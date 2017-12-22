Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Subject: [PATCH BlueZ 1/8] gdbus: Make proxy_lookup() global
From: ERAMOTO Masaya <eramoto.masaya@jp.fujitsu.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
References: <6f0b4053-4936-8d8c-3095-d6326d9a0e93@jp.fujitsu.com>
Message-ID: <134c30ec-c483-dd2c-4ec2-d3951a311fb1@jp.fujitsu.com>
Date: Fri, 22 Dec 2017 16:35:28 +0900
MIME-Version: 1.0
In-Reply-To: <6f0b4053-4936-8d8c-3095-d6326d9a0e93@jp.fujitsu.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Also g_dbus_proxy_lookup() is more robust even if proxy is NULL.
---
 gdbus/client.c | 13 ++++++++-----
 gdbus/gdbus.h  |  3 +++
 2 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/gdbus/client.c b/gdbus/client.c
index ab4059697..6ec611455 100644
--- a/gdbus/client.c
+++ b/gdbus/client.c
@@ -352,7 +352,7 @@ static void get_all_properties(GDBusProxy *proxy)
 	dbus_message_unref(msg);
 }
 
-static GDBusProxy *proxy_lookup(GList *list, const char *path,
+GDBusProxy *g_dbus_proxy_lookup(GList *list, const char *path,
 						const char *interface)
 {
 	GList *l;
@@ -360,8 +360,11 @@ static GDBusProxy *proxy_lookup(GList *list, const char *path,
 	for (l = g_list_first(list); l; l = g_list_next(l)) {
 		GDBusProxy *proxy = l->data;
 
-		if (g_str_equal(proxy->interface, interface) == TRUE &&
-				g_str_equal(proxy->obj_path, path) == TRUE)
+		const char *proxy_iface = g_dbus_proxy_get_interface(proxy);
+		const char *proxy_path = g_dbus_proxy_get_path(proxy);
+
+		if (g_str_equal(proxy_iface, interface) == TRUE &&
+			g_str_equal(proxy_path, path) == TRUE)
 			return proxy;
         }
 
@@ -519,7 +522,7 @@ GDBusProxy *g_dbus_proxy_new(GDBusClient *client, const char *path,
 	if (client == NULL)
 		return NULL;
 
-	proxy = proxy_lookup(client->proxy_list, path, interface);
+	proxy = g_dbus_proxy_lookup(client->proxy_list, path, interface);
 	if (proxy)
 		return g_dbus_proxy_ref(proxy);
 
@@ -992,7 +995,7 @@ static void parse_properties(GDBusClient *client, const char *path,
 	if (g_str_equal(interface, DBUS_INTERFACE_PROPERTIES) == TRUE)
 		return;
 
-	proxy = proxy_lookup(client->proxy_list, path, interface);
+	proxy = g_dbus_proxy_lookup(client->proxy_list, path, interface);
 	if (proxy && !proxy->pending) {
 		update_properties(proxy, iter, FALSE);
 		return;
diff --git a/gdbus/gdbus.h b/gdbus/gdbus.h
index e37385fa1..930aa5f77 100644
--- a/gdbus/gdbus.h
+++ b/gdbus/gdbus.h
@@ -339,6 +339,9 @@ const char *g_dbus_proxy_get_interface(GDBusProxy *proxy);
 gboolean g_dbus_proxy_get_property(GDBusProxy *proxy, const char *name,
 							DBusMessageIter *iter);
 
+GDBusProxy *g_dbus_proxy_lookup(GList *list, const char *path,
+						const char *interface);
+
 gboolean g_dbus_proxy_refresh_property(GDBusProxy *proxy, const char *name);
 
 typedef void (* GDBusResultFunction) (const DBusError *error, void *user_data);
-- 
2.14.1

