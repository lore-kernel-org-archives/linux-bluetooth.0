Return-Path: <cyrus@holtmann.org>
From: Frederic Danis <frederic.danis@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v5 1/4] Bluetooth: hci_bcm: Add PM for BCM devices
Date: Tue, 11 Aug 2015 16:35:35 +0200
Message-Id: <1439303738-24231-2-git-send-email-frederic.danis@linux.intel.com>
In-Reply-To: <1439303738-24231-1-git-send-email-frederic.danis@linux.intel.com>
References: <1439303738-24231-1-git-send-email-frederic.danis@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Retrieve "shutdown" and "device_wakeup" GPIOs from ACPI.
Set device off during platform device enumeration.
Set device on only when attached.
As driver can be unbound we need to check if the bcm_device still exists
before calling GPIO's functions, this is protected using device_list_lock.

Signed-off-by: Frederic Danis <frederic.danis@linux.intel.com>
---
 drivers/bluetooth/hci_bcm.c | 216 +++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 214 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
index 23523e1..6ac6636 100644
--- a/drivers/bluetooth/hci_bcm.c
+++ b/drivers/bluetooth/hci_bcm.c
@@ -25,6 +25,12 @@
 #include <linux/errno.h>
 #include <linux/skbuff.h>
 #include <linux/firmware.h>
+#include <linux/module.h>
+#include <linux/acpi.h>
+#include <linux/platform_device.h>
+#include <linux/clk.h>
+#include <linux/gpio/consumer.h>
+#include <linux/tty.h>
 
 #include <net/bluetooth/bluetooth.h>
 #include <net/bluetooth/hci_core.h>
@@ -32,11 +38,30 @@
 #include "btbcm.h"
 #include "hci_uart.h"
 
+struct bcm_device {
+	struct list_head	list;
+
+	struct platform_device	*pdev;
+
+	const char		*name;
+	struct gpio_desc	*device_wakeup;
+	struct gpio_desc	*shutdown;
+
+	struct clk		*clk;
+	bool			clk_enabled;
+};
+
 struct bcm_data {
-	struct sk_buff *rx_skb;
-	struct sk_buff_head txq;
+	struct sk_buff		*rx_skb;
+	struct sk_buff_head	txq;
+
+	struct bcm_device	*dev;
 };
 
+/* List of BCM BT UART devices */
+static DEFINE_SPINLOCK(bcm_device_list_lock);
+static LIST_HEAD(bcm_device_list);
+
 static int bcm_set_baudrate(struct hci_uart *hu, unsigned int speed)
 {
 	struct hci_dev *hdev = hu->hdev;
@@ -86,9 +111,41 @@ static int bcm_set_baudrate(struct hci_uart *hu, unsigned int speed)
 	return 0;
 }
 
+/* bcm_device_exists should be protected by bcm_device_list_lock */
+static bool bcm_device_exists(struct bcm_device *device)
+{
+	struct list_head *p;
+
+	list_for_each(p, &bcm_device_list) {
+		struct bcm_device *dev = list_entry(p, struct bcm_device, list);
+
+		if (device == dev)
+			return true;
+	}
+
+	return false;
+}
+
+static int bcm_gpio_set_power(struct bcm_device *dev, bool powered)
+{
+	if (powered && !IS_ERR(dev->clk) && !dev->clk_enabled)
+		clk_enable(dev->clk);
+
+	gpiod_set_value_cansleep(dev->shutdown, powered);
+	gpiod_set_value_cansleep(dev->device_wakeup, powered);
+
+	if (!powered && !IS_ERR(dev->clk) && dev->clk_enabled)
+		clk_disable(dev->clk);
+
+	dev->clk_enabled = powered;
+
+	return 0;
+}
+
 static int bcm_open(struct hci_uart *hu)
 {
 	struct bcm_data *bcm;
+	struct list_head *p;
 
 	BT_DBG("hu %p", hu);
 
@@ -99,6 +156,26 @@ static int bcm_open(struct hci_uart *hu)
 	skb_queue_head_init(&bcm->txq);
 
 	hu->priv = bcm;
+
+	spin_lock(&bcm_device_list_lock);
+	list_for_each(p, &bcm_device_list) {
+		struct bcm_device *dev = list_entry(p, struct bcm_device, list);
+
+		/* Retrieve saved bcm_device based on parent of the
+		 * platform device (saved during device probe) and
+		 * parent of tty device used by hci_uart
+		 */
+		if (hu->tty->dev->parent == dev->pdev->dev.parent) {
+			bcm->dev = dev;
+			break;
+		}
+	}
+
+	if (bcm->dev)
+		bcm_gpio_set_power(bcm->dev, true);
+
+	spin_unlock(&bcm_device_list_lock);
+
 	return 0;
 }
 
@@ -108,6 +185,12 @@ static int bcm_close(struct hci_uart *hu)
 
 	BT_DBG("hu %p", hu);
 
+	/* Protect bcm->dev against removal of the device or driver */
+	spin_lock(&bcm_device_list_lock);
+	if (bcm_device_exists(bcm->dev))
+		bcm_gpio_set_power(bcm->dev, false);
+	spin_unlock(&bcm_device_list_lock);
+
 	skb_queue_purge(&bcm->txq);
 	kfree_skb(bcm->rx_skb);
 	kfree(bcm);
@@ -232,6 +315,113 @@ static struct sk_buff *bcm_dequeue(struct hci_uart *hu)
 	return skb_dequeue(&bcm->txq);
 }
 
+static const struct acpi_gpio_params device_wakeup_gpios = { 0, 0, false };
+static const struct acpi_gpio_params shutdown_gpios = { 1, 0, false };
+
+static const struct acpi_gpio_mapping acpi_bcm_default_gpios[] = {
+	{ "device-wakeup-gpios", &device_wakeup_gpios, 1 },
+	{ "shutdown-gpios", &shutdown_gpios, 1 },
+	{ },
+};
+
+static int bcm_acpi_probe(struct bcm_device *dev)
+{
+	struct platform_device *pdev = dev->pdev;
+	const struct acpi_device_id *id;
+	struct gpio_desc *gpio;
+	int ret;
+
+	id = acpi_match_device(pdev->dev.driver->acpi_match_table, &pdev->dev);
+	if (!id)
+		return -ENODEV;
+
+	/* Retrieve GPIO data */
+	dev->name = dev_name(&pdev->dev);
+	ret = acpi_dev_add_driver_gpios(ACPI_COMPANION(&pdev->dev),
+					acpi_bcm_default_gpios);
+	if (ret)
+		return ret;
+
+	dev->clk = devm_clk_get(&pdev->dev, NULL);
+
+	gpio = devm_gpiod_get(&pdev->dev, "device-wakeup");
+	if (!IS_ERR(gpio)) {
+		ret = gpiod_direction_output(gpio, 0);
+		if (ret)
+			return ret;
+		dev->device_wakeup = gpio;
+	}
+
+	gpio = devm_gpiod_get(&pdev->dev, "shutdown");
+	if (!IS_ERR(gpio)) {
+		ret = gpiod_direction_output(gpio, 0);
+		if (ret)
+			return ret;
+		dev->shutdown = gpio;
+	}
+
+	/* Make sure at-least one of the GPIO is defined and that
+	 * a name is specified for this instance
+	 */
+	if ((!dev->device_wakeup && !dev->shutdown) || !dev->name) {
+		dev_err(&pdev->dev, "invalid platform data\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int bcm_probe(struct platform_device *pdev)
+{
+	struct bcm_device *dev;
+	struct acpi_device_id *pdata = pdev->dev.platform_data;
+	int ret;
+
+	dev = devm_kzalloc(&pdev->dev, sizeof(*dev), GFP_KERNEL);
+	if (!dev)
+		return -ENOMEM;
+
+	dev->pdev = pdev;
+
+	if (ACPI_HANDLE(&pdev->dev)) {
+		ret = bcm_acpi_probe(dev);
+		if (ret)
+			return ret;
+	} else if (pdata) {
+		dev->name = pdata->id;
+	} else {
+		return -ENODEV;
+	}
+
+	platform_set_drvdata(pdev, dev);
+
+	dev_info(&pdev->dev, "%s device registered.\n", dev->name);
+
+	/* Place this instance on the device list */
+	spin_lock(&bcm_device_list_lock);
+	list_add_tail(&dev->list, &bcm_device_list);
+	spin_unlock(&bcm_device_list_lock);
+
+	bcm_gpio_set_power(dev, false);
+
+	return 0;
+}
+
+static int bcm_remove(struct platform_device *pdev)
+{
+	struct bcm_device *dev = platform_get_drvdata(pdev);
+
+	spin_lock(&bcm_device_list_lock);
+	list_del(&dev->list);
+	spin_unlock(&bcm_device_list_lock);
+
+	acpi_dev_remove_driver_gpios(ACPI_COMPANION(&pdev->dev));
+
+	dev_info(&pdev->dev, "%s device unregistered.\n", dev->name);
+
+	return 0;
+}
+
 static const struct hci_uart_proto bcm_proto = {
 	.id		= HCI_UART_BCM,
 	.name		= "BCM",
@@ -247,12 +437,34 @@ static const struct hci_uart_proto bcm_proto = {
 	.dequeue	= bcm_dequeue,
 };
 
+#ifdef CONFIG_ACPI
+static const struct acpi_device_id bcm_acpi_match[] = {
+	{ "BCM2E39", 0 },
+	{ "BCM2E67", 0 },
+	{ },
+};
+MODULE_DEVICE_TABLE(acpi, bcm_acpi_match);
+#endif
+
+static struct platform_driver bcm_driver = {
+	.probe = bcm_probe,
+	.remove = bcm_remove,
+	.driver = {
+		.name = "hci_bcm",
+		.acpi_match_table = ACPI_PTR(bcm_acpi_match),
+	},
+};
+
 int __init bcm_init(void)
 {
+	platform_driver_register(&bcm_driver);
+
 	return hci_uart_register_proto(&bcm_proto);
 }
 
 int __exit bcm_deinit(void)
 {
+	platform_driver_unregister(&bcm_driver);
+
 	return hci_uart_unregister_proto(&bcm_proto);
 }
-- 
1.9.1

