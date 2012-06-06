Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 13/17] SAP: Fix server when multiple adapters are present
Date: Wed, 6 Jun 2012 15:19:23 +0200
Message-ID: <1338988767-19467-13-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1338988767-19467-1-git-send-email-szymon.janc@tieto.com>
References: <1338988767-19467-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Remove static pointer used to keep track of registered server and
just pass allocated server as user data to io and DBus callbacks.

It is up to backend now if multiple adapters are supported or if
multiple connections are possible (one per adapter or one in total).
---
 sap/server.c |   64 +++++++++++++++++++++++-----------------------------------
 sap/server.h |    2 +-
 2 files changed, 26 insertions(+), 40 deletions(-)

diff --git a/sap/server.c b/sap/server.c
index 95f621b..ee2624d 100644
--- a/sap/server.c
+++ b/sap/server.c
@@ -80,7 +80,6 @@ struct sap_server {
 };
 
 static DBusConnection *connection;
-static struct sap_server *sap_server;
 
 static void start_guard_timer(struct sap_server *server, guint interval);
 static void stop_guard_timer(struct sap_server *server);
@@ -1343,15 +1342,23 @@ static const GDBusSignalTable server_signals[] = {
 	{ }
 };
 
-static void server_free(struct sap_server *server)
+static void server_remove(struct sap_server *server)
 {
 	if (!server)
 		return;
 
 	sap_server_remove_conn(server);
+
+	remove_record_from_server(server->record_id);
+
+	if (server->listen_io) {
+		g_io_channel_shutdown(server->listen_io, TRUE, NULL);
+		g_io_channel_unref(server->listen_io);
+		server->listen_io = NULL;
+	}
+
 	g_free(server->path);
 	g_free(server);
-	server = NULL;
 }
 
 static void destroy_sap_interface(void *data)
@@ -1361,7 +1368,7 @@ static void destroy_sap_interface(void *data)
 	DBG("Unregistered interface %s on path %s", SAP_SERVER_INTERFACE,
 								server->path);
 
-	server_free(server);
+	server_remove(server);
 }
 
 int sap_server_register(const char *path, bdaddr_t *src)
@@ -1369,20 +1376,13 @@ int sap_server_register(const char *path, bdaddr_t *src)
 	sdp_record_t *record = NULL;
 	GError *gerr = NULL;
 	GIOChannel *io;
+	struct sap_server *server;
 
 	if (sap_init() < 0) {
 		error("Sap driver initialization failed.");
 		return -1;
 	}
 
-	sap_server = g_try_new0(struct sap_server, 1);
-	if (!sap_server) {
-		sap_exit();
-		return -ENOMEM;
-	}
-
-	sap_server->path = g_strdup(path);
-
 	record = create_sap_record(SAP_SERVER_CHANNEL);
 	if (!record) {
 		error("Creating SAP SDP record failed.");
@@ -1395,9 +1395,11 @@ int sap_server_register(const char *path, bdaddr_t *src)
 		goto sdp_err;
 	}
 
-	sap_server->record_id = record->handle;
+	server = g_new0(struct sap_server, 1);
+	server->path = g_strdup(path);
+	server->record_id = record->handle;
 
-	io = bt_io_listen(BT_IO_RFCOMM, NULL, connect_confirm_cb, sap_server,
+	io = bt_io_listen(BT_IO_RFCOMM, NULL, connect_confirm_cb, server,
 			NULL, &gerr,
 			BT_IO_OPT_SOURCE_BDADDR, src,
 			BT_IO_OPT_CHANNEL, SAP_SERVER_CHANNEL,
@@ -1409,51 +1411,35 @@ int sap_server_register(const char *path, bdaddr_t *src)
 		g_error_free(gerr);
 		goto server_err;
 	}
+	server->listen_io = io;
 
-	DBG("Listen socket 0x%02x", g_io_channel_unix_get_fd(io));
-
-	sap_server->listen_io = io;
-	sap_server->conn = NULL;
-
-	if (!g_dbus_register_interface(connection, path, SAP_SERVER_INTERFACE,
+	if (!g_dbus_register_interface(connection, server->path,
+					SAP_SERVER_INTERFACE,
 					server_methods, server_signals, NULL,
-					sap_server, destroy_sap_interface)) {
+					server, destroy_sap_interface)) {
 		error("D-Bus failed to register %s interface",
 							SAP_SERVER_INTERFACE);
 		goto server_err;
 	}
 
+	DBG("server %p, listen socket 0x%02x", server,
+						g_io_channel_unix_get_fd(io));
+
 	return 0;
 
 server_err:
-	remove_record_from_server(sap_server->record_id);
+	server_remove(server);
 sdp_err:
-	server_free(sap_server);
 	sap_exit();
 
 	return -1;
 }
 
-int sap_server_unregister(const char *path)
+void sap_server_unregister(const char *path)
 {
-	if (!sap_server)
-		return -EINVAL;
-
-	remove_record_from_server(sap_server->record_id);
-
-	sap_server_remove_conn(sap_server);
-
-	if (sap_server->listen_io) {
-		g_io_channel_shutdown(sap_server->listen_io, TRUE, NULL);
-		g_io_channel_unref(sap_server->listen_io);
-		sap_server->listen_io = NULL;
-	}
-
 	g_dbus_unregister_interface(connection, path, SAP_SERVER_INTERFACE);
 
 	sap_exit();
-
-	return 0;
 }
 
 int sap_server_init(DBusConnection *conn)
diff --git a/sap/server.h b/sap/server.h
index ef2b7b8..6d2f5e9 100644
--- a/sap/server.h
+++ b/sap/server.h
@@ -23,4 +23,4 @@
 int sap_server_init(DBusConnection *conn);
 void sap_server_exit(void);
 int sap_server_register(const char *path, bdaddr_t *src);
-int sap_server_unregister(const char *path);
+void sap_server_unregister(const char *path);
-- 
on behalf of ST-Ericsson

