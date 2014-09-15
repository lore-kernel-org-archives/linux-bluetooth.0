Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH v3 09/15] android/handsfree-client: Add Volume Control command
Date: Mon, 15 Sep 2014 13:51:22 +0200
Message-Id: <1410781888-1952-10-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1410781888-1952-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1410781888-1952-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/hal-handsfree-client.c | 19 +++++++++++++++++++
 android/hal-msg.h              |  9 +++++++++
 android/handsfree-client.c     | 11 +++++++++++
 3 files changed, 39 insertions(+)

diff --git a/android/hal-handsfree-client.c b/android/hal-handsfree-client.c
index c52d0c4..9a73931 100644
--- a/android/hal-handsfree-client.c
+++ b/android/hal-handsfree-client.c
@@ -170,6 +170,24 @@ static bt_status_t stop_voice_recognition(void)
 				NULL);
 }
 
+static bt_status_t volume_control(bthf_client_volume_type_t type,
+								int volume)
+{
+	struct hal_cmd_hf_client_volume_control cmd;
+
+	DBG("");
+
+	if (!interface_ready())
+		return BT_STATUS_NOT_READY;
+
+	cmd.type = type;
+	cmd.volume = volume;
+
+	return hal_ipc_cmd(HAL_SERVICE_ID_HANDSFREE_CLIENT,
+				HAL_OP_HF_CLIENT_VOLUME_CONTROL, sizeof(cmd),
+				&cmd, NULL, NULL, NULL);
+}
+
 static void cleanup(void)
 {
 	struct hal_cmd_unregister_module cmd;
@@ -198,6 +216,7 @@ static bthf_client_interface_t iface = {
 	.disconnect_audio = disconnect_audio,
 	.start_voice_recognition = start_voice_recognition,
 	.stop_voice_recognition = stop_voice_recognition,
+	.volume_control = volume_control,
 	.cleanup = cleanup
 };
 
diff --git a/android/hal-msg.h b/android/hal-msg.h
index a97759c..72e0def 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -1001,6 +1001,15 @@ struct hal_cmd_hf_client_disconnect_audio {
 #define HAL_OP_HF_CLIENT_START_VR		0x05
 #define HAL_OP_HF_CLIENT_STOP_VR		0x06
 
+#define HF_CLIENT_VOLUME_TYPE_SPEAKER	0x00
+#define HF_CLIENT_VOLUME_TYPE_MIC	0x01
+
+#define HAL_OP_HF_CLIENT_VOLUME_CONTROL		0x07
+struct hal_cmd_hf_client_volume_control {
+	uint8_t type;
+	uint8_t volume;
+} __attribute__((packed));
+
 /* Notifications and confirmations */
 
 #define HAL_POWER_OFF			0x00
diff --git a/android/handsfree-client.c b/android/handsfree-client.c
index 921272f..f2394d0 100644
--- a/android/handsfree-client.c
+++ b/android/handsfree-client.c
@@ -87,6 +87,14 @@ static void handle_stop_vr(const void *buf, uint16_t len)
 			HAL_OP_HF_CLIENT_STOP_VR, HAL_STATUS_UNSUPPORTED);
 }
 
+static void handle_volume_control(const void *buf, uint16_t len)
+{
+	DBG("Not Implemented");
+	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_HANDSFREE_CLIENT,
+					HAL_OP_HF_CLIENT_VOLUME_CONTROL,
+					HAL_STATUS_UNSUPPORTED);
+}
+
 static const struct ipc_handler cmd_handlers[] = {
 	/* HAL_OP_HF_CLIENT_CONNECT */
 	{ handle_connect, false,
@@ -104,6 +112,9 @@ static const struct ipc_handler cmd_handlers[] = {
 	{ handle_start_vr, false, 0 },
 	/* define HAL_OP_HF_CLIENT_STOP_VR */
 	{ handle_stop_vr, false, 0 },
+	/* HAL_OP_HF_CLIENT_VOLUME_CONTROL */
+	{ handle_volume_control, false,
+			sizeof(struct hal_cmd_hf_client_volume_control) },
 };
 
 bool bt_hf_client_register(struct ipc *ipc, const bdaddr_t *addr)
-- 
1.8.4

