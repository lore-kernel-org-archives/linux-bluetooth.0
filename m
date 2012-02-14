Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [PATCH obexd v2 5/6] client: queue transfers in ftp sessions
Date: Tue, 14 Feb 2012 15:47:08 +0100
Message-Id: <1329230829-27046-6-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1329230829-27046-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1329230829-27046-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

Previous implementation reported busy when trying to queue several
transfers in the same session.
---
 client/ftp.c |   39 +++++++++++----------------------------
 1 files changed, 11 insertions(+), 28 deletions(-)

diff --git a/client/ftp.c b/client/ftp.c
index 9e3f6b3..9be5d69 100644
--- a/client/ftp.c
+++ b/client/ftp.c
@@ -48,7 +48,6 @@ static DBusConnection *conn = NULL;
 
 struct ftp_data {
 	struct obc_session *session;
-	DBusMessage *msg;
 };
 
 static void async_cb(struct obc_session *session, GError *err,
@@ -176,36 +175,31 @@ static const GMarkupParser parser = {
 static void get_file_callback(struct obc_session *session, GError *err,
 							void *user_data)
 {
-	struct ftp_data *ftp = user_data;
+	DBusMessage *msg = user_data;
 	DBusMessage *reply;
 
-	if (!ftp->msg)
-		return;
-
 	if (err)
-		reply = g_dbus_create_error(ftp->msg,
+		reply = g_dbus_create_error(msg,
 					"org.openobex.Error.Failed",
 					"%s", err->message);
 	else
-		reply = dbus_message_new_method_return(ftp->msg);
+		reply = dbus_message_new_method_return(msg);
 
 	g_dbus_send_message(conn, reply);
-
-	dbus_message_unref(ftp->msg);
-	ftp->msg = NULL;
+	dbus_message_unref(msg);
 }
 
 static void list_folder_callback(struct obc_session *session,
 					GError *err, void *user_data)
 {
-	struct ftp_data *ftp = user_data;
+	DBusMessage *msg = user_data;
 	GMarkupParseContext *ctxt;
 	DBusMessage *reply;
 	DBusMessageIter iter, array;
 	const char *buf;
 	size_t size;
 
-	reply = dbus_message_new_method_return(ftp->msg);
+	reply = dbus_message_new_method_return(msg);
 
 	buf = obc_session_get_buffer(session, &size);
 	if (size == 0)
@@ -224,8 +218,7 @@ static void list_folder_callback(struct obc_session *session,
 
 done:
 	g_dbus_send_message(conn, reply);
-	dbus_message_unref(ftp->msg);
-	ftp->msg = NULL;
+	dbus_message_unref(msg);
 }
 
 static DBusMessage *create_folder(DBusConnection *connection,
@@ -263,18 +256,13 @@ static DBusMessage *list_folder(DBusConnection *connection,
 	struct ftp_data *ftp = user_data;
 	struct obc_session *session = ftp->session;
 
-	if (ftp->msg)
-		return g_dbus_create_error(message,
-				"org.openobex.Error.InProgress",
-				"Transfer in progress");
-
 	if (obc_session_get(session, "x-obex/folder-listing",
-			NULL, NULL, NULL, 0, list_folder_callback, ftp) < 0)
+			NULL, NULL, NULL, 0, list_folder_callback, message) < 0)
 		return g_dbus_create_error(message,
 				"org.openobex.Error.Failed",
 				"Failed");
 
-	ftp->msg = dbus_message_ref(message);
+	dbus_message_ref(message);
 
 	return NULL;
 }
@@ -286,11 +274,6 @@ static DBusMessage *get_file(DBusConnection *connection,
 	struct obc_session *session = ftp->session;
 	const char *target_file, *source_file;
 
-	if (ftp->msg)
-		return g_dbus_create_error(message,
-				"org.openobex.Error.InProgress",
-				"Transfer in progress");
-
 	if (dbus_message_get_args(message, NULL,
 				DBUS_TYPE_STRING, &target_file,
 				DBUS_TYPE_STRING, &source_file,
@@ -299,12 +282,12 @@ static DBusMessage *get_file(DBusConnection *connection,
 				"org.openobex.Error.InvalidArguments", NULL);
 
 	if (obc_session_get(session, NULL, source_file,
-			target_file, NULL, 0, get_file_callback, ftp) < 0)
+			target_file, NULL, 0, get_file_callback, message) < 0)
 		return g_dbus_create_error(message,
 				"org.openobex.Error.Failed",
 				"Failed");
 
-	ftp->msg = dbus_message_ref(message);
+	dbus_message_ref(message);
 
 	return NULL;
 }
-- 
1.7.6.5

