Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH v2 5/5] shared/gatt-server: Support Read By Group Type request.
Date: Mon, 13 Oct 2014 14:10:02 -0700
Message-Id: <1413234602-20566-6-git-send-email-armansito@chromium.org>
In-Reply-To: <1413234602-20566-1-git-send-email-armansito@chromium.org>
References: <1413234602-20566-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds handling for the Read By Group Type request.
---
 src/shared/gatt-server.c | 179 ++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 178 insertions(+), 1 deletion(-)

diff --git a/src/shared/gatt-server.c b/src/shared/gatt-server.c
index c7b0873..d6d0155 100644
--- a/src/shared/gatt-server.c
+++ b/src/shared/gatt-server.c
@@ -45,6 +45,7 @@ struct bt_gatt_server {
 	uint16_t mtu;
 
 	unsigned int mtu_id;
+	unsigned int read_by_grp_type_id;
 
 	bt_gatt_server_debug_func_t debug_callback;
 	bt_gatt_server_destroy_func_t debug_destroy;
@@ -54,6 +55,7 @@ struct bt_gatt_server {
 static void gatt_server_unregister_handlers(struct bt_gatt_server *server)
 {
 	bt_att_unregister(server->att, server->mtu_id);
+	bt_att_unregister(server->att, server->read_by_grp_type_id);
 }
 
 static void gatt_server_cleanup(struct bt_gatt_server *server)
@@ -71,6 +73,166 @@ static void encode_error_rsp(uint8_t opcode, uint16_t handle, uint8_t ecode,
 	put_le16(handle, pdu + 1);
 }
 
+static bool get_uuid_le(const uint8_t *uuid, size_t len, bt_uuid_t *out_uuid)
+{
+	uint128_t u128;
+
+	switch (len) {
+	case 2:
+		bt_uuid16_create(out_uuid, get_le16(uuid));
+		return true;
+	case 16:
+		bswap_128(uuid, &u128.data);
+		bt_uuid128_create(out_uuid, u128);
+		return true;
+	default:
+		return false;
+	}
+
+	return false;
+}
+
+static bool encode_read_by_grp_type_rsp(struct gatt_db *db, struct queue *q,
+						uint16_t mtu,
+						uint8_t *pdu, uint16_t *len)
+{
+	int iter = 0;
+	uint16_t start_handle, end_handle;
+	uint8_t *value;
+	int value_len;
+	uint8_t data_val_len;
+
+	*len = 0;
+
+	while (queue_peek_head(q)) {
+		start_handle = PTR_TO_UINT(queue_pop_head(q));
+		value = NULL;
+		value_len = 0;
+
+		/* This should never be deferred to the read callback for
+		 * primary/secondary service declarations.
+		 */
+		if (!gatt_db_read(db, start_handle, 0,
+						BT_ATT_OP_READ_BY_GRP_TYPE_REQ,
+						NULL, &value,
+						&value_len) || value_len < 0)
+			return false;
+
+		/* Use the first attribute to determine the length of each
+		 * attribute data unit. Stop the list when a different attribute
+		 * value is seen.
+		 */
+		if (iter == 0) {
+			data_val_len = value_len;
+			pdu[0] = data_val_len + 4;
+			iter++;
+		} else if (value_len != data_val_len)
+			break;
+
+		/* Stop if this unit would surpass the MTU */
+		if (iter + data_val_len + 4 > mtu)
+			break;
+
+		end_handle = gatt_db_get_end_handle(db, start_handle);
+
+		put_le16(start_handle, pdu + iter);
+		put_le16(end_handle, pdu + iter + 2);
+		memcpy(pdu + iter + 4, value, value_len);
+
+		iter += data_val_len + 4;
+	}
+
+	*len = iter;
+
+	return true;
+}
+
+static void read_by_grp_type_cb(uint8_t opcode, const void *pdu,
+					uint16_t length, void *user_data)
+{
+	struct bt_gatt_server *server = user_data;
+	uint16_t start, end;
+	bt_uuid_t type;
+	bt_uuid_t prim, snd;
+	uint16_t mtu = bt_att_get_mtu(server->att);
+	uint8_t rsp_pdu[mtu];
+	uint16_t rsp_len;
+	uint8_t rsp_opcode;
+	uint8_t ecode = 0;
+	uint16_t ehandle = 0;
+	struct queue *q = NULL;
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
+				"Read By Grp Type - start: 0x%04x end: 0x%04x",
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
+	/* GATT defines that only the <<Primary Service>> and
+	 * <<Secondary Service>> group types can be used for the
+	 * "Read By Group Type" request (Core v4.1, Vol 3, sec 2.5.3). Return an
+	 * error if any other group type is given.
+	 */
+	bt_uuid16_create(&prim, GATT_PRIM_SVC_UUID);
+	bt_uuid16_create(&snd, GATT_SND_SVC_UUID);
+	if (bt_uuid_cmp(&type, &prim) && bt_uuid_cmp(&type, &snd)) {
+		ecode = BT_ATT_ERROR_UNSUPPORTED_GROUP_TYPE;
+		goto error;
+	}
+
+	gatt_db_read_by_group_type(server->db, start, end, type, q);
+
+	if (queue_isempty(q)) {
+		ecode = BT_ATT_ERROR_ATTRIBUTE_NOT_FOUND;
+		goto error;
+	}
+
+	if (!encode_read_by_grp_type_rsp(server->db, q, mtu, rsp_pdu,
+								&rsp_len)) {
+		ecode = BT_ATT_ERROR_UNLIKELY;
+		goto error;
+	}
+
+	rsp_opcode = BT_ATT_OP_READ_BY_GRP_TYPE_RSP;
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
@@ -97,18 +259,33 @@ static void exchange_mtu_cb(uint8_t opcode, const void *pdu,
 	/* Set MTU to be the minimum */
 	server->mtu = final_mtu;
 	bt_att_set_mtu(server->att, final_mtu);
+
+	util_debug(server->debug_callback, server->debug_data,
+			"MTU exchange complete, with MTU: %u", final_mtu);
 }
 
 static bool gatt_server_register_att_handlers(struct bt_gatt_server *server)
 {
-	/* EXCHANGE MTU request */
+	/* Exchange MTU */
 	server->mtu_id = bt_att_register(server->att, BT_ATT_OP_MTU_REQ,
 								exchange_mtu_cb,
 								server, NULL);
 	if (!server->mtu_id)
 		return false;
 
+	/* Read By Group Type */
+	server->read_by_grp_type_id = bt_att_register(server->att,
+						BT_ATT_OP_READ_BY_GRP_TYPE_REQ,
+						read_by_grp_type_cb,
+						server, NULL);
+	if (!server->read_by_grp_type_id)
+		goto fail;
+
 	return true;
+
+fail:
+	gatt_server_unregister_handlers(server);
+	return false;
 }
 
 struct bt_gatt_server *bt_gatt_server_new(struct gatt_db *db,
-- 
2.1.0.rc2.206.gedb03e5

