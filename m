Return-Path: <cyrus@holtmann.org>
From: Sachin Kamat <sachin.kamat@linaro.org>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org,
	gustavo@padovan.org,
	johan.hedberg@gmail.com,
	sachin.kamat@linaro.org,
	patches@linaro.org
Subject: [PATCH 06/11] Bluetooth: Use devm_kzalloc in btmrvl_sdio.c file
Date: Fri, 27 Jul 2012 12:38:36 +0530
Message-Id: <1343372921-18780-7-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1343372921-18780-1-git-send-email-sachin.kamat@linaro.org>
References: <1343372921-18780-1-git-send-email-sachin.kamat@linaro.org>
List-ID: <linux-bluetooth.vger.kernel.org>

devm_kzalloc() eliminates the need to free memory explicitly
thereby saving some cleanup code.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/bluetooth/btmrvl_sdio.c |   15 ++++-----------
 1 files changed, 4 insertions(+), 11 deletions(-)

diff --git a/drivers/bluetooth/btmrvl_sdio.c b/drivers/bluetooth/btmrvl_sdio.c
index 6a9e971..03b3acb 100644
--- a/drivers/bluetooth/btmrvl_sdio.c
+++ b/drivers/bluetooth/btmrvl_sdio.c
@@ -956,11 +956,9 @@ static int btmrvl_sdio_probe(struct sdio_func *func,
 	BT_INFO("vendor=0x%x, device=0x%x, class=%d, fn=%d",
 			id->vendor, id->device, id->class, func->num);
 
-	card = kzalloc(sizeof(*card), GFP_KERNEL);
-	if (!card) {
-		ret = -ENOMEM;
-		goto done;
-	}
+	card = devm_kzalloc(&func->dev, sizeof(*card), GFP_KERNEL);
+	if (!card)
+		return -ENOMEM;
 
 	card->func = func;
 
@@ -974,8 +972,7 @@ static int btmrvl_sdio_probe(struct sdio_func *func,
 
 	if (btmrvl_sdio_register_dev(card) < 0) {
 		BT_ERR("Failed to register BT device!");
-		ret = -ENODEV;
-		goto free_card;
+		return -ENODEV;
 	}
 
 	/* Disable the interrupts on the card */
@@ -1023,9 +1020,6 @@ disable_host_int:
 	btmrvl_sdio_disable_host_int(card);
 unreg_dev:
 	btmrvl_sdio_unregister_dev(card);
-free_card:
-	kfree(card);
-done:
 	return ret;
 }
 
@@ -1047,7 +1041,6 @@ static void btmrvl_sdio_remove(struct sdio_func *func)
 			BT_DBG("unregester dev");
 			btmrvl_sdio_unregister_dev(card);
 			btmrvl_remove_card(card->priv);
-			kfree(card);
 		}
 	}
 }
-- 
1.7.4.1
