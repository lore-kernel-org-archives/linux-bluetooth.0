Return-Path: <cyrus@holtmann.org>
From: Frederic Danis <frederic.danis@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v5 3/5] Bluetooth: hci_bcm: Prepare PM runtime support
Date: Wed, 23 Sep 2015 18:18:09 +0200
Message-Id: <1443025091-1864-4-git-send-email-frederic.danis@linux.intel.com>
In-Reply-To: <1443025091-1864-1-git-send-email-frederic.danis@linux.intel.com>
References: <1443025091-1864-1-git-send-email-frederic.danis@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Change some CONFIG_PM_SLEEP to CONFIG_PM as hu and is_suspended parameters
will be used during PM runtime callbacks.

Add bcm_suspend_device() and bcm_resume_device() which performs link
management for PM callbacks.
These functions will be used for runtime management.

Signed-off-by: Frederic Danis <frederic.danis@linux.intel.com>
---
 drivers/bluetooth/hci_bcm.c | 88 ++++++++++++++++++++++++++++++---------------
 1 file changed, 60 insertions(+), 28 deletions(-)

diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
index 2cb5089..fc5ca95 100644
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
@@ -425,24 +425,17 @@ static struct sk_buff *bcm_dequeue(struct hci_uart *hu)
 	return skb_dequeue(&bcm->txq);
 }
 
-#ifdef CONFIG_PM_SLEEP
-/* Platform suspend callback */
-static int bcm_suspend(struct device *dev)
+#ifdef CONFIG_PM
+static int bcm_suspend_device(struct device *dev)
 {
 	struct bcm_device *bdev = platform_get_drvdata(to_platform_device(dev));
-	int error;
 
-	bt_dev_dbg(bdev, "suspend: is_suspended %d", bdev->is_suspended);
-
-	mutex_lock(&bcm_device_lock);
-
-	if (!bdev->hu)
-		goto unlock;
+	bt_dev_dbg(bdev, "");
 
-	if (!bdev->is_suspended) {
+	if (!bdev->is_suspended && bdev->hu) {
 		hci_uart_set_flow_control(bdev->hu, true);
 
-		/* Once this callback returns, driver suspends BT via GPIO */
+		/* Once this returns, driver suspends BT via GPIO */
 		bdev->is_suspended = true;
 	}
 
@@ -453,6 +446,52 @@ static int bcm_suspend(struct device *dev)
 		mdelay(15);
 	}
 
+	return 0;
+}
+
+static int bcm_resume_device(struct device *dev)
+{
+	struct bcm_device *bdev = platform_get_drvdata(to_platform_device(dev));
+
+	bt_dev_dbg(bdev, "");
+
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
+
+	return 0;
+}
+#endif
+
+#ifdef CONFIG_PM_SLEEP
+/* Platform suspend callback */
+static int bcm_suspend(struct device *dev)
+{
+	struct bcm_device *bdev = platform_get_drvdata(to_platform_device(dev));
+	int error;
+
+	bt_dev_dbg(bdev, "suspend: is_suspended %d", bdev->is_suspended);
+
+	/* bcm_suspend can be called at any time as long as platform device is
+	 * bound, so it should use bcm_device_lock to protect access to hci_uart
+	 * and device_wake-up GPIO.
+	 */
+	mutex_lock(&bcm_device_lock);
+
+	if (!bdev->hu)
+		goto unlock;
+
+	bcm_suspend_device(dev);
+
 	if (device_may_wakeup(&bdev->pdev->dev)) {
 		error = enable_irq_wake(bdev->irq);
 		if (!error)
@@ -472,6 +511,10 @@ static int bcm_resume(struct device *dev)
 
 	bt_dev_dbg(bdev, "resume: is_suspended %d", bdev->is_suspended);
 
+	/* bcm_resume can be called at any time as long as platform device is
+	 * bound, so it should use bcm_device_lock to protect access to hci_uart
+	 * and device_wake-up GPIO.
+	 */
 	mutex_lock(&bcm_device_lock);
 
 	if (!bdev->hu)
@@ -482,18 +525,7 @@ static int bcm_resume(struct device *dev)
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
+	bcm_resume_device(dev);
 
 unlock:
 	mutex_unlock(&bcm_device_lock);
-- 
1.9.1

