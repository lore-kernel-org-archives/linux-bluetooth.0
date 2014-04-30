Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: szymon.janc@tieto.com, johan.hedberg@gmail.com,
	Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH v4 37/38] android/gatt: Add support for GATT server send response
Date: Wed, 30 Apr 2014 11:14:08 +0200
Message-Id: <1398849249-5868-38-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1398849249-5868-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1398849249-5868-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/gatt.c | 72 +++++++++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 69 insertions(+), 3 deletions(-)

diff --git a/android/gatt.c b/android/gatt.c
index 6164044..db83707 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -3297,6 +3297,8 @@ static void send_gatt_response(uint8_t opcode, uint16_t handle,
 	uint16_t length;
 	uint8_t pdu[ATT_DEFAULT_LE_MTU];
 
+	DBG("");
+
 	dev = find_device_by_addr(bdaddr);
 	if (!dev) {
 		error("gatt: send_gatt_response, could not find dev");
@@ -3306,9 +3308,34 @@ static void send_gatt_response(uint8_t opcode, uint16_t handle,
 	if (!status) {
 		length = enc_error_resp(opcode, handle, status, pdu,
 								sizeof(pdu));
-		g_attrib_send(dev->attrib, 0, pdu, length, NULL, NULL, NULL);
+		goto done;
+	}
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
 	}
-	/* TODO: Send responses for other commands */
+
+done:
+	g_attrib_send(dev->attrib, 0, pdu, length, NULL, NULL, NULL);
 }
 
 static void set_trans_id(struct gatt_app *app, unsigned int id, int8_t opcode)
@@ -3317,6 +3344,13 @@ static void set_trans_id(struct gatt_app *app, unsigned int id, int8_t opcode)
 	app->trans_id.opcode = opcode;
 }
 
+static void clear_trans_id(struct gatt_app *app)
+{
+	app->trans_id.id = 0;
+	app->trans_id.opcode = 0;
+
+}
+
 static void read_cb(uint16_t handle, uint16_t offset, uint8_t att_opcode,
 					bdaddr_t *bdaddr, void *user_data)
 {
@@ -3640,10 +3674,42 @@ static void handle_server_send_indication(const void *buf, uint16_t len)
 
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
+	if ((unsigned int)cmd->trans_id != app->trans_id.id) {
+		error("gatt: trans_id != pend_trans_id (%d!=%d)",
+				cmd->trans_id, app->trans_id.id);
+
+		status = HAL_STATUS_FAILED;
+		goto reply;
+	}
+
+	send_gatt_response(conn->app->trans_id.opcode, cmd->handle, cmd->offset,
+					cmd->status, cmd->len, cmd->data,
+					&conn->device->bdaddr);
+
+	/* Clean request data */
+	clear_trans_id(app);
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

