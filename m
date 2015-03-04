Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH BlueZ v3 6/7] core/gatt: Support descriptor reads/writes
Date: Tue,  3 Mar 2015 20:30:10 -0800
Message-Id: <1425443411-11958-7-git-send-email-armansito@chromium.org>
In-Reply-To: <1425443411-11958-1-git-send-email-armansito@chromium.org>
References: <1425443411-11958-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds support for reading and writing to a descriptor from an
external application during a read/write procedure. This patch unifies
the code paths for characteristic and descriptor read/write operations.
---
 src/gatt-database.c | 217 +++++++++++++++++++++++++++++++++-------------------
 1 file changed, 139 insertions(+), 78 deletions(-)

diff --git a/src/gatt-database.c b/src/gatt-database.c
index 0ee8042..bba05ad 100644
--- a/src/gatt-database.c
+++ b/src/gatt-database.c
@@ -110,12 +110,15 @@ struct external_desc {
 	GDBusProxy *proxy;
 	struct gatt_db_attribute *attrib;
 	bool handled;
+	struct queue *pending_reads;
+	struct queue *pending_writes;
 };
 
 struct pending_op {
-	struct external_chrc *chrc;
 	unsigned int id;
-	void *user_data;
+	struct gatt_db_attribute *attrib;
+	struct queue *owner_queue;
+	void *setup_data;
 };
 
 struct device_state {
@@ -291,17 +294,19 @@ static void cancel_pending_read(void *data)
 {
 	struct pending_op *op = data;
 
-	gatt_db_attribute_read_result(op->chrc->attrib, op->id,
+	gatt_db_attribute_read_result(op->attrib, op->id,
 					BT_ATT_ERROR_REQUEST_NOT_SUPPORTED,
 					NULL, 0);
+	op->owner_queue = NULL;
 }
 
 static void cancel_pending_write(void *data)
 {
 	struct pending_op *op = data;
 
-	gatt_db_attribute_write_result(op->chrc->attrib, op->id,
+	gatt_db_attribute_write_result(op->attrib, op->id,
 					BT_ATT_ERROR_REQUEST_NOT_SUPPORTED);
+	op->owner_queue = NULL;
 }
 
 static void chrc_free(void *data)
@@ -326,6 +331,9 @@ static void desc_free(void *data)
 {
 	struct external_desc *desc = data;
 
+	queue_destroy(desc->pending_reads, cancel_pending_read);
+	queue_destroy(desc->pending_writes, cancel_pending_write);
+
 	if (desc->proxy)
 		g_dbus_proxy_unref(desc->proxy);
 
@@ -1076,8 +1084,23 @@ static struct external_desc *desc_create(struct external_service *service,
 	if (!desc)
 		return NULL;
 
+	desc->pending_reads = queue_new();
+	if (!desc->pending_reads) {
+		free(desc);
+		return NULL;
+	}
+
+	desc->pending_writes = queue_new();
+	if (!desc->pending_writes) {
+		queue_destroy(desc->pending_reads, NULL);
+		free(desc);
+		return NULL;
+	}
+
 	desc->chrc_path = g_strdup(chrc_path);
 	if (!desc->chrc_path) {
+		queue_destroy(desc->pending_reads, NULL);
+		queue_destroy(desc->pending_writes, NULL);
 		free(desc);
 		return NULL;
 	}
@@ -1385,7 +1408,7 @@ static void read_reply_cb(DBusMessage *message, void *user_data)
 	uint8_t *value = NULL;
 	int len = 0;
 
-	if (!op->chrc) {
+	if (!op->owner_queue) {
 		DBG("Pending read was canceled when object got removed");
 		return;
 	}
@@ -1427,12 +1450,22 @@ static void read_reply_cb(DBusMessage *message, void *user_data)
 	value = len ? value : NULL;
 
 done:
-	gatt_db_attribute_read_result(op->chrc->attrib, op->id, ecode,
-								value, len);
+	gatt_db_attribute_read_result(op->attrib, op->id, ecode, value, len);
 }
 
-static struct pending_op *pending_read_new(struct external_chrc *chrc,
-							unsigned int id)
+static void pending_op_free(void *data)
+{
+	struct pending_op *op = data;
+
+	if (op->owner_queue)
+		queue_remove(op->owner_queue, op);
+
+	free(op);
+}
+
+static struct pending_op *pending_read_new(struct queue *owner_queue,
+					struct gatt_db_attribute *attrib,
+					unsigned int id)
 {
 	struct pending_op *op;
 
@@ -1440,51 +1473,33 @@ static struct pending_op *pending_read_new(struct external_chrc *chrc,
 	if (!op)
 		return NULL;
 
-	op->chrc = chrc;
+	op->owner_queue = owner_queue;
+	op->attrib = attrib;
 	op->id = id;
-	queue_push_tail(chrc->pending_reads, op);
+	queue_push_tail(owner_queue, op);
 
 	return op;
 }
 
-static void pending_read_free(void *data)
-{
-	struct pending_op *op = data;
-
-	if (op->chrc)
-		queue_remove(op->chrc->pending_reads, op);
-
-	free(op);
-}
-
-static void chrc_read_cb(struct gatt_db_attribute *attrib,
-					unsigned int id, uint16_t offset,
-					uint8_t opcode, struct bt_att *att,
-					void *user_data)
+static void send_read(struct gatt_db_attribute *attrib, GDBusProxy *proxy,
+						struct queue *owner_queue,
+						unsigned int id)
 {
-	struct external_chrc *chrc = user_data;
 	struct pending_op *op;
 	uint8_t ecode = BT_ATT_ERROR_UNLIKELY;
 
-	if (chrc->attrib != attrib) {
-		error("Read callback called with incorrect attribute");
-		goto error;
-
-	}
-
-	op = pending_read_new(chrc, id);
+	op = pending_read_new(owner_queue, attrib, id);
 	if (!op) {
 		error("Failed to allocate memory for pending read call");
 		ecode = BT_ATT_ERROR_INSUFFICIENT_RESOURCES;
 		goto error;
 	}
 
-	if (g_dbus_proxy_method_call(chrc->proxy, "ReadValue", NULL,
-						read_reply_cb, op,
-						pending_read_free) == TRUE)
+	if (g_dbus_proxy_method_call(proxy, "ReadValue", NULL, read_reply_cb,
+						op, pending_op_free) == TRUE)
 		return;
 
-	pending_read_free(op);
+	pending_op_free(op);
 
 error:
 	gatt_db_attribute_read_result(attrib, id, ecode, NULL, 0);
@@ -1493,7 +1508,7 @@ error:
 static void write_setup_cb(DBusMessageIter *iter, void *user_data)
 {
 	struct pending_op *op = user_data;
-	struct iovec *iov = op->user_data;
+	struct iovec *iov = op->setup_data;
 	DBusMessageIter array;
 
 	dbus_message_iter_open_container(iter, DBUS_TYPE_ARRAY, "y", &array);
@@ -1509,7 +1524,7 @@ static void write_reply_cb(DBusMessage *message, void *user_data)
 	DBusMessageIter iter;
 	uint8_t ecode = 0;
 
-	if (!op->chrc) {
+	if (!op->owner_queue) {
 		DBG("Pending write was canceled when object got removed");
 		return;
 	}
@@ -1535,13 +1550,14 @@ static void write_reply_cb(DBusMessage *message, void *user_data)
 	}
 
 done:
-	gatt_db_attribute_write_result(op->chrc->attrib, op->id, ecode);
+	gatt_db_attribute_write_result(op->attrib, op->id, ecode);
 }
 
-static struct pending_op *pending_write_new(struct external_chrc *chrc,
-							unsigned int id,
-							const uint8_t *value,
-							size_t len)
+static struct pending_op *pending_write_new(struct queue *owner_queue,
+					struct gatt_db_attribute *attrib,
+					unsigned int id,
+					const uint8_t *value,
+					size_t len)
 {
 	struct pending_op *op;
 	struct iovec iov;
@@ -1553,52 +1569,36 @@ static struct pending_op *pending_write_new(struct external_chrc *chrc,
 	iov.iov_base = (uint8_t *) value;
 	iov.iov_len = len;
 
-	op->chrc = chrc;
+	op->owner_queue = owner_queue;
+	op->attrib = attrib;
 	op->id = id;
-	op->user_data = &iov;
-	queue_push_tail(chrc->pending_writes, op);
+	op->setup_data = &iov;
+	queue_push_tail(owner_queue, op);
 
 	return op;
 }
 
-static void pending_write_free(void *data)
-{
-	struct pending_op *op = data;
-
-	if (op->chrc)
-		queue_remove(op->chrc->pending_writes, op);
-
-	free(op);
-}
-
-static void chrc_write_cb(struct gatt_db_attribute *attrib,
-					unsigned int id, uint16_t offset,
-					const uint8_t *value, size_t len,
-					uint8_t opcode, struct bt_att *att,
-					void *user_data)
+static void send_write(struct gatt_db_attribute *attrib, GDBusProxy *proxy,
+					struct queue *owner_queue,
+					unsigned int id,
+					const uint8_t *value, size_t len)
 {
-	struct external_chrc *chrc = user_data;
 	struct pending_op *op;
 	uint8_t ecode = BT_ATT_ERROR_UNLIKELY;
 
-	if (chrc->attrib != attrib) {
-		error("Write callback called with incorrect attribute");
-		goto error;
-	}
-
-	op = pending_write_new(chrc, id, value, len);
+	op = pending_write_new(owner_queue, attrib, id, value, len);
 	if (!op) {
 		error("Failed to allocate memory for pending read call");
 		ecode = BT_ATT_ERROR_INSUFFICIENT_RESOURCES;
 		goto error;
 	}
 
-	if (g_dbus_proxy_method_call(chrc->proxy, "WriteValue", write_setup_cb,
+	if (g_dbus_proxy_method_call(proxy, "WriteValue", write_setup_cb,
 						write_reply_cb, op,
-						pending_write_free) == TRUE)
+						pending_op_free) == TRUE)
 		return;
 
-	pending_write_free(op);
+	pending_op_free(op);
 
 error:
 	gatt_db_attribute_write_result(attrib, id, ecode);
@@ -1775,6 +1775,37 @@ static bool create_cep_entry(struct external_service *service,
 	return true;
 }
 
+static void desc_read_cb(struct gatt_db_attribute *attrib,
+					unsigned int id, uint16_t offset,
+					uint8_t opcode, struct bt_att *att,
+					void *user_data)
+{
+	struct external_desc *desc = user_data;
+
+	if (desc->attrib != attrib) {
+		error("Read callback called with incorrect attribute");
+		return;
+	}
+
+	send_read(attrib, desc->proxy, desc->pending_reads, id);
+}
+
+static void desc_write_cb(struct gatt_db_attribute *attrib,
+					unsigned int id, uint16_t offset,
+					const uint8_t *value, size_t len,
+					uint8_t opcode, struct bt_att *att,
+					void *user_data)
+{
+	struct external_desc *desc = user_data;
+
+	if (desc->attrib != attrib) {
+		error("Read callback called with incorrect attribute");
+		return;
+	}
+
+	send_write(attrib, desc->proxy, desc->pending_writes, id, value, len);
+}
+
 static bool database_add_desc(struct external_service *service,
 						struct external_desc *desc)
 {
@@ -1786,13 +1817,12 @@ static bool database_add_desc(struct external_service *service,
 	}
 
 	/*
-	 * TODO: Set read/write callbacks and property set permissions based on
-	 * a D-Bus property of the external descriptor.
+	 * TODO: Set permissions based on a D-Bus property of the external
+	 * descriptor.
 	 */
-	desc->attrib = gatt_db_service_add_descriptor(service->attrib,
-								&uuid, 0, NULL,
-								NULL, NULL);
-
+	desc->attrib = gatt_db_service_add_descriptor(service->attrib, &uuid,
+					BT_ATT_PERM_READ | BT_ATT_PERM_WRITE,
+					desc_read_cb, desc_write_cb, desc);
 	if (!desc->attrib) {
 		error("Failed to create descriptor entry in database");
 		return false;
@@ -1803,6 +1833,37 @@ static bool database_add_desc(struct external_service *service,
 	return true;
 }
 
+static void chrc_read_cb(struct gatt_db_attribute *attrib,
+					unsigned int id, uint16_t offset,
+					uint8_t opcode, struct bt_att *att,
+					void *user_data)
+{
+	struct external_chrc *chrc = user_data;
+
+	if (chrc->attrib != attrib) {
+		error("Read callback called with incorrect attribute");
+		return;
+	}
+
+	send_read(attrib, chrc->proxy, chrc->pending_reads, id);
+}
+
+static void chrc_write_cb(struct gatt_db_attribute *attrib,
+					unsigned int id, uint16_t offset,
+					const uint8_t *value, size_t len,
+					uint8_t opcode, struct bt_att *att,
+					void *user_data)
+{
+	struct external_chrc *chrc = user_data;
+
+	if (chrc->attrib != attrib) {
+		error("Write callback called with incorrect attribute");
+		return;
+	}
+
+	send_write(attrib, chrc->proxy, chrc->pending_writes, id, value, len);
+}
+
 static bool database_add_chrc(struct external_service *service,
 						struct external_chrc *chrc)
 {
-- 
2.2.0.rc0.207.ga3a616c

