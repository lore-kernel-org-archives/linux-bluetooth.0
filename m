Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 4/7] unit: Add gdbus/client_get_string_property
Date: Fri, 11 Jan 2013 13:50:15 +0200
Message-Id: <1357905018-23237-4-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1357905018-23237-1-git-send-email-luiz.dentz@gmail.com>
References: <1357905018-23237-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 unit/test-gdbus-client.c | 65 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/unit/test-gdbus-client.c b/unit/test-gdbus-client.c
index dac0cb5..bcdd811 100644
--- a/unit/test-gdbus-client.c
+++ b/unit/test-gdbus-client.c
@@ -328,6 +328,68 @@ static void client_get_dict_property(void)
 	destroy_context(context);
 }
 
+static void proxy_get_string(GDBusProxy *proxy, void *user_data)
+{
+	struct context *context = user_data;
+	DBusMessageIter iter;
+	const char *string;
+
+	if (g_test_verbose())
+		g_print("proxy %s found\n",
+					g_dbus_proxy_get_interface(proxy));
+
+	g_assert(g_dbus_proxy_get_property(proxy, "String", &iter));
+	g_assert(dbus_message_iter_get_arg_type(&iter) == DBUS_TYPE_STRING);
+
+	dbus_message_iter_get_basic(&iter, &string);
+	g_assert(g_strcmp0(string, "value") == 0);
+
+	g_dbus_client_unref(context->dbus_client);
+
+	g_main_loop_quit(context->main_loop);
+}
+
+static gboolean get_string(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	const char *string = "value";
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_STRING, &string);
+
+	return TRUE;
+}
+
+static void client_get_string_property(void)
+{
+	struct context *context = create_context();
+	static const GDBusPropertyTable string_properties[] = {
+		{ "String", "s", get_string },
+		{ },
+	};
+
+	if (context == NULL)
+		return;
+
+	g_dbus_register_interface(context->dbus_conn,
+				SERVICE_PATH, SERVICE_NAME,
+				methods, signals, string_properties,
+				NULL, NULL);
+
+	context->dbus_client = g_dbus_client_new(context->dbus_conn,
+						SERVICE_NAME, SERVICE_PATH);
+
+	g_dbus_client_set_proxy_handlers(context->dbus_client, proxy_get_string,
+						NULL, NULL,
+						context);
+
+	g_main_loop_run(context->main_loop);
+
+	g_dbus_unregister_interface(context->dbus_conn,
+					SERVICE_PATH, SERVICE_NAME);
+
+	destroy_context(context);
+}
+
 int main(int argc, char *argv[])
 {
 	g_test_init(&argc, &argv, NULL);
@@ -337,6 +399,9 @@ int main(int argc, char *argv[])
 	g_test_add_func("/gdbus/client_connect_disconnect",
 						client_connect_disconnect);
 
+	g_test_add_func("/gdbus/client_get_string_property",
+						client_get_string_property);
+
 	g_test_add_func("/gdbus/client_get_dict_property",
 						client_get_dict_property);
 
-- 
1.8.0.1

