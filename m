Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH obexd 3/7 v4] client: Add filters to PhonebookAccess.List and PhonebookAccess.Search
Date: Mon, 10 Sep 2012 11:02:55 +0300
Message-Id: <1347264179-31477-3-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1347264179-31477-1-git-send-email-luiz.dentz@gmail.com>
References: <1347264179-31477-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This avoid D-Bus round trips and is more aligned with what has been
proposed for MessageAccess interface.
---
 client/pbap.c | 115 ++++++++++++++++++++++++++++++++++++++--------------------
 1 file changed, 76 insertions(+), 39 deletions(-)

diff --git a/client/pbap.c b/client/pbap.c
index 3f182df..2f1dd5f 100644
--- a/client/pbap.c
+++ b/client/pbap.c
@@ -575,35 +575,24 @@ static struct obc_transfer *pull_phonebook(struct pbap_data *pbap,
 
 static DBusMessage *pull_vcard_listing(struct pbap_data *pbap,
 					DBusMessage *message, const char *name,
-					guint8 order, char *searchval, guint8 attrib,
-					guint16 count, guint16 offset)
+					GObexApparam *apparam)
 {
 	struct pending_request *request;
 	struct obc_transfer *transfer;
 	guint8 buf[272];
 	gsize len;
 	GError *err = NULL;
-	GObexApparam *apparam;
 	DBusMessage *reply;
 
+	len = g_obex_apparam_encode(apparam, buf, sizeof(buf));
+	g_obex_apparam_free(apparam);
+
 	transfer = obc_transfer_get("x-bt/vcard-listing", name, NULL, &err);
 	if (transfer == NULL)
 		goto fail;
 
-	apparam = g_obex_apparam_set_uint8(NULL, ORDER_TAG, order);
-	apparam = g_obex_apparam_set_uint8(apparam, SEARCHATTRIB_TAG, attrib);
-	apparam = g_obex_apparam_set_string(apparam, SEARCHVALUE_TAG,
-								searchval);
-	apparam = g_obex_apparam_set_uint16(apparam, MAXLISTCOUNT_TAG, count);
-	apparam = g_obex_apparam_set_uint16(apparam, LISTSTARTOFFSET_TAG,
-								offset);
-
-	len = g_obex_apparam_encode(apparam, buf, sizeof(buf));
-
 	obc_transfer_set_params(transfer, buf, len);
 
-	g_obex_apparam_free(apparam);
-
 	request = pending_request_new(pbap, message);
 	if (obc_session_queue(pbap->session, transfer,
 				pull_vcard_listing_callback, request, &err))
@@ -882,34 +871,33 @@ static DBusMessage *pbap_list(DBusConnection *connection,
 					DBusMessage *message, void *user_data)
 {
 	struct pbap_data *pbap = user_data;
+	GObexApparam *apparam;
+	DBusMessageIter args;
 
 	if (!pbap->path)
 		return g_dbus_create_error(message,
 					ERROR_INTERFACE ".Forbidden",
 					"Call Select first of all");
 
-	return pull_vcard_listing(pbap, message, "", pbap->order, "",
-				ATTRIB_NAME, DEFAULT_COUNT, DEFAULT_OFFSET);
-}
+	dbus_message_iter_init(message, &args);
 
-static DBusMessage *pbap_search(DBusConnection *connection,
-					DBusMessage *message, void *user_data)
-{
-	struct pbap_data *pbap = user_data;
-	char *field, *value;
-	guint8 attrib;
+	apparam = g_obex_apparam_set_uint16(NULL, MAXLISTCOUNT_TAG,
+							DEFAULT_COUNT);
+	apparam = g_obex_apparam_set_uint16(apparam, LISTSTARTOFFSET_TAG,
+							DEFAULT_OFFSET);
 
-	if (dbus_message_get_args(message, NULL,
-			DBUS_TYPE_STRING, &field,
-			DBUS_TYPE_STRING, &value,
-			DBUS_TYPE_INVALID) == FALSE)
+	if (parse_filters(apparam, &args) == NULL) {
+		g_obex_apparam_free(apparam);
 		return g_dbus_create_error(message,
 				ERROR_INTERFACE ".InvalidArguments", NULL);
+	}
 
-	if (!pbap->path)
-		return g_dbus_create_error(message,
-					ERROR_INTERFACE ".Forbidden",
-					"Call Select first of all");
+	return pull_vcard_listing(pbap, message, "", apparam);
+}
+
+static GObexApparam *parse_attribute(GObexApparam *apparam, const char *field)
+{
+	guint8 attrib;
 
 	if (!field || g_str_equal(field, ""))
 		attrib = ATTRIB_NAME;
@@ -920,11 +908,58 @@ static DBusMessage *pbap_search(DBusConnection *connection,
 	else if (!g_ascii_strcasecmp(field, "sound"))
 		attrib = ATTRIB_SOUND;
 	else
+		return NULL;
+
+	return g_obex_apparam_set_uint8(apparam, SEARCHATTRIB_TAG, attrib);
+}
+
+static DBusMessage *pbap_search(DBusConnection *connection,
+					DBusMessage *message, void *user_data)
+{
+	struct pbap_data *pbap = user_data;
+	char *field, *value;
+	GObexApparam *apparam;
+	DBusMessageIter args;
+
+	if (!pbap->path)
+		return g_dbus_create_error(message,
+					ERROR_INTERFACE ".Forbidden",
+					"Call Select first of all");
+
+	dbus_message_iter_init(message, &args);
+
+	if (dbus_message_iter_get_arg_type(&args) != DBUS_TYPE_STRING)
+		return g_dbus_create_error(message,
+				ERROR_INTERFACE ".InvalidArguments", NULL);
+
+	dbus_message_iter_get_basic(&args, &field);
+	dbus_message_iter_next(&args);
+
+	apparam = parse_attribute(NULL, field);
+	if (apparam == NULL)
+		return g_dbus_create_error(message,
+				ERROR_INTERFACE ".InvalidArguments", NULL);
+
+	if (dbus_message_iter_get_arg_type(&args) != DBUS_TYPE_STRING)
+		return g_dbus_create_error(message,
+				ERROR_INTERFACE ".InvalidArguments", NULL);
+
+	dbus_message_iter_get_basic(&args, &value);
+	dbus_message_iter_next(&args);
+
+	apparam = g_obex_apparam_set_uint16(apparam, MAXLISTCOUNT_TAG,
+							DEFAULT_COUNT);
+	apparam = g_obex_apparam_set_uint16(apparam, LISTSTARTOFFSET_TAG,
+							DEFAULT_OFFSET);
+	apparam = g_obex_apparam_set_string(apparam, SEARCHVALUE_TAG, value);
+
+	if (parse_filters(apparam, &args) == NULL) {
+		g_obex_apparam_free(apparam);
 		return g_dbus_create_error(message,
 				ERROR_INTERFACE ".InvalidArguments", NULL);
+	}
 
-	return pull_vcard_listing(pbap, message, "", pbap->order, value,
-					attrib, DEFAULT_COUNT, DEFAULT_OFFSET);
+	return pull_vcard_listing(pbap, message, "", apparam);
 }
 
 static DBusMessage *pbap_get_size(DBusConnection *connection,
@@ -1091,12 +1126,14 @@ static const GDBusMethodTable pbap_methods[] = {
 					{ "properties", "a{sv}" }),
 			pbap_pull_vcard) },
 	{ GDBUS_ASYNC_METHOD("List",
-				NULL, GDBUS_ARGS({ "vcard_listing", "a(ss)" }),
-				pbap_list) },
+			GDBUS_ARGS({ "filters", "a{sv}" }),
+			GDBUS_ARGS({ "vcard_listing", "a(ss)" }),
+			pbap_list) },
 	{ GDBUS_ASYNC_METHOD("Search",
-				GDBUS_ARGS({ "field", "s" }, { "value", "s" }),
-				GDBUS_ARGS({ "vcard_listing", "a(ss)" }),
-				pbap_search) },
+			GDBUS_ARGS({ "field", "s" }, { "value", "s" },
+					{ "filters", "a{sv}" }),
+			GDBUS_ARGS({ "vcard_listing", "a(ss)" }),
+			pbap_search) },
 	{ GDBUS_ASYNC_METHOD("GetSize",
 				NULL, GDBUS_ARGS({ "size", "q" }),
 				pbap_get_size) },
-- 
1.7.11.4

