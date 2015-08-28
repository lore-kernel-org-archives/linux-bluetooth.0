Return-Path: <cyrus@holtmann.org>
From: Frederic Danis <frederic.danis@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: hci_bcm: Fix crash on suspend
Date: Fri, 28 Aug 2015 15:44:00 +0200
Message-Id: <1440769440-17959-1-git-send-email-frederic.danis@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

If bcm_suspend is called whithout device opened there is a crash as
it tries to use bdev->hu which is NULL.
Rename bcm_device_list_lock to bcm_device_lock as it does not only apply
to bcm_device_list.

Signed-off-by: Frederic Danis <frederic.danis@linux.intel.com>
---
 drivers/bluetooth/hci_bcm.c | 36 ++++++++++++++++++++++++++----------
 1 file changed, 26 insertions(+), 10 deletions(-)

diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
index 33ec097..835bfab 100644
--- a/drivers/bluetooth/hci_bcm.c
+++ b/drivers/bluetooth/hci_bcm.c
@@ -66,7 +66,7 @@ struct bcm_data {
 };
 
 /* List of BCM BT UART devices */
-static DEFINE_SPINLOCK(bcm_device_list_lock);
+static DEFINE_SPINLOCK(bcm_device_lock);
 static LIST_HEAD(bcm_device_list);
 
 static int bcm_set_baudrate(struct hci_uart *hu, unsigned int speed)
@@ -118,7 +118,7 @@ static int bcm_set_baudrate(struct hci_uart *hu, unsigned int speed)
 	return 0;
 }
 
-/* bcm_device_exists should be protected by bcm_device_list_lock */
+/* bcm_device_exists should be protected by bcm_device_lock */
 static bool bcm_device_exists(struct bcm_device *device)
 {
 	struct list_head *p;
@@ -164,7 +164,7 @@ static int bcm_open(struct hci_uart *hu)
 
 	hu->priv = bcm;
 
-	spin_lock(&bcm_device_list_lock);
+	spin_lock(&bcm_device_lock);
 	list_for_each(p, &bcm_device_list) {
 		struct bcm_device *dev = list_entry(p, struct bcm_device, list);
 
@@ -185,7 +185,7 @@ static int bcm_open(struct hci_uart *hu)
 	if (bcm->dev)
 		bcm_gpio_set_power(bcm->dev, true);
 
-	spin_unlock(&bcm_device_list_lock);
+	spin_unlock(&bcm_device_lock);
 
 	return 0;
 }
@@ -197,14 +197,14 @@ static int bcm_close(struct hci_uart *hu)
 	BT_DBG("hu %p", hu);
 
 	/* Protect bcm->dev against removal of the device or driver */
-	spin_lock(&bcm_device_list_lock);
+	spin_lock(&bcm_device_lock);
 	if (bcm_device_exists(bcm->dev)) {
 		bcm_gpio_set_power(bcm->dev, false);
 #ifdef CONFIG_PM_SLEEP
 		bcm->dev->hu = NULL;
 #endif
 	}
-	spin_unlock(&bcm_device_list_lock);
+	spin_unlock(&bcm_device_lock);
 
 	skb_queue_purge(&bcm->txq);
 	kfree_skb(bcm->rx_skb);
@@ -338,6 +338,11 @@ static int bcm_suspend(struct device *dev)
 
 	BT_DBG("suspend (%p): is_suspended %d", bdev, bdev->is_suspended);
 
+	spin_lock(&bcm_device_lock);
+
+	if (!bdev->hu)
+		goto unlock;
+
 	if (!bdev->is_suspended) {
 		hci_uart_set_flow_control(bdev->hu, true);
 
@@ -352,6 +357,9 @@ static int bcm_suspend(struct device *dev)
 		mdelay(15);
 	}
 
+unlock:
+	spin_unlock(&bcm_device_lock);
+
 	return 0;
 }
 
@@ -362,6 +370,11 @@ static int bcm_resume(struct device *dev)
 
 	BT_DBG("resume (%p): is_suspended %d", bdev, bdev->is_suspended);
 
+	spin_lock(&bcm_device_lock);
+
+	if (!bdev->hu)
+		goto unlock;
+
 	if (bdev->device_wakeup) {
 		gpiod_set_value(bdev->device_wakeup, true);
 		BT_DBG("resume, delaying 15 ms");
@@ -375,6 +388,9 @@ static int bcm_resume(struct device *dev)
 		hci_uart_set_flow_control(bdev->hu, false);
 	}
 
+unlock:
+	spin_unlock(&bcm_device_lock);
+
 	return 0;
 }
 #endif
@@ -488,9 +504,9 @@ static int bcm_probe(struct platform_device *pdev)
 	dev_info(&pdev->dev, "%s device registered.\n", dev->name);
 
 	/* Place this instance on the device list */
-	spin_lock(&bcm_device_list_lock);
+	spin_lock(&bcm_device_lock);
 	list_add_tail(&dev->list, &bcm_device_list);
-	spin_unlock(&bcm_device_list_lock);
+	spin_unlock(&bcm_device_lock);
 
 	bcm_gpio_set_power(dev, false);
 
@@ -501,9 +517,9 @@ static int bcm_remove(struct platform_device *pdev)
 {
 	struct bcm_device *dev = platform_get_drvdata(pdev);
 
-	spin_lock(&bcm_device_list_lock);
+	spin_lock(&bcm_device_lock);
 	list_del(&dev->list);
-	spin_unlock(&bcm_device_list_lock);
+	spin_unlock(&bcm_device_lock);
 
 	acpi_dev_remove_driver_gpios(ACPI_COMPANION(&pdev->dev));
 
-- 
1.9.1

