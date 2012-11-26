Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 06/11] network: Make use of D-Bus Properties interface
Date: Mon, 26 Nov 2012 15:09:17 +0200
Message-Id: <1353935362-8666-6-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1353935362-8666-1-git-send-email-luiz.dentz@gmail.com>
References: <1353935362-8666-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 profiles/network/connection.c | 133 +++++++++++++++++++++---------------------
 1 file changed, 68 insertions(+), 65 deletions(-)

diff --git a/profiles/network/connection.c b/profiles/network/connection.c
index 57451b9..d9961f8 100644
--- a/profiles/network/connection.c
+++ b/profiles/network/connection.c
@@ -113,19 +113,15 @@ static gboolean bnep_watchdog_cb(GIOChannel *chan, GIOCondition cond,
 				gpointer data)
 {
 	struct network_conn *nc = data;
-	gboolean connected = FALSE;
-	const char *property = "";
+	DBusConnection *conn = btd_get_dbus_connection();
 	const char *path = device_get_path(nc->peer->device);
 
-	emit_property_changed(path,
-				NETWORK_PEER_INTERFACE, "Connected",
-				DBUS_TYPE_BOOLEAN, &connected);
-	emit_property_changed(path,
-				NETWORK_PEER_INTERFACE, "Interface",
-				DBUS_TYPE_STRING, &property);
-	emit_property_changed(path,
-				NETWORK_PEER_INTERFACE, "UUID",
-				DBUS_TYPE_STRING, &property);
+	g_dbus_emit_property_changed(conn, path,
+					NETWORK_PEER_INTERFACE, "Connected");
+	g_dbus_emit_property_changed(conn, path,
+					NETWORK_PEER_INTERFACE, "Interface");
+	g_dbus_emit_property_changed(conn, path,
+					NETWORK_PEER_INTERFACE, "UUID");
 	device_remove_disconnect_watch(nc->peer->device, nc->dc_id);
 	nc->dc_id = 0;
 	if (nc->watch) {
@@ -200,9 +196,8 @@ static gboolean bnep_setup_cb(GIOChannel *chan, GIOCondition cond,
 	char pkt[BNEP_MTU];
 	ssize_t r;
 	int sk;
-	const char *pdev, *uuid;
-	gboolean connected;
 	const char *path;
+	DBusConnection *conn;
 
 	if (cond & G_IO_NVAL)
 		return FALSE;
@@ -265,24 +260,19 @@ static gboolean bnep_setup_cb(GIOChannel *chan, GIOCondition cond,
 	}
 
 	bnep_if_up(nc->dev);
-	pdev = nc->dev;
-	uuid = bnep_uuid(nc->id);
 
 	if (nc->cb)
-		nc->cb(nc->peer->device, 0, pdev, nc->cb_data);
+		nc->cb(nc->peer->device, 0, nc->dev, nc->cb_data);
 
+	conn = btd_get_dbus_connection();
 	path = device_get_path(nc->peer->device);
 
-	connected = TRUE;
-	emit_property_changed(path,
-				NETWORK_PEER_INTERFACE, "Connected",
-				DBUS_TYPE_BOOLEAN, &connected);
-	emit_property_changed(path,
-				NETWORK_PEER_INTERFACE, "Interface",
-				DBUS_TYPE_STRING, &pdev);
-	emit_property_changed(path,
-				NETWORK_PEER_INTERFACE, "UUID",
-				DBUS_TYPE_STRING, &uuid);
+	g_dbus_emit_property_changed(conn, path,
+					NETWORK_PEER_INTERFACE, "Connected");
+	g_dbus_emit_property_changed(conn, path,
+					NETWORK_PEER_INTERFACE, "Interface");
+	g_dbus_emit_property_changed(conn, path,
+					NETWORK_PEER_INTERFACE, "UUID");
 
 	nc->state = CONNECTED;
 	nc->dc_id = device_add_disconnect_watch(nc->peer->device, disconnect_cb,
@@ -530,54 +520,69 @@ static DBusMessage *local_disconnect(DBusConnection *conn,
 	return btd_error_not_connected(msg);
 }
 
-static DBusMessage *local_get_properties(DBusConnection *conn,
-					DBusMessage *msg, void *data)
+static gboolean
+network_property_get_connected(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
 {
 	struct network_peer *peer = data;
-	struct network_conn *nc = NULL;
-	DBusMessage *reply;
-	DBusMessageIter iter;
-	DBusMessageIter dict;
-	dbus_bool_t connected;
-	const char *property;
+	dbus_bool_t value = FALSE;
 	GSList *l;
 
-	reply = dbus_message_new_method_return(msg);
-	if (!reply)
-		return NULL;
+	for (l = peer->connections; l; l = l->next) {
+		struct network_conn *tmp = l->data;
+
+		if (tmp->state == CONNECTED) {
+			value = TRUE;
+			break;
+		}
+	}
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_BOOLEAN, &value);
 
-	dbus_message_iter_init_append(reply, &iter);
+	return TRUE;
+}
 
-	dbus_message_iter_open_container(&iter, DBUS_TYPE_ARRAY,
-			DBUS_DICT_ENTRY_BEGIN_CHAR_AS_STRING
-			DBUS_TYPE_STRING_AS_STRING DBUS_TYPE_VARIANT_AS_STRING
-			DBUS_DICT_ENTRY_END_CHAR_AS_STRING, &dict);
+static gboolean
+network_property_get_interface(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct network_peer *peer = data;
+	const char *value = "";
+	GSList *l;
 
-	/* Connected */
 	for (l = peer->connections; l; l = l->next) {
 		struct network_conn *tmp = l->data;
 
-		if (tmp->state != CONNECTED)
-			continue;
-
-		nc = tmp;
-		break;
+		if (tmp->state == CONNECTED) {
+			value = tmp->dev;
+			break;
+		}
 	}
 
-	connected = nc ? TRUE : FALSE;
-	dict_append_entry(&dict, "Connected", DBUS_TYPE_BOOLEAN, &connected);
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_STRING, &value);
 
-	/* Interface */
-	property = nc ? nc->dev : "";
-	dict_append_entry(&dict, "Interface", DBUS_TYPE_STRING, &property);
+	return TRUE;
+}
 
-	/* UUID */
-	property = nc ? bnep_uuid(nc->id) : "";
-	dict_append_entry(&dict, "UUID", DBUS_TYPE_STRING, &property);
+static gboolean network_property_get_uuid(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct network_peer *peer = data;
+	const char *value = "";
+	GSList *l;
+
+	for (l = peer->connections; l; l = l->next) {
+		struct network_conn *tmp = l->data;
+
+		if (tmp->state == CONNECTED) {
+			value = bnep_uuid(tmp->id);
+			break;
+		}
+	}
 
-	dbus_message_iter_close_container(&iter, &dict);
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_STRING, &value);
 
-	return reply;
+	return TRUE;
 }
 
 static void connection_free(void *data)
@@ -618,15 +623,13 @@ static const GDBusMethodTable connection_methods[] = {
 				local_connect) },
 	{ GDBUS_METHOD("Disconnect",
 			NULL, NULL, local_disconnect) },
-	{ GDBUS_METHOD("GetProperties",
-			NULL, GDBUS_ARGS({ "properties", "a{sv}" }),
-			local_get_properties) },
 	{ }
 };
 
-static const GDBusSignalTable connection_signals[] = {
-	{ GDBUS_SIGNAL("PropertyChanged",
-			GDBUS_ARGS({ "name", "s" }, { "value", "v" })) },
+static const GDBusPropertyTable connection_properties[] = {
+	{ "Connected", "b", network_property_get_connected },
+	{ "Interface", "s", network_property_get_interface },
+	{ "UUID", "s", network_property_get_uuid },
 	{ }
 };
 
@@ -659,7 +662,7 @@ static struct network_peer *create_peer(struct btd_device *device)
 	if (g_dbus_register_interface(btd_get_dbus_connection(), path,
 					NETWORK_PEER_INTERFACE,
 					connection_methods,
-					connection_signals, NULL,
+					NULL, connection_properties,
 					peer, path_unregister) == FALSE) {
 		error("D-Bus failed to register %s interface",
 			NETWORK_PEER_INTERFACE);
-- 
1.7.11.7

