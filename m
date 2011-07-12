Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ 09/11] Register ATT connection callback based on watchers
Date: Tue, 12 Jul 2011 17:28:39 -0300
Message-Id: <1310502521-462-10-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1310502521-462-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1310502521-462-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

In the Generic Attribute API, the ATT connection should be requested
on demand. In the case of watchers, the connection doesn't need to be
stay up if there isn't watcher registered.
---
 attrib/client.c |   55 ++++++++++++++++++++++++++++++++-----------------------
 1 files changed, 32 insertions(+), 23 deletions(-)

diff --git a/attrib/client.c b/attrib/client.c
index 5177524..962cdb7 100644
--- a/attrib/client.c
+++ b/attrib/client.c
@@ -285,6 +285,25 @@ static void events_handler(const uint8_t *pdu, uint16_t len,
 	}
 }
 
+static void attio_connected(GAttrib *attrib, gpointer user_data)
+{
+	struct gatt_service *gatt = user_data;
+
+	gatt->attrib = attrib;
+
+	g_attrib_register(gatt->attrib, ATT_OP_HANDLE_NOTIFY,
+					events_handler, gatt, NULL);
+	g_attrib_register(gatt->attrib, ATT_OP_HANDLE_IND,
+					events_handler, gatt, NULL);
+}
+
+static void attio_disconnected(gpointer user_data)
+{
+	struct gatt_service *gatt = user_data;
+
+	gatt->attrib = NULL;
+}
+
 static DBusMessage *register_watcher(DBusConnection *conn,
 						DBusMessage *msg, void *data)
 {
@@ -304,6 +323,12 @@ static DBusMessage *register_watcher(DBusConnection *conn,
 	watcher->id = g_dbus_add_disconnect_watch(conn, sender, watcher_exit,
 							watcher, watcher_free);
 
+	if (gatt->attioid == 0)
+		gatt->attioid = btd_device_add_attio_callback(gatt->dev,
+							attio_connected,
+							attio_disconnected,
+							gatt);
+
 	gatt->watchers = g_slist_append(gatt->watchers, watcher);
 
 	return dbus_message_new_method_return(msg);
@@ -335,6 +360,11 @@ static DBusMessage *unregister_watcher(DBusConnection *conn,
 	gatt->watchers = g_slist_remove(gatt->watchers, watcher);
 	watcher_free(watcher);
 
+	if (gatt->watchers == NULL && gatt->attioid) {
+		btd_device_remove_attio_callback(gatt->dev, gatt->attioid);
+		gatt->attioid = 0;
+	}
+
 	return dbus_message_new_method_return(msg);
 }
 
@@ -861,25 +891,6 @@ static GDBusMethodTable prim_methods[] = {
 	{ }
 };
 
-static void attio_connected(GAttrib *attrib, gpointer user_data)
-{
-	struct gatt_service *gatt = user_data;
-
-	gatt->attrib = attrib;
-
-	g_attrib_register(gatt->attrib, ATT_OP_HANDLE_NOTIFY,
-					events_handler, gatt, NULL);
-	g_attrib_register(gatt->attrib, ATT_OP_HANDLE_IND,
-					events_handler, gatt, NULL);
-}
-
-static void attio_disconnected(gpointer user_data)
-{
-	struct gatt_service *gatt = user_data;
-
-	gatt->attrib = NULL;
-}
-
 static struct gatt_service *primary_register(DBusConnection *conn,
 						struct btd_device *device,
 						struct att_primary *prim,
@@ -898,9 +909,6 @@ static struct gatt_service *primary_register(DBusConnection *conn,
 	gatt->path = g_strdup_printf("%s/service%04x", device_path,
 								prim->start);
 
-	gatt->attioid = btd_device_add_attio_callback(device, attio_connected,
-						attio_disconnected, gatt);
-
 	g_dbus_register_interface(gatt->conn, gatt->path,
 					CHAR_INTERFACE, prim_methods,
 					NULL, NULL, gatt, NULL);
@@ -936,7 +944,8 @@ static void primary_unregister(struct gatt_service *gatt)
 {
 	GSList *l;
 
-	btd_device_remove_attio_callback(gatt->dev, gatt->attioid);
+	if (gatt->attioid)
+		btd_device_remove_attio_callback(gatt->dev, gatt->attioid);
 
 	for (l = gatt->chars; l; l = l->next) {
 		struct characteristic *chr = l->data;
-- 
1.7.6

