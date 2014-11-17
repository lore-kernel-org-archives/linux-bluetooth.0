Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 13/16] android/hal-gatt: Implement client batchscan_cfg_storage
Date: Mon, 17 Nov 2014 23:28:05 +0100
Message-Id: <1416263288-30530-13-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1416263288-30530-1-git-send-email-szymon.janc@tieto.com>
References: <1416263288-30530-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This adds required IPC message, HAL implementation and daemon stub
handler.
---
 android/gatt.c     | 16 ++++++++++++++++
 android/hal-gatt.c | 14 +++++++++++---
 android/hal-msg.h  |  8 ++++++++
 3 files changed, 35 insertions(+), 3 deletions(-)

diff --git a/android/gatt.c b/android/gatt.c
index 5115762..dcdcdb2 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -5688,6 +5688,19 @@ static void handle_client_disable_multi_adv_inst(const void *buf, uint16_t len)
 				HAL_STATUS_UNSUPPORTED);
 }
 
+static void handle_client_configure_batchscan(const void *buf, uint16_t len)
+{
+	const struct hal_cmd_gatt_client_configure_batchscan *cmd = buf;
+
+	DBG("client_if %d", cmd->client_if);
+
+	/* TODO */
+
+	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_GATT,
+					HAL_OP_GATT_CLIENT_CONFIGURE_BATCHSCAN,
+					HAL_STATUS_UNSUPPORTED);
+}
+
 static const struct ipc_handler cmd_handlers[] = {
 	/* HAL_OP_GATT_CLIENT_REGISTER */
 	{ handle_client_register, false,
@@ -5827,6 +5840,9 @@ static const struct ipc_handler cmd_handlers[] = {
 	/* HAL_OP_GATT_CLIENT_DISABLE_MULTI_ADV_INST */
 	{ handle_client_disable_multi_adv_inst, false,
 		sizeof(struct hal_cmd_gatt_client_disable_multi_adv_inst) },
+	/* HAL_OP_GATT_CLIENT_CONFIGURE_BATCHSCAN */
+	{ handle_client_configure_batchscan, false,
+		sizeof(struct hal_cmd_gatt_client_configure_batchscan) },
 };
 
 static uint8_t read_by_group_type(const uint8_t *cmd, uint16_t cmd_len,
diff --git a/android/hal-gatt.c b/android/hal-gatt.c
index f248d33..9e58879 100644
--- a/android/hal-gatt.c
+++ b/android/hal-gatt.c
@@ -1595,11 +1595,19 @@ static bt_status_t batchscan_cfg_storage(int client_if, int batch_scan_full_max,
 						int batch_scan_trunc_max,
 						int batch_scan_notify_threshold)
 {
-	DBG("");
+	struct hal_cmd_gatt_client_configure_batchscan cmd;
 
-	/* TODO */
+	if (!interface_ready())
+		return BT_STATUS_NOT_READY;
 
-	return BT_STATUS_UNSUPPORTED;
+	cmd.client_if = client_if;
+	cmd.full_max = batch_scan_full_max;
+	cmd.trunc_max = batch_scan_trunc_max;
+	cmd.notify_threshold = batch_scan_notify_threshold;
+
+	return hal_ipc_cmd(HAL_SERVICE_ID_GATT,
+					HAL_OP_GATT_CLIENT_CONFIGURE_BATCHSCAN,
+					sizeof(cmd), &cmd, NULL, NULL, NULL);
 }
 
 static bt_status_t batchscan_enb_batch_scan(int client_if, int scan_mode,
diff --git a/android/hal-msg.h b/android/hal-msg.h
index 1d6f1e3..bff6509 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -1134,6 +1134,14 @@ struct hal_cmd_gatt_client_disable_multi_adv_inst {
 	int32_t client_if;
 } __attribute__((packed));
 
+#define HAL_OP_GATT_CLIENT_CONFIGURE_BATCHSCAN		0x2f
+struct hal_cmd_gatt_client_configure_batchscan {
+	int32_t client_if;
+	int32_t full_max;
+	int32_t trunc_max;
+	int32_t notify_threshold;
+} __attribute__((packed));
+
 /* Handsfree client HAL API */
 
 #define HAL_OP_HF_CLIENT_CONNECT		0x01
-- 
1.9.3

