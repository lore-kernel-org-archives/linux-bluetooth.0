Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/5] client: Define maximum attribute value length as initial value
Date: Wed,  9 May 2018 13:05:50 +0200
Message-Id: <20180509110553.28989-2-grzegorz.kolodziejczyk@codecoup.pl>
In-Reply-To: <20180509110553.28989-1-grzegorz.kolodziejczyk@codecoup.pl>
References: <20180509110553.28989-1-grzegorz.kolodziejczyk@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Initial registered attribute value is set as maximal attribute length.
---
 client/gatt.c | 54 +++++++++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 45 insertions(+), 9 deletions(-)

diff --git a/client/gatt.c b/client/gatt.c
index c8267a75f..1b4e713ef 100644
--- a/client/gatt.c
+++ b/client/gatt.c
@@ -54,12 +54,15 @@
 #define COLORED_CHG	COLOR_YELLOW "CHG" COLOR_OFF
 #define COLORED_DEL	COLOR_RED "DEL" COLOR_OFF
 
+#define MAX_ATTR_VAL_LEN	512
+
 struct desc {
 	struct chrc *chrc;
 	char *path;
 	char *uuid;
 	char **flags;
 	int value_len;
+	unsigned int max_val_len;
 	uint8_t *value;
 };
 
@@ -71,6 +74,7 @@ struct chrc {
 	bool notifying;
 	GList *descs;
 	int value_len;
+	unsigned int max_val_len;
 	uint8_t *value;
 	uint16_t mtu;
 	struct io *write_io;
@@ -612,7 +616,7 @@ static void write_attribute(GDBusProxy *proxy, char *val_str, uint16_t offset)
 {
 	struct iovec iov;
 	struct write_attribute_data wd;
-	uint8_t value[512];
+	uint8_t value[MAX_ATTR_VAL_LEN];
 	char *entry;
 	unsigned int i;
 
@@ -689,7 +693,7 @@ void gatt_write_attribute(GDBusProxy *proxy, int argc, char *argv[])
 static bool pipe_read(struct io *io, void *user_data)
 {
 	struct chrc *chrc = user_data;
-	uint8_t buf[512];
+	uint8_t buf[MAX_ATTR_VAL_LEN];
 	int fd = io_get_fd(io);
 	ssize_t bytes_read;
 
@@ -1612,7 +1616,8 @@ static DBusMessage *chrc_read_value(DBusConnection *conn, DBusMessage *msg,
 	return read_value(msg, &chrc->value[offset], chrc->value_len - offset);
 }
 
-static int parse_value_arg(DBusMessageIter *iter, uint8_t **value, int *len)
+static int parse_value_arg(DBusMessageIter *iter, uint8_t **value, int *len,
+								int max_len)
 {
 	DBusMessageIter array;
 	uint16_t offset = 0;
@@ -1629,6 +1634,9 @@ static int parse_value_arg(DBusMessageIter *iter, uint8_t **value, int *len)
 	if (parse_options(iter, &offset, NULL, NULL, NULL))
 		return -EINVAL;
 
+	if ((offset + read_len) > max_len)
+		return -EOVERFLOW;
+
 	if ((offset + read_len) > *len) {
 		*len = offset + read_len;
 		*value = g_realloc(*value, *len);
@@ -1646,6 +1654,7 @@ static void authorize_write_response(const char *input, void *user_data)
 	DBusMessageIter iter;
 	DBusMessage *reply;
 	char *err;
+	int errsv;
 
 	dbus_message_iter_init(pending_message, &iter);
 
@@ -1657,10 +1666,16 @@ static void authorize_write_response(const char *input, void *user_data)
 
 	chrc->authorized = true;
 
-	if (parse_value_arg(&iter, &chrc->value, &chrc->value_len)) {
+	errsv = parse_value_arg(&iter, &chrc->value, &chrc->value_len,
+							chrc->max_val_len);
+	if (errsv == -EINVAL) {
 		err = "org.bluez.Error.InvalidArguments";
 
 		goto error;
+	} else if (errsv == -EOVERFLOW) {
+		err = "org.bluez.Error.InvalidValueLength";
+
+		goto error;
 	}
 
 	bt_shell_printf("[" COLORED_CHG "] Attribute %s written" , chrc->path);
@@ -1686,6 +1701,7 @@ static DBusMessage *chrc_write_value(DBusConnection *conn, DBusMessage *msg,
 	struct chrc *chrc = user_data;
 	DBusMessageIter iter;
 	char *str;
+	int errsv;
 
 	dbus_message_iter_init(msg, &iter);
 
@@ -1708,10 +1724,15 @@ static DBusMessage *chrc_write_value(DBusConnection *conn, DBusMessage *msg,
 		return NULL;
 	}
 
-	if (parse_value_arg(&iter, &chrc->value, &chrc->value_len))
+	errsv = parse_value_arg(&iter, &chrc->value, &chrc->value_len,
+							chrc->max_val_len);
+	if (errsv == -EINVAL) {
 		return g_dbus_create_error(msg,
-					"org.bluez.Error.InvalidArguments",
-					NULL);
+				"org.bluez.Error.InvalidArguments", NULL);
+	} else if (errsv == -EOVERFLOW) {
+		return g_dbus_create_error(msg,
+				"org.bluez.Error.InvalidValueLength", NULL);
+	}
 
 	bt_shell_printf("[" COLORED_CHG "] Attribute %s written" , chrc->path);
 
@@ -1885,7 +1906,7 @@ static const GDBusMethodTable chrc_methods[] = {
 
 static uint8_t *str2bytearray(char *arg, int *val_len)
 {
-	uint8_t value[512];
+	uint8_t value[MAX_ATTR_VAL_LEN];
 	char *entry;
 	unsigned int i;
 
@@ -1922,6 +1943,13 @@ static void chrc_set_value(const char *input, void *user_data)
 	g_free(chrc->value);
 
 	chrc->value = str2bytearray((char *) input, &chrc->value_len);
+
+	if (!chrc->value) {
+		print_chrc(chrc, COLORED_DEL);
+		chrc_unregister(chrc);
+	}
+
+	chrc->max_val_len = chrc->value_len;
 }
 
 void gatt_register_chrc(DBusConnection *conn, GDBusProxy *proxy,
@@ -2039,7 +2067,8 @@ static DBusMessage *desc_write_value(DBusConnection *conn, DBusMessage *msg,
 
 	dbus_message_iter_init(msg, &iter);
 
-	if (parse_value_arg(&iter, &desc->value, &desc->value_len))
+	if (parse_value_arg(&iter, &desc->value, &desc->value_len,
+							desc->max_val_len))
 		return g_dbus_create_error(msg,
 					"org.bluez.Error.InvalidArguments",
 					NULL);
@@ -2143,6 +2172,13 @@ static void desc_set_value(const char *input, void *user_data)
 	g_free(desc->value);
 
 	desc->value = str2bytearray((char *) input, &desc->value_len);
+
+	if (!desc->value) {
+		print_desc(desc, COLORED_DEL);
+		desc_unregister(desc);
+	}
+
+	desc->max_val_len = desc->value_len;
 }
 
 void gatt_register_desc(DBusConnection *conn, GDBusProxy *proxy,
-- 
2.13.6

