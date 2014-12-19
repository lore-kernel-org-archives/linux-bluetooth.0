Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH BlueZ 14/17] core: gatt: Reference count chrcs and descs.
Date: Fri, 19 Dec 2014 13:36:02 -0800
Message-Id: <1419024965-10375-15-git-send-email-armansito@chromium.org>
In-Reply-To: <1419024965-10375-1-git-send-email-armansito@chromium.org>
References: <1419024965-10375-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Many of the GATT D-Bus API methods are asynchronous and their callbacks
depend on characteristic and descriptor instances to be alive when they
execute. This patch makes characteristics and descriptors reference
counted so that an interim disconnect or "Service Changed" won't
immediately free up those instances.
---
 src/gatt-client.c | 193 ++++++++++++++++++++++++++++++++++++++----------------
 1 file changed, 135 insertions(+), 58 deletions(-)

diff --git a/src/gatt-client.c b/src/gatt-client.c
index ee0a9c9..a2e73ac 100644
--- a/src/gatt-client.c
+++ b/src/gatt-client.c
@@ -78,6 +78,8 @@ struct characteristic {
 	bt_uuid_t uuid;
 	char *path;
 
+	int ref_count;
+
 	bool in_read;
 	bool in_write;
 	bool value_known;
@@ -96,6 +98,8 @@ struct descriptor {
 	bt_uuid_t uuid;
 	char *path;
 
+	int ref_count;
+
 	bool in_read;
 	bool in_write;
 	bool value_known;
@@ -103,6 +107,45 @@ struct descriptor {
 	size_t value_len;
 };
 
+static struct characteristic *characteristic_ref(struct characteristic *chrc)
+{
+	__sync_fetch_and_add(&chrc->ref_count, 1);
+
+	return chrc;
+}
+
+static void characteristic_unref(void *data)
+{
+	struct characteristic *chrc = data;
+
+	if (__sync_sub_and_fetch(&chrc->ref_count, 1))
+		return;
+
+	queue_destroy(chrc->descs, NULL);  /* List should be empty here */
+	free(chrc->value);
+	g_free(chrc->path);
+	free(chrc);
+}
+
+static struct descriptor *descriptor_ref(struct descriptor *desc)
+{
+	__sync_fetch_and_add(&desc->ref_count, 1);
+
+	return desc;
+}
+
+static void descriptor_unref(void *data)
+{
+	struct descriptor *desc = data;
+
+	if (__sync_sub_and_fetch(&desc->ref_count, 1))
+		return;
+
+	free(desc->value);
+	g_free(desc->path);
+	free(desc);
+}
+
 static DBusMessage *gatt_error_read_not_permitted(DBusMessage *msg)
 {
 	return g_dbus_create_error(msg, ERROR_INTERFACE ".ReadNotPermitted",
@@ -319,17 +362,22 @@ static bool parse_value_arg(DBusMessage *msg, uint8_t **value,
 }
 
 typedef bool (*async_dbus_op_complete_t)(void *data);
+typedef void (*async_dbus_op_destroy_t)(void *data);
 
 struct async_dbus_op {
 	DBusMessage *msg;
 	void *data;
 	async_dbus_op_complete_t complete;
+	async_dbus_op_destroy_t destroy;
 };
 
 static void async_dbus_op_free(void *data)
 {
 	struct async_dbus_op *op = data;
 
+	if (op->destroy)
+		op->destroy(op->data);
+
 	if (op->msg)
 		dbus_message_unref(op->msg);
 
@@ -361,6 +409,7 @@ struct async_read_op {
 	uint16_t handle;
 	void *data;
 	bool (*complete)(const uint8_t *value, size_t len, void *data);
+	void (*destroy)(void *data);
 };
 
 static struct async_read_op *async_read_op_ref(struct async_read_op *op)
@@ -377,6 +426,9 @@ static void async_read_op_unref(void *data)
 	if (__sync_sub_and_fetch(&op->ref_count, 1))
 		return;
 
+	if (op->destroy)
+		op->destroy(op->data);
+
 	dbus_message_unref(op->msg);
 	free(op->value);
 	free(op);
@@ -526,8 +578,9 @@ static DBusMessage *descriptor_read_value(DBusConnection *conn,
 	op->msg = dbus_message_ref(msg);
 	op->gatt = gatt;
 	op->handle = desc->handle;
-	op->data = desc;
+	op->data = descriptor_ref(desc);
 	op->complete = desc_read_complete;
+	op->destroy = descriptor_unref;
 
 	if (bt_gatt_client_read_value(gatt, desc->handle, read_cb,
 							async_read_op_ref(op),
@@ -582,7 +635,8 @@ static bool start_long_write(DBusMessage *msg, uint16_t handle,
 					struct bt_gatt_client *gatt,
 					bool reliable, const uint8_t *value,
 					size_t value_len, void *data,
-					async_dbus_op_complete_t complete)
+					async_dbus_op_complete_t complete,
+					async_dbus_op_destroy_t destroy)
 {
 	struct async_dbus_op *op;
 
@@ -593,6 +647,7 @@ static bool start_long_write(DBusMessage *msg, uint16_t handle,
 	op->msg = dbus_message_ref(msg);
 	op->data = data;
 	op->complete = complete;
+	op->destroy = destroy;
 
 	if (bt_gatt_client_write_long_value(gatt, reliable, handle,
 							0, value, value_len,
@@ -609,7 +664,8 @@ static bool start_write_request(DBusMessage *msg, uint16_t handle,
 					struct bt_gatt_client *gatt,
 					const uint8_t *value, size_t value_len,
 					void *data,
-					async_dbus_op_complete_t complete)
+					async_dbus_op_complete_t complete,
+					async_dbus_op_destroy_t destroy)
 {
 	struct async_dbus_op *op;
 
@@ -620,6 +676,7 @@ static bool start_write_request(DBusMessage *msg, uint16_t handle,
 	op->msg = dbus_message_ref(msg);
 	op->data = data;
 	op->complete = complete;
+	op->destroy = destroy;
 
 	if (bt_gatt_client_write_value(gatt, handle, value, value_len,
 							write_cb, op,
@@ -674,11 +731,13 @@ static DBusMessage *descriptor_write_value(DBusConnection *conn,
 	if (value_len <= (unsigned) bt_gatt_client_get_mtu(gatt) - 3)
 		result = start_write_request(msg, desc->handle, gatt, value,
 							value_len, desc,
-							desc_write_complete);
+							desc_write_complete,
+							descriptor_unref);
 	else
 		result = start_long_write(msg, desc->handle, gatt, false, value,
 							value_len, desc,
-							desc_write_complete);
+							desc_write_complete,
+							descriptor_unref);
 
 	if (!result)
 		return btd_error_failed(msg, "Failed to initiate write");
@@ -704,15 +763,6 @@ static const GDBusMethodTable descriptor_methods[] = {
 	{ }
 };
 
-static void descriptor_free(void *data)
-{
-	struct descriptor *desc = data;
-
-	free(desc->value);
-	g_free(desc->path);
-	free(desc);
-}
-
 static struct descriptor *descriptor_create(struct gatt_db_attribute *attr,
 						struct characteristic *chrc)
 {
@@ -733,10 +783,11 @@ static struct descriptor *descriptor_create(struct gatt_db_attribute *attr,
 						GATT_DESCRIPTOR_IFACE,
 						descriptor_methods, NULL,
 						descriptor_properties,
-						desc, descriptor_free)) {
+						descriptor_ref(desc),
+						descriptor_unref)) {
 		error("Unable to register GATT descriptor with handle 0x%04x",
 								desc->handle);
-		descriptor_free(desc);
+		descriptor_unref(desc);
 
 		return NULL;
 	}
@@ -755,6 +806,8 @@ static void unregister_descriptor(void *data)
 
 	DBG("Removing GATT descriptor: %s", desc->path);
 
+	desc->chrc = NULL;
+
 	g_dbus_unregister_interface(btd_get_dbus_connection(), desc->path,
 							GATT_DESCRIPTOR_IFACE);
 }
@@ -911,8 +964,9 @@ static DBusMessage *characteristic_read_value(DBusConnection *conn,
 	op->msg = dbus_message_ref(msg);
 	op->gatt = gatt;
 	op->handle = chrc->value_handle;
-	op->data = chrc;
+	op->data = characteristic_ref(chrc);
 	op->complete = chrc_read_complete;
+	op->destroy = characteristic_unref;
 
 	/*
 	 * A remote server may support the "read" procedure but may not support
@@ -976,8 +1030,10 @@ static DBusMessage *characteristic_write_value(DBusConnection *conn,
 	 */
 	if ((chrc->ext_props & BT_GATT_CHRC_EXT_PROP_RELIABLE_WRITE) &&
 			start_long_write(msg, chrc->value_handle, gatt, true,
-							value, value_len, chrc,
-							chrc_write_complete))
+						value, value_len,
+						characteristic_ref(chrc),
+						chrc_write_complete,
+						characteristic_unref))
 		goto done_async;
 
 	if (chrc->props & BT_GATT_CHRC_PROP_WRITE) {
@@ -990,13 +1046,16 @@ static DBusMessage *characteristic_write_value(DBusConnection *conn,
 
 		if (value_len <= (unsigned) mtu - 3)
 			result = start_write_request(msg, chrc->value_handle,
-							gatt, value,
-							value_len, chrc,
-							chrc_write_complete);
+						gatt, value, value_len,
+						characteristic_ref(chrc),
+						chrc_write_complete,
+						characteristic_unref);
 		else
 			result = start_long_write(msg, chrc->value_handle, gatt,
-						false, value, value_len, chrc,
-						chrc_write_complete);
+						false, value, value_len,
+						characteristic_ref(chrc),
+						chrc_write_complete,
+						characteristic_unref);
 
 		if (result)
 			goto done_async;
@@ -1129,12 +1188,33 @@ static bool match_notify_sender(const void *a, const void *b)
 	return strcmp(client->owner, sender) == 0;
 }
 
+struct register_notify_op {
+	int ref_count;
+	struct notify_client *client;
+	struct characteristic *chrc;
+};
+
+static void register_notify_op_unref(void *data)
+{
+	struct register_notify_op *op = data;
+
+	DBG("Released register_notify_op");
+
+	if (__sync_sub_and_fetch(&op->ref_count, 1))
+		return;
+
+	notify_client_unref(op->client);
+	characteristic_unref(op->chrc);
+
+	free(op);
+}
+
 static void notify_cb(uint16_t value_handle, const uint8_t *value,
 					uint16_t length, void *user_data)
 {
 	struct async_dbus_op *op = user_data;
-	struct notify_client *client = op->data;
-	struct characteristic *chrc = client->chrc;
+	struct register_notify_op *notify_op = op->data;
+	struct characteristic *chrc = notify_op->chrc;
 
 	/*
 	 * Even if the value didn't change, we want to send a PropertiesChanged
@@ -1151,26 +1231,24 @@ static void register_notify_cb(unsigned int id, uint16_t att_ecode,
 								void *user_data)
 {
 	struct async_dbus_op *op = user_data;
-	struct notify_client *client = op->data;
-	struct characteristic *chrc = client->chrc;
+	struct register_notify_op *notify_op = op->data;
+	struct notify_client *client = notify_op->client;
+	struct characteristic *chrc = notify_op->chrc;
 	DBusMessage *reply;
 
-	/* Make sure that an interim disconnect did not remove the client */
-	if (!queue_find(chrc->notify_clients, NULL, client)) {
+	/*
+	 * Make sure that an interim disconnect or "Service Changed" did not
+	 * remove the client
+	 */
+	if (!chrc->service || !queue_find(chrc->notify_clients, NULL, client)) {
 		bt_gatt_client_unregister_notify(chrc->service->client->gatt,
 									id);
-		notify_client_unref(client);
 
 		reply = btd_error_failed(op->msg,
 						"Characteristic not available");
 		goto done;
 	}
 
-	/*
-	 * Drop the reference count that we added when registering the callback.
-	 */
-	notify_client_unref(client);
-
 	if (!id) {
 		queue_remove(chrc->notify_clients, client);
 		notify_client_free(client);
@@ -1209,6 +1287,7 @@ static DBusMessage *characteristic_start_notify(DBusConnection *conn,
 	const char *sender = dbus_message_get_sender(msg);
 	struct async_dbus_op *op;
 	struct notify_client *client;
+	struct register_notify_op *notify_op;
 
 	if (!(chrc->props & BT_GATT_CHRC_PROP_NOTIFY ||
 				chrc->props & BT_GATT_CHRC_PROP_INDICATE))
@@ -1225,20 +1304,28 @@ static DBusMessage *characteristic_start_notify(DBusConnection *conn,
 	if (!client)
 		return btd_error_failed(msg, "Failed allocate notify session");
 
+	notify_op = new0(struct register_notify_op, 1);
+	if (!notify_op) {
+		notify_client_unref(client);
+		return btd_error_failed(msg, "Failed to initialize request");
+	}
+
+	notify_op->ref_count = 1;
+	notify_op->client = client;
+	notify_op->chrc = characteristic_ref(chrc);
+
 	op = new0(struct async_dbus_op, 1);
 	if (!op) {
-		notify_client_unref(client);
+		register_notify_op_unref(notify_op);
 		return btd_error_failed(msg, "Failed to initialize request");
 	}
 
-	/*
-	 * Add to the ref count so that a disconnect during register won't free
-	 * the client instance.
-	 */
-	op->data = notify_client_ref(client);
+	op->data = notify_op;
 	op->msg = dbus_message_ref(msg);
+	op->destroy = register_notify_op_unref;
 
-	queue_push_tail(chrc->notify_clients, client);
+	/* The characteristic owns a reference to the client */
+	queue_push_tail(chrc->notify_clients, notify_client_ref(client));
 
 	if (bt_gatt_client_register_notify(gatt, chrc->value_handle,
 						register_notify_cb, notify_cb,
@@ -1248,9 +1335,6 @@ static DBusMessage *characteristic_start_notify(DBusConnection *conn,
 	queue_remove(chrc->notify_clients, client);
 	async_dbus_op_free(op);
 
-	/* Directly free the client */
-	notify_client_free(client);
-
 	return btd_error_failed(msg, "Failed to register notify session");
 }
 
@@ -1325,16 +1409,6 @@ static const GDBusMethodTable characteristic_methods[] = {
 	{ }
 };
 
-static void characteristic_free(void *data)
-{
-	struct characteristic *chrc = data;
-
-	queue_destroy(chrc->descs, NULL);  /* List should be empty here */
-	free(chrc->value);
-	g_free(chrc->path);
-	free(chrc);
-}
-
 static struct characteristic *characteristic_create(
 						struct gatt_db_attribute *attr,
 						struct service *service)
@@ -1373,10 +1447,11 @@ static struct characteristic *characteristic_create(
 						GATT_CHARACTERISTIC_IFACE,
 						characteristic_methods, NULL,
 						characteristic_properties,
-						chrc, characteristic_free)) {
+						characteristic_ref(chrc),
+						characteristic_unref)) {
 		error("Unable to register GATT characteristic with handle "
 							"0x%04x", chrc->handle);
-		characteristic_free(chrc);
+		characteristic_unref(chrc);
 
 		return NULL;
 	}
@@ -1395,6 +1470,8 @@ static void unregister_characteristic(void *data)
 	queue_remove_all(chrc->notify_clients, NULL, NULL, notify_client_unref);
 	queue_remove_all(chrc->descs, NULL, NULL, unregister_descriptor);
 
+	chrc->service = NULL;
+
 	g_dbus_unregister_interface(btd_get_dbus_connection(), chrc->path,
 						GATT_CHARACTERISTIC_IFACE);
 }
-- 
2.2.0.rc0.207.ga3a616c

