Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v4 3/4] client: Add authorized property handling to characteristic attribute
Date: Fri, 25 May 2018 11:15:40 +0200
Message-Id: <20180525091541.4688-3-grzegorz.kolodziejczyk@codecoup.pl>
In-Reply-To: <20180525091541.4688-1-grzegorz.kolodziejczyk@codecoup.pl>
References: <20180525091541.4688-1-grzegorz.kolodziejczyk@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds handling of characteristic prepare write authorized
property to bluetoothctl.
---
 client/gatt.c | 146 +++++++++++++++++++++++++++++++++++++---------------------
 client/main.c |   9 +---
 2 files changed, 96 insertions(+), 59 deletions(-)

diff --git a/client/gatt.c b/client/gatt.c
index d37a6f55c..3fde3ca2e 100644
--- a/client/gatt.c
+++ b/client/gatt.c
@@ -80,7 +80,6 @@ struct chrc {
 	struct io *write_io;
 	struct io *notify_io;
 	bool authorization_req;
-	bool authorized;
 };
 
 struct service {
@@ -1609,7 +1608,8 @@ static const char *path_to_address(const char *path)
 }
 
 static int parse_options(DBusMessageIter *iter, uint16_t *offset, uint16_t *mtu,
-						char **device, char **link)
+						char **device, char **link,
+						bool *prep_authorize)
 {
 	DBusMessageIter dict;
 
@@ -1650,6 +1650,12 @@ static int parse_options(DBusMessageIter *iter, uint16_t *offset, uint16_t *mtu,
 				return -EINVAL;
 			if (link)
 				dbus_message_iter_get_basic(&value, link);
+		} else if (strcasecmp(key, "prep-authorize") == 0) {
+			if (var != DBUS_TYPE_BOOLEAN)
+				return -EINVAL;
+			if (prep_authorize)
+				dbus_message_iter_get_basic(&value,
+								prep_authorize);
 		}
 
 		dbus_message_iter_next(&dict);
@@ -1703,8 +1709,6 @@ static void authorize_read_response(const char *input, void *user_data)
 	reply = read_value(pending_message, &chrc->value[aad->offset],
 						chrc->value_len - aad->offset);
 
-	chrc->authorized = true;
-
 	g_dbus_send_message(aad->conn, reply);
 
 	g_free(aad);
@@ -1727,18 +1731,15 @@ static DBusMessage *chrc_read_value(DBusConnection *conn, DBusMessage *msg,
 
 	dbus_message_iter_init(msg, &iter);
 
-	if (parse_options(&iter, &offset, NULL, &device, &link))
+	if (parse_options(&iter, &offset, NULL, &device, &link, NULL))
 		return g_dbus_create_error(msg,
 					"org.bluez.Error.InvalidArguments",
 					NULL);
 
 	bt_shell_printf("ReadValue: %s offset %u link %s\n",
-			path_to_address(device), offset, link);
-
-	if (chrc->authorization_req && offset == 0)
-		chrc->authorized = false;
+					path_to_address(device), offset, link);
 
-	if (chrc->authorization_req && !chrc->authorized) {
+	if (chrc->authorization_req) {
 		struct authorize_attribute_data *aad;
 
 		aad = g_new0(struct authorize_attribute_data, 1);
@@ -1765,33 +1766,31 @@ static DBusMessage *chrc_read_value(DBusConnection *conn, DBusMessage *msg,
 	return read_value(msg, &chrc->value[offset], chrc->value_len - offset);
 }
 
-static int parse_value_arg(DBusMessageIter *iter, uint8_t **value, int *len,
-								int max_len)
+static int parse_value_arg(DBusMessageIter *iter, uint8_t **value, int *len)
 {
 	DBusMessageIter array;
-	uint16_t offset = 0;
-	uint8_t *read_value;
-	int read_len;
 
 	if (dbus_message_iter_get_arg_type(iter) != DBUS_TYPE_ARRAY)
 		return -EINVAL;
 
 	dbus_message_iter_recurse(iter, &array);
-	dbus_message_iter_get_fixed_array(&array, &read_value, &read_len);
+	dbus_message_iter_get_fixed_array(&array, value, len);
 
-	dbus_message_iter_next(iter);
-	if (parse_options(iter, &offset, NULL, NULL, NULL))
-		return -EINVAL;
+	return 0;
+}
 
-	if ((offset + read_len) > max_len)
+static int write_value(int *dst_len, uint8_t **dst_value, uint8_t *src_val,
+				int src_len, uint16_t offset, uint16_t max_len)
+{
+	if ((offset + src_len) > max_len)
 		return -EOVERFLOW;
 
-	if ((offset + read_len) > *len) {
-		*len = offset + read_len;
-		*value = g_realloc(*value, *len);
+	if ((offset + src_len) != *dst_len) {
+		*dst_len = offset + src_len;
+		*dst_value = g_realloc(*dst_value, *dst_len);
 	}
 
-	memcpy(*value + offset, read_value, read_len);
+	memcpy(*dst_value + offset, src_val, src_len);
 
 	return 0;
 }
@@ -1800,12 +1799,26 @@ static void authorize_write_response(const char *input, void *user_data)
 {
 	struct authorize_attribute_data *aad = user_data;
 	struct chrc *chrc = aad->attribute;
+	bool prep_authorize = false;
 	DBusMessageIter iter;
 	DBusMessage *reply;
+	int value_len;
+	uint8_t *value;
 	char *err;
-	int errsv;
 
 	dbus_message_iter_init(pending_message, &iter);
+	if (parse_value_arg(&iter, &value, &value_len)) {
+		err = "org.bluez.Error.InvalidArguments";
+
+		goto error;
+	}
+
+	dbus_message_iter_next(&iter);
+	if (parse_options(&iter, NULL, NULL, NULL, NULL, &prep_authorize)) {
+		err = "org.bluez.Error.InvalidArguments";
+
+		goto error;
+	}
 
 	if (!strcmp(input, "no")) {
 		err = "org.bluez.Error.NotAuthorized";
@@ -1813,15 +1826,17 @@ static void authorize_write_response(const char *input, void *user_data)
 		goto error;
 	}
 
-	chrc->authorized = true;
+	/* Authorization check of prepare writes */
+	if (prep_authorize) {
+		reply = g_dbus_create_reply(pending_message, DBUS_TYPE_INVALID);
+		g_dbus_send_message(aad->conn, reply);
+		g_free(aad);
 
-	errsv = parse_value_arg(&iter, &chrc->value, &chrc->value_len,
-							chrc->max_val_len);
-	if (errsv == -EINVAL) {
-		err = "org.bluez.Error.InvalidArguments";
+		return;
+	}
 
-		goto error;
-	} else if (errsv == -EOVERFLOW) {
+	if (write_value(&chrc->value_len, &chrc->value, value, value_len,
+					aad->offset, chrc->max_val_len)) {
 		err = "org.bluez.Error.InvalidValueLength";
 
 		goto error;
@@ -1848,18 +1863,31 @@ static DBusMessage *chrc_write_value(DBusConnection *conn, DBusMessage *msg,
 							void *user_data)
 {
 	struct chrc *chrc = user_data;
+	uint16_t offset = 0;
+	bool prep_authorize = false;
 	DBusMessageIter iter;
+	int value_len;
+	uint8_t *value;
 	char *str;
-	int errsv;
 
 	dbus_message_iter_init(msg, &iter);
 
-	if (chrc->authorization_req && !chrc->authorized) {
+	if (parse_value_arg(&iter, &value, &value_len))
+		return g_dbus_create_error(msg,
+				"org.bluez.Error.InvalidArguments", NULL);
+
+	dbus_message_iter_next(&iter);
+	if (parse_options(&iter, &offset, NULL, NULL, NULL, &prep_authorize))
+		return g_dbus_create_error(msg,
+				"org.bluez.Error.InvalidArguments", NULL);
+
+	if (chrc->authorization_req) {
 		struct authorize_attribute_data *aad;
 
 		aad = g_new0(struct authorize_attribute_data, 1);
 		aad->conn = conn;
 		aad->attribute = chrc;
+		aad->offset = offset;
 
 		str = g_strdup_printf("Authorize attribute(%s) write (yes/no):",
 								chrc->path);
@@ -1873,15 +1901,14 @@ static DBusMessage *chrc_write_value(DBusConnection *conn, DBusMessage *msg,
 		return NULL;
 	}
 
-	errsv = parse_value_arg(&iter, &chrc->value, &chrc->value_len,
-							chrc->max_val_len);
-	if (errsv == -EINVAL) {
-		return g_dbus_create_error(msg,
-				"org.bluez.Error.InvalidArguments", NULL);
-	} else if (errsv == -EOVERFLOW) {
+	/* Authorization check of prepare writes */
+	if (prep_authorize)
+		return g_dbus_create_reply(msg, DBUS_TYPE_INVALID);
+
+	if (write_value(&chrc->value_len, &chrc->value, value, value_len,
+						offset, chrc->max_val_len))
 		return g_dbus_create_error(msg,
 				"org.bluez.Error.InvalidValueLength", NULL);
-	}
 
 	bt_shell_printf("[" COLORED_CHG "] Attribute %s written" , chrc->path);
 
@@ -1943,7 +1970,7 @@ static DBusMessage *chrc_acquire_write(DBusConnection *conn, DBusMessage *msg,
 					"org.bluez.Error.NotPermitted",
 					NULL);
 
-	if (parse_options(&iter, NULL, &chrc->mtu, &device, &link))
+	if (parse_options(&iter, NULL, &chrc->mtu, &device, &link, NULL))
 		return g_dbus_create_error(msg,
 					"org.bluez.Error.InvalidArguments",
 					NULL);
@@ -1975,7 +2002,7 @@ static DBusMessage *chrc_acquire_notify(DBusConnection *conn, DBusMessage *msg,
 					"org.bluez.Error.NotPermitted",
 					NULL);
 
-	if (parse_options(&iter, NULL, &chrc->mtu, &device, &link))
+	if (parse_options(&iter, NULL, &chrc->mtu, &device, &link, NULL))
 		return g_dbus_create_error(msg,
 					"org.bluez.Error.InvalidArguments",
 					NULL);
@@ -2101,6 +2128,18 @@ static void chrc_set_value(const char *input, void *user_data)
 	chrc->max_val_len = chrc->value_len;
 }
 
+static gboolean attr_authorization_flag_exists(char **flags)
+{
+	int i;
+
+	for (i = 0; flags[i]; i++) {
+		if (!strcmp("authorize", flags[i]))
+			return TRUE;
+	}
+
+	return FALSE;
+}
+
 void gatt_register_chrc(DBusConnection *conn, GDBusProxy *proxy,
 					int argc, char *argv[])
 {
@@ -2119,7 +2158,7 @@ void gatt_register_chrc(DBusConnection *conn, GDBusProxy *proxy,
 	chrc->uuid = g_strdup(argv[1]);
 	chrc->path = g_strdup_printf("%s/chrc%p", service->path, chrc);
 	chrc->flags = g_strsplit(argv[2], ",", -1);
-	chrc->authorization_req = argc > 3 ? true : false;
+	chrc->authorization_req = attr_authorization_flag_exists(chrc->flags);
 
 	if (g_dbus_register_interface(conn, chrc->path, CHRC_INTERFACE,
 					chrc_methods, NULL, chrc_properties,
@@ -2191,7 +2230,7 @@ static DBusMessage *desc_read_value(DBusConnection *conn, DBusMessage *msg,
 
 	dbus_message_iter_init(msg, &iter);
 
-	if (parse_options(&iter, &offset, NULL, &device, &link))
+	if (parse_options(&iter, &offset, NULL, &device, &link, NULL))
 		return g_dbus_create_error(msg,
 					"org.bluez.Error.InvalidArguments",
 					NULL);
@@ -2213,21 +2252,24 @@ static DBusMessage *desc_write_value(DBusConnection *conn, DBusMessage *msg,
 	DBusMessageIter iter;
 	uint16_t offset = 0;
 	char *device = NULL, *link = NULL;
+	int value_len;
+	uint8_t *value;
 
 	dbus_message_iter_init(msg, &iter);
 
-	if (parse_value_arg(&iter, &desc->value, &desc->value_len,
-							desc->max_val_len))
+	if (parse_value_arg(&iter, &value, &value_len))
 		return g_dbus_create_error(msg,
-					"org.bluez.Error.InvalidArguments",
-					NULL);
+				"org.bluez.Error.InvalidArguments", NULL);
 
 	dbus_message_iter_next(&iter);
+	if (parse_options(&iter, &offset, NULL, &device, &link, NULL))
+		return g_dbus_create_error(msg,
+				"org.bluez.Error.InvalidArguments", NULL);
 
-	if (parse_options(&iter, &offset, NULL, &device, &link))
+	if (write_value(&desc->value_len, &desc->value, value,
+					value_len, offset, desc->max_val_len))
 		return g_dbus_create_error(msg,
-					"org.bluez.Error.InvalidArguments",
-					NULL);
+				"org.bluez.Error.InvalidValueLength", NULL);
 
 	bt_shell_printf("WriteValue: %s offset %u link %s\n",
 			path_to_address(device), offset, link);
diff --git a/client/main.c b/client/main.c
index 180f841ae..87323d8f7 100644
--- a/client/main.c
+++ b/client/main.c
@@ -2036,11 +2036,6 @@ static void cmd_register_characteristic(int argc, char *argv[])
 	if (check_default_ctrl() == FALSE)
 		return bt_shell_noninteractive_quit(EXIT_FAILURE);
 
-	if (argc > 3 && strcmp(argv[3], "authorize")) {
-		bt_shell_printf("Invalid authorize argument\n");
-		return bt_shell_noninteractive_quit(EXIT_FAILURE);
-	}
-
 	gatt_register_chrc(dbus_conn, default_ctrl->proxy, argc, argv);
 }
 
@@ -2517,8 +2512,8 @@ static const struct bt_shell_menu gatt_menu = {
 			cmd_unregister_includes,
 				 "Unregister Included service." },
 	{ "register-characteristic", "<UUID> <Flags=read,write,notify...> "
-				"[authorize]", cmd_register_characteristic,
-				"Register application characteristic" },
+					, cmd_register_characteristic,
+					"Register application characteristic" },
 	{ "unregister-characteristic", "<UUID/object>",
 				cmd_unregister_characteristic,
 				"Unregister application characteristic" },
-- 
2.13.6

