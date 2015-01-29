Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com, Arman Uguray <armansito@chromium.org>
Subject: [PATCH BlueZ 5/5] core: gatt: Keep objects over disconnects
Date: Wed, 28 Jan 2015 18:11:03 -0800
Message-Id: <1422497463-32539-6-git-send-email-armansito@chromium.org>
In-Reply-To: <1422497463-32539-1-git-send-email-armansito@chromium.org>
References: <1422497463-32539-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch changes the way that the life-time for exported GATT API
objects are managed, so that they are kept alive in the case of a
disconnection if the devices are bonded. In this case, all API method
calls return an error except for StartNotify/StopNotify.

All notification sessions that were initiated during and in-between
connections are maintained and a notification callback is registered
for each session immediately on reconnection.

Change-Id: Ib7ac72a91dd8dc4b631c0948b4bd41af0bd4ff7b
---
 src/gatt-client.c | 208 ++++++++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 187 insertions(+), 21 deletions(-)

diff --git a/src/gatt-client.c b/src/gatt-client.c
index a3cebca..6c83f11 100644
--- a/src/gatt-client.c
+++ b/src/gatt-client.c
@@ -58,6 +58,7 @@ struct btd_gatt_client {
 	struct bt_gatt_client *gatt;
 
 	struct queue *services;
+	struct queue *all_notify_clients;
 };
 
 struct service {
@@ -387,6 +388,9 @@ static DBusMessage *descriptor_read_value(DBusConnection *conn,
 	struct bt_gatt_client *gatt = desc->chrc->service->client->gatt;
 	struct async_dbus_op *op;
 
+	if (!gatt)
+		return btd_error_failed(msg, "Not connected");
+
 	if (desc->read_id)
 		return btd_error_in_progress(msg);
 
@@ -521,6 +525,9 @@ static DBusMessage *descriptor_write_value(DBusConnection *conn,
 	uint8_t *value = NULL;
 	size_t value_len = 0;
 
+	if (!gatt)
+		return btd_error_failed(msg, "Not connected");
+
 	if (desc->write_id)
 		return btd_error_in_progress(msg);
 
@@ -815,6 +822,9 @@ static DBusMessage *characteristic_read_value(DBusConnection *conn,
 	struct bt_gatt_client *gatt = chrc->service->client->gatt;
 	struct async_dbus_op *op;
 
+	if (!gatt)
+		return btd_error_failed(msg, "Not connected");
+
 	if (chrc->read_id)
 		return btd_error_in_progress(msg);
 
@@ -859,6 +869,9 @@ static DBusMessage *characteristic_write_value(DBusConnection *conn,
 	size_t value_len = 0;
 	bool supported = false;
 
+	if (!gatt)
+		return btd_error_failed(msg, "Not connected");
+
 	if (chrc->write_id)
 		return btd_error_in_progress(msg);
 
@@ -995,6 +1008,7 @@ static void notify_client_disconnect(DBusConnection *conn, void *user_data)
 	DBG("owner %s", client->owner);
 
 	queue_remove(chrc->notify_clients, client);
+	queue_remove(chrc->service->client->all_notify_clients, client);
 	bt_gatt_client_unregister_notify(gatt, client->notify_id);
 
 	update_notifying(chrc);
@@ -1055,6 +1069,31 @@ static void notify_cb(uint16_t value_handle, const uint8_t *value,
 						write_characteristic_cb, chrc);
 }
 
+static DBusMessage *create_notify_reply(struct async_dbus_op *op,
+						bool success, uint8_t att_ecode)
+{
+	DBusMessage *reply = NULL;
+
+	if (!op->msg)
+		return NULL;
+
+	if (success)
+		reply = g_dbus_create_reply(op->msg, DBUS_TYPE_INVALID);
+	else if (att_ecode)
+		reply = create_gatt_dbus_error(op->msg, att_ecode);
+	else
+		reply = btd_error_failed(op->msg,
+						"Characteristic not available");
+
+	dbus_message_unref(op->msg);
+	op->msg = NULL;
+
+	if (!reply)
+		error("Failed to construct D-Bus message reply");
+
+	return reply;
+}
+
 static void register_notify_cb(unsigned int id, uint16_t att_ecode,
 								void *user_data)
 {
@@ -1069,8 +1108,8 @@ static void register_notify_cb(unsigned int id, uint16_t att_ecode,
 									id);
 		notify_client_unref(client);
 
-		reply = btd_error_failed(op->msg,
-						"Characteristic not available");
+		reply = create_notify_reply(op, false, 0);
+
 		goto done;
 	}
 
@@ -1081,9 +1120,10 @@ static void register_notify_cb(unsigned int id, uint16_t att_ecode,
 
 	if (!id) {
 		queue_remove(chrc->notify_clients, client);
+		queue_remove(chrc->service->client->all_notify_clients, client);
 		notify_client_free(client);
 
-		reply = create_gatt_dbus_error(op->msg, att_ecode);
+		reply = create_notify_reply(op, false, att_ecode);
 
 		goto done;
 	}
@@ -1097,16 +1137,11 @@ static void register_notify_cb(unsigned int id, uint16_t att_ecode,
 					"Notifying");
 	}
 
-	reply = g_dbus_create_reply(op->msg, DBUS_TYPE_INVALID);
+	reply = create_notify_reply(op, true, 0);
 
 done:
 	if (reply)
 		g_dbus_send_message(btd_get_dbus_connection(), reply);
-	else
-		error("Failed to construct D-Bus message reply");
-
-	dbus_message_unref(op->msg);
-	op->msg = NULL;
 }
 
 static DBusMessage *characteristic_start_notify(DBusConnection *conn,
@@ -1133,12 +1168,33 @@ static DBusMessage *characteristic_start_notify(DBusConnection *conn,
 	if (!client)
 		return btd_error_failed(msg, "Failed allocate notify session");
 
-	op = new0(struct async_dbus_op, 1);
-	if (!op) {
-		notify_client_unref(client);
-		return btd_error_failed(msg, "Failed to initialize request");
+	queue_push_tail(chrc->notify_clients, client);
+	queue_push_tail(chrc->service->client->all_notify_clients, client);
+
+	/*
+	 * If the device is currently not connected, return success. We will
+	 * automatically try and register all clients when a GATT client becomes
+	 * ready.
+	 */
+	if (!gatt) {
+		DBusMessage *reply;
+
+		reply = g_dbus_create_reply(msg, DBUS_TYPE_INVALID);
+		if (reply)
+			return reply;
+
+		/*
+		 * Clean up and respond with an error instead of timing out to
+		 * avoid any ambiguities.
+		 */
+		error("Failed to construct D-Bus message reply");
+		goto fail;
 	}
 
+	op = new0(struct async_dbus_op, 1);
+	if (!op)
+		goto fail;
+
 	/*
 	 * Add to the ref count so that a disconnect during register won't free
 	 * the client instance.
@@ -1146,16 +1202,17 @@ static DBusMessage *characteristic_start_notify(DBusConnection *conn,
 	op->data = notify_client_ref(client);
 	op->msg = dbus_message_ref(msg);
 
-	queue_push_tail(chrc->notify_clients, client);
-
 	if (bt_gatt_client_register_notify(gatt, chrc->value_handle,
 						register_notify_cb, notify_cb,
 						op, async_dbus_op_free))
 		return NULL;
 
-	queue_remove(chrc->notify_clients, client);
 	async_dbus_op_free(op);
 
+fail:
+	queue_remove(chrc->notify_clients, client);
+	queue_remove(chrc->service->client->all_notify_clients, client);
+
 	/* Directly free the client */
 	notify_client_free(client);
 
@@ -1178,6 +1235,7 @@ static DBusMessage *characteristic_stop_notify(DBusConnection *conn,
 	if (!client)
 		return btd_error_failed(msg, "No notify session started");
 
+	queue_remove(chrc->service->client->all_notify_clients, client);
 	bt_gatt_client_unregister_notify(gatt, client->notify_id);
 	update_notifying(chrc);
 
@@ -1682,6 +1740,13 @@ struct btd_gatt_client *btd_gatt_client_new(struct btd_device *device)
 		return NULL;
 	}
 
+	client->all_notify_clients = queue_new();
+	if (!client->all_notify_clients) {
+		queue_destroy(client->services, NULL);
+		free(client);
+		return NULL;
+	}
+
 	client->device = device;
 	ba2str(device_get_address(device), client->devaddr);
 
@@ -1696,11 +1761,43 @@ void btd_gatt_client_destroy(struct btd_gatt_client *client)
 		return;
 
 	queue_destroy(client->services, unregister_service);
+	queue_destroy(client->all_notify_clients, NULL);
 	bt_gatt_client_unref(client->gatt);
 	gatt_db_unref(client->db);
 	free(client);
 }
 
+static void register_notify(void *data, void *user_data)
+{
+	struct notify_client *notify_client = data;
+	struct btd_gatt_client *client = user_data;
+	struct async_dbus_op *op;
+
+	DBG("Re-register subscribed notification client");
+
+	op = new0(struct async_dbus_op, 1);
+	if (!op)
+		goto fail;
+
+	op->data = notify_client_ref(notify_client);
+
+	if (bt_gatt_client_register_notify(client->gatt,
+					notify_client->chrc->value_handle,
+					register_notify_cb, notify_cb,
+					op, async_dbus_op_free))
+		return;
+
+	async_dbus_op_free(op);
+
+fail:
+	DBG("Failed to re-register notification client");
+
+	queue_remove(notify_client->chrc->notify_clients, client);
+	queue_remove(client->all_notify_clients, client);
+
+	notify_client_free(notify_client);
+}
+
 void btd_gatt_client_ready(struct btd_gatt_client *client)
 {
 	struct bt_gatt_client *gatt;
@@ -1719,7 +1816,19 @@ void btd_gatt_client_ready(struct btd_gatt_client *client)
 
 	client->ready = true;
 
-	create_services(client);
+	DBG("GATT client ready");
+
+	if (queue_isempty(client->services)) {
+		DBG("Exporting services");
+		create_services(client);
+		return;
+	}
+
+	/*
+	 * Services have already been created before. Re-enable notifications
+	 * for any pre-registered notification sessions.
+	 */
+	queue_foreach(client->all_notify_clients, register_notify, client);
 }
 
 void btd_gatt_client_service_added(struct btd_gatt_client *client,
@@ -1757,18 +1866,75 @@ void btd_gatt_client_service_removed(struct btd_gatt_client *client,
 						unregister_service);
 }
 
+static void clear_notify_id(void *data, void *user_data)
+{
+	struct notify_client *client = data;
+
+	client->notify_id = 0;
+}
+
+static void cancel_desc_ops(void *data, void *user_data)
+{
+	struct descriptor *desc = data;
+	struct bt_gatt_client *gatt = user_data;
+
+	if (desc->read_id) {
+		bt_gatt_client_cancel(gatt, desc->read_id);
+		desc->read_id = 0;
+	}
+
+	if (desc->write_id) {
+		bt_gatt_client_cancel(gatt, desc->write_id);
+		desc->write_id = 0;
+	}
+}
+
+static void cancel_chrc_ops(void *data, void *user_data)
+{
+	struct characteristic *chrc = data;
+	struct bt_gatt_client *gatt = user_data;
+
+	if (chrc->read_id) {
+		bt_gatt_client_cancel(gatt, chrc->read_id);
+		chrc->read_id = 0;
+	}
+
+	if (chrc->write_id) {
+		bt_gatt_client_cancel(gatt, chrc->write_id);
+		chrc->write_id = 0;
+	}
+
+	queue_foreach(chrc->descs, cancel_desc_ops, user_data);
+}
+
+static void cancel_ops(void *data, void *user_data)
+{
+	struct service *service = data;
+
+	queue_foreach(service->chrcs, cancel_chrc_ops, user_data);
+}
+
 void btd_gatt_client_disconnected(struct btd_gatt_client *client)
 {
-	if (!client)
+	if (!client || !client->gatt)
 		return;
 
-	DBG("Device disconnected. Cleaning up");
+	DBG("Device disconnected. Cleaning up.");
 
 	/*
 	 * Remove all services. We'll recreate them when a new bt_gatt_client
-	 * becomes ready.
+	 * becomes ready. Leave the services around if the device is bonded.
 	 */
-	queue_remove_all(client->services, NULL, NULL, unregister_service);
+	if (!device_is_bonded_for_gatt(client->device)) {
+		DBG("Device not bonded. Removing exported services.");
+		queue_remove_all(client->services, NULL, NULL,
+							unregister_service);
+	} else {
+		DBG("Device is bonded. Keeping exported services up.");
+		queue_foreach(client->all_notify_clients, clear_notify_id,
+									NULL);
+		queue_foreach(client->services, cancel_ops, client->gatt);
+	}
 
 	bt_gatt_client_unref(client->gatt);
 	client->gatt = NULL;
-- 
2.2.0.rc0.207.ga3a616c

