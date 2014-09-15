Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH v3 07/15] android/handsfree-client: Add Audio Connect/Disconnect commands
Date: Mon, 15 Sep 2014 13:51:20 +0200
Message-Id: <1410781888-1952-8-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1410781888-1952-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1410781888-1952-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/hal-handsfree-client.c | 40 ++++++++++++++++++++++++++++++++++++++++
 android/hal-msg.h              | 10 ++++++++++
 android/handsfree-client.c     | 21 +++++++++++++++++++++
 3 files changed, 71 insertions(+)

diff --git a/android/hal-handsfree-client.c b/android/hal-handsfree-client.c
index 441d2b4..22a7fd6 100644
--- a/android/hal-handsfree-client.c
+++ b/android/hal-handsfree-client.c
@@ -108,6 +108,44 @@ static bt_status_t disconnect(bt_bdaddr_t *bd_addr)
 				NULL, NULL, NULL);
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
+	return hal_ipc_cmd(HAL_SERVICE_ID_HANDSFREE_CLIENT,
+				HAL_OP_HF_CLIENT_CONNECT_AUDIO, sizeof(cmd),
+				&cmd, NULL, NULL, NULL);
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
+	return hal_ipc_cmd(HAL_SERVICE_ID_HANDSFREE_CLIENT,
+				HAL_OP_HF_CLIENT_DISCONNECT_AUDIO, sizeof(cmd),
+				&cmd, NULL, NULL, NULL);
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
index 02cc798..afb7836 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -988,6 +988,16 @@ struct hal_cmd_hf_client_disconnect {
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
diff --git a/android/handsfree-client.c b/android/handsfree-client.c
index f43829a..a65868e 100644
--- a/android/handsfree-client.c
+++ b/android/handsfree-client.c
@@ -58,6 +58,21 @@ static void handle_disconnect(const void *buf, uint16_t len)
 			HAL_OP_HF_CLIENT_DISCONNECT, HAL_STATUS_UNSUPPORTED);
 }
 
+static void handle_connect_audio(const void *buf, uint16_t len)
+{
+	DBG("Not Implemented");
+	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_HANDSFREE_CLIENT,
+			HAL_OP_HF_CLIENT_CONNECT_AUDIO, HAL_STATUS_UNSUPPORTED);
+}
+
+static void handle_disconnect_audio(const void *buf, uint16_t len)
+{
+	DBG("Not Implemented");
+	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_HANDSFREE_CLIENT,
+					HAL_OP_HF_CLIENT_DISCONNECT_AUDIO,
+					HAL_STATUS_UNSUPPORTED);
+}
+
 static const struct ipc_handler cmd_handlers[] = {
 	/* HAL_OP_HF_CLIENT_CONNECT */
 	{ handle_connect, false,
@@ -65,6 +80,12 @@ static const struct ipc_handler cmd_handlers[] = {
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

