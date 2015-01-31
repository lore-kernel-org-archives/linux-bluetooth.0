Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com, Arman Uguray <armansito@chromium.org>
Subject: [PATCH BlueZ v3 2/5] core: gatt: Implement GattCharacteristic1.StartNotify
Date: Fri, 30 Jan 2015 16:32:35 -0800
Message-Id: <1422664358-17061-3-git-send-email-armansito@chromium.org>
In-Reply-To: <1422664358-17061-1-git-send-email-armansito@chromium.org>
References: <1422664358-17061-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch implements the StartNotify method of
org.bluez.GattCharacteristic1. Each call to StartNotify assigns a
session to the D-Bus sender which internally registers a unique
notify handler with the bt_gatt_client. Each received notification
or indication causes a PropertiesChanged signal to be emitted for the
"Value" property.

The notify handler gets automatically unregistered when sender
disconnects from D-Bus.
---
 src/gatt-client.c | 254 ++++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 245 insertions(+), 9 deletions(-)

diff --git a/src/gatt-client.c b/src/gatt-client.c
index cb8ddf6..4f5022a 100644
--- a/src/gatt-client.c
+++ b/src/gatt-client.c
@@ -88,6 +88,9 @@ struct characteristic {
 	unsigned int write_id;
 
 	struct queue *descs;
+
+	bool notifying;
+	struct queue *notify_clients;
 };
 
 struct descriptor {
@@ -231,7 +234,9 @@ static void async_dbus_op_free(void *data)
 {
 	struct async_dbus_op *op = data;
 
-	dbus_message_unref(op->msg);
+	if (op->msg)
+		dbus_message_unref(op->msg);
+
 	free(op);
 }
 
@@ -689,12 +694,8 @@ static gboolean characteristic_value_exists(const GDBusPropertyTable *property,
 static gboolean characteristic_get_notifying(const GDBusPropertyTable *property,
 					DBusMessageIter *iter, void *data)
 {
-	dbus_bool_t notifying = FALSE;
-
-	/*
-	 * TODO: Return the correct value here once StartNotify and StopNotify
-	 * methods are implemented.
-	 */
+	struct characteristic *chrc = data;
+	dbus_bool_t notifying = chrc->notifying ? TRUE : FALSE;
 
 	dbus_message_iter_append_basic(iter, DBUS_TYPE_BOOLEAN, &notifying);
 
@@ -925,11 +926,238 @@ fail:
 	return btd_error_not_supported(msg);
 }
 
+struct notify_client {
+	struct characteristic *chrc;
+	int ref_count;
+	char *owner;
+	guint watch;
+	unsigned int notify_id;
+};
+
+static void notify_client_free(struct notify_client *client)
+{
+	DBG("owner %s", client->owner);
+
+	g_dbus_remove_watch(btd_get_dbus_connection(), client->watch);
+	bt_gatt_client_unregister_notify(client->chrc->service->client->gatt,
+							client->notify_id);
+	free(client->owner);
+	free(client);
+}
+
+static void notify_client_unref(void *data)
+{
+	struct notify_client *client = data;
+
+	DBG("owner %s", client->owner);
+
+	if (__sync_sub_and_fetch(&client->ref_count, 1))
+		return;
+
+	notify_client_free(client);
+}
+
+static struct notify_client *notify_client_ref(struct notify_client *client)
+{
+	DBG("owner %s", client->owner);
+
+	__sync_fetch_and_add(&client->ref_count, 1);
+
+	return client;
+}
+
+static bool match_notifying(const void *a, const void *b)
+{
+	const struct notify_client *client = a;
+
+	return !!client->notify_id;
+}
+
+static void update_notifying(struct characteristic *chrc)
+{
+	if (!chrc->notifying)
+		return;
+
+	if (queue_find(chrc->notify_clients, match_notifying, NULL))
+		return;
+
+	chrc->notifying = false;
+
+	g_dbus_emit_property_changed(btd_get_dbus_connection(), chrc->path,
+						GATT_CHARACTERISTIC_IFACE,
+						"Notifying");
+}
+
+static void notify_client_disconnect(DBusConnection *conn, void *user_data)
+{
+	struct notify_client *client = user_data;
+	struct characteristic *chrc = client->chrc;
+	struct bt_gatt_client *gatt = chrc->service->client->gatt;
+
+	DBG("owner %s", client->owner);
+
+	queue_remove(chrc->notify_clients, client);
+	bt_gatt_client_unregister_notify(gatt, client->notify_id);
+
+	update_notifying(chrc);
+
+	notify_client_unref(client);
+}
+
+static struct notify_client *notify_client_create(struct characteristic *chrc,
+							const char *owner)
+{
+	struct notify_client *client;
+
+	client = new0(struct notify_client, 1);
+	if (!client)
+		return NULL;
+
+	client->chrc = chrc;
+	client->owner = strdup(owner);
+	if (!client->owner) {
+		free(client);
+		return NULL;
+	}
+
+	client->watch = g_dbus_add_disconnect_watch(btd_get_dbus_connection(),
+						owner, notify_client_disconnect,
+						client, NULL);
+	if (!client->watch) {
+		free(client->owner);
+		free(client);
+		return NULL;
+	}
+
+	return notify_client_ref(client);
+}
+
+static bool match_notify_sender(const void *a, const void *b)
+{
+	const struct notify_client *client = a;
+	const char *sender = b;
+
+	return strcmp(client->owner, sender) == 0;
+}
+
+static void notify_cb(uint16_t value_handle, const uint8_t *value,
+					uint16_t length, void *user_data)
+{
+	struct async_dbus_op *op = user_data;
+	struct notify_client *client = op->data;
+	struct characteristic *chrc = client->chrc;
+
+	/*
+	 * Even if the value didn't change, we want to send a PropertiesChanged
+	 * signal so that we propagate the notification/indication to
+	 * applications.
+	 */
+	gatt_db_attribute_reset(chrc->attr);
+	gatt_db_attribute_write(chrc->attr, 0, value, length, 0, NULL,
+						write_characteristic_cb, chrc);
+}
+
+static void register_notify_cb(uint16_t att_ecode, void *user_data)
+{
+	struct async_dbus_op *op = user_data;
+	struct notify_client *client = op->data;
+	struct characteristic *chrc = client->chrc;
+	DBusMessage *reply;
+
+	/* Make sure that an interim disconnect did not remove the client */
+	if (!queue_find(chrc->notify_clients, NULL, client)) {
+		bt_gatt_client_unregister_notify(chrc->service->client->gatt,
+							client->notify_id);
+		notify_client_unref(client);
+
+		reply = btd_error_failed(op->msg,
+						"Characteristic not available");
+		goto done;
+	}
+
+	/*
+	 * Drop the reference count that we added when registering the callback.
+	 */
+	notify_client_unref(client);
+
+	if (att_ecode) {
+		queue_remove(chrc->notify_clients, client);
+		notify_client_free(client);
+
+		reply = create_gatt_dbus_error(op->msg, att_ecode);
+
+		goto done;
+	}
+
+	if (!chrc->notifying) {
+		chrc->notifying = true;
+		g_dbus_emit_property_changed(btd_get_dbus_connection(),
+					chrc->path, GATT_CHARACTERISTIC_IFACE,
+					"Notifying");
+	}
+
+	reply = g_dbus_create_reply(op->msg, DBUS_TYPE_INVALID);
+
+done:
+	if (reply)
+		g_dbus_send_message(btd_get_dbus_connection(), reply);
+	else
+		error("Failed to construct D-Bus message reply");
+}
+
 static DBusMessage *characteristic_start_notify(DBusConnection *conn,
 					DBusMessage *msg, void *user_data)
 {
-	/* TODO: Implement */
-	return btd_error_failed(msg, "Not implemented");
+	struct characteristic *chrc = user_data;
+	struct bt_gatt_client *gatt = chrc->service->client->gatt;
+	const char *sender = dbus_message_get_sender(msg);
+	struct async_dbus_op *op;
+	struct notify_client *client;
+
+	if (!(chrc->props & BT_GATT_CHRC_PROP_NOTIFY ||
+				chrc->props & BT_GATT_CHRC_PROP_INDICATE))
+		return btd_error_not_supported(msg);
+
+	/* Each client can only have one active notify session. */
+	client = queue_find(chrc->notify_clients, match_notify_sender, sender);
+	if (client)
+		return client->notify_id ?
+				btd_error_failed(msg, "Already notifying") :
+				btd_error_in_progress(msg);
+
+	client = notify_client_create(chrc, sender);
+	if (!client)
+		return btd_error_failed(msg, "Failed allocate notify session");
+
+	op = new0(struct async_dbus_op, 1);
+	if (!op) {
+		notify_client_unref(client);
+		return btd_error_failed(msg, "Failed to initialize request");
+	}
+
+	/*
+	 * Add to the ref count so that a disconnect during register won't free
+	 * the client instance.
+	 */
+	op->data = notify_client_ref(client);
+	op->msg = dbus_message_ref(msg);
+
+	queue_push_tail(chrc->notify_clients, client);
+
+	client->notify_id = bt_gatt_client_register_notify(gatt,
+						chrc->value_handle,
+						register_notify_cb, notify_cb,
+						op, async_dbus_op_free);
+	if (client->notify_id)
+		return NULL;
+
+	queue_remove(chrc->notify_clients, client);
+	async_dbus_op_free(op);
+
+	/* Directly free the client */
+	notify_client_free(client);
+
+	return btd_error_failed(msg, "Failed to register notify session");
 }
 
 static DBusMessage *characteristic_stop_notify(DBusConnection *conn,
@@ -1022,6 +1250,13 @@ static struct characteristic *characteristic_create(
 		return NULL;
 	}
 
+	chrc->notify_clients = queue_new();
+	if (!chrc->notify_clients) {
+		queue_destroy(chrc->descs, NULL);
+		free(chrc);
+		return NULL;
+	}
+
 	chrc->service = service;
 
 	gatt_db_attribute_get_char_data(attr, &chrc->handle,
@@ -1064,6 +1299,7 @@ static void unregister_characteristic(void *data)
 	if (chrc->write_id)
 		bt_gatt_client_cancel(gatt, chrc->write_id);
 
+	queue_remove_all(chrc->notify_clients, NULL, NULL, notify_client_unref);
 	queue_remove_all(chrc->descs, NULL, NULL, unregister_descriptor);
 
 	g_dbus_unregister_interface(btd_get_dbus_connection(), chrc->path,
-- 
2.2.0.rc0.207.ga3a616c

