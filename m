Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: szymon.janc@tieto.com,
	Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH 35/36] android/gatt: Add support for GATT server send response
Date: Tue, 29 Apr 2014 03:15:06 +0200
Message-Id: <1398734107-4793-37-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1398734107-4793-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1398734107-4793-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/gatt.c | 60 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 58 insertions(+), 2 deletions(-)

diff --git a/android/gatt.c b/android/gatt.c
index 70ebb06..6368e2c 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -3316,13 +3316,39 @@ static void send_gatt_response(uint8_t opcode, uint16_t handle, uint16_t offset,
 	uint16_t length;
 	uint8_t pdu[ATT_DEFAULT_LE_MTU];
 
+	DBG("");
+
 	if (!status) {
 		length = enc_error_resp(opcode, handle, status, pdu,
 								sizeof(pdu));
 		g_attrib_send(dev->attrib, 0, pdu, length, NULL, NULL, NULL);
 		return;
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
+		return;
+	}
+
+	g_attrib_send(dev->attrib, 0, pdu, length, NULL, NULL, NULL);
 }
 
 static void read_cb(uint16_t handle, uint16_t offset,
@@ -3648,10 +3674,40 @@ static void handle_server_send_indication(const void *buf, uint16_t len)
 
 static void handle_server_send_response(const void *buf, uint16_t len)
 {
+	const struct hal_cmd_gatt_server_send_response *cmd = buf;
+	struct app_connection *conn;
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
+	if (cmd->trans_id != conn->app->pend_trans_id) {
+		error("gatt: trans_id != pend_trans_id (%d!=%d)",
+				cmd->trans_id, conn->app->pend_trans_id);
+
+		status = HAL_STATUS_FAILED;
+		goto reply;
+	}
+
+	send_gatt_response(cmd->conn_id, cmd->handle, cmd->offset, cmd->status,
+					cmd->len, cmd->data, conn->device);
+
+	free(conn->app->data);
+	conn->app->data = NULL;
+
+	conn->app->pend_trans_id = 0;
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

