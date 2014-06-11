Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [RFC 2/3] android/gatt: Update set_adv_data IPC to HAL API change
Date: Wed, 11 Jun 2014 13:31:00 +0200
Message-Id: <1402486261-22488-2-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1402486261-22488-1-git-send-email-szymon.janc@tieto.com>
References: <1402486261-22488-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/gatt.c     | 19 +++++++++----------
 android/hal-gatt.c | 28 ++++++++++++++++++++++++++--
 android/hal-msg.h  |  4 +++-
 3 files changed, 38 insertions(+), 13 deletions(-)

diff --git a/android/gatt.c b/android/gatt.c
index 558b203..649a482 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -3464,19 +3464,18 @@ static void handle_client_set_adv_data(const void *buf, uint16_t len)
 		return;
 	}
 
-	DBG("scan_rsp=%u name=%u tx=%u min=%d max=%d app=%d manufacturer=%u",
+	DBG("scan_rsp=%u name=%u tx=%u min=%d max=%d app=%d",
 		cmd->set_scan_rsp, cmd->include_name, cmd->include_txpower,
-		cmd->min_interval, cmd->max_interval, cmd->appearance,
-		cmd->manufacturer_len);
+		cmd->min_interval, cmd->max_interval, cmd->appearance);
 
-	/*
-	 * TODO
-	 * Currently kernel is setting all except for vendor data.
-	 * This should be implemented when kernel supports it.
-	 */
+	DBG("manufacturer=%u service_data=%u service_uuid=%u",
+				cmd->manufacturer_len, cmd->service_data_len,
+				cmd->service_uuid_len);
 
-	if (cmd->manufacturer_len) {
-		error("gatt: Manufacturer advertising data not supported");
+	/* TODO This should be implemented when kernel supports it */
+	if (cmd->manufacturer_len || cmd->service_data_len ||
+							cmd->service_uuid_len) {
+		error("gatt: Extra advertising data not supported");
 		status = HAL_STATUS_FAILED;
 		goto failed;
 	}
diff --git a/android/hal-gatt.c b/android/hal-gatt.c
index a4ad0f2..a8f5bd1 100644
--- a/android/hal-gatt.c
+++ b/android/hal-gatt.c
@@ -981,11 +981,18 @@ static bt_status_t set_adv_data(int server_if, bool set_scan_rsp,
 {
 	char buf[IPC_MTU];
 	struct hal_cmd_gatt_client_set_adv_data *cmd = (void *) buf;
-	size_t cmd_len = sizeof(*cmd) + manufacturer_len;
+	size_t cmd_len;
+	uint8_t *data;
 
 	if (!interface_ready())
 		return BT_STATUS_NOT_READY;
 
+	cmd_len = sizeof(*cmd) + manufacturer_len + service_data_len +
+							service_uuid_len;
+
+	if (cmd_len > IPC_MTU)
+		return BT_STATUS_FAIL;
+
 	cmd->server_if = server_if;
 	cmd->set_scan_rsp = set_scan_rsp;
 	cmd->include_name = include_name;
@@ -994,8 +1001,25 @@ static bt_status_t set_adv_data(int server_if, bool set_scan_rsp,
 	cmd->max_interval = max_interval;
 	cmd->appearance = appearance;
 	cmd->manufacturer_len = manufacturer_len;
+	cmd->service_data_len = service_data_len;
+	cmd->service_uuid_len = service_uuid_len;
+
+	data = cmd->data;
+
+	if (manufacturer_data && manufacturer_len) {
+		memcpy(data, manufacturer_data, manufacturer_len);
+		data += manufacturer_len;
+	}
+
+	if (service_data && service_data_len) {
+		memcpy(data, service_data, service_data_len);
+		data += service_data_len;
+	}
 
-	memcpy(cmd->manufacturer_data, manufacturer_data, manufacturer_len);
+	if (service_uuid && service_uuid_len) {
+		memcpy(data, service_uuid, service_uuid_len);
+		data += service_uuid_len;
+	}
 
 	return hal_ipc_cmd(HAL_SERVICE_ID_GATT, HAL_OP_GATT_CLIENT_SET_ADV_DATA,
 						cmd_len, cmd, 0, NULL, NULL);
diff --git a/android/hal-msg.h b/android/hal-msg.h
index 65cf81f..50ae914 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -745,7 +745,9 @@ struct hal_cmd_gatt_client_set_adv_data {
 	int32_t  max_interval;
 	int32_t  appearance;
 	uint16_t manufacturer_len;
-	uint8_t  manufacturer_data[0];
+	uint16_t service_data_len;
+	uint16_t service_uuid_len;
+	uint8_t  data[0];
 } __attribute__((packed));
 
 #define GATT_CLIENT_TEST_CMD_ENABLE		0x01
-- 
1.9.1

