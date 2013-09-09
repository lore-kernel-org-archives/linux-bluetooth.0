Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/8] unit: Add gdbus/client_force_disconnect
Date: Mon,  9 Sep 2013 17:49:33 +0300
Message-Id: <1378738179-21047-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1378738179-21047-1-git-send-email-luiz.dentz@gmail.com>
References: <1378738179-21047-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This tests if watches created using g_dbus_proxy_set_removed_watch works
when the service disconnects from the bus.
---
 unit/test-gdbus-client.c | 59 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/unit/test-gdbus-client.c b/unit/test-gdbus-client.c
index 30b0ce3..685729a 100644
--- a/unit/test-gdbus-client.c
+++ b/unit/test-gdbus-client.c
@@ -29,6 +29,7 @@
 #include <gdbus.h>
 
 #define SERVICE_NAME "org.bluez.unit.test-gdbus-client"
+#define SERVICE_NAME1 "org.bluez.unit.test-gdbus-client1"
 #define SERVICE_PATH "/org/bluez/unit/test_gdbus_client"
 
 struct context {
@@ -903,6 +904,61 @@ static void client_proxy_removed(void)
 	destroy_context(context);
 }
 
+static void proxy_force_disconnect(GDBusProxy *proxy, void *user_data)
+{
+	struct context *context = user_data;
+	DBusConnection *conn = context->data;
+
+	if (g_test_verbose())
+		g_print("proxy %s found\n",
+					g_dbus_proxy_get_interface(proxy));
+
+	g_assert(g_dbus_proxy_set_removed_watch(proxy, proxy_removed, context));
+
+	context->timeout_source = g_timeout_add_seconds(2, timeout_test,
+								context);
+
+	dbus_connection_flush(conn);
+	dbus_connection_close(conn);
+	context->data = NULL;
+}
+
+static void client_force_disconnect(void)
+{
+	struct context *context = create_context();
+	DBusConnection *conn;
+	static const GDBusPropertyTable string_properties[] = {
+		{ "String", "s", get_string, set_string, string_exists },
+		{ },
+	};
+
+	if (context == NULL)
+		return;
+
+	conn = g_dbus_setup_private(DBUS_BUS_SESSION, SERVICE_NAME1, NULL);
+	g_assert(conn != NULL);
+
+	/* Avoid D-Bus library calling _exit() before next test finishes. */
+	dbus_connection_set_exit_on_disconnect(conn, FALSE);
+	g_dbus_attach_object_manager(conn);
+	context->data = conn;
+
+	g_dbus_register_interface(conn, SERVICE_PATH, SERVICE_NAME1,
+					methods, signals, string_properties,
+					context, NULL);
+
+	context->dbus_client = g_dbus_client_new(context->dbus_conn,
+						SERVICE_NAME1, SERVICE_PATH);
+
+	g_dbus_client_set_proxy_handlers(context->dbus_client,
+					proxy_force_disconnect, NULL, NULL,
+					context);
+
+	g_main_loop_run(context->main_loop);
+
+	destroy_context(context);
+}
+
 int main(int argc, char *argv[])
 {
 	g_test_init(&argc, &argv, NULL);
@@ -937,5 +993,8 @@ int main(int argc, char *argv[])
 
 	g_test_add_func("/gdbus/client_proxy_removed", client_proxy_removed);
 
+	g_test_add_func("/gdbus/client_force_disconnect",
+						client_force_disconnect);
+
 	return g_test_run();
 }
-- 
1.8.3.1

