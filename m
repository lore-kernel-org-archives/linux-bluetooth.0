Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH v3 11/15] android/handsfree-client: Add Call Action command
Date: Mon, 15 Sep 2014 13:51:24 +0200
Message-Id: <1410781888-1952-12-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1410781888-1952-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1410781888-1952-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/hal-handsfree-client.c | 18 ++++++++++++++++++
 android/hal-msg.h              | 19 +++++++++++++++++++
 android/handsfree-client.c     | 10 ++++++++++
 3 files changed, 47 insertions(+)

diff --git a/android/hal-handsfree-client.c b/android/hal-handsfree-client.c
index 23cbd53..35929c5 100644
--- a/android/hal-handsfree-client.c
+++ b/android/hal-handsfree-client.c
@@ -229,6 +229,23 @@ static bt_status_t dial_memory(int location)
 					sizeof(cmd), &cmd, NULL, NULL, NULL);
 }
 
+static bt_status_t call_action(bthf_client_call_action_t action, int index)
+{
+	struct hal_cmd_hf_client_call_action cmd;
+
+	DBG("");
+
+	if (!interface_ready())
+		return BT_STATUS_NOT_READY;
+
+	cmd.action = action;
+	cmd.index = index;
+
+	return hal_ipc_cmd(HAL_SERVICE_ID_HANDSFREE_CLIENT,
+				HAL_OP_HF_CLIENT_CALL_ACTION, sizeof(cmd), &cmd,
+				NULL, NULL, NULL);
+}
+
 static void cleanup(void)
 {
 	struct hal_cmd_unregister_module cmd;
@@ -260,6 +277,7 @@ static bthf_client_interface_t iface = {
 	.volume_control = volume_control,
 	.dial = dial,
 	.dial_memory = dial_memory,
+	.handle_call_action = call_action,
 	.cleanup = cleanup
 };
 
diff --git a/android/hal-msg.h b/android/hal-msg.h
index 1c57657..dc563e4 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -1021,6 +1021,25 @@ struct hal_cmd_hf_client_dial_memory {
 	int32_t location;
 } __attribute__((packed));
 
+#define HAL_HF_CLIENT_ACTION_CHLD_0		0x00
+#define HAL_HF_CLIENT_ACTION_CHLD_1		0x01
+#define HAL_HF_CLIENT_ACTION_CHLD_2		0x02
+#define HAL_HF_CLIENT_ACTION_CHLD_3		0x03
+#define HAL_HF_CLIENT_ACTION_CHLD_4		0x04
+#define HAL_HF_CLIENT_ACTION_CHLD_1x	0x05
+#define HAL_HF_CLIENT_ACTION_CHLD_2x	0x06
+#define HAL_HF_CLIENT_ACTION_ATA		0x07
+#define HAL_HF_CLIENT_ACTION_CHUP		0x08
+#define HAL_HF_CLIENT_ACTION_BRTH_0		0x09
+#define HAL_HF_CLIENT_ACTION_BRTH_1		0x10
+#define HAL_HF_CLIENT_ACTION_BRTH_02	0x11
+
+#define HAL_OP_HF_CLIENT_CALL_ACTION		0x0a
+struct hal_cmd_hf_client_call_action {
+	uint8_t action;
+	uint8_t index;
+} __attribute__((packed));
+
 /* Notifications and confirmations */
 
 #define HAL_POWER_OFF			0x00
diff --git a/android/handsfree-client.c b/android/handsfree-client.c
index d51ba86..6319b85 100644
--- a/android/handsfree-client.c
+++ b/android/handsfree-client.c
@@ -109,6 +109,13 @@ static void handle_dial_memory(const void *buf, uint16_t len)
 			HAL_OP_HF_CLIENT_DIAL_MEMORY, HAL_STATUS_UNSUPPORTED);
 }
 
+static void handle_call_action(const void *buf, uint16_t len)
+{
+	DBG("Not Implemented");
+	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_HANDSFREE_CLIENT,
+			HAL_OP_HF_CLIENT_CALL_ACTION, HAL_STATUS_UNSUPPORTED);
+}
+
 static const struct ipc_handler cmd_handlers[] = {
 	/* HAL_OP_HF_CLIENT_CONNECT */
 	{ handle_connect, false,
@@ -134,6 +141,9 @@ static const struct ipc_handler cmd_handlers[] = {
 	/* HAL_OP_HF_CLIENT_DIAL_MEMORY */
 	{ handle_dial_memory, false,
 				sizeof(struct hal_cmd_hf_client_dial_memory) },
+	/* HAL_OP_HF_CLIENT_CALL_ACTION */
+	{ handle_call_action, false,
+				sizeof(struct hal_cmd_hf_client_call_action) },
 };
 
 bool bt_hf_client_register(struct ipc *ipc, const bdaddr_t *addr)
-- 
1.8.4

