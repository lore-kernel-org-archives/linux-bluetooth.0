Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/2] unit/test-dbus-client: Add client_no_object_manager test
Date: Tue, 24 Mar 2015 14:10:32 +0200
Message-Id: <1427199032-23492-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1427199032-23492-1-git-send-email-luiz.dentz@gmail.com>
References: <1427199032-23492-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Michael Janssen <jamuraa@chromium.org>

Adds a test for the functionality of g_dbus_client_new_full passing NULL
as root_path.
---
 unit/test-gdbus-client.c | 55 +++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 54 insertions(+), 1 deletion(-)

diff --git a/unit/test-gdbus-client.c b/unit/test-gdbus-client.c
index 11ad1f7..ad426fe 100644
--- a/unit/test-gdbus-client.c
+++ b/unit/test-gdbus-client.c
@@ -353,7 +353,7 @@ static void proxy_get_string(GDBusProxy *proxy, void *user_data)
 	g_assert(dbus_message_iter_get_arg_type(&iter) == DBUS_TYPE_STRING);
 
 	dbus_message_iter_get_basic(&iter, &string);
-	g_assert(g_strcmp0(string, "value") == 0);
+	g_assert_cmpstr(string, ==, "value");
 
 	g_dbus_client_unref(context->dbus_client);
 }
@@ -908,6 +908,56 @@ static void client_proxy_removed(void)
 	destroy_context(context);
 }
 
+static void client_no_object_manager(void)
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
+	context->data = g_strdup("value");
+
+	g_dbus_register_interface(conn,
+				SERVICE_PATH, SERVICE_NAME1,
+				methods, signals, string_properties,
+				context, NULL);
+
+	context->dbus_client = g_dbus_client_new_full(context->dbus_conn,
+						SERVICE_NAME1, SERVICE_PATH,
+						NULL);
+
+	g_dbus_client_set_disconnect_watch(context->dbus_client,
+						disconnect_handler, context);
+
+	context->proxy = g_dbus_proxy_new(context->dbus_client, SERVICE_PATH,
+								SERVICE_NAME1);
+
+	g_dbus_client_set_proxy_handlers(context->dbus_client, proxy_get_string,
+						NULL, NULL, context);
+
+	g_assert(!g_dbus_proxy_get_property(context->proxy, "String", &iter));
+
+	g_main_loop_run(context->main_loop);
+
+	g_dbus_proxy_unref(context->proxy);
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
@@ -1051,6 +1101,9 @@ int main(int argc, char *argv[])
 
 	g_test_add_func("/gdbus/client_proxy_removed", client_proxy_removed);
 
+	g_test_add_func("/gdbus/client_no_object_manager",
+						client_no_object_manager);
+
 	g_test_add_func("/gdbus/client_force_disconnect",
 						client_force_disconnect);
 
-- 
2.1.0

