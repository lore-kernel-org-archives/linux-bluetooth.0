Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH BlueZ 06/17] core: gatt: Implement GattDescriptor1.ReadValue
Date: Fri, 19 Dec 2014 13:35:54 -0800
Message-Id: <1419024965-10375-7-git-send-email-armansito@chromium.org>
In-Reply-To: <1419024965-10375-1-git-send-email-armansito@chromium.org>
References: <1419024965-10375-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch implements the ReadValue method of org.bluez.GattDescriptor1
and exposes the "Value" property based on what was cached during the
most recent read. The property is hidden if the value is unknown.
---
 src/gatt-client.c | 266 ++++++++++++++++++++++++++++++++++++------------------
 1 file changed, 177 insertions(+), 89 deletions(-)

diff --git a/src/gatt-client.c b/src/gatt-client.c
index 1c4ea51..9cbe32d 100644
--- a/src/gatt-client.c
+++ b/src/gatt-client.c
@@ -87,6 +87,11 @@ struct descriptor {
 	uint16_t handle;
 	bt_uuid_t uuid;
 	char *path;
+
+	bool in_read;
+	bool value_known;
+	uint8_t *value;
+	size_t value_len;
 };
 
 static DBusMessage *gatt_error_read_not_permitted(DBusMessage *msg)
@@ -177,22 +182,176 @@ static gboolean descriptor_property_get_characteristic(
 static gboolean descriptor_property_get_value(const GDBusPropertyTable *property,
 					DBusMessageIter *iter, void *data)
 {
+	struct descriptor *desc = data;
 	DBusMessageIter array;
+	size_t i;
 
 	dbus_message_iter_open_container(iter, DBUS_TYPE_ARRAY, "y", &array);
 
-	/* TODO: Implement this once the value is cached */
+	if (desc->value_known) {
+		for (i = 0; i < desc->value_len; i++)
+			dbus_message_iter_append_basic(&array, DBUS_TYPE_BYTE,
+							desc->value + i);
+	}
 
 	dbus_message_iter_close_container(iter, &array);
 
 	return TRUE;
 }
 
+static gboolean descriptor_property_value_exists(
+					const GDBusPropertyTable *property,
+					void *data)
+{
+	struct descriptor *desc = data;
+
+	return desc->value_known ? TRUE : FALSE;
+}
+
+static bool resize_value_buffer(size_t new_len, uint8_t **value, size_t *len)
+{
+	uint8_t *ptr;
+
+	if (*len == new_len)
+		return true;
+
+	if (!new_len) {
+		free(*value);
+		*value = NULL;
+		*len = 0;
+
+		return true;
+	}
+
+	ptr = realloc(*value, sizeof(uint8_t) * new_len);
+	if (!ptr)
+		return false;
+
+	*value = ptr;
+	*len = new_len;
+
+	return true;
+}
+
+static void update_value_property(const uint8_t *value, size_t len,
+					uint8_t **cur_value, size_t *cur_len,
+					bool *value_known,
+					const char *path, const char *iface)
+{
+	/*
+	 * If the value is the same, then only updated it if wasn't previously
+	 * known.
+	 */
+	if (*value_known && *cur_len == len &&
+			!memcmp(*cur_value, value, sizeof(uint8_t) * len))
+		return;
+
+	if (resize_value_buffer(len, cur_value, cur_len)) {
+		*value_known = true;
+		memcpy(*cur_value, value, sizeof(uint8_t) * len);
+	} else {
+		/*
+		 * Failed to resize the buffer. Since we don't want to show a
+		 * stale value, if the value was previously known then free and
+		 * hide it.
+		 */
+		free(*cur_value);
+		*cur_value = NULL;
+		*cur_len = 0;
+		*value_known = false;
+	}
+
+	g_dbus_emit_property_changed(btd_get_dbus_connection(), path, iface,
+								"Value");
+}
+
+struct async_dbus_op {
+	DBusMessage *msg;
+	void *data;
+};
+
+static void async_dbus_op_free(void *data)
+{
+	struct async_dbus_op *op = data;
+
+	dbus_message_unref(op->msg);
+	free(op);
+}
+
+static void message_append_byte_array(DBusMessage *msg, const uint8_t *bytes,
+								size_t len)
+{
+	DBusMessageIter iter, array;
+	size_t i;
+
+	dbus_message_iter_init_append(msg, &iter);
+	dbus_message_iter_open_container(&iter, DBUS_TYPE_ARRAY, "y", &array);
+
+	for (i = 0; i < len; i++)
+		dbus_message_iter_append_basic(&array, DBUS_TYPE_BYTE,
+								bytes + i);
+
+	dbus_message_iter_close_container(&iter, &array);
+}
+
+static void desc_read_long_cb(bool success, uint8_t att_ecode,
+					const uint8_t *value, uint16_t length,
+					void *user_data)
+{
+	struct async_dbus_op *op = user_data;
+	struct descriptor *desc = op->data;
+	DBusMessage *reply;
+
+	desc->in_read = false;
+
+	if (!success) {
+		reply = create_gatt_dbus_error(op->msg, att_ecode);
+		goto done;
+	}
+
+	update_value_property(value, length, &desc->value, &desc->value_len,
+						&desc->value_known, desc->path,
+						GATT_DESCRIPTOR_IFACE);
+
+	reply = g_dbus_create_reply(op->msg, DBUS_TYPE_INVALID);
+	if (!reply) {
+		error("Failed to allocate D-Bus message reply");
+		return;
+	}
+
+	message_append_byte_array(reply, value, length);
+
+done:
+	g_dbus_send_message(btd_get_dbus_connection(), reply);
+}
+
 static DBusMessage *descriptor_read_value(DBusConnection *conn,
 					DBusMessage *msg, void *user_data)
 {
-	/* TODO: Implement */
-	return btd_error_failed(msg, "Not implemented");
+	struct descriptor *desc = user_data;
+	struct bt_gatt_client *gatt = desc->chrc->service->client->gatt;
+	struct async_dbus_op *op;
+
+	if (desc->in_read)
+		return btd_error_in_progress(msg);
+
+	op = new0(struct async_dbus_op, 1);
+	if (!op)
+		return btd_error_failed(msg, "Failed to initialize request");
+
+	op->msg = dbus_message_ref(msg);
+	op->data = desc;
+
+	if (bt_gatt_client_read_long_value(gatt, desc->handle, 0,
+							desc_read_long_cb, op,
+							async_dbus_op_free)) {
+		desc->in_read = true;
+		return NULL;
+	}
+
+	async_dbus_op_free(op);
+
+	return btd_error_failed(msg, "Failed to send read request");
 }
 
 static DBusMessage *descriptor_write_value(DBusConnection *conn,
@@ -205,7 +364,8 @@ static DBusMessage *descriptor_write_value(DBusConnection *conn,
 static const GDBusPropertyTable descriptor_properties[] = {
 	{ "UUID", "s", descriptor_property_get_uuid },
 	{ "Characteristic", "o", descriptor_property_get_characteristic },
-	{ "Value", "ay", descriptor_property_get_value },
+	{ "Value", "ay", descriptor_property_get_value, NULL,
+					descriptor_property_value_exists },
 	{ }
 };
 
@@ -221,6 +381,7 @@ static void descriptor_free(void *data)
 {
 	struct descriptor *desc = data;
 
+	free(desc->value);
 	g_free(desc->path);
 	free(desc);
 }
@@ -386,105 +547,32 @@ static gboolean characteristic_property_get_flags(
 	return TRUE;
 }
 
-struct chrc_dbus_op {
-	struct characteristic *chrc;
-	DBusMessage *msg;
-};
-
-static void chrc_dbus_op_free(void *data)
-{
-	struct chrc_dbus_op *op = data;
-
-	dbus_message_unref(op->msg);
-	free(op);
-}
-
-static bool chrc_resize_value(struct characteristic *chrc, size_t new_size)
-{
-	uint8_t *ptr;
-
-	if (chrc->value_len == new_size)
-		return true;
-
-	if (!new_size) {
-		free(chrc->value);
-		chrc->value = NULL;
-		chrc->value_len = 0;
-
-		return true;
-	}
-
-	ptr = realloc(chrc->value, sizeof(uint8_t) * new_size);
-	if (!ptr)
-		return false;
-
-	chrc->value = ptr;
-	chrc->value_len = new_size;
-
-	return true;
-}
-
 static void chrc_read_long_cb(bool success, uint8_t att_ecode,
 					const uint8_t *value, uint16_t length,
 					void *user_data)
 {
-	struct chrc_dbus_op *op = user_data;
-	struct characteristic *chrc = op->chrc;
-	DBusMessageIter iter, array;
+	struct async_dbus_op *op = user_data;
+	struct characteristic *chrc = op->data;
 	DBusMessage *reply;
 
-	op->chrc->in_read = false;
+	chrc->in_read = false;
 
 	if (!success) {
 		reply = create_gatt_dbus_error(op->msg, att_ecode);
 		goto done;
 	}
 
-	/*
-	 * If the value is the same, then only update it if it wasn't previously
-	 * known.
-	 */
-	if (chrc->value_known && chrc->value_len == length &&
-			!memcmp(chrc->value, value, sizeof(uint8_t) * length))
-		goto reply;
-
-	if (!chrc_resize_value(chrc, length)) {
-		/*
-		 * Failed to resize the buffer. Since we don't want to show a
-		 * stale value, if the value was previously known, then free and
-		 * hide it.
-		 */
-		free(chrc->value);
-		chrc->value = NULL;
-		chrc->value_len = 0;
-		chrc->value_known = false;
-
-		goto changed_signal;
-	}
-
-	chrc->value_known = true;
-	memcpy(chrc->value, value, sizeof(uint8_t) * length);
-
-changed_signal:
-	g_dbus_emit_property_changed(btd_get_dbus_connection(), chrc->path,
-						GATT_CHARACTERISTIC_IFACE,
-						"Value");
+	update_value_property(value, length, &chrc->value, &chrc->value_len,
+						&chrc->value_known, chrc->path,
+						GATT_CHARACTERISTIC_IFACE);
 
-reply:
 	reply = g_dbus_create_reply(op->msg, DBUS_TYPE_INVALID);
 	if (!reply) {
 		error("Failed to allocate D-Bus message reply");
 		return;
 	}
 
-	dbus_message_iter_init_append(reply, &iter);
-	dbus_message_iter_open_container(&iter, DBUS_TYPE_ARRAY, "y", &array);
-
-	for (i = 0; i < length; i++)
-		dbus_message_iter_append_basic(&array, DBUS_TYPE_BYTE,
-								value + i);
-
-	dbus_message_iter_close_container(&iter, &array);
+	message_append_byte_array(reply, value, length);
 
 done:
 	g_dbus_send_message(btd_get_dbus_connection(), reply);
@@ -495,26 +583,26 @@ static DBusMessage *characteristic_read_value(DBusConnection *conn,
 {
 	struct characteristic *chrc = user_data;
 	struct bt_gatt_client *gatt = chrc->service->client->gatt;
-	struct chrc_dbus_op *op;
+	struct async_dbus_op *op;
 
 	if (chrc->in_read)
 		return btd_error_in_progress(msg);
 
-	op = new0(struct chrc_dbus_op, 1);
+	op = new0(struct async_dbus_op, 1);
 	if (!op)
 		return btd_error_failed(msg, "Failed to initialize request");
 
-	op->chrc = chrc;
 	op->msg = dbus_message_ref(msg);
+	op->data = chrc;
 
 	if (bt_gatt_client_read_long_value(gatt, chrc->value_handle, 0,
 							chrc_read_long_cb, op,
-							chrc_dbus_op_free)) {
+							async_dbus_op_free)) {
 		chrc->in_read = true;
 		return NULL;
 	}
 
-	chrc_dbus_op_free(op);
+	async_dbus_op_free(op);
 
 	return btd_error_failed(msg, "Failed to send read request");
 }
-- 
2.2.0.rc0.207.ga3a616c

