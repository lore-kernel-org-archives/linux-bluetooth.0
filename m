Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 5/5] unit: Add gdbus/client_get_uint64_property
Date: Wed, 16 Jan 2013 15:54:40 +0200
Message-Id: <1358344480-23777-5-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1358344480-23777-1-git-send-email-luiz.dentz@gmail.com>
References: <1358344480-23777-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 unit/test-gdbus-client.c | 65 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/unit/test-gdbus-client.c b/unit/test-gdbus-client.c
index 534d8ce..7fc97ed 100644
--- a/unit/test-gdbus-client.c
+++ b/unit/test-gdbus-client.c
@@ -530,6 +530,68 @@ static void client_get_array_property(void)
 	destroy_context(context);
 }
 
+static void proxy_get_uint64(GDBusProxy *proxy, void *user_data)
+{
+	struct context *context = user_data;
+	DBusMessageIter iter;
+	guint64 value;
+
+	if (g_test_verbose())
+		g_print("proxy %s found\n",
+					g_dbus_proxy_get_interface(proxy));
+
+	g_assert(g_dbus_proxy_get_property(proxy, "Number", &iter));
+	g_assert(dbus_message_iter_get_arg_type(&iter) == DBUS_TYPE_UINT64);
+
+	dbus_message_iter_get_basic(&iter, &value);
+	g_assert(value == G_MAXUINT64);
+
+	g_dbus_client_unref(context->dbus_client);
+}
+
+static gboolean get_uint64(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	guint64 value = G_MAXUINT64;
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_UINT64, &value);
+
+	return TRUE;
+}
+
+static void client_get_uint64_property(void)
+{
+	struct context *context = create_context();
+	static const GDBusPropertyTable uint64_properties[] = {
+		{ "Number", "t", get_uint64 },
+		{ },
+	};
+
+	if (context == NULL)
+		return;
+
+	g_dbus_register_interface(context->dbus_conn,
+				SERVICE_PATH, SERVICE_NAME,
+				methods, signals, uint64_properties,
+				NULL, NULL);
+
+	context->dbus_client = g_dbus_client_new(context->dbus_conn,
+						SERVICE_NAME, SERVICE_PATH);
+
+	g_dbus_client_set_proxy_handlers(context->dbus_client,
+						proxy_get_uint64,
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
@@ -545,6 +607,9 @@ int main(int argc, char *argv[])
 	g_test_add_func("/gdbus/client_get_boolean_property",
 						client_get_boolean_property);
 
+	g_test_add_func("/gdbus/client_get_uint64_property",
+						client_get_uint64_property);
+
 	g_test_add_func("/gdbus/client_get_array_property",
 						client_get_array_property);
 
-- 
1.8.0.2

