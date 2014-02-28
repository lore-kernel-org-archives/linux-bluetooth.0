Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 3/6] android/hal-handsfree: Add support for enable HFP command
Date: Fri, 28 Feb 2014 17:19:31 +0100
Message-Id: <1393604374-10127-3-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1393604374-10127-1-git-send-email-szymon.janc@tieto.com>
References: <1393604374-10127-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/hal-handsfree.c | 45 ++++++++++++++++++++++++++-------------------
 1 file changed, 26 insertions(+), 19 deletions(-)

diff --git a/android/hal-handsfree.c b/android/hal-handsfree.c
index 1b150c3..790d7a5 100644
--- a/android/hal-handsfree.c
+++ b/android/hal-handsfree.c
@@ -196,6 +196,25 @@ static const struct hal_ipc_handler ev_handlers[] = {
 	{handle_hsp_key_press, false, 0},
 };
 
+static void cleanup(void)
+{
+	struct hal_cmd_unregister_module cmd;
+
+	DBG("");
+
+	if (!interface_ready())
+		return;
+
+	cbs = NULL;
+
+	cmd.service_id = HAL_SERVICE_ID_HANDSFREE;
+
+	hal_ipc_cmd(HAL_SERVICE_ID_CORE, HAL_OP_UNREGISTER_MODULE,
+					sizeof(cmd), &cmd, 0, NULL, NULL);
+
+	hal_ipc_unregister(HAL_SERVICE_ID_HANDSFREE);
+}
+
 static bt_status_t init(bthf_callbacks_t *callbacks)
 {
 	struct hal_cmd_register_module cmd;
@@ -219,8 +238,15 @@ static bt_status_t init(bthf_callbacks_t *callbacks)
 	if (ret != BT_STATUS_SUCCESS) {
 		cbs = NULL;
 		hal_ipc_unregister(HAL_SERVICE_ID_HANDSFREE);
+		return ret;
 	}
 
+	/* TODO should be based on some property value */
+	ret = hal_ipc_cmd(HAL_SERVICE_ID_HANDSFREE, HAL_OP_HANDSFREE_ENABLE_HFP,
+							0, NULL, 0, NULL, NULL);
+	if (ret != BT_STATUS_SUCCESS)
+		cleanup();
+
 	return ret;
 }
 
@@ -518,25 +544,6 @@ static bt_status_t phone_state_change(int num_active, int num_held,
 					len, cmd, 0, NULL, NULL);
 }
 
-static void cleanup(void)
-{
-	struct hal_cmd_unregister_module cmd;
-
-	DBG("");
-
-	if (!interface_ready())
-		return;
-
-	cbs = NULL;
-
-	cmd.service_id = HAL_SERVICE_ID_HANDSFREE;
-
-	hal_ipc_cmd(HAL_SERVICE_ID_CORE, HAL_OP_UNREGISTER_MODULE,
-					sizeof(cmd), &cmd, 0, NULL, NULL);
-
-	hal_ipc_unregister(HAL_SERVICE_ID_HANDSFREE);
-}
-
 static bthf_interface_t iface = {
 	.size = sizeof(iface),
 	.init = init,
-- 
1.8.3.2

