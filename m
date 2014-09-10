Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com,
	Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH v2 09/16] android/hf-client: Add Start/Stop Voice Recognition command
Date: Wed, 10 Sep 2014 13:34:07 +0200
Message-Id: <1410348854-26249-10-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1410348854-26249-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1410348854-26249-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/hal-hf-client.c | 24 ++++++++++++++++++++++++
 android/hal-msg.h       |  3 +++
 android/hf-client.c     | 20 ++++++++++++++++++++
 3 files changed, 47 insertions(+)

diff --git a/android/hal-hf-client.c b/android/hal-hf-client.c
index 0ebd9d1..5ae13f8 100644
--- a/android/hal-hf-client.c
+++ b/android/hal-hf-client.c
@@ -146,6 +146,28 @@ static bt_status_t disconnect_audio(bt_bdaddr_t *bd_addr)
 					sizeof(cmd), &cmd, NULL, NULL, NULL);
 }
 
+static bt_status_t start_voice_recognition(void)
+{
+	DBG("");
+
+	if (!interface_ready())
+		return BT_STATUS_NOT_READY;
+
+	return hal_ipc_cmd(HAL_SERVICE_ID_HF_CLIENT, HAL_OP_HF_CLIENT_START_VR,
+						0, NULL, NULL, NULL, NULL);
+}
+
+static bt_status_t stop_voice_recognition(void)
+{
+	DBG("");
+
+	if (!interface_ready())
+		return BT_STATUS_NOT_READY;
+
+	return hal_ipc_cmd(HAL_SERVICE_ID_HF_CLIENT, HAL_OP_HF_CLIENT_STOP_VR,
+						0, NULL, NULL, NULL, NULL);
+}
+
 static void cleanup(void)
 {
 	struct hal_cmd_unregister_module cmd;
@@ -172,6 +194,8 @@ static bthf_client_interface_t iface = {
 	.disconnect = disconnect,
 	.connect_audio = connect_audio,
 	.disconnect_audio = disconnect_audio,
+	.start_voice_recognition = start_voice_recognition,
+	.stop_voice_recognition = stop_voice_recognition,
 	.cleanup = cleanup
 };
 
diff --git a/android/hal-msg.h b/android/hal-msg.h
index 7e4a077..e46dffc 100644
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
diff --git a/android/hf-client.c b/android/hf-client.c
index d4fca21..c49b895 100644
--- a/android/hf-client.c
+++ b/android/hf-client.c
@@ -75,6 +75,22 @@ static void handle_disconnect_audio(const void *buf, uint16_t len)
 					HAL_STATUS_UNSUPPORTED);
 }
 
+static void handle_start_vr(const void *buf, uint16_t len)
+{
+	DBG("Not Implemented");
+	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_HF_CLIENT,
+						HAL_OP_HF_CLIENT_START_VR,
+						HAL_STATUS_UNSUPPORTED);
+}
+
+static void handle_stop_vr(const void *buf, uint16_t len)
+{
+	DBG("Not Implemented");
+	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_HF_CLIENT,
+						HAL_OP_HF_CLIENT_STOP_VR,
+						HAL_STATUS_UNSUPPORTED);
+}
+
 static const struct ipc_handler cmd_handlers[] = {
 	/* HAL_OP_HF_CLIENT_CONNECT */
 	{ handle_connect, false,
@@ -88,6 +104,10 @@ static const struct ipc_handler cmd_handlers[] = {
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

