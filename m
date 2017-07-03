Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 07/10] gatt: Add implementation of AcquireNotify
Date: Mon,  3 Jul 2017 15:11:45 +0300
Message-Id: <20170703121148.24299-8-luiz.dentz@gmail.com>
In-Reply-To: <20170703121148.24299-1-luiz.dentz@gmail.com>
References: <20170703121148.24299-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This implements AcquireNotify creating a pipe and passing the read fd
to the application requesting it, at same time subscribe for
notifications:

bluetoothd[7279]: src/gatt-client.c:notify_client_ref() owner :1.461
bluetoothd[7279]: src/gatt-client.c:characteristic_create_pipe() AcquireNotify: sender :1.461 io 0x8a60540
---
 src/gatt-client.c | 170 +++++++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 155 insertions(+), 15 deletions(-)

diff --git a/src/gatt-client.c b/src/gatt-client.c
index 12bdbdc..6bff87b 100644
--- a/src/gatt-client.c
+++ b/src/gatt-client.c
@@ -89,6 +89,13 @@ struct async_dbus_op {
 	async_dbus_op_complete_t complete;
 };
 
+struct pipe_io {
+	DBusMessage *msg;
+	struct io *io;
+	void (*destroy)(void *data);
+	void *data;
+};
+
 struct characteristic {
 	struct service *service;
 	struct gatt_db_attribute *attr;
@@ -101,8 +108,8 @@ struct characteristic {
 	char *path;
 
 	unsigned int ready_id;
-	DBusMessage *acquire_write;
-	struct io *write_io;
+	struct pipe_io *write_io;
+	struct pipe_io *notify_io;
 
 	struct async_dbus_op *read_op;
 	struct async_dbus_op *write_op;
@@ -1031,16 +1038,31 @@ static bool chrc_pipe_read(struct io *io, void *user_data)
 	return true;
 }
 
+static void pipe_io_destroy(struct pipe_io *io)
+{
+	if (io->destroy)
+		io->destroy(io->data);
+
+	if (io->msg)
+		dbus_message_unref(io->msg);
+
+	io_destroy(io->io);
+	free(io);
+}
+
 static void characteristic_destroy_pipe(struct characteristic *chrc,
 							struct io *io)
 {
-	if (io == chrc->write_io) {
-		io_destroy(chrc->write_io);
+	if (chrc->write_io && io == chrc->write_io->io) {
+		pipe_io_destroy(chrc->write_io);
 		chrc->write_io = NULL;
 		g_dbus_emit_property_changed(btd_get_dbus_connection(),
 						chrc->path,
 						GATT_CHARACTERISTIC_IFACE,
 						"WriteLocked");
+	} else if (chrc->notify_io) {
+		pipe_io_destroy(chrc->notify_io);
+		chrc->notify_io = NULL;
 	}
 }
 
@@ -1097,12 +1119,13 @@ static DBusMessage *characteristic_create_pipe(struct characteristic *chrc,
 	close(pipefd[dir]);
 
 	if (dir) {
-		chrc->write_io = io;
+		chrc->write_io->io = io;
 		g_dbus_emit_property_changed(btd_get_dbus_connection(),
 						chrc->path,
 						GATT_CHARACTERISTIC_IFACE,
 						"WriteLocked");
-	}
+	} else
+		chrc->notify_io->io = io;
 
 	DBG("%s: sender %s io %p", dbus_message_get_member(msg),
 					dbus_message_get_sender(msg), io);
@@ -1122,13 +1145,22 @@ static void characteristic_ready(bool success, uint8_t ecode, void *user_data)
 
 	chrc->ready_id = 0;
 
-	if (chrc->acquire_write) {
-		reply = characteristic_create_pipe(chrc, chrc->acquire_write);
+	if (chrc->write_io->msg) {
+		reply = characteristic_create_pipe(chrc, chrc->write_io->msg);
 
 		g_dbus_send_message(btd_get_dbus_connection(), reply);
 
-		dbus_message_unref(chrc->acquire_write);
-		chrc->acquire_write = NULL;
+		dbus_message_unref(chrc->write_io->msg);
+		chrc->write_io->msg = NULL;
+	}
+
+	if (chrc->notify_io->msg) {
+		reply = characteristic_create_pipe(chrc, chrc->notify_io->msg);
+
+		g_dbus_send_message(btd_get_dbus_connection(), reply);
+
+		dbus_message_unref(chrc->notify_io->msg);
+		chrc->notify_io->msg = NULL;
 	}
 }
 
@@ -1141,7 +1173,7 @@ static DBusMessage *characteristic_acquire_write(DBusConnection *conn,
 	if (!gatt)
 		return btd_error_failed(msg, "Not connected");
 
-	if (chrc->write_io || chrc->acquire_write)
+	if (chrc->write_io)
 		return btd_error_failed(msg, strerror(EBUSY));
 
 	if (chrc->write_op)
@@ -1150,13 +1182,15 @@ static DBusMessage *characteristic_acquire_write(DBusConnection *conn,
 	if (!(chrc->props & BT_GATT_CHRC_PROP_WRITE_WITHOUT_RESP))
 		return btd_error_not_supported(msg);
 
+	chrc->write_io = new0(struct pipe_io, 1);
+
 	if (!bt_gatt_client_is_ready(gatt)) {
 		DBG("GATT not ready, wait until it becomes read");
 		if (!chrc->ready_id)
 			chrc->ready_id = bt_gatt_client_ready_register(gatt,
 							characteristic_ready,
 							chrc, NULL);
-		chrc->acquire_write = dbus_message_ref(msg);
+		chrc->write_io->msg = dbus_message_ref(msg);
 		return NULL;
 	}
 
@@ -1329,6 +1363,98 @@ static void register_notify_cb(uint16_t att_ecode, void *user_data)
 	create_notify_reply(op, true, 0);
 }
 
+static void notify_io_cb(uint16_t value_handle, const uint8_t *value,
+					uint16_t length, void *user_data)
+{
+	struct iovec iov;
+	struct notify_client *client = user_data;
+	struct characteristic *chrc = client->chrc;
+	int err;
+
+	/* Drop notification if the pipe is not ready */
+	if (!chrc->notify_io->io)
+		return;
+
+	iov.iov_base = (void *) value;
+	iov.iov_len = length;
+
+	err = io_send(chrc->notify_io->io, &iov, 1);
+	if (err < 0)
+		error("io_send: %s", strerror(-err));
+}
+
+static void register_notify_io_cb(uint16_t att_ecode, void *user_data)
+{
+	struct notify_client *client = user_data;
+	struct characteristic *chrc = client->chrc;
+
+	if (!att_ecode)
+		return;
+
+	queue_remove(chrc->notify_clients, client);
+	notify_client_free(client);
+
+	pipe_io_destroy(chrc->notify_io);
+	chrc->notify_io = NULL;
+}
+
+static void notify_io_destroy(void *data)
+{
+	struct notify_client *client = data;
+
+	queue_remove(client->chrc->notify_clients, client);
+	notify_client_unref(client);
+}
+
+static DBusMessage *characteristic_acquire_notify(DBusConnection *conn,
+					DBusMessage *msg, void *user_data)
+{
+	struct characteristic *chrc = user_data;
+	struct bt_gatt_client *gatt = chrc->service->client->gatt;
+	const char *sender = dbus_message_get_sender(msg);
+	struct notify_client *client;
+
+	if (!gatt)
+		return btd_error_failed(msg, "Not connected");
+
+	/* Each client can only have one active notify session. */
+	if (chrc->notify_io || !queue_isempty(chrc->notify_clients))
+		return btd_error_failed(msg, strerror(EBUSY));
+
+	if (!(chrc->props & BT_GATT_CHRC_PROP_NOTIFY ||
+				chrc->props & BT_GATT_CHRC_PROP_INDICATE))
+		return btd_error_not_supported(msg);
+
+	client = notify_client_create(chrc, sender);
+	if (!client)
+		return btd_error_failed(msg, "Failed allocate notify session");
+
+	client->notify_id = bt_gatt_client_register_notify(gatt,
+						chrc->value_handle,
+						register_notify_io_cb,
+						notify_io_cb,
+						client, NULL);
+	if (!client->notify_id)
+		return btd_error_failed(msg, "Failed to subscribe");
+
+	queue_push_tail(chrc->notify_clients, client);
+
+	chrc->notify_io = new0(struct pipe_io, 1);
+	chrc->notify_io->data = client;
+	chrc->notify_io->destroy = notify_io_destroy;
+
+	if (!bt_gatt_client_is_ready(gatt)) {
+		if (!chrc->ready_id)
+			chrc->ready_id = bt_gatt_client_ready_register(gatt,
+							characteristic_ready,
+							chrc, NULL);
+		chrc->notify_io->msg = dbus_message_ref(msg);
+		return NULL;
+	}
+
+	return characteristic_create_pipe(chrc, msg);
+}
+
 static DBusMessage *characteristic_start_notify(DBusConnection *conn,
 					DBusMessage *msg, void *user_data)
 {
@@ -1338,6 +1464,9 @@ static DBusMessage *characteristic_start_notify(DBusConnection *conn,
 	struct async_dbus_op *op;
 	struct notify_client *client;
 
+	if (chrc->notify_io)
+		return btd_error_failed(msg, strerror(EBUSY));
+
 	if (!(chrc->props & BT_GATT_CHRC_PROP_NOTIFY ||
 				chrc->props & BT_GATT_CHRC_PROP_INDICATE))
 		return btd_error_not_supported(msg);
@@ -1410,6 +1539,12 @@ static DBusMessage *characteristic_stop_notify(DBusConnection *conn,
 	if (!client)
 		return btd_error_failed(msg, "No notify session started");
 
+	if (chrc->notify_io) {
+		pipe_io_destroy(chrc->notify_io);
+		chrc->notify_io = NULL;
+		return dbus_message_new_method_return(msg);
+	}
+
 	queue_remove(chrc->service->client->all_notify_clients, client);
 	bt_gatt_client_unregister_notify(gatt, client->notify_id);
 	update_notifying(chrc);
@@ -1444,6 +1579,10 @@ static const GDBusMethodTable characteristic_methods[] = {
 					GDBUS_ARGS({ "fd", "h" },
 						{ "mtu", "q" }),
 					characteristic_acquire_write) },
+	{ GDBUS_EXPERIMENTAL_ASYNC_METHOD("AcquireNotify", NULL,
+					GDBUS_ARGS({ "fd", "h" },
+						{ "mtu", "q" }),
+					characteristic_acquire_notify) },
 	{ GDBUS_ASYNC_METHOD("StartNotify", NULL, NULL,
 					characteristic_start_notify) },
 	{ GDBUS_METHOD("StopNotify", NULL, NULL,
@@ -1459,10 +1598,11 @@ static void characteristic_free(void *data)
 	queue_destroy(chrc->descs, NULL);
 	queue_destroy(chrc->notify_clients, NULL);
 
-	io_destroy(chrc->write_io);
+	if (chrc->write_io)
+		pipe_io_destroy(chrc->write_io);
 
-	if (chrc->acquire_write)
-		dbus_message_unref(chrc->acquire_write);
+	if (chrc->notify_io)
+		pipe_io_destroy(chrc->notify_io);
 
 	g_free(chrc->path);
 	free(chrc);
-- 
2.9.4

