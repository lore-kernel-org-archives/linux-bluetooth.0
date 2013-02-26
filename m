Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/3] unit: Add gdbus/client_string_changed
Date: Tue, 26 Feb 2013 16:31:56 +0200
Message-Id: <1361889117-18425-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1361889117-18425-1-git-send-email-luiz.dentz@gmail.com>
References: <1361889117-18425-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 unit/test-gdbus-client.c | 61 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/unit/test-gdbus-client.c b/unit/test-gdbus-client.c
index 679c27d..ed7a943 100644
--- a/unit/test-gdbus-client.c
+++ b/unit/test-gdbus-client.c
@@ -695,6 +695,64 @@ static void client_set_string_property(void)
 	destroy_context(context);
 }
 
+static gboolean string_exists(const GDBusPropertyTable *property, void *data)
+{
+	struct context *context = data;
+
+	return context->data != NULL;
+}
+
+static void proxy_string_changed(GDBusProxy *proxy, void *user_data)
+{
+	struct context *context = user_data;
+	DBusMessageIter iter;
+
+	if (g_test_verbose())
+		g_print("proxy %s found\n",
+					g_dbus_proxy_get_interface(proxy));
+
+	g_assert(!g_dbus_proxy_get_property(proxy, "String", &iter));
+
+	context->data = g_strdup("value1");
+
+	g_dbus_emit_property_changed(context->dbus_conn, SERVICE_PATH,
+						SERVICE_NAME, "String");
+}
+
+static void client_string_changed(void)
+{
+	struct context *context = create_context();
+	static const GDBusPropertyTable string_properties[] = {
+		{ "String", "s", get_string, NULL, string_exists },
+		{ },
+	};
+
+	if (context == NULL)
+		return;
+
+	g_dbus_register_interface(context->dbus_conn,
+				SERVICE_PATH, SERVICE_NAME,
+				methods, signals, string_properties,
+				context, NULL);
+
+	context->dbus_client = g_dbus_client_new(context->dbus_conn,
+						SERVICE_NAME, SERVICE_PATH);
+
+	g_dbus_client_set_disconnect_watch(context->dbus_client,
+						disconnect_handler, context);
+	g_dbus_client_set_proxy_handlers(context->dbus_client,
+						proxy_string_changed, NULL,
+						property_string_changed,
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
@@ -722,5 +780,8 @@ int main(int argc, char *argv[])
 	g_test_add_func("/gdbus/client_set_string_property",
 						client_set_string_property);
 
+	g_test_add_func("/gdbus/client_string_changed",
+						client_string_changed);
+
 	return g_test_run();
 }
-- 
1.8.1.2

