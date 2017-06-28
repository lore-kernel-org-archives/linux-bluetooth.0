Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 4/9] client: Add register-characteristic command
Date: Wed, 28 Jun 2017 15:54:18 +0300
Message-Id: <20170628125423.26208-5-luiz.dentz@gmail.com>
In-Reply-To: <20170628125423.26208-1-luiz.dentz@gmail.com>
References: <20170628125423.26208-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds register-characteristic which can be used to register
characteristic to a service registered with register-service:

register-characteristic 00002a06-0000-1000-8000-00805f9b34fb write-without-response
[NEW] Characteristic
	/org/bluez/app/service0x1122150/chrc0x113fa40
	00002a06-0000-1000-8000-00805f9b34fb
	Alert Level
---
 client/gatt.c | 285 ++++++++++++++++++++++++++++++++++++++++++++++++++++++----
 client/gatt.h |   2 +
 client/main.c |  25 ++++++
 3 files changed, 297 insertions(+), 15 deletions(-)

diff --git a/client/gatt.c b/client/gatt.c
index 92ace0e..2e56e0c 100644
--- a/client/gatt.c
+++ b/client/gatt.c
@@ -46,17 +46,30 @@
 #define APP_PATH "/org/bluez/app"
 #define PROFILE_INTERFACE "org.bluez.GattProfile1"
 #define SERVICE_INTERFACE "org.bluez.GattService1"
+#define CHRC_INTERFACE "org.bluez.GattCharacteristic1"
 
 /* String display constants */
 #define COLORED_NEW	COLOR_GREEN "NEW" COLOR_OFF
 #define COLORED_CHG	COLOR_YELLOW "CHG" COLOR_OFF
 #define COLORED_DEL	COLOR_RED "DEL" COLOR_OFF
 
+struct chrc {
+	struct service *service;
+	char *path;
+	char *uuid;
+	char **flags;
+	bool notifying;
+	GList *descs;
+	int value_len;
+	uint8_t *value;
+};
+
 struct service {
 	DBusConnection *conn;
 	char *path;
 	char *uuid;
 	bool primary;
+	GList *chrcs;
 };
 
 static GList *local_services;
@@ -133,34 +146,43 @@ void gatt_remove_service(GDBusProxy *proxy)
 	print_service_proxy(proxy, COLORED_DEL);
 }
 
-static void print_characteristic(GDBusProxy *proxy, const char *description)
+static void print_chrc(struct chrc *chrc, const char *description)
 {
-	DBusMessageIter iter;
-	const char *uuid, *text;
-
-	if (g_dbus_proxy_get_property(proxy, "UUID", &iter) == FALSE)
-		return;
-
-	dbus_message_iter_get_basic(&iter, &uuid);
+	const char *text;
 
-	text = uuidstr_to_str(uuid);
+	text = uuidstr_to_str(chrc->uuid);
 	if (!text)
 		rl_printf("%s%s%sCharacteristic\n\t%s\n\t%s\n",
 					description ? "[" : "",
 					description ? : "",
 					description ? "] " : "",
-					g_dbus_proxy_get_path(proxy),
-					uuid);
+					chrc->path, chrc->uuid);
 	else
 		rl_printf("%s%s%sCharacteristic\n\t%s\n\t%s\n\t%s\n",
 					description ? "[" : "",
 					description ? : "",
 					description ? "] " : "",
-					g_dbus_proxy_get_path(proxy),
-					uuid, text);
+					chrc->path, chrc->uuid, text);
+}
+
+static void print_characteristic(GDBusProxy *proxy, const char *description)
+{
+	struct chrc chrc;
+	DBusMessageIter iter;
+	const char *uuid;
+
+	if (g_dbus_proxy_get_property(proxy, "UUID", &iter) == FALSE)
+		return;
+
+	dbus_message_iter_get_basic(&iter, &uuid);
+
+	chrc.path = (char *) g_dbus_proxy_get_path(proxy);
+	chrc.uuid = (char *) uuid;
+
+	print_chrc(&chrc, description);
 }
 
-static gboolean characteristic_is_child(GDBusProxy *characteristic)
+static gboolean chrc_is_child(GDBusProxy *characteristic)
 {
 	GList *l;
 	DBusMessageIter iter;
@@ -185,7 +207,7 @@ static gboolean characteristic_is_child(GDBusProxy *characteristic)
 
 void gatt_add_characteristic(GDBusProxy *proxy)
 {
-	if (!characteristic_is_child(proxy))
+	if (!chrc_is_child(proxy))
 		return;
 
 	characteristics = g_list_append(characteristics, proxy);
@@ -820,10 +842,31 @@ void gatt_unregister_app(DBusConnection *conn, GDBusProxy *proxy)
 	}
 }
 
+static void chrc_free(void *data)
+{
+	struct chrc *chrc = data;
+
+	g_free(chrc->path);
+	g_free(chrc->uuid);
+	g_strfreev(chrc->flags);
+	g_free(chrc);
+}
+
+static void chrc_unregister(void *data)
+{
+	struct chrc *chrc = data;
+
+	print_chrc(chrc, COLORED_DEL);
+
+	g_dbus_unregister_interface(chrc->service->conn, chrc->path,
+						CHRC_INTERFACE);
+}
+
 static void service_free(void *data)
 {
 	struct service *service = data;
 
+	g_list_free_full(service->chrcs, chrc_unregister);
 	g_free(service->path);
 	g_free(service->uuid);
 	g_free(service);
@@ -932,3 +975,215 @@ void gatt_unregister_service(DBusConnection *conn, GDBusProxy *proxy,
 	g_dbus_unregister_interface(service->conn, service->path,
 						SERVICE_INTERFACE);
 }
+
+static gboolean chrc_get_uuid(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct chrc *chrc = data;
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_STRING, &chrc->uuid);
+
+	return TRUE;
+}
+
+static gboolean chrc_get_service(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct chrc *chrc = data;
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_OBJECT_PATH,
+						&chrc->service->path);
+
+	return TRUE;
+}
+
+static gboolean chrc_get_value(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct chrc *chrc = data;
+	DBusMessageIter array;
+
+	dbus_message_iter_open_container(iter, DBUS_TYPE_ARRAY, "y", &array);
+
+	dbus_message_iter_append_fixed_array(&array, DBUS_TYPE_BYTE,
+						&chrc->value, chrc->value_len);
+
+	dbus_message_iter_close_container(iter, &array);
+
+	return TRUE;
+}
+
+static gboolean chrc_get_notifying(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct chrc *chrc = data;
+	dbus_bool_t value;
+
+	value = chrc->notifying ? TRUE : FALSE;
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_BOOLEAN, &value);
+
+	return TRUE;
+}
+
+static gboolean chrc_get_flags(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct chrc *chrc = data;
+	int i;
+	DBusMessageIter array;
+
+	dbus_message_iter_open_container(iter, DBUS_TYPE_ARRAY, "s", &array);
+
+	for (i = 0; chrc->flags[i]; i++)
+		dbus_message_iter_append_basic(&array, DBUS_TYPE_STRING,
+							&chrc->flags[i]);
+
+	dbus_message_iter_close_container(iter, &array);
+
+	return TRUE;
+}
+
+static const GDBusPropertyTable chrc_properties[] = {
+	{ "UUID", "s", chrc_get_uuid, NULL, NULL },
+	{ "Service", "o", chrc_get_service, NULL, NULL },
+	{ "Value", "ay", chrc_get_value, NULL, NULL },
+	{ "Notifying", "b", chrc_get_notifying, NULL, NULL },
+	{ "Flags", "as", chrc_get_flags, NULL, NULL },
+	{ }
+};
+
+static DBusMessage *read_value(DBusMessage *msg, uint8_t *value,
+						uint16_t value_len)
+{
+	DBusMessage *reply;
+	DBusMessageIter iter, array;
+
+	reply = g_dbus_create_reply(msg, DBUS_TYPE_INVALID);
+
+	dbus_message_iter_init_append(reply, &iter);
+	dbus_message_iter_open_container(&iter, DBUS_TYPE_ARRAY, "y", &array);
+	dbus_message_iter_append_fixed_array(&array, DBUS_TYPE_BYTE,
+						&value, value_len);
+	dbus_message_iter_close_container(&iter, &array);
+
+	return reply;
+}
+
+static DBusMessage *chrc_read_value(DBusConnection *conn, DBusMessage *msg,
+							void *user_data)
+{
+	struct chrc *chrc = user_data;
+
+	return read_value(msg, chrc->value, chrc->value_len);
+}
+
+static int parse_value_arg(DBusMessageIter *iter, uint8_t **value, int *len)
+{
+	DBusMessageIter array;
+
+	if (dbus_message_iter_get_arg_type(iter) != DBUS_TYPE_ARRAY)
+		return -EINVAL;
+
+	dbus_message_iter_recurse(iter, &array);
+	dbus_message_iter_get_fixed_array(&array, value, len);
+
+	return 0;
+}
+
+static DBusMessage *chrc_write_value(DBusConnection *conn, DBusMessage *msg,
+							void *user_data)
+{
+	struct chrc *chrc = user_data;
+	DBusMessageIter iter;
+
+	dbus_message_iter_init(msg, &iter);
+
+	if (parse_value_arg(&iter, &chrc->value, &chrc->value_len))
+		return g_dbus_create_error(msg,
+					"org.bluez.Error.InvalidArguments",
+					NULL);
+
+	rl_printf("[" COLORED_CHG "] Attribute %s written" , chrc->path);
+
+	g_dbus_emit_property_changed(conn, chrc->path, CHRC_INTERFACE, "Value");
+
+	return g_dbus_create_reply(msg, DBUS_TYPE_INVALID);
+}
+
+static DBusMessage *chrc_start_notify(DBusConnection *conn, DBusMessage *msg,
+							void *user_data)
+{
+	struct chrc *chrc = user_data;
+
+	if (!chrc->notifying)
+		return g_dbus_create_reply(msg, DBUS_TYPE_INVALID);
+
+	chrc->notifying = true;
+	rl_printf("[" COLORED_CHG "] Attribute %s notifications enabled",
+							chrc->path);
+	g_dbus_emit_property_changed(conn, chrc->path, CHRC_INTERFACE,
+							"Notifying");
+
+	return g_dbus_create_reply(msg, DBUS_TYPE_INVALID);
+}
+
+static DBusMessage *chrc_stop_notify(DBusConnection *conn, DBusMessage *msg,
+							void *user_data)
+{
+	struct chrc *chrc = user_data;
+
+	if (chrc->notifying)
+		return g_dbus_create_reply(msg, DBUS_TYPE_INVALID);
+
+	chrc->notifying = false;
+	rl_printf("[" COLORED_CHG "] Attribute %s notifications disabled",
+							chrc->path);
+	g_dbus_emit_property_changed(conn, chrc->path, CHRC_INTERFACE,
+							"Notifying");
+
+	return g_dbus_create_reply(msg, DBUS_TYPE_INVALID);
+}
+
+static const GDBusMethodTable chrc_methods[] = {
+	{ GDBUS_ASYNC_METHOD("ReadValue", GDBUS_ARGS({ "options", "a{sv}" }),
+					GDBUS_ARGS({ "value", "ay" }),
+					chrc_read_value) },
+	{ GDBUS_ASYNC_METHOD("WriteValue", GDBUS_ARGS({ "value", "ay" },
+						{ "options", "a{sv}" }),
+					NULL, chrc_write_value) },
+	{ GDBUS_ASYNC_METHOD("StartNotify", NULL, NULL, chrc_start_notify) },
+	{ GDBUS_METHOD("StopNotify", NULL, NULL, chrc_stop_notify) },
+	{ }
+};
+
+void gatt_register_chrc(DBusConnection *conn, GDBusProxy *proxy, wordexp_t *w)
+{
+	struct service *service;
+	struct chrc *chrc;
+
+	if (!local_services) {
+		rl_printf("No service registered\n");
+		return;
+	}
+
+	service = g_list_last(local_services)->data;
+
+	chrc = g_new0(struct chrc, 1);
+	chrc->service = service;
+	chrc->uuid = g_strdup(w->we_wordv[0]);
+	chrc->path = g_strdup_printf("%s/chrc%p", service->path, chrc);
+	chrc->flags = g_strsplit(w->we_wordv[1], ",", -1);
+
+	if (g_dbus_register_interface(conn, chrc->path, CHRC_INTERFACE,
+					chrc_methods, NULL, chrc_properties,
+					chrc, chrc_free) == FALSE) {
+		rl_printf("Failed to register characteristic object\n");
+		chrc_free(chrc);
+		return;
+	}
+
+	service->chrcs = g_list_append(service->chrcs, chrc);
+
+	print_chrc(chrc, COLORED_NEW);
+}
diff --git a/client/gatt.h b/client/gatt.h
index 4b9edd5..4ecf642 100644
--- a/client/gatt.h
+++ b/client/gatt.h
@@ -48,3 +48,5 @@ void gatt_register_service(DBusConnection *conn, GDBusProxy *proxy,
 								wordexp_t *w);
 void gatt_unregister_service(DBusConnection *conn, GDBusProxy *proxy,
 								wordexp_t *w);
+
+void gatt_register_chrc(DBusConnection *conn, GDBusProxy *proxy, wordexp_t *w);
diff --git a/client/main.c b/client/main.c
index 16bc125..76a731f 100644
--- a/client/main.c
+++ b/client/main.c
@@ -1883,6 +1883,28 @@ static void cmd_unregister_service(const char *arg)
 	wordfree(&w);
 }
 
+static void cmd_register_characteristic(const char *arg)
+{
+	wordexp_t w;
+
+	if (check_default_ctrl() == FALSE)
+		return;
+
+	if (wordexp(arg, &w, WRDE_NOCMD)) {
+		rl_printf("Invalid argument\n");
+		return;
+	}
+
+	if (w.we_wordc < 2) {
+		rl_printf("Missing arguments\n");
+		return;
+	}
+
+	gatt_register_chrc(dbus_conn, default_ctrl->proxy, &w);
+
+	wordfree(&w);
+}
+
 static void cmd_version(const char *arg)
 {
 	rl_printf("Version %s\n", VERSION);
@@ -2189,6 +2211,9 @@ static const struct {
 					"Register application service" },
 	{ "unregister-service", "<UUID/object>", cmd_unregister_service,
 					"Unregister application service" },
+	{ "register-characteristic", "<UUID> <Flags=read,write,notify...>",
+					cmd_register_characteristic,
+					"Register application characteristic" },
 	{ "version",      NULL,       cmd_version, "Display version" },
 	{ "quit",         NULL,       cmd_quit, "Quit program" },
 	{ "exit",         NULL,       cmd_quit, "Quit program" },
-- 
2.9.4

