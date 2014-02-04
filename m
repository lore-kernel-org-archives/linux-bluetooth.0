Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: claudio.takahasi@openbossa.org
Subject: [PATCH BlueZ v6 15/18] test: Add registering external service
Date: Tue,  4 Feb 2014 14:53:46 -0300
Message-Id: <1391536429-8345-16-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1391536429-8345-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1390854924-31904-1-git-send-email-claudio.takahasi@openbossa.org>
 <1391536429-8345-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch extends gatt-service to call RegisterService() when org.bluez
service gets connected to the system bus.
---
 test/gatt-service.c | 67 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 67 insertions(+)

diff --git a/test/gatt-service.c b/test/gatt-service.c
index 4059336..b656ef3 100644
--- a/test/gatt-service.c
+++ b/test/gatt-service.c
@@ -35,6 +35,7 @@
 #include <dbus/dbus.h>
 #include <gdbus/gdbus.h>
 
+#define GATT_MGR_IFACE			"org.bluez.GattManager1"
 #define SERVICE_IFACE			"org.bluez.GattService1"
 
 /* Immediate Alert Service UUID */
@@ -100,6 +101,65 @@ static void create_services(DBusConnection *conn)
 	printf("Registered service: %s\n", service_path);
 }
 
+static void register_external_service_reply(DBusPendingCall *call,
+							void *user_data)
+{
+	DBusMessage *reply = dbus_pending_call_steal_reply(call);
+	DBusError derr;
+
+	dbus_error_init(&derr);
+	dbus_set_error_from_message(&derr, reply);
+
+	if (dbus_error_is_set(&derr))
+		printf("RegisterService: %s\n", derr.message);
+	else
+		printf("RegisterService: OK\n");
+
+	dbus_message_unref(reply);
+	dbus_error_free(&derr);
+}
+
+static void register_external_service(gpointer a, gpointer b)
+{
+	DBusConnection *conn = b;
+	const char *path = a;
+	DBusMessage *msg;
+	DBusPendingCall *call;
+	DBusMessageIter iter, dict;
+
+	msg = dbus_message_new_method_call("org.bluez", "/org/bluez",
+					GATT_MGR_IFACE, "RegisterService");
+	if (msg == NULL) {
+		printf("Couldn't allocate D-Bus message\n");
+		return;
+	}
+
+	dbus_message_iter_init_append(msg, &iter);
+
+	dbus_message_iter_append_basic(&iter, DBUS_TYPE_OBJECT_PATH, &path);
+
+	dbus_message_iter_open_container(&iter, DBUS_TYPE_ARRAY, "{sv}", &dict);
+
+	/* TODO: Add options dictionary */
+
+	dbus_message_iter_close_container(&iter, &dict);
+
+	if (g_dbus_send_message_with_reply(conn, msg, &call, -1) == FALSE) {
+		dbus_message_unref(msg);
+		return;
+	}
+
+	dbus_pending_call_set_notify(call, register_external_service_reply,
+								NULL, NULL);
+
+	dbus_pending_call_unref(call);
+}
+
+static void connect_handler(DBusConnection *conn, void *user_data)
+{
+	g_slist_foreach(services, register_external_service, conn);
+}
+
 static gboolean signal_handler(GIOChannel *channel, GIOCondition cond,
 							gpointer user_data)
 {
@@ -171,6 +231,7 @@ static guint setup_signalfd(void)
 
 int main(int argc, char *argv[])
 {
+	GDBusClient *client;
 	DBusConnection *dbus_conn;
 	guint signal;
 
@@ -189,8 +250,14 @@ int main(int argc, char *argv[])
 
 	create_services(dbus_conn);
 
+	client = g_dbus_client_new(dbus_conn, "org.bluez", "/org/bluez");
+
+	g_dbus_client_set_connect_watch(client, connect_handler, NULL);
+
 	g_main_loop_run(main_loop);
 
+	g_dbus_client_unref(client);
+
 	g_source_remove(signal);
 
 	g_slist_free_full(services, g_free);
-- 
1.8.3.1

