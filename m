Return-Path: <cyrus@holtmann.org>
From: Loic Poulain <loic.poulain@intel.com>
To: marcel@holtmann.org
Cc: linux-bluetooth@vger.kernel.org,
	Loic Poulain <loic.poulain@intel.com>
Subject: [PATCH] Bluetooth: hci_intel: Add platform driver
Date: Wed, 19 Aug 2015 19:11:43 +0200
Message-Id: <1440004303-27509-1-git-send-email-loic.poulain@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

A platform device can be used to provide some specific resources in
order to manage the controller. In this first patch we retrieve the
reset gpio which is used to power on/off the controller.

The main issue is to match the current tty with the correct pdev.
In case of ACPI, we can easily find the right tty/pdev pair because
they are both child of the same UART port.
In case of device tree, there is currently nothing to link the pdev
with its tty. So, we just match the first available pdev.

If controller is powered-on from the driver, we need to wait for a
HCI boot event before being able to send any command.

Signed-off-by: Loic Poulain <loic.poulain@intel.com>
---
 drivers/bluetooth/hci_intel.c | 275 +++++++++++++++++++++++++++++++++++++++---
 1 file changed, 255 insertions(+), 20 deletions(-)

diff --git a/drivers/bluetooth/hci_intel.c b/drivers/bluetooth/hci_intel.c
index 275283c..b8e6322 100644
--- a/drivers/bluetooth/hci_intel.c
+++ b/drivers/bluetooth/hci_intel.c
@@ -26,6 +26,11 @@
 #include <linux/skbuff.h>
 #include <linux/firmware.h>
 #include <linux/wait.h>
+#include <linux/tty.h>
+#include <linux/platform_device.h>
+#include <linux/gpio/consumer.h>
+#include <linux/of_platform.h>
+#include <linux/acpi.h>
 
 #include <net/bluetooth/bluetooth.h>
 #include <net/bluetooth/hci_core.h>
@@ -40,10 +45,20 @@
 #define STATE_BOOTING		4
 #define STATE_SPEED_CHANGING	5
 
+struct intel_device {
+	struct list_head list;
+	struct platform_device *pdev;
+	struct gpio_desc *reset;
+	struct hci_uart *hu;
+};
+LIST_HEAD(intel_device_list);
+DEFINE_SPINLOCK(intel_device_list_lock);
+
 struct intel_data {
 	struct sk_buff *rx_skb;
 	struct sk_buff_head txq;
 	unsigned long flags;
+	struct intel_device *idev;
 };
 
 static u8 intel_convert_speed(unsigned int speed)
@@ -78,6 +93,120 @@ static u8 intel_convert_speed(unsigned int speed)
 	}
 }
 
+static int intel_device_lock(struct intel_device *idev)
+{
+	struct list_head *p;
+
+	spin_lock(&intel_device_list_lock);
+
+	list_for_each(p, &intel_device_list) {
+		struct intel_device *dev = list_entry(p, struct intel_device,
+						      list);
+		if (dev == idev)
+			return 0;
+	}
+
+	spin_unlock(&intel_device_list_lock);
+
+	return -ENODEV;
+}
+
+static void intel_device_unlock(struct intel_device *idev)
+{
+	spin_unlock(&intel_device_list_lock);
+}
+
+static int intel_set_power(struct hci_uart *hu, bool powered)
+{
+	struct intel_data *intel = hu->priv;
+	struct intel_device *idev = intel->idev;
+
+	if (intel_device_lock(idev))
+		return -ENODEV;
+
+	if (!idev->reset) {
+		intel_device_unlock(idev);
+		return -EINVAL;
+	}
+
+	BT_DBG("%s: set power %d", hu->hdev->name, powered);
+
+	gpiod_set_value(idev->reset, powered);
+
+	intel_device_unlock(idev);
+
+	return 0;
+}
+
+static struct intel_device *intel_get_idev(struct hci_uart *hu)
+{
+	struct list_head *p;
+	struct intel_device *idev_match = NULL;
+
+	spin_lock(&intel_device_list_lock);
+	list_for_each(p, &intel_device_list) {
+		struct intel_device *idev;
+
+		idev = list_entry(p, struct intel_device, list);
+
+		/* Return the first available pdev in case of device tree.
+		 * There is currently nothing to match pdev with tty.
+		 */
+		if (idev->pdev->dev.of_node) {
+			if (!idev->hu) {
+				idev_match = idev;
+				break;
+			}
+
+		/* tty device and pdev device should share the same parent
+		 * which is the UART port.
+		 */
+		} else if (hu->tty->dev->parent == idev->pdev->dev.parent) {
+			idev_match = idev;
+			break;
+		}
+	}
+
+	if (idev_match) {
+		idev_match->hu = hu;
+		BT_INFO("hu %p, Found compatible pm device (%s)", hu,
+			dev_name(&idev_match->pdev->dev));
+	}
+	spin_unlock(&intel_device_list_lock);
+
+	return idev_match;
+}
+
+static int intel_boot_wait(struct hci_uart *hu)
+{
+	struct intel_data *intel = hu->priv;
+	struct hci_dev *hdev = hu->hdev;
+	int err;
+
+	if (!test_bit(STATE_BOOTING, &intel->flags))
+		return 0;
+
+	BT_INFO("%s: Waiting for device to boot", hdev->name);
+
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
+		return -ETIMEDOUT;
+	}
+
+	return 0;
+}
+
 static int intel_open(struct hci_uart *hu)
 {
 	struct intel_data *intel;
@@ -91,6 +220,12 @@ static int intel_open(struct hci_uart *hu)
 	skb_queue_head_init(&intel->txq);
 
 	hu->priv = intel;
+
+	intel->idev = intel_get_idev(hu);
+
+	if (!intel_set_power(hu, true))
+		set_bit(STATE_BOOTING, &intel->flags);
+
 	return 0;
 }
 
@@ -100,6 +235,13 @@ static int intel_close(struct hci_uart *hu)
 
 	BT_DBG("hu %p", hu);
 
+	intel_set_power(hu, false);
+
+	if (!intel_device_lock(intel->idev)) {
+		intel->idev->hu = NULL;
+		intel_device_unlock(intel->idev);
+	}
+
 	skb_queue_purge(&intel->txq);
 	kfree_skb(intel->rx_skb);
 	kfree(intel);
@@ -151,6 +293,8 @@ static int intel_set_baudrate(struct hci_uart *hu, unsigned int speed)
 	u8 intel_speed;
 	struct sk_buff *skb;
 
+	intel_boot_wait(hu);
+
 	BT_INFO("%s: Change controller speed to %d", hdev->name, speed);
 
 	/* Device will not accept speed change if Intel version has not been
@@ -229,6 +373,8 @@ static int intel_setup(struct hci_uart *hu)
 	if (oper_speed && init_speed && oper_speed != init_speed)
 		speed_change = 1;
 
+	intel_boot_wait(hu);
+
 	set_bit(STATE_BOOTLOADER, &intel->flags);
 
 	/* Read the Intel version information to determine if the device
@@ -511,10 +657,6 @@ done:
 	if (err < 0)
 		return err;
 
-	calltime = ktime_get();
-
-	set_bit(STATE_BOOTING, &intel->flags);
-
 	/* We need to restore the default speed before Intel reset */
 	if (speed_change) {
 		err = intel_set_baudrate(hu, init_speed);
@@ -523,6 +665,10 @@ done:
 		hci_uart_set_baudrate(hu, init_speed);
 	}
 
+	calltime = ktime_get();
+
+	set_bit(STATE_BOOTING, &intel->flags);
+
 	skb = __hci_cmd_sync(hdev, 0xfc01, sizeof(reset_param), reset_param,
 			     HCI_INIT_TIMEOUT);
 	if (IS_ERR(skb))
@@ -537,21 +683,9 @@ done:
 	 * 1 second. However if that happens, then just fail the setup
 	 * since something went wrong.
 	 */
-	BT_INFO("%s: Waiting for device to boot", hdev->name);
-
-	err = wait_on_bit_timeout(&intel->flags, STATE_BOOTING,
-				  TASK_INTERRUPTIBLE,
-				  msecs_to_jiffies(1000));
-
-	if (err == 1) {
-		BT_ERR("%s: Device boot interrupted", hdev->name);
-		return -EINTR;
-	}
-
-	if (err) {
-		BT_ERR("%s: Device boot timeout", hdev->name);
-		return -ETIMEDOUT;
-	}
+	err = intel_boot_wait(hu);
+	if (err)
+		return err;
 
 	rettime = ktime_get();
 	delta = ktime_sub(rettime, calltime);
@@ -583,7 +717,8 @@ static int intel_recv_event(struct hci_dev *hdev, struct sk_buff *skb)
 	struct intel_data *intel = hu->priv;
 	struct hci_event_hdr *hdr;
 
-	if (!test_bit(STATE_BOOTLOADER, &intel->flags))
+	if (!test_bit(STATE_BOOTLOADER, &intel->flags) &&
+	    !test_bit(STATE_BOOTING, &intel->flags))
 		goto recv;
 
 	hdr = (void *)skb->data;
@@ -713,12 +848,112 @@ static const struct hci_uart_proto intel_proto = {
 	.dequeue	= intel_dequeue,
 };
 
+
+/*--- Platform Driver ---*/
+static const struct of_device_id intel_bt_of_match[] = {
+	{ .compatible = "intel,bt-fmr",
+	  .data = (void *)"intel,bt-fmr-reset", },
+	{},
+};
+
+#ifdef CONFIG_ACPI
+static const struct acpi_device_id intel_bt_acpi_match[] = {
+	{ "INT33E1", (kernel_ulong_t)"reset" },
+	{ },
+};
+#endif
+
+static int intel_probe(struct platform_device *pdev)
+{
+	struct intel_device *idev;
+	char *gpio_reset_name = NULL;
+
+	idev = devm_kzalloc(&pdev->dev, sizeof(*idev), GFP_KERNEL);
+	if (!idev)
+		return -ENOMEM;
+
+	idev->pdev = pdev;
+
+	if (ACPI_HANDLE(&pdev->dev)) {
+#ifdef CONFIG_ACPI
+		const struct acpi_device_id *id;
+
+		id = acpi_match_device(intel_bt_acpi_match, &pdev->dev);
+		if (!id)
+			return -ENODEV;
+
+		gpio_reset_name = (char *)id->driver_data;
+#endif
+	} else if (&pdev->dev.of_node) {
+		const struct of_device_id *match;
+
+		match = of_match_device(intel_bt_of_match, &pdev->dev);
+		if (!match)
+			return -ENODEV;
+
+		gpio_reset_name = (char *)match->data;
+	} else {
+		return -ENODEV;
+	}
+
+	if (!gpio_reset_name)
+		goto no_reset;
+
+	idev->reset = devm_gpiod_get_optional(&pdev->dev, gpio_reset_name,
+					      GPIOD_OUT_LOW);
+	if (IS_ERR(idev->reset)) {
+		dev_err(&pdev->dev, "Unable to retrieve %s gpio\n",
+			gpio_reset_name);
+		return PTR_ERR(idev->reset);
+	}
+
+no_reset:
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
+		.of_match_table = intel_bt_of_match,
+		.acpi_match_table = ACPI_PTR(intel_bt_acpi_match),
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

