Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [RFC 07/18] cyclingspeed: Add CyclingSpeedManager interface
Date: Thu, 25 Oct 2012 16:43:37 +0200
Message-ID: <1351176228-5789-8-git-send-email-andrzej.kaczmarek@tieto.com>
In-Reply-To: <1351176228-5789-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1351176228-5789-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch registers org.bluez.CyclingSpeedManager interface for each
adapter to allow registration and deregistration of measurement watchers.
---
 profiles/cyclingspeed/cyclingspeed.c | 154 ++++++++++++++++++++++++++++++++++-
 1 file changed, 153 insertions(+), 1 deletion(-)

diff --git a/profiles/cyclingspeed/cyclingspeed.c b/profiles/cyclingspeed/cyclingspeed.c
index 67963d1..0b3742a 100644
--- a/profiles/cyclingspeed/cyclingspeed.c
+++ b/profiles/cyclingspeed/cyclingspeed.c
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
 #include "att.h"
 #include "gatt.h"
@@ -38,9 +41,12 @@
 #include "log.h"
 #include "cyclingspeed.h"
 
+#define CYCLINGSPEED_MANAGER_INTERFACE	"org.bluez.CyclingSpeedManager"
+
 struct csc_adapter {
 	struct btd_adapter	*adapter;
 	GSList			*devices;	/* list of registered devices */
+	GSList			*watchers;
 };
 
 struct csc {
@@ -60,6 +66,13 @@ struct csc {
 	uint8_t			location;
 };
 
+struct watcher {
+	struct csc_adapter	*cadapter;
+	guint			id;
+	char			*srv;
+	char			*path;
+};
+
 struct characteristic {
 	struct csc	*csc;
 	char		uuid[MAX_LEN_UUID_STR + 1];
@@ -89,6 +102,19 @@ static gint cmp_device(gconstpointer a, gconstpointer b)
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
 static struct csc_adapter *find_csc_adapter(struct btd_adapter *adapter)
 {
 	GSList *l = g_slist_find_custom(csc_adapters, adapter, cmp_adapter);
@@ -99,10 +125,47 @@ static struct csc_adapter *find_csc_adapter(struct btd_adapter *adapter)
 	return l->data;
 }
 
+static void destroy_watcher(gpointer user_data)
+{
+	struct watcher *watcher = user_data;
+
+	g_free(watcher->path);
+	g_free(watcher->srv);
+	g_free(watcher);
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
+static void remove_watcher(gpointer user_data)
+{
+	struct watcher *watcher = user_data;
+
+	g_dbus_remove_watch(btd_get_dbus_connection(), watcher->id);
+}
+
 static void destroy_csc_adapter(gpointer user_data)
 {
 	struct csc_adapter *cadapter = user_data;
 
+	g_slist_free_full(cadapter->watchers, remove_watcher);
+
 	g_free(cadapter);
 }
 
@@ -303,6 +366,81 @@ static void attio_disconnected_cb(gpointer user_data)
 	csc->attrib = NULL;
 }
 
+static void watcher_exit_cb(DBusConnection *conn, void *user_data)
+{
+	struct watcher *watcher = user_data;
+	struct csc_adapter *cadapter = watcher->cadapter;
+
+	DBG("cycling watcher [%s] disconnected", watcher->path);
+
+	cadapter->watchers = g_slist_remove(cadapter->watchers, watcher);
+	g_dbus_remove_watch(conn, watcher->id);
+}
+
+static DBusMessage *register_watcher(DBusConnection *conn, DBusMessage *msg,
+								void *data)
+{
+	struct csc_adapter *cadapter = data;
+	struct watcher *watcher;
+	const char *sender = dbus_message_get_sender(msg);
+	char *path;
+
+	if (!dbus_message_get_args(msg, NULL, DBUS_TYPE_OBJECT_PATH, &path,
+							DBUS_TYPE_INVALID))
+		return btd_error_invalid_args(msg);
+
+	watcher = find_watcher(cadapter->watchers, sender, path);
+	if (watcher != NULL)
+		return btd_error_already_exists(msg);
+
+	watcher = g_new0(struct watcher, 1);
+	watcher->cadapter = cadapter;
+	watcher->id = g_dbus_add_disconnect_watch(conn, sender, watcher_exit_cb,
+						watcher, destroy_watcher);
+	watcher->srv = g_strdup(sender);
+	watcher->path = g_strdup(path);
+
+	cadapter->watchers = g_slist_prepend(cadapter->watchers, watcher);
+
+	DBG("cycling watcher [%s] registered", path);
+
+	return dbus_message_new_method_return(msg);
+}
+
+static DBusMessage *unregister_watcher(DBusConnection *conn, DBusMessage *msg,
+								void *data)
+{
+	struct csc_adapter *cadapter = data;
+	struct watcher *watcher;
+	const char *sender = dbus_message_get_sender(msg);
+	char *path;
+
+	if (!dbus_message_get_args(msg, NULL, DBUS_TYPE_OBJECT_PATH, &path,
+							DBUS_TYPE_INVALID))
+		return btd_error_invalid_args(msg);
+
+	watcher = find_watcher(cadapter->watchers, sender, path);
+	if (watcher == NULL)
+		return btd_error_does_not_exist(msg);
+
+	cadapter->watchers = g_slist_remove(cadapter->watchers, watcher);
+	g_dbus_remove_watch(conn, watcher->id);
+
+	DBG("cycling watcher [%s] unregistered", path);
+
+	return dbus_message_new_method_return(msg);
+}
+
+static const GDBusMethodTable cyclingspeed_manager_methods[] = {
+	{ GDBUS_METHOD("RegisterWatcher",
+			GDBUS_ARGS({ "agent", "o" }), NULL,
+			register_watcher) },
+	{ GDBUS_METHOD("UnregisterWatcher",
+			GDBUS_ARGS({ "agent", "o" }), NULL,
+			unregister_watcher) },
+	{ }
+};
+
 int csc_adapter_register(struct btd_adapter *adapter)
 {
 	struct csc_adapter *cadapter;
@@ -312,6 +450,18 @@ int csc_adapter_register(struct btd_adapter *adapter)
 
 	csc_adapters = g_slist_prepend(csc_adapters, cadapter);
 
+	if (!g_dbus_register_interface(btd_get_dbus_connection(),
+						adapter_get_path(adapter),
+						CYCLINGSPEED_MANAGER_INTERFACE,
+						cyclingspeed_manager_methods,
+						NULL, NULL, cadapter,
+						destroy_csc_adapter)) {
+		error("D-Bus failed to register %s interface",
+						CYCLINGSPEED_MANAGER_INTERFACE);
+		destroy_csc_adapter(cadapter);
+		return -EIO;
+	}
+
 	return 0;
 }
 
@@ -325,7 +475,9 @@ void csc_adapter_unregister(struct btd_adapter *adapter)
 
 	csc_adapters = g_slist_remove(csc_adapters, cadapter);
 
-	destroy_csc_adapter(cadapter);
+	g_dbus_unregister_interface(btd_get_dbus_connection(),
+					adapter_get_path(cadapter->adapter),
+					CYCLINGSPEED_MANAGER_INTERFACE);
 }
 
 int csc_device_register(struct btd_device *device, struct gatt_primary *prim)
-- 
1.8.0

