Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH BlueZ 03/11] shared/gatt-server: Implement "Write" request and command.
Date: Fri,  7 Nov 2014 00:09:43 -0800
Message-Id: <1415347791-11716-4-git-send-email-armansito@chromium.org>
In-Reply-To: <1415347791-11716-1-git-send-email-armansito@chromium.org>
References: <1415347791-11716-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch implements the "Write" request and command for the GATT
server role. Writes are delegated to the attribute's write handler,
which is also responsible for performing certain permission checks.
---
 src/shared/gatt-server.c | 146 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 146 insertions(+)

diff --git a/src/shared/gatt-server.c b/src/shared/gatt-server.c
index ddb714d..db002db 100644
--- a/src/shared/gatt-server.c
+++ b/src/shared/gatt-server.c
@@ -50,6 +50,11 @@ struct async_read_op {
 	struct queue *db_data;
 };
 
+struct async_write_op {
+	struct bt_gatt_server *server;
+	uint8_t opcode;
+};
+
 struct bt_gatt_server {
 	struct gatt_db *db;
 	struct bt_att *att;
@@ -60,8 +65,11 @@ struct bt_gatt_server {
 	unsigned int read_by_grp_type_id;
 	unsigned int read_by_type_id;
 	unsigned int find_info_id;
+	unsigned int write_id;
+	unsigned int write_cmd_id;
 
 	struct async_read_op *pending_read_op;
+	struct async_write_op *pending_write_op;
 
 	bt_gatt_server_debug_func_t debug_callback;
 	bt_gatt_server_destroy_func_t debug_destroy;
@@ -77,10 +85,15 @@ static void bt_gatt_server_free(struct bt_gatt_server *server)
 	bt_att_unregister(server->att, server->read_by_grp_type_id);
 	bt_att_unregister(server->att, server->read_by_type_id);
 	bt_att_unregister(server->att, server->find_info_id);
+	bt_att_unregister(server->att, server->write_id);
+	bt_att_unregister(server->att, server->write_cmd_id);
 
 	if (server->pending_read_op)
 		server->pending_read_op->server = NULL;
 
+	if (server->pending_write_op)
+		server->pending_write_op->server = NULL;
+
 	bt_att_unref(server->att);
 	free(server);
 }
@@ -626,6 +639,125 @@ done:
 							NULL, NULL, NULL);
 }
 
+static void async_write_op_destroy(struct async_write_op *op)
+{
+	if (op->server)
+		op->server->pending_write_op = NULL;
+
+	free(op);
+}
+
+static void write_complete_cb(struct gatt_db_attribute *attr, int err,
+								void *user_data)
+{
+	struct async_write_op *op = user_data;
+	struct bt_gatt_server *server = op->server;
+	uint16_t handle;
+
+	if (!server) {
+		async_write_op_destroy(op);
+		return;
+	}
+
+	handle = gatt_db_attribute_get_handle(attr);
+
+	if (err) {
+		uint8_t rsp_pdu[4];
+		uint8_t att_ecode = att_ecode_from_error(err);
+
+		encode_error_rsp(op->opcode, handle, att_ecode, rsp_pdu);
+		bt_att_send(server->att, BT_ATT_OP_ERROR_RSP, rsp_pdu, 4,
+							NULL, NULL, NULL);
+	} else {
+		/*
+		 * TODO: Make this function work with Prepare Write request once
+		 * it's supported.
+		 */
+
+		bt_att_send(server->att, BT_ATT_OP_WRITE_RSP, NULL, 0,
+							NULL, NULL, NULL);
+	}
+
+	async_write_op_destroy(op);
+}
+
+static void write_cb(uint8_t opcode, const void *pdu,
+					uint16_t length, void *user_data)
+{
+	struct bt_gatt_server *server = user_data;
+	struct gatt_db_attribute *attr;
+	uint16_t handle = 0;
+	uint8_t rsp_pdu[4];
+	gatt_db_attribute_write_t complete_func = NULL;
+	struct async_write_op *op = NULL;
+	uint8_t ecode;
+	uint32_t perm;
+
+	if (length < 2) {
+		ecode = BT_ATT_ERROR_INVALID_PDU;
+		goto error;
+	}
+
+	handle = get_le16(pdu);
+	attr = gatt_db_get_attribute(server->db, handle);
+	if (!attr) {
+		ecode = BT_ATT_ERROR_INVALID_HANDLE;
+		goto error;
+	}
+
+	util_debug(server->debug_callback, server->debug_data,
+				"Write %s - handle: 0x%04x",
+				(opcode == BT_ATT_OP_WRITE_REQ) ? "Req" : "Cmd",
+				handle);
+
+	if (!gatt_db_attribute_get_permissions(attr, &perm)) {
+		ecode = BT_ATT_ERROR_INVALID_HANDLE;
+		goto error;
+	}
+
+	if (!(perm & BT_ATT_PERM_WRITE)) {
+		ecode = BT_ATT_ERROR_WRITE_NOT_PERMITTED;
+		goto error;
+	}
+
+	/* If this is not a command, set up the completion callback and data */
+	if (opcode == BT_ATT_OP_WRITE_REQ) {
+		if (server->pending_write_op) {
+			ecode = BT_ATT_ERROR_UNLIKELY;
+			goto error;
+		}
+
+		op = new0(struct async_write_op, 1);
+		if (!op) {
+			ecode = BT_ATT_ERROR_INSUFFICIENT_RESOURCES;
+			goto error;
+		}
+
+		op->server = server;
+		op->opcode = opcode;
+		server->pending_write_op = op;
+
+		complete_func = write_complete_cb;
+	}
+
+	if (gatt_db_attribute_write(attr, 0, pdu + 2, length - 2, opcode,
+						NULL, complete_func, op))
+		return;
+
+	if (op)
+		async_write_op_destroy(op);
+
+	ecode = BT_ATT_ERROR_UNLIKELY;
+
+error:
+	if (opcode == BT_ATT_OP_WRITE_CMD)
+		return;
+
+	encode_error_rsp(opcode, handle, ecode, rsp_pdu);
+	bt_att_send(server->att, BT_ATT_OP_ERROR_RSP, rsp_pdu, 4,
+							NULL, NULL, NULL);
+}
+
 static void exchange_mtu_cb(uint8_t opcode, const void *pdu,
 					uint16_t length, void *user_data)
 {
@@ -690,6 +822,20 @@ static bool gatt_server_register_att_handlers(struct bt_gatt_server *server)
 	if (!server->find_info_id)
 		return false;
 
+	/* Write Request */
+	server->write_id = bt_att_register(server->att, BT_ATT_OP_WRITE_REQ,
+								write_cb,
+								server, NULL);
+	if (!server->write_id)
+		return false;
+
+	/* Write Command */
+	server->write_cmd_id = bt_att_register(server->att, BT_ATT_OP_WRITE_CMD,
+								write_cb,
+								server, NULL);
+	if (!server->write_cmd_id)
+		return false;
+
 	return true;
 }
 
-- 
2.1.0.rc2.206.gedb03e5

