Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH v3 10/15] android/handsfree-client: Add Dial and Dial Memory command
Date: Mon, 15 Sep 2014 13:51:23 +0200
Message-Id: <1410781888-1952-11-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1410781888-1952-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1410781888-1952-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/hal-handsfree-client.c | 43 ++++++++++++++++++++++++++++++++++++++++++
 android/hal-msg.h              | 11 +++++++++++
 android/handsfree-client.c     | 19 +++++++++++++++++++
 3 files changed, 73 insertions(+)

diff --git a/android/hal-handsfree-client.c b/android/hal-handsfree-client.c
index 9a73931..23cbd53 100644
--- a/android/hal-handsfree-client.c
+++ b/android/hal-handsfree-client.c
@@ -188,6 +188,47 @@ static bt_status_t volume_control(bthf_client_volume_type_t type,
 				&cmd, NULL, NULL, NULL);
 }
 
+static bt_status_t dial(const char *number)
+{
+	char buf[IPC_MTU];
+	struct hal_cmd_hf_client_dial *cmd = (void *) buf;
+	size_t len;
+
+	DBG("");
+
+	if (!interface_ready())
+		return BT_STATUS_NOT_READY;
+
+	if (number) {
+		cmd->number_len = strlen(number) + 1;
+		memcpy(cmd->number, number, cmd->number_len);
+	} else {
+		cmd->number_len = 0;
+	}
+
+	len = sizeof(*cmd) + cmd->number_len;
+
+	return hal_ipc_cmd(HAL_SERVICE_ID_HANDSFREE_CLIENT,
+				HAL_OP_HF_CLIENT_DIAL, len, cmd, NULL, NULL,
+				NULL);
+}
+
+static bt_status_t dial_memory(int location)
+{
+	struct hal_cmd_hf_client_dial_memory cmd;
+
+	DBG("");
+
+	if (!interface_ready())
+		return BT_STATUS_NOT_READY;
+
+	cmd.location = location;
+
+	return hal_ipc_cmd(HAL_SERVICE_ID_HANDSFREE_CLIENT,
+					HAL_OP_HF_CLIENT_DIAL_MEMORY,
+					sizeof(cmd), &cmd, NULL, NULL, NULL);
+}
+
 static void cleanup(void)
 {
 	struct hal_cmd_unregister_module cmd;
@@ -217,6 +258,8 @@ static bthf_client_interface_t iface = {
 	.start_voice_recognition = start_voice_recognition,
 	.stop_voice_recognition = stop_voice_recognition,
 	.volume_control = volume_control,
+	.dial = dial,
+	.dial_memory = dial_memory,
 	.cleanup = cleanup
 };
 
diff --git a/android/hal-msg.h b/android/hal-msg.h
index 72e0def..1c57657 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -1010,6 +1010,17 @@ struct hal_cmd_hf_client_volume_control {
 	uint8_t volume;
 } __attribute__((packed));
 
+#define HAL_OP_HF_CLIENT_DIAL			0x08
+struct hal_cmd_hf_client_dial {
+	uint16_t number_len;
+	uint8_t number[0];
+} __attribute__((packed));
+
+#define HAL_OP_HF_CLIENT_DIAL_MEMORY		0x09
+struct hal_cmd_hf_client_dial_memory {
+	int32_t location;
+} __attribute__((packed));
+
 /* Notifications and confirmations */
 
 #define HAL_POWER_OFF			0x00
diff --git a/android/handsfree-client.c b/android/handsfree-client.c
index f2394d0..d51ba86 100644
--- a/android/handsfree-client.c
+++ b/android/handsfree-client.c
@@ -95,6 +95,20 @@ static void handle_volume_control(const void *buf, uint16_t len)
 					HAL_STATUS_UNSUPPORTED);
 }
 
+static void handle_dial(const void *buf, uint16_t len)
+{
+	DBG("Not Implemented");
+	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_HANDSFREE_CLIENT,
+				HAL_OP_HF_CLIENT_DIAL, HAL_STATUS_UNSUPPORTED);
+}
+
+static void handle_dial_memory(const void *buf, uint16_t len)
+{
+	DBG("Not Implemented");
+	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_HANDSFREE_CLIENT,
+			HAL_OP_HF_CLIENT_DIAL_MEMORY, HAL_STATUS_UNSUPPORTED);
+}
+
 static const struct ipc_handler cmd_handlers[] = {
 	/* HAL_OP_HF_CLIENT_CONNECT */
 	{ handle_connect, false,
@@ -115,6 +129,11 @@ static const struct ipc_handler cmd_handlers[] = {
 	/* HAL_OP_HF_CLIENT_VOLUME_CONTROL */
 	{ handle_volume_control, false,
 			sizeof(struct hal_cmd_hf_client_volume_control) },
+	/* HAL_OP_HF_CLIENT_DIAL */
+	{ handle_dial, true, sizeof(struct hal_cmd_hf_client_dial) },
+	/* HAL_OP_HF_CLIENT_DIAL_MEMORY */
+	{ handle_dial_memory, false,
+				sizeof(struct hal_cmd_hf_client_dial_memory) },
 };
 
 bool bt_hf_client_register(struct ipc *ipc, const bdaddr_t *addr)
-- 
1.8.4

