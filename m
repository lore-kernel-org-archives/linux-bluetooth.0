Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com,
	Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH v2 14/16] android/hf-client: Add Retrieve Subscriber Info command
Date: Wed, 10 Sep 2014 13:34:12 +0200
Message-Id: <1410348854-26249-15-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1410348854-26249-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1410348854-26249-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/hal-hf-client.c | 13 +++++++++++++
 android/hal-msg.h       |  1 +
 android/hf-client.c     | 10 ++++++++++
 3 files changed, 24 insertions(+)

diff --git a/android/hal-hf-client.c b/android/hal-hf-client.c
index 85a0718..572f06e 100644
--- a/android/hal-hf-client.c
+++ b/android/hal-hf-client.c
@@ -267,6 +267,18 @@ static bt_status_t query_operator_name(void)
 					0, NULL, NULL, NULL, NULL);
 }
 
+static bt_status_t retrieve_subsr_info(void)
+{
+	DBG("");
+
+	if (!interface_ready())
+		return BT_STATUS_NOT_READY;
+
+	return hal_ipc_cmd(HAL_SERVICE_ID_HF_CLIENT,
+					HAL_OP_HF_CLIENT_RETRIEVE_SUBSCR_INFO,
+					0, NULL, NULL, NULL, NULL);
+}
+
 static void cleanup(void)
 {
 	struct hal_cmd_unregister_module cmd;
@@ -301,6 +313,7 @@ static bthf_client_interface_t iface = {
 	.handle_call_action = call_action,
 	.query_current_calls = query_current_calls,
 	.query_current_operator_name = query_operator_name,
+	.retrieve_subscriber_info = retrieve_subsr_info,
 	.cleanup = cleanup
 };
 
diff --git a/android/hal-msg.h b/android/hal-msg.h
index 9e8a477..ad075fc 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -1042,6 +1042,7 @@ struct hal_cmd_hf_client_call_action {
 
 #define HAL_OP_HF_CLIENT_QUERY_CURRENT_CALLS	0x11
 #define HAL_OP_HF_CLIENT_QUERY_OPERATOR_NAME	0x12
+#define HAL_OP_HF_CLIENT_RETRIEVE_SUBSCR_INFO	0x13
 
 /* Notifications and confirmations */
 
diff --git a/android/hf-client.c b/android/hf-client.c
index 8b7386c..bdd60b1 100644
--- a/android/hf-client.c
+++ b/android/hf-client.c
@@ -136,6 +136,14 @@ static void handle_query_operator_name(const void *buf, uint16_t len)
 					HAL_STATUS_UNSUPPORTED);
 }
 
+static void handle_retrieve_subscr_info(const void *buf, uint16_t len)
+{
+	DBG("Not Implemented");
+	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_HF_CLIENT,
+					HAL_OP_HF_CLIENT_RETRIEVE_SUBSCR_INFO,
+					HAL_STATUS_UNSUPPORTED);
+}
+
 static const struct ipc_handler cmd_handlers[] = {
 	/* HAL_OP_HF_CLIENT_CONNECT */
 	{ handle_connect, false,
@@ -168,6 +176,8 @@ static const struct ipc_handler cmd_handlers[] = {
 	{ handle_query_current_calls, false, 0 },
 	/* HAL_OP_HF_CLIENT_QUERY_OPERATOR_NAME */
 	{ handle_query_operator_name, false, 0 },
+	/* HAL_OP_HF_CLIENT_RETRIEVE_SUBSCR_INFO */
+	{ handle_retrieve_subscr_info, false, 0 },
 };
 
 bool bt_hf_client_register(struct ipc *ipc, const bdaddr_t *addr)
-- 
1.8.4

