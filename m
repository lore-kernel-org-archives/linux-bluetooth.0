Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH 16/39] android/hf-client: Add Send DTMF command
Date: Tue,  9 Sep 2014 21:57:01 +0200
Message-Id: <1410292644-23497-17-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1410292644-23497-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1410292644-23497-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/hal-hf-client.c | 17 +++++++++++++++++
 android/hal-msg.h       |  5 +++++
 android/hf-client.c     | 10 ++++++++++
 3 files changed, 32 insertions(+)

diff --git a/android/hal-hf-client.c b/android/hal-hf-client.c
index d74958d..e7d9abe 100644
--- a/android/hal-hf-client.c
+++ b/android/hal-hf-client.c
@@ -275,6 +275,22 @@ static bt_status_t retrieve_subsr_info(void)
 					0, NULL, NULL, NULL, NULL);
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
+	return hal_ipc_cmd(HAL_SERVICE_ID_HF_CLIENT,
+					HAL_OP_HF_CLIENT_SEND_DTMF,
+					sizeof(cmd), &cmd, NULL, NULL, NULL);
+}
+
 static void cleanup(void)
 {
 	struct hal_cmd_unregister_module cmd;
@@ -310,6 +326,7 @@ static bthf_client_interface_t iface = {
 	.query_current_calls = query_current_calls,
 	.query_current_operator_name = query_operator_name,
 	.retrieve_subscriber_info = retrieve_subsr_info,
+	.send_dtmf = send_dtmf,
 	.cleanup = cleanup
 };
 
diff --git a/android/hal-msg.h b/android/hal-msg.h
index e08c002..b43f7d9 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -1040,6 +1040,11 @@ struct hal_cmd_hf_client_call_action {
 #define HAL_OP_HF_CLIENT_QUERY_OPERATOR_NAME	0x12
 #define HAL_OP_HF_CLIENT_RETRIEVE_SUBSCR_INFO	0x13
 
+#define HAL_OP_HF_CLIENT_SEND_DTMF		0x14
+struct hal_cmd_hf_client_send_dtmf {
+	uint8_t tone;
+} __attribute__((packed));
+
 /* Notifications and confirmations */
 
 #define HAL_POWER_OFF			0x00
diff --git a/android/hf-client.c b/android/hf-client.c
index bdd60b1..bcb2f51 100644
--- a/android/hf-client.c
+++ b/android/hf-client.c
@@ -144,6 +144,13 @@ static void handle_retrieve_subscr_info(const void *buf, uint16_t len)
 					HAL_STATUS_UNSUPPORTED);
 }
 
+static void handle_send_dtmf(const void *buf, uint16_t len)
+{
+	DBG("Not Implemented");
+	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_HF_CLIENT,
+			HAL_OP_HF_CLIENT_SEND_DTMF, HAL_STATUS_UNSUPPORTED);
+}
+
 static const struct ipc_handler cmd_handlers[] = {
 	/* HAL_OP_HF_CLIENT_CONNECT */
 	{ handle_connect, false,
@@ -178,6 +185,9 @@ static const struct ipc_handler cmd_handlers[] = {
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

