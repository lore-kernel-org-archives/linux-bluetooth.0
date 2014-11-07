Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH BlueZ 01/11] shared/gatt-server: Implement "Read By Type" request.
Date: Fri,  7 Nov 2014 00:09:41 -0800
Message-Id: <1415347791-11716-2-git-send-email-armansito@chromium.org>
In-Reply-To: <1415347791-11716-1-git-send-email-armansito@chromium.org>
References: <1415347791-11716-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch implements the ATT protocol "Read By Type" request for
shared/gatt-server. Logic is implemented that allows asynchronous
reading of non-standard attribute values via the registered read and
read completion callbacks.
---
 src/shared/gatt-server.c | 246 ++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 243 insertions(+), 3 deletions(-)

diff --git a/src/shared/gatt-server.c b/src/shared/gatt-server.c
index 18f82c4..ddb0be1 100644
--- a/src/shared/gatt-server.c
+++ b/src/shared/gatt-server.c
@@ -40,6 +40,16 @@
 #define MIN(a, b) ((a) < (b) ? (a) : (b))
 #endif
 
+struct async_read_op {
+	struct bt_gatt_server *server;
+	uint8_t opcode;
+	bool done;
+	uint8_t *pdu;
+	size_t pdu_len;
+	size_t value_len;
+	struct queue *db_data;
+};
+
 struct bt_gatt_server {
 	struct gatt_db *db;
 	struct bt_att *att;
@@ -48,6 +58,9 @@ struct bt_gatt_server {
 
 	unsigned int mtu_id;
 	unsigned int read_by_grp_type_id;
+	unsigned int read_by_type_id;
+
+	struct async_read_op *pending_read_op;
 
 	bt_gatt_server_debug_func_t debug_callback;
 	bt_gatt_server_destroy_func_t debug_destroy;
@@ -61,11 +74,23 @@ static void bt_gatt_server_free(struct bt_gatt_server *server)
 
 	bt_att_unregister(server->att, server->mtu_id);
 	bt_att_unregister(server->att, server->read_by_grp_type_id);
+	bt_att_unregister(server->att, server->read_by_type_id);
 	bt_att_unref(server->att);
 
+	if (server->pending_read_op)
+		server->pending_read_op->server = NULL;
+
 	free(server);
 }
 
+static uint8_t att_ecode_from_error(int err)
+{
+	if (err < 0 || err > UINT8_MAX)
+		return 0xff;
+
+	return err;
+}
+
 static void encode_error_rsp(uint8_t opcode, uint16_t handle, uint8_t ecode,
 								uint8_t pdu[4])
 {
@@ -136,14 +161,15 @@ static bool encode_read_by_grp_type_rsp(struct gatt_db *db, struct queue *q,
 		 * value is seen.
 		 */
 		if (iter == 0) {
-			data_val_len = value.iov_len;
+			data_val_len = MIN(MIN((unsigned)mtu - 6, 251),
+								value.iov_len);
 			pdu[0] = data_val_len + 4;
 			iter++;
 		} else if (value.iov_len != data_val_len)
 			break;
 
 		/* Stop if this unit would surpass the MTU */
-		if (iter + data_val_len + 4 > mtu)
+		if (iter + data_val_len + 4 > mtu - 1)
 			break;
 
 		gatt_db_attribute_get_service_handles(attrib, &start_handle,
@@ -151,7 +177,7 @@ static bool encode_read_by_grp_type_rsp(struct gatt_db *db, struct queue *q,
 
 		put_le16(start_handle, pdu + iter);
 		put_le16(end_handle, pdu + iter + 2);
-		memcpy(pdu + iter + 4, value.iov_base, value.iov_len);
+		memcpy(pdu + iter + 4, value.iov_base, data_val_len);
 
 		iter += data_val_len + 4;
 	}
@@ -248,6 +274,212 @@ done:
 							NULL, NULL, NULL);
 }
 
+static void async_read_op_destroy(struct async_read_op *op)
+{
+	if (op->server)
+		op->server->pending_read_op = NULL;
+
+	queue_destroy(op->db_data, NULL);
+	free(op->pdu);
+	free(op);
+}
+
+static void process_read_by_type(struct async_read_op *op);
+
+static void read_by_type_read_complete_cb(struct gatt_db_attribute *attr,
+						int err, const uint8_t *value,
+						size_t len, void *user_data)
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
+	/* Terminate the operation if there was an error */
+	if (err) {
+		uint8_t pdu[4];
+		uint8_t att_ecode = att_ecode_from_error(err);
+
+		encode_error_rsp(BT_ATT_OP_READ_BY_TYPE_REQ, handle, att_ecode,
+									pdu);
+		bt_att_send(server->att, BT_ATT_OP_ERROR_RSP, pdu, 4, NULL,
+								NULL, NULL);
+		async_read_op_destroy(op);
+		return;
+	}
+
+	if (op->pdu_len == 0) {
+		op->value_len = MIN(MIN((unsigned) mtu - 4, 253), len);
+		op->pdu[0] = op->value_len + 2;
+		op->pdu_len++;
+	} else if (len != op->value_len) {
+		op->done = true;
+		goto done;
+	}
+
+	/* Stop if this would surpass the MTU */
+	if (op->pdu_len + op->value_len + 2 > (unsigned) mtu - 1) {
+		op->done = true;
+		goto done;
+	}
+
+	/* Encode the current value */
+	put_le16(handle, op->pdu + op->pdu_len);
+	memcpy(op->pdu + op->pdu_len + 2, value, op->value_len);
+
+	op->pdu_len += op->value_len + 2;
+
+	if (op->pdu_len == (unsigned) mtu - 1)
+		op->done = true;
+
+done:
+	process_read_by_type(op);
+}
+
+static void process_read_by_type(struct async_read_op *op)
+{
+	struct bt_gatt_server *server = op->server;
+	uint8_t rsp_opcode;
+	uint8_t rsp_len;
+	uint8_t ecode;
+	uint16_t ehandle;
+	struct gatt_db_attribute *attr;
+	uint32_t perm;
+
+	attr = queue_pop_head(op->db_data);
+
+	if (op->done || !attr) {
+		rsp_opcode = BT_ATT_OP_READ_BY_TYPE_RSP;
+		rsp_len = op->pdu_len;
+		goto done;
+	}
+
+	if (!gatt_db_attribute_get_permissions(attr, &perm)) {
+		ecode = BT_ATT_ERROR_UNLIKELY;
+		goto error;
+	}
+
+	/*
+	 * Check for the READ access permission. Encryption,
+	 * authentication, and authorization permissions need to be
+	 * checked by the read handler, since bt_att is agnostic to
+	 * connection type and doesn't have security information on it.
+	 */
+	if (perm && !(perm & BT_ATT_PERM_READ)) {
+		ecode = BT_ATT_ERROR_READ_NOT_PERMITTED;
+		goto error;
+	}
+
+	if (gatt_db_attribute_read(attr, 0, op->opcode, NULL,
+				read_by_type_read_complete_cb, op))
+		return;
+
+	ecode = BT_ATT_ERROR_UNLIKELY;
+
+error:
+	ehandle = gatt_db_attribute_get_handle(attr);
+	rsp_opcode = BT_ATT_OP_ERROR_RSP;
+	rsp_len = 4;
+	encode_error_rsp(BT_ATT_OP_READ_BY_TYPE_REQ, ehandle, ecode, op->pdu);
+
+done:
+	bt_att_send(server->att, rsp_opcode, op->pdu, rsp_len, NULL,
+								NULL, NULL);
+	async_read_op_destroy(op);
+}
+
+static void read_by_type_cb(uint8_t opcode, const void *pdu,
+					uint16_t length, void *user_data)
+{
+	struct bt_gatt_server *server = user_data;
+	uint16_t start, end;
+	bt_uuid_t type;
+	uint8_t rsp_pdu[4];
+	uint16_t ehandle = 0;
+	uint8_t ecode;
+	struct queue *q = NULL;
+	struct async_read_op *op;
+
+	if (length != 6 && length != 20) {
+		ecode = BT_ATT_ERROR_INVALID_PDU;
+		goto error;
+	}
+
+	q = queue_new();
+	if (!q) {
+		ecode = BT_ATT_ERROR_INSUFFICIENT_RESOURCES;
+		goto error;
+	}
+
+	start = get_le16(pdu);
+	end = get_le16(pdu + 2);
+	get_uuid_le(pdu + 4, length - 4, &type);
+
+	util_debug(server->debug_callback, server->debug_data,
+				"Read By Type - start: 0x%04x end: 0x%04x",
+				start, end);
+
+	if (!start || !end) {
+		ecode = BT_ATT_ERROR_INVALID_HANDLE;
+		goto error;
+	}
+
+	ehandle = start;
+
+	if (start > end) {
+		ecode = BT_ATT_ERROR_INVALID_HANDLE;
+		goto error;
+	}
+
+	gatt_db_read_by_type(server->db, start, end, type, q);
+
+	if (queue_isempty(q)) {
+		ecode = BT_ATT_ERROR_ATTRIBUTE_NOT_FOUND;
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
+	op->pdu = malloc(bt_att_get_mtu(server->att));
+	if (!op->pdu) {
+		free(op);
+		ecode = BT_ATT_ERROR_INSUFFICIENT_RESOURCES;
+		goto error;
+	}
+
+	op->opcode = opcode;
+	op->server = server;
+	op->db_data = q;
+	server->pending_read_op = op;
+
+	process_read_by_type(op);
+
+	return;
+
+error:
+	encode_error_rsp(opcode, ehandle, ecode, rsp_pdu);
+	queue_destroy(q, NULL);
+	bt_att_send(server->att, BT_ATT_OP_ERROR_RSP, rsp_pdu, 4,
+							NULL, NULL, NULL);
+}
+
 static void exchange_mtu_cb(uint8_t opcode, const void *pdu,
 					uint16_t length, void *user_data)
 {
@@ -296,6 +528,14 @@ static bool gatt_server_register_att_handlers(struct bt_gatt_server *server)
 	if (!server->read_by_grp_type_id)
 		return false;
 
+	/* Read By Type */
+	server->read_by_type_id = bt_att_register(server->att,
+						BT_ATT_OP_READ_BY_TYPE_REQ,
+						read_by_type_cb,
+						server, NULL);
+	if (!server->read_by_type_id)
+		return false;
+
 	return true;
 }
 
-- 
2.1.0.rc2.206.gedb03e5

