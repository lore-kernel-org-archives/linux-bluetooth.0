Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 3/5] unit: Add gdbus/client_get_boolean_property
Date: Wed, 16 Jan 2013 15:54:38 +0200
Message-Id: <1358344480-23777-3-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1358344480-23777-1-git-send-email-luiz.dentz@gmail.com>
References: <1358344480-23777-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 unit/test-gdbus-client.c | 65 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/unit/test-gdbus-client.c b/unit/test-gdbus-client.c
index cf80087..ca82bad 100644
--- a/unit/test-gdbus-client.c
+++ b/unit/test-gdbus-client.c
@@ -392,6 +392,68 @@ static void client_get_string_property(void)
 	destroy_context(context);
 }
 
+static void proxy_get_boolean(GDBusProxy *proxy, void *user_data)
+{
+	struct context *context = user_data;
+	DBusMessageIter iter;
+	dbus_bool_t value;
+
+	if (g_test_verbose())
+		g_print("proxy %s found\n",
+					g_dbus_proxy_get_interface(proxy));
+
+	g_assert(g_dbus_proxy_get_property(proxy, "Boolean", &iter));
+	g_assert(dbus_message_iter_get_arg_type(&iter) == DBUS_TYPE_BOOLEAN);
+
+	dbus_message_iter_get_basic(&iter, &value);
+	g_assert(value == TRUE);
+
+	g_dbus_client_unref(context->dbus_client);
+}
+
+static gboolean get_boolean(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	dbus_bool_t value = TRUE;
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_BOOLEAN, &value);
+
+	return TRUE;
+}
+
+static void client_get_boolean_property(void)
+{
+	struct context *context = create_context();
+	static const GDBusPropertyTable boolean_properties[] = {
+		{ "Boolean", "b", get_boolean },
+		{ },
+	};
+
+	if (context == NULL)
+		return;
+
+	g_dbus_register_interface(context->dbus_conn,
+				SERVICE_PATH, SERVICE_NAME,
+				methods, signals, boolean_properties,
+				NULL, NULL);
+
+	context->dbus_client = g_dbus_client_new(context->dbus_conn,
+						SERVICE_NAME, SERVICE_PATH);
+
+	g_dbus_client_set_proxy_handlers(context->dbus_client,
+						proxy_get_boolean,
+						NULL, NULL, context);
+	g_dbus_client_set_disconnect_watch(context->dbus_client,
+						disconnect_handler, context);
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
@@ -404,6 +466,9 @@ int main(int argc, char *argv[])
 	g_test_add_func("/gdbus/client_get_string_property",
 						client_get_string_property);
 
+	g_test_add_func("/gdbus/client_get_boolean_property",
+						client_get_boolean_property);
+
 	g_test_add_func("/gdbus/client_get_dict_property",
 						client_get_dict_property);
 
-- 
1.8.0.2

