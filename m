Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 04/16] android/hal-gatt: Implement client scan_filter_clear
Date: Mon, 17 Nov 2014 23:27:56 +0100
Message-Id: <1416263288-30530-4-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1416263288-30530-1-git-send-email-szymon.janc@tieto.com>
References: <1416263288-30530-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This adds required IPC message, HAL implementation and daemon stub
handler.
---
 android/gatt.c     | 16 ++++++++++++++++
 android/hal-gatt.c | 13 +++++++++----
 android/hal-msg.h  |  6 ++++++
 3 files changed, 31 insertions(+), 4 deletions(-)

diff --git a/android/gatt.c b/android/gatt.c
index f104a2c..319841a 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -5566,6 +5566,19 @@ static void handle_client_scan_filter_add_remove(const void *buf, uint16_t len)
 				HAL_STATUS_UNSUPPORTED);
 }
 
+static void handle_client_scan_filter_clear(const void *buf, uint16_t len)
+{
+	const struct hal_cmd_gatt_client_scan_filter_clear *cmd = buf;
+
+	DBG("client_if %u", cmd->client_if);
+
+	/* TODO */
+
+	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_GATT,
+					HAL_OP_GATT_CLIENT_SCAN_FILTER_CLEAR,
+					HAL_STATUS_UNSUPPORTED);
+}
+
 static const struct ipc_handler cmd_handlers[] = {
 	/* HAL_OP_GATT_CLIENT_REGISTER */
 	{ handle_client_register, false,
@@ -5678,6 +5691,9 @@ static const struct ipc_handler cmd_handlers[] = {
 	/* HAL_OP_GATT_CLIENT_SCAN_FILTER_ADD_REMOVE */
 	{ handle_client_scan_filter_add_remove, true,
 		sizeof(struct hal_cmd_gatt_client_scan_filter_add_remove) },
+	/* HAL_OP_GATT_CLIENT_SCAN_FILTER_CLEAR */
+	{ handle_client_scan_filter_clear, false,
+		sizeof(struct hal_cmd_gatt_client_scan_filter_clear) },
 };
 
 static uint8_t read_by_group_type(const uint8_t *cmd, uint16_t cmd_len,
diff --git a/android/hal-gatt.c b/android/hal-gatt.c
index 3291d47..d82bbca 100644
--- a/android/hal-gatt.c
+++ b/android/hal-gatt.c
@@ -1383,13 +1383,18 @@ static bt_status_t scan_filter_add_remove(int client_if, int action,
 
 static bt_status_t scan_filter_clear(int client_if, int filt_index)
 {
-	DBG("");
+	struct hal_cmd_gatt_client_scan_filter_clear cmd;
 
-	/* TODO */
+	if (!interface_ready())
+		return BT_STATUS_NOT_READY;
 
-	return BT_STATUS_UNSUPPORTED;
-}
+	cmd.client_if = client_if;
+	cmd.index = filt_index;
 
+	return hal_ipc_cmd(HAL_SERVICE_ID_GATT,
+					HAL_OP_GATT_CLIENT_SCAN_FILTER_CLEAR,
+					sizeof(cmd), &cmd, NULL, NULL, NULL);
+}
 
 static bt_status_t scan_filter_enable(int client_if, bool enable)
 {
diff --git a/android/hal-msg.h b/android/hal-msg.h
index 94d0069..c269843 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -1061,6 +1061,12 @@ struct hal_cmd_gatt_client_scan_filter_add_remove {
 	uint8_t data_mask[0];
 } __attribute__((packed));
 
+#define HAL_OP_GATT_CLIENT_SCAN_FILTER_CLEAR		0x26
+struct hal_cmd_gatt_client_scan_filter_clear {
+	int32_t client_if;
+	int32_t index;
+} __attribute__((packed));
+
 /* Handsfree client HAL API */
 
 #define HAL_OP_HF_CLIENT_CONNECT		0x01
-- 
1.9.3

