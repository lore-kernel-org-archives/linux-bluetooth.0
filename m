Return-Path: <cyrus@holtmann.org>
From: Sachin Kamat <sachin.kamat@linaro.org>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org,
	gustavo@padovan.org,
	johan.hedberg@gmail.com,
	sachin.kamat@linaro.org,
	patches@linaro.org
Subject: [PATCH 10/11] Bluetooth: Use devm_kzalloc in btwilink.c file
Date: Fri, 27 Jul 2012 12:38:40 +0530
Message-Id: <1343372921-18780-11-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1343372921-18780-1-git-send-email-sachin.kamat@linaro.org>
References: <1343372921-18780-1-git-send-email-sachin.kamat@linaro.org>
List-ID: <linux-bluetooth.vger.kernel.org>

devm_kzalloc() eliminates the need to free memory explicitly
thereby saving some cleanup code.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/bluetooth/btwilink.c |    8 ++------
 1 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/bluetooth/btwilink.c b/drivers/bluetooth/btwilink.c
index 8869469..4ad7b35 100644
--- a/drivers/bluetooth/btwilink.c
+++ b/drivers/bluetooth/btwilink.c
@@ -297,16 +297,14 @@ static int bt_ti_probe(struct platform_device *pdev)
 	struct hci_dev *hdev;
 	int err;
 
-	hst = kzalloc(sizeof(struct ti_st), GFP_KERNEL);
+	hst = devm_kzalloc(&pdev->dev, sizeof(struct ti_st), GFP_KERNEL);
 	if (!hst)
 		return -ENOMEM;
 
 	/* Expose "hciX" device to user space */
 	hdev = hci_alloc_dev();
-	if (!hdev) {
-		kfree(hst);
+	if (!hdev)
 		return -ENOMEM;
-	}
 
 	BT_DBG("hdev %p", hdev);
 
@@ -321,7 +319,6 @@ static int bt_ti_probe(struct platform_device *pdev)
 	err = hci_register_dev(hdev);
 	if (err < 0) {
 		BT_ERR("Can't register HCI device error %d", err);
-		kfree(hst);
 		hci_free_dev(hdev);
 		return err;
 	}
@@ -347,7 +344,6 @@ static int bt_ti_remove(struct platform_device *pdev)
 	hci_unregister_dev(hdev);
 
 	hci_free_dev(hdev);
-	kfree(hst);
 
 	dev_set_drvdata(&pdev->dev, NULL);
 	return 0;
-- 
1.7.4.1
