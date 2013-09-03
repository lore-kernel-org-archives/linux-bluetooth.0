Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 02/10 v3] unit: Add gdbus/client_check_order
Date: Tue,  3 Sep 2013 14:21:11 +0300
Message-Id: <1378207279-14557-3-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1378207279-14557-1-git-send-email-luiz.dentz@gmail.com>
References: <1378207279-14557-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 unit/test-gdbus-client.c | 71 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 71 insertions(+)

diff --git a/unit/test-gdbus-client.c b/unit/test-gdbus-client.c
index a594384..488d4ec 100644
--- a/unit/test-gdbus-client.c
+++ b/unit/test-gdbus-client.c
@@ -35,6 +35,7 @@ struct context {
 	GMainLoop *main_loop;
 	DBusConnection *dbus_conn;
 	GDBusClient *dbus_client;
+	GDBusProxy *proxy;
 	void *data;
 	guint timeout_source;
 };
@@ -779,6 +780,74 @@ static void client_string_changed(void)
 	destroy_context(context);
 }
 
+static void property_check_order(const DBusError *err, void *user_data)
+{
+	struct context *context = user_data;
+	GDBusProxy *proxy = context->proxy;
+	DBusMessageIter iter;
+	const char *string;
+
+	g_assert(!dbus_error_is_set(err));
+
+	g_assert(g_dbus_proxy_get_property(proxy, "String", &iter));
+
+	dbus_message_iter_get_basic(&iter, &string);
+	g_assert(g_strcmp0(string, "value1") == 0);
+
+	g_dbus_client_unref(context->dbus_client);
+}
+
+static void proxy_check_order(GDBusProxy *proxy, void *user_data)
+{
+	struct context *context = user_data;
+	const char *string;
+
+	if (g_test_verbose())
+		g_print("proxy %s found\n",
+					g_dbus_proxy_get_interface(proxy));
+
+	context->proxy = proxy;
+	string = "value1";
+	g_assert(g_dbus_proxy_set_property_basic(proxy, "String",
+					DBUS_TYPE_STRING, &string,
+					property_check_order, context,
+					NULL));
+}
+
+static void client_check_order(void)
+{
+	struct context *context = create_context();
+	static const GDBusPropertyTable string_properties[] = {
+		{ "String", "s", get_string, set_string, string_exists },
+		{ },
+	};
+
+	if (context == NULL)
+		return;
+
+	context->data = g_strdup("value");
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
+						proxy_check_order, NULL, NULL,
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
@@ -809,5 +878,7 @@ int main(int argc, char *argv[])
 	g_test_add_func("/gdbus/client_string_changed",
 						client_string_changed);
 
+	g_test_add_func("/gdbus/client_check_order", client_check_order);
+
 	return g_test_run();
 }
-- 
1.8.3.1

