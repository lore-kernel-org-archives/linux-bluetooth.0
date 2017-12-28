Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Subject: [PATCH BlueZ v2 1/8] gdbus: Make proxy_lookup() global
From: ERAMOTO Masaya <eramoto.masaya@jp.fujitsu.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
References: <2003783a-cdd8-597a-6438-967ffafe67c8@jp.fujitsu.com>
Message-ID: <f619fe12-c359-d01f-0bc5-03e62da609bf@jp.fujitsu.com>
Date: Thu, 28 Dec 2017 14:43:59 +0900
MIME-Version: 1.0
In-Reply-To: <2003783a-cdd8-597a-6438-967ffafe67c8@jp.fujitsu.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Also adds the following feature to g_dbus_proxy_lookup().
 - It is more robust even if a proxy is NULL.
 - It checks if the passed interface is NULL.
 - It looks up from the position of the list specified by the index.
---
 gdbus/client.c | 23 +++++++++++++++++------
 gdbus/gdbus.h  |  3 +++
 2 files changed, 20 insertions(+), 6 deletions(-)

diff --git a/gdbus/client.c b/gdbus/client.c
index ab4059697..3768d2f59 100644
--- a/gdbus/client.c
+++ b/gdbus/client.c
@@ -352,16 +352,25 @@ static void get_all_properties(GDBusProxy *proxy)
 	dbus_message_unref(msg);
 }
 
-static GDBusProxy *proxy_lookup(GList *list, const char *path,
+GDBusProxy *g_dbus_proxy_lookup(GList *list, int *index, const char *path,
 						const char *interface)
 {
 	GList *l;
 
-	for (l = g_list_first(list); l; l = g_list_next(l)) {
+	if (!interface)
+		return NULL;
+
+	for (l = g_list_nth(list, index ? *index : 0); l; l = g_list_next(l)) {
 		GDBusProxy *proxy = l->data;
 
-		if (g_str_equal(proxy->interface, interface) == TRUE &&
-				g_str_equal(proxy->obj_path, path) == TRUE)
+		const char *proxy_iface = g_dbus_proxy_get_interface(proxy);
+		const char *proxy_path = g_dbus_proxy_get_path(proxy);
+
+		if (index)
+			(*index)++;
+
+		if (g_str_equal(proxy_iface, interface) == TRUE &&
+			g_str_equal(proxy_path, path) == TRUE)
 			return proxy;
         }
 
@@ -519,7 +528,8 @@ GDBusProxy *g_dbus_proxy_new(GDBusClient *client, const char *path,
 	if (client == NULL)
 		return NULL;
 
-	proxy = proxy_lookup(client->proxy_list, path, interface);
+	proxy = g_dbus_proxy_lookup(client->proxy_list, NULL,
+						path, interface);
 	if (proxy)
 		return g_dbus_proxy_ref(proxy);
 
@@ -992,7 +1002,8 @@ static void parse_properties(GDBusClient *client, const char *path,
 	if (g_str_equal(interface, DBUS_INTERFACE_PROPERTIES) == TRUE)
 		return;
 
-	proxy = proxy_lookup(client->proxy_list, path, interface);
+	proxy = g_dbus_proxy_lookup(client->proxy_list, NULL,
+						path, interface);
 	if (proxy && !proxy->pending) {
 		update_properties(proxy, iter, FALSE);
 		return;
diff --git a/gdbus/gdbus.h b/gdbus/gdbus.h
index e37385fa1..85cb9682e 100644
--- a/gdbus/gdbus.h
+++ b/gdbus/gdbus.h
@@ -339,6 +339,9 @@ const char *g_dbus_proxy_get_interface(GDBusProxy *proxy);
 gboolean g_dbus_proxy_get_property(GDBusProxy *proxy, const char *name,
 							DBusMessageIter *iter);
 
+GDBusProxy *g_dbus_proxy_lookup(GList *list, int *index, const char *path,
+						const char *interface);
+
 gboolean g_dbus_proxy_refresh_property(GDBusProxy *proxy, const char *name);
 
 typedef void (* GDBusResultFunction) (const DBusError *error, void *user_data);
-- 
2.14.1

