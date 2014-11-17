Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 03/16] android/hal-gatt: Implement client scan_filter_add_remove
Date: Mon, 17 Nov 2014 23:27:55 +0100
Message-Id: <1416263288-30530-3-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1416263288-30530-1-git-send-email-szymon.janc@tieto.com>
References: <1416263288-30530-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This adds required IPC message, HAL implementation and daemon stub
handler
---
 android/gatt.c     | 16 ++++++++++++++++
 android/hal-gatt.c | 35 ++++++++++++++++++++++++++++++++---
 android/hal-msg.h  | 17 +++++++++++++++++
 3 files changed, 65 insertions(+), 3 deletions(-)

diff --git a/android/gatt.c b/android/gatt.c
index a441e4f..f104a2c 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -5553,6 +5553,19 @@ static void handle_client_scan_filter_setup(const void *buf, uint16_t len)
 					HAL_STATUS_UNSUPPORTED);
 }
 
+static void handle_client_scan_filter_add_remove(const void *buf, uint16_t len)
+{
+	const struct hal_cmd_gatt_client_scan_filter_add_remove *cmd = buf;
+
+	DBG("client_if %u", cmd->client_if);
+
+	/* TODO */
+
+	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_GATT,
+				HAL_OP_GATT_CLIENT_SCAN_FILTER_ADD_REMOVE,
+				HAL_STATUS_UNSUPPORTED);
+}
+
 static const struct ipc_handler cmd_handlers[] = {
 	/* HAL_OP_GATT_CLIENT_REGISTER */
 	{ handle_client_register, false,
@@ -5662,6 +5675,9 @@ static const struct ipc_handler cmd_handlers[] = {
 	/* HAL_OP_GATT_CLIENT_SCAN_FILTER_SETUP */
 	{ handle_client_scan_filter_setup, false,
 		sizeof(struct hal_cmd_gatt_client_scan_filter_setup) },
+	/* HAL_OP_GATT_CLIENT_SCAN_FILTER_ADD_REMOVE */
+	{ handle_client_scan_filter_add_remove, true,
+		sizeof(struct hal_cmd_gatt_client_scan_filter_add_remove) },
 };
 
 static uint8_t read_by_group_type(const uint8_t *cmd, uint16_t cmd_len,
diff --git a/android/hal-gatt.c b/android/hal-gatt.c
index f4c3d31..3291d47 100644
--- a/android/hal-gatt.c
+++ b/android/hal-gatt.c
@@ -1345,11 +1345,40 @@ static bt_status_t scan_filter_add_remove(int client_if, int action,
 						int data_len, char *p_data,
 						int mask_len, char *p_mask)
 {
-	DBG("");
+	char buf[IPC_MTU];
+	struct hal_cmd_gatt_client_scan_filter_add_remove *cmd = (void *) buf;
+	size_t cmd_len;
 
-	/* TODO */
+	if (!interface_ready())
+		return BT_STATUS_NOT_READY;
 
-	return BT_STATUS_UNSUPPORTED;
+	if (!p_uuid || !p_uuid_mask || !bd_addr)
+		return BT_STATUS_PARM_INVALID;
+
+	cmd_len = sizeof(*cmd) + data_len + mask_len;
+	if (cmd_len > IPC_MTU)
+		return BT_STATUS_FAIL;
+
+	cmd->client_if = client_if;
+	cmd->action = action;
+	cmd->filter_type = filt_type;
+	cmd->filter_index = filt_index;
+	cmd->company_id = company_id;
+	cmd->company_id_mask = company_id_mask;
+	memcpy(cmd->uuid, p_uuid, sizeof(*p_uuid));
+	memcpy(cmd->uuid_mask, p_uuid_mask, sizeof(*p_uuid_mask));
+	memcpy(cmd->address, bd_addr, sizeof(*bd_addr));
+	cmd->address_type = addr_type;
+
+	cmd->data_len = data_len;
+	memcpy(cmd->data_mask, p_data, data_len);
+
+	cmd->mask_len = mask_len;
+	memcpy(cmd->data_mask + data_len, p_mask, mask_len);
+
+	return hal_ipc_cmd(HAL_SERVICE_ID_GATT,
+				HAL_OP_GATT_CLIENT_SCAN_FILTER_ADD_REMOVE,
+				cmd_len, cmd, NULL, NULL, NULL);
 }
 
 static bt_status_t scan_filter_clear(int client_if, int filt_index)
diff --git a/android/hal-msg.h b/android/hal-msg.h
index c74c76b..94d0069 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -1044,6 +1044,23 @@ struct hal_cmd_gatt_client_scan_filter_setup {
 	int32_t found_timeout_cnt;
 } __attribute__((packed));
 
+#define HAL_OP_GATT_CLIENT_SCAN_FILTER_ADD_REMOVE	0x025
+struct hal_cmd_gatt_client_scan_filter_add_remove {
+	int32_t client_if;
+	int32_t action;
+	int32_t filter_type;
+	int32_t filter_index;
+	int32_t company_id;
+	int32_t company_id_mask;
+	uint8_t uuid[16];
+	uint8_t uuid_mask[16];
+	uint8_t address[6];
+	uint8_t address_type;
+	int32_t data_len;
+	int32_t mask_len;
+	uint8_t data_mask[0];
+} __attribute__((packed));
+
 /* Handsfree client HAL API */
 
 #define HAL_OP_HF_CLIENT_CONNECT		0x01
-- 
1.9.3

