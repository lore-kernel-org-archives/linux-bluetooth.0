Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 4/5] shared/gatt-server: Request authorization for prepare writes.
Date: Wed, 16 May 2018 15:52:29 +0200
Message-Id: <20180516135230.7182-4-grzegorz.kolodziejczyk@codecoup.pl>
In-Reply-To: <20180516135230.7182-1-grzegorz.kolodziejczyk@codecoup.pl>
References: <20180516135230.7182-1-grzegorz.kolodziejczyk@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds gatt-server possibility to request authorization from
application if needed and previously wasn't authorized. Authorization is
requested by sending message with set prepare write authorization reqest
to client.
---
 src/gatt-database.c      | 86 ++++++++++++++++++++++++++++++++++++++++--------
 src/shared/gatt-server.c | 64 ++++++++++++++++++++++++++++++-----
 2 files changed, 127 insertions(+), 23 deletions(-)

diff --git a/src/gatt-database.c b/src/gatt-database.c
index 0ac5b75b0..3326b40db 100644
--- a/src/gatt-database.c
+++ b/src/gatt-database.c
@@ -133,6 +133,7 @@ struct external_chrc {
 	struct queue *pending_reads;
 	struct queue *pending_writes;
 	unsigned int ntfy_cnt;
+	bool authorized;
 };
 
 struct external_desc {
@@ -144,6 +145,7 @@ struct external_desc {
 	bool handled;
 	struct queue *pending_reads;
 	struct queue *pending_writes;
+	bool authorized;
 };
 
 struct pending_op {
@@ -154,6 +156,8 @@ struct pending_op {
 	struct gatt_db_attribute *attrib;
 	struct queue *owner_queue;
 	struct iovec data;
+	bool is_characteristic;
+	bool authorize;
 };
 
 struct notify {
@@ -1937,6 +1941,9 @@ static void append_options(DBusMessageIter *iter, void *user_data)
 							&op->offset);
 	if (link)
 		dict_append_entry(iter, "link", DBUS_TYPE_STRING, &link);
+	if (op->authorize)
+		dict_append_entry(iter, "authorize", DBUS_TYPE_BOOLEAN,
+							&op->authorize);
 }
 
 static void read_setup_cb(DBusMessageIter *iter, void *user_data)
@@ -2008,6 +2015,8 @@ static void write_setup_cb(DBusMessageIter *iter, void *user_data)
 static void write_reply_cb(DBusMessage *message, void *user_data)
 {
 	struct pending_op *op = user_data;
+	struct external_chrc *chrc;
+	struct external_desc *desc;
 	DBusError err;
 	DBusMessageIter iter;
 	uint8_t ecode = 0;
@@ -2027,6 +2036,16 @@ static void write_reply_cb(DBusMessage *message, void *user_data)
 		goto done;
 	}
 
+	if (op->authorize) {
+		if (op->is_characteristic) {
+			chrc = gatt_db_attribute_get_user_data(op->attrib);
+			chrc->authorized = true;
+		} else {
+			desc = gatt_db_attribute_get_user_data(op->attrib);
+			desc->authorized = true;
+		}
+	}
+
 	dbus_message_iter_init(message, &iter);
 	if (dbus_message_iter_has_next(&iter)) {
 		/*
@@ -2045,9 +2064,10 @@ static struct pending_op *pending_write_new(struct btd_device *device,
 					struct queue *owner_queue,
 					struct gatt_db_attribute *attrib,
 					unsigned int id,
-					const uint8_t *value,
-					size_t len,
-					uint16_t offset, uint8_t link_type)
+					const uint8_t *value, size_t len,
+					uint16_t offset, uint8_t link_type,
+					bool is_characteristic,
+					bool authorize)
 {
 	struct pending_op *op;
 
@@ -2062,6 +2082,8 @@ static struct pending_op *pending_write_new(struct btd_device *device,
 	op->id = id;
 	op->offset = offset;
 	op->link_type = link_type;
+	op->is_characteristic = is_characteristic;
+	op->authorize = authorize;
 	queue_push_tail(owner_queue, op);
 
 	return op;
@@ -2073,12 +2095,15 @@ static struct pending_op *send_write(struct btd_device *device,
 					struct queue *owner_queue,
 					unsigned int id,
 					const uint8_t *value, size_t len,
-					uint16_t offset, uint8_t link_type)
+					uint16_t offset, uint8_t link_type,
+					bool is_characteristic,
+					bool authorize)
 {
 	struct pending_op *op;
 
 	op = pending_write_new(device, owner_queue, attrib, id, value, len,
-							offset, link_type);
+					offset, link_type, is_characteristic,
+					authorize);
 
 	if (g_dbus_proxy_method_call(proxy, "WriteValue", write_setup_cb,
 					owner_queue ? write_reply_cb : NULL,
@@ -2191,7 +2216,7 @@ static void acquire_write_reply(DBusMessage *message, void *user_data)
 retry:
 	send_write(op->device, op->attrib, chrc->proxy, NULL, op->id,
 				op->data.iov_base, op->data.iov_len, 0,
-				op->link_type);
+				op->link_type, false, false);
 }
 
 static void acquire_write_setup(DBusMessageIter *iter, void *user_data)
@@ -2229,7 +2254,7 @@ static struct pending_op *acquire_write(struct external_chrc *chrc,
 	struct pending_op *op;
 
 	op = pending_write_new(device, NULL, attrib, id, value, len, 0,
-							link_type);
+						link_type, false, false);
 
 	if (g_dbus_proxy_method_call(chrc->proxy, "AcquireWrite",
 					acquire_write_setup,
@@ -2520,6 +2545,7 @@ static void desc_write_cb(struct gatt_db_attribute *attrib,
 {
 	struct external_desc *desc = user_data;
 	struct btd_device *device;
+	DBusMessageIter iter;
 
 	if (desc->attrib != attrib) {
 		error("Read callback called with incorrect attribute");
@@ -2532,8 +2558,25 @@ static void desc_write_cb(struct gatt_db_attribute *attrib,
 		goto fail;
 	}
 
+	if (opcode == BT_ATT_OP_PREP_WRITE_REQ) {
+		if (!desc->authorized && g_dbus_proxy_get_property(desc->proxy,
+							"Authorize", &iter))
+			send_write(device, attrib, desc->proxy,
+					desc->pending_writes, id, value, len,
+					offset, bt_att_get_link_type(att),
+					false, true);
+		else
+			gatt_db_attribute_write_result(attrib, id, 0);
+
+		return;
+	}
+
+	if (opcode == BT_ATT_OP_EXEC_WRITE_REQ)
+		desc->authorized = false;
+
 	if (send_write(device, attrib, desc->proxy, desc->pending_writes, id,
-				value, len, offset, bt_att_get_link_type(att)))
+			value, len, offset, bt_att_get_link_type(att), false,
+			false))
 		return;
 
 fail:
@@ -2614,6 +2657,26 @@ static void chrc_write_cb(struct gatt_db_attribute *attrib,
 		goto fail;
 	}
 
+	if (!(chrc->props & BT_GATT_CHRC_PROP_WRITE_WITHOUT_RESP))
+		queue = chrc->pending_writes;
+	else
+		queue = NULL;
+
+	if (opcode == BT_ATT_OP_PREP_WRITE_REQ) {
+		if (!chrc->authorized && g_dbus_proxy_get_property(chrc->proxy,
+							"Authorize", &iter))
+			send_write(device, attrib, chrc->proxy, queue,
+					id, value, len, offset,
+					bt_att_get_link_type(att), true, true);
+		else
+			gatt_db_attribute_write_result(attrib, id, 0);
+
+		return;
+	}
+
+	if (id == BT_ATT_OP_EXEC_WRITE_REQ)
+		chrc->authorized = false;
+
 	if (chrc->write_io) {
 		if (pipe_io_send(chrc->write_io, value, len) < 0) {
 			error("Unable to write: %s", strerror(errno));
@@ -2630,13 +2693,8 @@ static void chrc_write_cb(struct gatt_db_attribute *attrib,
 			return;
 	}
 
-	if (!(chrc->props & BT_GATT_CHRC_PROP_WRITE_WITHOUT_RESP))
-		queue = chrc->pending_writes;
-	else
-		queue = NULL;
-
 	if (send_write(device, attrib, chrc->proxy, queue, id, value, len,
-					offset, bt_att_get_link_type(att)))
+			offset, bt_att_get_link_type(att), false, false))
 		return;
 
 fail:
diff --git a/src/shared/gatt-server.c b/src/shared/gatt-server.c
index 4b554f665..cdade76f8 100644
--- a/src/shared/gatt-server.c
+++ b/src/shared/gatt-server.c
@@ -1208,6 +1208,45 @@ static bool store_prep_data(struct bt_gatt_server *server,
 	return prep_data_new(server, handle, offset, length, value);
 }
 
+struct prep_write_complete_data {
+	void *pdu;
+	uint16_t length;
+	struct bt_gatt_server *server;
+};
+
+static void prep_write_complete_cb(struct gatt_db_attribute *attr, int err,
+								void *user_data)
+{
+	struct prep_write_complete_data *pwcd = user_data;
+	uint16_t handle = 0;
+	uint16_t offset;
+
+	handle = get_le16(pwcd->pdu);
+
+	if (err) {
+		bt_att_send_error_rsp(pwcd->server->att,
+					BT_ATT_OP_PREP_WRITE_REQ, handle, err);
+		free(pwcd->pdu);
+		free(pwcd);
+
+		return;
+	}
+
+	offset = get_le16(pwcd->pdu + 2);
+
+	if (!store_prep_data(pwcd->server, handle, offset, pwcd->length - 4,
+						&((uint8_t *) pwcd->pdu)[4]))
+		bt_att_send_error_rsp(pwcd->server->att,
+					BT_ATT_OP_PREP_WRITE_RSP, handle,
+					BT_ATT_ERROR_INSUFFICIENT_RESOURCES);
+
+	bt_att_send(pwcd->server->att, BT_ATT_OP_PREP_WRITE_RSP, pwcd->pdu,
+						pwcd->length, NULL, NULL, NULL);
+
+	free(pwcd->pdu);
+	free(pwcd);
+}
+
 static void prep_write_cb(uint8_t opcode, const void *pdu,
 					uint16_t length, void *user_data)
 {
@@ -1215,7 +1254,8 @@ static void prep_write_cb(uint8_t opcode, const void *pdu,
 	uint16_t handle = 0;
 	uint16_t offset;
 	struct gatt_db_attribute *attr;
-	uint8_t ecode;
+	struct prep_write_complete_data *pwcd;
+	uint8_t ecode, status;
 
 	if (length < 4) {
 		ecode = BT_ATT_ERROR_INVALID_PDU;
@@ -1245,15 +1285,21 @@ static void prep_write_cb(uint8_t opcode, const void *pdu,
 	if (ecode)
 		goto error;
 
-	if (!store_prep_data(server, handle, offset, length - 4,
-						&((uint8_t *) pdu)[4])) {
-		ecode = BT_ATT_ERROR_INSUFFICIENT_RESOURCES;
-		goto error;
-	}
+	pwcd = new0(struct prep_write_complete_data, 1);
+	pwcd->pdu = malloc(length);
+	memcpy(pwcd->pdu, pdu, length);
+	pwcd->length = length;
+	pwcd->server = server;
 
-	bt_att_send(server->att, BT_ATT_OP_PREP_WRITE_RSP, pdu, length, NULL,
-								NULL, NULL);
-	return;
+	status = gatt_db_attribute_write(attr, offset, NULL, 0,
+						BT_ATT_OP_PREP_WRITE_REQ,
+						server->att,
+						prep_write_complete_cb, pwcd);
+
+	if (status)
+		return;
+
+	ecode = BT_ATT_ERROR_UNLIKELY;
 
 error:
 	bt_att_send_error_rsp(server->att, opcode, handle, ecode);
-- 
2.13.6

