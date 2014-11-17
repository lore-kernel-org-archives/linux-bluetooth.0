Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 12/16] android/hal-gatt: Implement client multi_adv_disable
Date: Mon, 17 Nov 2014 23:28:04 +0100
Message-Id: <1416263288-30530-12-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1416263288-30530-1-git-send-email-szymon.janc@tieto.com>
References: <1416263288-30530-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This adds required IPC message, HAL implementation and daemon stub
handler.
---
 android/gatt.c     | 16 ++++++++++++++++
 android/hal-gatt.c | 11 ++++++++---
 android/hal-msg.h  |  5 +++++
 3 files changed, 29 insertions(+), 3 deletions(-)

diff --git a/android/gatt.c b/android/gatt.c
index 1ba06f7..5115762 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -5675,6 +5675,19 @@ static void handle_client_setup_multi_adv_inst(const void *buf, uint16_t len)
 					HAL_STATUS_UNSUPPORTED);
 }
 
+static void handle_client_disable_multi_adv_inst(const void *buf, uint16_t len)
+{
+	const struct hal_cmd_gatt_client_disable_multi_adv_inst *cmd = buf;
+
+	DBG("client_if %d", cmd->client_if);
+
+	/* TODO */
+
+	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_GATT,
+				HAL_OP_GATT_CLIENT_DISABLE_MULTI_ADV_INST,
+				HAL_STATUS_UNSUPPORTED);
+}
+
 static const struct ipc_handler cmd_handlers[] = {
 	/* HAL_OP_GATT_CLIENT_REGISTER */
 	{ handle_client_register, false,
@@ -5811,6 +5824,9 @@ static const struct ipc_handler cmd_handlers[] = {
 	/* HAL_OP_GATT_CLIENT_SETUP_MULTI_ADV_INST */
 	{ handle_client_setup_multi_adv_inst, false,
 		sizeof(struct hal_cmd_gatt_client_setup_multi_adv_inst) },
+	/* HAL_OP_GATT_CLIENT_DISABLE_MULTI_ADV_INST */
+	{ handle_client_disable_multi_adv_inst, false,
+		sizeof(struct hal_cmd_gatt_client_disable_multi_adv_inst) },
 };
 
 static uint8_t read_by_group_type(const uint8_t *cmd, uint16_t cmd_len,
diff --git a/android/hal-gatt.c b/android/hal-gatt.c
index bf1e3e7..f248d33 100644
--- a/android/hal-gatt.c
+++ b/android/hal-gatt.c
@@ -1579,11 +1579,16 @@ static bt_status_t multi_adv_set_inst_data(int client_if, bool set_scan_rsp,
 
 static bt_status_t multi_adv_disable(int client_if)
 {
-	DBG("");
+	struct hal_cmd_gatt_client_disable_multi_adv_inst cmd;
 
-	/* TODO */
+	if (!interface_ready())
+		return BT_STATUS_NOT_READY;
 
-	return BT_STATUS_UNSUPPORTED;
+	cmd.client_if = client_if;
+
+	return hal_ipc_cmd(HAL_SERVICE_ID_GATT,
+				HAL_OP_GATT_CLIENT_DISABLE_MULTI_ADV_INST,
+				sizeof(cmd), &cmd, NULL, NULL, NULL);
 }
 
 static bt_status_t batchscan_cfg_storage(int client_if, int batch_scan_full_max,
diff --git a/android/hal-msg.h b/android/hal-msg.h
index 7d26140..1d6f1e3 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -1129,6 +1129,11 @@ struct hal_cmd_gatt_client_setup_multi_adv_inst {
 	uint8_t data_service_uuid[0];
 } __attribute__((packed));
 
+#define HAL_OP_GATT_CLIENT_DISABLE_MULTI_ADV_INST	0x2e
+struct hal_cmd_gatt_client_disable_multi_adv_inst {
+	int32_t client_if;
+} __attribute__((packed));
+
 /* Handsfree client HAL API */
 
 #define HAL_OP_HF_CLIENT_CONNECT		0x01
-- 
1.9.3

