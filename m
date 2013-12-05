Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 5/8] android/pan: Unregister ipc handlers if init fails
Date: Thu,  5 Dec 2013 11:37:14 +0100
Message-Id: <1386239837-4102-5-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1386239837-4102-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1386239837-4102-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Add ipc handlers cleanup if init fails. Send proper status if
already initialized.

---
 android/hal-pan.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/android/hal-pan.c b/android/hal-pan.c
index e7b8a20..6aaf8af 100644
--- a/android/hal-pan.c
+++ b/android/hal-pan.c
@@ -152,9 +152,13 @@ static bt_status_t pan_disconnect(const bt_bdaddr_t *bd_addr)
 static bt_status_t pan_init(const btpan_callbacks_t *callbacks)
 {
 	struct hal_cmd_register_module cmd;
+	int ret;
 
 	DBG("");
 
+	if (interface_ready())
+		return BT_STATUS_DONE;
+
 	cbs = callbacks;
 
 	hal_ipc_register(HAL_SERVICE_ID_PAN, ev_handlers,
@@ -162,8 +166,15 @@ static bt_status_t pan_init(const btpan_callbacks_t *callbacks)
 
 	cmd.service_id = HAL_SERVICE_ID_PAN;
 
-	return hal_ipc_cmd(HAL_SERVICE_ID_CORE, HAL_OP_REGISTER_MODULE,
+	ret = hal_ipc_cmd(HAL_SERVICE_ID_CORE, HAL_OP_REGISTER_MODULE,
 					sizeof(cmd), &cmd, 0, NULL, NULL);
+
+	if (ret != BT_STATUS_SUCCESS) {
+		cbs = NULL;
+		hal_ipc_unregister(HAL_SERVICE_ID_PAN);
+	}
+
+	return ret;
 }
 
 static void pan_cleanup()
-- 
1.8.5

