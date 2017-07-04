Return-Path: <loic.poulain@gmail.com>
From: Loic Poulain <loic.poulain@gmail.com>
To: marcel@holtmann.org
Cc: linux-bluetooth@vger.kernel.org,
	ian@mnementh.co.uk,
	Loic Poulain <loic.poulain@gmail.com>
Subject: [PATCH] Bluetooth: hci_bcm: Make bcm_request_irq fail if no IRQ resource
Date: Tue,  4 Jul 2017 12:57:56 +0200
Message-Id: <1499165876-18999-1-git-send-email-loic.poulain@gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

In case of no IRQ resource associated to the bcm_device, requesting
IRQ should return an error in order to not enable low power mgmt.

Signed-off-by: Loic Poulain <loic.poulain@gmail.com>
Reported-by: Ian Molton <ian@mnementh.co.uk>
---
 drivers/bluetooth/hci_bcm.c | 30 ++++++++++++++++--------------
 1 file changed, 16 insertions(+), 14 deletions(-)

diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
index be53238..fab6f73 100644
--- a/drivers/bluetooth/hci_bcm.c
+++ b/drivers/bluetooth/hci_bcm.c
@@ -176,7 +176,7 @@ static irqreturn_t bcm_host_wake(int irq, void *data)
 static int bcm_request_irq(struct bcm_data *bcm)
 {
 	struct bcm_device *bdev = bcm->dev;
-	int err = 0;
+	int err;
 
 	/* If this is not a platform device, do not enable PM functionalities */
 	mutex_lock(&bcm_device_lock);
@@ -185,21 +185,23 @@ static int bcm_request_irq(struct bcm_data *bcm)
 		goto unlock;
 	}
 
-	if (bdev->irq > 0) {
-		err = devm_request_irq(&bdev->pdev->dev, bdev->irq,
-				       bcm_host_wake, IRQF_TRIGGER_RISING,
-				       "host_wake", bdev);
-		if (err)
-			goto unlock;
+	if (bdev->irq <= 0) {
+		err = -EOPNOTSUPP;
+		goto unlock;
+	}
 
-		device_init_wakeup(&bdev->pdev->dev, true);
+	err = devm_request_irq(&bdev->pdev->dev, bdev->irq, bcm_host_wake,
+			       IRQF_TRIGGER_RISING, "host_wake", bdev);
+	if (err)
+		goto unlock;
 
-		pm_runtime_set_autosuspend_delay(&bdev->pdev->dev,
-						 BCM_AUTOSUSPEND_DELAY);
-		pm_runtime_use_autosuspend(&bdev->pdev->dev);
-		pm_runtime_set_active(&bdev->pdev->dev);
-		pm_runtime_enable(&bdev->pdev->dev);
-	}
+	device_init_wakeup(&bdev->pdev->dev, true);
+
+	pm_runtime_set_autosuspend_delay(&bdev->pdev->dev,
+					 BCM_AUTOSUSPEND_DELAY);
+	pm_runtime_use_autosuspend(&bdev->pdev->dev);
+	pm_runtime_set_active(&bdev->pdev->dev);
+	pm_runtime_enable(&bdev->pdev->dev);
 
 unlock:
 	mutex_unlock(&bcm_device_lock);
-- 
1.9.1
