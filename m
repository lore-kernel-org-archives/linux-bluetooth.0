Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 3/7] unit: Add gdbus/client_get_dict_property
Date: Fri, 11 Jan 2013 13:50:14 +0200
Message-Id: <1357905018-23237-3-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1357905018-23237-1-git-send-email-luiz.dentz@gmail.com>
References: <1357905018-23237-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 unit/test-gdbus-client.c | 147 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 147 insertions(+)

diff --git a/unit/test-gdbus-client.c b/unit/test-gdbus-client.c
index 34c714e..dac0cb5 100644
--- a/unit/test-gdbus-client.c
+++ b/unit/test-gdbus-client.c
@@ -81,6 +81,8 @@ static struct context *create_context(void)
 	/* Avoid D-Bus library calling _exit() before next test finishes. */
 	dbus_connection_set_exit_on_disconnect(context->dbus_conn, FALSE);
 
+	g_dbus_attach_object_manager(context->dbus_conn);
+
 	return context;
 }
 
@@ -184,6 +186,148 @@ static void client_connect_disconnect(void)
 	destroy_context(context);
 }
 
+static void append_variant(DBusMessageIter *iter, int type, void *val)
+{
+	DBusMessageIter value;
+	char sig[2] = { type, '\0' };
+
+	dbus_message_iter_open_container(iter, DBUS_TYPE_VARIANT, sig, &value);
+
+	dbus_message_iter_append_basic(&value, type, val);
+
+	dbus_message_iter_close_container(iter, &value);
+}
+
+static void dict_append_entry(DBusMessageIter *dict, const char *key, int type,
+								void *val)
+{
+	DBusMessageIter entry;
+
+	if (type == DBUS_TYPE_STRING) {
+		const char *str = *((const char **) val);
+		if (str == NULL)
+			return;
+	}
+
+	dbus_message_iter_open_container(dict, DBUS_TYPE_DICT_ENTRY,
+							NULL, &entry);
+
+	dbus_message_iter_append_basic(&entry, DBUS_TYPE_STRING, &key);
+
+	append_variant(&entry, type, val);
+
+	dbus_message_iter_close_container(dict, &entry);
+}
+
+static gboolean get_dict(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	DBusMessageIter dict;
+	const char *string = "value";
+	dbus_bool_t boolean = TRUE;
+
+	dbus_message_iter_open_container(iter, DBUS_TYPE_ARRAY,
+			DBUS_DICT_ENTRY_BEGIN_CHAR_AS_STRING
+			DBUS_TYPE_STRING_AS_STRING DBUS_TYPE_VARIANT_AS_STRING
+			DBUS_DICT_ENTRY_END_CHAR_AS_STRING, &dict);
+
+	dict_append_entry(&dict, "String", DBUS_TYPE_STRING, &string);
+	dict_append_entry(&dict, "Boolean", DBUS_TYPE_BOOLEAN, &boolean);
+
+	dbus_message_iter_close_container(iter, &dict);
+
+	return TRUE;
+}
+
+static void proxy_get_dict(GDBusProxy *proxy, void *user_data)
+{
+	struct context *context = user_data;
+	DBusMessageIter iter, dict, var1, var2, entry1, entry2;
+	const char *string;
+	dbus_bool_t boolean;
+
+	if (g_test_verbose())
+		g_print("proxy %s found\n",
+					g_dbus_proxy_get_interface(proxy));
+
+	g_assert(g_dbus_proxy_get_property(proxy, "Dict", &iter));
+	g_assert(dbus_message_iter_get_arg_type(&iter) == DBUS_TYPE_ARRAY);
+
+	dbus_message_iter_recurse(&iter, &dict);
+	g_assert(dbus_message_iter_get_arg_type(&dict) ==
+							DBUS_TYPE_DICT_ENTRY);
+
+	dbus_message_iter_recurse(&dict, &entry1);
+	g_assert(dbus_message_iter_get_arg_type(&entry1) == DBUS_TYPE_STRING);
+
+	dbus_message_iter_get_basic(&entry1, &string);
+	g_assert(g_strcmp0(string, "String") == 0);
+
+	dbus_message_iter_next(&entry1);
+	g_assert(dbus_message_iter_get_arg_type(&entry1) == DBUS_TYPE_VARIANT);
+
+	dbus_message_iter_recurse(&entry1, &var1);
+	g_assert(dbus_message_iter_get_arg_type(&var1) == DBUS_TYPE_STRING);
+
+	dbus_message_iter_get_basic(&var1, &string);
+	g_assert(g_strcmp0(string, "value") == 0);
+
+	dbus_message_iter_next(&dict);
+	g_assert(dbus_message_iter_get_arg_type(&dict) ==
+							DBUS_TYPE_DICT_ENTRY);
+
+	dbus_message_iter_recurse(&dict, &entry2);
+	g_assert(dbus_message_iter_get_arg_type(&entry2) == DBUS_TYPE_STRING);
+
+	dbus_message_iter_get_basic(&entry2, &string);
+	g_assert(g_strcmp0(string, "Boolean") == 0);
+
+	dbus_message_iter_next(&entry2);
+	g_assert(dbus_message_iter_get_arg_type(&entry2) == DBUS_TYPE_VARIANT);
+
+	dbus_message_iter_recurse(&entry2, &var2);
+	g_assert(dbus_message_iter_get_arg_type(&var2) == DBUS_TYPE_BOOLEAN);
+
+	dbus_message_iter_get_basic(&var2, &boolean);
+	g_assert(boolean == TRUE);
+
+	dbus_message_iter_next(&dict);
+	g_assert(dbus_message_iter_get_arg_type(&dict) == DBUS_TYPE_INVALID);
+
+	g_main_loop_quit(context->main_loop);
+}
+
+static void client_get_dict_property(void)
+{
+	struct context *context = create_context();
+	static const GDBusPropertyTable dict_properties[] = {
+		{ "Dict", "a{sv}", get_dict },
+		{ },
+	};
+
+	if (context == NULL)
+		return;
+
+	g_dbus_register_interface(context->dbus_conn,
+				SERVICE_PATH, SERVICE_NAME,
+				methods, signals, dict_properties,
+				NULL, NULL);
+
+	context->dbus_client = g_dbus_client_new(context->dbus_conn,
+						SERVICE_NAME, SERVICE_PATH);
+
+	g_dbus_client_set_proxy_handlers(context->dbus_client, proxy_get_dict,
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
@@ -193,5 +337,8 @@ int main(int argc, char *argv[])
 	g_test_add_func("/gdbus/client_connect_disconnect",
 						client_connect_disconnect);
 
+	g_test_add_func("/gdbus/client_get_dict_property",
+						client_get_dict_property);
+
 	return g_test_run();
 }
-- 
1.8.0.1

