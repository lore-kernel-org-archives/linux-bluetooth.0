Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH BlueZ v1 04/11] shared/gatt-server: Implement "Read" request.
Date: Fri,  7 Nov 2014 12:41:52 -0800
Message-Id: <1415392919-17572-5-git-send-email-armansito@chromium.org>
In-Reply-To: <1415392919-17572-1-git-send-email-armansito@chromium.org>
References: <1415392919-17572-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch implements the "Read" request for the GATT server role.
---
 src/shared/gatt-server.c | 111 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 111 insertions(+)

diff --git a/src/shared/gatt-server.c b/src/shared/gatt-server.c
index db002db..5cf11a4 100644
--- a/src/shared/gatt-server.c
+++ b/src/shared/gatt-server.c
@@ -67,6 +67,7 @@ struct bt_gatt_server {
 	unsigned int find_info_id;
 	unsigned int write_id;
 	unsigned int write_cmd_id;
+	unsigned int read_id;
 
 	struct async_read_op *pending_read_op;
 	struct async_write_op *pending_write_op;
@@ -87,6 +88,7 @@ static void bt_gatt_server_free(struct bt_gatt_server *server)
 	bt_att_unregister(server->att, server->find_info_id);
 	bt_att_unregister(server->att, server->write_id);
 	bt_att_unregister(server->att, server->write_cmd_id);
+	bt_att_unregister(server->att, server->read_id);
 
 	if (server->pending_read_op)
 		server->pending_read_op->server = NULL;
@@ -758,6 +760,108 @@ error:
 							NULL, NULL, NULL);
 }
 
+static void read_complete_cb(struct gatt_db_attribute *attr, int err,
+					const uint8_t *value, size_t len,
+					void *user_data)
+{
+	struct async_read_op *op = user_data;
+	struct bt_gatt_server *server = op->server;
+	uint16_t mtu;
+	uint16_t handle;
+
+	if (!server) {
+		async_read_op_destroy(op);
+		return;
+	}
+
+	mtu = bt_att_get_mtu(server->att);
+	handle = gatt_db_attribute_get_handle(attr);
+
+	if (err) {
+		uint8_t pdu[4];
+		uint8_t att_ecode = att_ecode_from_error(err);
+
+		encode_error_rsp(op->opcode, handle, att_ecode, pdu);
+		bt_att_send(server->att, BT_ATT_OP_ERROR_RSP, pdu, 4, NULL,
+								NULL, NULL);
+		async_read_op_destroy(op);
+		return;
+	}
+
+	/* TODO: Send Read Blob response based on the request */
+
+	bt_att_send(server->att, BT_ATT_OP_READ_RSP, len ? value : NULL,
+						MIN((unsigned) mtu - 1, len),
+						NULL, NULL, NULL);
+	async_read_op_destroy(op);
+}
+
+static void read_cb(uint8_t opcode, const void *pdu,
+					uint16_t length, void *user_data)
+{
+	struct bt_gatt_server *server = user_data;
+	uint16_t mtu = bt_att_get_mtu(server->att);
+	uint8_t error_pdu[4];
+	uint16_t handle = 0;
+	struct gatt_db_attribute *attr;
+	uint8_t ecode;
+	uint32_t perm;
+	struct async_read_op *op = NULL;
+
+	if (length != 2) {
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
+					"Read - handle: 0x%04x", handle);
+
+	if (!gatt_db_attribute_get_permissions(attr, &perm)) {
+		ecode = BT_ATT_ERROR_INVALID_HANDLE;
+		goto error;
+	}
+
+	if (perm && !(perm & BT_ATT_PERM_READ)) {
+		ecode = BT_ATT_ERROR_READ_NOT_PERMITTED;
+		goto error;
+	}
+
+	if (server->pending_read_op) {
+		ecode = BT_ATT_ERROR_UNLIKELY;
+		goto error;
+	}
+
+	op = new0(struct async_read_op, 1);
+	if (!op) {
+		ecode = BT_ATT_ERROR_INSUFFICIENT_RESOURCES;
+		goto error;
+	}
+
+	op->opcode = opcode;
+	op->server = server;
+	server->pending_read_op = op;
+
+	if (gatt_db_attribute_read(attr, 0, opcode, NULL, read_complete_cb, op))
+		return;
+
+	ecode = BT_ATT_ERROR_UNLIKELY;
+
+error:
+	if (op)
+		async_read_op_destroy(op);
+
+	encode_error_rsp(opcode, handle, ecode, error_pdu);
+	bt_att_send(server->att, BT_ATT_OP_ERROR_RSP, error_pdu, 4, NULL, NULL,
+									NULL);
+}
+
 static void exchange_mtu_cb(uint8_t opcode, const void *pdu,
 					uint16_t length, void *user_data)
 {
@@ -836,6 +940,13 @@ static bool gatt_server_register_att_handlers(struct bt_gatt_server *server)
 	if (!server->write_cmd_id)
 		return false;
 
+	/* Read Request */
+	server->read_id = bt_att_register(server->att, BT_ATT_OP_READ_REQ,
+								read_cb,
+								server, NULL);
+	if (!server->read_id)
+		return false;
+
 	return true;
 }
 
-- 
2.1.0.rc2.206.gedb03e5

