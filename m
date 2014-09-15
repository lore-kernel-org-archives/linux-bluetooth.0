Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH v3 15/15] android/handsfree-client: Add Get Last Voice Tag Number command
Date: Mon, 15 Sep 2014 13:51:28 +0200
Message-Id: <1410781888-1952-16-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1410781888-1952-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1410781888-1952-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/hal-handsfree-client.c | 13 +++++++++++++
 android/hal-msg.h              |  2 ++
 android/handsfree-client.c     | 10 ++++++++++
 3 files changed, 25 insertions(+)

diff --git a/android/hal-handsfree-client.c b/android/hal-handsfree-client.c
index 7c1cfea..98b6cb6 100644
--- a/android/hal-handsfree-client.c
+++ b/android/hal-handsfree-client.c
@@ -298,6 +298,18 @@ static bt_status_t send_dtmf(char tone)
 				NULL, NULL, NULL);
 }
 
+static bt_status_t request_last_voice_tag_number(void)
+{
+	DBG("");
+
+	if (!interface_ready())
+		return BT_STATUS_NOT_READY;
+
+	return hal_ipc_cmd(HAL_SERVICE_ID_HANDSFREE_CLIENT,
+					HAL_OP_HF_CLIENT_GET_LAST_VOICE_TAG_NUM,
+					0, NULL, NULL, NULL, NULL);
+}
+
 static void cleanup(void)
 {
 	struct hal_cmd_unregister_module cmd;
@@ -334,6 +346,7 @@ static bthf_client_interface_t iface = {
 	.query_current_operator_name = query_operator_name,
 	.retrieve_subscriber_info = retrieve_subsr_info,
 	.send_dtmf = send_dtmf,
+	.request_last_voice_tag_number = request_last_voice_tag_number,
 	.cleanup = cleanup
 };
 
diff --git a/android/hal-msg.h b/android/hal-msg.h
index f9fcfb3..ba213b7 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -1049,6 +1049,8 @@ struct hal_cmd_hf_client_send_dtmf {
 	uint8_t tone;
 } __attribute__((packed));
 
+#define HAL_OP_HF_CLIENT_GET_LAST_VOICE_TAG_NUM	0x0f
+
 /* Notifications and confirmations */
 
 #define HAL_POWER_OFF			0x00
diff --git a/android/handsfree-client.c b/android/handsfree-client.c
index 604ac08..be29952 100644
--- a/android/handsfree-client.c
+++ b/android/handsfree-client.c
@@ -147,6 +147,14 @@ static void handle_send_dtmf(const void *buf, uint16_t len)
 			HAL_OP_HF_CLIENT_SEND_DTMF, HAL_STATUS_UNSUPPORTED);
 }
 
+static void handle_get_last_vc_tag_num(const void *buf, uint16_t len)
+{
+	DBG("Not Implemented");
+	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_HANDSFREE_CLIENT,
+					HAL_OP_HF_CLIENT_GET_LAST_VOICE_TAG_NUM,
+					HAL_STATUS_UNSUPPORTED);
+}
+
 static const struct ipc_handler cmd_handlers[] = {
 	/* HAL_OP_HF_CLIENT_CONNECT */
 	{ handle_connect, false,
@@ -184,6 +192,8 @@ static const struct ipc_handler cmd_handlers[] = {
 	/* HAL_OP_HF_CLIENT_SEND_DTMF */
 	{ handle_send_dtmf, false,
 				sizeof(struct hal_cmd_hf_client_send_dtmf) },
+	/* HAL_OP_HF_CLIENT_GET_LAST_VOICE_TAG_NUM */
+	{ handle_get_last_vc_tag_num, false, 0 },
 };
 
 bool bt_hf_client_register(struct ipc *ipc, const bdaddr_t *addr)
-- 
1.8.4

