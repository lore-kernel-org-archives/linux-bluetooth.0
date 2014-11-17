Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 08/16] android/hal-gatt: Implement client set_scan_parameters
Date: Mon, 17 Nov 2014 23:28:00 +0100
Message-Id: <1416263288-30530-8-git-send-email-szymon.janc@tieto.com>
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
index 6f3b4ee..77f6dc7 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -5623,6 +5623,19 @@ static void handle_client_conn_param_update(const void *buf, uint16_t len)
 					HAL_STATUS_UNSUPPORTED);
 }
 
+static void handle_client_set_scan_param(const void *buf, uint16_t len)
+{
+	const struct hal_cmd_gatt_client_set_scan_param *cmd = buf;
+
+	DBG("interval %d window %d", cmd->interval, cmd->window);
+
+	/* TODO */
+
+	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_GATT,
+					HAL_OP_GATT_CLIENT_SET_SCAN_PARAM,
+					HAL_STATUS_UNSUPPORTED);
+}
+
 static const struct ipc_handler cmd_handlers[] = {
 	/* HAL_OP_GATT_CLIENT_REGISTER */
 	{ handle_client_register, false,
@@ -5747,6 +5760,9 @@ static const struct ipc_handler cmd_handlers[] = {
 	/* HAL_OP_GATT_CLIENT_CONN_PARAM_UPDATE */
 	{ handle_client_conn_param_update, false,
 		sizeof(struct hal_cmd_gatt_client_conn_param_update) },
+	/* HAL_OP_GATT_CLIENT_SET_SCAN_PARAM */
+	{ handle_client_set_scan_param, false,
+		sizeof(struct hal_cmd_gatt_client_set_scan_param) },
 };
 
 static uint8_t read_by_group_type(const uint8_t *cmd, uint16_t cmd_len,
diff --git a/android/hal-gatt.c b/android/hal-gatt.c
index 276268b..78ac8f0 100644
--- a/android/hal-gatt.c
+++ b/android/hal-gatt.c
@@ -1452,11 +1452,17 @@ static bt_status_t conn_parameter_update(const bt_bdaddr_t *bd_addr,
 
 static bt_status_t set_scan_parameters(int scan_interval, int scan_window)
 {
-	DBG("");
+	struct hal_cmd_gatt_client_set_scan_param cmd;
 
-	/* TODO */
+	if (!interface_ready())
+		return BT_STATUS_NOT_READY;
 
-	return BT_STATUS_UNSUPPORTED;
+	cmd.interval = scan_interval;
+	cmd.window = scan_window;
+
+	return hal_ipc_cmd(HAL_SERVICE_ID_GATT,
+					HAL_OP_GATT_CLIENT_SET_SCAN_PARAM,
+					sizeof(cmd), &cmd, NULL, NULL, NULL);
 }
 
 static bt_status_t multi_adv_enable(int client_if, int min_interval,
diff --git a/android/hal-msg.h b/android/hal-msg.h
index 8b62de2..8f81274 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -1088,6 +1088,12 @@ struct hal_cmd_gatt_client_conn_param_update {
 	int32_t timeout;
 } __attribute__((packed));
 
+#define HAL_OP_GATT_CLIENT_SET_SCAN_PARAM		0x2a
+struct hal_cmd_gatt_client_set_scan_param {
+	int32_t interval;
+	int32_t window;
+} __attribute__((packed));
+
 /* Handsfree client HAL API */
 
 #define HAL_OP_HF_CLIENT_CONNECT		0x01
-- 
1.9.3

