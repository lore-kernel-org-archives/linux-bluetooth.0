Return-Path: <cyrus@holtmann.org>
From: Michael Janssen <jamuraa@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Michael Janssen <jamuraa@chromium.org>
Subject: [PATCH BlueZ v2 03/12] shared/gatt-server: support Discover by UUID
Date: Mon,  5 Jan 2015 13:32:45 -0800
Message-Id: <1420493574-37305-4-git-send-email-jamuraa@chromium.org>
In-Reply-To: <1420493574-37305-1-git-send-email-jamuraa@chromium.org>
References: <1420493574-37305-1-git-send-email-jamuraa@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Implements Find By Type Value parsing and response, supporting the
"Discovery Primary Service by UUID" of GATT.
---
 src/shared/gatt-server.c | 103 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 103 insertions(+)

diff --git a/src/shared/gatt-server.c b/src/shared/gatt-server.c
index 00f36fd..ed1b274 100644
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
@@ -639,6 +641,98 @@ error:
 
 }
 
+struct find_by_type_val_data {
+	uint8_t *pdu;
+	uint16_t len;
+	uint16_t mtu;
+	uint8_t ecode;
+};
+
+static void find_by_type_val_att_cb(struct gatt_db_attribute *attrib,
+								void *user_data)
+{
+	uint16_t handle, end_handle;
+	struct find_by_type_val_data *data = user_data;
+
+	if (data->ecode)
+		return;
+
+	if (data->len + 4 > data->mtu - 1)
+		return;
+
+	/*
+	 * This OP is only valid for Primary Service per the spec
+	 * page 562, so this should work.
+	 */
+	gatt_db_attribute_get_service_data(attrib, &handle, &end_handle, NULL,
+									NULL);
+
+	if (!handle || !end_handle) {
+		data->ecode = BT_ATT_ERROR_UNLIKELY;
+		return;
+	}
+
+	put_le16(handle, data->pdu + data->len);
+	put_le16(end_handle, data->pdu + data->len + 2);
+
+	data->len += 4;
+}
+
+static void find_by_type_val_cb(uint8_t opcode, const void *pdu,
+					uint16_t length, void *user_data)
+{
+	struct bt_gatt_server *server = user_data;
+	uint16_t start, end, uuid16;
+	struct find_by_type_val_data data;
+	uint16_t mtu = bt_att_get_mtu(server->att);
+	uint8_t rsp_pdu[mtu];
+	uint16_t ehandle = 0;
+	bt_uuid_t uuid;
+
+	if (length < 6) {
+		data.ecode = BT_ATT_ERROR_INVALID_PDU;
+		goto error;
+	}
+
+	data.pdu = rsp_pdu;
+	data.len = 0;
+	data.mtu = mtu;
+	data.ecode = 0;
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
+		data.ecode = BT_ATT_ERROR_INVALID_HANDLE;
+		goto error;
+	}
+
+	bt_uuid16_create(&uuid, uuid16);
+	gatt_db_find_by_type_value(server->db, start, end, &uuid, pdu + 6,
+							length - 6,
+							find_by_type_val_att_cb,
+							&data);
+
+	if (!data.len)
+		data.ecode = BT_ATT_ERROR_ATTRIBUTE_NOT_FOUND;
+
+	if (data.ecode)
+		goto error;
+
+	bt_att_send(server->att, BT_ATT_OP_FIND_BY_TYPE_VAL_RSP, data.pdu,
+						data.len, NULL, NULL, NULL);
+
+	return;
+
+error:
+	bt_att_send_error_rsp(server->att, opcode, ehandle, data.ecode);
+}
+
 static void async_write_op_destroy(struct async_write_op *op)
 {
 	if (op->server)
@@ -1128,6 +1222,15 @@ static bool gatt_server_register_att_handlers(struct bt_gatt_server *server)
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

