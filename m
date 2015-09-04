Return-Path: <cyrus@holtmann.org>
From: Frederic Danis <frederic.danis@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 1/4] Bluetooth: hci_bcm: Add wake-up capability
Date: Fri,  4 Sep 2015 15:35:44 +0200
Message-Id: <1441373747-23042-2-git-send-email-frederic.danis@linux.intel.com>
In-Reply-To: <1441373747-23042-1-git-send-email-frederic.danis@linux.intel.com>
References: <1441373747-23042-1-git-send-email-frederic.danis@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Retrieve the Interruption used by BCM device, which can be declared
as Interruption or GpioInt in the ACPI table.
Retrieve IRQ polarity from the ACPI table to use it for host_wake_active
parameter of Setup Sleep vendor specific command.
Configure BCM device to wake-up the host.
Enable IRQ wake while suspended.

Signed-off-by: Frederic Danis <frederic.danis@linux.intel.com>
---
 drivers/bluetooth/hci_bcm.c | 160 +++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 150 insertions(+), 10 deletions(-)

diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
index fbad52f..f306541 100644
--- a/drivers/bluetooth/hci_bcm.c
+++ b/drivers/bluetooth/hci_bcm.c
@@ -31,6 +31,7 @@
 #include <linux/clk.h>
 #include <linux/gpio/consumer.h>
 #include <linux/tty.h>
+#include <linux/interrupt.h>
 
 #include <net/bluetooth/bluetooth.h>
 #include <net/bluetooth/hci_core.h>
@@ -51,6 +52,8 @@ struct bcm_device {
 	bool			clk_enabled;
 
 	u32			init_speed;
+	int			irq;
+	u8			irq_polarity;
 
 #ifdef CONFIG_PM_SLEEP
 	struct hci_uart		*hu;
@@ -149,6 +152,86 @@ static int bcm_gpio_set_power(struct bcm_device *dev, bool powered)
 	return 0;
 }
 
+#ifdef CONFIG_PM_SLEEP
+static irqreturn_t bcm_host_wake(int irq, void *data)
+{
+	struct bcm_device *bdev = data;
+
+	bt_dev_dbg(bdev, "Host wake IRQ");
+
+	return IRQ_HANDLED;
+}
+
+static int bcm_request_irq(struct bcm_data *bcm)
+{
+	struct bcm_device *bdev = bcm->dev;
+	int err = 0;
+
+	/* If this is not a platform device, do not enable PM functionalities */
+	mutex_lock(&bcm_device_lock);
+	if (!bcm_device_exists(bdev)) {
+		err = -ENODEV;
+		goto unlock;
+	}
+
+	if (bdev->irq > 0) {
+		err = devm_request_irq(&bdev->pdev->dev, bdev->irq,
+				       bcm_host_wake, IRQF_TRIGGER_RISING,
+				       "host_wake", bdev);
+		if (err)
+			goto unlock;
+
+		device_init_wakeup(&bdev->pdev->dev, true);
+	}
+
+unlock:
+	mutex_unlock(&bcm_device_lock);
+
+	return err;
+}
+
+static const struct bcm_set_sleep_mode default_sleep_params = {
+	.sleep_mode = 1,	/* 0=Disabled, 1=UART, 2=Reserved, 3=USB */
+	.idle_host = 2,		/* idle threshold HOST, in 300ms */
+	.idle_dev = 2,		/* idle threshold device, in 300ms */
+	.bt_wake_active = 1,	/* BT_WAKE active mode: 1 = high, 0 = low */
+	.host_wake_active = 0,	/* HOST_WAKE active mode: 1 = high, 0 = low */
+	.allow_host_sleep = 1,	/* Allow host sleep in SCO flag */
+	.combine_modes = 0,	/* Combine sleep and LPM flag */
+	.tristate_control = 0,	/* Allow tri-state control of UART tx flag */
+	/* Irrelevant USB flags */
+	.usb_auto_sleep = 0,
+	.usb_resume_timeout = 0,
+	.pulsed_host_wake = 0,
+	.break_to_host = 0
+};
+
+static int bcm_setup_sleep(struct hci_uart *hu)
+{
+	struct bcm_data *bcm = hu->priv;
+	struct sk_buff *skb;
+	struct bcm_set_sleep_mode sleep_params = default_sleep_params;
+
+	sleep_params.host_wake_active = !bcm->dev->irq_polarity;
+
+	skb = __hci_cmd_sync(hu->hdev, 0xfc27, sizeof(sleep_params),
+			     &sleep_params, HCI_INIT_TIMEOUT);
+	if (IS_ERR(skb)) {
+		int err = PTR_ERR(skb);
+		bt_dev_err(hu->hdev, "Sleep VSC failed (%d)", err);
+		return err;
+	}
+	kfree_skb(skb);
+
+	bt_dev_dbg(hu->hdev, "Set Sleep Parameters VSC succeeded");
+
+	return 0;
+}
+#else
+static inline int bcm_request_irq(struct bcm_data *bcm) { return 0; }
+static inline int bcm_setup_sleep(struct hci_uart *hu) { return 0; }
+#endif
+
 static int bcm_open(struct hci_uart *hu)
 {
 	struct bcm_data *bcm;
@@ -178,13 +261,11 @@ static int bcm_open(struct hci_uart *hu)
 #ifdef CONFIG_PM_SLEEP
 			dev->hu = hu;
 #endif
+			bcm_gpio_set_power(bcm->dev, true);
 			break;
 		}
 	}
 
-	if (bcm->dev)
-		bcm_gpio_set_power(bcm->dev, true);
-
 	mutex_unlock(&bcm_device_lock);
 
 	return 0;
@@ -193,15 +274,21 @@ static int bcm_open(struct hci_uart *hu)
 static int bcm_close(struct hci_uart *hu)
 {
 	struct bcm_data *bcm = hu->priv;
+	struct bcm_device *bdev = bcm->dev;
 
 	bt_dev_dbg(hu->hdev, "hu %p", hu);
 
 	/* Protect bcm->dev against removal of the device or driver */
 	mutex_lock(&bcm_device_lock);
-	if (bcm_device_exists(bcm->dev)) {
-		bcm_gpio_set_power(bcm->dev, false);
+	if (bcm_device_exists(bdev)) {
+		bcm_gpio_set_power(bdev, false);
 #ifdef CONFIG_PM_SLEEP
-		bcm->dev->hu = NULL;
+		if (device_can_wakeup(&bdev->pdev->dev)) {
+			devm_free_irq(&bdev->pdev->dev, bdev->irq, bdev);
+			device_init_wakeup(&bdev->pdev->dev, false);
+		}
+
+		bdev->hu = NULL;
 #endif
 	}
 	mutex_unlock(&bcm_device_lock);
@@ -227,6 +314,7 @@ static int bcm_flush(struct hci_uart *hu)
 
 static int bcm_setup(struct hci_uart *hu)
 {
+	struct bcm_data *bcm = hu->priv;
 	char fw_name[64];
 	const struct firmware *fw;
 	unsigned int speed;
@@ -281,6 +369,12 @@ finalize:
 	release_firmware(fw);
 
 	err = btbcm_finalize(hu->hdev);
+	if (err)
+		return err;
+
+	err = bcm_request_irq(bcm);
+	if (!err)
+		err = bcm_setup_sleep(hu);
 
 	return err;
 }
@@ -335,6 +429,7 @@ static struct sk_buff *bcm_dequeue(struct hci_uart *hu)
 static int bcm_suspend(struct device *dev)
 {
 	struct bcm_device *bdev = platform_get_drvdata(to_platform_device(dev));
+	int error;
 
 	bt_dev_dbg(bdev, "suspend: is_suspended %d", bdev->is_suspended);
 
@@ -357,6 +452,12 @@ static int bcm_suspend(struct device *dev)
 		mdelay(15);
 	}
 
+	if (device_may_wakeup(&bdev->pdev->dev)) {
+		error = enable_irq_wake(bdev->irq);
+		if (!error)
+			bt_dev_dbg(bdev, "BCM irq: enabled");
+	}
+
 unlock:
 	mutex_unlock(&bcm_device_lock);
 
@@ -375,6 +476,11 @@ static int bcm_resume(struct device *dev)
 	if (!bdev->hu)
 		goto unlock;
 
+	if (device_may_wakeup(&bdev->pdev->dev)) {
+		disable_irq_wake(bdev->irq);
+		bt_dev_dbg(bdev, "BCM irq: disabled");
+	}
+
 	if (bdev->device_wakeup) {
 		gpiod_set_value(bdev->device_wakeup, true);
 		bt_dev_dbg(bdev, "resume, delaying 15 ms");
@@ -397,10 +503,12 @@ unlock:
 
 static const struct acpi_gpio_params device_wakeup_gpios = { 0, 0, false };
 static const struct acpi_gpio_params shutdown_gpios = { 1, 0, false };
+static const struct acpi_gpio_params host_wakeup_gpios = { 2, 0, false };
 
 static const struct acpi_gpio_mapping acpi_bcm_default_gpios[] = {
 	{ "device-wakeup-gpios", &device_wakeup_gpios, 1 },
 	{ "shutdown-gpios", &shutdown_gpios, 1 },
+	{ "host-wakeup-gpios", &host_wakeup_gpios, 1 },
 	{ },
 };
 
@@ -408,13 +516,30 @@ static const struct acpi_gpio_mapping acpi_bcm_default_gpios[] = {
 static int bcm_resource(struct acpi_resource *ares, void *data)
 {
 	struct bcm_device *dev = data;
-
-	if (ares->type == ACPI_RESOURCE_TYPE_SERIAL_BUS) {
-		struct acpi_resource_uart_serialbus *sb;
-
+	struct acpi_resource_extended_irq *irq;
+	struct acpi_resource_gpio *gpio;
+	struct acpi_resource_uart_serialbus *sb;
+
+	switch (ares->type) {
+	case ACPI_RESOURCE_TYPE_EXTENDED_IRQ:
+		irq = &ares->data.extended_irq;
+		dev->irq_polarity = irq->polarity;
+		break;
+
+	case ACPI_RESOURCE_TYPE_GPIO:
+		gpio = &ares->data.gpio;
+		if (gpio->connection_type == ACPI_RESOURCE_GPIO_TYPE_INT)
+			dev->irq_polarity = gpio->polarity;
+		break;
+
+	case ACPI_RESOURCE_TYPE_SERIAL_BUS:
 		sb = &ares->data.uart_serial_bus;
 		if (sb->type == ACPI_RESOURCE_SERIAL_TYPE_UART)
 			dev->init_speed = sb->default_baud_rate;
+		break;
+
+	default:
+		break;
 	}
 
 	/* Always tell the ACPI core to skip this resource */
@@ -453,6 +578,21 @@ static int bcm_acpi_probe(struct bcm_device *dev)
 	if (IS_ERR(dev->shutdown))
 		return PTR_ERR(dev->shutdown);
 
+	/* IRQ can be declared in ACPI table as Interrupt or GpioInt */
+	dev->irq = platform_get_irq(pdev, 0);
+	if (dev->irq <= 0) {
+		struct gpio_desc *gpio;
+
+		gpio = devm_gpiod_get_optional(&pdev->dev, "host-wakeup",
+					       GPIOD_IN);
+		if (IS_ERR(gpio))
+			return PTR_ERR(gpio);
+
+		dev->irq = gpiod_to_irq(gpio);
+	}
+
+	dev_info(&pdev->dev, "BCM irq: %d\n", dev->irq);
+
 	/* Make sure at-least one of the GPIO is defined and that
 	 * a name is specified for this instance
 	 */
-- 
1.9.1

