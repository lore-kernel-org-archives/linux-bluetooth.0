Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH 09/39] android/hf-client: Add Audio Connect/Disconnect commands
Date: Tue,  9 Sep 2014 21:56:54 +0200
Message-Id: <1410292644-23497-10-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1410292644-23497-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1410292644-23497-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/hal-hf-client.c | 40 ++++++++++++++++++++++++++++++++++++++++
 android/hal-msg.h       | 10 ++++++++++
 android/hf-client.c     | 22 ++++++++++++++++++++++
 3 files changed, 72 insertions(+)

diff --git a/android/hal-hf-client.c b/android/hal-hf-client.c
index 5a31563..0ebd9d1 100644
--- a/android/hal-hf-client.c
+++ b/android/hal-hf-client.c
@@ -108,6 +108,44 @@ static bt_status_t disconnect(bt_bdaddr_t *bd_addr)
 						NULL);
 }
 
+static bt_status_t connect_audio(bt_bdaddr_t *bd_addr)
+{
+	struct hal_cmd_hf_client_connect_audio cmd;
+
+	DBG("");
+
+	if (!interface_ready())
+		return BT_STATUS_NOT_READY;
+
+	if (!bd_addr)
+		return BT_STATUS_PARM_INVALID;
+
+	memcpy(cmd.bdaddr, bd_addr, sizeof(cmd.bdaddr));
+
+	return hal_ipc_cmd(HAL_SERVICE_ID_HF_CLIENT,
+					HAL_OP_HF_CLIENT_CONNECT_AUDIO,
+					sizeof(cmd), &cmd, NULL, NULL, NULL);
+}
+
+static bt_status_t disconnect_audio(bt_bdaddr_t *bd_addr)
+{
+	struct hal_cmd_hf_client_disconnect_audio cmd;
+
+	DBG("");
+
+	if (!interface_ready())
+		return BT_STATUS_NOT_READY;
+
+	if (!bd_addr)
+		return BT_STATUS_PARM_INVALID;
+
+	memcpy(cmd.bdaddr, bd_addr, sizeof(cmd.bdaddr));
+
+	return hal_ipc_cmd(HAL_SERVICE_ID_HF_CLIENT,
+					HAL_OP_HF_CLIENT_DISCONNECT_AUDIO,
+					sizeof(cmd), &cmd, NULL, NULL, NULL);
+}
+
 static void cleanup(void)
 {
 	struct hal_cmd_unregister_module cmd;
@@ -132,6 +170,8 @@ static bthf_client_interface_t iface = {
 	.init = init,
 	.connect = hf_client_connect,
 	.disconnect = disconnect,
+	.connect_audio = connect_audio,
+	.disconnect_audio = disconnect_audio,
 	.cleanup = cleanup
 };
 
diff --git a/android/hal-msg.h b/android/hal-msg.h
index fa8beb9..42b0c1f 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -984,6 +984,16 @@ struct hal_cmd_hf_client_disconnect {
 	uint8_t bdaddr[6];
 } __attribute__((packed));
 
+#define HAL_OP_HF_CLIENT_CONNECT_AUDIO		0x03
+struct hal_cmd_hf_client_connect_audio {
+	uint8_t bdaddr[6];
+} __attribute__((packed));
+
+#define HAL_OP_HF_CLIENT_DISCONNECT_AUDIO	0x04
+struct hal_cmd_hf_client_disconnect_audio {
+	uint8_t bdaddr[6];
+} __attribute__((packed));
+
 /* Notifications and confirmations */
 
 #define HAL_POWER_OFF			0x00
diff --git a/android/hf-client.c b/android/hf-client.c
index d6c2ef6..d4fca21 100644
--- a/android/hf-client.c
+++ b/android/hf-client.c
@@ -59,6 +59,22 @@ static void handle_disconnect(const void *buf, uint16_t len)
 						HAL_STATUS_UNSUPPORTED);
 }
 
+static void handle_connect_audio(const void *buf, uint16_t len)
+{
+	DBG("Not Implemented");
+	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_HF_CLIENT,
+						HAL_OP_HF_CLIENT_CONNECT_AUDIO,
+						HAL_STATUS_UNSUPPORTED);
+}
+
+static void handle_disconnect_audio(const void *buf, uint16_t len)
+{
+	DBG("Not Implemented");
+	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_HF_CLIENT,
+					HAL_OP_HF_CLIENT_DISCONNECT_AUDIO,
+					HAL_STATUS_UNSUPPORTED);
+}
+
 static const struct ipc_handler cmd_handlers[] = {
 	/* HAL_OP_HF_CLIENT_CONNECT */
 	{ handle_connect, false,
@@ -66,6 +82,12 @@ static const struct ipc_handler cmd_handlers[] = {
 	/* HAL_OP_HF_CLIENT_DISCONNECT */
 	{ handle_disconnect, false,
 				sizeof(struct hal_cmd_hf_client_disconnect) },
+	/* HAL_OP_HF_CLIENT_CONNECT_AUDIO */
+	{ handle_connect_audio, false,
+			sizeof(struct hal_cmd_hf_client_connect_audio) },
+	/* HAL_OP_HF_CLIENT_DISCONNECT_AUDIO */
+	{ handle_disconnect_audio, false,
+			sizeof(struct hal_cmd_hf_client_disconnect_audio) },
 };
 
 bool bt_hf_client_register(struct ipc *ipc, const bdaddr_t *addr)
-- 
1.8.4

