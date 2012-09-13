Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH obexd 2/8] client: Rename MessageAccess method GetMessagesListing to ListMessages
Date: Thu, 13 Sep 2012 16:06:55 +0300
Message-Id: <1347541621-26858-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1347541621-26858-1-git-send-email-luiz.dentz@gmail.com>
References: <1347541621-26858-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

In addition to that add missing parsing of the filters
---
 client/map.c | 317 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 302 insertions(+), 15 deletions(-)

diff --git a/client/map.c b/client/map.c
index a7bdf08..6d1b0f2 100644
--- a/client/map.c
+++ b/client/map.c
@@ -26,6 +26,7 @@
 
 #include <errno.h>
 #include <string.h>
+#include <stdio.h>
 #include <glib.h>
 #include <gdbus.h>
 
@@ -52,6 +53,29 @@
 #define DEFAULT_COUNT 1024
 #define DEFAULT_OFFSET 0
 
+static const char * const filter_list[] = {
+	"subject",
+	"timestamp",
+	"sender",
+	"sender-address",
+	"recipient",
+	"recipient-address",
+	"type",
+	"size",
+	"status",
+	"text",
+	"attachment",
+	"priority",
+	"read",
+	"sent",
+	"protected",
+	"replyto",
+	NULL
+};
+
+#define FILTER_BIT_MAX	15
+#define FILTER_ALL	0xFF
+
 struct map_data {
 	struct obc_session *session;
 	DBusMessage *msg;
@@ -689,28 +713,26 @@ done:
 	dbus_message_unref(map->msg);
 }
 
-static DBusMessage *map_get_message_listing(DBusConnection *connection,
-					DBusMessage *message, void *user_data)
+static DBusMessage *get_message_listing(struct map_data *map,
+							DBusMessage *message,
+							const char *folder,
+							GObexApparam *apparam)
 {
-	struct map_data *map = user_data;
 	struct obc_transfer *transfer;
-	const char *folder;
-	DBusMessageIter msg_iter;
 	GError *err = NULL;
 	DBusMessage *reply;
+	guint8 buf[1024];
+	gsize len;
 
-	dbus_message_iter_init(message, &msg_iter);
-
-	if (dbus_message_iter_get_arg_type(&msg_iter) != DBUS_TYPE_STRING)
-		return g_dbus_create_error(message,
-				ERROR_INTERFACE ".InvalidArguments", NULL);
-
-	dbus_message_iter_get_basic(&msg_iter, &folder);
+	len = g_obex_apparam_encode(apparam, buf, sizeof(buf));
+	g_obex_apparam_free(apparam);
 
 	transfer = obc_transfer_get("x-bt/MAP-msg-listing", folder, NULL, &err);
 	if (transfer == NULL)
 		goto fail;
 
+	obc_transfer_set_params(transfer, buf, len);
+
 	if (obc_session_queue(map->session, transfer, message_listing_cb, map,
 								&err)) {
 		map->msg = dbus_message_ref(message);
@@ -724,6 +746,271 @@ fail:
 	return reply;
 }
 
+static uint64_t get_filter_mask(const char *filterstr)
+{
+	int i;
+
+	if (!filterstr)
+		return 0;
+
+	if (!g_ascii_strcasecmp(filterstr, "ALL"))
+		return FILTER_ALL;
+
+	for (i = 0; filter_list[i] != NULL; i++)
+		if (!g_ascii_strcasecmp(filterstr, filter_list[i]))
+			return 1ULL << i;
+
+	return 0;
+}
+
+static int set_field(guint32 *filter, const char *filterstr)
+{
+	guint64 mask;
+
+	mask = get_filter_mask(filterstr);
+
+	if (mask == 0)
+		return -EINVAL;
+
+	*filter |= mask;
+	return 0;
+}
+
+static GObexApparam *parse_fields(GObexApparam *apparam, DBusMessageIter *iter)
+{
+	DBusMessageIter array;
+	guint32 filter = 0;
+
+	if (dbus_message_iter_get_arg_type(iter) != DBUS_TYPE_ARRAY)
+		return NULL;
+
+	dbus_message_iter_recurse(iter, &array);
+
+	while (dbus_message_iter_get_arg_type(&array) == DBUS_TYPE_STRING) {
+		const char *string;
+
+		dbus_message_iter_get_basic(&array, &string);
+
+		if (set_field(&filter, string) < 0)
+			return NULL;
+
+		dbus_message_iter_next(&array);
+	}
+
+	return g_obex_apparam_set_uint32(apparam, MAP_AP_PARAMETERMASK,
+								filter);
+}
+
+static GObexApparam *parse_filter_type(GObexApparam *apparam,
+							DBusMessageIter *iter)
+{
+	DBusMessageIter array;
+	guint8 types = 0;
+
+	if (dbus_message_iter_get_arg_type(iter) != DBUS_TYPE_ARRAY)
+		return NULL;
+
+	dbus_message_iter_recurse(iter, &array);
+
+	while (dbus_message_iter_get_arg_type(&array) == DBUS_TYPE_STRING) {
+		const char *string;
+
+		dbus_message_iter_get_basic(&array, &string);
+
+		if (!g_ascii_strcasecmp(string, "sms"))
+			types |= 0x03; /* SMS_GSM and SMS_CDMA */
+		else if (!g_ascii_strcasecmp(string, "email"))
+			types |= 0x04; /* EMAIL */
+		else if (!g_ascii_strcasecmp(string, "mms"))
+			types |= 0x08; /* MMS */
+		else
+			return NULL;
+	}
+
+	return g_obex_apparam_set_uint8(apparam, MAP_AP_FILTERMESSAGETYPE,
+									types);
+}
+
+static GObexApparam *parse_period_begin(GObexApparam *apparam,
+							DBusMessageIter *iter)
+{
+	const char *string;
+
+	if (dbus_message_iter_get_arg_type(iter) != DBUS_TYPE_STRING)
+		return NULL;
+
+	dbus_message_iter_get_basic(iter, &string);
+
+	return g_obex_apparam_set_string(apparam, MAP_AP_FILTERPERIODBEGIN,
+								string);
+}
+
+static GObexApparam *parse_period_end(GObexApparam *apparam,
+							DBusMessageIter *iter)
+{
+	const char *string;
+
+	if (dbus_message_iter_get_arg_type(iter) != DBUS_TYPE_STRING)
+		return NULL;
+
+	dbus_message_iter_get_basic(iter, &string);
+
+	return g_obex_apparam_set_string(apparam, MAP_AP_FILTERPERIODEND,
+								string);
+}
+
+static GObexApparam *parse_filter_read(GObexApparam *apparam,
+							DBusMessageIter *iter)
+{
+	guint8 status = 0;
+
+	if (dbus_message_iter_get_arg_type(iter) != DBUS_TYPE_BOOLEAN)
+		return NULL;
+
+	dbus_message_iter_get_basic(iter, &status);
+
+	status = (status) ? 0x01 : 0x02;
+
+	return g_obex_apparam_set_uint8(apparam, MAP_AP_FILTERREADSTATUS,
+								status);
+}
+
+static GObexApparam *parse_filter_recipient(GObexApparam *apparam,
+							DBusMessageIter *iter)
+{
+	const char *string;
+
+	if (dbus_message_iter_get_arg_type(iter) != DBUS_TYPE_STRING)
+		return NULL;
+
+	dbus_message_iter_get_basic(iter, &string);
+
+	return g_obex_apparam_set_string(apparam, MAP_AP_FILTERRECIPIENT,
+								string);
+}
+
+static GObexApparam *parse_filter_sender(GObexApparam *apparam,
+							DBusMessageIter *iter)
+{
+	const char *string;
+
+	if (dbus_message_iter_get_arg_type(iter) != DBUS_TYPE_STRING)
+		return NULL;
+
+	dbus_message_iter_get_basic(iter, &string);
+
+	return g_obex_apparam_set_string(apparam, MAP_AP_FILTERORIGINATOR,
+								string);
+}
+
+static GObexApparam *parse_filter_priority(GObexApparam *apparam,
+							DBusMessageIter *iter)
+{
+	guint8 priority;
+
+	if (dbus_message_iter_get_arg_type(iter) != DBUS_TYPE_BOOLEAN)
+		return NULL;
+
+	dbus_message_iter_get_basic(iter, &priority);
+
+	priority = (priority) ? 0x01 : 0x02;
+
+	return g_obex_apparam_set_uint8(apparam, MAP_AP_FILTERPRIORITY,
+								priority);
+}
+
+static GObexApparam *parse_message_filters(GObexApparam *apparam,
+							DBusMessageIter *iter)
+{
+	DBusMessageIter array;
+
+	DBG("");
+
+	if (dbus_message_iter_get_arg_type(iter) != DBUS_TYPE_ARRAY)
+		return NULL;
+
+	dbus_message_iter_recurse(iter, &array);
+
+	while (dbus_message_iter_get_arg_type(&array) == DBUS_TYPE_DICT_ENTRY) {
+		const char *key;
+		DBusMessageIter value, entry;
+
+		dbus_message_iter_recurse(&array, &entry);
+		dbus_message_iter_get_basic(&entry, &key);
+
+		dbus_message_iter_next(&entry);
+		dbus_message_iter_recurse(&entry, &value);
+
+		if (strcasecmp(key, "Offset") == 0) {
+			if (parse_offset(apparam, &value) == NULL)
+				return NULL;
+		} else if (strcasecmp(key, "MaxCount") == 0) {
+			if (parse_max_count(apparam, &value) == NULL)
+				return NULL;
+		} else if (strcasecmp(key, "Fields") == 0) {
+			if (parse_fields(apparam, &value) == NULL)
+				return NULL;
+		} else if (strcasecmp(key, "Types") == 0) {
+			if (parse_filter_type(apparam, &value) == NULL)
+				return NULL;
+		} else if (strcasecmp(key, "PeriodBegin") == 0) {
+			if (parse_period_begin(apparam, &value) == NULL)
+				return NULL;
+		} else if (strcasecmp(key, "PeriodEnd") == 0) {
+			if (parse_period_end(apparam, &value) == NULL)
+				return NULL;
+		} else if (strcasecmp(key, "Read") == 0) {
+			if (parse_filter_read(apparam, &value) == NULL)
+				return NULL;
+		} else if (strcasecmp(key, "Recipient") == 0) {
+			if (parse_filter_recipient(apparam, &value) == NULL)
+				return NULL;
+		} else if (strcasecmp(key, "Sender") == 0) {
+			if (parse_filter_sender(apparam, &value) == NULL)
+				return NULL;
+		} else if (strcasecmp(key, "Priority") == 0) {
+			if (parse_filter_priority(apparam, &value) == NULL)
+				return NULL;
+		}
+
+		dbus_message_iter_next(&array);
+	}
+
+	return apparam;
+}
+
+static DBusMessage *map_list_messages(DBusConnection *connection,
+					DBusMessage *message, void *user_data)
+{
+	struct map_data *map = user_data;
+	const char *folder;
+	GObexApparam *apparam;
+	DBusMessageIter args;
+
+	dbus_message_iter_init(message, &args);
+
+	if (dbus_message_iter_get_arg_type(&args) != DBUS_TYPE_STRING)
+		return g_dbus_create_error(message,
+				ERROR_INTERFACE ".InvalidArguments", NULL);
+
+	dbus_message_iter_get_basic(&args, &folder);
+
+	apparam = g_obex_apparam_set_uint16(NULL, MAP_AP_MAXLISTCOUNT,
+							DEFAULT_COUNT);
+	apparam = g_obex_apparam_set_uint16(apparam, MAP_AP_STARTOFFSET,
+							DEFAULT_OFFSET);
+
+	dbus_message_iter_next(&args);
+
+	if (parse_message_filters(apparam, &args) == NULL) {
+		g_obex_apparam_free(apparam);
+		return g_dbus_create_error(message,
+				ERROR_INTERFACE ".InvalidArguments", NULL);
+	}
+
+	return get_message_listing(map, message, folder, apparam);
+}
+
 static const GDBusMethodTable map_methods[] = {
 	{ GDBUS_ASYNC_METHOD("SetFolder",
 				GDBUS_ARGS({ "name", "s" }), NULL,
@@ -732,10 +1019,10 @@ static const GDBusMethodTable map_methods[] = {
 			GDBUS_ARGS({ "filters", "a{sv}" }),
 			GDBUS_ARGS({ "content", "aa{sv}" }),
 			map_list_folders) },
-	{ GDBUS_ASYNC_METHOD("GetMessageListing",
-			GDBUS_ARGS({ "folder", "s" }, { "filter", "a{ss}" }),
+	{ GDBUS_ASYNC_METHOD("ListMessages",
+			GDBUS_ARGS({ "folder", "s" }, { "filter", "a{sv}" }),
 			GDBUS_ARGS({ "messages", "a{oa{sv}}" }),
-			map_get_message_listing) },
+			map_list_messages) },
 	{ }
 };
 
-- 
1.7.11.4

