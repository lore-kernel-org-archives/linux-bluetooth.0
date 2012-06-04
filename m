Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [PATCH obexd v1 11/15] client: PhonebookAccess sessions return transfers
Date: Mon,  4 Jun 2012 11:37:54 +0200
Message-Id: <1338802678-7009-12-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1338802678-7009-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1338802678-7009-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

Return the D-Bus path of the transfer representing the operation.
---
 client/pbap.c |  161 ++++++++++++++++++++++++++------------------------------
 1 files changed, 75 insertions(+), 86 deletions(-)

diff --git a/client/pbap.c b/client/pbap.c
index 3a771ab..e296eec 100644
--- a/client/pbap.c
+++ b/client/pbap.c
@@ -340,45 +340,6 @@ static void read_return_apparam(struct obc_transfer *transfer,
 	}
 }
 
-static void pull_phonebook_callback(struct obc_session *session,
-						struct obc_transfer *transfer,
-						GError *err, void *user_data)
-{
-	struct pending_request *request = user_data;
-	DBusMessage *reply;
-	char *contents;
-	size_t size;
-	int perr;
-
-	if (err) {
-		reply = g_dbus_create_error(request->msg,
-						"org.openobex.Error.Failed",
-						"%s", err->message);
-		goto send;
-	}
-
-	perr = obc_transfer_get_contents(transfer, &contents, &size);
-	if (perr < 0) {
-		reply = g_dbus_create_error(request->msg,
-						"org.openobex.Error.Failed",
-						"Error reading contents: %s",
-						strerror(-perr));
-		goto send;
-	}
-
-	reply = dbus_message_new_method_return(request->msg);
-
-	dbus_message_append_args(reply,
-			DBUS_TYPE_STRING, &contents,
-			DBUS_TYPE_INVALID);
-
-	g_free(contents);
-
-send:
-	g_dbus_send_message(conn, reply);
-	pending_request_free(request);
-}
-
 static void phonebook_size_callback(struct obc_session *session,
 						struct obc_transfer *transfer,
 						GError *err, void *user_data)
@@ -454,22 +415,23 @@ send:
 	pending_request_free(request);
 }
 
-static DBusMessage *pull_phonebook(struct pbap_data *pbap,
-					DBusMessage *message, guint8 type,
-					const char *name, uint64_t filter,
-					guint8 format, guint16 maxlistcount,
-					guint16 liststartoffset)
+static struct obc_transfer *pull_phonebook(struct pbap_data *pbap,
+						DBusMessage *message,
+						guint8 type, const char *name,
+						const char *targetfile,
+						uint64_t filter, guint8 format,
+						guint16 maxlistcount,
+						guint16 liststartoffset,
+						GError **err)
 {
 	struct pending_request *request;
-	struct pullphonebook_apparam apparam;
 	struct obc_transfer *transfer;
+	struct pullphonebook_apparam apparam;
 	session_callback_t func;
-	GError *err = NULL;
-	DBusMessage *reply;
 
-	transfer = obc_transfer_get("x-bt/phonebook", name, NULL, &err);
+	transfer = obc_transfer_get("x-bt/phonebook", name, targetfile, err);
 	if (transfer == NULL)
-		goto fail;
+		return NULL;
 
 	apparam.filter_tag = FILTER_TAG;
 	apparam.filter_len = FILTER_LEN;
@@ -486,30 +448,29 @@ static DBusMessage *pull_phonebook(struct pbap_data *pbap,
 
 	switch (type) {
 	case PULLPHONEBOOK:
-		func = pull_phonebook_callback;
+		func = NULL;
+		request = NULL;
 		break;
 	case GETPHONEBOOKSIZE:
 		func = phonebook_size_callback;
+		request = pending_request_new(pbap, message);
 		break;
 	default:
 		error("Unexpected type : 0x%2x", type);
 		return NULL;
 	}
 
-	request = pending_request_new(pbap, message);
-
 	obc_transfer_set_params(transfer, &apparam, sizeof(apparam));
 
-	if (obc_session_queue(pbap->session, transfer, func, request, &err))
+	if (!obc_session_queue(pbap->session, transfer, func, request, err)) {
+		if (request != NULL)
+			pending_request_free(request);
+
 		return NULL;
+	}
 
-	pending_request_free(request);
 
-fail:
-	reply = g_dbus_create_error(message, "org.openobex.Error.Failed", "%s",
-								err->message);
-	g_error_free(err);
-	return reply;
+	return transfer;
 }
 
 static guint8 *fill_apparam(guint8 *dest, void *buf, guint8 tag, guint8 len)
@@ -742,32 +703,48 @@ static DBusMessage *pbap_pull_all(DBusConnection *connection,
 					DBusMessage *message, void *user_data)
 {
 	struct pbap_data *pbap = user_data;
-	DBusMessage * err;
+	struct obc_transfer *transfer;
+	const char *targetfile;
 	char *name;
+	GError *err = NULL;
 
 	if (!pbap->path)
 		return g_dbus_create_error(message,
 				ERROR_INF ".Forbidden", "Call Select first of all");
 
+	if (dbus_message_get_args(message, NULL,
+			DBUS_TYPE_STRING, &targetfile,
+			DBUS_TYPE_INVALID) == FALSE)
+		return g_dbus_create_error(message,
+				ERROR_INF ".InvalidArguments", NULL);
+
 	name = g_strconcat(pbap->path, ".vcf", NULL);
 
-	err = pull_phonebook(pbap, message, PULLPHONEBOOK, name,
-				pbap->filter, pbap->format,
-				DEFAULT_COUNT, DEFAULT_OFFSET);
+	transfer = pull_phonebook(pbap, message, PULLPHONEBOOK, name,
+				targetfile, pbap->filter, pbap->format,
+				DEFAULT_COUNT, DEFAULT_OFFSET, &err);
 	g_free(name);
-	return err;
+
+	if (transfer == NULL) {
+		DBusMessage *reply = g_dbus_create_error(message,
+				"org.openobex.Error.Failed", "%s",
+				err->message);
+		g_error_free(err);
+		return reply;
+	}
+
+	return obc_transfer_create_dbus_reply(transfer, message);
 }
 
 static DBusMessage *pbap_pull_vcard(DBusConnection *connection,
 					DBusMessage *message, void *user_data)
 {
 	struct pbap_data *pbap = user_data;
-	struct pullvcardentry_apparam apparam;
-	const char *name;
-	struct pending_request *request;
 	struct obc_transfer *transfer;
-	GError *err = NULL;
+	struct pullvcardentry_apparam apparam;
+	const char *name, *targetfile;
 	DBusMessage *reply;
+	GError *err = NULL;
 
 	if (!pbap->path)
 		return g_dbus_create_error(message,
@@ -776,11 +753,12 @@ static DBusMessage *pbap_pull_vcard(DBusConnection *connection,
 
 	if (dbus_message_get_args(message, NULL,
 			DBUS_TYPE_STRING, &name,
+			DBUS_TYPE_STRING, &targetfile,
 			DBUS_TYPE_INVALID) == FALSE)
 		return g_dbus_create_error(message,
 				ERROR_INF ".InvalidArguments", NULL);
 
-	transfer = obc_transfer_get("x-bt/vcard", name, NULL, &err);
+	transfer = obc_transfer_get("x-bt/vcard", name, targetfile, &err);
 	if (transfer == NULL)
 		goto fail;
 
@@ -791,15 +769,12 @@ static DBusMessage *pbap_pull_vcard(DBusConnection *connection,
 	apparam.format_len = FORMAT_LEN;
 	apparam.format = pbap->format;
 
-	request = pending_request_new(pbap, message);
-
 	obc_transfer_set_params(transfer, &apparam, sizeof(apparam));
 
-	if (obc_session_queue(pbap->session, transfer, pull_phonebook_callback,
-								request, &err))
-		return NULL;
+	if (!obc_session_queue(pbap->session, transfer, NULL, NULL, &err))
+		goto fail;
 
-	pending_request_free(request);
+	return obc_transfer_create_dbus_reply(transfer, message);
 
 fail:
 	reply = g_dbus_create_error(message, "org.openobex.Error.Failed", "%s",
@@ -859,8 +834,10 @@ static DBusMessage *pbap_get_size(DBusConnection *connection,
 					DBusMessage *message, void *user_data)
 {
 	struct pbap_data *pbap = user_data;
-	DBusMessage * err;
+	DBusMessage *reply;
+	struct obc_transfer *transfer;
 	char *name;
+	GError *err = NULL;
 
 	if (!pbap->path)
 		return g_dbus_create_error(message,
@@ -868,11 +845,20 @@ static DBusMessage *pbap_get_size(DBusConnection *connection,
 
 	name = g_strconcat(pbap->path, ".vcf", NULL);
 
-	err = pull_phonebook(pbap, message, GETPHONEBOOKSIZE, name,
+	transfer = pull_phonebook(pbap, message, GETPHONEBOOKSIZE, name, NULL,
 				pbap->filter, pbap->format, 0,
-				DEFAULT_OFFSET);
+				DEFAULT_OFFSET, &err);
+
 	g_free(name);
-	return err;
+
+	if (transfer != NULL)
+		return NULL;
+
+	reply = g_dbus_create_error(message,
+				"org.openobex.Error.Failed", "%s",
+				err->message);
+	g_error_free(err);
+	return reply;
 }
 
 static DBusMessage *pbap_set_format(DBusConnection *connection,
@@ -984,13 +970,16 @@ static const GDBusMethodTable pbap_methods[] = {
 	{ GDBUS_ASYNC_METHOD("Select",
 			GDBUS_ARGS({ "location", "s" }, { "phonebook", "s" }),
 			NULL, pbap_select) },
-	{ GDBUS_ASYNC_METHOD("PullAll",
-				NULL, GDBUS_ARGS({ "phonebook", "s" }),
-				pbap_pull_all) },
-	{ GDBUS_ASYNC_METHOD("Pull",
-				GDBUS_ARGS({ "phonebook_object", "s" }),
-				GDBUS_ARGS({ "vcard", "s" }),
-				pbap_pull_vcard) },
+	{ GDBUS_METHOD("PullAll",
+			GDBUS_ARGS({ "targetfile", "s" }),
+			GDBUS_ARGS({ "transfer", "o" },
+					{ "properties", "a{sv}" }),
+			pbap_pull_all) },
+	{ GDBUS_METHOD("Pull",
+			GDBUS_ARGS({ "vcard", "s" }, { "targetfile", "s" }),
+			GDBUS_ARGS({ "transfer", "o" },
+					{ "properties", "a{sv}" }),
+			pbap_pull_vcard) },
 	{ GDBUS_ASYNC_METHOD("List",
 				NULL, GDBUS_ARGS({ "vcard_listing", "a(ss)" }),
 				pbap_list) },
-- 
1.7.7.6

