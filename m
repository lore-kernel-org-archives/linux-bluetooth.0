Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com, Arman Uguray <armansito@chromium.org>
Subject: [PATCH BlueZ 17/18] core: gatt: Support descriptor reads/writes
Date: Fri, 20 Feb 2015 17:57:02 -0800
Message-Id: <1424483824-27374-18-git-send-email-armansito@chromium.org>
In-Reply-To: <1424483824-27374-1-git-send-email-armansito@chromium.org>
References: <1424483824-27374-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds support for reading and writing to a descriptor from an
external application during a read/write procedure. This patch unifies
the code paths for characteristic and descriptor read/write operations.
---
 src/gatt-manager.c | 148 +++++++++++++++++++++++++++++++++++++----------------
 1 file changed, 104 insertions(+), 44 deletions(-)

diff --git a/src/gatt-manager.c b/src/gatt-manager.c
index 9049d25..28c6ff5 100644
--- a/src/gatt-manager.c
+++ b/src/gatt-manager.c
@@ -92,11 +92,13 @@ struct external_desc {
 	GDBusProxy *proxy;
 	struct gatt_db_attribute *attrib;
 	bool handled;
+	struct queue *pending_ops;
 };
 
 struct pending_dbus_op {
-	struct external_chrc *chrc;
 	unsigned int id;
+	struct gatt_db_attribute *attrib;
+	struct queue *owner_queue;
 	void *user_data;
 };
 
@@ -104,18 +106,18 @@ static void cancel_pending_dbus_op(void *data, void *user_data)
 {
 	struct pending_dbus_op *op = data;
 
-	gatt_db_attribute_read_result(op->chrc->attrib, op->id,
+	gatt_db_attribute_read_result(op->attrib, op->id,
 					BT_ATT_ERROR_REQUEST_NOT_SUPPORTED,
 					NULL, 0);
-	op->chrc = NULL;
+	op->owner_queue = NULL;
 }
 
 static void pending_dbus_op_free(void *data)
 {
 	struct pending_dbus_op *op = data;
 
-	if (op->chrc)
-		queue_remove(op->chrc->pending_ops, op);
+	if (op->owner_queue)
+		queue_remove(op->owner_queue, op);
 
 	free(op);
 }
@@ -147,6 +149,8 @@ static void desc_free(void *data)
 {
 	struct external_desc *desc = data;
 
+	queue_foreach(desc->pending_ops, cancel_pending_dbus_op, NULL);
+
 	if (desc->proxy)
 		g_dbus_proxy_unref(desc->proxy);
 
@@ -280,8 +284,16 @@ static struct external_desc *desc_create(struct external_service *service,
 	if (!desc)
 		return NULL;
 
+
+	desc->pending_ops = queue_new();
+	if (!desc->pending_ops) {
+		free(desc);
+		return NULL;
+	}
+
 	desc->chrc_path = g_strdup(chrc_path);
 	if (!desc->chrc_path) {
+		queue_destroy(desc->pending_ops, NULL);
 		free(desc);
 		return NULL;
 	}
@@ -589,7 +601,7 @@ static void read_reply_cb(DBusMessage *message, void *user_data)
 	uint8_t *value = NULL;
 	int len = 0;
 
-	if (!op->chrc) {
+	if (!op->owner_queue) {
 		DBG("Pending read was canceled when object got removed");
 		return;
 	}
@@ -631,25 +643,17 @@ static void read_reply_cb(DBusMessage *message, void *user_data)
 	value = len ? value : NULL;
 
 done:
-	gatt_db_attribute_read_result(op->chrc->attrib, op->id, ecode,
+	gatt_db_attribute_read_result(op->attrib, op->id, ecode,
 								value, len);
 }
 
-static void chrc_read_cb(struct gatt_db_attribute *attrib,
-					unsigned int id, uint16_t offset,
-					uint8_t opcode, struct bt_att *att,
-					void *user_data)
+static void send_read(struct gatt_db_attribute *attrib, GDBusProxy *proxy,
+					struct queue *owner_queue,
+					unsigned int id)
 {
-	struct external_chrc *chrc = user_data;
 	struct pending_dbus_op *op;
 	uint8_t ecode = BT_ATT_ERROR_UNLIKELY;
 
-	if (chrc->attrib != attrib) {
-		error("Read callback called with incorrect attribute");
-		goto error;
-
-	}
-
 	op = new0(struct pending_dbus_op, 1);
 	if (!op) {
 		error("Failed to allocate memory for pending read call");
@@ -657,11 +661,12 @@ static void chrc_read_cb(struct gatt_db_attribute *attrib,
 		goto error;
 	}
 
-	op->chrc = chrc;
+	op->owner_queue = owner_queue;
+	op->attrib = attrib;
 	op->id = id;
-	queue_push_tail(chrc->pending_ops, op);
+	queue_push_tail(owner_queue, op);
 
-	if (g_dbus_proxy_method_call(chrc->proxy, "ReadValue", NULL,
+	if (g_dbus_proxy_method_call(proxy, "ReadValue", NULL,
 						read_reply_cb, op,
 						pending_dbus_op_free) == TRUE)
 		return;
@@ -691,7 +696,7 @@ static void write_reply_cb(DBusMessage *message, void *user_data)
 	DBusMessageIter iter;
 	uint8_t ecode = 0;
 
-	if (!op->chrc) {
+	if (!op->owner_queue) {
 		DBG("Pending write was canceled when object got removed");
 		return;
 	}
@@ -717,28 +722,21 @@ static void write_reply_cb(DBusMessage *message, void *user_data)
 	}
 
 done:
-	gatt_db_attribute_write_result(op->chrc->attrib, op->id, ecode);
+	gatt_db_attribute_write_result(op->attrib, op->id, ecode);
 }
 
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
 	struct pending_dbus_op *op;
 	uint8_t ecode = BT_ATT_ERROR_UNLIKELY;
 	struct iovec iov;
 
-	if (chrc->attrib != attrib) {
-		error("Write callback called with incorrect attribute");
-		goto error;
-	}
-
 	op = new0(struct pending_dbus_op, 1);
 	if (!op) {
-		error("Failed to allocate memory for pending read call");
+		error("Failed to allocate memory for pending write call");
 		ecode = BT_ATT_ERROR_INSUFFICIENT_RESOURCES;
 		goto error;
 	}
@@ -746,12 +744,13 @@ static void chrc_write_cb(struct gatt_db_attribute *attrib,
 	iov.iov_base = (uint8_t *) value;
 	iov.iov_len = len;
 
-	op->chrc = chrc;
+	op->owner_queue = owner_queue;
+	op->attrib = attrib;
 	op->id = id;
 	op->user_data = &iov;
-	queue_push_tail(chrc->pending_ops, op);
+	queue_push_tail(owner_queue, op);
 
-	if (g_dbus_proxy_method_call(chrc->proxy, "WriteValue", write_setup_cb,
+	if (g_dbus_proxy_method_call(proxy, "WriteValue", write_setup_cb,
 						write_reply_cb, op,
 						pending_dbus_op_free) == TRUE)
 		return;
@@ -955,6 +954,37 @@ static bool create_cep_entry(struct external_service *service,
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
+	send_read(attrib, desc->proxy, desc->pending_ops, id);
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
+	send_write(attrib, desc->proxy, desc->pending_ops, id, value, len);
+}
+
 static bool create_desc_entry(struct external_service *service,
 						struct external_desc *desc)
 {
@@ -966,13 +996,12 @@ static bool create_desc_entry(struct external_service *service,
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
@@ -983,6 +1012,37 @@ static bool create_desc_entry(struct external_service *service,
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
+	send_read(attrib, chrc->proxy, chrc->pending_ops, id);
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
+	send_write(attrib, chrc->proxy, chrc->pending_ops, id, value, len);
+}
+
 static bool create_chrc_entry(struct external_service *service,
 						struct external_chrc *chrc)
 {
-- 
2.2.0.rc0.207.ga3a616c

