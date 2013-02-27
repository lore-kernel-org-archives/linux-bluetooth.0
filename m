Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/3 v3] unit: Add gdbus/client_set_string_property
Date: Wed, 27 Feb 2013 14:00:21 +0200
Message-Id: <1361966423-3582-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 unit/test-gdbus-client.c | 112 +++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 109 insertions(+), 3 deletions(-)

diff --git a/unit/test-gdbus-client.c b/unit/test-gdbus-client.c
index 7fc97ed..679c27d 100644
--- a/unit/test-gdbus-client.c
+++ b/unit/test-gdbus-client.c
@@ -35,6 +35,7 @@ struct context {
 	GMainLoop *main_loop;
 	DBusConnection *dbus_conn;
 	GDBusClient *dbus_client;
+	void *data;
 	guint timeout_source;
 };
 
@@ -98,6 +99,7 @@ static void destroy_context(struct context *context)
 
 	g_main_loop_unref(context->main_loop);
 
+	g_free(context->data);
 	g_free(context);
 }
 
@@ -353,9 +355,9 @@ static void proxy_get_string(GDBusProxy *proxy, void *user_data)
 static gboolean get_string(const GDBusPropertyTable *property,
 					DBusMessageIter *iter, void *data)
 {
-	const char *string = "value";
+	struct context *context = data;
 
-	dbus_message_iter_append_basic(iter, DBUS_TYPE_STRING, &string);
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_STRING, &context->data);
 
 	return TRUE;
 }
@@ -371,10 +373,11 @@ static void client_get_string_property(void)
 	if (context == NULL)
 		return;
 
+	context->data = g_strdup("value");
 	g_dbus_register_interface(context->dbus_conn,
 				SERVICE_PATH, SERVICE_NAME,
 				methods, signals, string_properties,
-				NULL, NULL);
+				context, NULL);
 
 	context->dbus_client = g_dbus_client_new(context->dbus_conn,
 						SERVICE_NAME, SERVICE_PATH);
@@ -592,6 +595,106 @@ static void client_get_uint64_property(void)
 	destroy_context(context);
 }
 
+static void property_set_success(const DBusError *err, void *user_data)
+{
+	g_assert(!dbus_error_is_set(err));
+}
+
+static void proxy_set_string(GDBusProxy *proxy, void *user_data)
+{
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
+	string = "value1";
+	g_assert(g_dbus_proxy_set_property_basic(proxy, "String",
+					DBUS_TYPE_STRING, &string,
+					property_set_success, user_data,
+					NULL));
+}
+
+static void property_string_changed(GDBusProxy *proxy, const char *name,
+					DBusMessageIter *iter, void *user_data)
+{
+	struct context *context = user_data;
+	const char *string;
+
+	if (g_test_verbose())
+		g_print("property %s changed\n", name);
+
+	g_assert(g_strcmp0(name, "String") == 0);
+	g_assert(dbus_message_iter_get_arg_type(iter) == DBUS_TYPE_STRING);
+
+	dbus_message_iter_get_basic(iter, &string);
+	g_assert(g_strcmp0(string, "value1") == 0);
+
+	g_dbus_client_unref(context->dbus_client);
+}
+
+static void set_string(const GDBusPropertyTable *property,
+			DBusMessageIter *iter, GDBusPendingPropertySet id,
+			void *data)
+{
+	struct context *context = data;
+	const char *string;
+
+	g_assert(dbus_message_iter_get_arg_type(iter) == DBUS_TYPE_STRING);
+
+	dbus_message_iter_get_basic(iter, &string);
+	g_assert(g_strcmp0(string, "value1") == 0);
+
+	g_free(context->data);
+	context->data = g_strdup(string);
+
+	g_dbus_emit_property_changed(context->dbus_conn, SERVICE_PATH,
+						SERVICE_NAME, "String");
+
+	g_dbus_pending_property_success(id);
+}
+
+static void client_set_string_property(void)
+{
+	struct context *context = create_context();
+	static const GDBusPropertyTable string_properties[] = {
+		{ "String", "s", get_string, set_string },
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
+	g_dbus_client_set_proxy_handlers(context->dbus_client, proxy_set_string,
+						NULL, property_string_changed,
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
@@ -616,5 +719,8 @@ int main(int argc, char *argv[])
 	g_test_add_func("/gdbus/client_get_dict_property",
 						client_get_dict_property);
 
+	g_test_add_func("/gdbus/client_set_string_property",
+						client_set_string_property);
+
 	return g_test_run();
 }
-- 
1.8.1.2

