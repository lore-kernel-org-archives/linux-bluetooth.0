Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 06/16] android/hal-gatt: Implement client configure_mtu
Date: Mon, 17 Nov 2014 23:27:58 +0100
Message-Id: <1416263288-30530-6-git-send-email-szymon.janc@tieto.com>
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
index 9db24e7..93859cf 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -5592,6 +5592,19 @@ static void handle_client_scan_filter_enable(const void *buf, uint16_t len)
 					HAL_STATUS_UNSUPPORTED);
 }
 
+static void handle_client_configure_mtu(const void *buf, uint16_t len)
+{
+	const struct hal_cmd_gatt_client_configure_mtu *cmd = buf;
+
+	DBG("conn_id %u", cmd->conn_id);
+
+	/* TODO */
+
+	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_GATT,
+					HAL_OP_GATT_CLIENT_CONFIGURE_MTU,
+					HAL_STATUS_UNSUPPORTED);
+}
+
 static const struct ipc_handler cmd_handlers[] = {
 	/* HAL_OP_GATT_CLIENT_REGISTER */
 	{ handle_client_register, false,
@@ -5710,6 +5723,9 @@ static const struct ipc_handler cmd_handlers[] = {
 	/* HAL_OP_GATT_CLIENT_SCAN_FILTER_ENABLE */
 	{ handle_client_scan_filter_enable, false,
 		sizeof(struct hal_cmd_gatt_client_scan_filter_enable) },
+	/* HAL_OP_GATT_CLIENT_CONFIGURE_MTU */
+	{ handle_client_configure_mtu, false,
+		sizeof(struct hal_cmd_gatt_client_configure_mtu) },
 };
 
 static uint8_t read_by_group_type(const uint8_t *cmd, uint16_t cmd_len,
diff --git a/android/hal-gatt.c b/android/hal-gatt.c
index 0d90608..f4a16bf 100644
--- a/android/hal-gatt.c
+++ b/android/hal-gatt.c
@@ -1413,11 +1413,17 @@ static bt_status_t scan_filter_enable(int client_if, bool enable)
 
 static bt_status_t configure_mtu(int conn_id, int mtu)
 {
-	DBG("");
+	struct hal_cmd_gatt_client_configure_mtu cmd;
 
-	/* TODO */
+	if (!interface_ready())
+		return BT_STATUS_NOT_READY;
 
-	return BT_STATUS_UNSUPPORTED;
+	cmd.conn_id = conn_id;
+	cmd.mtu = mtu;
+
+	return hal_ipc_cmd(HAL_SERVICE_ID_GATT,
+					HAL_OP_GATT_CLIENT_CONFIGURE_MTU,
+					sizeof(cmd), &cmd, NULL, NULL, NULL);
 }
 
 static bt_status_t conn_parameter_update(const bt_bdaddr_t *bd_addr,
diff --git a/android/hal-msg.h b/android/hal-msg.h
index def94a1..efdb9e1 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -1073,6 +1073,12 @@ struct hal_cmd_gatt_client_scan_filter_enable {
 	uint8_t enable;
 } __attribute__((packed));
 
+#define HAL_OP_GATT_CLIENT_CONFIGURE_MTU		0x28
+struct hal_cmd_gatt_client_configure_mtu {
+	int32_t conn_id;
+	int32_t mtu;
+} __attribute__((packed));
+
 /* Handsfree client HAL API */
 
 #define HAL_OP_HF_CLIENT_CONNECT		0x01
-- 
1.9.3

