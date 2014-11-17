Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 16/16] android/hal-gatt: Implement client batchscan_read_reports
Date: Mon, 17 Nov 2014 23:28:08 +0100
Message-Id: <1416263288-30530-16-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1416263288-30530-1-git-send-email-szymon.janc@tieto.com>
References: <1416263288-30530-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This adds required IPC message, HAL implementation and daemon stub
handler.
---
 android/gatt.c     | 16 ++++++++++++++++
 android/hal-gatt.c | 12 +++++++++---
 android/hal-msg.h  |  6 ++++++
 3 files changed, 31 insertions(+), 3 deletions(-)

diff --git a/android/gatt.c b/android/gatt.c
index 24b2af1..71eab14 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -5727,6 +5727,19 @@ static void handle_client_disable_batchscan(const void *buf, uint16_t len)
 					HAL_STATUS_UNSUPPORTED);
 }
 
+static void handle_client_read_batchscan_reports(const void *buf, uint16_t len)
+{
+	const struct hal_cmd_gatt_client_read_batchscan_reports *cmd = buf;
+
+	DBG("client_if %d", cmd->client_if);
+
+	/* TODO */
+
+	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_GATT,
+				HAL_OP_GATT_CLIENT_READ_BATCHSCAN_REPORTS,
+				HAL_STATUS_UNSUPPORTED);
+}
+
 static const struct ipc_handler cmd_handlers[] = {
 	/* HAL_OP_GATT_CLIENT_REGISTER */
 	{ handle_client_register, false,
@@ -5875,6 +5888,9 @@ static const struct ipc_handler cmd_handlers[] = {
 	/* HAL_OP_GATT_CLIENT_DISABLE_BATCHSCAN */
 	{ handle_client_disable_batchscan, false,
 		sizeof(struct hal_cmd_gatt_client_disable_batchscan) },
+	/* HAL_OP_GATT_CLIENT_READ_BATCHSCAN_REPORTS */
+	{ handle_client_read_batchscan_reports, false,
+		sizeof(struct hal_cmd_gatt_client_read_batchscan_reports) },
 };
 
 static uint8_t read_by_group_type(const uint8_t *cmd, uint16_t cmd_len,
diff --git a/android/hal-gatt.c b/android/hal-gatt.c
index a97095f..4dd40cd 100644
--- a/android/hal-gatt.c
+++ b/android/hal-gatt.c
@@ -1648,11 +1648,17 @@ static bt_status_t batchscan_dis_batch_scan(int client_if)
 
 static bt_status_t batchscan_read_reports(int client_if, int scan_mode)
 {
-	DBG("");
+	struct hal_cmd_gatt_client_read_batchscan_reports cmd;
 
-	/* TODO */
+	if (!interface_ready())
+		return BT_STATUS_NOT_READY;
 
-	return BT_STATUS_UNSUPPORTED;
+	cmd.client_if = client_if;
+	cmd.scan_mode = scan_mode;
+
+	return hal_ipc_cmd(HAL_SERVICE_ID_GATT,
+				HAL_OP_GATT_CLIENT_READ_BATCHSCAN_REPORTS,
+				sizeof(cmd), &cmd, NULL, NULL, NULL);
 }
 #endif
 
diff --git a/android/hal-msg.h b/android/hal-msg.h
index 696972a..ecb7255 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -1157,6 +1157,12 @@ struct hal_cmd_gatt_client_disable_batchscan {
 	int32_t client_if;
 } __attribute__((packed));
 
+#define HAL_OP_GATT_CLIENT_READ_BATCHSCAN_REPORTS	0x32
+struct hal_cmd_gatt_client_read_batchscan_reports {
+	int32_t client_if;
+	int32_t scan_mode;
+} __attribute__((packed));
+
 /* Handsfree client HAL API */
 
 #define HAL_OP_HF_CLIENT_CONNECT		0x01
-- 
1.9.3

