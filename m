Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH v3 12/15] android/handsfree-client: Add Query Current Call and Operator Name cmd
Date: Mon, 15 Sep 2014 13:51:25 +0200
Message-Id: <1410781888-1952-13-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1410781888-1952-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1410781888-1952-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/hal-handsfree-client.c | 26 ++++++++++++++++++++++++++
 android/hal-msg.h              |  3 +++
 android/handsfree-client.c     | 20 ++++++++++++++++++++
 3 files changed, 49 insertions(+)

diff --git a/android/hal-handsfree-client.c b/android/hal-handsfree-client.c
index 35929c5..fbdc516 100644
--- a/android/hal-handsfree-client.c
+++ b/android/hal-handsfree-client.c
@@ -246,6 +246,30 @@ static bt_status_t call_action(bthf_client_call_action_t action, int index)
 				NULL, NULL, NULL);
 }
 
+static bt_status_t query_current_calls(void)
+{
+	DBG("");
+
+	if (!interface_ready())
+		return BT_STATUS_NOT_READY;
+
+	return hal_ipc_cmd(HAL_SERVICE_ID_HANDSFREE_CLIENT,
+				HAL_OP_HF_CLIENT_QUERY_CURRENT_CALLS, 0, NULL,
+				NULL, NULL, NULL);
+}
+
+static bt_status_t query_operator_name(void)
+{
+	DBG("");
+
+	if (!interface_ready())
+		return BT_STATUS_NOT_READY;
+
+	return hal_ipc_cmd(HAL_SERVICE_ID_HANDSFREE_CLIENT,
+				HAL_OP_HF_CLIENT_QUERY_OPERATOR_NAME, 0, NULL,
+				NULL, NULL, NULL);
+}
+
 static void cleanup(void)
 {
 	struct hal_cmd_unregister_module cmd;
@@ -278,6 +302,8 @@ static bthf_client_interface_t iface = {
 	.dial = dial,
 	.dial_memory = dial_memory,
 	.handle_call_action = call_action,
+	.query_current_calls = query_current_calls,
+	.query_current_operator_name = query_operator_name,
 	.cleanup = cleanup
 };
 
diff --git a/android/hal-msg.h b/android/hal-msg.h
index dc563e4..bedc598 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -1040,6 +1040,9 @@ struct hal_cmd_hf_client_call_action {
 	uint8_t index;
 } __attribute__((packed));
 
+#define HAL_OP_HF_CLIENT_QUERY_CURRENT_CALLS	0x0b
+#define HAL_OP_HF_CLIENT_QUERY_OPERATOR_NAME	0x0c
+
 /* Notifications and confirmations */
 
 #define HAL_POWER_OFF			0x00
diff --git a/android/handsfree-client.c b/android/handsfree-client.c
index 6319b85..9bec019 100644
--- a/android/handsfree-client.c
+++ b/android/handsfree-client.c
@@ -116,6 +116,22 @@ static void handle_call_action(const void *buf, uint16_t len)
 			HAL_OP_HF_CLIENT_CALL_ACTION, HAL_STATUS_UNSUPPORTED);
 }
 
+static void handle_query_current_calls(const void *buf, uint16_t len)
+{
+	DBG("Not Implemented");
+	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_HANDSFREE_CLIENT,
+					HAL_OP_HF_CLIENT_QUERY_CURRENT_CALLS,
+					HAL_STATUS_UNSUPPORTED);
+}
+
+static void handle_query_operator_name(const void *buf, uint16_t len)
+{
+	DBG("Not Implemented");
+	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_HANDSFREE_CLIENT,
+					HAL_OP_HF_CLIENT_QUERY_OPERATOR_NAME,
+					HAL_STATUS_UNSUPPORTED);
+}
+
 static const struct ipc_handler cmd_handlers[] = {
 	/* HAL_OP_HF_CLIENT_CONNECT */
 	{ handle_connect, false,
@@ -144,6 +160,10 @@ static const struct ipc_handler cmd_handlers[] = {
 	/* HAL_OP_HF_CLIENT_CALL_ACTION */
 	{ handle_call_action, false,
 				sizeof(struct hal_cmd_hf_client_call_action) },
+	/* HAL_OP_HF_CLIENT_QUERY_CURRENT_CALLS */
+	{ handle_query_current_calls, false, 0 },
+	/* HAL_OP_HF_CLIENT_QUERY_OPERATOR_NAME */
+	{ handle_query_operator_name, false, 0 },
 };
 
 bool bt_hf_client_register(struct ipc *ipc, const bdaddr_t *addr)
-- 
1.8.4

