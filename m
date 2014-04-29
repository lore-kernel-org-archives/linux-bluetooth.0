Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: szymon.janc@tieto.com, johan.hedberg@gmail.com,
	Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH v2 38/40] android/hal-gatt-api: Fix IPC definition for send response
Date: Tue, 29 Apr 2014 18:47:27 +0200
Message-Id: <1398790049-30303-39-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1398790049-30303-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1398790049-30303-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/hal-gatt.c | 7 +++++--
 android/hal-msg.h  | 3 +++
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/android/hal-gatt.c b/android/hal-gatt.c
index 16b5607..e1faccb 100644
--- a/android/hal-gatt.c
+++ b/android/hal-gatt.c
@@ -1237,9 +1237,12 @@ static bt_status_t send_response(int conn_id, int trans_id, int status,
 	cmd->conn_id = conn_id;
 	cmd->trans_id = trans_id;
 	cmd->status = status;
-	cmd->len = sizeof(*response);
+	cmd->handle = response->attr_value.handle;
+	cmd->offset = response->attr_value.offset;
+	cmd->auth_req = response->attr_value.auth_req;
+	cmd->len = response->attr_value.len;
 
-	memcpy(cmd->data, response, sizeof(*response));
+	memcpy(cmd->data, response->attr_value.value, cmd->len);
 
 	return hal_ipc_cmd(HAL_SERVICE_ID_GATT,
 					HAL_OP_GATT_SERVER_SEND_RESPONSE,
diff --git a/android/hal-msg.h b/android/hal-msg.h
index 9d28866..09bd9a0 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -847,6 +847,9 @@ struct hal_cmd_gatt_server_send_indication {
 struct hal_cmd_gatt_server_send_response {
 	int32_t conn_id;
 	int32_t trans_id;
+	uint16_t handle;
+	uint16_t offset;
+	uint8_t auth_req;
 	int32_t status;
 	uint16_t len;
 	uint8_t data[0];
-- 
1.8.4

