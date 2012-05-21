Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [PATCH obexd v0 06/12] client: Replace SendFiles with SendFile
Date: Mon, 21 May 2012 11:07:08 +0200
Message-Id: <1337591234-24919-7-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1337591234-24919-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1337591234-24919-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

The function is now asynchronous, since it will return only when the
transfer has been finished.
---
 client/opp.c |   66 ++++++++++++++++++++++++++++++++++-----------------------
 1 files changed, 39 insertions(+), 27 deletions(-)

diff --git a/client/opp.c b/client/opp.c
index 424ae8d..67b01a9 100644
--- a/client/opp.c
+++ b/client/opp.c
@@ -45,48 +45,60 @@ struct opp_data {
 
 static DBusConnection *conn = NULL;
 
-static DBusMessage *opp_send_files(DBusConnection *connection,
+static void send_file_callback(struct obc_session *session,
+						struct obc_transfer *transfer,
+						GError *err, void *user_data)
+{
+	DBusMessage *msg = user_data;
+	DBusMessage *reply;
+
+	if (err != NULL)
+		reply = g_dbus_create_error(msg,
+				ERROR_INF ".Failed", "%s", err->message);
+	else
+		reply = dbus_message_new_method_return(msg);
+
+	g_dbus_send_message(conn, reply);
+	dbus_message_unref(msg);
+}
+
+static DBusMessage *opp_send_file(DBusConnection *connection,
 					DBusMessage *message, void *user_data)
 {
 	struct opp_data *opp = user_data;
-	DBusMessageIter iter, array;
+	struct obc_transfer *transfer;
 	DBusMessage *reply;
+	char *filename;
+	char *basename;
 	GError *err = NULL;
 
-	dbus_message_iter_init(message, &iter);
-	dbus_message_iter_recurse(&iter, &array);
-
-	while (dbus_message_iter_get_arg_type(&array) == DBUS_TYPE_STRING) {
-		char *filename;
-		char *basename;
-		struct obc_transfer *transfer;
-
-		dbus_message_iter_get_basic(&array, &filename);
-		basename = g_path_get_basename(filename);
+	if (dbus_message_get_args(message, NULL,
+					DBUS_TYPE_STRING, &filename,
+					DBUS_TYPE_INVALID) == FALSE)
+		return g_dbus_create_error(message,
+				ERROR_INF ".InvalidArguments", NULL);
 
-		transfer = obc_transfer_put(NULL, basename, filename, NULL, 0,
-									&err);
+	basename = g_path_get_basename(filename);
 
-		g_free(basename);
+	transfer = obc_transfer_put(NULL, basename, filename, NULL, 0, &err);
 
-		if (transfer == NULL)
-			goto fail;
+	g_free(basename);
 
-		if (!obc_session_queue(opp->session, transfer, NULL, NULL,
-									&err))
-			goto fail;
+	if (transfer == NULL)
+		goto fail;
 
-		dbus_message_iter_next(&array);
-	}
+	if (!obc_session_queue(opp->session, transfer, send_file_callback,
+								message, &err))
+		goto fail;
 
-	return dbus_message_new_method_return(message);
+	dbus_message_ref(message);
+	return NULL;
 
 fail:
 	reply = g_dbus_create_error(message,
 				ERROR_INF ".Failed", "%s", err->message);
 	g_error_free(err);
 	return reply;
-
 }
 
 static void pull_complete_callback(struct obc_session *session,
@@ -153,10 +165,10 @@ static DBusMessage *opp_exchange_business_cards(DBusConnection *connection,
 }
 
 static const GDBusMethodTable opp_methods[] = {
-	{ GDBUS_METHOD("SendFiles",
-		GDBUS_ARGS({ "files", "as" }),
+	{ GDBUS_ASYNC_METHOD("SendFile",
+		GDBUS_ARGS({ "sourcefile", "s" }),
 		NULL,
-		opp_send_files) },
+		opp_send_file) },
 	{ GDBUS_ASYNC_METHOD("PullBusinessCard",
 		GDBUS_ARGS({ "targetfile", "s" }),
 		NULL,
-- 
1.7.7.6

