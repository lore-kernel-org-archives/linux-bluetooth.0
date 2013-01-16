Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 4/5] unit: Add gdbus/client_get_array_property
Date: Wed, 16 Jan 2013 15:54:39 +0200
Message-Id: <1358344480-23777-4-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1358344480-23777-1-git-send-email-luiz.dentz@gmail.com>
References: <1358344480-23777-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 unit/test-gdbus-client.c | 79 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 79 insertions(+)

diff --git a/unit/test-gdbus-client.c b/unit/test-gdbus-client.c
index ca82bad..534d8ce 100644
--- a/unit/test-gdbus-client.c
+++ b/unit/test-gdbus-client.c
@@ -454,6 +454,82 @@ static void client_get_boolean_property(void)
 	destroy_context(context);
 }
 
+static void proxy_get_array(GDBusProxy *proxy, void *user_data)
+{
+	struct context *context = user_data;
+	DBusMessageIter iter, entry;
+	const char *value1, *value2;
+
+	if (g_test_verbose())
+		g_print("proxy %s found\n",
+					g_dbus_proxy_get_interface(proxy));
+
+	g_assert(g_dbus_proxy_get_property(proxy, "Array", &iter));
+	g_assert(dbus_message_iter_get_arg_type(&iter) == DBUS_TYPE_ARRAY);
+
+	dbus_message_iter_recurse(&iter, &entry);
+	g_assert(dbus_message_iter_get_arg_type(&entry) == DBUS_TYPE_STRING);
+
+	dbus_message_iter_get_basic(&entry, &value1);
+	g_assert(g_strcmp0(value1, "value1") == 0);
+
+	dbus_message_iter_next(&entry);
+	g_assert(dbus_message_iter_get_arg_type(&entry) == DBUS_TYPE_STRING);
+
+	dbus_message_iter_get_basic(&entry, &value2);
+	g_assert(g_strcmp0(value2, "value2") == 0);
+
+	g_dbus_client_unref(context->dbus_client);
+}
+
+static gboolean get_array(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	const char *value[2] = { "value1", "value2" };
+	DBusMessageIter array;
+
+	dbus_message_iter_open_container(iter, DBUS_TYPE_ARRAY, "s", &array);
+
+	dbus_message_iter_append_basic(&array, DBUS_TYPE_STRING, &value[0]);
+	dbus_message_iter_append_basic(&array, DBUS_TYPE_STRING, &value[1]);
+
+	dbus_message_iter_close_container(iter, &array);
+
+	return TRUE;
+}
+
+static void client_get_array_property(void)
+{
+	struct context *context = create_context();
+	static const GDBusPropertyTable array_properties[] = {
+		{ "Array", "as", get_array },
+		{ },
+	};
+
+	if (context == NULL)
+		return;
+
+	g_dbus_register_interface(context->dbus_conn,
+				SERVICE_PATH, SERVICE_NAME,
+				methods, signals, array_properties,
+				NULL, NULL);
+
+	context->dbus_client = g_dbus_client_new(context->dbus_conn,
+						SERVICE_NAME, SERVICE_PATH);
+
+	g_dbus_client_set_proxy_handlers(context->dbus_client, proxy_get_array,
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
@@ -469,6 +545,9 @@ int main(int argc, char *argv[])
 	g_test_add_func("/gdbus/client_get_boolean_property",
 						client_get_boolean_property);
 
+	g_test_add_func("/gdbus/client_get_array_property",
+						client_get_array_property);
+
 	g_test_add_func("/gdbus/client_get_dict_property",
 						client_get_dict_property);
 
-- 
1.8.0.2

