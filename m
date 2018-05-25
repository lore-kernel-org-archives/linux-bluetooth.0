Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v3 3/4] client: Add authorized property handling to characteristic attribute
Date: Fri, 25 May 2018 09:38:56 +0200
Message-Id: <20180525073857.17860-3-grzegorz.kolodziejczyk@codecoup.pl>
In-Reply-To: <20180525073857.17860-1-grzegorz.kolodziejczyk@codecoup.pl>
References: <20180525073857.17860-1-grzegorz.kolodziejczyk@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds handling of characteristic prepare write authorized
property to bluetoothctl.
---
 client/gatt.c | 158 +++++++++++++++++++++++++++++++++++++++-------------------
 1 file changed, 107 insertions(+), 51 deletions(-)

diff --git a/client/gatt.c b/client/gatt.c
index d37a6f55c..13c5d8e49 100644
--- a/client/gatt.c
+++ b/client/gatt.c
@@ -80,7 +80,6 @@ struct chrc {
 	struct io *write_io;
 	struct io *notify_io;
 	bool authorization_req;
-	bool authorized;
 };
 
 struct service {
@@ -1581,6 +1580,30 @@ static gboolean chrc_notify_acquired_exists(const GDBusPropertyTable *property,
 	return FALSE;
 }
 
+static gboolean chrc_get_authorize(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct chrc *chrc = data;
+	dbus_bool_t value;
+
+	value = chrc->authorization_req ? TRUE : FALSE;
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_BOOLEAN, &value);
+
+	return TRUE;
+}
+
+static gboolean chrc_get_authorize_exists(const GDBusPropertyTable *property,
+								void *data)
+{
+	struct chrc *chrc = data;
+
+	if (chrc->authorization_req)
+		return TRUE;
+
+	return FALSE;
+}
+
 static const GDBusPropertyTable chrc_properties[] = {
 	{ "UUID", "s", chrc_get_uuid, NULL, NULL },
 	{ "Service", "o", chrc_get_service, NULL, NULL },
@@ -1591,6 +1614,8 @@ static const GDBusPropertyTable chrc_properties[] = {
 					chrc_write_acquired_exists },
 	{ "NotifyAcquired", "b", chrc_get_notify_acquired, NULL,
 					chrc_notify_acquired_exists },
+	{ "Authorize", "b", chrc_get_authorize, NULL,
+						chrc_get_authorize_exists },
 	{ }
 };
 
@@ -1609,7 +1634,8 @@ static const char *path_to_address(const char *path)
 }
 
 static int parse_options(DBusMessageIter *iter, uint16_t *offset, uint16_t *mtu,
-						char **device, char **link)
+						char **device, char **link,
+						bool *prep_authorize)
 {
 	DBusMessageIter dict;
 
@@ -1650,6 +1676,12 @@ static int parse_options(DBusMessageIter *iter, uint16_t *offset, uint16_t *mtu,
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
@@ -1703,8 +1735,6 @@ static void authorize_read_response(const char *input, void *user_data)
 	reply = read_value(pending_message, &chrc->value[aad->offset],
 						chrc->value_len - aad->offset);
 
-	chrc->authorized = true;
-
 	g_dbus_send_message(aad->conn, reply);
 
 	g_free(aad);
@@ -1727,18 +1757,15 @@ static DBusMessage *chrc_read_value(DBusConnection *conn, DBusMessage *msg,
 
 	dbus_message_iter_init(msg, &iter);
 
-	if (parse_options(&iter, &offset, NULL, &device, &link))
+	if (parse_options(&iter, &offset, NULL, &device, &link, NULL))
 		return g_dbus_create_error(msg,
 					"org.bluez.Error.InvalidArguments",
 					NULL);
 
 	bt_shell_printf("ReadValue: %s offset %u link %s\n",
-			path_to_address(device), offset, link);
+					path_to_address(device), offset, link);
 
-	if (chrc->authorization_req && offset == 0)
-		chrc->authorized = false;
-
-	if (chrc->authorization_req && !chrc->authorized) {
+	if (chrc->authorization_req) {
 		struct authorize_attribute_data *aad;
 
 		aad = g_new0(struct authorize_attribute_data, 1);
@@ -1765,33 +1792,31 @@ static DBusMessage *chrc_read_value(DBusConnection *conn, DBusMessage *msg,
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
@@ -1800,12 +1825,26 @@ static void authorize_write_response(const char *input, void *user_data)
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
@@ -1813,15 +1852,17 @@ static void authorize_write_response(const char *input, void *user_data)
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
@@ -1848,18 +1889,31 @@ static DBusMessage *chrc_write_value(DBusConnection *conn, DBusMessage *msg,
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
@@ -1873,15 +1927,14 @@ static DBusMessage *chrc_write_value(DBusConnection *conn, DBusMessage *msg,
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
 
@@ -1943,7 +1996,7 @@ static DBusMessage *chrc_acquire_write(DBusConnection *conn, DBusMessage *msg,
 					"org.bluez.Error.NotPermitted",
 					NULL);
 
-	if (parse_options(&iter, NULL, &chrc->mtu, &device, &link))
+	if (parse_options(&iter, NULL, &chrc->mtu, &device, &link, NULL))
 		return g_dbus_create_error(msg,
 					"org.bluez.Error.InvalidArguments",
 					NULL);
@@ -1975,7 +2028,7 @@ static DBusMessage *chrc_acquire_notify(DBusConnection *conn, DBusMessage *msg,
 					"org.bluez.Error.NotPermitted",
 					NULL);
 
-	if (parse_options(&iter, NULL, &chrc->mtu, &device, &link))
+	if (parse_options(&iter, NULL, &chrc->mtu, &device, &link, NULL))
 		return g_dbus_create_error(msg,
 					"org.bluez.Error.InvalidArguments",
 					NULL);
@@ -2191,7 +2244,7 @@ static DBusMessage *desc_read_value(DBusConnection *conn, DBusMessage *msg,
 
 	dbus_message_iter_init(msg, &iter);
 
-	if (parse_options(&iter, &offset, NULL, &device, &link))
+	if (parse_options(&iter, &offset, NULL, &device, &link, NULL))
 		return g_dbus_create_error(msg,
 					"org.bluez.Error.InvalidArguments",
 					NULL);
@@ -2213,21 +2266,24 @@ static DBusMessage *desc_write_value(DBusConnection *conn, DBusMessage *msg,
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
-- 
2.13.6

