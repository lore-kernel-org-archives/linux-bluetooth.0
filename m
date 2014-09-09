Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH 13/39] android/hf-client: Add Command Action command
Date: Tue,  9 Sep 2014 21:56:58 +0200
Message-Id: <1410292644-23497-14-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1410292644-23497-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1410292644-23497-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/hal-hf-client.c | 18 ++++++++++++++++++
 android/hal-msg.h       | 19 +++++++++++++++++++
 android/hf-client.c     | 10 ++++++++++
 3 files changed, 47 insertions(+)

diff --git a/android/hal-hf-client.c b/android/hal-hf-client.c
index 1f8c85f..7766985 100644
--- a/android/hal-hf-client.c
+++ b/android/hal-hf-client.c
@@ -222,6 +222,23 @@ static bt_status_t dial_memory(int location)
 				&cmd, NULL, NULL, NULL);
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
+	return hal_ipc_cmd(HAL_SERVICE_ID_HF_CLIENT,
+					HAL_OP_HF_CLIENT_CALL_ACTION,
+					sizeof(cmd), &cmd, NULL, NULL, NULL);
+}
+
 static void cleanup(void)
 {
 	struct hal_cmd_unregister_module cmd;
@@ -253,6 +270,7 @@ static bthf_client_interface_t iface = {
 	.volume_control = volume_control,
 	.dial = dial,
 	.dial_memory = dial_memory,
+	.handle_call_action = call_action,
 	.cleanup = cleanup
 };
 
diff --git a/android/hal-msg.h b/android/hal-msg.h
index 5218b06..7cee365 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -1017,6 +1017,25 @@ struct hal_cmd_hf_client_dial_memory {
 	uint16_t location;
 } __attribute__((packed));
 
+#define HF_CLIENT_ACTION_CHLD_0		0x00
+#define HF_CLIENT_ACTION_CHLD_1		0x01
+#define HF_CLIENT_ACTION_CHLD_2		0x02
+#define HF_CLIENT_ACTION_CHLD_3		0x03
+#define HF_CLIENT_ACTION_CHLD_4		0x04
+#define HF_CLIENT_ACTION_CHLD_1x	0x05
+#define HF_CLIENT_ACTION_CHLD_2x	0x06
+#define HF_CLIENT_ACTION_ATA		0x07
+#define HF_CLIENT_ACTION_CHUP		0x08
+#define HF_CLIENT_ACTION_BRTH_0		0x09
+#define HF_CLIENT_ACTION_BRTH_1		0x10
+#define HF_CLIENT_ACTION_BRTH_02	0x11
+
+#define HAL_OP_HF_CLIENT_CALL_ACTION		0x10
+struct hal_cmd_hf_client_call_action {
+	uint8_t action;
+	uint8_t index;
+} __attribute__((packed));
+
 /* Notifications and confirmations */
 
 #define HAL_POWER_OFF			0x00
diff --git a/android/hf-client.c b/android/hf-client.c
index e1cb88d..66954b9 100644
--- a/android/hf-client.c
+++ b/android/hf-client.c
@@ -113,6 +113,13 @@ static void handle_dial_memory(const void *buf, uint16_t len)
 			HAL_OP_HF_CLIENT_DIAL_MEMORY, HAL_STATUS_UNSUPPORTED);
 }
 
+static void handle_call_action(const void *buf, uint16_t len)
+{
+	DBG("Not Implemented");
+	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_HF_CLIENT,
+			HAL_OP_HF_CLIENT_CALL_ACTION, HAL_STATUS_UNSUPPORTED);
+}
+
 static const struct ipc_handler cmd_handlers[] = {
 	/* HAL_OP_HF_CLIENT_CONNECT */
 	{ handle_connect, false,
@@ -138,6 +145,9 @@ static const struct ipc_handler cmd_handlers[] = {
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

