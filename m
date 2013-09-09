Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 7/8] gdbus/client: Use g_dbus_add_signal_watch to track signals
Date: Mon,  9 Sep 2013 17:49:38 +0300
Message-Id: <1378738179-21047-7-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1378738179-21047-1-git-send-email-luiz.dentz@gmail.com>
References: <1378738179-21047-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This make the handling much simpler and avoids duplicates of the same
match rule.
---
 gdbus/client.c | 73 +++++++++++++++++++++++++++++-----------------------------
 1 file changed, 37 insertions(+), 36 deletions(-)

diff --git a/gdbus/client.c b/gdbus/client.c
index 7a14d7e..01d7d02 100644
--- a/gdbus/client.c
+++ b/gdbus/client.c
@@ -25,6 +25,7 @@
 #include <config.h>
 #endif
 
+#include <stdio.h>
 #include <glib.h>
 #include <dbus/dbus.h>
 
@@ -32,12 +33,18 @@
 
 #define METHOD_CALL_TIMEOUT (300 * 1000)
 
+#ifndef DBUS_INTERFACE_OBJECT_MANAGER
+#define DBUS_INTERFACE_OBJECT_MANAGER DBUS_INTERFACE_DBUS ".ObjectManager"
+#endif
+
 struct GDBusClient {
 	int ref_count;
 	DBusConnection *dbus_conn;
 	char *service_name;
 	char *base_path;
 	guint watch;
+	guint added_watch;
+	guint removed_watch;
 	GPtrArray *match_rules;
 	DBusPendingCall *pending_call;
 	DBusPendingCall *get_objects_call;
@@ -908,16 +915,18 @@ static void parse_interfaces(GDBusClient *client, const char *path,
 	}
 }
 
-static void interfaces_added(GDBusClient *client, DBusMessage *msg)
+static gboolean interfaces_added(DBusConnection *conn, DBusMessage *msg,
+							void *user_data)
 {
+	GDBusClient *client = user_data;
 	DBusMessageIter iter;
 	const char *path;
 
 	if (dbus_message_iter_init(msg, &iter) == FALSE)
-		return;
+		return TRUE;
 
 	if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_OBJECT_PATH)
-		return;
+		return TRUE;
 
 	dbus_message_iter_get_basic(&iter, &path);
 	dbus_message_iter_next(&iter);
@@ -927,24 +936,28 @@ static void interfaces_added(GDBusClient *client, DBusMessage *msg)
 	parse_interfaces(client, path, &iter);
 
 	g_dbus_client_unref(client);
+
+	return TRUE;
 }
 
-static void interfaces_removed(GDBusClient *client, DBusMessage *msg)
+static gboolean interfaces_removed(DBusConnection *conn, DBusMessage *msg,
+							void *user_data)
 {
+	GDBusClient *client = user_data;
 	DBusMessageIter iter, entry;
 	const char *path;
 
 	if (dbus_message_iter_init(msg, &iter) == FALSE)
-		return;
+		return TRUE;
 
 	if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_OBJECT_PATH)
-		return;
+		return TRUE;
 
 	dbus_message_iter_get_basic(&iter, &path);
 	dbus_message_iter_next(&iter);
 
 	if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_ARRAY)
-		return;
+		return TRUE;
 
 	dbus_message_iter_recurse(&iter, &entry);
 
@@ -959,6 +972,8 @@ static void interfaces_removed(GDBusClient *client, DBusMessage *msg)
 	}
 
 	g_dbus_client_unref(client);
+
+	return TRUE;
 }
 
 static void parse_managed_objects(GDBusClient *client, DBusMessage *msg)
@@ -1093,24 +1108,6 @@ static DBusHandlerResult message_filter(DBusConnection *connection,
 	interface = dbus_message_get_interface(message);
 	member = dbus_message_get_member(message);
 
-	if (g_str_equal(path, "/") == TRUE) {
-		if (g_str_equal(interface, DBUS_INTERFACE_DBUS
-						".ObjectManager") == FALSE)
-			return DBUS_HANDLER_RESULT_NOT_YET_HANDLED;
-
-		if (g_str_equal(member, "InterfacesAdded") == TRUE) {
-			interfaces_added(client, message);
-			return DBUS_HANDLER_RESULT_NOT_YET_HANDLED;
-		}
-
-		if (g_str_equal(member, "InterfacesRemoved") == TRUE) {
-			interfaces_removed(client, message);
-			return DBUS_HANDLER_RESULT_NOT_YET_HANDLED;
-		}
-
-		return DBUS_HANDLER_RESULT_NOT_YET_HANDLED;
-	}
-
 	if (g_str_has_prefix(path, client->base_path) == FALSE)
 		return DBUS_HANDLER_RESULT_NOT_YET_HANDLED;
 
@@ -1150,23 +1147,25 @@ GDBusClient *g_dbus_client_new(DBusConnection *connection,
 	client->service_name = g_strdup(service);
 	client->base_path = g_strdup(path);
 
-	client->match_rules = g_ptr_array_sized_new(3);
+	client->match_rules = g_ptr_array_sized_new(1);
 	g_ptr_array_set_free_func(client->match_rules, g_free);
 
 	client->watch = g_dbus_add_service_watch(connection, service,
 						service_connect,
 						service_disconnect,
 						client, NULL);
-	g_ptr_array_add(client->match_rules, g_strdup_printf("type='signal',"
-				"sender='%s',"
-				"path='/',interface='%s.ObjectManager',"
-				"member='InterfacesAdded'",
-				client->service_name, DBUS_INTERFACE_DBUS));
-	g_ptr_array_add(client->match_rules, g_strdup_printf("type='signal',"
-				"sender='%s',"
-				"path='/',interface='%s.ObjectManager',"
-				"member='InterfacesRemoved'",
-				client->service_name, DBUS_INTERFACE_DBUS));
+	client->added_watch = g_dbus_add_signal_watch(connection, service,
+						"/",
+						DBUS_INTERFACE_OBJECT_MANAGER,
+						"InterfacesAdded",
+						interfaces_added,
+						client, NULL);
+	client->removed_watch = g_dbus_add_signal_watch(connection, service,
+						"/",
+						DBUS_INTERFACE_OBJECT_MANAGER,
+						"InterfacesRemoved",
+						interfaces_removed,
+						client, NULL);
 	g_ptr_array_add(client->match_rules, g_strdup_printf("type='signal',"
 				"sender='%s',path_namespace='%s'",
 				client->service_name, client->base_path));
@@ -1225,6 +1224,8 @@ void g_dbus_client_unref(GDBusClient *client)
 		client->disconn_func(client->dbus_conn, client->disconn_data);
 
 	g_dbus_remove_watch(client->dbus_conn, client->watch);
+	g_dbus_remove_watch(client->dbus_conn, client->added_watch);
+	g_dbus_remove_watch(client->dbus_conn, client->removed_watch);
 
 	dbus_connection_unref(client->dbus_conn);
 
-- 
1.8.3.1

