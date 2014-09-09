Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH 17/39] android/hf-client: Add Get Last Voice Tag Number command
Date: Tue,  9 Sep 2014 21:57:02 +0200
Message-Id: <1410292644-23497-18-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1410292644-23497-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1410292644-23497-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/hal-hf-client.c | 13 +++++++++++++
 android/hal-msg.h       |  2 ++
 android/hf-client.c     | 10 ++++++++++
 3 files changed, 25 insertions(+)

diff --git a/android/hal-hf-client.c b/android/hal-hf-client.c
index e7d9abe..8ee77f2 100644
--- a/android/hal-hf-client.c
+++ b/android/hal-hf-client.c
@@ -291,6 +291,18 @@ static bt_status_t send_dtmf(char tone)
 					sizeof(cmd), &cmd, NULL, NULL, NULL);
 }
 
+static bt_status_t request_last_voice_tag_number(void)
+{
+	DBG("");
+
+	if (!interface_ready())
+		return BT_STATUS_NOT_READY;
+
+	return hal_ipc_cmd(HAL_SERVICE_ID_HF_CLIENT,
+					HAL_OP_HF_CLIENT_GET_LAST_VOICE_TAG_NUM,
+					0, NULL, NULL, NULL, NULL);
+}
+
 static void cleanup(void)
 {
 	struct hal_cmd_unregister_module cmd;
@@ -327,6 +339,7 @@ static bthf_client_interface_t iface = {
 	.query_current_operator_name = query_operator_name,
 	.retrieve_subscriber_info = retrieve_subsr_info,
 	.send_dtmf = send_dtmf,
+	.request_last_voice_tag_number = request_last_voice_tag_number,
 	.cleanup = cleanup
 };
 
diff --git a/android/hal-msg.h b/android/hal-msg.h
index b43f7d9..9445c66 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -1045,6 +1045,8 @@ struct hal_cmd_hf_client_send_dtmf {
 	uint8_t tone;
 } __attribute__((packed));
 
+#define HAL_OP_HF_CLIENT_GET_LAST_VOICE_TAG_NUM	0x15
+
 /* Notifications and confirmations */
 
 #define HAL_POWER_OFF			0x00
diff --git a/android/hf-client.c b/android/hf-client.c
index bcb2f51..1d03c46 100644
--- a/android/hf-client.c
+++ b/android/hf-client.c
@@ -151,6 +151,14 @@ static void handle_send_dtmf(const void *buf, uint16_t len)
 			HAL_OP_HF_CLIENT_SEND_DTMF, HAL_STATUS_UNSUPPORTED);
 }
 
+static void handle_get_last_vc_tag_num(const void *buf, uint16_t len)
+{
+	DBG("Not Implemented");
+	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_HF_CLIENT,
+					HAL_OP_HF_CLIENT_GET_LAST_VOICE_TAG_NUM,
+					HAL_STATUS_UNSUPPORTED);
+}
+
 static const struct ipc_handler cmd_handlers[] = {
 	/* HAL_OP_HF_CLIENT_CONNECT */
 	{ handle_connect, false,
@@ -188,6 +196,8 @@ static const struct ipc_handler cmd_handlers[] = {
 	/* HAL_OP_HF_CLIENT_SEND_DTMF */
 	{ handle_send_dtmf, false,
 				sizeof(struct hal_cmd_hf_client_send_dtmf) },
+	/* HAL_OP_HF_CLIENT_GET_LAST_VOICE_TAG_NUM */
+	{ handle_get_last_vc_tag_num, false, 0 },
 };
 
 bool bt_hf_client_register(struct ipc *ipc, const bdaddr_t *addr)
-- 
1.8.4

