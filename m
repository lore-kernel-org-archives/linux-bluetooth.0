Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ v0 1/9] gdbus: Add g_dbus_client_set_proxies_ready_watch()
Date: Fri, 28 Feb 2014 14:05:28 -0300
Message-Id: <1393607136-16908-2-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1393607136-16908-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1393607136-16908-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds a new gdbus helper to notify the clients that
GetManagedObjects reply was received and the last proxy has been
informed previously by the proxy_added callback.
---
 gdbus/client.c | 18 ++++++++++++++++++
 gdbus/gdbus.h  |  4 ++++
 2 files changed, 22 insertions(+)

diff --git a/gdbus/client.c b/gdbus/client.c
index be8cc29..f479742 100644
--- a/gdbus/client.c
+++ b/gdbus/client.c
@@ -56,6 +56,8 @@ struct GDBusClient {
 	void *signal_data;
 	GDBusProxyFunction proxy_added;
 	GDBusProxyFunction proxy_removed;
+	GDBusClientReadyFunction ready;
+	void *ready_data;
 	GDBusPropertyFunction property_changed;
 	void *user_data;
 	GList *proxy_list;
@@ -982,6 +984,9 @@ static void parse_managed_objects(GDBusClient *client, DBusMessage *msg)
 
 		dbus_message_iter_next(&dict);
 	}
+
+	if (client->ready)
+		client->ready(client->ready_data);
 }
 
 static void get_managed_objects_reply(DBusPendingCall *call, void *user_data)
@@ -1261,3 +1266,16 @@ gboolean g_dbus_client_set_proxy_handlers(GDBusClient *client,
 
 	return TRUE;
 }
+
+gboolean g_dbus_client_set_proxies_ready_watch(GDBusClient *client,
+						GDBusClientReadyFunction ready,
+						void *user_data)
+{
+	if (client == NULL)
+		return FALSE;
+
+	client->ready = ready;
+	client->ready_data = user_data;
+
+	return TRUE;
+}
diff --git a/gdbus/gdbus.h b/gdbus/gdbus.h
index 9542109..aa407aa 100644
--- a/gdbus/gdbus.h
+++ b/gdbus/gdbus.h
@@ -337,6 +337,7 @@ gboolean g_dbus_proxy_method_call(GDBusProxy *proxy, const char *method,
 				GDBusReturnFunction function, void *user_data,
 				GDBusDestroyFunction destroy);
 
+typedef void (* GDBusClientReadyFunction) (void *user_data);
 typedef void (* GDBusProxyFunction) (GDBusProxy *proxy, void *user_data);
 typedef void (* GDBusPropertyFunction) (GDBusProxy *proxy, const char *name,
 					DBusMessageIter *iter, void *user_data);
@@ -365,6 +366,9 @@ gboolean g_dbus_client_set_proxy_handlers(GDBusClient *client,
 					GDBusProxyFunction proxy_removed,
 					GDBusPropertyFunction property_changed,
 					void *user_data);
+gboolean g_dbus_client_set_proxies_ready_watch(GDBusClient *client,
+						GDBusClientReadyFunction ready,
+						void *user_data);
 
 #ifdef __cplusplus
 }
-- 
1.8.3.1

