Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Rafal Garbat <rafal.garbat@tieto.com>
Subject: [PATCH v3 08/17] heartrate: Add HeartRateManager interface
Date: Thu, 6 Sep 2012 13:32:42 +0200
Message-ID: <1346931171-18968-9-git-send-email-andrzej.kaczmarek@tieto.com>
In-Reply-To: <1346931171-18968-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1346931171-18968-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Rafal Garbat <rafal.garbat@tieto.com>

This patch adds support for org.bluez.HeartRateManager interface on adapters
which allows to register and unregister per-adapter watcher.

---
 profiles/heartrate/heartrate.c | 155 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 154 insertions(+), 1 deletion(-)

diff --git a/profiles/heartrate/heartrate.c b/profiles/heartrate/heartrate.c
index eec8ae0..a223fe0 100644
--- a/profiles/heartrate/heartrate.c
+++ b/profiles/heartrate/heartrate.c
@@ -24,13 +24,16 @@
 #include <config.h>
 #endif
 
+#include <gdbus.h>
 #include <errno.h>
 #include <stdbool.h>
 #include <glib.h>
 #include <bluetooth/uuid.h>
 
 #include "adapter.h"
+#include "dbus-common.h"
 #include "device.h"
+#include "error.h"
 #include "gattrib.h"
 #include "attio.h"
 #include "att.h"
@@ -38,9 +41,12 @@
 #include "heartrate.h"
 #include "log.h"
 
+#define HEART_RATE_MANAGER_IFACE "org.bluez.HeartRateManager"
+
 struct heartrate_adapter {
 	struct btd_adapter	*adapter;
 	GSList			*devices;
+	GSList			*watchers;
 };
 
 struct heartrate {
@@ -64,6 +70,13 @@ struct descriptor {
 	bt_uuid_t		uuid;
 };
 
+struct watcher {
+	struct heartrate_adapter	*hra;
+	guint				id;
+	char				*srv;
+	char				*path;
+};
+
 static GSList *heartrate_adapters = NULL;
 
 static gint cmp_adapter(gconstpointer a, gconstpointer b)
@@ -88,6 +101,19 @@ static gint cmp_device(gconstpointer a, gconstpointer b)
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
 static struct heartrate_adapter *
 find_heartrate_adapter(struct btd_adapter *adapter)
 {
@@ -108,6 +134,22 @@ static void destroy_char(gpointer user_data)
 	g_free(c);
 }
 
+static void remove_watcher(gpointer user_data)
+{
+	struct watcher *watcher = user_data;
+
+	g_dbus_remove_watch(get_dbus_connection(), watcher->id);
+}
+
+static void destroy_watcher(gpointer user_data)
+{
+	struct watcher *watcher = user_data;
+
+	g_free(watcher->path);
+	g_free(watcher->srv);
+	g_free(watcher);
+}
+
 static void destroy_heartrate_device(gpointer user_data)
 {
 	struct heartrate *hr = user_data;
@@ -133,9 +175,106 @@ static void destroy_heartrate_adapter(gpointer user_data)
 	if (hra->devices != NULL)
 		g_slist_free_full(hra->devices, destroy_heartrate_device);
 
+	if (hra->watchers != NULL)
+		g_slist_free_full(hra->watchers, remove_watcher);
+
 	g_free(hra);
 }
 
+static void watcher_exit(DBusConnection *conn, void *user_data)
+{
+	struct watcher *watcher = user_data;
+	struct heartrate_adapter *hr = watcher->hra;
+
+	DBG("Heart Rate watcher %s disconnected", watcher->path);
+
+	hr->watchers = g_slist_remove(hr->watchers, watcher);
+	g_dbus_remove_watch(conn, watcher->id);
+}
+
+static struct watcher *find_watcher(GSList *list, const char *sender,
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
+	destroy_watcher(match);
+
+	if (l != NULL)
+		return l->data;
+
+	return NULL;
+}
+
+static DBusMessage *register_watcher(DBusConnection *conn, DBusMessage *msg,
+								void *data)
+{
+	const char *sender = dbus_message_get_sender(msg);
+	struct heartrate_adapter *hra = data;
+	struct watcher *watcher;
+	char *path;
+
+	if (!dbus_message_get_args(msg, NULL, DBUS_TYPE_OBJECT_PATH, &path,
+							DBUS_TYPE_INVALID))
+		return btd_error_invalid_args(msg);
+
+	watcher = find_watcher(hra->watchers, sender, path);
+	if (watcher != NULL)
+		return btd_error_already_exists(msg);
+
+	DBG("Heart Rate watcher %s registered", path);
+
+	watcher = g_new0(struct watcher, 1);
+	watcher->srv = g_strdup(sender);
+	watcher->path = g_strdup(path);
+	watcher->hra = hra;
+	watcher->id = g_dbus_add_disconnect_watch(conn, sender, watcher_exit,
+						watcher, destroy_watcher);
+
+	hra->watchers = g_slist_prepend(hra->watchers, watcher);
+
+	return dbus_message_new_method_return(msg);
+}
+
+static DBusMessage *unregister_watcher(DBusConnection *conn, DBusMessage *msg,
+								void *data)
+{
+	const char *sender = dbus_message_get_sender(msg);
+	struct heartrate_adapter *hr = data;
+	struct watcher *watcher;
+	char *path;
+
+	if (!dbus_message_get_args(msg, NULL, DBUS_TYPE_OBJECT_PATH, &path,
+							DBUS_TYPE_INVALID))
+		return btd_error_invalid_args(msg);
+
+	watcher = find_watcher(hr->watchers, sender, path);
+	if (watcher == NULL)
+		return btd_error_does_not_exist(msg);
+
+	DBG("Heart Rate watcher %s unregistered", path);
+
+	hr->watchers = g_slist_remove(hr->watchers, watcher);
+	g_dbus_remove_watch(get_dbus_connection(), watcher->id);
+
+	return dbus_message_new_method_return(msg);
+}
+
+static const GDBusMethodTable heartrate_manager_methods[] = {
+	{ GDBUS_METHOD("RegisterWatcher",
+			GDBUS_ARGS({ "agent", "o" }), NULL,
+			register_watcher) },
+	{ GDBUS_METHOD("UnregisterWatcher",
+			GDBUS_ARGS({ "agent", "o" }), NULL,
+			unregister_watcher) },
+	{ }
+};
+
 static void process_heartrate_char(struct characteristic *ch)
 {
 	if (g_strcmp0(ch->attr.uuid, HEART_RATE_CONTROL_POINT_UUID) == 0)
@@ -275,6 +414,18 @@ int heartrate_adapter_register(struct btd_adapter *adapter)
 	hra = g_new0(struct heartrate_adapter, 1);
 	hra->adapter = adapter;
 
+	if (!g_dbus_register_interface(get_dbus_connection(),
+						adapter_get_path(adapter),
+						HEART_RATE_MANAGER_IFACE,
+						heartrate_manager_methods,
+						NULL, NULL, hra,
+						destroy_heartrate_adapter)) {
+		error("D-Bus failed to register %s interface",
+						HEART_RATE_MANAGER_IFACE);
+		destroy_heartrate_adapter(hra);
+		return -EIO;
+	}
+
 	heartrate_adapters = g_slist_prepend(heartrate_adapters, hra);
 
 	return 0;
@@ -290,7 +441,9 @@ void heartrate_adapter_unregister(struct btd_adapter *adapter)
 
 	heartrate_adapters = g_slist_remove(heartrate_adapters, hra);
 
-	destroy_heartrate_adapter(hra);
+	g_dbus_unregister_interface(get_dbus_connection(),
+						adapter_get_path(hra->adapter),
+						HEART_RATE_MANAGER_IFACE);
 }
 
 int heartrate_device_register(struct btd_device *device,
-- 
1.7.11.3

