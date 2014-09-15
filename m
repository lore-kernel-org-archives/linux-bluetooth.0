Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH v3 14/15] android/handsfree-client: Add Send DTMF command
Date: Mon, 15 Sep 2014 13:51:27 +0200
Message-Id: <1410781888-1952-15-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1410781888-1952-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1410781888-1952-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/hal-handsfree-client.c | 17 +++++++++++++++++
 android/hal-msg.h              |  5 +++++
 android/handsfree-client.c     | 10 ++++++++++
 3 files changed, 32 insertions(+)

diff --git a/android/hal-handsfree-client.c b/android/hal-handsfree-client.c
index d5683d1..7c1cfea 100644
--- a/android/hal-handsfree-client.c
+++ b/android/hal-handsfree-client.c
@@ -282,6 +282,22 @@ static bt_status_t retrieve_subsr_info(void)
 				NULL, NULL, NULL);
 }
 
+static bt_status_t send_dtmf(char tone)
+{
+	struct hal_cmd_hf_client_send_dtmf cmd;
+
+	DBG("");
+
+	if (!interface_ready())
+		return BT_STATUS_NOT_READY;
+
+	cmd.tone = tone;
+
+	return hal_ipc_cmd(HAL_SERVICE_ID_HANDSFREE_CLIENT,
+				HAL_OP_HF_CLIENT_SEND_DTMF, sizeof(cmd), &cmd,
+				NULL, NULL, NULL);
+}
+
 static void cleanup(void)
 {
 	struct hal_cmd_unregister_module cmd;
@@ -317,6 +333,7 @@ static bthf_client_interface_t iface = {
 	.query_current_calls = query_current_calls,
 	.query_current_operator_name = query_operator_name,
 	.retrieve_subscriber_info = retrieve_subsr_info,
+	.send_dtmf = send_dtmf,
 	.cleanup = cleanup
 };
 
diff --git a/android/hal-msg.h b/android/hal-msg.h
index 300465d..f9fcfb3 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -1044,6 +1044,11 @@ struct hal_cmd_hf_client_call_action {
 #define HAL_OP_HF_CLIENT_QUERY_OPERATOR_NAME	0x0c
 #define HAL_OP_HF_CLIENT_RETRIEVE_SUBSCR_INFO	0x0d
 
+#define HAL_OP_HF_CLIENT_SEND_DTMF		0x0e
+struct hal_cmd_hf_client_send_dtmf {
+	uint8_t tone;
+} __attribute__((packed));
+
 /* Notifications and confirmations */
 
 #define HAL_POWER_OFF			0x00
diff --git a/android/handsfree-client.c b/android/handsfree-client.c
index 8df93d9..604ac08 100644
--- a/android/handsfree-client.c
+++ b/android/handsfree-client.c
@@ -140,6 +140,13 @@ static void handle_retrieve_subscr_info(const void *buf, uint16_t len)
 					HAL_STATUS_UNSUPPORTED);
 }
 
+static void handle_send_dtmf(const void *buf, uint16_t len)
+{
+	DBG("Not Implemented");
+	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_HANDSFREE_CLIENT,
+			HAL_OP_HF_CLIENT_SEND_DTMF, HAL_STATUS_UNSUPPORTED);
+}
+
 static const struct ipc_handler cmd_handlers[] = {
 	/* HAL_OP_HF_CLIENT_CONNECT */
 	{ handle_connect, false,
@@ -174,6 +181,9 @@ static const struct ipc_handler cmd_handlers[] = {
 	{ handle_query_operator_name, false, 0 },
 	/* HAL_OP_HF_CLIENT_RETRIEVE_SUBSCR_INFO */
 	{ handle_retrieve_subscr_info, false, 0 },
+	/* HAL_OP_HF_CLIENT_SEND_DTMF */
+	{ handle_send_dtmf, false,
+				sizeof(struct hal_cmd_hf_client_send_dtmf) },
 };
 
 bool bt_hf_client_register(struct ipc *ipc, const bdaddr_t *addr)
-- 
1.8.4

