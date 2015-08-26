Return-Path: <cyrus@holtmann.org>
From: Loic Poulain <loic.poulain@intel.com>
To: marcel@holtmann.org
Cc: linux-bluetooth@vger.kernel.org,
	Loic Poulain <loic.poulain@intel.com>
Subject: [PATCH v6 2/2] Bluetooth: hci_intel: Add platform driver
Date: Wed, 26 Aug 2015 10:51:05 +0200
Message-Id: <1440579065-28384-1-git-send-email-loic.poulain@intel.com>
List-ID: <linux-bluetooth.vger.kernel.org>

A platform device can be used to provide some specific resources in
order to manage the controller. In this first patch we retrieve the
reset gpio which is used to power on/off the controller.

The main issue is to match the current tty with the correct pdev.
In case of ACPI, we can easily find the right tty/pdev pair because
they are both child of the same UART port.

If controller is powered-on from the driver, we need to wait for a
HCI boot event before being able to send any command.

Signed-off-by: Loic Poulain <loic.poulain@intel.com>
---
 v2: v3: none, align patch version with patch 1/2 "Intel baudrate" patch
 v4: remove device tree support, will be part of a different patch
 v5: static declaration fixes
     rework locking usage, remove confusing intel_device_lock/unlock
     Add intel_acpi_probe, align acpi device table name
 v6: intel_set_power refactoring
     move idev search (intel_get_idev) direclty in intel_open

 drivers/bluetooth/hci_intel.c | 216 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 215 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/hci_intel.c b/drivers/bluetooth/hci_intel.c
index da3192a..c060fd3 100644
--- a/drivers/bluetooth/hci_intel.c
+++ b/drivers/bluetooth/hci_intel.c
@@ -26,6 +26,10 @@
 #include <linux/skbuff.h>
 #include <linux/firmware.h>
 #include <linux/wait.h>
+#include <linux/tty.h>
+#include <linux/platform_device.h>
+#include <linux/gpio/consumer.h>
+#include <linux/acpi.h>
 
 #include <net/bluetooth/bluetooth.h>
 #include <net/bluetooth/hci_core.h>
@@ -39,10 +43,20 @@
 #define STATE_FIRMWARE_FAILED	3
 #define STATE_BOOTING		4
 
+struct intel_device {
+	struct list_head list;
+	struct platform_device *pdev;
+	struct gpio_desc *reset;
+	struct hci_uart *hu;
+};
+static LIST_HEAD(intel_device_list);
+static DEFINE_SPINLOCK(intel_device_list_lock);
+
 struct intel_data {
 	struct sk_buff *rx_skb;
 	struct sk_buff_head txq;
 	unsigned long flags;
+	struct intel_device *idev;
 };
 
 static u8 intel_convert_speed(unsigned int speed)
@@ -77,9 +91,52 @@ static u8 intel_convert_speed(unsigned int speed)
 	}
 }
 
+static bool intel_device_exists(struct intel_device *idev)
+{
+	struct list_head *p;
+
+	list_for_each(p, &intel_device_list) {
+		struct intel_device *dev = list_entry(p, struct intel_device,
+						      list);
+		if (dev == idev)
+			return true;
+	}
+
+	return false;
+}
+
+static int intel_set_power(struct hci_uart *hu, bool powered)
+{
+	struct intel_data *intel = hu->priv;
+	struct intel_device *idev = intel->idev;
+	int err = 0;
+
+	spin_lock(&intel_device_list_lock);
+
+	if (!intel_device_exists(idev)) {
+		err = -ENODEV;
+		goto done;
+	}
+
+	if (!idev->reset) {
+		err = -EINVAL;
+		goto done;
+	}
+
+	BT_DBG("%s: set power %d", hu->hdev->name, powered);
+
+	gpiod_set_value(idev->reset, powered);
+
+done:
+	spin_unlock(&intel_device_list_lock);
+
+	return err;
+}
+
 static int intel_open(struct hci_uart *hu)
 {
 	struct intel_data *intel;
+	struct list_head *p;
 
 	BT_DBG("hu %p", hu);
 
@@ -90,6 +147,29 @@ static int intel_open(struct hci_uart *hu)
 	skb_queue_head_init(&intel->txq);
 
 	hu->priv = intel;
+
+	spin_lock(&intel_device_list_lock);
+	list_for_each(p, &intel_device_list) {
+		struct intel_device *idev;
+
+		idev = list_entry(p, struct intel_device, list);
+
+		/* tty device and pdev device should share the same parent
+		 * which is the UART port.
+		 */
+		if (hu->tty->dev->parent == idev->pdev->dev.parent) {
+			BT_INFO("hu %p, Found compatible pm device (%s)", hu,
+				dev_name(&idev->pdev->dev));
+			intel->idev = idev;
+			intel->idev->hu = hu;
+			break;
+		}
+	}
+	spin_unlock(&intel_device_list_lock);
+
+	if (!intel_set_power(hu, true))
+		set_bit(STATE_BOOTING, &intel->flags);
+
 	return 0;
 }
 
@@ -99,6 +179,13 @@ static int intel_close(struct hci_uart *hu)
 
 	BT_DBG("hu %p", hu);
 
+	intel_set_power(hu, false);
+
+	spin_lock(&intel_device_list_lock);
+	if (intel_device_exists(intel->idev))
+		intel->idev->hu = NULL;
+	spin_unlock(&intel_device_list_lock);
+
 	skb_queue_purge(&intel->txq);
 	kfree_skb(intel->rx_skb);
 	kfree(intel);
@@ -149,6 +236,26 @@ static int intel_set_baudrate(struct hci_uart *hu, unsigned int speed)
 	struct hci_dev *hdev = hu->hdev;
 	u8 speed_cmd[] = { 0x06, 0xfc, 0x01, 0x00 };
 	struct sk_buff *skb;
+	int err;
+
+	/* This can be the first command sent to the chip, check controller is
+	 * ready
+	 */
+	err = wait_on_bit_timeout(&intel->flags, STATE_BOOTING,
+				  TASK_INTERRUPTIBLE,
+				  msecs_to_jiffies(1000));
+
+	if (err == 1) {
+		BT_ERR("%s: Device boot interrupted", hdev->name);
+		clear_bit(STATE_BOOTING, &intel->flags);
+		return -EINTR;
+	}
+
+	if (err) {
+		BT_ERR("%s: Device boot timeout", hdev->name);
+		clear_bit(STATE_BOOTING, &intel->flags);
+		/* Try to continue anyway */
+	}
 
 	BT_INFO("%s: Change controller speed to %d", hdev->name, speed);
 
@@ -231,6 +338,23 @@ static int intel_setup(struct hci_uart *hu)
 	if (oper_speed && init_speed && oper_speed != init_speed)
 		speed_change = 1;
 
+	/* Check controller is ready */
+	err = wait_on_bit_timeout(&intel->flags, STATE_BOOTING,
+				  TASK_INTERRUPTIBLE,
+				  msecs_to_jiffies(1000));
+
+	if (err == 1) {
+		BT_ERR("%s: Device boot interrupted", hdev->name);
+		clear_bit(STATE_BOOTING, &intel->flags);
+		return -EINTR;
+	}
+
+	if (err) {
+		BT_ERR("%s: Device boot timeout", hdev->name);
+		clear_bit(STATE_BOOTING, &intel->flags);
+		/* Try to continue anyway */
+	}
+
 	set_bit(STATE_BOOTLOADER, &intel->flags);
 
 	/* Read the Intel version information to determine if the device
@@ -546,11 +670,13 @@ done:
 
 	if (err == 1) {
 		BT_ERR("%s: Device boot interrupted", hdev->name);
+		clear_bit(STATE_BOOTING, &intel->flags);
 		return -EINTR;
 	}
 
 	if (err) {
 		BT_ERR("%s: Device boot timeout", hdev->name);
+		clear_bit(STATE_BOOTING, &intel->flags);
 		return -ETIMEDOUT;
 	}
 
@@ -584,7 +710,8 @@ static int intel_recv_event(struct hci_dev *hdev, struct sk_buff *skb)
 	struct intel_data *intel = hu->priv;
 	struct hci_event_hdr *hdr;
 
-	if (!test_bit(STATE_BOOTLOADER, &intel->flags))
+	if (!test_bit(STATE_BOOTLOADER, &intel->flags) &&
+	    !test_bit(STATE_BOOTING, &intel->flags))
 		goto recv;
 
 	hdr = (void *)skb->data;
@@ -700,12 +827,99 @@ static const struct hci_uart_proto intel_proto = {
 	.dequeue	= intel_dequeue,
 };
 
+#ifdef CONFIG_ACPI
+static const struct acpi_device_id intel_acpi_match[] = {
+	{ "INT33E1", 0 },
+	{ },
+};
+
+static int intel_acpi_probe(struct intel_device *idev)
+{
+	const struct acpi_device_id *id;
+
+	id = acpi_match_device(intel_acpi_match, &idev->pdev->dev);
+	if (!id)
+		return -ENODEV;
+
+	return 0;
+}
+#else
+static int intel_acpi_probe(struct intel_device *idev)
+{
+	return -ENODEV;
+}
+#endif
+
+static int intel_probe(struct platform_device *pdev)
+{
+	struct intel_device *idev;
+
+	idev = devm_kzalloc(&pdev->dev, sizeof(*idev), GFP_KERNEL);
+	if (!idev)
+		return -ENOMEM;
+
+	idev->pdev = pdev;
+
+	if (ACPI_HANDLE(&pdev->dev)) {
+		int err = intel_acpi_probe(idev);
+		if (err)
+			return err;
+	} else {
+		return -ENODEV;
+	}
+
+	idev->reset = devm_gpiod_get_optional(&pdev->dev, "reset",
+					      GPIOD_OUT_LOW);
+	if (IS_ERR(idev->reset)) {
+		dev_err(&pdev->dev, "Unable to retrieve gpio\n");
+		return PTR_ERR(idev->reset);
+	}
+
+	platform_set_drvdata(pdev, idev);
+
+	/* Place this instance on the device list */
+	spin_lock(&intel_device_list_lock);
+	list_add_tail(&idev->list, &intel_device_list);
+	spin_unlock(&intel_device_list_lock);
+
+	dev_info(&pdev->dev, "registered.\n");
+
+	return 0;
+}
+
+static int intel_remove(struct platform_device *pdev)
+{
+	struct intel_device *idev = platform_get_drvdata(pdev);
+
+	spin_lock(&intel_device_list_lock);
+	list_del(&idev->list);
+	spin_unlock(&intel_device_list_lock);
+
+	dev_info(&pdev->dev, "unregistered.\n");
+
+	return 0;
+}
+
+static struct platform_driver intel_driver = {
+	.probe = intel_probe,
+	.remove = intel_remove,
+	.driver = {
+		.name = "hci_intel",
+		.acpi_match_table = ACPI_PTR(intel_acpi_match),
+		.owner = THIS_MODULE,
+	},
+};
+
 int __init intel_init(void)
 {
+	platform_driver_register(&intel_driver);
+
 	return hci_uart_register_proto(&intel_proto);
 }
 
 int __exit intel_deinit(void)
 {
+	platform_driver_unregister(&intel_driver);
+
 	return hci_uart_unregister_proto(&intel_proto);
 }
-- 
1.9.1
