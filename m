Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH 09/17] attrib: Simplify DBusConnection object handling
Date: Wed, 19 Sep 2012 12:22:11 +0200
Message-ID: <1348050139-27883-10-git-send-email-andrzej.kaczmarek@tieto.com>
In-Reply-To: <1348050139-27883-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1348050139-27883-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch removes redundant references and function parameters for
DBusConnection object and uses btd_get_dbus_connection() call wherever
such object is needed instead.

Pointer returned by this call is guaranteed to be valid for entire
bluetoothd lifetime and thus do not need to be refcounted.
---
 attrib/client.c | 41 ++++++++++++++++++-----------------------
 attrib/client.h |  3 +--
 src/device.c    |  4 +---
 3 files changed, 20 insertions(+), 28 deletions(-)

diff --git a/attrib/client.c b/attrib/client.c
index d5d40a1..2423fad 100644
--- a/attrib/client.c
+++ b/attrib/client.c
@@ -68,7 +68,6 @@ struct query {
 struct gatt_service {
 	struct btd_device *dev;
 	struct gatt_primary *prim;
-	DBusConnection *conn;
 	GAttrib *attrib;
 	guint attioid;
 	int psm;
@@ -204,7 +203,6 @@ static void gatt_service_free(struct gatt_service *gatt)
 	g_slist_free(gatt->offline_chars);
 	g_free(gatt->path);
 	btd_device_unref(gatt->dev);
-	dbus_connection_unref(gatt->conn);
 	g_free(gatt);
 }
 
@@ -296,7 +294,7 @@ static void watcher_exit(DBusConnection *conn, void *user_data)
 	DBG("%s watcher %s exited", gatt->path, watcher->name);
 
 	gatt->watchers = g_slist_remove(gatt->watchers, watcher);
-	g_dbus_remove_watch(gatt->conn, watcher->id);
+	g_dbus_remove_watch(btd_get_dbus_connection(), watcher->id);
 	remove_attio(gatt);
 }
 
@@ -317,7 +315,6 @@ static void update_watchers(gpointer data, gpointer user_data)
 {
 	struct watcher *w = data;
 	struct characteristic *chr = user_data;
-	DBusConnection *conn = w->gatt->conn;
 	DBusMessage *msg;
 
 	msg = dbus_message_new_method_call(w->name, w->path,
@@ -330,7 +327,7 @@ static void update_watchers(gpointer data, gpointer user_data)
 			&chr->value, chr->vlen, DBUS_TYPE_INVALID);
 
 	dbus_message_set_no_reply(msg, TRUE);
-	g_dbus_send_message(conn, msg);
+	g_dbus_send_message(btd_get_dbus_connection(), msg);
 }
 
 static void events_handler(const uint8_t *pdu, uint16_t len,
@@ -434,7 +431,7 @@ static void attio_disconnected(gpointer user_data)
 
 		reply = btd_error_failed(gatt->query->msg,
 					"ATT IO channel was disconnected");
-		g_dbus_send_message(gatt->conn, reply);
+		g_dbus_send_message(btd_get_dbus_connection(), reply);
 		dbus_message_unref(gatt->query->msg);
 	}
 
@@ -465,7 +462,8 @@ static DBusMessage *register_watcher(DBusConnection *conn,
 	watcher->name = g_strdup(sender);
 	watcher->gatt = gatt;
 	watcher->path = g_strdup(path);
-	watcher->id = g_dbus_add_disconnect_watch(conn, sender, watcher_exit,
+	watcher->id = g_dbus_add_disconnect_watch(btd_get_dbus_connection(),
+							sender, watcher_exit,
 							watcher, watcher_free);
 
 	if (gatt->attioid == 0)
@@ -502,13 +500,13 @@ static DBusMessage *unregister_watcher(DBusConnection *conn,
 
 	watcher = l->data;
 	gatt->watchers = g_slist_remove(gatt->watchers, watcher);
-	g_dbus_remove_watch(conn, watcher->id);
+	g_dbus_remove_watch(btd_get_dbus_connection(), watcher->id);
 	remove_attio(gatt);
 
 	return dbus_message_new_method_return(msg);
 }
 
-static DBusMessage *set_value(DBusConnection *conn, DBusMessage *msg,
+static DBusMessage *set_value(DBusMessage *msg,
 			DBusMessageIter *iter, struct characteristic *chr)
 {
 	struct gatt_service *gatt = chr->gatt;
@@ -582,7 +580,7 @@ static DBusMessage *set_property(DBusConnection *conn,
 	dbus_message_iter_recurse(&iter, &sub);
 
 	if (g_str_equal("Value", property))
-		return set_value(conn, msg, &sub, chr);
+		return set_value(msg, &sub, chr);
 
 	return btd_error_invalid_args(msg);
 }
@@ -636,13 +634,13 @@ static void store_characteristics(const bdaddr_t *sba, const bdaddr_t *dba,
 static void register_characteristic(gpointer data, gpointer user_data)
 {
 	struct characteristic *chr = data;
-	DBusConnection *conn = chr->gatt->conn;
 	const char *gatt_path = user_data;
 
 	chr->path = g_strdup_printf("%s/characteristic%04x", gatt_path,
 								chr->handle);
 
-	g_dbus_register_interface(conn, chr->path, CHAR_INTERFACE,
+	g_dbus_register_interface(btd_get_dbus_connection(),
+					chr->path, CHAR_INTERFACE,
 					char_methods, NULL, NULL, chr, NULL);
 
 	DBG("Registered: %s", chr->path);
@@ -1022,7 +1020,7 @@ fail:
 	dbus_message_unref(gatt->query->msg);
 	gatt->query->msg = NULL;
 
-	g_dbus_send_message(gatt->conn, reply);
+	g_dbus_send_message(btd_get_dbus_connection(), reply);
 	query_list_remove(gatt, current);
 	g_free(current);
 }
@@ -1121,8 +1119,7 @@ static const GDBusMethodTable prim_methods[] = {
 	{ }
 };
 
-static struct gatt_service *primary_register(DBusConnection *conn,
-						struct btd_device *device,
+static struct gatt_service *primary_register(struct btd_device *device,
 						struct gatt_primary *prim,
 						int psm)
 {
@@ -1135,11 +1132,10 @@ static struct gatt_service *primary_register(DBusConnection *conn,
 	gatt->dev = btd_device_ref(device);
 	gatt->prim = prim;
 	gatt->psm = psm;
-	gatt->conn = dbus_connection_ref(conn);
 	gatt->path = g_strdup_printf("%s/service%04x", device_path,
 								prim->range.start);
 
-	g_dbus_register_interface(gatt->conn, gatt->path,
+	g_dbus_register_interface(btd_get_dbus_connection(), gatt->path,
 					CHAR_INTERFACE, prim_methods,
 					NULL, NULL, gatt, NULL);
 	gatt->chars = load_characteristics(gatt, prim->range.start);
@@ -1148,8 +1144,7 @@ static struct gatt_service *primary_register(DBusConnection *conn,
 	return gatt;
 }
 
-GSList *attrib_client_register(DBusConnection *connection,
-					struct btd_device *device, int psm,
+GSList *attrib_client_register(struct btd_device *device, int psm,
 					GAttrib *attrib, GSList *primaries)
 {
 	GSList *l, *services;
@@ -1158,7 +1153,7 @@ GSList *attrib_client_register(DBusConnection *connection,
 		struct gatt_primary *prim = l->data;
 		struct gatt_service *gatt;
 
-		gatt = primary_register(connection, device, prim, psm);
+		gatt = primary_register(device, prim, psm);
 
 		DBG("Registered: %s", gatt->path);
 
@@ -1172,15 +1167,15 @@ GSList *attrib_client_register(DBusConnection *connection,
 
 static void primary_unregister(struct gatt_service *gatt)
 {
+	DBusConnection *conn = btd_get_dbus_connection();
 	GSList *l;
 
 	for (l = gatt->chars; l; l = l->next) {
 		struct characteristic *chr = l->data;
-		g_dbus_unregister_interface(gatt->conn, chr->path,
-							CHAR_INTERFACE);
+		g_dbus_unregister_interface(conn, chr->path, CHAR_INTERFACE);
 	}
 
-	g_dbus_unregister_interface(gatt->conn, gatt->path, CHAR_INTERFACE);
+	g_dbus_unregister_interface(conn, gatt->path, CHAR_INTERFACE);
 
 	remove_attio(gatt);
 }
diff --git a/attrib/client.h b/attrib/client.h
index 948f030..89f4f24 100644
--- a/attrib/client.h
+++ b/attrib/client.h
@@ -22,7 +22,6 @@
  *
  */
 
-GSList *attrib_client_register(DBusConnection *connection,
-					struct btd_device *device, int psm,
+GSList *attrib_client_register(struct btd_device *device, int psm,
 					GAttrib *attrib, GSList *primaries);
 void attrib_client_unregister(GSList *services);
diff --git a/src/device.c b/src/device.c
index 1b2c741..a6e10a5 100644
--- a/src/device.c
+++ b/src/device.c
@@ -2949,9 +2949,7 @@ void device_register_services(struct btd_device *device,
 						GSList *prim_list, int psm)
 {
 	device->primaries = g_slist_concat(device->primaries, prim_list);
-	device->services = attrib_client_register(btd_get_dbus_connection(),
-							device, psm, NULL,
-							prim_list);
+	device->services = attrib_client_register(device, psm, NULL, prim_list);
 }
 
 GSList *btd_device_get_primaries(struct btd_device *device)
-- 
1.7.11.3

