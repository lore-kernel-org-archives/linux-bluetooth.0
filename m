Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH BlueZ v1 05/11] shared/gatt-server: Implement "Read Blob" request.
Date: Fri,  7 Nov 2014 12:41:53 -0800
Message-Id: <1415392919-17572-6-git-send-email-armansito@chromium.org>
In-Reply-To: <1415392919-17572-1-git-send-email-armansito@chromium.org>
References: <1415392919-17572-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch implements the "Read Blob" request for the GATT server role.
---
 src/shared/gatt-server.c | 96 +++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 82 insertions(+), 14 deletions(-)

diff --git a/src/shared/gatt-server.c b/src/shared/gatt-server.c
index 5cf11a4..49da84e 100644
--- a/src/shared/gatt-server.c
+++ b/src/shared/gatt-server.c
@@ -68,6 +68,7 @@ struct bt_gatt_server {
 	unsigned int write_id;
 	unsigned int write_cmd_id;
 	unsigned int read_id;
+	unsigned int read_blob_id;
 
 	struct async_read_op *pending_read_op;
 	struct async_write_op *pending_write_op;
@@ -89,6 +90,7 @@ static void bt_gatt_server_free(struct bt_gatt_server *server)
 	bt_att_unregister(server->att, server->write_id);
 	bt_att_unregister(server->att, server->write_cmd_id);
 	bt_att_unregister(server->att, server->read_id);
+	bt_att_unregister(server->att, server->read_blob_id);
 
 	if (server->pending_read_op)
 		server->pending_read_op->server = NULL;
@@ -760,12 +762,36 @@ error:
 							NULL, NULL, NULL);
 }
 
+static uint8_t get_read_rsp_opcode(uint8_t opcode)
+{
+
+	switch (opcode) {
+	case BT_ATT_OP_READ_REQ:
+		return BT_ATT_OP_READ_RSP;
+	case BT_ATT_OP_READ_BLOB_REQ:
+		return BT_ATT_OP_READ_BLOB_RSP;
+	default:
+		/*
+		 * Should never happen
+		 *
+		 * TODO: It would be nice to have a debug-mode assert macro
+		 * for development builds. This way bugs could be easily catched
+		 * during development and there would be self documenting code
+		 * that wouldn't be crash release builds.
+		 */
+		return 0;
+	}
+
+	return 0;
+}
+
 static void read_complete_cb(struct gatt_db_attribute *attr, int err,
 					const uint8_t *value, size_t len,
 					void *user_data)
 {
 	struct async_read_op *op = user_data;
 	struct bt_gatt_server *server = op->server;
+	uint8_t rsp_opcode;
 	uint16_t mtu;
 	uint16_t handle;
 
@@ -788,32 +814,24 @@ static void read_complete_cb(struct gatt_db_attribute *attr, int err,
 		return;
 	}
 
-	/* TODO: Send Read Blob response based on the request */
+	rsp_opcode = get_read_rsp_opcode(op->opcode);
 
-	bt_att_send(server->att, BT_ATT_OP_READ_RSP, len ? value : NULL,
+	bt_att_send(server->att, rsp_opcode, len ? value : NULL,
 						MIN((unsigned) mtu - 1, len),
 						NULL, NULL, NULL);
 	async_read_op_destroy(op);
 }
 
-static void read_cb(uint8_t opcode, const void *pdu,
-					uint16_t length, void *user_data)
+static void handle_read_req(struct bt_gatt_server *server, uint8_t opcode,
+								uint16_t handle,
+								uint16_t offset)
 {
-	struct bt_gatt_server *server = user_data;
-	uint16_t mtu = bt_att_get_mtu(server->att);
 	uint8_t error_pdu[4];
-	uint16_t handle = 0;
 	struct gatt_db_attribute *attr;
 	uint8_t ecode;
 	uint32_t perm;
 	struct async_read_op *op = NULL;
 
-	if (length != 2) {
-		ecode = BT_ATT_ERROR_INVALID_PDU;
-		goto error;
-	}
-
-	handle = get_le16(pdu);
 	attr = gatt_db_get_attribute(server->db, handle);
 	if (!attr) {
 		ecode = BT_ATT_ERROR_INVALID_HANDLE;
@@ -848,7 +866,8 @@ static void read_cb(uint8_t opcode, const void *pdu,
 	op->server = server;
 	server->pending_read_op = op;
 
-	if (gatt_db_attribute_read(attr, 0, opcode, NULL, read_complete_cb, op))
+	if (gatt_db_attribute_read(attr, offset, opcode, NULL,
+							read_complete_cb, op))
 		return;
 
 	ecode = BT_ATT_ERROR_UNLIKELY;
@@ -862,6 +881,47 @@ error:
 									NULL);
 }
 
+static void read_cb(uint8_t opcode, const void *pdu,
+					uint16_t length, void *user_data)
+{
+	struct bt_gatt_server *server = user_data;
+	uint16_t handle;
+
+	if (length != 2) {
+		uint8_t pdu[4];
+
+		encode_error_rsp(opcode, 0, BT_ATT_ERROR_INVALID_PDU, pdu);
+		bt_att_send(server->att, BT_ATT_OP_ERROR_RSP, pdu, 4, NULL,
+								NULL, NULL);
+		return;
+	}
+
+	handle = get_le16(pdu);
+
+	handle_read_req(server, opcode, handle, 0);
+}
+
+static void read_blob_cb(uint8_t opcode, const void *pdu,
+					uint16_t length, void *user_data)
+{
+	struct bt_gatt_server *server = user_data;
+	uint16_t handle, offset;
+
+	if (length != 4) {
+		uint8_t pdu[4];
+
+		encode_error_rsp(opcode, 0, BT_ATT_ERROR_INVALID_PDU, pdu);
+		bt_att_send(server->att, BT_ATT_OP_ERROR_RSP, pdu, 4, NULL,
+								NULL, NULL);
+		return;
+	}
+
+	handle = get_le16(pdu);
+	offset = get_le16(pdu + 2);
+
+	handle_read_req(server, opcode, handle, offset);
+}
+
 static void exchange_mtu_cb(uint8_t opcode, const void *pdu,
 					uint16_t length, void *user_data)
 {
@@ -947,6 +1007,14 @@ static bool gatt_server_register_att_handlers(struct bt_gatt_server *server)
 	if (!server->read_id)
 		return false;
 
+	/* Read Blob Request */
+	server->read_blob_id = bt_att_register(server->att,
+							BT_ATT_OP_READ_BLOB_REQ,
+							read_blob_cb,
+							server, NULL);
+	if (!server->read_blob_id)
+		return false;
+
 	return true;
 }
 
-- 
2.1.0.rc2.206.gedb03e5

