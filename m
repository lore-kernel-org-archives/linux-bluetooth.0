Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH obexd 1/7 v4] client: Add filters to Phonebook.PullAll
Date: Mon, 10 Sep 2012 11:02:53 +0300
Message-Id: <1347264179-31477-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This avoid D-Bus round trips and is more aligned with what has been
proposed for MessageAccess interface.
---
v3: Fix patch 2/7
v4: Fix not having an empty line before parse_filter in patch 1/7

 client/pbap.c | 256 +++++++++++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 210 insertions(+), 46 deletions(-)

diff --git a/client/pbap.c b/client/pbap.c
index ebd6320..b41412c 100644
--- a/client/pbap.c
+++ b/client/pbap.c
@@ -351,18 +351,191 @@ send:
 	pending_request_free(request);
 }
 
+static GObexApparam *parse_format(GObexApparam *apparam, DBusMessageIter *iter)
+{
+	const char *string;
+	guint8 format;
+
+	if (dbus_message_iter_get_arg_type(iter) != DBUS_TYPE_STRING)
+		return NULL;
+
+	dbus_message_iter_get_basic(iter, &string);
+
+	if (!string || g_str_equal(string, ""))
+		format = FORMAT_VCARD21;
+	else if (!g_ascii_strcasecmp(string, "vcard21"))
+		format = FORMAT_VCARD21;
+	else if (!g_ascii_strcasecmp(string, "vcard30"))
+		format = FORMAT_VCARD30;
+	else
+		return NULL;
+
+	return g_obex_apparam_set_uint8(apparam, FORMAT_TAG, format);
+}
+
+static GObexApparam *parse_order(GObexApparam *apparam, DBusMessageIter *iter)
+{
+	const char *string;
+	guint8 order;
+
+	if (dbus_message_iter_get_arg_type(iter) != DBUS_TYPE_STRING)
+		return NULL;
+
+	dbus_message_iter_get_basic(iter, &string);
+
+	if (!string || g_str_equal(string, ""))
+		order = ORDER_INDEXED;
+	else if (!g_ascii_strcasecmp(string, "indexed"))
+		order = ORDER_INDEXED;
+	else if (!g_ascii_strcasecmp(string, "alphanumeric"))
+		order = ORDER_ALPHANUMERIC;
+	else if (!g_ascii_strcasecmp(string, "phonetic"))
+		order = ORDER_PHONETIC;
+	else
+		return NULL;
+
+	return g_obex_apparam_set_uint8(apparam, ORDER_TAG, order);
+}
+
+static GObexApparam *parse_offset(GObexApparam *apparam, DBusMessageIter *iter)
+{
+	guint16 num;
+
+	if (dbus_message_iter_get_arg_type(iter) != DBUS_TYPE_UINT16)
+		return NULL;
+
+	dbus_message_iter_get_basic(iter, &num);
+
+	return g_obex_apparam_set_uint16(apparam, LISTSTARTOFFSET_TAG, num);
+}
+
+static GObexApparam *parse_max_count(GObexApparam *apparam,
+							DBusMessageIter *iter)
+{
+	guint16 num;
+
+	if (dbus_message_iter_get_arg_type(iter) != DBUS_TYPE_UINT16)
+		return NULL;
+
+	dbus_message_iter_get_basic(iter, &num);
+
+	return g_obex_apparam_set_uint16(apparam, MAXLISTCOUNT_TAG, num);
+}
+
+static uint64_t get_filter_mask(const char *filterstr)
+{
+	int i, bit = -1;
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
+	if (strlen(filterstr) < 4 || strlen(filterstr) > 5
+			|| g_ascii_strncasecmp(filterstr, "bit", 3) != 0)
+		return 0;
+
+	sscanf(&filterstr[3], "%d", &bit);
+	if (bit >= 0 && bit <= FILTER_BIT_MAX)
+		return 1ULL << bit;
+	else
+		return 0;
+}
+
+static int set_field(guint64 *filter, const char *filterstr)
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
+	guint64 filter = 0;
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
+	return g_obex_apparam_set_uint64(apparam, FILTER_TAG, filter);
+}
+
+static GObexApparam *parse_filters(GObexApparam *apparam,
+							DBusMessageIter *iter)
+{
+	DBusMessageIter array;
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
+		if (strcasecmp(key, "Format") == 0) {
+			if (parse_format(apparam, &value) == NULL)
+				return NULL;
+		} else if (strcasecmp(key, "Order") == 0) {
+			if (parse_order(apparam, &value) == NULL)
+				return NULL;
+		} else if (strcasecmp(key, "Offset") == 0) {
+			if (parse_offset(apparam, &value) == NULL)
+				return NULL;
+		} else if (strcasecmp(key, "MaxCount") == 0) {
+			if (parse_max_count(apparam, &value) == NULL)
+				return NULL;
+		} else if (strcasecmp(key, "Fields") == 0) {
+			if (parse_fields(apparam, &value) == NULL)
+				return NULL;
+		}
+
+		dbus_message_iter_next(&array);
+	}
+
+	return apparam;
+}
+
 static struct obc_transfer *pull_phonebook(struct pbap_data *pbap,
 						DBusMessage *message,
 						guint8 type, const char *name,
 						const char *targetfile,
-						uint64_t filter, guint8 format,
-						guint16 maxlistcount,
-						guint16 liststartoffset,
+						GObexApparam *apparam,
 						GError **err)
 {
 	struct pending_request *request;
 	struct obc_transfer *transfer;
-	GObexApparam *apparam;
 	guint8 buf[32];
 	gsize len;
 	session_callback_t func;
@@ -371,13 +544,6 @@ static struct obc_transfer *pull_phonebook(struct pbap_data *pbap,
 	if (transfer == NULL)
 		return NULL;
 
-	apparam = g_obex_apparam_set_uint64(NULL, FILTER_TAG, filter);
-	apparam = g_obex_apparam_set_uint8(apparam, FORMAT_TAG, format);
-	apparam = g_obex_apparam_set_uint16(apparam, MAXLISTCOUNT_TAG,
-							maxlistcount);
-	apparam = g_obex_apparam_set_uint16(apparam, LISTSTARTOFFSET_TAG,
-							liststartoffset);
-
 	switch (type) {
 	case PULLPHONEBOOK:
 		func = NULL;
@@ -396,8 +562,6 @@ static struct obc_transfer *pull_phonebook(struct pbap_data *pbap,
 
 	obc_transfer_set_params(transfer, buf, len);
 
-	g_obex_apparam_free(apparam);
-
 	if (!obc_session_queue(pbap->session, transfer, func, request, err)) {
 		if (request != NULL)
 			pending_request_free(request);
@@ -490,31 +654,6 @@ static int set_order(struct pbap_data *pbap, const char *orderstr)
 	return 0;
 }
 
-static uint64_t get_filter_mask(const char *filterstr)
-{
-	int i, bit = -1;
-
-	if (!filterstr)
-		return 0;
-
-	if (!g_ascii_strcasecmp(filterstr, "ALL"))
-		return FILTER_ALL;
-
-	for (i = 0; filter_list[i] != NULL; i++)
-		if (!g_ascii_strcasecmp(filterstr, filter_list[i]))
-			return 1ULL << i;
-
-	if (strlen(filterstr) < 4 || strlen(filterstr) > 5
-			|| g_ascii_strncasecmp(filterstr, "bit", 3) != 0)
-		return 0;
-
-	sscanf(&filterstr[3], "%d", &bit);
-	if (bit >= 0 && bit <= FILTER_BIT_MAX)
-		return 1ULL << bit;
-	else
-		return 0;
-}
-
 static int add_filter(struct pbap_data *pbap, const char *filterstr)
 {
 	uint64_t mask;
@@ -618,25 +757,41 @@ static DBusMessage *pbap_pull_all(DBusConnection *connection,
 	struct obc_transfer *transfer;
 	const char *targetfile;
 	char *name;
+	GObexApparam *apparam;
 	GError *err = NULL;
+	DBusMessageIter args;
 
 	if (!pbap->path)
 		return g_dbus_create_error(message,
 					ERROR_INTERFACE ".Forbidden",
 					"Call Select first of all");
 
-	if (dbus_message_get_args(message, NULL,
-			DBUS_TYPE_STRING, &targetfile,
-			DBUS_TYPE_INVALID) == FALSE)
+	dbus_message_iter_init(message, &args);
+
+	if (dbus_message_iter_get_arg_type(&args) != DBUS_TYPE_STRING)
 		return g_dbus_create_error(message,
 				ERROR_INTERFACE ".InvalidArguments", NULL);
 
+	dbus_message_iter_get_basic(&args, &targetfile);
+	dbus_message_iter_next(&args);
+
+	apparam = g_obex_apparam_set_uint16(NULL, MAXLISTCOUNT_TAG,
+							DEFAULT_COUNT);
+	apparam = g_obex_apparam_set_uint16(apparam, LISTSTARTOFFSET_TAG,
+							DEFAULT_OFFSET);
+
+	if (parse_filters(apparam, &args) == NULL) {
+		g_obex_apparam_free(apparam);
+		return g_dbus_create_error(message,
+				ERROR_INTERFACE ".InvalidArguments", NULL);
+	}
+
 	name = g_strconcat(pbap->path, ".vcf", NULL);
 
 	transfer = pull_phonebook(pbap, message, PULLPHONEBOOK, name,
-				targetfile, pbap->filter, pbap->format,
-				DEFAULT_COUNT, DEFAULT_OFFSET, &err);
+						targetfile, apparam, &err);
 	g_free(name);
+	g_obex_apparam_free(apparam);
 
 	if (transfer == NULL) {
 		DBusMessage *reply = g_dbus_create_error(message,
@@ -754,20 +909,28 @@ static DBusMessage *pbap_get_size(DBusConnection *connection,
 	DBusMessage *reply;
 	struct obc_transfer *transfer;
 	char *name;
+	GObexApparam *apparam;
 	GError *err = NULL;
+	DBusMessageIter args;
 
 	if (!pbap->path)
 		return g_dbus_create_error(message,
 					ERROR_INTERFACE ".Forbidden",
 					"Call Select first of all");
 
+	dbus_message_iter_init(message, &args);
+
 	name = g_strconcat(pbap->path, ".vcf", NULL);
 
+	apparam = g_obex_apparam_set_uint16(NULL, MAXLISTCOUNT_TAG, 0);
+	apparam = g_obex_apparam_set_uint16(apparam, LISTSTARTOFFSET_TAG,
+							DEFAULT_OFFSET);
+
 	transfer = pull_phonebook(pbap, message, GETPHONEBOOKSIZE, name, NULL,
-				pbap->filter, pbap->format, 0,
-				DEFAULT_OFFSET, &err);
+								apparam, &err);
 
 	g_free(name);
+	g_obex_apparam_free(apparam);
 
 	if (transfer != NULL)
 		return NULL;
@@ -891,7 +1054,8 @@ static const GDBusMethodTable pbap_methods[] = {
 			GDBUS_ARGS({ "location", "s" }, { "phonebook", "s" }),
 			NULL, pbap_select) },
 	{ GDBUS_METHOD("PullAll",
-			GDBUS_ARGS({ "targetfile", "s" }),
+			GDBUS_ARGS({ "targetfile", "s" },
+					{ "filters", "a{sv}" }),
 			GDBUS_ARGS({ "transfer", "o" },
 					{ "properties", "a{sv}" }),
 			pbap_pull_all) },
-- 
1.7.11.4

