Return-Path: <cyrus@holtmann.org>
From: Frederic Danis <frederic.danis@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 3/4] Bluetooth: hci_bcm: Prepare PM runtime support
Date: Fri,  4 Sep 2015 15:35:46 +0200
Message-Id: <1441373747-23042-4-git-send-email-frederic.danis@linux.intel.com>
In-Reply-To: <1441373747-23042-1-git-send-email-frederic.danis@linux.intel.com>
References: <1441373747-23042-1-git-send-email-frederic.danis@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Change some CONFIG_PM_SLEEP to CONFIG_PM as hu and is_suspended parameters
will be used during PM runtime callbacks.

Add __bcm_suspend() and __bcm_resume() which performs link management for
PM callbacks.

Signed-off-by: Frederic Danis <frederic.danis@linux.intel.com>
---
 drivers/bluetooth/hci_bcm.c | 70 ++++++++++++++++++++++++++-------------------
 1 file changed, 41 insertions(+), 29 deletions(-)

diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
index efb9566..7f63f2b 100644
--- a/drivers/bluetooth/hci_bcm.c
+++ b/drivers/bluetooth/hci_bcm.c
@@ -56,7 +56,7 @@ struct bcm_device {
 	int			irq;
 	u8			irq_polarity;
 
-#ifdef CONFIG_PM_SLEEP
+#ifdef CONFIG_PM
 	struct hci_uart		*hu;
 	bool			is_suspended; /* suspend/resume flag */
 #endif
@@ -153,7 +153,7 @@ static int bcm_gpio_set_power(struct bcm_device *dev, bool powered)
 	return 0;
 }
 
-#ifdef CONFIG_PM_SLEEP
+#ifdef CONFIG_PM
 static irqreturn_t bcm_host_wake(int irq, void *data)
 {
 	struct bcm_device *bdev = data;
@@ -259,7 +259,7 @@ static int bcm_open(struct hci_uart *hu)
 		if (hu->tty->dev->parent == dev->pdev->dev.parent) {
 			bcm->dev = dev;
 			hu->init_speed = dev->init_speed;
-#ifdef CONFIG_PM_SLEEP
+#ifdef CONFIG_PM
 			dev->hu = hu;
 #endif
 			bcm_gpio_set_power(bcm->dev, true);
@@ -283,7 +283,7 @@ static int bcm_close(struct hci_uart *hu)
 	mutex_lock(&bcm_device_lock);
 	if (bcm_device_exists(bdev)) {
 		bcm_gpio_set_power(bdev, false);
-#ifdef CONFIG_PM_SLEEP
+#ifdef CONFIG_PM
 		if (device_can_wakeup(&bdev->pdev->dev)) {
 			devm_free_irq(&bdev->pdev->dev, bdev->irq, bdev);
 			device_init_wakeup(&bdev->pdev->dev, false);
@@ -425,6 +425,41 @@ static struct sk_buff *bcm_dequeue(struct hci_uart *hu)
 	return skb_dequeue(&bcm->txq);
 }
 
+#ifdef CONFIG_PM
+static void __bcm_suspend(struct bcm_device *bdev)
+{
+	if (!bdev->is_suspended && bdev->hu) {
+		hci_uart_set_flow_control(bdev->hu, true);
+
+		/* Once this returns, driver suspends BT via GPIO */
+		bdev->is_suspended = true;
+	}
+
+	/* Suspend the device */
+	if (bdev->device_wakeup) {
+		gpiod_set_value(bdev->device_wakeup, false);
+		bt_dev_dbg(bdev, "suspend, delaying 15 ms");
+		mdelay(15);
+	}
+}
+
+static void __bcm_resume(struct bcm_device *bdev)
+{
+	if (bdev->device_wakeup) {
+		gpiod_set_value(bdev->device_wakeup, true);
+		bt_dev_dbg(bdev, "resume, delaying 15 ms");
+		mdelay(15);
+	}
+
+	/* When this executes, the device has woken up already */
+	if (bdev->is_suspended && bdev->hu) {
+		bdev->is_suspended = false;
+
+		hci_uart_set_flow_control(bdev->hu, false);
+	}
+}
+#endif
+
 #ifdef CONFIG_PM_SLEEP
 /* Platform suspend callback */
 static int bcm_suspend(struct device *dev)
@@ -439,19 +474,7 @@ static int bcm_suspend(struct device *dev)
 	if (!bdev->hu)
 		goto unlock;
 
-	if (!bdev->is_suspended) {
-		hci_uart_set_flow_control(bdev->hu, true);
-
-		/* Once this callback returns, driver suspends BT via GPIO */
-		bdev->is_suspended = true;
-	}
-
-	/* Suspend the device */
-	if (bdev->device_wakeup) {
-		gpiod_set_value(bdev->device_wakeup, false);
-		bt_dev_dbg(bdev, "suspend, delaying 15 ms");
-		mdelay(15);
-	}
+	__bcm_suspend(bdev);
 
 	if (device_may_wakeup(&bdev->pdev->dev)) {
 		error = enable_irq_wake(bdev->irq);
@@ -482,18 +505,7 @@ static int bcm_resume(struct device *dev)
 		bt_dev_dbg(bdev, "BCM irq: disabled");
 	}
 
-	if (bdev->device_wakeup) {
-		gpiod_set_value(bdev->device_wakeup, true);
-		bt_dev_dbg(bdev, "resume, delaying 15 ms");
-		mdelay(15);
-	}
-
-	/* When this callback executes, the device has woken up already */
-	if (bdev->is_suspended) {
-		bdev->is_suspended = false;
-
-		hci_uart_set_flow_control(bdev->hu, false);
-	}
+	__bcm_resume(bdev);
 
 unlock:
 	mutex_unlock(&bcm_device_lock);
-- 
1.9.1

