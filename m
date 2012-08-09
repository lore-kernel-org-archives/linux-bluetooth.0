Return-Path: <cyrus@holtmann.org>
From: Rafal Garbat <rafal.garbat@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <rafal.garbat@tieto.com>
Subject: [PATCH 06/13] heartrate: Add DBus connection logic
Date: Thu, 9 Aug 2012 09:20:09 +0200
Message-ID: <1344496816-4641-7-git-send-email-rafal.garbat@tieto.com>
In-Reply-To: <1344496816-4641-1-git-send-email-rafal.garbat@tieto.com>
References: <1344496816-4641-1-git-send-email-rafal.garbat@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Add DBus connection logic and watcher methods.

---
 profiles/heartrate/heartrate.c |  156 +++++++++++++++++++++++++++++++++++++++-
 profiles/heartrate/heartrate.h |    3 +-
 profiles/heartrate/main.c      |   18 ++++-
 profiles/heartrate/manager.c   |   19 ++++-
 profiles/heartrate/manager.h   |    2 +-
 5 files changed, 191 insertions(+), 7 deletions(-)

diff --git a/profiles/heartrate/heartrate.c b/profiles/heartrate/heartrate.c
index f1668c7..b11f132 100644
--- a/profiles/heartrate/heartrate.c
+++ b/profiles/heartrate/heartrate.c
@@ -24,12 +24,15 @@
 #include <config.h>
 #endif
 
+#include <gdbus.h>
 #include <errno.h>
 #include <glib.h>
 #include <bluetooth/uuid.h>
 
 #include "adapter.h"
+#include "dbus-common.h"
 #include "device.h"
+#include "error.h"
 #include "gattrib.h"
 #include "attio.h"
 #include "att.h"
@@ -37,12 +40,16 @@
 #include "heartrate.h"
 #include "log.h"
 
+#define HEART_RATE_INTERFACE "org.bluez.HeartRate"
+
 struct heartrate {
 	struct btd_device	*dev;  /*Device reference*/
+	DBusConnection		*conn; /*DBus conn*/
 	GAttrib			*attrib; /*GATT connection*/
 	guint			attioid; /*ATT watcher id*/
 	struct att_range	*svc_range; /*Heart Rate range*/
 	GSList			*chars; /*Characteristics*/
+	GSList			*watchers; /*Watchers*/
 };
 
 struct characteristic {
@@ -57,6 +64,13 @@ struct descriptor {
 	bt_uuid_t		uuid;
 };
 
+struct watcher {
+	struct heartrate	*hr;
+	guint			id;
+	char			*srv;
+	char			*path;
+};
+
 static GSList *hr_servers = NULL;
 
 static gint cmp_device(gconstpointer a, gconstpointer b)
@@ -70,6 +84,35 @@ static gint cmp_device(gconstpointer a, gconstpointer b)
 	return -1;
 }
 
+static gint cmp_watcher(gconstpointer a, gconstpointer b)
+{
+	const struct watcher *watcher = a;
+	const struct watcher *match = b;
+	int ret;
+
+	ret = g_strcmp0(watcher->srv, match->srv);
+	if (ret != 0)
+		return ret;
+
+	return g_strcmp0(watcher->path, match->path);
+}
+
+static void watcher_remove(gpointer user_data)
+{
+	struct watcher *watcher = user_data;
+
+	g_dbus_remove_watch(watcher->hr->conn, watcher->id);
+}
+
+static void watcher_destroy(gpointer user_data)
+{
+	struct watcher *watcher = user_data;
+
+	g_free(watcher->path);
+	g_free(watcher->srv);
+	g_free(watcher);
+}
+
 static void char_destroy(gpointer user_data)
 {
 	struct characteristic *c = user_data;
@@ -92,12 +135,109 @@ static void heartrate_destroy(gpointer user_data)
 	if (hr->attrib != NULL)
 		g_attrib_unref(hr->attrib);
 
+	if (hr->watchers != NULL)
+		g_slist_free_full(hr->watchers, watcher_remove);
+
 	btd_device_unref(hr->dev);
+	dbus_connection_unref(hr->conn);
 	g_free(hr->svc_range);
 	g_free(hr);
+}
+
+static void watcher_exit(DBusConnection *conn, void *user_data)
+{
+	struct watcher *watcher = user_data;
+	struct heartrate *hr = watcher->hr;
+
+	DBG("Heart Rate watcher %s disconnected", watcher->path);
+
+	hr->watchers = g_slist_remove(hr->watchers, watcher);
+	g_dbus_remove_watch(watcher->hr->conn, watcher->id);
+}
+
+static struct watcher *watcher_find(GSList *list, const char *sender,
+							const char *path)
+{
+	struct watcher *match;
+	GSList *l;
+
+	match = g_new0(struct watcher, 1);
+	match->srv = g_strdup(sender);
+	match->path = g_strdup(path);
+
+	l = g_slist_find_custom(list, match, cmp_watcher);
+	watcher_destroy(match);
+
+	if (l != NULL)
+		return l->data;
+
+	return NULL;
+}
+
+static DBusMessage *watcher_register(DBusConnection *conn, DBusMessage *msg,
+								void *data)
+{
+	const char *sender = dbus_message_get_sender(msg);
+	struct heartrate *hr = data;
+	struct watcher *watcher;
+	char *path;
+
+	if (!dbus_message_get_args(msg, NULL, DBUS_TYPE_OBJECT_PATH, &path,
+							DBUS_TYPE_INVALID))
+		return btd_error_invalid_args(msg);
+
+	watcher = watcher_find(hr->watchers, sender, path);
+	if (watcher != NULL)
+		return btd_error_already_exists(msg);
+
+	DBG("Heart Rate watcher %s registered", path);
+
+	watcher = g_new0(struct watcher, 1);
+	watcher->srv = g_strdup(sender);
+	watcher->path = g_strdup(path);
+	watcher->hr = hr;
+	watcher->id = g_dbus_add_disconnect_watch(conn, sender, watcher_exit,
+						watcher, watcher_destroy);
+
+	hr->watchers = g_slist_prepend(hr->watchers, watcher);
 
+	return dbus_message_new_method_return(msg);
 }
 
+static DBusMessage *watcher_unregister(DBusConnection *conn, DBusMessage *msg,
+								void *data)
+{
+	const char *sender = dbus_message_get_sender(msg);
+	struct heartrate *hr = data;
+	struct watcher *watcher;
+	char *path;
+
+	if (!dbus_message_get_args(msg, NULL, DBUS_TYPE_OBJECT_PATH, &path,
+							DBUS_TYPE_INVALID))
+		return btd_error_invalid_args(msg);
+
+	watcher = watcher_find(hr->watchers, sender, path);
+	if (watcher == NULL)
+		return btd_error_does_not_exist(msg);
+
+	DBG("Heart Rate watcher %s unregistered", path);
+
+	hr->watchers = g_slist_remove(hr->watchers, watcher);
+	g_dbus_remove_watch(watcher->hr->conn, watcher->id);
+
+	return dbus_message_new_method_return(msg);
+}
+
+static const GDBusMethodTable heartrate_methods[] = {
+	{ GDBUS_METHOD("RegisterWatcher",
+			GDBUS_ARGS({ "agent", "o" }), NULL,
+			watcher_register) },
+	{ GDBUS_METHOD("UnregisterWatcher",
+			GDBUS_ARGS({ "agent", "o" }), NULL,
+			watcher_unregister) },
+	{ }
+};
+
 static void measurement_cb(guint8 status, const guint8 *pdu,
 						guint16 len, gpointer user_data)
 {
@@ -245,17 +385,29 @@ static void attio_disconnected_cb(gpointer user_data)
 	hr->attrib = NULL;
 }
 
-int heartrate_register(struct btd_device *device, struct gatt_primary *pattr)
+int heartrate_register(DBusConnection *connection, struct btd_device *device,
+						struct gatt_primary *pattr)
 {
+	const gchar *path = device_get_path(device);
 	struct heartrate *hr;
 
 	hr = g_new0(struct heartrate, 1);
 	hr->dev = btd_device_ref(device);
 
+	hr->conn = dbus_connection_ref(connection);
 	hr->svc_range = g_new0(struct att_range, 1);
 	hr->svc_range->start = pattr->range.start;
 	hr->svc_range->end = pattr->range.end;
 
+	if (!g_dbus_register_interface(hr->conn, path, HEART_RATE_INTERFACE,
+						heartrate_methods, NULL, NULL,
+						hr, heartrate_destroy)) {
+		error("D-Bus failed to register %s interface",
+							HEART_RATE_INTERFACE);
+		heartrate_destroy(hr);
+		return -EIO;
+	}
+
 	hr_servers = g_slist_prepend(hr_servers, hr);
 
 	hr->attioid = btd_device_add_attio_callback(device,
@@ -276,5 +428,7 @@ void heartrate_unregister(struct btd_device *device)
 	hr = l->data;
 	hr_servers = g_slist_remove(hr_servers, hr);
 
+	g_dbus_unregister_interface(hr->conn, device_get_path(hr->dev),
+							HEART_RATE_INTERFACE);
 	heartrate_destroy(hr);
 }
diff --git a/profiles/heartrate/heartrate.h b/profiles/heartrate/heartrate.h
index 1d2ba89..08e2c92 100644
--- a/profiles/heartrate/heartrate.h
+++ b/profiles/heartrate/heartrate.h
@@ -20,5 +20,6 @@
  *
  */
 
-int heartrate_register(struct btd_device *device, struct gatt_primary *pattr);
+int heartrate_register(DBusConnection *connection, struct btd_device *device,
+						struct gatt_primary *tattr);
 void heartrate_unregister(struct btd_device *device);
diff --git a/profiles/heartrate/main.c b/profiles/heartrate/main.c
index 40f34bc..8e8fde9 100644
--- a/profiles/heartrate/main.c
+++ b/profiles/heartrate/main.c
@@ -27,12 +27,15 @@
 #include <stdint.h>
 #include <glib.h>
 #include <errno.h>
+#include <gdbus.h>
 
 #include "plugin.h"
 #include "manager.h"
 #include "hcid.h"
 #include "log.h"
 
+static DBusConnection *connection = NULL;
+
 static int heartrate_init(void)
 {
 	if (!main_opts.gatt_enabled) {
@@ -40,12 +43,25 @@ static int heartrate_init(void)
 		return -ENOTSUP;
 	}
 
-	return heartrate_manager_init();
+	connection = dbus_bus_get(DBUS_BUS_SYSTEM, NULL);
+	if (connection == NULL)
+		return -EIO;
+
+	if (heartrate_manager_init(connection) < 0) {
+		dbus_connection_unref(connection);
+		connection = NULL;
+		return -EIO;
+	}
+
+	return 0;
 }
 
 static void heartrate_exit(void)
 {
 	heartrate_manager_exit();
+
+	dbus_connection_unref(connection);
+	connection = NULL;
 }
 
 BLUETOOTH_PLUGIN_DEFINE(heartrate, VERSION, BLUETOOTH_PLUGIN_PRIORITY_DEFAULT,
diff --git a/profiles/heartrate/manager.c b/profiles/heartrate/manager.c
index 6ba059d..c373f86 100644
--- a/profiles/heartrate/manager.c
+++ b/profiles/heartrate/manager.c
@@ -32,6 +32,8 @@
 #include "heartrate.h"
 #include "manager.h"
 
+static DBusConnection *connection = NULL;
+
 static gint primary_uuid_cmp(gconstpointer a, gconstpointer b)
 {
 	const struct gatt_primary *prim = a;
@@ -54,7 +56,7 @@ static int heartrate_driver_probe(struct btd_device *device, GSList *uuids)
 
 	pattr = l->data;
 
-	return heartrate_register(device, pattr);
+	return heartrate_register(connection, device, pattr);
 }
 
 static void heartrate_driver_remove(struct btd_device *device)
@@ -69,12 +71,23 @@ static struct btd_device_driver heartrate_device_driver = {
 	.remove	= heartrate_driver_remove
 };
 
-int heartrate_manager_init(void)
+int heartrate_manager_init(DBusConnection *conn)
+
 {
-	return btd_register_device_driver(&heartrate_device_driver);
+	int ret;
+
+	ret = btd_register_device_driver(&heartrate_device_driver);
+	if (ret < 0)
+		return ret;
+
+	connection = dbus_connection_ref(conn);
+	return 0;
 }
 
 void heartrate_manager_exit(void)
 {
 	btd_unregister_device_driver(&heartrate_device_driver);
+
+	dbus_connection_unref(connection);
+	connection = NULL;
 }
diff --git a/profiles/heartrate/manager.h b/profiles/heartrate/manager.h
index de799f6..5e9c8b2 100644
--- a/profiles/heartrate/manager.h
+++ b/profiles/heartrate/manager.h
@@ -20,5 +20,5 @@
  *
  */
 
-int heartrate_manager_init(void);
+int heartrate_manager_init(DBusConnection *conn);
 void heartrate_manager_exit(void);
-- 
1.7.9.5

