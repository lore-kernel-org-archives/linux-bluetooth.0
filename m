Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 14/16] android/hal-gatt: Implement client batchscan_enb_batch_scan
Date: Mon, 17 Nov 2014 23:28:06 +0100
Message-Id: <1416263288-30530-14-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1416263288-30530-1-git-send-email-szymon.janc@tieto.com>
References: <1416263288-30530-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This adds required IPC message, HAL implementation and daemon stub
handler.
---
 android/gatt.c     | 16 ++++++++++++++++
 android/hal-gatt.c | 16 +++++++++++++---
 android/hal-msg.h  | 10 ++++++++++
 3 files changed, 39 insertions(+), 3 deletions(-)

diff --git a/android/gatt.c b/android/gatt.c
index dcdcdb2..dbe749f 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -5701,6 +5701,19 @@ static void handle_client_configure_batchscan(const void *buf, uint16_t len)
 					HAL_STATUS_UNSUPPORTED);
 }
 
+static void handle_client_enable_batchscan(const void *buf, uint16_t len)
+{
+	const struct hal_cmd_gatt_client_enable_batchscan *cmd = buf;
+
+	DBG("client_if %d", cmd->client_if);
+
+	/* TODO */
+
+	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_GATT,
+					HAL_OP_GATT_CLIENT_ENABLE_BATCHSCAN,
+					HAL_STATUS_UNSUPPORTED);
+}
+
 static const struct ipc_handler cmd_handlers[] = {
 	/* HAL_OP_GATT_CLIENT_REGISTER */
 	{ handle_client_register, false,
@@ -5843,6 +5856,9 @@ static const struct ipc_handler cmd_handlers[] = {
 	/* HAL_OP_GATT_CLIENT_CONFIGURE_BATCHSCAN */
 	{ handle_client_configure_batchscan, false,
 		sizeof(struct hal_cmd_gatt_client_configure_batchscan) },
+	/* HAL_OP_GATT_CLIENT_ENABLE_BATCHSCAN */
+	{ handle_client_enable_batchscan, false,
+		sizeof(struct hal_cmd_gatt_client_enable_batchscan) },
 };
 
 static uint8_t read_by_group_type(const uint8_t *cmd, uint16_t cmd_len,
diff --git a/android/hal-gatt.c b/android/hal-gatt.c
index 9e58879..0fc89ac 100644
--- a/android/hal-gatt.c
+++ b/android/hal-gatt.c
@@ -1615,11 +1615,21 @@ static bt_status_t batchscan_enb_batch_scan(int client_if, int scan_mode,
 						int scan_window, int addr_type,
 						int discard_rule)
 {
-	DBG("");
+	struct hal_cmd_gatt_client_enable_batchscan cmd;
 
-	/* TODO */
+	if (!interface_ready())
+		return BT_STATUS_NOT_READY;
 
-	return BT_STATUS_UNSUPPORTED;
+	cmd.client_if = client_if;
+	cmd.mode = scan_mode;
+	cmd.interval = scan_interval;
+	cmd.window = scan_window;
+	cmd.address_type = addr_type;
+	cmd.discard_rule = discard_rule;
+
+	return hal_ipc_cmd(HAL_SERVICE_ID_GATT,
+					HAL_OP_GATT_CLIENT_ENABLE_BATCHSCAN,
+					sizeof(cmd), &cmd, NULL, NULL, NULL);
 }
 
 static bt_status_t batchscan_dis_batch_scan(int client_if)
diff --git a/android/hal-msg.h b/android/hal-msg.h
index bff6509..ca2cf9a 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -1142,6 +1142,16 @@ struct hal_cmd_gatt_client_configure_batchscan {
 	int32_t notify_threshold;
 } __attribute__((packed));
 
+#define HAL_OP_GATT_CLIENT_ENABLE_BATCHSCAN		0x30
+struct hal_cmd_gatt_client_enable_batchscan {
+	int32_t client_if;
+	int32_t mode;
+	int32_t interval;
+	int32_t window;
+	int32_t address_type;
+	int32_t discard_rule;
+} __attribute__((packed));
+
 /* Handsfree client HAL API */
 
 #define HAL_OP_HF_CLIENT_CONNECT		0x01
-- 
1.9.3

