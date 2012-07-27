Return-Path: <cyrus@holtmann.org>
From: Sachin Kamat <sachin.kamat@linaro.org>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org,
	gustavo@padovan.org,
	johan.hedberg@gmail.com,
	sachin.kamat@linaro.org,
	patches@linaro.org
Subject: [PATCH 07/11] Bluetooth: Use devm_kzalloc in btsdio.c file
Date: Fri, 27 Jul 2012 12:38:37 +0530
Message-Id: <1343372921-18780-8-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1343372921-18780-1-git-send-email-sachin.kamat@linaro.org>
References: <1343372921-18780-1-git-send-email-sachin.kamat@linaro.org>
List-ID: <linux-bluetooth.vger.kernel.org>

devm_kzalloc() eliminates the need to free memory explicitly
thereby saving some cleanup code.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/bluetooth/btsdio.c |    8 ++------
 1 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/bluetooth/btsdio.c b/drivers/bluetooth/btsdio.c
index e10ea03..4a99097 100644
--- a/drivers/bluetooth/btsdio.c
+++ b/drivers/bluetooth/btsdio.c
@@ -304,7 +304,7 @@ static int btsdio_probe(struct sdio_func *func,
 		tuple = tuple->next;
 	}
 
-	data = kzalloc(sizeof(*data), GFP_KERNEL);
+	data = devm_kzalloc(&func->dev, sizeof(*data), GFP_KERNEL);
 	if (!data)
 		return -ENOMEM;
 
@@ -315,10 +315,8 @@ static int btsdio_probe(struct sdio_func *func,
 	skb_queue_head_init(&data->txq);
 
 	hdev = hci_alloc_dev();
-	if (!hdev) {
-		kfree(data);
+	if (!hdev)
 		return -ENOMEM;
-	}
 
 	hdev->bus = HCI_SDIO;
 	hci_set_drvdata(hdev, data);
@@ -340,7 +338,6 @@ static int btsdio_probe(struct sdio_func *func,
 	err = hci_register_dev(hdev);
 	if (err < 0) {
 		hci_free_dev(hdev);
-		kfree(data);
 		return err;
 	}
 
@@ -366,7 +363,6 @@ static void btsdio_remove(struct sdio_func *func)
 	hci_unregister_dev(hdev);
 
 	hci_free_dev(hdev);
-	kfree(data);
 }
 
 static struct sdio_driver btsdio_driver = {
-- 
1.7.4.1
