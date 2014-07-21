Return-Path: <cyrus@holtmann.org>
From: Bharat Panda <bharat.panda@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: cpgs@samsung.com, Bharat Panda <bharat.panda@samsung.com>
Subject: [PATCH ] tools: Add unregister gatt service
Date: Mon, 21 Jul 2014 14:50:33 +0530
Message-id: <1405934433-29723-1-git-send-email-bharat.panda@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Unregister gatt service on proxy disconnect and removes service
data on Unregister complete.
---
 tools/gatt-service.c | 77 ++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 75 insertions(+), 2 deletions(-)

diff --git a/tools/gatt-service.c b/tools/gatt-service.c
index 6bca404..2102230 100644
--- a/tools/gatt-service.c
+++ b/tools/gatt-service.c
@@ -53,6 +53,8 @@ static GMainLoop *main_loop;
 static GSList *services;
 static DBusConnection *connection;
 
+static int id;
+
 struct characteristic {
 	char *uuid;
 	char *path;
@@ -332,10 +334,10 @@ static gboolean register_characteristic(const char *chr_uuid,
 
 static char *register_service(const char *uuid)
 {
-	static int id = 1;
 	char *path;
 
-	path = g_strdup_printf("/service%d", id++);
+	id++;
+	path = g_strdup_printf("/service%d", id);
 	if (!g_dbus_register_interface(connection, path, GATT_SERVICE_IFACE,
 				NULL, NULL, service_properties,
 				g_strdup(uuid), g_free)) {
@@ -373,6 +375,40 @@ static void create_services()
 	printf("Registered service: %s\n", service_path);
 }
 
+static void remove_services()
+{
+	char *service_path = g_strdup_printf("/service%d", id);;
+
+	services = g_slist_remove(services, service_path);
+	g_dbus_unregister_interface(connection, service_path,
+						GATT_SERVICE_IFACE);
+
+	printf("Unregistered: %s\n", service_path);
+	g_free(service_path);
+}
+
+static void unregister_external_service_reply(DBusPendingCall *call,
+							void *user_data)
+{
+	DBusMessage *reply = dbus_pending_call_steal_reply(call);
+	DBusError derr;
+
+	dbus_error_init(&derr);
+	dbus_set_error_from_message(&derr, reply);
+
+	if (dbus_error_is_set(&derr)) {
+		printf("UnRegisterService: %s\n", derr.message);
+		goto done;
+	}
+
+	printf("UnRegisterService: OK\n");
+	remove_services();
+
+done:
+	dbus_message_unref(reply);
+	dbus_error_free(&derr);
+}
+
 static void register_external_service_reply(DBusPendingCall *call,
 							void *user_data)
 {
@@ -391,6 +427,37 @@ static void register_external_service_reply(DBusPendingCall *call,
 	dbus_error_free(&derr);
 }
 
+static void unregister_external_service(gpointer a, gpointer b)
+{
+	DBusConnection *conn = b;
+	const char *path = a;
+	DBusMessage *msg;
+	DBusPendingCall *call;
+	DBusMessageIter iter;
+
+	msg = dbus_message_new_method_call("org.bluez", "/org/bluez",
+					GATT_MGR_IFACE, "UnregisterService");
+	if (!msg) {
+		printf("Couldn't allocate D-Bus message\n");
+		return;
+	}
+
+	dbus_message_iter_init_append(msg, &iter);
+
+	dbus_message_iter_append_basic(&iter, DBUS_TYPE_OBJECT_PATH, &path);
+
+	if (!g_dbus_send_message_with_reply(conn, msg, &call, -1)) {
+		dbus_message_unref(msg);
+		return;
+	}
+
+	dbus_message_unref(msg);
+
+	dbus_pending_call_set_notify(call, unregister_external_service_reply,
+								NULL, NULL);
+	dbus_pending_call_unref(call);
+}
+
 static void register_external_service(gpointer a, gpointer b)
 {
 	DBusConnection *conn = b;
@@ -432,6 +499,11 @@ static void connect_handler(DBusConnection *conn, void *user_data)
 	g_slist_foreach(services, register_external_service, conn);
 }
 
+static void disconnect_handler(DBusConnection *conn, void *user_data)
+{
+	g_slist_foreach(services, unregister_external_service, conn);
+}
+
 static gboolean signal_handler(GIOChannel *channel, GIOCondition cond,
 							gpointer user_data)
 {
@@ -524,6 +596,7 @@ int main(int argc, char *argv[])
 	client = g_dbus_client_new(connection, "org.bluez", "/org/bluez");
 
 	g_dbus_client_set_connect_watch(client, connect_handler, NULL);
+	g_dbus_client_set_disconnect_watch(client, disconnect_handler, NULL);
 
 	g_main_loop_run(main_loop);
 
-- 
1.9.1

