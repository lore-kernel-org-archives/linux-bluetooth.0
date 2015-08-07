Return-Path: <cyrus@holtmann.org>
From: Frederic Danis <frederic.danis@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 4/4] Bluetooth: hci_bcm: Add suspend/resume PM functions
Date: Fri,  7 Aug 2015 17:00:40 +0200
Message-Id: <1438959640-15476-5-git-send-email-frederic.danis@linux.intel.com>
In-Reply-To: <1438959640-15476-1-git-send-email-frederic.danis@linux.intel.com>
References: <1438959640-15476-1-git-send-email-frederic.danis@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Add reference to hci_uart structure to bcm_device.
This allows suspend/resume callbacks to manage UART flow control.

Signed-off-by: Frederic Danis <frederic.danis@linux.intel.com>
---
 drivers/bluetooth/hci_bcm.c | 61 ++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 60 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
index 8e1eacd..8d8f21c 100644
--- a/drivers/bluetooth/hci_bcm.c
+++ b/drivers/bluetooth/hci_bcm.c
@@ -51,6 +51,9 @@ struct bcm_device {
 	bool			clk_enabled;
 
 	u32			init_speed;
+
+	struct hci_uart		*hu;
+	bool			is_suspended; /* suspend/resume flag */
 };
 
 struct bcm_data {
@@ -152,6 +155,7 @@ static int bcm_open(struct hci_uart *hu)
 		if (hu->tty->dev->parent == dev->pdev->dev.parent) {
 			bcm->dev = dev;
 			hu->init_speed = dev->init_speed;
+			dev->hu = hu;
 			break;
 		}
 	}
@@ -169,8 +173,10 @@ static int bcm_close(struct hci_uart *hu)
 
 	BT_DBG("hu %p", hu);
 
-	if (bcm->dev)
+	if (bcm->dev) {
 		bcm_gpio_set_power(bcm->dev, false);
+		bcm->dev->hu = NULL;
+	}
 
 	skb_queue_purge(&bcm->txq);
 	kfree_skb(bcm->rx_skb);
@@ -296,6 +302,53 @@ static struct sk_buff *bcm_dequeue(struct hci_uart *hu)
 	return skb_dequeue(&bcm->txq);
 }
 
+/* Platform suspend callback */
+static int bcm_suspend(struct device *pdev)
+{
+	struct bcm_device *dev = platform_get_drvdata(to_platform_device(pdev));
+
+	BT_DBG("suspend (%p): is_suspended %d", dev, dev->is_suspended);
+
+	if (!dev->is_suspended) {
+		hci_uart_set_flow_control(dev->hu, true);
+
+		/* Once this callback returns, driver suspends BT via GPIO */
+		dev->is_suspended = true;
+	}
+
+	/* Suspend the device */
+	if (dev->device_wakeup) {
+		gpiod_set_value(dev->device_wakeup, false);
+		BT_DBG("suspend, delaying 15 ms");
+		mdelay(15);
+	}
+
+	return 0;
+}
+
+/* Platform resume callback */
+static int bcm_resume(struct device *pdev)
+{
+	struct bcm_device *dev = platform_get_drvdata(to_platform_device(pdev));
+
+	BT_DBG("resume (%p): is_suspended %d", dev, dev->is_suspended);
+
+	if (dev->device_wakeup) {
+		gpiod_set_value(dev->device_wakeup, true);
+		BT_DBG("resume, delaying 15 ms");
+		mdelay(15);
+	}
+
+	/* When this callback executes, the device has woken up already */
+	if (dev->is_suspended) {
+		dev->is_suspended = false;
+
+		hci_uart_set_flow_control(dev->hu, false);
+	}
+
+	return 0;
+}
+
 static const struct acpi_gpio_params device_wakeup_gpios = { 0, 0, false };
 static const struct acpi_gpio_params shutdown_gpios = { 1, 0, false };
 
@@ -450,12 +503,18 @@ static const struct acpi_device_id bcm_acpi_match[] = {
 MODULE_DEVICE_TABLE(acpi, bcm_acpi_match);
 #endif
 
+/* Platform suspend and resume callbacks */
+static const struct dev_pm_ops bcm_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(bcm_suspend, bcm_resume)
+};
+
 static struct platform_driver bcm_driver = {
 	.probe = bcm_probe,
 	.remove = bcm_remove,
 	.driver = {
 		.name = "hci_bcm",
 		.acpi_match_table = ACPI_PTR(bcm_acpi_match),
+		.pm = &bcm_pm_ops,
 	},
 };
 
-- 
1.9.1

