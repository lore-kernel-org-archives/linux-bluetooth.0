Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 6/8] android/a2dp: Unregister ipc handlers if init fails
Date: Thu,  5 Dec 2013 11:37:15 +0100
Message-Id: <1386239837-4102-6-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1386239837-4102-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1386239837-4102-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Add ipc handlers cleanup if init fails. Send proper status if
already initialized.

---
 android/hal-a2dp.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/android/hal-a2dp.c b/android/hal-a2dp.c
index cf39ba2..c898995 100644
--- a/android/hal-a2dp.c
+++ b/android/hal-a2dp.c
@@ -96,9 +96,13 @@ static bt_status_t disconnect(bt_bdaddr_t *bd_addr)
 static bt_status_t init(btav_callbacks_t *callbacks)
 {
 	struct hal_cmd_register_module cmd;
+	int ret;
 
 	DBG("");
 
+	if (interface_ready())
+		return BT_STATUS_DONE;
+
 	cbs = callbacks;
 
 	hal_ipc_register(HAL_SERVICE_ID_A2DP, ev_handlers,
@@ -106,8 +110,15 @@ static bt_status_t init(btav_callbacks_t *callbacks)
 
 	cmd.service_id = HAL_SERVICE_ID_A2DP;
 
-	return hal_ipc_cmd(HAL_SERVICE_ID_CORE, HAL_OP_REGISTER_MODULE,
+	ret = hal_ipc_cmd(HAL_SERVICE_ID_CORE, HAL_OP_REGISTER_MODULE,
 					sizeof(cmd), &cmd, 0, NULL, NULL);
+
+	if (ret != BT_STATUS_SUCCESS) {
+		cbs = NULL;
+		hal_ipc_unregister(HAL_SERVICE_ID_A2DP);
+	}
+
+	return ret;
 }
 
 static void cleanup()
-- 
1.8.5

