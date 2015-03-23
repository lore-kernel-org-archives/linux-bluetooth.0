Return-Path: <cyrus@holtmann.org>
From: Michael Janssen <jamuraa@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Michael Janssen <jamuraa@chromium.org>
Subject: [BlueZ v4 04/15] unit/test-dbus-client: test for g_dbus_set_ready_watch
Date: Mon, 23 Mar 2015 08:10:56 -0700
Message-Id: <1427123467-13445-5-git-send-email-jamuraa@chromium.org>
In-Reply-To: <1427123467-13445-1-git-send-email-jamuraa@chromium.org>
References: <1427123467-13445-1-git-send-email-jamuraa@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Adds a test for the functionality of g_dbus_set_ready_watch.
---
 unit/test-gdbus-client.c | 66 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 66 insertions(+)

diff --git a/unit/test-gdbus-client.c b/unit/test-gdbus-client.c
index 11ad1f7..e2ab9cf 100644
--- a/unit/test-gdbus-client.c
+++ b/unit/test-gdbus-client.c
@@ -908,6 +908,70 @@ static void client_proxy_removed(void)
 	destroy_context(context);
 }
 
+static void proxy_ready(GDBusProxy *proxy, void *user_data)
+{
+	struct context *context = user_data;
+	DBusMessageIter iter;
+	const char *string;
+
+	if (g_test_verbose())
+		g_print("proxy for %s ready\n",
+					g_dbus_proxy_get_interface(proxy));
+
+	g_assert(context->proxy == proxy);
+
+	g_assert(g_dbus_proxy_get_property(proxy, "String", &iter));
+
+	dbus_message_iter_get_basic(&iter, &string);
+	g_assert(g_strcmp0(string, "value1") == 0);
+
+	g_main_loop_quit(context->main_loop);
+}
+
+static void client_proxy_ready(void)
+{
+	struct context *context = create_context();
+	DBusConnection *conn;
+	DBusMessageIter iter;
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
+	context->data = g_strdup("value1");
+
+	g_dbus_register_interface(conn,
+				SERVICE_PATH, SERVICE_NAME1,
+				methods, signals, string_properties,
+				context, NULL);
+
+	context->dbus_client = g_dbus_client_new(context->dbus_conn,
+						SERVICE_NAME1, SERVICE_PATH);
+
+	context->proxy = g_dbus_proxy_new(context->dbus_client, SERVICE_PATH,
+								SERVICE_NAME1);
+
+	g_dbus_proxy_set_ready_watch(context->proxy, proxy_ready, context);
+
+	g_assert(!g_dbus_proxy_get_property(context->proxy, "String", &iter));
+
+	g_main_loop_run(context->main_loop);
+
+	g_dbus_unregister_interface(conn, SERVICE_PATH, SERVICE_NAME1);
+
+	dbus_connection_flush(conn);
+	dbus_connection_close(conn);
+	dbus_connection_unref(conn);
+
+	destroy_context(context);
+}
+
 static void proxy_force_disconnect(GDBusProxy *proxy, void *user_data)
 {
 	struct context *context = user_data;
@@ -1051,6 +1115,8 @@ int main(int argc, char *argv[])
 
 	g_test_add_func("/gdbus/client_proxy_removed", client_proxy_removed);
 
+	g_test_add_func("/gdbus/client_proxy_ready", client_proxy_ready);
+
 	g_test_add_func("/gdbus/client_force_disconnect",
 						client_force_disconnect);
 
-- 
2.2.0.rc0.207.ga3a616c

