Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH v3 08/15] android/handsfree-client: Add Start/Stop Voice Recognition command
Date: Mon, 15 Sep 2014 13:51:21 +0200
Message-Id: <1410781888-1952-9-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1410781888-1952-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1410781888-1952-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/hal-handsfree-client.c | 26 ++++++++++++++++++++++++++
 android/hal-msg.h              |  3 +++
 android/handsfree-client.c     | 18 ++++++++++++++++++
 3 files changed, 47 insertions(+)

diff --git a/android/hal-handsfree-client.c b/android/hal-handsfree-client.c
index 22a7fd6..c52d0c4 100644
--- a/android/hal-handsfree-client.c
+++ b/android/hal-handsfree-client.c
@@ -146,6 +146,30 @@ static bt_status_t disconnect_audio(bt_bdaddr_t *bd_addr)
 				&cmd, NULL, NULL, NULL);
 }
 
+static bt_status_t start_voice_recognition(void)
+{
+	DBG("");
+
+	if (!interface_ready())
+		return BT_STATUS_NOT_READY;
+
+	return hal_ipc_cmd(HAL_SERVICE_ID_HANDSFREE_CLIENT,
+				HAL_OP_HF_CLIENT_START_VR, 0, NULL, NULL, NULL,
+				NULL);
+}
+
+static bt_status_t stop_voice_recognition(void)
+{
+	DBG("");
+
+	if (!interface_ready())
+		return BT_STATUS_NOT_READY;
+
+	return hal_ipc_cmd(HAL_SERVICE_ID_HANDSFREE_CLIENT,
+				HAL_OP_HF_CLIENT_STOP_VR, 0, NULL, NULL, NULL,
+				NULL);
+}
+
 static void cleanup(void)
 {
 	struct hal_cmd_unregister_module cmd;
@@ -172,6 +196,8 @@ static bthf_client_interface_t iface = {
 	.disconnect = disconnect,
 	.connect_audio = connect_audio,
 	.disconnect_audio = disconnect_audio,
+	.start_voice_recognition = start_voice_recognition,
+	.stop_voice_recognition = stop_voice_recognition,
 	.cleanup = cleanup
 };
 
diff --git a/android/hal-msg.h b/android/hal-msg.h
index afb7836..a97759c 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -998,6 +998,9 @@ struct hal_cmd_hf_client_disconnect_audio {
 	uint8_t bdaddr[6];
 } __attribute__((packed));
 
+#define HAL_OP_HF_CLIENT_START_VR		0x05
+#define HAL_OP_HF_CLIENT_STOP_VR		0x06
+
 /* Notifications and confirmations */
 
 #define HAL_POWER_OFF			0x00
diff --git a/android/handsfree-client.c b/android/handsfree-client.c
index a65868e..921272f 100644
--- a/android/handsfree-client.c
+++ b/android/handsfree-client.c
@@ -73,6 +73,20 @@ static void handle_disconnect_audio(const void *buf, uint16_t len)
 					HAL_STATUS_UNSUPPORTED);
 }
 
+static void handle_start_vr(const void *buf, uint16_t len)
+{
+	DBG("Not Implemented");
+	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_HANDSFREE_CLIENT,
+			HAL_OP_HF_CLIENT_START_VR, HAL_STATUS_UNSUPPORTED);
+}
+
+static void handle_stop_vr(const void *buf, uint16_t len)
+{
+	DBG("Not Implemented");
+	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_HANDSFREE_CLIENT,
+			HAL_OP_HF_CLIENT_STOP_VR, HAL_STATUS_UNSUPPORTED);
+}
+
 static const struct ipc_handler cmd_handlers[] = {
 	/* HAL_OP_HF_CLIENT_CONNECT */
 	{ handle_connect, false,
@@ -86,6 +100,10 @@ static const struct ipc_handler cmd_handlers[] = {
 	/* HAL_OP_HF_CLIENT_DISCONNECT_AUDIO */
 	{ handle_disconnect_audio, false,
 			sizeof(struct hal_cmd_hf_client_disconnect_audio) },
+	/* define HAL_OP_HF_CLIENT_START_VR */
+	{ handle_start_vr, false, 0 },
+	/* define HAL_OP_HF_CLIENT_STOP_VR */
+	{ handle_stop_vr, false, 0 },
 };
 
 bool bt_hf_client_register(struct ipc *ipc, const bdaddr_t *addr)
-- 
1.8.4

