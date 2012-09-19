Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH 15/17] thermometer: Simplify DBusConnection object handling
Date: Wed, 19 Sep 2012 12:22:17 +0200
Message-ID: <1348050139-27883-16-git-send-email-andrzej.kaczmarek@tieto.com>
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
 profiles/thermometer/main.c        | 17 +----------------
 profiles/thermometer/manager.c     | 11 ++---------
 profiles/thermometer/manager.h     |  2 +-
 profiles/thermometer/thermometer.c | 22 +++++++++-------------
 profiles/thermometer/thermometer.h |  3 +--
 5 files changed, 14 insertions(+), 41 deletions(-)

diff --git a/profiles/thermometer/main.c b/profiles/thermometer/main.c
index 4447b52..fd4b8e2 100644
--- a/profiles/thermometer/main.c
+++ b/profiles/thermometer/main.c
@@ -27,15 +27,12 @@
 #include <stdint.h>
 #include <glib.h>
 #include <errno.h>
-#include <gdbus.h>
 
 #include "plugin.h"
 #include "manager.h"
 #include "hcid.h"
 #include "log.h"
 
-static DBusConnection *connection = NULL;
-
 static int thermometer_init(void)
 {
 	if (!main_opts.gatt_enabled) {
@@ -43,16 +40,7 @@ static int thermometer_init(void)
 		return -ENOTSUP;
 	}
 
-	connection = dbus_bus_get(DBUS_BUS_SYSTEM, NULL);
-	if (connection == NULL)
-		return -EIO;
-
-	if (thermometer_manager_init(connection) < 0) {
-		dbus_connection_unref(connection);
-		return -EIO;
-	}
-
-	return 0;
+	return thermometer_manager_init();
 }
 
 static void thermometer_exit(void)
@@ -61,9 +49,6 @@ static void thermometer_exit(void)
 		return;
 
 	thermometer_manager_exit();
-
-	dbus_connection_unref(connection);
-	connection = NULL;
 }
 
 BLUETOOTH_PLUGIN_DEFINE(thermometer, VERSION, BLUETOOTH_PLUGIN_PRIORITY_DEFAULT,
diff --git a/profiles/thermometer/manager.c b/profiles/thermometer/manager.c
index 4a894cf..1b5173e 100644
--- a/profiles/thermometer/manager.c
+++ b/profiles/thermometer/manager.c
@@ -20,7 +20,6 @@
  *
  */
 
-#include <gdbus.h>
 #include <errno.h>
 #include <stdbool.h>
 #include <bluetooth/uuid.h>
@@ -34,8 +33,6 @@
 #include "thermometer.h"
 #include "manager.h"
 
-static DBusConnection *connection = NULL;
-
 static gint primary_uuid_cmp(gconstpointer a, gconstpointer b)
 {
 	const struct gatt_primary *prim = a;
@@ -58,7 +55,7 @@ static int thermometer_driver_probe(struct btd_device *device, GSList *uuids)
 
 	tattr = l->data;
 
-	return thermometer_register(connection, device, tattr);
+	return thermometer_register(device, tattr);
 }
 
 static void thermometer_driver_remove(struct btd_device *device)
@@ -73,7 +70,7 @@ static struct btd_profile thermometer_profile = {
 	.device_remove	= thermometer_driver_remove
 };
 
-int thermometer_manager_init(DBusConnection *conn)
+int thermometer_manager_init(void)
 {
 	int ret;
 
@@ -81,14 +78,10 @@ int thermometer_manager_init(DBusConnection *conn)
 	if (ret < 0)
 		return ret;
 
-	connection = dbus_connection_ref(conn);
 	return 0;
 }
 
 void thermometer_manager_exit(void)
 {
 	btd_profile_unregister(&thermometer_profile);
-
-	dbus_connection_unref(connection);
-	connection = NULL;
 }
diff --git a/profiles/thermometer/manager.h b/profiles/thermometer/manager.h
index ed928ad..01e4f62 100644
--- a/profiles/thermometer/manager.h
+++ b/profiles/thermometer/manager.h
@@ -20,5 +20,5 @@
  *
  */
 
-int thermometer_manager_init(DBusConnection *conn);
+int thermometer_manager_init(void);
 void thermometer_manager_exit(void);
diff --git a/profiles/thermometer/thermometer.c b/profiles/thermometer/thermometer.c
index 44043e8..77dcb26 100644
--- a/profiles/thermometer/thermometer.c
+++ b/profiles/thermometer/thermometer.c
@@ -56,7 +56,6 @@
 #define MEASUREMENT_INTERVAL_SIZE	2
 
 struct thermometer {
-	DBusConnection		*conn;		/* The connection to the bus */
 	struct btd_device	*dev;		/* Device reference */
 	GAttrib			*attrib;	/* GATT connection */
 	struct att_range	*svc_range;	/* Thermometer range */
@@ -146,7 +145,7 @@ static void remove_watcher(gpointer user_data)
 {
 	struct watcher *watcher = user_data;
 
-	g_dbus_remove_watch(watcher->t->conn, watcher->id);
+	g_dbus_remove_watch(btd_get_dbus_connection(), watcher->id);
 }
 
 static void destroy_char(gpointer user_data)
@@ -179,7 +178,6 @@ static void destroy_thermometer(gpointer user_data)
 	if (t->fwatchers != NULL)
 		g_slist_free_full(t->fwatchers, remove_watcher);
 
-	dbus_connection_unref(t->conn);
 	btd_device_unref(t->dev);
 	g_free(t->svc_range);
 	g_free(t);
@@ -822,7 +820,7 @@ static void watcher_exit(DBusConnection *conn, void *user_data)
 	remove_int_watcher(t, watcher);
 
 	t->fwatchers = g_slist_remove(t->fwatchers, watcher);
-	g_dbus_remove_watch(watcher->t->conn, watcher->id);
+	g_dbus_remove_watch(btd_get_dbus_connection(), watcher->id);
 
 	if (g_slist_length(t->fwatchers) == 0)
 		disable_final_measurement(t);
@@ -901,7 +899,7 @@ static DBusMessage *unregister_watcher(DBusConnection *conn, DBusMessage *msg,
 	remove_int_watcher(t, watcher);
 
 	t->fwatchers = g_slist_remove(t->fwatchers, watcher);
-	g_dbus_remove_watch(watcher->t->conn, watcher->id);
+	g_dbus_remove_watch(btd_get_dbus_connection(), watcher->id);
 
 	if (g_slist_length(t->fwatchers) == 0)
 		disable_final_measurement(t);
@@ -996,7 +994,6 @@ static void update_watcher(gpointer data, gpointer user_data)
 {
 	struct watcher *w = data;
 	struct measurement *m = user_data;
-	DBusConnection *conn = w->t->conn;
 	DBusMessageIter iter;
 	DBusMessageIter dict;
 	DBusMessage *msg;
@@ -1027,7 +1024,7 @@ static void update_watcher(gpointer data, gpointer user_data)
 	dbus_message_iter_close_container(&iter, &dict);
 
 	dbus_message_set_no_reply(msg, TRUE);
-	g_dbus_send_message(conn, msg);
+	g_dbus_send_message(btd_get_dbus_connection(), msg);
 }
 
 static void recv_measurement(struct thermometer *t, struct measurement *m)
@@ -1232,20 +1229,19 @@ static void attio_disconnected_cb(gpointer user_data)
 	t->attrib = NULL;
 }
 
-int thermometer_register(DBusConnection *connection, struct btd_device *device,
-						struct gatt_primary *tattr)
+int thermometer_register(struct btd_device *device, struct gatt_primary *tattr)
 {
 	const gchar *path = device_get_path(device);
 	struct thermometer *t;
 
 	t = g_new0(struct thermometer, 1);
-	t->conn = dbus_connection_ref(connection);
 	t->dev = btd_device_ref(device);
 	t->svc_range = g_new0(struct att_range, 1);
 	t->svc_range->start = tattr->range.start;
 	t->svc_range->end = tattr->range.end;
 
-	if (!g_dbus_register_interface(t->conn, path, THERMOMETER_INTERFACE,
+	if (!g_dbus_register_interface(btd_get_dbus_connection(),
+				path, THERMOMETER_INTERFACE,
 				thermometer_methods, thermometer_signals,
 				NULL, t, destroy_thermometer)) {
 		error("D-Bus failed to register %s interface",
@@ -1272,6 +1268,6 @@ void thermometer_unregister(struct btd_device *device)
 
 	t = l->data;
 	thermometers = g_slist_remove(thermometers, t);
-	g_dbus_unregister_interface(t->conn, device_get_path(t->dev),
-							THERMOMETER_INTERFACE);
+	g_dbus_unregister_interface(btd_get_dbus_connection(),
+				device_get_path(t->dev), THERMOMETER_INTERFACE);
 }
diff --git a/profiles/thermometer/thermometer.h b/profiles/thermometer/thermometer.h
index 330503c..2744ed6 100644
--- a/profiles/thermometer/thermometer.h
+++ b/profiles/thermometer/thermometer.h
@@ -20,6 +20,5 @@
  *
  */
 
-int thermometer_register(DBusConnection *connection, struct btd_device *device,
-						struct gatt_primary *tattr);
+int thermometer_register(struct btd_device *device, struct gatt_primary *tattr);
 void thermometer_unregister(struct btd_device *device);
-- 
1.7.11.3

