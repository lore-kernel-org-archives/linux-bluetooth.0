Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 09/17] SAP: Rename server variable to sap_server
Date: Wed, 6 Jun 2012 15:19:19 +0200
Message-ID: <1338988767-19467-9-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1338988767-19467-1-git-send-email-szymon.janc@tieto.com>
References: <1338988767-19467-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is to avoid shadowing by local functions variables.
---
 sap/server.c |   48 ++++++++++++++++++++++++------------------------
 1 file changed, 24 insertions(+), 24 deletions(-)

diff --git a/sap/server.c b/sap/server.c
index bc466d0..a96c3fa 100644
--- a/sap/server.c
+++ b/sap/server.c
@@ -80,7 +80,7 @@ struct sap_server {
 };
 
 static DBusConnection *connection;
-static struct sap_server *server;
+static struct sap_server *sap_server;
 
 static void start_guard_timer(struct sap_connection *conn, guint interval);
 static void stop_guard_timer(struct sap_connection *conn);
@@ -588,7 +588,7 @@ static void sap_set_connected(struct sap_connection *conn)
 {
 	gboolean connected = TRUE;
 
-	emit_property_changed(connection, server->path,
+	emit_property_changed(connection, sap_server->path,
 					SAP_SERVER_INTERFACE,
 		"Connected", DBUS_TYPE_BOOLEAN, &connected);
 
@@ -1064,7 +1064,7 @@ static void sap_conn_remove(struct sap_connection *conn)
 
 	conn->io = NULL;
 	g_free(conn);
-	server->conn = NULL;
+	sap_server->conn = NULL;
 }
 
 static gboolean sap_io_cb(GIOChannel *io, GIOCondition cond, gpointer data)
@@ -1122,7 +1122,7 @@ static void sap_io_destroy(void *data)
 
 	if (conn->state != SAP_STATE_CONNECT_IN_PROGRESS &&
 			conn->state != SAP_STATE_CONNECT_MODEM_BUSY)
-		emit_property_changed(connection, server->path,
+		emit_property_changed(connection, sap_server->path,
 					SAP_SERVER_INTERFACE, "Connected",
 					DBUS_TYPE_BOOLEAN, &connected);
 
@@ -1181,7 +1181,7 @@ static void connect_auth_cb(DBusError *derr, void *data)
 
 static void connect_confirm_cb(GIOChannel *io, gpointer data)
 {
-	struct sap_connection *conn = server->conn;
+	struct sap_connection *conn = sap_server->conn;
 	GError *gerr = NULL;
 	bdaddr_t src, dst;
 	char dstaddr[18];
@@ -1208,7 +1208,7 @@ static void connect_confirm_cb(GIOChannel *io, gpointer data)
 	g_io_channel_set_encoding(io, NULL, NULL);
 	g_io_channel_set_buffered(io, FALSE);
 
-	server->conn = conn;
+	sap_server->conn = conn;
 	conn->io = g_io_channel_ref(io);
 	conn->state = SAP_STATE_DISCONNECTED;
 
@@ -1341,13 +1341,13 @@ int sap_server_register(const char *path, bdaddr_t *src)
 		return -1;
 	}
 
-	server = g_try_new0(struct sap_server, 1);
-	if (!server) {
+	sap_server = g_try_new0(struct sap_server, 1);
+	if (!sap_server) {
 		sap_exit();
 		return -ENOMEM;
 	}
 
-	server->path = g_strdup(path);
+	sap_server->path = g_strdup(path);
 
 	record = create_sap_record(SAP_SERVER_CHANNEL);
 	if (!record) {
@@ -1361,9 +1361,9 @@ int sap_server_register(const char *path, bdaddr_t *src)
 		goto sdp_err;
 	}
 
-	server->record_id = record->handle;
+	sap_server->record_id = record->handle;
 
-	io = bt_io_listen(BT_IO_RFCOMM, NULL, connect_confirm_cb, server,
+	io = bt_io_listen(BT_IO_RFCOMM, NULL, connect_confirm_cb, sap_server,
 			NULL, &gerr,
 			BT_IO_OPT_SOURCE_BDADDR, src,
 			BT_IO_OPT_CHANNEL, SAP_SERVER_CHANNEL,
@@ -1378,12 +1378,12 @@ int sap_server_register(const char *path, bdaddr_t *src)
 
 	DBG("Listen socket 0x%02x", g_io_channel_unix_get_fd(io));
 
-	server->listen_io = io;
-	server->conn = NULL;
+	sap_server->listen_io = io;
+	sap_server->conn = NULL;
 
 	if (!g_dbus_register_interface(connection, path, SAP_SERVER_INTERFACE,
 					server_methods, server_signals, NULL,
-					server, destroy_sap_interface)) {
+					sap_server, destroy_sap_interface)) {
 		error("D-Bus failed to register %s interface",
 							SAP_SERVER_INTERFACE);
 		goto server_err;
@@ -1392,9 +1392,9 @@ int sap_server_register(const char *path, bdaddr_t *src)
 	return 0;
 
 server_err:
-	remove_record_from_server(server->record_id);
+	remove_record_from_server(sap_server->record_id);
 sdp_err:
-	server_free(server);
+	server_free(sap_server);
 	sap_exit();
 
 	return -1;
@@ -1402,18 +1402,18 @@ sdp_err:
 
 int sap_server_unregister(const char *path)
 {
-	if (!server)
+	if (!sap_server)
 		return -EINVAL;
 
-	remove_record_from_server(server->record_id);
+	remove_record_from_server(sap_server->record_id);
 
-	if (server->conn)
-		sap_conn_remove(server->conn);
+	if (sap_server->conn)
+		sap_conn_remove(sap_server->conn);
 
-	if (server->listen_io) {
-		g_io_channel_shutdown(server->listen_io, TRUE, NULL);
-		g_io_channel_unref(server->listen_io);
-		server->listen_io = NULL;
+	if (sap_server->listen_io) {
+		g_io_channel_shutdown(sap_server->listen_io, TRUE, NULL);
+		g_io_channel_unref(sap_server->listen_io);
+		sap_server->listen_io = NULL;
 	}
 
 	g_dbus_unregister_interface(connection, path, SAP_SERVER_INTERFACE);
-- 
on behalf of ST-Ericsson

