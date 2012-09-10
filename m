Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH obexd 4/7 v4] client: Remove deprecated methods from PhonebookAccess
Date: Mon, 10 Sep 2012 11:02:56 +0300
Message-Id: <1347264179-31477-4-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1347264179-31477-1-git-send-email-luiz.dentz@gmail.com>
References: <1347264179-31477-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

SetFormat, SetOrder, SetFilter and GetFilter methods are no longer
necessary as other methods now take them as parameters to avoid round
trips.
---
 client/pbap.c | 197 +++++-----------------------------------------------------
 1 file changed, 14 insertions(+), 183 deletions(-)

diff --git a/client/pbap.c b/client/pbap.c
index 2f1dd5f..c0ccbdc 100644
--- a/client/pbap.c
+++ b/client/pbap.c
@@ -116,9 +116,6 @@ static const char *filter_list[] = {
 struct pbap_data {
 	struct obc_session *session;
 	char *path;
-	guint8 format;
-	guint8 order;
-	uint64_t filter;
 };
 
 struct pending_request {
@@ -607,91 +604,6 @@ fail:
 	return reply;
 }
 
-static int set_format(struct pbap_data *pbap, const char *formatstr)
-{
-	if (!formatstr || g_str_equal(formatstr, "")) {
-		pbap->format = FORMAT_VCARD21;
-		return 0;
-	}
-
-	if (!g_ascii_strcasecmp(formatstr, "vcard21"))
-		pbap->format = FORMAT_VCARD21;
-	else if (!g_ascii_strcasecmp(formatstr, "vcard30"))
-		pbap->format = FORMAT_VCARD30;
-	else
-		return -EINVAL;
-
-	return 0;
-}
-
-static int set_order(struct pbap_data *pbap, const char *orderstr)
-{
-	if (!orderstr || g_str_equal(orderstr, "")) {
-		pbap->order = ORDER_INDEXED;
-		return 0;
-	}
-
-	if (!g_ascii_strcasecmp(orderstr, "indexed"))
-		pbap->order = ORDER_INDEXED;
-	else if (!g_ascii_strcasecmp(orderstr, "alphanumeric"))
-		pbap->order = ORDER_ALPHANUMERIC;
-	else if (!g_ascii_strcasecmp(orderstr, "phonetic"))
-		pbap->order = ORDER_PHONETIC;
-	else
-		return -EINVAL;
-
-	return 0;
-}
-
-static int add_filter(struct pbap_data *pbap, const char *filterstr)
-{
-	uint64_t mask;
-
-	mask = get_filter_mask(filterstr);
-
-	if (mask == 0)
-		return -EINVAL;
-
-	pbap->filter |= mask;
-	return 0;
-}
-
-static int remove_filter(struct pbap_data *pbap, const char *filterstr)
-{
-	uint64_t mask;
-
-	mask = get_filter_mask(filterstr);
-
-	if (mask == 0)
-		return -EINVAL;
-
-	pbap->filter &= ~mask;
-	return 0;
-}
-
-static gchar **get_filter_strs(uint64_t filter, gint *size)
-{
-	gchar **list, **item;
-	gint i;
-	gint filter_list_size = sizeof(filter_list) / sizeof(filter_list[0]) - 1;
-
-	list = g_malloc0(sizeof(gchar **) * (FILTER_BIT_MAX + 2));
-
-	item = list;
-
-	for (i = 0; i < filter_list_size; i++)
-		if (filter & (1ULL << i))
-			*(item++) = g_strdup(filter_list[i]);
-
-	for (i = filter_list_size; i <= FILTER_BIT_MAX; i++)
-		if (filter & (1ULL << i))
-			*(item++) = g_strdup_printf("%s%d", "BIT", i);
-
-	*item = NULL;
-	*size = item - list;
-	return list;
-}
-
 static DBusMessage *pbap_select(DBusConnection *connection,
 					DBusMessage *message, void *user_data)
 {
@@ -1001,95 +913,26 @@ static DBusMessage *pbap_get_size(DBusConnection *connection,
 	return reply;
 }
 
-static DBusMessage *pbap_set_format(DBusConnection *connection,
-					DBusMessage *message, void *user_data)
-{
-	struct pbap_data *pbap = user_data;
-	const char *format;
-
-	if (dbus_message_get_args(message, NULL,
-			DBUS_TYPE_STRING, &format,
-			DBUS_TYPE_INVALID) == FALSE)
-		return g_dbus_create_error(message,
-				ERROR_INTERFACE ".InvalidArguments", NULL);
-
-	if (set_format(pbap, format) < 0)
-		return g_dbus_create_error(message,
-					ERROR_INTERFACE ".InvalidArguments",
-					"InvalidFormat");
-
-	return dbus_message_new_method_return(message);
-}
-
-static DBusMessage *pbap_set_order(DBusConnection *connection,
-					DBusMessage *message, void *user_data)
-{
-	struct pbap_data *pbap = user_data;
-	const char *order;
-
-	if (dbus_message_get_args(message, NULL,
-			DBUS_TYPE_STRING, &order,
-			DBUS_TYPE_INVALID) == FALSE)
-		return g_dbus_create_error(message,
-				ERROR_INTERFACE ".InvalidArguments", NULL);
-
-	if (set_order(pbap, order) < 0)
-		return g_dbus_create_error(message,
-					ERROR_INTERFACE ".InvalidArguments",
-					"InvalidFilter");
-
-	return dbus_message_new_method_return(message);
-}
-
-static DBusMessage *pbap_set_filter(DBusConnection *connection,
-					DBusMessage *message, void *user_data)
+static gchar **get_filter_strs(uint64_t filter, gint *size)
 {
-	struct pbap_data *pbap = user_data;
-	char **filters, **item;
-	gint size;
-	uint64_t oldfilter = pbap->filter;
-
-	if (dbus_message_get_args(message, NULL, DBUS_TYPE_ARRAY,
-			DBUS_TYPE_STRING, &filters, &size,
-			DBUS_TYPE_INVALID) == FALSE)
-		return g_dbus_create_error(message,
-				ERROR_INTERFACE ".InvalidArguments", NULL);
-
-	remove_filter(pbap, "ALL");
-	if (size == 0)
-		goto done;
+	gchar **list, **item;
+	gint i;
 
-	for (item = filters; *item; item++) {
-		if (add_filter(pbap, *item) < 0) {
-			pbap->filter = oldfilter;
-			g_strfreev(filters);
-			return g_dbus_create_error(message,
-					ERROR_INTERFACE ".InvalidArguments",
-					"InvalidFilters");
-		}
-	}
+	list = g_malloc0(sizeof(gchar **) * (FILTER_BIT_MAX + 2));
 
-done:
-	g_strfreev(filters);
-	return dbus_message_new_method_return(message);
-}
+	item = list;
 
-static DBusMessage *pbap_get_filter(DBusConnection *connection,
-					DBusMessage *message, void *user_data)
-{
-	struct pbap_data *pbap = user_data;
-	gchar **filters = NULL;
-	gint size;
-	DBusMessage *reply;
+	for (i = 0; filter_list[i] != NULL; i++)
+		if (filter & (1ULL << i))
+			*(item++) = g_strdup(filter_list[i]);
 
-	filters = get_filter_strs(pbap->filter, &size);
-	reply = dbus_message_new_method_return(message);
-	dbus_message_append_args(reply, DBUS_TYPE_ARRAY,
-				DBUS_TYPE_STRING, &filters, size,
-				DBUS_TYPE_INVALID);
+	for (; i <= FILTER_BIT_MAX; i++)
+		if (filter & (1ULL << i))
+			*(item++) = g_strdup_printf("%s%d", "BIT", i);
 
-	g_strfreev(filters);
-	return reply;
+	*item = NULL;
+	*size = item - list;
+	return list;
 }
 
 static DBusMessage *pbap_list_filter_fields(DBusConnection *connection,
@@ -1137,18 +980,6 @@ static const GDBusMethodTable pbap_methods[] = {
 	{ GDBUS_ASYNC_METHOD("GetSize",
 				NULL, GDBUS_ARGS({ "size", "q" }),
 				pbap_get_size) },
-	{ GDBUS_METHOD("SetFormat",
-				GDBUS_ARGS({ "format", "s" }), NULL,
-				pbap_set_format) },
-	{ GDBUS_METHOD("SetOrder",
-				GDBUS_ARGS({ "order", "s" }), NULL,
-				pbap_set_order) },
-	{ GDBUS_METHOD("SetFilter",
-				GDBUS_ARGS({ "fields", "as" }), NULL,
-				pbap_set_filter) },
-	{ GDBUS_METHOD("GetFilter",
-				NULL, GDBUS_ARGS({ "fields", "as" }),
-				pbap_get_filter) },
 	{ GDBUS_METHOD("ListFilterFields",
 				NULL, GDBUS_ARGS({ "fields", "as" }),
 				pbap_list_filter_fields) },
-- 
1.7.11.4

