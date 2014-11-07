Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH BlueZ v1 08/11] shared/gatt-server: Implement "Prepare Write" request.
Date: Fri,  7 Nov 2014 12:41:56 -0800
Message-Id: <1415392919-17572-9-git-send-email-armansito@chromium.org>
In-Reply-To: <1415392919-17572-1-git-send-email-armansito@chromium.org>
References: <1415392919-17572-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch add support for handling ATT "Prepare Write" requests for the
server role.
---
 src/shared/gatt-server.c | 142 +++++++++++++++++++++++++++++++++++++++++++++++
 src/shared/gatt-server.h |   3 +
 2 files changed, 145 insertions(+)

diff --git a/src/shared/gatt-server.c b/src/shared/gatt-server.c
index e77acce..48a55e7 100644
--- a/src/shared/gatt-server.c
+++ b/src/shared/gatt-server.c
@@ -40,6 +40,8 @@
 #define MIN(a, b) ((a) < (b) ? (a) : (b))
 #endif
 
+#define DEFAULT_MAX_PREP_QUEUE_LEN 5
+
 struct async_read_op {
 	struct bt_gatt_server *server;
 	uint8_t opcode;
@@ -55,6 +57,22 @@ struct async_write_op {
 	uint8_t opcode;
 };
 
+struct prep_write_data {
+	struct bt_gatt_server *server;
+	uint8_t *value;
+	uint16_t handle;
+	uint16_t offset;
+	uint16_t length;
+};
+
+static void prep_write_data_destroy(void *user_data)
+{
+	struct prep_write_data *data = user_data;
+
+	free(data->value);
+	free(data);
+}
+
 struct bt_gatt_server {
 	struct gatt_db *db;
 	struct bt_att *att;
@@ -69,6 +87,10 @@ struct bt_gatt_server {
 	unsigned int write_cmd_id;
 	unsigned int read_id;
 	unsigned int read_blob_id;
+	unsigned int prep_write_id;
+
+	struct queue *prep_queue;
+	unsigned int max_prep_queue_len;
 
 	struct async_read_op *pending_read_op;
 	struct async_write_op *pending_write_op;
@@ -91,6 +113,7 @@ static void bt_gatt_server_free(struct bt_gatt_server *server)
 	bt_att_unregister(server->att, server->write_cmd_id);
 	bt_att_unregister(server->att, server->read_id);
 	bt_att_unregister(server->att, server->read_blob_id);
+	bt_att_unregister(server->att, server->prep_write_id);
 
 	if (server->pending_read_op)
 		server->pending_read_op->server = NULL;
@@ -98,6 +121,8 @@ static void bt_gatt_server_free(struct bt_gatt_server *server)
 	if (server->pending_write_op)
 		server->pending_write_op->server = NULL;
 
+	queue_destroy(server->prep_queue, prep_write_data_destroy);
+
 	bt_att_unref(server->att);
 	free(server);
 }
@@ -922,6 +947,98 @@ static void read_blob_cb(uint8_t opcode, const void *pdu,
 	handle_read_req(server, opcode, handle, offset);
 }
 
+static void prep_write_cb(uint8_t opcode, const void *pdu,
+					uint16_t length, void *user_data)
+{
+	struct bt_gatt_server *server = user_data;
+	struct prep_write_data *prep_data = NULL;
+	uint16_t handle = 0;
+	uint16_t offset;
+	struct gatt_db_attribute *attr;
+	uint8_t rsp_opcode;
+	uint8_t rsp_pdu[MAX(4, length)];
+	uint16_t rsp_len;
+	uint8_t ecode;
+	uint32_t perm;
+
+	if (length < 4) {
+		ecode = BT_ATT_ERROR_INVALID_PDU;
+		goto error;
+	}
+
+	if (queue_length(server->prep_queue) >= server->max_prep_queue_len) {
+		ecode = BT_ATT_ERROR_PREPARE_QUEUE_FULL;
+		goto error;
+	}
+
+	handle = get_le16(pdu);
+	offset = get_le16(pdu + 2);
+
+	attr = gatt_db_get_attribute(server->db, handle);
+	if (!attr) {
+		ecode = BT_ATT_ERROR_INVALID_HANDLE;
+		goto error;
+	}
+
+	if (!gatt_db_attribute_get_permissions(attr, &perm)) {
+		ecode = BT_ATT_ERROR_INVALID_HANDLE;
+		goto error;
+	}
+
+	/*
+	 * TODO: The "Prepare Write" request requires security permission checks
+	 * to be performed before the write is executed. I.e., we can't leave
+	 * the permission check to the upper layer since we can't call
+	 * gatt_db_write until the entire queue is atomically processed during
+	 * an "Execute Write" request. Figure out how to make this check here.
+	 */
+	if (!(perm & BT_ATT_PERM_WRITE)) {
+		ecode = BT_ATT_ERROR_WRITE_NOT_PERMITTED;
+		goto error;
+	}
+
+	prep_data = new0(struct prep_write_data, 1);
+	if (!prep_data) {
+		ecode = BT_ATT_ERROR_INSUFFICIENT_RESOURCES;
+		goto error;
+	}
+
+	prep_data->length = length - 4;
+	if (prep_data->length) {
+		prep_data->value = malloc(prep_data->length);
+		if (!prep_data->value) {
+			ecode = BT_ATT_ERROR_INSUFFICIENT_RESOURCES;
+			goto error;
+		}
+	}
+
+	prep_data->server = server;
+	prep_data->handle = handle;
+	prep_data->offset = offset;
+	memcpy(prep_data->value, pdu + 4, prep_data->length);
+
+	queue_push_tail(server->prep_queue, prep_data);
+
+	/* Create the response */
+	rsp_len = length;
+	rsp_opcode = BT_ATT_OP_PREP_WRITE_RSP;
+	memcpy(rsp_pdu, pdu, rsp_len);
+
+	goto done;
+
+error:
+	if (prep_data)
+		prep_write_data_destroy(prep_data);
+
+	rsp_opcode = BT_ATT_OP_ERROR_RSP;
+	rsp_len = 4;
+	encode_error_rsp(opcode, handle, ecode, rsp_pdu);
+
+done:
+	bt_att_send(server->att, rsp_opcode, rsp_pdu, rsp_len, NULL, NULL,
+									NULL);
+}
+
 static void exchange_mtu_cb(uint8_t opcode, const void *pdu,
 					uint16_t length, void *user_data)
 {
@@ -1015,6 +1132,13 @@ static bool gatt_server_register_att_handlers(struct bt_gatt_server *server)
 	if (!server->read_blob_id)
 		return false;
 
+	/* Prepare Write Request */
+	server->prep_write_id = bt_att_register(server->att,
+						BT_ATT_OP_PREP_WRITE_REQ,
+						prep_write_cb, server, NULL);
+	if (!server->prep_write_id)
+		return false;
+
 	return true;
 }
 
@@ -1033,6 +1157,13 @@ struct bt_gatt_server *bt_gatt_server_new(struct gatt_db *db,
 	server->db = db;
 	server->att = bt_att_ref(att);
 	server->mtu = MAX(mtu, BT_ATT_DEFAULT_LE_MTU);
+	server->max_prep_queue_len = DEFAULT_MAX_PREP_QUEUE_LEN;
+
+	server->prep_queue = queue_new();
+	if (!server->prep_queue) {
+		bt_gatt_server_free(server);
+		return NULL;
+	}
 
 	if (!gatt_server_register_att_handlers(server)) {
 		bt_gatt_server_free(server);
@@ -1078,6 +1209,17 @@ bool bt_gatt_server_set_debug(struct bt_gatt_server *server,
 	return true;
 }
 
+bool bt_gatt_server_set_max_prep_queue_length(struct bt_gatt_server *server,
+							unsigned int length)
+{
+	if (!server || !length)
+		return false;
+
+	server->max_prep_queue_len = length;
+
+	return true;
+}
+
 bool bt_gatt_server_send_notification(struct bt_gatt_server *server,
 					uint16_t handle, const uint8_t *value,
 					uint16_t length)
diff --git a/src/shared/gatt-server.h b/src/shared/gatt-server.h
index 0e480e1..a95613c 100644
--- a/src/shared/gatt-server.h
+++ b/src/shared/gatt-server.h
@@ -40,6 +40,9 @@ bool bt_gatt_server_set_debug(struct bt_gatt_server *server,
 					void *user_data,
 					bt_gatt_server_destroy_func_t destroy);
 
+bool bt_gatt_server_set_max_prep_queue_length(struct bt_gatt_server *server,
+							unsigned int length);
+
 bool bt_gatt_server_send_notification(struct bt_gatt_server *server,
 					uint16_t handle, const uint8_t *value,
 					uint16_t length);
-- 
2.1.0.rc2.206.gedb03e5

