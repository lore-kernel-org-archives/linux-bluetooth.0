Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: claudio.takahasi@openbossa.org,
	Alvaro Silva <alvaro.silva@openbossa.org>
Subject: [PATCH BlueZ v4 07/18] gatt: Add external services tracking
Date: Mon, 27 Jan 2014 15:00:45 -0300
Message-Id: <1390845656-29880-8-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1390845656-29880-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1390398025-28340-1-git-send-email-claudio.takahasi@openbossa.org>
 <1390845656-29880-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Alvaro Silva <alvaro.silva@openbossa.org>

All primary services declarations provided by an external application
will be automatically inserted in the attribute database.
---
 src/gatt-dbus.c | 109 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 109 insertions(+)

diff --git a/src/gatt-dbus.c b/src/gatt-dbus.c
index fd614f9..000d7ae 100644
--- a/src/gatt-dbus.c
+++ b/src/gatt-dbus.c
@@ -39,15 +39,21 @@
 #include "log.h"
 
 #include "error.h"
+#include "gatt.h"
 #include "gatt-dbus.h"
 
 #define GATT_MGR_IFACE			"org.bluez.GattManager1"
+#define SERVICE_IFACE			"org.bluez.GattService1"
+
+#define REGISTER_TIMER         1
 
 struct external_app {
 	char *owner;
 	char *path;
 	GDBusClient *client;
+	GSList *proxies;
 	unsigned int watch;
+	guint register_timer;
 };
 
 static GSList *external_apps;
@@ -60,6 +66,36 @@ static int external_app_path_cmp(gconstpointer a, gconstpointer b)
 	return g_strcmp0(eapp->path, path);
 }
 
+static void proxy_added(GDBusProxy *proxy, void *user_data)
+{
+	struct external_app *eapp = user_data;
+	const char *interface, *path;
+
+	interface = g_dbus_proxy_get_interface(proxy);
+	path = g_dbus_proxy_get_path(proxy);
+
+	DBG("path %s iface %s", path, interface);
+
+	if (g_strcmp0(interface, SERVICE_IFACE) != 0)
+		return;
+
+	eapp->proxies = g_slist_append(eapp->proxies, proxy);
+}
+
+static void proxy_removed(GDBusProxy *proxy, void *user_data)
+{
+	struct external_app *eapp = user_data;
+	const char *interface, *path;
+
+	interface = g_dbus_proxy_get_interface(proxy);
+	path = g_dbus_proxy_get_path(proxy);
+
+	DBG("path %s iface %s", path, interface);
+
+	eapp->proxies = g_slist_remove(eapp->proxies, proxy);
+}
+
+
 static void external_app_watch_destroy(gpointer user_data)
 {
 	struct external_app *eapp = user_data;
@@ -70,6 +106,9 @@ static void external_app_watch_destroy(gpointer user_data)
 
 	g_dbus_client_unref(eapp->client);
 
+	if (eapp->register_timer)
+		g_source_remove(eapp->register_timer);
+
 	g_free(eapp->owner);
 	g_free(eapp->path);
 	g_free(eapp);
@@ -99,9 +138,75 @@ static struct external_app *new_external_app(DBusConnection *conn,
 	eapp->client = client;
 	eapp->path = g_strdup(path);
 
+	g_dbus_client_set_proxy_handlers(client, proxy_added, proxy_removed,
+								NULL, eapp);
+
 	return eapp;
 }
 
+static int register_external_service(GDBusProxy *proxy)
+{
+	DBusMessageIter iter;
+	const char *uuid;
+	bt_uuid_t btuuid;
+
+	if (!g_dbus_proxy_get_property(proxy, "UUID", &iter))
+		return -EINVAL;
+
+	if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_STRING)
+		return -EINVAL;
+
+	dbus_message_iter_get_basic(&iter, &uuid);
+
+	if (bt_string_to_uuid(&btuuid, uuid) < 0)
+		return -EINVAL;
+
+	if (btd_gatt_add_service(&btuuid) == NULL)
+		return -EINVAL;
+
+	return 0;
+}
+
+static gboolean finish_register(gpointer user_data)
+{
+	struct external_app *eapp = user_data;
+	GSList *list;
+
+	/*
+	 * It is not possible to detect when the last proxy object
+	 * was reported. "Proxy added" handler reports objects
+	 * added on demand or returned by GetManagedObjects().
+	 * This timer helps to register all the GATT declarations
+	 * (services, characteristics and descriptors) after fetching
+	 * all the D-Bus objects.
+	 */
+
+	eapp->register_timer = 0;
+
+	for (list = eapp->proxies; list; list = g_slist_next(list)) {
+		const char *interface, *path;
+		GDBusProxy *proxy = list->data;
+
+		interface = g_dbus_proxy_get_interface(proxy);
+		path = g_dbus_proxy_get_path(proxy);
+
+		if (g_strcmp0(SERVICE_IFACE, interface) != 0)
+			continue;
+
+		if (g_strcmp0(path, eapp->path) != 0)
+			continue;
+
+		if (register_external_service(proxy) < 0) {
+			DBG("Inconsistent external service: %s", path);
+			continue;
+		}
+
+		DBG("External service: %s", path);
+	}
+
+	return FALSE;
+}
+
 static DBusMessage *register_service(DBusConnection *conn,
 					DBusMessage *msg, void *user_data)
 {
@@ -109,6 +214,8 @@ static DBusMessage *register_service(DBusConnection *conn,
 	DBusMessageIter iter;
 	const char *path;
 
+	DBG("Registering GATT Service");
+
 	if (!dbus_message_iter_init(msg, &iter))
 		return btd_error_invalid_args(msg);
 
@@ -127,6 +234,8 @@ static DBusMessage *register_service(DBusConnection *conn,
 	external_apps = g_slist_prepend(external_apps, eapp);
 
 	DBG("New app %p: %s", eapp, path);
+	eapp->register_timer = g_timeout_add_seconds(REGISTER_TIMER,
+							finish_register, eapp);
 
 	return g_dbus_create_reply(msg, DBUS_TYPE_INVALID);
 }
-- 
1.8.3.1

