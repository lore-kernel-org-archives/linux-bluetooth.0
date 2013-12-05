Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 4/8] android/hidhost: Unregister ipc handlers if init fails
Date: Thu,  5 Dec 2013 11:37:13 +0100
Message-Id: <1386239837-4102-4-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1386239837-4102-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1386239837-4102-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Add ipc handlers cleanup if init fails. Send proper status if
already initialized.

---
 android/hal-hidhost.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/android/hal-hidhost.c b/android/hal-hidhost.c
index 0573006..6a6b682 100644
--- a/android/hal-hidhost.c
+++ b/android/hal-hidhost.c
@@ -363,9 +363,13 @@ static bt_status_t send_data(bt_bdaddr_t *bd_addr, char *data)
 static bt_status_t init(bthh_callbacks_t *callbacks)
 {
 	struct hal_cmd_register_module cmd;
+	int ret;
 
 	DBG("");
 
+	if (interface_ready())
+		return BT_STATUS_DONE;
+
 	/* store reference to user callbacks */
 	cbacks = callbacks;
 
@@ -374,8 +378,15 @@ static bt_status_t init(bthh_callbacks_t *callbacks)
 
 	cmd.service_id = HAL_SERVICE_ID_HIDHOST;
 
-	return hal_ipc_cmd(HAL_SERVICE_ID_CORE, HAL_OP_REGISTER_MODULE,
+	ret = hal_ipc_cmd(HAL_SERVICE_ID_CORE, HAL_OP_REGISTER_MODULE,
 					sizeof(cmd), &cmd, 0, NULL, NULL);
+
+	if (ret != BT_STATUS_SUCCESS) {
+		cbacks = NULL;
+		hal_ipc_unregister(HAL_SERVICE_ID_HIDHOST);
+	}
+
+	return ret;
 }
 
 static void cleanup(void)
-- 
1.8.5

