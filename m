Return-Path: <cyrus@holtmann.org>
From: Michael Janssen <jamuraa@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Michael Janssen <jamuraa@chromium.org>
Subject: [PATCH BlueZ 12/23] shared/gatt-server: Add read multiple support.
Date: Wed, 21 Jan 2015 12:28:49 -0800
Message-Id: <1421872140-7581-13-git-send-email-jamuraa@chromium.org>
In-Reply-To: <1421872140-7581-1-git-send-email-jamuraa@chromium.org>
References: <1421872140-7581-1-git-send-email-jamuraa@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Add server handling for BT_ATT_OP_READ_MULT_REQ.
---
 src/shared/gatt-server.c | 154 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 154 insertions(+)

diff --git a/src/shared/gatt-server.c b/src/shared/gatt-server.c
index f12ac47..b406ed6 100644
--- a/src/shared/gatt-server.c
+++ b/src/shared/gatt-server.c
@@ -92,6 +92,7 @@ struct bt_gatt_server {
 	unsigned int write_cmd_id;
 	unsigned int read_id;
 	unsigned int read_blob_id;
+	unsigned int read_multiple_id;
 	unsigned int prep_write_id;
 	unsigned int exec_write_id;
 
@@ -120,6 +121,7 @@ static void bt_gatt_server_free(struct bt_gatt_server *server)
 	bt_att_unregister(server->att, server->write_cmd_id);
 	bt_att_unregister(server->att, server->read_id);
 	bt_att_unregister(server->att, server->read_blob_id);
+	bt_att_unregister(server->att, server->read_multiple_id);
 	bt_att_unregister(server->att, server->prep_write_id);
 	bt_att_unregister(server->att, server->exec_write_id);
 
@@ -971,6 +973,149 @@ static void read_blob_cb(uint8_t opcode, const void *pdu,
 	handle_read_req(server, opcode, handle, offset);
 }
 
+struct read_multiple_resp_data {
+	struct bt_gatt_server *server;
+	uint16_t *handles;
+	size_t cur_handle;
+	size_t num_handles;
+	uint8_t *rsp_data;
+	size_t length;
+	size_t mtu;
+};
+
+static void read_multiple_resp_data_free(struct read_multiple_resp_data *data)
+{
+	free(data->handles);
+	data->handles = NULL;
+
+	free(data->rsp_data);
+	data->rsp_data = NULL;
+}
+
+static void read_multiple_complete_cb(struct gatt_db_attribute *attr, int err,
+					const uint8_t *value, size_t len,
+					void *user_data)
+{
+	struct read_multiple_resp_data *data = user_data;
+	struct gatt_db_attribute *next_attr;
+	uint32_t perm;
+
+	uint16_t handle = gatt_db_attribute_get_handle(attr);
+
+	if (err != 0) {
+		bt_att_send_error_rsp(data->server->att,
+					BT_ATT_OP_READ_MULT_REQ, handle, err);
+		read_multiple_resp_data_free(data);
+		return;
+	}
+
+	perm = gatt_db_attribute_get_permissions(attr);
+
+	if (perm && !(perm & BT_ATT_PERM_READ)) {
+		bt_att_send_error_rsp(data->server->att,
+					BT_ATT_OP_READ_MULT_REQ, handle,
+					BT_ATT_ERROR_READ_NOT_PERMITTED);
+		read_multiple_resp_data_free(data);
+		return;
+	}
+
+	len = MIN(len, data->mtu - data->length - 1);
+
+	memcpy(data->rsp_data + data->length, value, len);
+	data->length += len;
+
+	data->cur_handle++;
+
+	if ((data->length >= data->mtu - 1) ||
+				(data->cur_handle == data->num_handles)) {
+		bt_att_send(data->server->att, BT_ATT_OP_READ_MULT_RSP,
+				data->rsp_data, data->length, NULL, NULL, NULL);
+		read_multiple_resp_data_free(data);
+		return;
+	}
+
+	util_debug(data->server->debug_callback, data->server->debug_data,
+				"Read Multiple Req - #%lu of %lu: 0x%04x",
+				data->cur_handle + 1, data->num_handles,
+				data->handles[data->cur_handle]);
+
+	next_attr = gatt_db_get_attribute(data->server->db,
+					data->handles[data->cur_handle]);
+
+	if (!next_attr) {
+		bt_att_send_error_rsp(data->server->att,
+					BT_ATT_OP_READ_MULT_REQ,
+					data->handles[data->cur_handle],
+					BT_ATT_ERROR_INVALID_HANDLE);
+		read_multiple_resp_data_free(data);
+		return;
+	}
+
+	if (!gatt_db_attribute_read(next_attr, 0, BT_ATT_OP_READ_MULT_REQ, NULL,
+					read_multiple_complete_cb, data)) {
+		bt_att_send_error_rsp(data->server->att,
+						BT_ATT_OP_READ_MULT_REQ,
+						data->handles[data->cur_handle],
+						BT_ATT_ERROR_UNLIKELY);
+		read_multiple_resp_data_free(data);
+	}
+}
+
+static void read_multiple_cb(uint8_t opcode, const void *pdu,
+					uint16_t length, void *user_data)
+{
+	struct bt_gatt_server *server = user_data;
+	struct gatt_db_attribute *attr;
+	struct read_multiple_resp_data data;
+	uint8_t ecode = BT_ATT_ERROR_UNLIKELY;
+	size_t i = 0;
+
+	data.handles = NULL;
+	data.rsp_data = NULL;
+
+	if (length < 4) {
+		ecode = BT_ATT_ERROR_INVALID_PDU;
+		goto error;
+	}
+
+	data.server = server;
+	data.num_handles = length / 2;
+	data.cur_handle = 0;
+	data.mtu = bt_att_get_mtu(server->att);
+	data.length = 0;
+	data.rsp_data = malloc(data.mtu - 1);
+
+	if (!data.rsp_data)
+		goto error;
+
+	data.handles = new0(uint16_t, data.num_handles);
+
+	if (!data.handles)
+		goto error;
+
+	for (i = 0; i < data.num_handles; i++)
+		data.handles[i] = get_le16(pdu + i * 2);
+
+	util_debug(server->debug_callback, server->debug_data,
+			"Read Multiple Req - %lu handles, 1st: 0x%04x",
+			data.num_handles, data.handles[0]);
+
+	attr = gatt_db_get_attribute(server->db, data.handles[0]);
+
+	if (!attr) {
+		ecode = BT_ATT_ERROR_INVALID_HANDLE;
+		goto error;
+	}
+
+	if (gatt_db_attribute_read(attr, 0, opcode, NULL,
+					read_multiple_complete_cb, &data))
+		return;
+
+error:
+	read_multiple_resp_data_free(&data);
+	bt_att_send_error_rsp(server->att, opcode, 0, ecode);
+}
+
 static void prep_write_cb(uint8_t opcode, const void *pdu,
 					uint16_t length, void *user_data)
 {
@@ -1248,6 +1393,15 @@ static bool gatt_server_register_att_handlers(struct bt_gatt_server *server)
 	if (!server->read_blob_id)
 		return false;
 
+	/* Read Multiple Request */
+	server->read_multiple_id = bt_att_register(server->att,
+							BT_ATT_OP_READ_MULT_REQ,
+							read_multiple_cb,
+							server, NULL);
+
+	if (!server->read_multiple_id)
+		return false;
+
 	/* Prepare Write Request */
 	server->prep_write_id = bt_att_register(server->att,
 						BT_ATT_OP_PREP_WRITE_REQ,
-- 
2.2.0.rc0.207.ga3a616c

