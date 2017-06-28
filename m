Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 8/9] client: Add register-descriptor command
Date: Wed, 28 Jun 2017 15:54:22 +0300
Message-Id: <20170628125423.26208-9-luiz.dentz@gmail.com>
In-Reply-To: <20170628125423.26208-1-luiz.dentz@gmail.com>
References: <20170628125423.26208-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds register-descriptor which can be used to register
descriptors to a characteristic registered with register-characteristic:

register-descriptor 8260c653-1a54-426b-9e36-e84c238bc669 read,write
[NEW] Descriptor
	/org/bluez/app/service0x902610/chrc0x91d690/desc0x9095a0
	8260c653-1a54-426b-9e36-e84c238bc669
	Vendor specific
[/org/bluez/app/service0x902610/chrc0x91d690/desc0x9095a0] Enter value: 00
---
 client/gatt.c | 241 ++++++++++++++++++++++++++++++++++++++++++++++++++++------
 client/gatt.h |   2 +
 client/main.c |  25 ++++++
 3 files changed, 246 insertions(+), 22 deletions(-)

diff --git a/client/gatt.c b/client/gatt.c
index 674795a..7cfdc54 100644
--- a/client/gatt.c
+++ b/client/gatt.c
@@ -47,12 +47,22 @@
 #define PROFILE_INTERFACE "org.bluez.GattProfile1"
 #define SERVICE_INTERFACE "org.bluez.GattService1"
 #define CHRC_INTERFACE "org.bluez.GattCharacteristic1"
+#define DESC_INTERFACE "org.bluez.GattDescriptor1"
 
 /* String display constants */
 #define COLORED_NEW	COLOR_GREEN "NEW" COLOR_OFF
 #define COLORED_CHG	COLOR_YELLOW "CHG" COLOR_OFF
 #define COLORED_DEL	COLOR_RED "DEL" COLOR_OFF
 
+struct desc {
+	struct chrc *chrc;
+	char *path;
+	char *uuid;
+	char **flags;
+	int value_len;
+	uint8_t *value;
+};
+
 struct chrc {
 	struct service *service;
 	char *path;
@@ -228,31 +238,40 @@ void gatt_remove_characteristic(GDBusProxy *proxy)
 	print_characteristic(proxy, COLORED_DEL);
 }
 
-static void print_descriptor(GDBusProxy *proxy, const char *description)
+static void print_desc(struct desc *desc, const char *description)
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
+	text = uuidstr_to_str(desc->uuid);
 	if (!text)
 		rl_printf("%s%s%sDescriptor\n\t%s\n\t%s\n",
 					description ? "[" : "",
 					description ? : "",
 					description ? "] " : "",
-					g_dbus_proxy_get_path(proxy),
-					uuid);
+					desc->path, desc->uuid);
 	else
 		rl_printf("%s%s%sDescriptor\n\t%s\n\t%s\n\t%s\n",
 					description ? "[" : "",
 					description ? : "",
 					description ? "] " : "",
-					g_dbus_proxy_get_path(proxy),
-					uuid, text);
+					desc->path, desc->uuid, text);
+}
+
+static void print_descriptor(GDBusProxy *proxy, const char *description)
+{
+	struct desc desc;
+	DBusMessageIter iter;
+	const char *uuid;
+
+	if (g_dbus_proxy_get_property(proxy, "UUID", &iter) == FALSE)
+		return;
+
+	dbus_message_iter_get_basic(&iter, &uuid);
+
+	desc.path = (char *) g_dbus_proxy_get_path(proxy);
+	desc.uuid = (char *) uuid;
+
+	print_desc(&desc, description);
 }
 
 static gboolean descriptor_is_child(GDBusProxy *characteristic)
@@ -842,10 +861,31 @@ void gatt_unregister_app(DBusConnection *conn, GDBusProxy *proxy)
 	}
 }
 
+static void desc_free(void *data)
+{
+	struct desc *desc = data;
+
+	g_free(desc->path);
+	g_free(desc->uuid);
+	g_strfreev(desc->flags);
+	g_free(desc);
+}
+
+static void desc_unregister(void *data)
+{
+	struct desc *desc = data;
+
+	print_desc(desc, COLORED_DEL);
+
+	g_dbus_unregister_interface(desc->chrc->service->conn, desc->path,
+						DESC_INTERFACE);
+}
+
 static void chrc_free(void *data)
 {
 	struct chrc *chrc = data;
 
+	g_list_free_full(chrc->descs, desc_unregister);
 	g_free(chrc->path);
 	g_free(chrc->uuid);
 	g_strfreev(chrc->flags);
@@ -1157,16 +1197,13 @@ static const GDBusMethodTable chrc_methods[] = {
 	{ }
 };
 
-static void chrc_set_value(const char *input, void *user_data)
+static uint8_t *str2bytearray(char *arg, int *val_len)
 {
-	struct chrc *chrc = user_data;
 	uint8_t value[512];
 	char *entry;
 	unsigned int i;
 
-	g_free(chrc->value);
-
-	for (i = 0; (entry = strsep((char **)&input, " \t")) != NULL; i++) {
+	for (i = 0; (entry = strsep(&arg, " \t")) != NULL; i++) {
 		long int val;
 		char *endptr = NULL;
 
@@ -1175,20 +1212,30 @@ static void chrc_set_value(const char *input, void *user_data)
 
 		if (i >= G_N_ELEMENTS(value)) {
 			rl_printf("Too much data\n");
-			return;
+			return NULL;
 		}
 
 		val = strtol(entry, &endptr, 0);
 		if (!endptr || *endptr != '\0' || val > UINT8_MAX) {
 			rl_printf("Invalid value at index %d\n", i);
-			return;
+			return NULL;
 		}
 
 		value[i] = val;
 	}
 
-	chrc->value_len = i;
-	chrc->value = g_memdup(value, i);
+	*val_len = i;
+
+	return g_memdup(value, i);
+}
+
+static void chrc_set_value(const char *input, void *user_data)
+{
+	struct chrc *chrc = user_data;
+
+	g_free(chrc->value);
+
+	chrc->value = str2bytearray((char *) input, &chrc->value_len);
 }
 
 void gatt_register_chrc(DBusConnection *conn, GDBusProxy *proxy, wordexp_t *w)
@@ -1264,3 +1311,153 @@ void gatt_unregister_chrc(DBusConnection *conn, GDBusProxy *proxy,
 
 	chrc_unregister(chrc);
 }
+
+static DBusMessage *desc_read_value(DBusConnection *conn, DBusMessage *msg,
+							void *user_data)
+{
+	struct desc *desc = user_data;
+
+	return read_value(msg, desc->value, desc->value_len);
+}
+
+static DBusMessage *desc_write_value(DBusConnection *conn, DBusMessage *msg,
+							void *user_data)
+{
+	struct desc *desc = user_data;
+	DBusMessageIter iter;
+
+	dbus_message_iter_init(msg, &iter);
+
+	if (parse_value_arg(&iter, &desc->value, &desc->value_len))
+		return g_dbus_create_error(msg,
+					"org.bluez.Error.InvalidArguments",
+					NULL);
+
+	rl_printf("[" COLORED_CHG "] Attribute %s written" , desc->path);
+
+	g_dbus_emit_property_changed(conn, desc->path, CHRC_INTERFACE, "Value");
+
+	return g_dbus_create_reply(msg, DBUS_TYPE_INVALID);
+}
+
+static const GDBusMethodTable desc_methods[] = {
+	{ GDBUS_ASYNC_METHOD("ReadValue", GDBUS_ARGS({ "options", "a{sv}" }),
+					GDBUS_ARGS({ "value", "ay" }),
+					desc_read_value) },
+	{ GDBUS_ASYNC_METHOD("WriteValue", GDBUS_ARGS({ "value", "ay" },
+						{ "options", "a{sv}" }),
+					NULL, desc_write_value) },
+	{ }
+};
+
+static gboolean desc_get_uuid(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct desc *desc = data;
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_STRING, &desc->uuid);
+
+	return TRUE;
+}
+
+static gboolean desc_get_chrc(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct desc *desc = data;
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_OBJECT_PATH,
+						&desc->chrc->path);
+
+	return TRUE;
+}
+
+static gboolean desc_get_value(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct desc *desc = data;
+	DBusMessageIter array;
+
+	dbus_message_iter_open_container(iter, DBUS_TYPE_ARRAY, "y", &array);
+
+	if (desc->value)
+		dbus_message_iter_append_fixed_array(&array, DBUS_TYPE_BYTE,
+							&desc->value,
+							desc->value_len);
+
+	dbus_message_iter_close_container(iter, &array);
+
+	return TRUE;
+}
+
+static gboolean desc_get_flags(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct desc *desc = data;
+	int i;
+	DBusMessageIter array;
+
+	dbus_message_iter_open_container(iter, DBUS_TYPE_ARRAY, "s", &array);
+
+	for (i = 0; desc->flags[i]; i++)
+		dbus_message_iter_append_basic(&array, DBUS_TYPE_STRING,
+							&desc->flags[i]);
+
+	dbus_message_iter_close_container(iter, &array);
+
+	return TRUE;
+}
+
+static const GDBusPropertyTable desc_properties[] = {
+	{ "UUID", "s", desc_get_uuid, NULL, NULL },
+	{ "Characteristic", "o", desc_get_chrc, NULL, NULL },
+	{ "Value", "ay", desc_get_value, NULL, NULL },
+	{ "Flags", "as", desc_get_flags, NULL, NULL },
+	{ }
+};
+
+static void desc_set_value(const char *input, void *user_data)
+{
+	struct desc *desc = user_data;
+
+	g_free(desc->value);
+
+	desc->value = str2bytearray((char *) input, &desc->value_len);
+}
+
+void gatt_register_desc(DBusConnection *conn, GDBusProxy *proxy, wordexp_t *w)
+{
+	struct service *service;
+	struct desc *desc;
+
+	if (!local_services) {
+		rl_printf("No service registered\n");
+		return;
+	}
+
+	service = g_list_last(local_services)->data;
+
+	if (!service->chrcs) {
+		rl_printf("No characteristic registered\n");
+		return;
+	}
+
+	desc = g_new0(struct desc, 1);
+	desc->chrc = g_list_last(service->chrcs)->data;
+	desc->uuid = g_strdup(w->we_wordv[0]);
+	desc->path = g_strdup_printf("%s/desc%p", desc->chrc->path, desc);
+	desc->flags = g_strsplit(w->we_wordv[1], ",", -1);
+
+	if (g_dbus_register_interface(conn, desc->path, DESC_INTERFACE,
+					desc_methods, NULL, desc_properties,
+					desc, desc_free) == FALSE) {
+		rl_printf("Failed to register descriptor object\n");
+		desc_free(desc);
+		return;
+	}
+
+	desc->chrc->descs = g_list_append(desc->chrc->descs, desc);
+
+	print_desc(desc, COLORED_NEW);
+
+	rl_prompt_input(desc->path, "Enter value:", desc_set_value, desc);
+}
diff --git a/client/gatt.h b/client/gatt.h
index 0acce4d..4d1e63f 100644
--- a/client/gatt.h
+++ b/client/gatt.h
@@ -52,3 +52,5 @@ void gatt_unregister_service(DBusConnection *conn, GDBusProxy *proxy,
 void gatt_register_chrc(DBusConnection *conn, GDBusProxy *proxy, wordexp_t *w);
 void gatt_unregister_chrc(DBusConnection *conn, GDBusProxy *proxy,
 								wordexp_t *w);
+
+void gatt_register_desc(DBusConnection *conn, GDBusProxy *proxy, wordexp_t *w);
diff --git a/client/main.c b/client/main.c
index e5497f1..88dbdb3 100644
--- a/client/main.c
+++ b/client/main.c
@@ -1927,6 +1927,28 @@ static void cmd_unregister_characteristic(const char *arg)
 	wordfree(&w);
 }
 
+static void cmd_register_descriptor(const char *arg)
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
+	gatt_register_desc(dbus_conn, default_ctrl->proxy, &w);
+
+	wordfree(&w);
+}
+
 static void cmd_version(const char *arg)
 {
 	rl_printf("Version %s\n", VERSION);
@@ -2239,6 +2261,9 @@ static const struct {
 	{ "unregister-characteristic", "<UUID/object>",
 				cmd_unregister_characteristic,
 				"Unregister application characteristic" },
+	{ "register-descriptor", "<UUID> <Flags=read,write...>",
+					cmd_register_descriptor,
+					"Register application descriptor" },
 	{ "version",      NULL,       cmd_version, "Display version" },
 	{ "quit",         NULL,       cmd_quit, "Quit program" },
 	{ "exit",         NULL,       cmd_quit, "Quit program" },
-- 
2.9.4

