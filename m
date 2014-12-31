Return-Path: <cyrus@holtmann.org>
From: Michael Janssen <jamuraa@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Michael Janssen <jamuraa@chromium.org>
Subject: [PATCH BlueZ 02/14] shared/gatt-server: support Discover by UUID
Date: Tue, 30 Dec 2014 16:32:20 -0800
Message-Id: <1419985952-18334-3-git-send-email-jamuraa@chromium.org>
In-Reply-To: <1419985952-18334-1-git-send-email-jamuraa@chromium.org>
References: <1419985952-18334-1-git-send-email-jamuraa@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Implements Find By Type Value parsing and response, supporting the
"Discovery Primary Service by UUID" of GATT.
---
 src/shared/gatt-server.c | 107 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 107 insertions(+)

diff --git a/src/shared/gatt-server.c b/src/shared/gatt-server.c
index 00f36fd..985cca1 100644
--- a/src/shared/gatt-server.c
+++ b/src/shared/gatt-server.c
@@ -87,6 +87,7 @@ struct bt_gatt_server {
 	unsigned int read_by_grp_type_id;
 	unsigned int read_by_type_id;
 	unsigned int find_info_id;
+	unsigned int find_by_type_value_id;
 	unsigned int write_id;
 	unsigned int write_cmd_id;
 	unsigned int read_id;
@@ -114,6 +115,7 @@ static void bt_gatt_server_free(struct bt_gatt_server *server)
 	bt_att_unregister(server->att, server->read_by_grp_type_id);
 	bt_att_unregister(server->att, server->read_by_type_id);
 	bt_att_unregister(server->att, server->find_info_id);
+	bt_att_unregister(server->att, server->find_by_type_value_id);
 	bt_att_unregister(server->att, server->write_id);
 	bt_att_unregister(server->att, server->write_cmd_id);
 	bt_att_unregister(server->att, server->read_id);
@@ -639,6 +641,102 @@ error:
 
 }
 
+static bool encode_find_by_type_value_rsp(struct queue *q, uint16_t mtu,
+						uint8_t *pdu, uint16_t *len)
+{
+	struct gatt_db_attribute *attr;
+	uint16_t handle, end_handle;
+	uint16_t iter = 0;
+
+	*len = 0;
+	while (queue_peek_head(q)) {
+		/*
+		 * This OP is only valid for Primary Service per the spec
+		 * page 562, so this should work.
+		 */
+		attr = queue_pop_head(q);
+		gatt_db_attribute_get_service_data(attr, &handle, &end_handle,
+								NULL, NULL);
+		if (!handle || !end_handle)
+			return false;
+
+		if (iter + 4 > mtu - 1)
+			break;
+
+		put_le16(handle, pdu + iter);
+		put_le16(end_handle, pdu + iter + 2);
+
+		iter += 4;
+	}
+
+	*len = iter;
+
+	return true;
+}
+
+static void find_by_type_val_cb(uint8_t opcode, const void *pdu,
+					uint16_t length, void *user_data)
+{
+	struct bt_gatt_server *server = user_data;
+	uint16_t start, end, uuid16;
+	uint16_t mtu = bt_att_get_mtu(server->att);
+	uint8_t rsp_pdu[mtu];
+	uint16_t rsp_len;
+	uint8_t ecode = 0;
+	uint16_t ehandle = 0;
+	bt_uuid_t uuid;
+	struct queue *q = NULL;
+
+	if (length < 6) {
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
+	uuid16 = get_le16(pdu + 4);
+
+	util_debug(server->debug_callback, server->debug_data,
+			"Find By Type Value - start: 0x%04x end: 0x%04x uuid: 0x%04x",
+			start, end, uuid16);
+	ehandle = start;
+	if (start > end) {
+		ecode = BT_ATT_ERROR_INVALID_HANDLE;
+		goto error;
+	}
+
+	bt_uuid16_create(&uuid, uuid16);
+	gatt_db_find_by_type_value(server->db, start, end, &uuid, pdu + 6,
+								length - 6, q);
+
+	if (queue_isempty(q)) {
+		ecode = BT_ATT_ERROR_ATTRIBUTE_NOT_FOUND;
+		goto error;
+	}
+
+	if (!encode_find_by_type_value_rsp(q, mtu, rsp_pdu, &rsp_len)) {
+		ecode = BT_ATT_ERROR_UNLIKELY;
+		goto error;
+	}
+
+	bt_att_send(server->att, BT_ATT_OP_FIND_BY_TYPE_VAL_RSP, rsp_pdu,
+						rsp_len, NULL, NULL, NULL);
+
+	queue_destroy(q, NULL);
+
+	return;
+
+error:
+	bt_att_send_error_rsp(server->att, opcode, ehandle, ecode);
+	queue_destroy(q, NULL);
+}
+
 static void async_write_op_destroy(struct async_write_op *op)
 {
 	if (op->server)
@@ -1128,6 +1226,15 @@ static bool gatt_server_register_att_handlers(struct bt_gatt_server *server)
 	if (!server->find_info_id)
 		return false;
 
+	/* Find By Type Value */
+	server->find_by_type_value_id = bt_att_register(server->att,
+						BT_ATT_OP_FIND_BY_TYPE_VAL_REQ,
+						find_by_type_val_cb,
+						server, NULL);
+
+	if (!server->find_by_type_value_id)
+		return false;
+
 	/* Write Request */
 	server->write_id = bt_att_register(server->att, BT_ATT_OP_WRITE_REQ,
 								write_cb,
-- 
2.2.0.rc0.207.ga3a616c

