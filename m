Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [PATCH obexd v0 06/14] client: FileTransfer sessions return transfers
Date: Fri,  1 Jun 2012 12:51:15 +0200
Message-Id: <1338547883-18907-7-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1338547883-18907-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1338547883-18907-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

Return the D-Bus path of the transfer representing the operation.
---
 client/ftp.c |   46 ++++++++++++++--------------------------------
 1 files changed, 14 insertions(+), 32 deletions(-)

diff --git a/client/ftp.c b/client/ftp.c
index 8c72413..58aa17f 100644
--- a/client/ftp.c
+++ b/client/ftp.c
@@ -143,24 +143,6 @@ static const GMarkupParser parser = {
 	NULL
 };
 
-static void transfer_callback(struct obc_session *session,
-						struct obc_transfer *transfer,
-						GError *err, void *user_data)
-{
-	DBusMessage *msg = user_data;
-	DBusMessage *reply;
-
-	if (err)
-		reply = g_dbus_create_error(msg,
-					"org.openobex.Error.Failed",
-					"%s", err->message);
-	else
-		reply = dbus_message_new_method_return(msg);
-
-	g_dbus_send_message(conn, reply);
-	dbus_message_unref(msg);
-}
-
 static void list_folder_callback(struct obc_session *session,
 						struct obc_transfer *transfer,
 						GError *err, void *user_data)
@@ -270,11 +252,10 @@ static DBusMessage *get_file(DBusConnection *connection,
 	if (transfer == NULL)
 		goto fail;
 
-	if (obc_session_queue(session, transfer, transfer_callback, message,
-									&err)) {
-		dbus_message_ref(message);
-		return NULL;
-	}
+	if (!obc_session_queue(session, transfer, NULL, NULL, &err))
+		goto fail;
+
+	return obc_transfer_create_dbus_reply(transfer, message);
 
 fail:
 	reply = g_dbus_create_error(message, "org.openobex.Error.Failed", "%s",
@@ -306,11 +287,10 @@ static DBusMessage *put_file(DBusConnection *connection,
 	if (transfer == NULL)
 		goto fail;
 
-	if (obc_session_queue(session, transfer, transfer_callback, message,
-									&err)) {
-		dbus_message_ref(message);
-		return NULL;
-	}
+	if (!obc_session_queue(session, transfer, NULL, NULL, &err))
+		goto fail;
+
+	return obc_transfer_create_dbus_reply(transfer, message);
 
 fail:
 	reply = g_dbus_create_error(message, "org.openobex.Error.Failed", "%s",
@@ -415,11 +395,13 @@ static const GDBusMethodTable ftp_methods[] = {
 		GDBUS_ARGS({ "folder", "s" }), NULL, create_folder) },
 	{ GDBUS_ASYNC_METHOD("ListFolder",
 		NULL, GDBUS_ARGS({ "folderinfo", "aa{sv}" }), list_folder) },
-	{ GDBUS_ASYNC_METHOD("GetFile",
-		GDBUS_ARGS({ "targetfile", "s" }, { "sourcefile", "s" }), NULL,
+	{ GDBUS_METHOD("GetFile",
+		GDBUS_ARGS({ "targetfile", "s" }, { "sourcefile", "s" }),
+		GDBUS_ARGS({ "transfer", "o" }, { "properties", "a{sv}" }),
 		get_file) },
-	{ GDBUS_ASYNC_METHOD("PutFile",
-		GDBUS_ARGS({ "sourcefile", "s" }, { "targetfile", "s" }), NULL,
+	{ GDBUS_METHOD("PutFile",
+		GDBUS_ARGS({ "sourcefile", "s" }, { "targetfile", "s" }),
+		GDBUS_ARGS({ "transfer", "o" }, { "properties", "a{sv}" }),
 		put_file) },
 	{ GDBUS_ASYNC_METHOD("CopyFile",
 		GDBUS_ARGS({ "sourcefile", "s" }, { "targetfile", "s" }), NULL,
-- 
1.7.7.6

