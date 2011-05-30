Return-Path: <cyrus@holtmann.org>
From: Waldemar Rymarkiewicz <waldemar.rymarkiewicz@tieto.com>
To: Johan Hedberg <johan.hedberg@gmail.com>,
	<linux-bluetooth@vger.kernel.org>
CC: Waldemar Rymarkiewicz <waldemar.rymarkiewicz@tieto.com>
Subject: [PATCH v2 3/3] Coding style cleanup in sap server
Date: Mon, 30 May 2011 11:59:35 +0200
Message-ID: <1306749575-21119-3-git-send-email-waldemar.rymarkiewicz@tieto.com>
In-Reply-To: <1306749575-21119-1-git-send-email-waldemar.rymarkiewicz@tieto.com>
References: <1306749575-21119-1-git-send-email-waldemar.rymarkiewicz@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 sap/server.c |   21 ++++++++++-----------
 1 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/sap/server.c b/sap/server.c
index d166173..c268cec 100644
--- a/sap/server.c
+++ b/sap/server.c
@@ -1095,7 +1095,7 @@ static gboolean sap_io_cb(GIOChannel *io, GIOCondition cond, gpointer data)
 	}
 
 	gstatus = g_io_channel_read_chars(io, buf, sizeof(buf) - 1,
-				&bytes_read, &gerr);
+							&bytes_read, &gerr);
 	if (gstatus != G_IO_STATUS_NORMAL) {
 		if (gerr)
 			g_error_free(gerr);
@@ -1212,10 +1212,9 @@ static void connect_confirm_cb(GIOChannel *io, gpointer data)
 	conn->io = g_io_channel_ref(io);
 	conn->state = SAP_STATE_DISCONNECTED;
 
-	bt_io_get(io, BT_IO_RFCOMM, &gerr,
-			BT_IO_OPT_SOURCE_BDADDR, &src,
-			BT_IO_OPT_DEST_BDADDR, &dst,
-			BT_IO_OPT_INVALID);
+	bt_io_get(io, BT_IO_RFCOMM, &gerr, BT_IO_OPT_SOURCE_BDADDR, &src,
+			BT_IO_OPT_DEST_BDADDR, &dst, BT_IO_OPT_INVALID);
+
 	if (gerr) {
 		error("%s", gerr->message);
 		g_error_free(gerr);
@@ -1239,8 +1238,8 @@ static void connect_confirm_cb(GIOChannel *io, gpointer data)
 static inline DBusMessage *message_failed(DBusMessage *msg,
 					const char *description)
 {
-	return g_dbus_create_error(msg, ERROR_INTERFACE ".Failed",
-				"%s", description);
+	return g_dbus_create_error(msg, ERROR_INTERFACE ".Failed", "%s",
+								description);
 }
 
 static DBusMessage *disconnect(DBusConnection *conn, DBusMessage *msg,
@@ -1258,7 +1257,7 @@ static DBusMessage *disconnect(DBusConnection *conn, DBusMessage *msg,
 
 	if (disconnect_req(server->conn, SAP_DISCONNECTION_TYPE_GRACEFUL) < 0)
 		return g_dbus_create_error(msg, ERROR_INTERFACE	".Failed",
-				"There is no active connection");
+					"There is no active connection");
 
 	return dbus_message_new_method_return(msg);
 }
@@ -1287,7 +1286,7 @@ static DBusMessage *get_properties(DBusConnection *c,
 			DBUS_DICT_ENTRY_END_CHAR_AS_STRING, &dict);
 
 	connected = (conn->state == SAP_STATE_CONNECTED ||
-			conn->state == SAP_STATE_GRACEFUL_DISCONNECT);
+				conn->state == SAP_STATE_GRACEFUL_DISCONNECT);
 	dict_append_entry(&dict, "Connected", DBUS_TYPE_BOOLEAN, &connected);
 
 	dbus_message_iter_close_container(&iter, &dict);
@@ -1380,8 +1379,8 @@ int sap_server_register(const char *path, bdaddr_t *src)
 	server->conn = NULL;
 
 	if (!g_dbus_register_interface(connection, path, SAP_SERVER_INTERFACE,
-				server_methods, server_signals, NULL,
-				server, destroy_sap_interface)) {
+			server_methods, server_signals, NULL, server,
+			destroy_sap_interface)) {
 		error("D-Bus failed to register %s interface",
 							SAP_SERVER_INTERFACE);
 		goto server_err;
-- 
1.7.4.1

