Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: szymon.janc@tieto.com, johan.hedberg@gmail.com,
	Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH v2 39/40] android/gatt: Add support for GATT server send response
Date: Tue, 29 Apr 2014 18:47:28 +0200
Message-Id: <1398790049-30303-40-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1398790049-30303-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1398790049-30303-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/gatt.c | 68 +++++++++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 65 insertions(+), 3 deletions(-)

diff --git a/android/gatt.c b/android/gatt.c
index 03ff1f3..80880eb 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -3305,12 +3305,40 @@ static void send_gatt_response(uint8_t opcode, uint16_t handle,
 	uint16_t length;
 	uint8_t pdu[ATT_DEFAULT_LE_MTU];
 
+	DBG("");
+
 	if (!status) {
 		length = enc_error_resp(opcode, handle, status, pdu,
 								sizeof(pdu));
-		cb(req_data, pdu, length);
+		goto done;
 	}
-	/* TODO: Send responses for other commands */
+
+	switch (opcode) {
+	case ATT_OP_EXEC_WRITE_REQ:
+		length = enc_exec_write_resp(pdu);
+		break;
+	case ATT_OP_WRITE_REQ:
+		length = enc_write_resp(pdu);
+		break;
+	case ATT_OP_PREP_WRITE_REQ:
+		length = enc_prep_write_resp(handle, offset, data, len, pdu,
+								sizeof(pdu));
+		break;
+	case ATT_OP_READ_BLOB_REQ:
+		length = enc_read_blob_resp((uint8_t *)data, len, offset, pdu,
+								sizeof(pdu));
+		break;
+	case ATT_OP_READ_REQ:
+		length = enc_read_resp((uint8_t *)data, len, pdu, sizeof(pdu));
+		break;
+	default:
+		error("gatt: Unexpected opcode");
+		cb(req_data, NULL, 0);
+		return;
+	}
+
+done:
+	cb(req_data, pdu, length);
 }
 
 static void read_cb(uint16_t handle, uint16_t offset, void *req_data,
@@ -3643,10 +3671,44 @@ static void handle_server_send_indication(const void *buf, uint16_t len)
 
 static void handle_server_send_response(const void *buf, uint16_t len)
 {
+	const struct hal_cmd_gatt_server_send_response *cmd = buf;
+	struct app_connection *conn;
+	struct gatt_app *app;
+	uint8_t status;
+
 	DBG("");
 
+	conn = find_connection_by_id(cmd->conn_id);
+	if (!conn) {
+		error("gatt: cound not found connection");
+		status = HAL_STATUS_FAILED;
+		goto reply;
+	}
+
+	app = conn->app;
+
+	if (cmd->trans_id != app->pend_trans_id) {
+		error("gatt: trans_id != pend_trans_id (%d!=%d)",
+				cmd->trans_id, app->pend_trans_id);
+
+		status = HAL_STATUS_FAILED;
+		goto reply;
+	}
+
+	send_gatt_response(conn->app->data->opcode, cmd->handle, cmd->offset,
+					cmd->status, cmd->len, cmd->data,
+					app->data, app->gatt_db_complete_cb);
+
+	/* Clean request data */
+	conn->app->data = NULL;
+	conn->app->pend_trans_id = 0;
+	conn->app->gatt_db_complete_cb = NULL;
+
+	status = HAL_STATUS_SUCCESS;
+
+reply:
 	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_GATT,
-			HAL_OP_GATT_SERVER_SEND_RESPONSE, HAL_STATUS_FAILED);
+			HAL_OP_GATT_SERVER_SEND_RESPONSE, status);
 }
 
 static const struct ipc_handler cmd_handlers[] = {
-- 
1.8.4

