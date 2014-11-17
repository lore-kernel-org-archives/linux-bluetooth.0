Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 07/16] android/hal-gatt: Implement client conn_parameter_update
Date: Mon, 17 Nov 2014 23:27:59 +0100
Message-Id: <1416263288-30530-7-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1416263288-30530-1-git-send-email-szymon.janc@tieto.com>
References: <1416263288-30530-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This adds required IPC message, HAL implementation and daemon stub
handler.
---
 android/gatt.c     | 21 +++++++++++++++++++++
 android/hal-gatt.c | 18 +++++++++++++++---
 android/hal-msg.h  |  9 +++++++++
 3 files changed, 45 insertions(+), 3 deletions(-)

diff --git a/android/gatt.c b/android/gatt.c
index 93859cf..6f3b4ee 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -5605,6 +5605,24 @@ static void handle_client_configure_mtu(const void *buf, uint16_t len)
 					HAL_STATUS_UNSUPPORTED);
 }
 
+static void handle_client_conn_param_update(const void *buf, uint16_t len)
+{
+	const struct hal_cmd_gatt_client_conn_param_update *cmd = buf;
+	char address[18];
+	bdaddr_t bdaddr;
+
+	android2bdaddr(cmd->address, &bdaddr);
+	ba2str(&bdaddr, address);
+
+	DBG("%s", address);
+
+	/* TODO */
+
+	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_GATT,
+					HAL_OP_GATT_CLIENT_CONN_PARAM_UPDATE,
+					HAL_STATUS_UNSUPPORTED);
+}
+
 static const struct ipc_handler cmd_handlers[] = {
 	/* HAL_OP_GATT_CLIENT_REGISTER */
 	{ handle_client_register, false,
@@ -5726,6 +5744,9 @@ static const struct ipc_handler cmd_handlers[] = {
 	/* HAL_OP_GATT_CLIENT_CONFIGURE_MTU */
 	{ handle_client_configure_mtu, false,
 		sizeof(struct hal_cmd_gatt_client_configure_mtu) },
+	/* HAL_OP_GATT_CLIENT_CONN_PARAM_UPDATE */
+	{ handle_client_conn_param_update, false,
+		sizeof(struct hal_cmd_gatt_client_conn_param_update) },
 };
 
 static uint8_t read_by_group_type(const uint8_t *cmd, uint16_t cmd_len,
diff --git a/android/hal-gatt.c b/android/hal-gatt.c
index f4a16bf..276268b 100644
--- a/android/hal-gatt.c
+++ b/android/hal-gatt.c
@@ -1431,11 +1431,23 @@ static bt_status_t conn_parameter_update(const bt_bdaddr_t *bd_addr,
 						int max_interval, int latency,
 						int timeout)
 {
-	DBG("");
+	struct hal_cmd_gatt_client_conn_param_update cmd;
 
-	/* TODO */
+	if (!interface_ready())
+		return BT_STATUS_NOT_READY;
 
-	return BT_STATUS_UNSUPPORTED;
+	if (!bd_addr)
+		return BT_STATUS_PARM_INVALID;
+
+	memcpy(cmd.address, bd_addr, sizeof(*bd_addr));
+	cmd.min_interval = min_interval;
+	cmd.max_interval = max_interval;
+	cmd.latency = latency;
+	cmd.timeout = timeout;
+
+	return hal_ipc_cmd(HAL_SERVICE_ID_GATT,
+					HAL_OP_GATT_CLIENT_CONN_PARAM_UPDATE,
+					sizeof(cmd), &cmd, NULL, NULL, NULL);
 }
 
 static bt_status_t set_scan_parameters(int scan_interval, int scan_window)
diff --git a/android/hal-msg.h b/android/hal-msg.h
index efdb9e1..8b62de2 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -1079,6 +1079,15 @@ struct hal_cmd_gatt_client_configure_mtu {
 	int32_t mtu;
 } __attribute__((packed));
 
+#define HAL_OP_GATT_CLIENT_CONN_PARAM_UPDATE		0x29
+struct hal_cmd_gatt_client_conn_param_update {
+	uint8_t address[6];
+	int32_t min_interval;
+	int32_t max_interval;
+	int32_t latency;
+	int32_t timeout;
+} __attribute__((packed));
+
 /* Handsfree client HAL API */
 
 #define HAL_OP_HF_CLIENT_CONNECT		0x01
-- 
1.9.3

