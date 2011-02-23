Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Elvis=20Pf=C3=BCtzenreuter?= <epx@signove.com>
To: linux-bluetooth@vger.kernel.org
Cc: epx@signove.com
Subject: [PATCH 2/2 v3] Implement generic descriptor access to Attribute API
Date: Wed, 23 Feb 2011 10:49:40 -0300
Message-Id: <1298468980-2215-2-git-send-email-epx@signove.com>
In-Reply-To: <1298468980-2215-1-git-send-email-epx@signove.com>
References: <1298468980-2215-1-git-send-email-epx@signove.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch implements the proposed API changes.

Client Characteristic Configuration automatic update upon Watcher
registering will be handled by another series.
---
 attrib/client.c |  367 +++++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 files changed, 356 insertions(+), 11 deletions(-)

diff --git a/attrib/client.c b/attrib/client.c
index 0f9ba3e..711813b 100644
--- a/attrib/client.c
+++ b/attrib/client.c
@@ -79,6 +79,15 @@ struct primary {
 	GSList *watchers;
 };
 
+struct descriptor {
+	char *path;
+	uint16_t handle;
+	uuid_t uuid;
+	char type[MAX_LEN_UUID_STR + 1];
+	uint8_t *value;
+	size_t vlen;
+};
+
 struct characteristic {
 	struct primary *prim;
 	char *path;
@@ -91,12 +100,14 @@ struct characteristic {
 	struct format *format;
 	uint8_t *value;
 	size_t vlen;
+	GSList *descriptors;
 };
 
 struct query_data {
 	struct primary *prim;
 	struct characteristic *chr;
 	uint16_t handle;
+	struct descriptor *descr;
 };
 
 struct watcher {
@@ -110,10 +121,22 @@ static GSList *gatt_services = NULL;
 
 static DBusConnection *connection;
 
+static void descriptor_free(void *user_data)
+{
+	struct descriptor *descr = user_data;
+
+	g_free(descr->path);
+	g_free(descr->value);
+
+	g_free(descr);
+}
+
 static void characteristic_free(void *user_data)
 {
 	struct characteristic *chr = user_data;
 
+	g_slist_foreach(chr->descriptors, (GFunc) descriptor_free, NULL);
+
 	g_free(chr->path);
 	g_free(chr->desc);
 	g_free(chr->format);
@@ -188,11 +211,90 @@ static int watcher_cmp(gconstpointer a, gconstpointer b)
 	return g_strcmp0(watcher->path, match->path);
 }
 
+static void add_descriptor_dict(DBusMessageIter *entry,
+					struct descriptor *descr)
+{
+	DBusMessageIter descr_dict_var;
+	DBusMessageIter descr_dict;
+	const char *uuid;
+	const uint8_t *value;
+	size_t vlen;
+
+	value = descr->value;
+	vlen = descr->vlen;
+	uuid = descr->type;
+
+	dbus_message_iter_open_container(entry, DBUS_TYPE_VARIANT,
+			DBUS_TYPE_ARRAY_AS_STRING
+			DBUS_DICT_ENTRY_BEGIN_CHAR_AS_STRING
+			DBUS_TYPE_STRING_AS_STRING DBUS_TYPE_VARIANT_AS_STRING
+			DBUS_DICT_ENTRY_END_CHAR_AS_STRING,
+			&descr_dict_var);
+
+	dbus_message_iter_open_container(&descr_dict_var, DBUS_TYPE_ARRAY,
+			DBUS_DICT_ENTRY_BEGIN_CHAR_AS_STRING
+			DBUS_TYPE_STRING_AS_STRING DBUS_TYPE_VARIANT_AS_STRING
+			DBUS_DICT_ENTRY_END_CHAR_AS_STRING,
+			&descr_dict);
+
+	dict_append_entry(&descr_dict, "UUID", DBUS_TYPE_STRING, &uuid);
+
+	if (value)
+		dict_append_array(&descr_dict, "Value", DBUS_TYPE_BYTE,
+							&value, vlen);
+
+	dbus_message_iter_close_container(&descr_dict_var, &descr_dict);
+	dbus_message_iter_close_container(entry, &descr_dict_var);
+}
+
+static void add_descriptors_dict(DBusMessageIter *outer_entry,
+					struct characteristic *chr)
+{
+	DBusMessageIter descrs_dict_var;
+	DBusMessageIter descrs_dict;
+	GSList *l;
+
+	dbus_message_iter_open_container(outer_entry, DBUS_TYPE_VARIANT,
+			DBUS_TYPE_ARRAY_AS_STRING
+			DBUS_DICT_ENTRY_BEGIN_CHAR_AS_STRING
+			DBUS_TYPE_STRING_AS_STRING DBUS_TYPE_VARIANT_AS_STRING
+			DBUS_DICT_ENTRY_END_CHAR_AS_STRING,
+			&descrs_dict_var);
+
+	dbus_message_iter_open_container(&descrs_dict_var, DBUS_TYPE_ARRAY,
+			DBUS_DICT_ENTRY_BEGIN_CHAR_AS_STRING
+			DBUS_TYPE_STRING_AS_STRING DBUS_TYPE_VARIANT_AS_STRING
+			DBUS_DICT_ENTRY_END_CHAR_AS_STRING,
+			&descrs_dict);
+
+	for (l = chr->descriptors; l; l = l->next) {
+		struct descriptor *descr = l->data;
+		const char *key;
+		DBusMessageIter entry;
+
+		key = descr->path;
+
+		dbus_message_iter_open_container(&descrs_dict,
+			DBUS_TYPE_DICT_ENTRY, NULL, &entry);
+
+		dbus_message_iter_append_basic(&entry, DBUS_TYPE_STRING, &key);
+
+		add_descriptor_dict(&entry, descr);
+
+		dbus_message_iter_close_container(&descrs_dict, &entry);
+	}
+
+	dbus_message_iter_close_container(&descrs_dict_var, &descrs_dict);
+	dbus_message_iter_close_container(outer_entry, &descrs_dict_var);
+}
+
 static void append_char_dict(DBusMessageIter *iter, struct characteristic *chr)
 {
 	DBusMessageIter dict;
+	DBusMessageIter entry;
 	const char *name = "";
 	char *uuid;
+	const char *key;
 
 	dbus_message_iter_open_container(iter, DBUS_TYPE_ARRAY,
 			DBUS_DICT_ENTRY_BEGIN_CHAR_AS_STRING
@@ -214,6 +316,19 @@ static void append_char_dict(DBusMessageIter *iter, struct characteristic *chr)
 		dict_append_array(&dict, "Value", DBUS_TYPE_BYTE, &chr->value,
 								chr->vlen);
 
+	/* Descriptors entry */
+
+	dbus_message_iter_open_container(&dict, DBUS_TYPE_DICT_ENTRY,
+						NULL, &entry);
+
+	key = "Descriptors";
+
+	dbus_message_iter_append_basic(&entry, DBUS_TYPE_STRING, &key);
+
+	add_descriptors_dict(&entry, chr);
+
+	dbus_message_iter_close_container(&dict, &entry);
+
 	/* FIXME: Missing Format, Value and Representation */
 
 	dbus_message_iter_close_container(iter, &dict);
@@ -245,6 +360,19 @@ static int characteristic_set_value(struct characteristic *chr,
 	return 0;
 }
 
+static int descriptor_set_value(struct descriptor *descr,
+					const uint8_t *value, size_t vlen)
+{
+	descr->value = g_try_realloc(descr->value, vlen);
+	if (descr->value == NULL)
+		return -ENOMEM;
+
+	memcpy(descr->value, value, vlen);
+	descr->vlen = vlen;
+
+	return 0;
+}
+
 static void update_watchers(gpointer data, gpointer user_data)
 {
 	struct watcher *w = data;
@@ -483,6 +611,172 @@ static DBusMessage *set_value(DBusConnection *conn, DBusMessage *msg,
 	return dbus_message_new_method_return(msg);
 }
 
+static int descriptor_path_cmp(gconstpointer a, gconstpointer b)
+{
+	const struct descriptor *descr = a;
+	const char *path = b;
+
+	return strcmp(descr->path, path);
+}
+
+static struct descriptor *find_descriptor_by_path(struct characteristic *chr,
+							const char *path)
+{
+	GSList *ldescr;
+
+	ldescr = g_slist_find_custom(chr->descriptors, path,
+					descriptor_path_cmp);
+
+	if (ldescr)
+		return ldescr->data;
+
+	return NULL;
+}
+
+static int descriptor_handle_cmp(gconstpointer a, gconstpointer b)
+{
+	const struct descriptor *descr = a;
+	uint16_t handle = GPOINTER_TO_UINT(b);
+
+	return descr->handle - handle;
+}
+
+static struct descriptor *find_descriptor_by_handle(struct characteristic *chr,
+							guint handle)
+{
+	GSList *ldescr;
+
+	ldescr = g_slist_find_custom(chr->descriptors, GUINT_TO_POINTER(handle),
+					descriptor_handle_cmp);
+
+	if (ldescr)
+		return ldescr->data;
+
+	return NULL;
+}
+
+static DBusMessage *set_descriptor(DBusConnection *conn, DBusMessage *msg,
+			struct characteristic *chr, const char *path,
+			uint8_t *value, int len)
+{
+	struct gatt_service *gatt = chr->prim->gatt;
+	GError *gerr = NULL;
+	struct descriptor *descr;
+
+	descr = find_descriptor_by_path(chr, path);
+
+	if (!descr)
+		return btd_error_invalid_args(msg);
+
+	if (l2cap_connect(gatt, &gerr, FALSE) < 0) {
+		DBusMessage *reply = btd_error_failed(msg, gerr->message);
+		g_error_free(gerr);
+		return reply;
+	}
+
+	gatt_write_cmd(gatt->attrib, descr->handle, value, len, NULL, NULL);
+
+	descriptor_set_value(descr, value, len);
+
+	return dbus_message_new_method_return(msg);
+}
+
+static DBusMessage *set_descriptor_front(DBusConnection *conn,
+			DBusMessage *msg, DBusMessageIter *iter,
+			struct characteristic *chr)
+{
+	DBusMessageIter dict, entry;
+	DBusMessageIter descr_iter, descr_dict, descr_entry, sub;
+	int ctype;
+	const char *descriptor_path;
+	const char *key;
+	uint8_t *value;
+	int len;
+
+	if (dbus_message_iter_get_arg_type(iter) != DBUS_TYPE_ARRAY)
+		return btd_error_invalid_args(msg);
+
+	dbus_message_iter_recurse(iter, &dict);
+
+	if (dbus_message_iter_get_arg_type(&dict) != DBUS_TYPE_DICT_ENTRY)
+		return btd_error_invalid_args(msg);
+
+	/* Unpack descriptor entry */
+
+	dbus_message_iter_recurse(&dict, &entry);
+	ctype = dbus_message_iter_get_arg_type(&entry);
+
+	if (ctype != DBUS_TYPE_OBJECT_PATH && ctype != DBUS_TYPE_STRING)
+		return btd_error_invalid_args(msg);
+
+	/* Got descriptor path */
+
+	dbus_message_iter_get_basic(&entry, &descriptor_path);
+
+	dbus_message_iter_next(&entry);
+
+	/* Get descriptor dict */
+
+	if (dbus_message_iter_get_arg_type(&entry) == DBUS_TYPE_VARIANT)
+		dbus_message_iter_recurse(&entry, &descr_iter);
+	else
+		descr_iter = entry;
+
+	if (dbus_message_iter_get_arg_type(&descr_iter) != DBUS_TYPE_ARRAY)
+		return btd_error_invalid_args(msg);
+
+	/* Unpack descriptor dict */
+
+	dbus_message_iter_recurse(&descr_iter, &descr_dict);
+
+	while ((ctype = dbus_message_iter_get_arg_type(&descr_dict)) !=
+							DBUS_TYPE_INVALID) {
+		if (ctype != DBUS_TYPE_DICT_ENTRY)
+			return btd_error_invalid_args(msg);
+
+		/* Interpret descriptor dict's entry */
+
+		dbus_message_iter_recurse(&descr_dict, &descr_entry);
+
+		ctype = dbus_message_iter_get_arg_type(&descr_entry);
+		if (ctype != DBUS_TYPE_STRING)
+			return btd_error_invalid_args(msg);
+
+		dbus_message_iter_get_basic(&descr_entry, &key);
+
+		if (!g_str_equal(key, "Value")) {
+			dbus_message_iter_next(&descr_dict);
+			continue;
+		}
+
+		/* Key is Value, get array of bytes */
+
+		dbus_message_iter_next(&descr_entry);
+
+		ctype = dbus_message_iter_get_arg_type(&descr_entry);
+		if (ctype != DBUS_TYPE_ARRAY)
+			return btd_error_invalid_args(msg);
+
+		ctype = dbus_message_iter_get_element_type(&descr_entry);
+		if (ctype != DBUS_TYPE_BYTE)
+			return btd_error_invalid_args(msg);
+
+		dbus_message_iter_recurse(&descr_entry, &sub);
+		dbus_message_iter_get_fixed_array(&sub, &value, &len);
+
+		dbus_message_iter_next(&descr_dict);
+	}
+
+	/* Just one descriptor entry per SetProperty() call */
+
+	dbus_message_iter_next(&dict);
+
+	if (dbus_message_iter_get_arg_type(&dict) != DBUS_TYPE_INVALID)
+		return btd_error_invalid_args(msg);
+
+	return set_descriptor(conn, msg, chr, descriptor_path, value, len);
+}
+
 static DBusMessage *get_properties(DBusConnection *conn, DBusMessage *msg,
 								void *data)
 {
@@ -525,6 +819,8 @@ static DBusMessage *set_property(DBusConnection *conn,
 
 	if (g_str_equal("Value", property))
 		return set_value(conn, msg, &sub, chr);
+	else if (g_str_equal("Descriptors", property))
+		return set_descriptor_front(conn, msg, &sub, chr);
 
 	return btd_error_invalid_args(msg);
 }
@@ -737,6 +1033,26 @@ done:
 	g_free(current);
 }
 
+static void update_descriptor(guint8 status, const guint8 *pdu, guint16 len,
+							gpointer user_data)
+{
+	struct query_data *current = user_data;
+	struct gatt_service *gatt = current->prim->gatt;
+	struct descriptor *descr = current->descr;
+
+	if (status != 0)
+		goto done;
+
+	if (len < 2)
+		goto done;
+
+	descriptor_set_value(descr, pdu + 1, len - 1);
+
+done:
+	g_attrib_unref(gatt->attrib);
+	g_free(current);
+}
+
 static void update_char_value(guint8 status, const guint8 *pdu,
 					guint16 len, gpointer user_data)
 {
@@ -762,6 +1078,31 @@ static void update_char_value(guint8 status, const guint8 *pdu,
 	g_free(current);
 }
 
+static struct descriptor *char_add_descriptor(struct characteristic *chr,
+						uint16_t handle, uuid_t uuid)
+{
+	struct descriptor *descr;
+
+	descr = find_descriptor_by_handle(chr, handle);
+
+	if (!descr) {
+		descr = g_new0(struct descriptor, 1);
+		descr->path = g_strdup_printf("%s/descriptor%04x",
+						chr->path, handle);
+		descr->handle = handle;
+		chr->descriptors = g_slist_append(chr->descriptors, descr);
+	}
+
+	if (sdp_uuid_cmp(&uuid, &descr->uuid) != 0) {
+		char *uuidstr = bt_uuid2string(&uuid);
+		strcpy(descr->type, uuidstr);
+		g_free(uuidstr);
+		descr->uuid = uuid;
+	}
+
+	return descr;
+}
+
 static int uuid_desc16_cmp(uuid_t *uuid, guint16 desc)
 {
 	uuid_t u16;
@@ -783,7 +1124,7 @@ static void descriptor_cb(guint8 status, const guint8 *pdu, guint16 plen,
 	if (status != 0)
 		goto done;
 
-	DBG("Find Information Response received");
+	DBG("Discover Descriptors Response received");
 
 	list = dec_find_info_resp(pdu, plen, &format);
 	if (list == NULL)
@@ -797,15 +1138,14 @@ static void descriptor_cb(guint8 status, const guint8 *pdu, guint16 plen,
 
 		handle = att_get_u16(info);
 
-		if (format == 0x01) {
+		if (format == 0x01)
 			sdp_uuid16_create(&uuid, att_get_u16(&info[2]));
-		} else {
-			/* Currently, only "user description" and "presentation
-			 * format" descriptors are used, and both have 16-bit
-			 * UUIDs. Therefore there is no need to support format
-			 * 0x02 yet. */
+		else if (format == 0x02)
+			// FIXME use att_get_u128
+			sdp_uuid128_create(&uuid, &info[2]);
+		else
 			continue;
-		}
+
 		qfmt = g_new0(struct query_data, 1);
 		qfmt->prim = current->prim;
 		qfmt->chr = current->chr;
@@ -819,8 +1159,13 @@ static void descriptor_cb(guint8 status, const guint8 *pdu, guint16 plen,
 			gatt->attrib = g_attrib_ref(gatt->attrib);
 			gatt_read_char(gatt->attrib, handle,
 						update_char_format, qfmt);
-		} else
-			g_free(qfmt);
+		} else {
+			qfmt->descr = char_add_descriptor(current->chr, handle,
+								uuid);
+			gatt->attrib = g_attrib_ref(gatt->attrib);
+			gatt_read_char(gatt->attrib, handle, update_descriptor,
+									qfmt);
+		}
 	}
 
 	att_data_list_free(list);
@@ -888,7 +1233,7 @@ static void char_discovered_cb(GSList *characteristics, guint8 status,
 		strncpy(chr->type, current_chr->uuid, sizeof(chr->type));
 
 		if (previous_end)
-			*previous_end = current_chr->handle;
+			*previous_end = current_chr->handle - 1;
 
 		previous_end = &chr->end;
 
-- 
1.7.1

