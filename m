Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [RFC v0 03/15] network: Expose internal connection API
Date: Fri, 19 Oct 2012 17:39:20 +0200
Message-Id: <1350661172-18125-4-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1350661172-18125-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1350661172-18125-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

Separate the D-Bus code from the internal connection handling code,
exposing an internal API in case some internal codepath/plugin is
interested in using it.
---
 profiles/network/connection.c | 148 ++++++++++++++++++++++++++++--------------
 profiles/network/connection.h |   8 +++
 2 files changed, 108 insertions(+), 48 deletions(-)

diff --git a/profiles/network/connection.c b/profiles/network/connection.c
index afa8a6b..abcbee8 100644
--- a/profiles/network/connection.c
+++ b/profiles/network/connection.c
@@ -64,11 +64,13 @@ struct network_peer {
 };
 
 struct network_conn {
-	DBusMessage	*msg;
+	btd_connection_cb cb;
+	void		*cb_data;
 	char		dev[16];	/* Interface name */
 	uint16_t	id;		/* Role: Service Class Identifier */
 	conn_state	state;
 	GIOChannel	*io;
+	char		*owner;		/* Connection initiator D-Bus client */
 	guint		watch;		/* Disconnect watch */
 	guint		dc_id;
 	struct network_peer *peer;
@@ -141,10 +143,9 @@ static gboolean bnep_watchdog_cb(GIOChannel *chan, GIOCondition cond,
 	return FALSE;
 }
 
-static void cancel_connection(struct network_conn *nc, const char *err_msg)
+static void cancel_connection(struct network_conn *nc, int err)
 {
 	DBusConnection *conn = btd_get_dbus_connection();
-	DBusMessage *reply;
 
 	if (nc->timeout_source > 0) {
 		g_source_remove(nc->timeout_source);
@@ -156,14 +157,8 @@ static void cancel_connection(struct network_conn *nc, const char *err_msg)
 		nc->watch = 0;
 	}
 
-	if (nc->msg) {
-		if (err_msg) {
-			reply = btd_error_failed(nc->msg, err_msg);
-			g_dbus_send_message(conn, reply);
-		}
-		dbus_message_unref(nc->msg);
-		nc->msg = NULL;
-	}
+	if (nc->cb)
+		nc->cb(nc->peer->device, err, NULL, nc->cb_data);
 
 	g_io_channel_shutdown(nc->io, TRUE, NULL);
 	g_io_channel_unref(nc->io);
@@ -180,7 +175,12 @@ static void connection_destroy(DBusConnection *conn, void *user_data)
 		bnep_if_down(nc->dev);
 		bnep_kill_connection(device_get_address(nc->peer->device));
 	} else if (nc->io)
-		cancel_connection(nc, NULL);
+		cancel_connection(nc, -EIO);
+
+	if (nc->owner) {
+		g_free(nc->owner);
+		nc->owner = NULL;
+	}
 }
 
 static void disconnect_cb(struct btd_device *device, gboolean removal,
@@ -270,11 +270,8 @@ static gboolean bnep_setup_cb(GIOChannel *chan, GIOCondition cond,
 	pdev = nc->dev;
 	uuid = bnep_uuid(nc->id);
 
-	g_dbus_send_reply(btd_get_dbus_connection(), nc->msg,
-			DBUS_TYPE_STRING, &pdev,
-			DBUS_TYPE_INVALID);
-	dbus_message_unref(nc->msg);
-	nc->msg = NULL;
+	if (nc->cb)
+		nc->cb(nc->peer->device, 0, pdev, nc->cb_data);
 
 	path = device_get_path(nc->peer->device);
 
@@ -303,7 +300,7 @@ static gboolean bnep_setup_cb(GIOChannel *chan, GIOCondition cond,
 	return FALSE;
 
 failed:
-	cancel_connection(nc, "bnep setup failed");
+	cancel_connection(nc, -EIO);
 
 	return FALSE;
 }
@@ -349,7 +346,7 @@ static gboolean bnep_conn_req_to(gpointer user_data)
 			return TRUE;
 	}
 
-	cancel_connection(nc, "bnep setup failed");
+	cancel_connection(nc, -ETIMEDOUT);
 
 	return FALSE;
 }
@@ -393,32 +390,74 @@ static void connect_cb(GIOChannel *chan, GError *err, gpointer data)
 	return;
 
 failed:
-	cancel_connection(nc, err_msg);
+	cancel_connection(nc, -EIO);
+}
+
+static void local_connect_cb(struct btd_device *device, int err,
+						const char *pdev, void *data)
+{
+	DBusMessage *msg = data;
+	DBusMessage *reply;
+
+	if (err < 0) {
+		reply = btd_error_failed(msg, strerror(-err));
+		g_dbus_send_message(btd_get_dbus_connection(), reply);
+		dbus_message_unref(msg);
+		return;
+	}
+
+	g_dbus_send_reply(btd_get_dbus_connection(), msg,
+						DBUS_TYPE_STRING, &pdev,
+						DBUS_TYPE_INVALID);
+
+	dbus_message_unref(msg);
 }
 
-/* Connect and initiate BNEP session */
 static DBusMessage *local_connect(DBusConnection *conn,
 						DBusMessage *msg, void *data)
 {
 	struct network_peer *peer = data;
-	struct network_conn *nc;
 	const char *svc;
 	uint16_t id;
-	GError *err = NULL;
-	const bdaddr_t *src;
-	const bdaddr_t *dst;
+	int err;
 
 	if (dbus_message_get_args(msg, NULL, DBUS_TYPE_STRING, &svc,
 						DBUS_TYPE_INVALID) == FALSE)
 		return btd_error_invalid_args(msg);
 
 	id = bnep_service_id(svc);
+
+	err = connection_connect(peer->device, id, dbus_message_get_sender(msg),
+							local_connect_cb, msg);
+	if (err < 0)
+		return btd_error_failed(msg, strerror(-err));
+
+	dbus_message_ref(msg);
+
+	return NULL;
+}
+
+/* Connect and initiate BNEP session */
+int connection_connect(struct btd_device *device, uint16_t id,
+					const char *owner,
+					btd_connection_cb cb, void *data)
+{
+	struct network_peer *peer;
+	struct network_conn *nc;
+	GError *err = NULL;
+	const bdaddr_t *src;
+	const bdaddr_t *dst;
+
+	peer = find_peer(peers, device);
+	if (!peer)
+		return -ENOENT;
+
 	nc = find_connection(peer->connections, id);
 	if (!nc)
-		return btd_error_not_supported(msg);
+		return -ENOTSUP;
 
 	if (nc->state != DISCONNECTED)
-		return btd_error_already_connected(msg);
+		return -EALREADY;
 
 	src = adapter_get_address(device_get_adapter(peer->device));
 	dst = device_get_address(peer->device);
@@ -432,52 +471,65 @@ static DBusMessage *local_connect(DBusConnection *conn,
 				BT_IO_OPT_OMTU, BNEP_MTU,
 				BT_IO_OPT_IMTU, BNEP_MTU,
 				BT_IO_OPT_INVALID);
-	if (!nc->io) {
-		DBusMessage *reply;
-		error("%s", err->message);
-		reply = btd_error_failed(msg, err->message);
-		g_error_free(err);
-		return reply;
-	}
+	if (!nc->io)
+		return -EIO;
 
 	nc->state = CONNECTING;
-	nc->msg = dbus_message_ref(msg);
-	nc->watch = g_dbus_add_disconnect_watch(conn,
-						dbus_message_get_sender(msg),
-						connection_destroy,
+	nc->owner = g_strdup(owner);
+
+	if (owner)
+		nc->watch = g_dbus_add_disconnect_watch(
+						btd_get_dbus_connection(),
+						owner, connection_destroy,
 						nc, NULL);
 
-	return NULL;
+	return 0;
 }
 
-static DBusMessage *connection_cancel(DBusConnection *conn,
-						DBusMessage *msg, void *data)
+int connection_disconnect(struct btd_device *device, uint16_t id,
+							const char *caller)
 {
-	struct network_conn *nc = data;
-	const char *owner = dbus_message_get_sender(nc->msg);
-	const char *caller = dbus_message_get_sender(msg);
+	struct network_peer *peer;
+	struct network_conn *nc;
+
+	peer = find_peer(peers, device);
+	if (!peer)
+		return -ENOENT;
+
+	nc = find_connection(peer->connections, id);
+	if (!nc)
+		return -ENOTSUP;
+
+	if (nc->state == DISCONNECTED)
+		return 0;
 
-	if (!g_str_equal(owner, caller))
-		return btd_error_not_authorized(msg);
+	if (!g_str_equal(nc->owner, caller))
+		return -EPERM;
 
 	connection_destroy(NULL, nc);
 
-	return g_dbus_create_reply(msg, DBUS_TYPE_INVALID);
+	return 0;
 }
 
 static DBusMessage *local_disconnect(DBusConnection *conn,
 					DBusMessage *msg, void *data)
 {
 	struct network_peer *peer = data;
+	const char *caller = dbus_message_get_sender(msg);
 	GSList *l;
 
 	for (l = peer->connections; l; l = l->next) {
 		struct network_conn *nc = l->data;
+		int err;
 
 		if (nc->state == DISCONNECTED)
 			continue;
 
-		return connection_cancel(conn, msg, nc);
+		err = connection_disconnect(peer->device, nc->id, caller);
+		if (err < 0)
+			return btd_error_failed(msg, strerror(-err));
+
+		return g_dbus_create_reply(msg, DBUS_TYPE_INVALID);
 	}
 
 	return btd_error_not_connected(msg);
diff --git a/profiles/network/connection.h b/profiles/network/connection.h
index 50c0774..e67b0ec 100644
--- a/profiles/network/connection.h
+++ b/profiles/network/connection.h
@@ -21,5 +21,13 @@
  *
  */
 
+typedef void (*btd_connection_cb)(struct btd_device *device, int err,
+					const char *pdev, void *data);
+
 int connection_register(struct btd_device *device, uint16_t id);
 void connection_unregister(struct btd_device *device);
+int connection_connect(struct btd_device *device, uint16_t id,
+					const char *owner,
+					btd_connection_cb cb, void *data);
+int connection_disconnect(struct btd_device *device, uint16_t id,
+					const char *caller);
-- 
1.7.11.7

