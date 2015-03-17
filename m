Return-Path: <cyrus@holtmann.org>
From: Michael Janssen <jamuraa@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Michael Janssen <jamuraa@chromium.org>
Subject: [BlueZ v2 03/14] gdbus/client: add g_dbus_proxy_set_read_watch
Date: Tue, 17 Mar 2015 16:49:50 -0700
Message-Id: <1426636201-30057-4-git-send-email-jamuraa@chromium.org>
In-Reply-To: <1426636201-30057-1-git-send-email-jamuraa@chromium.org>
References: <1426636201-30057-1-git-send-email-jamuraa@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Adds a new gdbus utility function which will set a function to be called
after the properties of a proxy are updated.

This enables using GDBusClient for objects without the ObjectManager
interface as long as you know in advance the object path using
g_dbus_proxy_new
---
 gdbus/client.c | 17 +++++++++++++++++
 gdbus/gdbus.h  |  3 +++
 2 files changed, 20 insertions(+)

diff --git a/gdbus/client.c b/gdbus/client.c
index fe0c0db..c913773 100644
--- a/gdbus/client.c
+++ b/gdbus/client.c
@@ -76,6 +76,8 @@ struct GDBusProxy {
 	void *prop_data;
 	GDBusProxyFunction removed_func;
 	void *removed_data;
+	GDBusProxyFunction read_func;
+	void *read_data;
 };
 
 struct prop_entry {
@@ -297,6 +299,9 @@ static void get_all_properties_reply(DBusPendingCall *call, void *user_data)
 
 	update_properties(proxy, &iter, FALSE);
 
+	if (proxy->read_func)
+		proxy->read_func(proxy, proxy->read_data);
+
 done:
 	if (g_list_find(client->proxy_list, proxy) == NULL) {
 		if (client->proxy_added)
@@ -914,6 +919,18 @@ gboolean g_dbus_proxy_set_removed_watch(GDBusProxy *proxy,
 	return TRUE;
 }
 
+gboolean g_dbus_proxy_set_read_watch(GDBusProxy *proxy,
+				GDBusProxyFunction function, void *user_data)
+{
+	if (proxy == NULL)
+		return FALSE;
+
+	proxy->read_func = function;
+	proxy->read_data = user_data;
+
+	return TRUE;
+}
+
 static void refresh_properties(GDBusClient *client)
 {
 	GList *list;
diff --git a/gdbus/gdbus.h b/gdbus/gdbus.h
index 9814838..ae281d9 100644
--- a/gdbus/gdbus.h
+++ b/gdbus/gdbus.h
@@ -353,6 +353,9 @@ gboolean g_dbus_proxy_set_property_watch(GDBusProxy *proxy,
 gboolean g_dbus_proxy_set_removed_watch(GDBusProxy *proxy,
 			GDBusProxyFunction destroy, void *user_data);
 
+gboolean g_dbus_proxy_set_read_watch(GDBusProxy *proxy,
+			GDBusProxyFunction ready, void *user_data);
+
 GDBusClient *g_dbus_client_new(DBusConnection *connection,
 					const char *service, const char *path);
 GDBusClient *g_dbus_client_new_full(DBusConnection *connection,
-- 
2.2.0.rc0.207.ga3a616c

