Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Rafal Garbat <rafal.garbat@tieto.com>
Subject: [PATCH v6 07/13] heartrate: Add HeartRateManager interface
Date: Thu, 20 Sep 2012 13:14:44 +0200
Message-ID: <1348139690-26985-8-git-send-email-andrzej.kaczmarek@tieto.com>
In-Reply-To: <1348139690-26985-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1348139690-26985-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Rafal Garbat <rafal.garbat@tieto.com>

This patch adds support for org.bluez.HeartRateManager interface on adapters
which allows to register and unregister per-adapter watcher.
---
 profiles/heartrate/heartrate.c | 154 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 153 insertions(+), 1 deletion(-)

diff --git a/profiles/heartrate/heartrate.c b/profiles/heartrate/heartrate.c
index 8c12101..760b294 100644
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
 #include "att.h"
 #include "gatt.h"
@@ -38,9 +41,12 @@
 #include "log.h"
 #include "heartrate.h"
 
+#define HEART_RATE_MANAGER_INTERFACE	"org.bluez.HeartRateManager"
+
 struct heartrate_adapter {
 	struct btd_adapter	*adapter;
 	GSList			*devices;
+	GSList			*watchers;
 };
 
 struct heartrate {
@@ -59,6 +65,13 @@ struct heartrate {
 	uint8_t				location;
 };
 
+struct watcher {
+	struct heartrate_adapter	*hradapter;
+	guint				id;
+	char				*srv;
+	char				*path;
+};
+
 static GSList *heartrate_adapters = NULL;
 
 static gint cmp_adapter(gconstpointer a, gconstpointer b)
@@ -83,6 +96,19 @@ static gint cmp_device(gconstpointer a, gconstpointer b)
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
@@ -94,6 +120,34 @@ find_heartrate_adapter(struct btd_adapter *adapter)
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
 static void destroy_heartrate(gpointer user_data)
 {
 	struct heartrate *hr = user_data;
@@ -109,10 +163,19 @@ static void destroy_heartrate(gpointer user_data)
 	g_free(hr);
 }
 
+static void remove_watcher(gpointer user_data)
+{
+	struct watcher *watcher = user_data;
+
+	g_dbus_remove_watch(get_dbus_connection(), watcher->id);
+}
+
 static void destroy_heartrate_adapter(gpointer user_data)
 {
 	struct heartrate_adapter *hradapter = user_data;
 
+	g_slist_free_full(hradapter->watchers, remove_watcher);
+
 	g_free(hradapter);
 }
 
@@ -258,6 +321,81 @@ static void attio_disconnected_cb(gpointer user_data)
 	hr->attrib = NULL;
 }
 
+static void watcher_exit_cb(DBusConnection *conn, void *user_data)
+{
+	struct watcher *watcher = user_data;
+	struct heartrate_adapter *hradapter = watcher->hradapter;
+
+	DBG("heartrate watcher [%s] disconnected", watcher->path);
+
+	hradapter->watchers = g_slist_remove(hradapter->watchers, watcher);
+	g_dbus_remove_watch(conn, watcher->id);
+}
+
+static DBusMessage *register_watcher(DBusConnection *conn, DBusMessage *msg,
+								void *data)
+{
+	struct heartrate_adapter *hradapter = data;
+	struct watcher *watcher;
+	const char *sender = dbus_message_get_sender(msg);
+	char *path;
+
+	if (!dbus_message_get_args(msg, NULL, DBUS_TYPE_OBJECT_PATH, &path,
+							DBUS_TYPE_INVALID))
+		return btd_error_invalid_args(msg);
+
+	watcher = find_watcher(hradapter->watchers, sender, path);
+	if (watcher != NULL)
+		return btd_error_already_exists(msg);
+
+	watcher = g_new0(struct watcher, 1);
+	watcher->hradapter = hradapter;
+	watcher->id = g_dbus_add_disconnect_watch(conn, sender, watcher_exit_cb,
+						watcher, destroy_watcher);
+	watcher->srv = g_strdup(sender);
+	watcher->path = g_strdup(path);
+
+	hradapter->watchers = g_slist_prepend(hradapter->watchers, watcher);
+
+	DBG("heartrate watcher [%s] registered", path);
+
+	return dbus_message_new_method_return(msg);
+}
+
+static DBusMessage *unregister_watcher(DBusConnection *conn, DBusMessage *msg,
+								void *data)
+{
+	struct heartrate_adapter *hradapter = data;
+	struct watcher *watcher;
+	const char *sender = dbus_message_get_sender(msg);
+	char *path;
+
+	if (!dbus_message_get_args(msg, NULL, DBUS_TYPE_OBJECT_PATH, &path,
+							DBUS_TYPE_INVALID))
+		return btd_error_invalid_args(msg);
+
+	watcher = find_watcher(hradapter->watchers, sender, path);
+	if (watcher == NULL)
+		return btd_error_does_not_exist(msg);
+
+	hradapter->watchers = g_slist_remove(hradapter->watchers, watcher);
+	g_dbus_remove_watch(conn, watcher->id);
+
+	DBG("heartrate watcher [%s] unregistered", path);
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
 int heartrate_adapter_register(struct btd_adapter *adapter)
 {
 	struct heartrate_adapter *hradapter;
@@ -267,6 +405,18 @@ int heartrate_adapter_register(struct btd_adapter *adapter)
 
 	heartrate_adapters = g_slist_prepend(heartrate_adapters, hradapter);
 
+	if (!g_dbus_register_interface(get_dbus_connection(),
+						adapter_get_path(adapter),
+						HEART_RATE_MANAGER_INTERFACE,
+						heartrate_manager_methods,
+						NULL, NULL, hradapter,
+						destroy_heartrate_adapter)) {
+		error("D-Bus failed to register %s interface",
+						HEART_RATE_MANAGER_INTERFACE);
+		destroy_heartrate_adapter(hradapter);
+		return -EIO;
+	}
+
 	return 0;
 }
 
@@ -280,7 +430,9 @@ void heartrate_adapter_unregister(struct btd_adapter *adapter)
 
 	heartrate_adapters = g_slist_remove(heartrate_adapters, hradapter);
 
-	destroy_heartrate_adapter(hradapter);
+	g_dbus_unregister_interface(get_dbus_connection(),
+					adapter_get_path(hradapter->adapter),
+					HEART_RATE_MANAGER_INTERFACE);
 }
 
 int heartrate_device_register(struct btd_device *device,
-- 
1.7.11.3

