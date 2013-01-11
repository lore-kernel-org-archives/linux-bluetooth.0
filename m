Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/7] gdbus: Add g_dbus_client_get_proxy
Date: Fri, 11 Jan 2013 13:50:12 +0200
Message-Id: <1357905018-23237-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

g_dbus_client_get_proxy gives the possibilitity to just check if a
proxy exist for the given path and interface pair instead of using
g_dbus_proxy_new which end up creating a proxy if it doesn't exists
which is not always necessary.
---
 gdbus/client.c | 8 ++++----
 gdbus/gdbus.h  | 3 +++
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/gdbus/client.c b/gdbus/client.c
index c03e3a4..ea56023 100644
--- a/gdbus/client.c
+++ b/gdbus/client.c
@@ -328,8 +328,8 @@ static void get_all_properties(GDBusProxy *proxy)
 	dbus_message_unref(msg);
 }
 
-static GDBusProxy *proxy_lookup(GDBusClient *client, const char *path,
-						const char *interface)
+GDBusProxy *g_dbus_client_get_proxy(GDBusClient *client, const char *path,
+							const char *interface)
 {
 	GList *list;
 
@@ -423,7 +423,7 @@ GDBusProxy *g_dbus_proxy_new(GDBusClient *client, const char *path,
 	if (client == NULL)
 		return NULL;
 
-	proxy = proxy_lookup(client, path, interface);
+	proxy = g_dbus_client_get_proxy(client, path, interface);
 	if (proxy)
 		return g_dbus_proxy_ref(proxy);
 
@@ -841,7 +841,7 @@ static void parse_properties(GDBusClient *client, const char *path,
 	if (g_str_equal(interface, DBUS_INTERFACE_PROPERTIES) == TRUE)
 		return;
 
-	proxy = proxy_lookup(client, path, interface);
+	proxy = g_dbus_client_get_proxy(client, path, interface);
 	if (proxy) {
 		update_properties(proxy, iter);
 		return;
diff --git a/gdbus/gdbus.h b/gdbus/gdbus.h
index 6f5a012..77bd069 100644
--- a/gdbus/gdbus.h
+++ b/gdbus/gdbus.h
@@ -360,6 +360,9 @@ gboolean g_dbus_client_set_proxy_handlers(GDBusClient *client,
 					GDBusPropertyFunction property_changed,
 					void *user_data);
 
+GDBusProxy *g_dbus_client_get_proxy(GDBusClient *client, const char *path,
+							const char *interface);
+
 #ifdef __cplusplus
 }
 #endif
-- 
1.8.0.1

