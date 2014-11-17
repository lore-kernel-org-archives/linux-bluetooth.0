Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 09/16] android/hal-gatt: Implement client multi_adv_enable
Date: Mon, 17 Nov 2014 23:28:01 +0100
Message-Id: <1416263288-30530-9-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1416263288-30530-1-git-send-email-szymon.janc@tieto.com>
References: <1416263288-30530-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This adds required IPC message, HAL implementation and daemon stub
handler.
---
 android/gatt.c     | 16 ++++++++++++++++
 android/hal-gatt.c | 17 ++++++++++++++---
 android/hal-msg.h  | 11 +++++++++++
 3 files changed, 41 insertions(+), 3 deletions(-)

diff --git a/android/gatt.c b/android/gatt.c
index 77f6dc7..6144a55 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -5636,6 +5636,19 @@ static void handle_client_set_scan_param(const void *buf, uint16_t len)
 					HAL_STATUS_UNSUPPORTED);
 }
 
+static void handle_client_setup_multi_adv(const void *buf, uint16_t len)
+{
+	const struct hal_cmd_gatt_client_setup_multi_adv *cmd = buf;
+
+	DBG("client_if %d", cmd->client_if);
+
+	/* TODO */
+
+	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_GATT,
+					HAL_OP_GATT_CLIENT_SETUP_MULTI_ADV,
+					HAL_STATUS_UNSUPPORTED);
+}
+
 static const struct ipc_handler cmd_handlers[] = {
 	/* HAL_OP_GATT_CLIENT_REGISTER */
 	{ handle_client_register, false,
@@ -5763,6 +5776,9 @@ static const struct ipc_handler cmd_handlers[] = {
 	/* HAL_OP_GATT_CLIENT_SET_SCAN_PARAM */
 	{ handle_client_set_scan_param, false,
 		sizeof(struct hal_cmd_gatt_client_set_scan_param) },
+	/* HAL_OP_GATT_CLIENT_SETUP_MULTI_ADV */
+	{ handle_client_setup_multi_adv, false,
+		sizeof(struct hal_cmd_gatt_client_setup_multi_adv) },
 };
 
 static uint8_t read_by_group_type(const uint8_t *cmd, uint16_t cmd_len,
diff --git a/android/hal-gatt.c b/android/hal-gatt.c
index 78ac8f0..2692e9c 100644
--- a/android/hal-gatt.c
+++ b/android/hal-gatt.c
@@ -1470,11 +1470,22 @@ static bt_status_t multi_adv_enable(int client_if, int min_interval,
 					int chnl_map, int tx_power,
 					int timeout_s)
 {
-	DBG("");
+	struct hal_cmd_gatt_client_setup_multi_adv cmd;
 
-	/* TODO */
+	if (!interface_ready())
+		return BT_STATUS_NOT_READY;
 
-	return BT_STATUS_UNSUPPORTED;
+	cmd.client_if = client_if;
+	cmd.min_interval = min_interval;
+	cmd.max_interval = max_interval;
+	cmd.type = adv_type;
+	cmd.channel_map = chnl_map;
+	cmd.tx_power = tx_power;
+	cmd.timeout = timeout_s;
+
+	return hal_ipc_cmd(HAL_SERVICE_ID_GATT,
+					HAL_OP_GATT_CLIENT_SETUP_MULTI_ADV,
+					sizeof(cmd), &cmd, NULL, NULL, NULL);
 }
 
 static bt_status_t multi_adv_update(int client_if, int min_interval,
diff --git a/android/hal-msg.h b/android/hal-msg.h
index 8f81274..e59a322 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -1094,6 +1094,17 @@ struct hal_cmd_gatt_client_set_scan_param {
 	int32_t window;
 } __attribute__((packed));
 
+#define HAL_OP_GATT_CLIENT_SETUP_MULTI_ADV		0x2b
+struct hal_cmd_gatt_client_setup_multi_adv {
+	int32_t client_if;
+	int32_t min_interval;
+	int32_t max_interval;
+	int32_t type;
+	int32_t channel_map;
+	int32_t tx_power;
+	int32_t timeout;
+} __attribute__((packed));
+
 /* Handsfree client HAL API */
 
 #define HAL_OP_HF_CLIENT_CONNECT		0x01
-- 
1.9.3

