Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: hci_intel: Add support for platform driver
Date: Thu, 27 Aug 2015 07:14:46 +0200
Message-Id: <1440652486-35130-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Loic Poulain <loic.poulain@intel.com>

A platform device can be used to provide some specific resources in
order to manage the controller. In this first patch we retrieve the
reset gpio which is used to power on/off the controller.

The main issue is to match the current tty with the correct pdev.
In case of ACPI, we can easily find the right tty/pdev pair because
they are both child of the same UART port.

If controller is powered-on from the driver, we need to wait for a
HCI boot event before being able to send any command.

Signed-off-by: Loic Poulain <loic.poulain@intel.com>
Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 drivers/bluetooth/hci_intel.c | 201 +++++++++++++++++++++++++++++++++++++++---
 1 file changed, 188 insertions(+), 13 deletions(-)

diff --git a/drivers/bluetooth/hci_intel.c b/drivers/bluetooth/hci_intel.c
index da3192aee5e1..1ca0d8553de1 100644
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
@@ -39,6 +43,15 @@
 #define STATE_FIRMWARE_FAILED	3
 #define STATE_BOOTING		4
 
+struct intel_device {
+	struct list_head list;
+	struct platform_device *pdev;
+	struct gpio_desc *reset;
+};
+
+static LIST_HEAD(intel_device_list);
+static DEFINE_SPINLOCK(intel_device_list_lock);
+
 struct intel_data {
 	struct sk_buff *rx_skb;
 	struct sk_buff_head txq;
@@ -77,6 +90,61 @@ static u8 intel_convert_speed(unsigned int speed)
 	}
 }
 
+static int intel_wait_booting(struct hci_uart *hu)
+{
+	struct intel_data *intel = hu->priv;
+	int err;
+
+	err = wait_on_bit_timeout(&intel->flags, STATE_BOOTING,
+				  TASK_INTERRUPTIBLE,
+				  msecs_to_jiffies(1000));
+
+	if (err == 1) {
+		BT_ERR("%s: Device boot interrupted", hu->hdev->name);
+		return -EINTR;
+	}
+
+	if (err) {
+		BT_ERR("%s: Device boot timeout", hu->hdev->name);
+		return -ETIMEDOUT;
+	}
+
+	return err;
+}
+
+static int intel_set_power(struct hci_uart *hu, bool powered)
+{
+	struct list_head *p;
+	int err = -ENODEV;
+
+	spin_lock(&intel_device_list_lock);
+
+	list_for_each(p, &intel_device_list) {
+		struct intel_device *idev = list_entry(p, struct intel_device,
+						       list);
+
+		/* tty device and pdev device should share the same parent
+		 * which is the UART port.
+		 */
+		if (hu->tty->dev->parent != idev->pdev->dev.parent)
+			continue;
+
+		if (!idev->reset) {
+			err = -ENOTSUPP;
+			break;
+		}
+
+		BT_INFO("hu %p, Switching compatible pm device (%s) to %u",
+			hu, dev_name(&idev->pdev->dev), powered);
+
+		gpiod_set_value(idev->reset, powered);
+	}
+
+	spin_unlock(&intel_device_list_lock);
+
+	return err;
+}
+
 static int intel_open(struct hci_uart *hu)
 {
 	struct intel_data *intel;
@@ -90,6 +158,10 @@ static int intel_open(struct hci_uart *hu)
 	skb_queue_head_init(&intel->txq);
 
 	hu->priv = intel;
+
+	if (!intel_set_power(hu, true))
+		set_bit(STATE_BOOTING, &intel->flags);
+
 	return 0;
 }
 
@@ -99,6 +171,8 @@ static int intel_close(struct hci_uart *hu)
 
 	BT_DBG("hu %p", hu);
 
+	intel_set_power(hu, false);
+
 	skb_queue_purge(&intel->txq);
 	kfree_skb(intel->rx_skb);
 	kfree(intel);
@@ -149,6 +223,18 @@ static int intel_set_baudrate(struct hci_uart *hu, unsigned int speed)
 	struct hci_dev *hdev = hu->hdev;
 	u8 speed_cmd[] = { 0x06, 0xfc, 0x01, 0x00 };
 	struct sk_buff *skb;
+	int err;
+
+	/* This can be the first command sent to the chip, check
+	 * that the controller is ready.
+	 */
+	err = intel_wait_booting(hu);
+
+	clear_bit(STATE_BOOTING, &intel->flags);
+
+	/* In case of timeout, try to continue anyway */
+	if (err && err != ETIMEDOUT)
+		return err;
 
 	BT_INFO("%s: Change controller speed to %d", hdev->name, speed);
 
@@ -231,6 +317,15 @@ static int intel_setup(struct hci_uart *hu)
 	if (oper_speed && init_speed && oper_speed != init_speed)
 		speed_change = 1;
 
+	/* Check that the controller is ready */
+	err = intel_wait_booting(hu);
+
+	clear_bit(STATE_BOOTING, &intel->flags);
+
+	/* In case of timeout, try to continue anyway */
+	if (err && err != ETIMEDOUT)
+		return err;
+
 	set_bit(STATE_BOOTLOADER, &intel->flags);
 
 	/* Read the Intel version information to determine if the device
@@ -540,19 +635,11 @@ done:
 	 */
 	BT_INFO("%s: Waiting for device to boot", hdev->name);
 
-	err = wait_on_bit_timeout(&intel->flags, STATE_BOOTING,
-				  TASK_INTERRUPTIBLE,
-				  msecs_to_jiffies(1000));
-
-	if (err == 1) {
-		BT_ERR("%s: Device boot interrupted", hdev->name);
-		return -EINTR;
-	}
+	err = intel_wait_booting(hu);
+	if (err)
+		return err;
 
-	if (err) {
-		BT_ERR("%s: Device boot timeout", hdev->name);
-		return -ETIMEDOUT;
-	}
+	clear_bit(STATE_BOOTING, &intel->flags);
 
 	rettime = ktime_get();
 	delta = ktime_sub(rettime, calltime);
@@ -584,7 +671,8 @@ static int intel_recv_event(struct hci_dev *hdev, struct sk_buff *skb)
 	struct intel_data *intel = hu->priv;
 	struct hci_event_hdr *hdr;
 
-	if (!test_bit(STATE_BOOTLOADER, &intel->flags))
+	if (!test_bit(STATE_BOOTLOADER, &intel->flags) &&
+	    !test_bit(STATE_BOOTING, &intel->flags))
 		goto recv;
 
 	hdr = (void *)skb->data;
@@ -700,12 +788,99 @@ static const struct hci_uart_proto intel_proto = {
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
2.4.3

