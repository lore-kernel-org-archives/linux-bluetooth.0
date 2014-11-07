Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH BlueZ v1 02/11] shared/gatt-server: Implement "Find Information" request.
Date: Fri,  7 Nov 2014 12:41:50 -0800
Message-Id: <1415392919-17572-3-git-send-email-armansito@chromium.org>
In-Reply-To: <1415392919-17572-1-git-send-email-armansito@chromium.org>
References: <1415392919-17572-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch implements the "Find Information" request for the GATT
server role.
---
 src/shared/gatt-server.c | 156 ++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 155 insertions(+), 1 deletion(-)

diff --git a/src/shared/gatt-server.c b/src/shared/gatt-server.c
index ddb0be1..ddb714d 100644
--- a/src/shared/gatt-server.c
+++ b/src/shared/gatt-server.c
@@ -59,6 +59,7 @@ struct bt_gatt_server {
 	unsigned int mtu_id;
 	unsigned int read_by_grp_type_id;
 	unsigned int read_by_type_id;
+	unsigned int find_info_id;
 
 	struct async_read_op *pending_read_op;
 
@@ -75,11 +76,12 @@ static void bt_gatt_server_free(struct bt_gatt_server *server)
 	bt_att_unregister(server->att, server->mtu_id);
 	bt_att_unregister(server->att, server->read_by_grp_type_id);
 	bt_att_unregister(server->att, server->read_by_type_id);
-	bt_att_unref(server->att);
+	bt_att_unregister(server->att, server->find_info_id);
 
 	if (server->pending_read_op)
 		server->pending_read_op->server = NULL;
 
+	bt_att_unref(server->att);
 	free(server);
 }
 
@@ -480,6 +482,150 @@ error:
 							NULL, NULL, NULL);
 }
 
+static void put_uuid_le(const bt_uuid_t *src, void *dst)
+{
+	bt_uuid_t uuid;
+
+	switch (src->type) {
+	case BT_UUID16:
+		put_le16(src->value.u16, dst);
+		break;
+	case BT_UUID128:
+		bswap_128(&src->value.u128, dst);
+		break;
+	case BT_UUID32:
+		bt_uuid_to_uuid128(src, &uuid);
+		bswap_128(&uuid.value.u128, dst);
+		break;
+	default:
+		break;
+	}
+}
+
+static bool encode_find_info_rsp(struct gatt_db *db, struct queue *q,
+						uint16_t mtu,
+						uint8_t *pdu, uint16_t *len)
+{
+	uint16_t handle;
+	struct gatt_db_attribute *attr;
+	const bt_uuid_t *type;
+	int uuid_len, cur_uuid_len;
+	int iter = 0;
+
+	*len = 0;
+
+	while (queue_peek_head(q)) {
+		attr = queue_pop_head(q);
+		handle = gatt_db_attribute_get_handle(attr);
+		type = gatt_db_attribute_get_type(attr);
+		if (!handle || !type)
+			return false;
+
+		cur_uuid_len = bt_uuid_len(type);
+
+		if (iter == 0) {
+			switch (cur_uuid_len) {
+			case 2:
+				uuid_len = 2;
+				pdu[0] = 0x01;
+				break;
+			case 4:
+			case 16:
+				uuid_len = 16;
+				pdu[0] = 0x02;
+				break;
+			default:
+				return false;
+			}
+
+			iter++;
+		} else if (cur_uuid_len != uuid_len)
+			break;
+
+		if (iter + uuid_len + 2 > mtu - 1)
+			break;
+
+		put_le16(handle, pdu + iter);
+		put_uuid_le(type, pdu + iter + 2);
+
+		iter += uuid_len + 2;
+	}
+
+	*len = iter;
+
+	return true;
+}
+
+static void find_info_cb(uint8_t opcode, const void *pdu,
+					uint16_t length, void *user_data)
+{
+	struct bt_gatt_server *server = user_data;
+	uint16_t start, end;
+	uint16_t mtu = bt_att_get_mtu(server->att);
+	uint8_t rsp_pdu[mtu];
+	uint16_t rsp_len;
+	uint8_t rsp_opcode;
+	uint8_t ecode = 0;
+	uint16_t ehandle = 0;
+	struct queue *q = NULL;
+
+	if (length != 4) {
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
+
+	util_debug(server->debug_callback, server->debug_data,
+					"Find Info - start: 0x%04x end: 0x%04x",
+					start, end);
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
+	gatt_db_find_information(server->db, start, end, q);
+
+	if (queue_isempty(q)) {
+		ecode = BT_ATT_ERROR_ATTRIBUTE_NOT_FOUND;
+		goto error;
+	}
+
+	if (!encode_find_info_rsp(server->db, q, mtu, rsp_pdu, &rsp_len)) {
+		ecode = BT_ATT_ERROR_UNLIKELY;
+		goto error;
+	}
+
+	rsp_opcode = BT_ATT_OP_FIND_INFO_RSP;
+
+	goto done;
+
+error:
+	rsp_opcode = BT_ATT_OP_ERROR_RSP;
+	rsp_len = 4;
+	encode_error_rsp(opcode, ehandle, ecode, rsp_pdu);
+
+done:
+	queue_destroy(q, NULL);
+	bt_att_send(server->att, rsp_opcode, rsp_pdu, rsp_len,
+							NULL, NULL, NULL);
+}
+
 static void exchange_mtu_cb(uint8_t opcode, const void *pdu,
 					uint16_t length, void *user_data)
 {
@@ -536,6 +682,14 @@ static bool gatt_server_register_att_handlers(struct bt_gatt_server *server)
 	if (!server->read_by_type_id)
 		return false;
 
+	/* Find Information */
+	server->find_info_id = bt_att_register(server->att,
+							BT_ATT_OP_FIND_INFO_REQ,
+							find_info_cb,
+							server, NULL);
+	if (!server->find_info_id)
+		return false;
+
 	return true;
 }
 
-- 
2.1.0.rc2.206.gedb03e5

