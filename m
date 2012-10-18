Return-Path: <cyrus@holtmann.org>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Lucas De Marchi <lucas.de.marchi@gmail.com>
Subject: [RFC 3/6] sap: Convert to DBus.Properties
Date: Thu, 18 Oct 2012 19:03:48 -0300
Message-Id: <1350597831-28380-4-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1350597831-28380-1-git-send-email-lucas.demarchi@profusion.mobi>
References: <1350597831-28380-1-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Lucas De Marchi <lucas.de.marchi@gmail.com>

---
 doc/sap-api.txt       | 12 -----------
 profiles/sap/server.c | 58 ++++++++++++++++-----------------------------------
 2 files changed, 18 insertions(+), 52 deletions(-)

diff --git a/doc/sap-api.txt b/doc/sap-api.txt
index b8b7253..92bdd9e 100644
--- a/doc/sap-api.txt
+++ b/doc/sap-api.txt
@@ -17,18 +17,6 @@ Methods		void Disconnect()
 
 			Possible errors: org.bluez.Error.Failed
 
-		dict GetProperties()
-
-			Return all properties for the interface. See the
-			properties section for available properties.
-
-			Possible Errors: org.bluez.Error.Failed
-
-Signals		PropertyChanged(string name, variant value)
-
-			This signal indicates a changed value of the given
-			property.
-
 Properties	boolean Connected [readonly]
 
 			Indicates if SAP client is connected to the server.
diff --git a/profiles/sap/server.c b/profiles/sap/server.c
index cbe00b9..530f994 100644
--- a/profiles/sap/server.c
+++ b/profiles/sap/server.c
@@ -618,13 +618,10 @@ static gboolean guard_timeout(gpointer data)
 
 static void sap_set_connected(struct sap_server *server)
 {
-	gboolean connected = TRUE;
-
-	emit_property_changed(server->path,
-				SAP_SERVER_INTERFACE, "Connected",
-				DBUS_TYPE_BOOLEAN, &connected);
-
 	server->conn->state = SAP_STATE_CONNECTED;
+
+	g_dbus_emit_property_changed(btd_get_dbus_connection(), server->path,
+					SAP_SERVER_INTERFACE, "Connected");
 }
 
 int sap_connect_rsp(void *sap_device, uint8_t status)
@@ -1136,7 +1133,6 @@ static void sap_io_destroy(void *data)
 {
 	struct sap_server *server = data;
 	struct sap_connection *conn = server->conn;
-	gboolean connected = FALSE;
 
 	DBG("conn %p", conn);
 
@@ -1146,10 +1142,10 @@ static void sap_io_destroy(void *data)
 	stop_guard_timer(server);
 
 	if (conn->state != SAP_STATE_CONNECT_IN_PROGRESS &&
-			conn->state != SAP_STATE_CONNECT_MODEM_BUSY)
-		emit_property_changed(server->path,
-					SAP_SERVER_INTERFACE, "Connected",
-					DBUS_TYPE_BOOLEAN, &connected);
+				conn->state != SAP_STATE_CONNECT_MODEM_BUSY)
+		g_dbus_emit_property_changed(btd_get_dbus_connection(),
+					server->path, SAP_SERVER_INTERFACE,
+					"Connected");
 
 	if (conn->state == SAP_STATE_CONNECT_IN_PROGRESS ||
 			conn->state == SAP_STATE_CONNECT_MODEM_BUSY ||
@@ -1291,50 +1287,31 @@ static DBusMessage *disconnect(DBusConnection *conn, DBusMessage *msg,
 	return dbus_message_new_method_return(msg);
 }
 
-static DBusMessage *get_properties(DBusConnection *c,
-				DBusMessage *msg, void *data)
+static gboolean server_property_get_connected(
+					const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
 {
 	struct sap_server *server = data;
 	struct sap_connection *conn = server->conn;
-	DBusMessage *reply;
-	DBusMessageIter iter;
-	DBusMessageIter dict;
 	dbus_bool_t connected;
 
 	if (!conn)
-		return message_failed(msg, "Server internal error.");
-
-	reply = dbus_message_new_method_return(msg);
-	if (!reply)
-		return NULL;
-
-	dbus_message_iter_init_append(reply, &iter);
-
-	dbus_message_iter_open_container(&iter, DBUS_TYPE_ARRAY,
-			DBUS_DICT_ENTRY_BEGIN_CHAR_AS_STRING
-			DBUS_TYPE_STRING_AS_STRING DBUS_TYPE_VARIANT_AS_STRING
-			DBUS_DICT_ENTRY_END_CHAR_AS_STRING, &dict);
+		return FALSE;
 
 	connected = (conn->state == SAP_STATE_CONNECTED ||
 				conn->state == SAP_STATE_GRACEFUL_DISCONNECT);
-	dict_append_entry(&dict, "Connected", DBUS_TYPE_BOOLEAN, &connected);
-
-	dbus_message_iter_close_container(&iter, &dict);
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_BOOLEAN, &connected);
 
-	return reply;
+	return TRUE;
 }
 
 static const GDBusMethodTable server_methods[] = {
-	{ GDBUS_METHOD("GetProperties",
-			NULL, GDBUS_ARGS({ "properties", "a{sv}" }),
-			get_properties) },
 	{ GDBUS_METHOD("Disconnect", NULL, NULL, disconnect) },
 	{ }
 };
 
-static const GDBusSignalTable server_signals[] = {
-	{ GDBUS_SIGNAL("PropertyChanged",
-			GDBUS_ARGS({ "name", "s" }, { "value", "v" })) },
+static const GDBusPropertyTable server_properties[] = {
+	{ "Connected", "b", server_property_get_connected },
 	{ }
 };
 
@@ -1411,8 +1388,9 @@ int sap_server_register(const char *path, const bdaddr_t *src)
 
 	if (!g_dbus_register_interface(btd_get_dbus_connection(),
 					server->path, SAP_SERVER_INTERFACE,
-					server_methods, server_signals, NULL,
-					server, destroy_sap_interface)) {
+					server_methods, NULL,
+					server_properties, server,
+					destroy_sap_interface)) {
 		error("D-Bus failed to register %s interface",
 							SAP_SERVER_INTERFACE);
 		goto server_err;
-- 
1.7.12.3

