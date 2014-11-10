Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH BlueZ v2 09/11] shared/gatt-server: Implement "Execute Write" request.
Date: Mon, 10 Nov 2014 09:07:25 -0800
Message-Id: <1415639247-14320-10-git-send-email-armansito@chromium.org>
In-Reply-To: <1415639247-14320-1-git-send-email-armansito@chromium.org>
References: <1415639247-14320-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds support for handling ATT "Execute Write" requests for
the server role.
---
 src/shared/gatt-server.c | 122 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 122 insertions(+)

diff --git a/src/shared/gatt-server.c b/src/shared/gatt-server.c
index 17e15b1..2ca318a 100644
--- a/src/shared/gatt-server.c
+++ b/src/shared/gatt-server.c
@@ -92,6 +92,7 @@ struct bt_gatt_server {
 	unsigned int read_id;
 	unsigned int read_blob_id;
 	unsigned int prep_write_id;
+	unsigned int exec_write_id;
 
 	struct queue *prep_queue;
 	unsigned int max_prep_queue_len;
@@ -118,6 +119,7 @@ static void bt_gatt_server_free(struct bt_gatt_server *server)
 	bt_att_unregister(server->att, server->read_id);
 	bt_att_unregister(server->att, server->read_blob_id);
 	bt_att_unregister(server->att, server->prep_write_id);
+	bt_att_unregister(server->att, server->exec_write_id);
 
 	if (server->pending_read_op)
 		server->pending_read_op->server = NULL;
@@ -1037,6 +1039,119 @@ done:
 									NULL);
 }
 
+static void exec_next_prep_write(struct bt_gatt_server *server,
+					uint16_t ehandle, uint8_t att_ecode);
+
+static void exec_write_complete_cb(struct gatt_db_attribute *attr, int err,
+								void *user_data)
+{
+	struct bt_gatt_server *server = user_data;
+	uint16_t handle = gatt_db_attribute_get_handle(attr);
+	uint16_t att_ecode = att_ecode_from_error(err);
+
+	exec_next_prep_write(server, handle, att_ecode);
+}
+
+static void exec_next_prep_write(struct bt_gatt_server *server,
+					uint16_t ehandle, uint8_t att_ecode)
+{
+	struct prep_write_data *next = NULL;
+	uint8_t rsp_opcode = BT_ATT_OP_EXEC_WRITE_RSP;
+	uint8_t error_pdu[4];
+	uint8_t *rsp_pdu = NULL;
+	uint16_t rsp_len = 0;
+	struct gatt_db_attribute *attr;
+	bool status;
+
+	if (att_ecode)
+		goto error;
+
+	next = queue_pop_head(server->prep_queue);
+	if (!next)
+		goto done;
+
+	attr = gatt_db_get_attribute(server->db, next->handle);
+	if (!attr) {
+		att_ecode = BT_ATT_ERROR_UNLIKELY;
+		goto error;
+	}
+
+	status = gatt_db_attribute_write(attr, next->offset,
+						next->value, next->length,
+						BT_ATT_OP_EXEC_WRITE_REQ, NULL,
+						exec_write_complete_cb, server);
+
+	prep_write_data_destroy(next);
+
+	if (status)
+		return;
+
+	att_ecode = BT_ATT_ERROR_UNLIKELY;
+
+error:
+	rsp_opcode = BT_ATT_OP_ERROR_RSP;
+	rsp_len = 4;
+	rsp_pdu = error_pdu;
+	encode_error_rsp(BT_ATT_OP_EXEC_WRITE_REQ, ehandle, att_ecode, rsp_pdu);
+
+done:
+	bt_att_send(server->att, rsp_opcode, rsp_pdu, rsp_len, NULL, NULL,
+									NULL);
+}
+
+static void exec_write_cb(uint8_t opcode, const void *pdu,
+					uint16_t length, void *user_data)
+{
+	struct bt_gatt_server *server = user_data;
+	uint8_t flags;
+	uint8_t ecode;
+	uint8_t rsp_opcode;
+	uint8_t error_pdu[4];
+	uint8_t *rsp_pdu = NULL;
+	uint16_t rsp_len = 0;
+	bool write;
+
+	if (length != 1) {
+		ecode = BT_ATT_ERROR_INVALID_PDU;
+		goto error;
+	}
+
+	flags = ((uint8_t *) pdu)[0];
+
+	util_debug(server->debug_callback, server->debug_data,
+				"Exec Write Req - flags: 0x%02x", flags);
+
+	if (flags == 0x00)
+		write = false;
+	else if (flags == 0x01)
+		write = true;
+	else {
+		ecode = BT_ATT_ERROR_INVALID_PDU;
+		goto error;
+	}
+
+	if (!write) {
+		queue_remove_all(server->prep_queue, NULL, NULL,
+						prep_write_data_destroy);
+		rsp_opcode = BT_ATT_OP_EXEC_WRITE_RSP;
+		goto done;
+	}
+
+	exec_next_prep_write(server, 0, 0);
+
+	return;
+
+error:
+	rsp_opcode = BT_ATT_OP_ERROR_RSP;
+	rsp_len = 4;
+	rsp_pdu = error_pdu;
+	encode_error_rsp(opcode, 0, ecode, rsp_pdu);
+
+done:
+	bt_att_send(server->att, rsp_opcode, rsp_pdu, rsp_len, NULL, NULL,
+									NULL);
+}
+
 static void exchange_mtu_cb(uint8_t opcode, const void *pdu,
 					uint16_t length, void *user_data)
 {
@@ -1137,6 +1252,13 @@ static bool gatt_server_register_att_handlers(struct bt_gatt_server *server)
 	if (!server->prep_write_id)
 		return false;
 
+	/* Execute Write Request */
+	server->exec_write_id = bt_att_register(server->att,
+						BT_ATT_OP_EXEC_WRITE_REQ,
+						exec_write_cb, server, NULL);
+	if (!server->exec_write_id)
+		return NULL;
+
 	return true;
 }
 
-- 
2.1.0.rc2.206.gedb03e5

