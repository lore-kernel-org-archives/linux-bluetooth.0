Return-Path: <cyrus@holtmann.org>
From: Frederic Danis <frederic.danis@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/2] Bluetooth: hci_bcm: Replace spinlock by mutex
Date: Tue,  1 Sep 2015 12:13:35 +0200
Message-Id: <1441102416-29864-1-git-send-email-frederic.danis@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Replace spinlock by mutex to be able to use bcm_device_lock in
sleepable context like devm_request_threaded_irq or upcomming PM support.

Signed-off-by: Frederic Danis <frederic.danis@linux.intel.com>
---
 drivers/bluetooth/hci_bcm.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
index 835bfab..42ab91d 100644
--- a/drivers/bluetooth/hci_bcm.c
+++ b/drivers/bluetooth/hci_bcm.c
@@ -66,7 +66,7 @@ struct bcm_data {
 };
 
 /* List of BCM BT UART devices */
-static DEFINE_SPINLOCK(bcm_device_lock);
+static DEFINE_MUTEX(bcm_device_lock);
 static LIST_HEAD(bcm_device_list);
 
 static int bcm_set_baudrate(struct hci_uart *hu, unsigned int speed)
@@ -164,7 +164,7 @@ static int bcm_open(struct hci_uart *hu)
 
 	hu->priv = bcm;
 
-	spin_lock(&bcm_device_lock);
+	mutex_lock(&bcm_device_lock);
 	list_for_each(p, &bcm_device_list) {
 		struct bcm_device *dev = list_entry(p, struct bcm_device, list);
 
@@ -185,7 +185,7 @@ static int bcm_open(struct hci_uart *hu)
 	if (bcm->dev)
 		bcm_gpio_set_power(bcm->dev, true);
 
-	spin_unlock(&bcm_device_lock);
+	mutex_unlock(&bcm_device_lock);
 
 	return 0;
 }
@@ -197,14 +197,14 @@ static int bcm_close(struct hci_uart *hu)
 	BT_DBG("hu %p", hu);
 
 	/* Protect bcm->dev against removal of the device or driver */
-	spin_lock(&bcm_device_lock);
+	mutex_lock(&bcm_device_lock);
 	if (bcm_device_exists(bcm->dev)) {
 		bcm_gpio_set_power(bcm->dev, false);
 #ifdef CONFIG_PM_SLEEP
 		bcm->dev->hu = NULL;
 #endif
 	}
-	spin_unlock(&bcm_device_lock);
+	mutex_unlock(&bcm_device_lock);
 
 	skb_queue_purge(&bcm->txq);
 	kfree_skb(bcm->rx_skb);
@@ -338,7 +338,7 @@ static int bcm_suspend(struct device *dev)
 
 	BT_DBG("suspend (%p): is_suspended %d", bdev, bdev->is_suspended);
 
-	spin_lock(&bcm_device_lock);
+	mutex_lock(&bcm_device_lock);
 
 	if (!bdev->hu)
 		goto unlock;
@@ -358,7 +358,7 @@ static int bcm_suspend(struct device *dev)
 	}
 
 unlock:
-	spin_unlock(&bcm_device_lock);
+	mutex_unlock(&bcm_device_lock);
 
 	return 0;
 }
@@ -370,7 +370,7 @@ static int bcm_resume(struct device *dev)
 
 	BT_DBG("resume (%p): is_suspended %d", bdev, bdev->is_suspended);
 
-	spin_lock(&bcm_device_lock);
+	mutex_lock(&bcm_device_lock);
 
 	if (!bdev->hu)
 		goto unlock;
@@ -389,7 +389,7 @@ static int bcm_resume(struct device *dev)
 	}
 
 unlock:
-	spin_unlock(&bcm_device_lock);
+	mutex_unlock(&bcm_device_lock);
 
 	return 0;
 }
@@ -504,9 +504,9 @@ static int bcm_probe(struct platform_device *pdev)
 	dev_info(&pdev->dev, "%s device registered.\n", dev->name);
 
 	/* Place this instance on the device list */
-	spin_lock(&bcm_device_lock);
+	mutex_lock(&bcm_device_lock);
 	list_add_tail(&dev->list, &bcm_device_list);
-	spin_unlock(&bcm_device_lock);
+	mutex_unlock(&bcm_device_lock);
 
 	bcm_gpio_set_power(dev, false);
 
@@ -517,9 +517,9 @@ static int bcm_remove(struct platform_device *pdev)
 {
 	struct bcm_device *dev = platform_get_drvdata(pdev);
 
-	spin_lock(&bcm_device_lock);
+	mutex_lock(&bcm_device_lock);
 	list_del(&dev->list);
-	spin_unlock(&bcm_device_lock);
+	mutex_unlock(&bcm_device_lock);
 
 	acpi_dev_remove_driver_gpios(ACPI_COMPANION(&pdev->dev));
 
-- 
1.9.1

