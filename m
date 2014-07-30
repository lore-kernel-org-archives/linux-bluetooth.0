Return-Path: <cyrus@holtmann.org>
From: Anatol Pomozov <anatol.pomozov@gmail.com>
To: marcel@holtmann.org,
	gustavo@padovan.org,
	johan.hedberg@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	Anatol Pomozov <anatol.pomozov@gmail.com>
Subject: [PATCH] bluetooth: Fix crash in the driver initialization codepath
Date: Wed, 30 Jul 2014 15:57:03 -0700
Message-Id: <1406761023-21290-1-git-send-email-anatol.pomozov@gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

btmrvl_add_card() function calls kthread_run that might return error
(e.g. if current thread is killed). If one tries to use the error
value as a pointer then invalid memory access oops happens.

Check kthread_run() return value, if it is an error then release resources correctly.

TEST=boot computer with BT modules enabled. I see the error message that BT device
initialization failed. Now kernel does not crash. Hint: to enable BT run
'rmmod btmrvl_sdio; modprobe btmrvl_sdio'

Signed-off-by: Anatol Pomozov <anatol.pomozov@gmail.com>
---
 drivers/bluetooth/btmrvl_main.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/bluetooth/btmrvl_main.c b/drivers/bluetooth/btmrvl_main.c
index e9dbddb..d95ebf6 100644
--- a/drivers/bluetooth/btmrvl_main.c
+++ b/drivers/bluetooth/btmrvl_main.c
@@ -645,12 +645,17 @@ struct btmrvl_private *btmrvl_add_card(void *card)
 	init_waitqueue_head(&priv->main_thread.wait_q);
 	priv->main_thread.task = kthread_run(btmrvl_service_main_thread,
 				&priv->main_thread, "btmrvl_main_service");
+	if (IS_ERR(priv->main_thread.task))
+		goto err_thread;
 
 	priv->btmrvl_dev.card = card;
 	priv->btmrvl_dev.tx_dnld_rdy = true;
 
 	return priv;
 
+err_thread:
+	btmrvl_free_adapter(priv);
+
 err_adapter:
 	kfree(priv);
 
-- 
2.0.0.526.g5318336
