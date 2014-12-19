Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH BlueZ 12/17] core: gatt: Don't always issue read-long for ReadValue
Date: Fri, 19 Dec 2014 13:36:00 -0800
Message-Id: <1419024965-10375-13-git-send-email-armansito@chromium.org>
In-Reply-To: <1419024965-10375-1-git-send-email-armansito@chromium.org>
References: <1419024965-10375-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

A remote GATT server may not support the "long write" procedure for all
of its attributes (or not at all). This patch revises the implementation
of GattCharacteristic1.ReadValue and GattDescriptor1.ReadValue, so that
instead of always initiating a "long write" (i.e. ATT Read Blob Req),
they first send out a regular read request and then proceed to a long
write only if the value fills the current MTU and may potentially have
more bytes waiting.
---
 src/gatt-client.c | 215 +++++++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 172 insertions(+), 43 deletions(-)

diff --git a/src/gatt-client.c b/src/gatt-client.c
index 4c0900b..d350b1b 100644
--- a/src/gatt-client.c
+++ b/src/gatt-client.c
@@ -348,24 +348,51 @@ static void message_append_byte_array(DBusMessage *msg, const uint8_t *bytes,
 	dbus_message_iter_close_container(&iter, &array);
 }
 
-static void desc_read_long_cb(bool success, uint8_t att_ecode,
-					const uint8_t *value, uint16_t length,
-					void *user_data)
+struct async_read_op {
+	DBusMessage *msg;
+	int ref_count;
+	uint8_t *value;
+	size_t len;
+	struct bt_gatt_client *gatt;
+	uint16_t handle;
+	void *data;
+	bool (*complete)(const uint8_t *value, size_t len, void *data);
+};
+
+static struct async_read_op *async_read_op_ref(struct async_read_op *op)
 {
-	struct async_dbus_op *op = user_data;
-	struct descriptor *desc = op->data;
-	DBusMessage *reply;
+	__sync_fetch_and_add(&op->ref_count, 1);
 
-	desc->in_read = false;
+	return op;
+}
+
+static void async_read_op_unref(void *data)
+{
+	struct async_read_op *op = data;
+
+	if (__sync_sub_and_fetch(&op->ref_count, 1))
+		return;
+
+	dbus_message_unref(op->msg);
+	free(op->value);
+	free(op);
+}
+
+static void complete_read(struct async_read_op *op, bool success,
+					uint8_t att_ecode, const uint8_t *value,
+					uint16_t length)
+{
+	DBusMessage *reply;
 
 	if (!success) {
 		reply = create_gatt_dbus_error(op->msg, att_ecode);
 		goto done;
 	}
 
-	update_value_property(value, length, &desc->value, &desc->value_len,
-						&desc->value_known, desc->path,
-						GATT_DESCRIPTOR_IFACE, false);
+	if (!op->complete(value, length, op->data)) {
+		reply = btd_error_failed(op->msg, "Operation failed");
+		goto done;
+	}
 
 	reply = g_dbus_create_reply(op->msg, DBUS_TYPE_INVALID);
 	if (!reply) {
@@ -379,31 +406,133 @@ done:
 	g_dbus_send_message(btd_get_dbus_connection(), reply);
 }
 
+static void read_long_cb(bool success, uint8_t att_ecode,
+					const uint8_t *value, uint16_t length,
+					void *user_data)
+{
+	struct async_read_op *op = user_data;
+	uint8_t *final_value = NULL;
+	size_t final_len = 0;
+
+	if (!success) {
+		if (att_ecode != BT_ATT_ERROR_REQUEST_NOT_SUPPORTED &&
+				att_ecode != BT_ATT_ERROR_ATTRIBUTE_NOT_LONG &&
+				att_ecode != BT_ATT_ERROR_INVALID_OFFSET)
+			goto done;
+
+		success = true;
+		att_ecode = 0;
+	}
+
+	if (length == 0) {
+		final_len = op->len;
+		final_value = op->value;
+	} else {
+		final_len = op->len + length;
+		final_value = malloc(sizeof(uint8_t) * (op->len + length));
+		if (!final_value) {
+			success = false;
+			goto done;
+		}
+
+		memcpy(final_value, op->value, op->len);
+		memcpy(final_value + op->len, value, length);
+	}
+
+done:
+	complete_read(op, success, att_ecode, final_value, final_len);
+
+	if (final_value && final_value != op->value)
+		free(final_value);
+}
+
+static void read_cb(bool success, uint8_t att_ecode,
+					const uint8_t *value, uint16_t length,
+					void *user_data)
+{
+	struct async_read_op *op = user_data;
+
+	if (!success)
+		goto done;
+
+	/*
+	 * If the value length is exactly MTU-1, then we may not have read the
+	 * entire value. Perform a long read to obtain the rest, otherwise,
+	 * we're done.
+	 */
+	if (length < bt_gatt_client_get_mtu(op->gatt) - 1)
+		goto done;
+
+	op->value = malloc(sizeof(uint8_t) * length);
+	if (!op->value) {
+		success = false;
+		goto done;
+	}
+
+	memcpy(op->value, value, sizeof(uint8_t) * length);
+	op->len = length;
+
+	if (bt_gatt_client_read_long_value(op->gatt, op->handle, length,
+							read_long_cb,
+							async_read_op_ref(op),
+							async_read_op_unref))
+		return;
+
+	async_read_op_unref(op);
+	success = false;
+
+done:
+	complete_read(op, success, att_ecode, value, length);
+}
+
+static bool desc_read_complete(const uint8_t *value, size_t len, void *data)
+{
+	struct descriptor *desc = data;
+
+	desc->in_read = false;
+
+	/*
+	 * The descriptor might have been unregistered during the read. Return
+	 * failure.
+	 */
+	if (!desc->chrc)
+		return false;
+
+	update_value_property(value, len, &desc->value, &desc->value_len,
+						&desc->value_known, desc->path,
+						GATT_DESCRIPTOR_IFACE, false);
+
+	return true;
+}
+
 static DBusMessage *descriptor_read_value(DBusConnection *conn,
 					DBusMessage *msg, void *user_data)
 {
 	struct descriptor *desc = user_data;
 	struct bt_gatt_client *gatt = desc->chrc->service->client->gatt;
-	struct async_dbus_op *op;
+	struct async_read_op *op;
 
 	if (desc->in_read)
 		return btd_error_in_progress(msg);
 
-	op = new0(struct async_dbus_op, 1);
+	op = new0(struct async_read_op, 1);
 	if (!op)
 		return btd_error_failed(msg, "Failed to initialize request");
 
 	op->msg = dbus_message_ref(msg);
+	op->gatt = gatt;
+	op->handle = desc->handle;
 	op->data = desc;
+	op->complete = desc_read_complete;
 
-	if (bt_gatt_client_read_long_value(gatt, desc->handle, 0,
-							desc_read_long_cb, op,
-							async_dbus_op_free)) {
+	if (bt_gatt_client_read_value(gatt, desc->handle, read_cb,
+							async_read_op_ref(op),
+							async_read_op_unref)) {
 		desc->in_read = true;
 		return NULL;
 	}
 
-	async_dbus_op_free(op);
+	async_read_op_unref(op);
 
 	return btd_error_failed(msg, "Failed to send read request");
 }
@@ -686,36 +815,25 @@ static gboolean characteristic_property_get_flags(
 	return TRUE;
 }
 
-static void chrc_read_long_cb(bool success, uint8_t att_ecode,
-					const uint8_t *value, uint16_t length,
-					void *user_data)
+static bool chrc_read_complete(const uint8_t *value, size_t len, void *data)
 {
-	struct async_dbus_op *op = user_data;
-	struct characteristic *chrc = op->data;
-	DBusMessage *reply;
+	struct characteristic *chrc = data;
 
 	chrc->in_read = false;
 
-	if (!success) {
-		reply = create_gatt_dbus_error(op->msg, att_ecode);
-		goto done;
-	}
+	/*
+	 * The characteristic might have been unregistered during the read.
+	 * Return failure.
+	 */
+	if (!chrc->service)
+		return false;
 
-	update_value_property(value, length, &chrc->value, &chrc->value_len,
+	update_value_property(value, len, &chrc->value, &chrc->value_len,
 						&chrc->value_known, chrc->path,
 						GATT_CHARACTERISTIC_IFACE,
 						false);
 
-	reply = g_dbus_create_reply(op->msg, DBUS_TYPE_INVALID);
-	if (!reply) {
-		error("Failed to allocate D-Bus message reply");
-		return;
-	}
-
-	message_append_byte_array(reply, value, length);
-
-done:
-	g_dbus_send_message(btd_get_dbus_connection(), reply);
+	return true;
 }
 
 static DBusMessage *characteristic_read_value(DBusConnection *conn,
@@ -723,26 +841,37 @@ static DBusMessage *characteristic_read_value(DBusConnection *conn,
 {
 	struct characteristic *chrc = user_data;
 	struct bt_gatt_client *gatt = chrc->service->client->gatt;
-	struct async_dbus_op *op;
+	struct async_read_op *op;
 
 	if (chrc->in_read)
 		return btd_error_in_progress(msg);
 
-	op = new0(struct async_dbus_op, 1);
+	if (!(chrc->props & BT_GATT_CHRC_PROP_READ))
+		return gatt_error_read_not_permitted(msg);
+
+	op = new0(struct async_read_op, 1);
 	if (!op)
 		return btd_error_failed(msg, "Failed to initialize request");
 
 	op->msg = dbus_message_ref(msg);
+	op->gatt = gatt;
+	op->handle = chrc->value_handle;
 	op->data = chrc;
+	op->complete = chrc_read_complete;
 
-	if (bt_gatt_client_read_long_value(gatt, chrc->value_handle, 0,
-							chrc_read_long_cb, op,
-							async_dbus_op_free)) {
+	/*
+	 * A remote server may support the "read" procedure but may not support
+	 * a "long read". Hence, we start with the regular read procedure and
+	 * proceed to a long read only if necessary.
+	 */
+	if (bt_gatt_client_read_value(gatt, chrc->value_handle, read_cb,
+							async_read_op_ref(op),
+							async_read_op_unref)) {
 		chrc->in_read = true;
 		return NULL;
 	}
 
-	async_dbus_op_free(op);
+	async_read_op_unref(op);
 
 	return btd_error_failed(msg, "Failed to send read request");
 }
-- 
2.2.0.rc0.207.ga3a616c

