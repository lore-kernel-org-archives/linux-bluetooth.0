Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 02/16] android/hal-gatt: Implement client scan_filter_param_setup
Date: Mon, 17 Nov 2014 23:27:54 +0100
Message-Id: <1416263288-30530-2-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1416263288-30530-1-git-send-email-szymon.janc@tieto.com>
References: <1416263288-30530-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This adds required IPC message, HAL implementation and daemon stub
handler.
---
 android/gatt.c     | 16 ++++++++++++++++
 android/hal-gatt.c | 22 +++++++++++++++++++---
 android/hal-msg.h  | 16 ++++++++++++++++
 3 files changed, 51 insertions(+), 3 deletions(-)

diff --git a/android/gatt.c b/android/gatt.c
index 5169468..a441e4f 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -5540,6 +5540,19 @@ reply:
 			HAL_OP_GATT_SERVER_SEND_RESPONSE, status);
 }
 
+static void handle_client_scan_filter_setup(const void *buf, uint16_t len)
+{
+	const struct hal_cmd_gatt_client_scan_filter_setup *cmd = buf;
+
+	DBG("client_if %u", cmd->client_if);
+
+	/* TODO */
+
+	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_GATT,
+					HAL_OP_GATT_CLIENT_SCAN_FILTER_SETUP,
+					HAL_STATUS_UNSUPPORTED);
+}
+
 static const struct ipc_handler cmd_handlers[] = {
 	/* HAL_OP_GATT_CLIENT_REGISTER */
 	{ handle_client_register, false,
@@ -5646,6 +5659,9 @@ static const struct ipc_handler cmd_handlers[] = {
 	/* HAL_OP_GATT_SERVER_SEND_RESPONSE */
 	{ handle_server_send_response, true,
 		sizeof(struct hal_cmd_gatt_server_send_response) },
+	/* HAL_OP_GATT_CLIENT_SCAN_FILTER_SETUP */
+	{ handle_client_scan_filter_setup, false,
+		sizeof(struct hal_cmd_gatt_client_scan_filter_setup) },
 };
 
 static uint8_t read_by_group_type(const uint8_t *cmd, uint16_t cmd_len,
diff --git a/android/hal-gatt.c b/android/hal-gatt.c
index 15ab357..f4c3d31 100644
--- a/android/hal-gatt.c
+++ b/android/hal-gatt.c
@@ -1311,11 +1311,27 @@ static bt_status_t scan_filter_param_setup(int client_if, int action,
 						int lost_timeout,
 						int found_timeout_cnt)
 {
-	DBG("");
+	struct hal_cmd_gatt_client_scan_filter_setup cmd;
 
-	/* TODO */
+	if (!interface_ready())
+		return BT_STATUS_NOT_READY;
 
-	return BT_STATUS_UNSUPPORTED;
+	cmd.client_if = client_if;
+	cmd.action = action;
+	cmd.filter_index = filt_index;
+	cmd.features = feat_seln;
+	cmd.list_type = list_logic_type;
+	cmd.filter_type = filt_logic_type;
+	cmd.rssi_hi = rssi_high_thres;
+	cmd.rssi_lo = rssi_low_thres;
+	cmd.delivery_mode = dely_mode;
+	cmd.found_timeout = found_timeout;
+	cmd.lost_timeout = lost_timeout;
+	cmd.found_timeout_cnt = found_timeout_cnt;
+
+	return hal_ipc_cmd(HAL_SERVICE_ID_GATT,
+					HAL_OP_GATT_CLIENT_SCAN_FILTER_SETUP,
+					sizeof(cmd), &cmd, NULL, NULL, NULL);
 }
 
 static bt_status_t scan_filter_add_remove(int client_if, int action,
diff --git a/android/hal-msg.h b/android/hal-msg.h
index 438fa7b..c74c76b 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -1028,6 +1028,22 @@ struct hal_cmd_gatt_server_send_response {
 	uint8_t data[0];
 } __attribute__((packed));
 
+#define HAL_OP_GATT_CLIENT_SCAN_FILTER_SETUP	0x024
+struct hal_cmd_gatt_client_scan_filter_setup {
+	int32_t client_if;
+	int32_t action;
+	int32_t filter_index;
+	int32_t features;
+	int32_t list_type;
+	int32_t filter_type;
+	int32_t rssi_hi;
+	int32_t rssi_lo;
+	int32_t delivery_mode;
+	int32_t found_timeout;
+	int32_t lost_timeout;
+	int32_t found_timeout_cnt;
+} __attribute__((packed));
+
 /* Handsfree client HAL API */
 
 #define HAL_OP_HF_CLIENT_CONNECT		0x01
-- 
1.9.3

