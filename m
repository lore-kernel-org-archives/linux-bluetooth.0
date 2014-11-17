Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 05/16] android/hal-gatt: Implement client scan_filter_enable
Date: Mon, 17 Nov 2014 23:27:57 +0100
Message-Id: <1416263288-30530-5-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1416263288-30530-1-git-send-email-szymon.janc@tieto.com>
References: <1416263288-30530-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This adds required IPC message, HAL implementation and daemon stub
handler
---
 android/gatt.c     | 16 ++++++++++++++++
 android/hal-gatt.c | 12 +++++++++---
 android/hal-msg.h  |  6 ++++++
 3 files changed, 31 insertions(+), 3 deletions(-)

diff --git a/android/gatt.c b/android/gatt.c
index 319841a..9db24e7 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -5579,6 +5579,19 @@ static void handle_client_scan_filter_clear(const void *buf, uint16_t len)
 					HAL_STATUS_UNSUPPORTED);
 }
 
+static void handle_client_scan_filter_enable(const void *buf, uint16_t len)
+{
+	const struct hal_cmd_gatt_client_scan_filter_enable *cmd = buf;
+
+	DBG("client_if %u", cmd->client_if);
+
+	/* TODO */
+
+	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_GATT,
+					HAL_OP_GATT_CLIENT_SCAN_FILTER_ENABLE,
+					HAL_STATUS_UNSUPPORTED);
+}
+
 static const struct ipc_handler cmd_handlers[] = {
 	/* HAL_OP_GATT_CLIENT_REGISTER */
 	{ handle_client_register, false,
@@ -5694,6 +5707,9 @@ static const struct ipc_handler cmd_handlers[] = {
 	/* HAL_OP_GATT_CLIENT_SCAN_FILTER_CLEAR */
 	{ handle_client_scan_filter_clear, false,
 		sizeof(struct hal_cmd_gatt_client_scan_filter_clear) },
+	/* HAL_OP_GATT_CLIENT_SCAN_FILTER_ENABLE */
+	{ handle_client_scan_filter_enable, false,
+		sizeof(struct hal_cmd_gatt_client_scan_filter_enable) },
 };
 
 static uint8_t read_by_group_type(const uint8_t *cmd, uint16_t cmd_len,
diff --git a/android/hal-gatt.c b/android/hal-gatt.c
index d82bbca..0d90608 100644
--- a/android/hal-gatt.c
+++ b/android/hal-gatt.c
@@ -1398,11 +1398,17 @@ static bt_status_t scan_filter_clear(int client_if, int filt_index)
 
 static bt_status_t scan_filter_enable(int client_if, bool enable)
 {
-	DBG("");
+	struct hal_cmd_gatt_client_scan_filter_enable cmd;
 
-	/* TODO */
+	if (!interface_ready())
+		return BT_STATUS_NOT_READY;
 
-	return BT_STATUS_UNSUPPORTED;
+	cmd.client_if = client_if;
+	cmd.enable = enable;
+
+	return hal_ipc_cmd(HAL_SERVICE_ID_GATT,
+					HAL_OP_GATT_CLIENT_SCAN_FILTER_ENABLE,
+					sizeof(cmd), &cmd, NULL, NULL, NULL);
 }
 
 static bt_status_t configure_mtu(int conn_id, int mtu)
diff --git a/android/hal-msg.h b/android/hal-msg.h
index c269843..def94a1 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -1067,6 +1067,12 @@ struct hal_cmd_gatt_client_scan_filter_clear {
 	int32_t index;
 } __attribute__((packed));
 
+#define HAL_OP_GATT_CLIENT_SCAN_FILTER_ENABLE		0x27
+struct hal_cmd_gatt_client_scan_filter_enable {
+	int32_t client_if;
+	uint8_t enable;
+} __attribute__((packed));
+
 /* Handsfree client HAL API */
 
 #define HAL_OP_HF_CLIENT_CONNECT		0x01
-- 
1.9.3

