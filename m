Return-Path: <cyrus@holtmann.org>
From: Loic Poulain <loic.poulain@intel.com>
To: marcel@holtmann.org
Cc: linux-bluetooth@vger.kernel.org,
	Loic Poulain <loic.poulain@intel.com>
Subject: [PATCH 2/2] Bluetooth: hci_intel: Replace spinlock with mutex
Date: Mon, 31 Aug 2015 18:34:31 +0200
Message-Id: <1441038871-27193-2-git-send-email-loic.poulain@intel.com>
In-Reply-To: <1441038871-27193-1-git-send-email-loic.poulain@intel.com>
References: <1441038871-27193-1-git-send-email-loic.poulain@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Replace the device_intel list spinlock with a mutex.
devm_request_threaded_irq is not atomic and upcomming PM support should
be simpler.

Signed-off-by: Loic Poulain <loic.poulain@intel.com>
---
 drivers/bluetooth/hci_intel.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/bluetooth/hci_intel.c b/drivers/bluetooth/hci_intel.c
index e35df28..5d53185 100644
--- a/drivers/bluetooth/hci_intel.c
+++ b/drivers/bluetooth/hci_intel.c
@@ -67,7 +67,7 @@ struct intel_device {
 };
 
 static LIST_HEAD(intel_device_list);
-static DEFINE_SPINLOCK(intel_device_list_lock);
+static DEFINE_MUTEX(intel_device_list_lock);
 
 struct intel_data {
 	struct sk_buff *rx_skb;
@@ -143,7 +143,7 @@ static int intel_set_power(struct hci_uart *hu, bool powered)
 	struct list_head *p;
 	int err = -ENODEV;
 
-	spin_lock(&intel_device_list_lock);
+	mutex_lock(&intel_device_list_lock);
 
 	list_for_each(p, &intel_device_list) {
 		struct intel_device *idev = list_entry(p, struct intel_device,
@@ -187,7 +187,7 @@ static int intel_set_power(struct hci_uart *hu, bool powered)
 		}
 	}
 
-	spin_unlock(&intel_device_list_lock);
+	mutex_unlock(&intel_device_list_lock);
 
 	return err;
 }
@@ -696,7 +696,7 @@ done:
 	bt_dev_info(hdev, "Device booted in %llu usecs", duration);
 
 	/* Enable LPM if matching pdev with wakeup enabled */
-	spin_lock(&intel_device_list_lock);
+	mutex_lock(&intel_device_list_lock);
 	list_for_each(p, &intel_device_list) {
 		struct intel_device *dev = list_entry(p, struct intel_device,
 						      list);
@@ -706,7 +706,7 @@ done:
 			break;
 		}
 	}
-	spin_unlock(&intel_device_list_lock);
+	mutex_unlock(&intel_device_list_lock);
 
 	if (!idev)
 		goto no_lpm;
@@ -982,9 +982,9 @@ no_irq:
 	platform_set_drvdata(pdev, idev);
 
 	/* Place this instance on the device list */
-	spin_lock(&intel_device_list_lock);
+	mutex_lock(&intel_device_list_lock);
 	list_add_tail(&idev->list, &intel_device_list);
-	spin_unlock(&intel_device_list_lock);
+	mutex_unlock(&intel_device_list_lock);
 
 	dev_info(&pdev->dev, "registered, gpio(%d)/irq(%d).\n",
 		 desc_to_gpio(idev->reset), idev->irq);
@@ -998,9 +998,9 @@ static int intel_remove(struct platform_device *pdev)
 
 	device_wakeup_disable(&pdev->dev);
 
-	spin_lock(&intel_device_list_lock);
+	mutex_lock(&intel_device_list_lock);
 	list_del(&idev->list);
-	spin_unlock(&intel_device_list_lock);
+	mutex_unlock(&intel_device_list_lock);
 
 	dev_info(&pdev->dev, "unregistered.\n");
 
-- 
1.9.1

