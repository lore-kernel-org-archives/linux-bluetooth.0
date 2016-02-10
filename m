Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/2] tools/gatt-service: Fix using RegisterService
Date: Wed, 10 Feb 2016 14:36:32 +0200
Message-Id: <1455107793-23010-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

RegisterService no longer exists as it was replaced with
RegisterApplication, also the path being used is wrong since GattManager
interface is available per adapter path.
---
 tools/gatt-service.c | 63 +++++++++++++++++++++++-----------------------------
 1 file changed, 28 insertions(+), 35 deletions(-)

diff --git a/tools/gatt-service.c b/tools/gatt-service.c
index 9baa9e1..74f934e 100644
--- a/tools/gatt-service.c
+++ b/tools/gatt-service.c
@@ -372,63 +372,55 @@ static void create_services()
 	printf("Registered service: %s\n", service_path);
 }
 
-static void register_external_service_reply(DBusPendingCall *call,
-							void *user_data)
+static void register_app_reply(DBusMessage *reply, void *user_data)
 {
-	DBusMessage *reply = dbus_pending_call_steal_reply(call);
 	DBusError derr;
 
 	dbus_error_init(&derr);
 	dbus_set_error_from_message(&derr, reply);
 
 	if (dbus_error_is_set(&derr))
-		printf("RegisterService: %s\n", derr.message);
+		printf("RegisterApplication: %s\n", derr.message);
 	else
-		printf("RegisterService: OK\n");
+		printf("RegisterApplication: OK\n");
 
-	dbus_message_unref(reply);
 	dbus_error_free(&derr);
 }
 
-static void register_external_service(gpointer a, gpointer b)
+static void register_app_setup(DBusMessageIter *iter, void *user_data)
 {
-	DBusConnection *conn = b;
-	const char *path = a;
-	DBusMessage *msg;
-	DBusPendingCall *call;
-	DBusMessageIter iter, dict;
-
-	msg = dbus_message_new_method_call("org.bluez", "/org/bluez",
-					GATT_MGR_IFACE, "RegisterService");
-	if (!msg) {
-		printf("Couldn't allocate D-Bus message\n");
-		return;
-	}
+	const char *path = "/";
+	DBusMessageIter dict;
 
-	dbus_message_iter_init_append(msg, &iter);
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_OBJECT_PATH, &path);
 
-	dbus_message_iter_append_basic(&iter, DBUS_TYPE_OBJECT_PATH, &path);
-
-	dbus_message_iter_open_container(&iter, DBUS_TYPE_ARRAY, "{sv}", &dict);
+	dbus_message_iter_open_container(iter, DBUS_TYPE_ARRAY, "{sv}", &dict);
 
 	/* TODO: Add options dictionary */
 
-	dbus_message_iter_close_container(&iter, &dict);
+	dbus_message_iter_close_container(iter, &dict);
+}
 
-	if (!g_dbus_send_message_with_reply(conn, msg, &call, -1)) {
-		dbus_message_unref(msg);
+static void register_app(GDBusProxy *proxy)
+{
+	if (!g_dbus_proxy_method_call(proxy, "RegisterApplication",
+					register_app_setup, register_app_reply,
+					NULL, NULL)) {
+		printf("Unable to call RegisterApplication\n");
 		return;
 	}
-
-	dbus_pending_call_set_notify(call, register_external_service_reply,
-								NULL, NULL);
-
-	dbus_pending_call_unref(call);
 }
 
-static void connect_handler(DBusConnection *conn, void *user_data)
+static void proxy_added_cb(GDBusProxy *proxy, void *user_data)
 {
-	g_slist_foreach(services, register_external_service, conn);
+	const char *iface;
+
+	iface = g_dbus_proxy_get_interface(proxy);
+
+	if (g_strcmp0(iface, GATT_MGR_IFACE))
+		return;
+
+	register_app(proxy);
 }
 
 static gboolean signal_handler(GIOChannel *channel, GIOCondition cond,
@@ -520,9 +512,10 @@ int main(int argc, char *argv[])
 
 	create_services();
 
-	client = g_dbus_client_new(connection, "org.bluez", "/org/bluez");
+	client = g_dbus_client_new(connection, "org.bluez", "/");
 
-	g_dbus_client_set_connect_watch(client, connect_handler, NULL);
+	g_dbus_client_set_proxy_handlers(client, proxy_added_cb, NULL, NULL,
+									NULL);
 
 	g_main_loop_run(main_loop);
 
-- 
2.5.0

