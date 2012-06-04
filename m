Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [PATCH obexd v1 09/15] client: Synchronization sessions return transfers
Date: Mon,  4 Jun 2012 11:37:52 +0200
Message-Id: <1338802678-7009-10-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1338802678-7009-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1338802678-7009-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

Return the D-Bus path of the transfer representing the operation.
---
 client/sync.c |   92 ++++++++++++++++++++------------------------------------
 1 files changed, 33 insertions(+), 59 deletions(-)

diff --git a/client/sync.c b/client/sync.c
index d56e066..035ab2e 100644
--- a/client/sync.c
+++ b/client/sync.c
@@ -84,53 +84,22 @@ static DBusMessage *sync_setlocation(DBusConnection *connection,
 	return dbus_message_new_method_return(message);
 }
 
-static void sync_getphonebook_callback(struct obc_session *session,
-					struct obc_transfer *transfer,
-					GError *err, void *user_data)
-{
-	struct sync_data *sync = user_data;
-	DBusMessage *reply;
-	char *contents;
-	size_t size;
-	int perr;
-
-	if (err) {
-		reply = g_dbus_create_error(sync->msg,
-						"org.openobex.Error.Failed",
-						"%s", err->message);
-		goto send;
-	}
-
-	perr = obc_transfer_get_contents(transfer, &contents, &size);
-	if (perr < 0) {
-		reply = g_dbus_create_error(sync->msg,
-						"org.openobex.Error.Failed",
-						"Error reading contents: %s",
-						strerror(-perr));
-		goto send;
-	}
-
-	reply = dbus_message_new_method_return(sync->msg);
-
-	dbus_message_append_args(reply, DBUS_TYPE_STRING, &contents,
-							DBUS_TYPE_INVALID);
-
-	g_free(contents);
-
-send:
-	g_dbus_send_message(conn, reply);
-	dbus_message_unref(sync->msg);
-	sync->msg = NULL;
-}
-
 static DBusMessage *sync_getphonebook(DBusConnection *connection,
 			DBusMessage *message, void *user_data)
 {
 	struct sync_data *sync = user_data;
 	struct obc_transfer *transfer;
+	const char *target_file;
 	GError *err = NULL;
 	DBusMessage *reply;
 
+	if (dbus_message_get_args(message, NULL,
+					DBUS_TYPE_STRING, &target_file,
+					DBUS_TYPE_INVALID) == FALSE)
+		return g_dbus_create_error(message,
+				ERROR_INF ".InvalidArguments",
+				"Invalid arguments in method call");
+
 	if (sync->msg)
 		return g_dbus_create_error(message,
 			ERROR_INF ".InProgress", "Transfer in progress");
@@ -139,17 +108,15 @@ static DBusMessage *sync_getphonebook(DBusConnection *connection,
 	if (!sync->phonebook_path)
 		sync->phonebook_path = g_strdup("telecom/pb.vcf");
 
-	transfer = obc_transfer_get("phonebook", sync->phonebook_path, NULL,
-									&err);
+	transfer = obc_transfer_get("phonebook", sync->phonebook_path,
+							target_file, &err);
 	if (transfer == NULL)
 		goto fail;
 
-	if (obc_session_queue(sync->session, transfer,
-						sync_getphonebook_callback,
-						sync, &err)) {
-		sync->msg = dbus_message_ref(message);
-		return NULL;
-	}
+	if (!obc_session_queue(sync->session, transfer, NULL, NULL, &err))
+		goto fail;
+
+	return obc_transfer_create_dbus_reply(transfer, message);
 
 fail:
 	reply = g_dbus_create_error(message, ERROR_INF ".Failed", "%s",
@@ -163,27 +130,30 @@ static DBusMessage *sync_putphonebook(DBusConnection *connection,
 {
 	struct sync_data *sync = user_data;
 	struct obc_transfer *transfer;
-	const char *buf;
+	const char *source_file;
 	GError *err = NULL;
 	DBusMessage *reply;
 
 	if (dbus_message_get_args(message, NULL,
-			DBUS_TYPE_STRING, &buf,
-			DBUS_TYPE_INVALID) == FALSE)
+					DBUS_TYPE_STRING, &source_file,
+					DBUS_TYPE_INVALID) == FALSE)
 		return g_dbus_create_error(message,
-			ERROR_INF ".InvalidArguments", NULL);
+				ERROR_INF ".InvalidArguments",
+				"Invalid arguments in method call");
 
 	/* set default phonebook_path to memory internal phonebook */
 	if (!sync->phonebook_path)
 		sync->phonebook_path = g_strdup("telecom/pb.vcf");
 
-	transfer = obc_transfer_put(NULL, sync->phonebook_path, NULL, buf,
-							strlen(buf), &err);
+	transfer = obc_transfer_put(NULL, sync->phonebook_path, source_file,
+							NULL, 0, &err);
 	if (transfer == NULL)
 		goto fail;
 
-	if (obc_session_queue(sync->session, transfer, NULL, NULL, &err))
-		return dbus_message_new_method_return(message);
+	if (!obc_session_queue(sync->session, transfer, NULL, NULL, &err))
+		goto fail;
+
+	return obc_transfer_create_dbus_reply(transfer, message);
 
 fail:
 	reply = g_dbus_create_error(message, ERROR_INF ".Failed", "%s",
@@ -196,11 +166,15 @@ static const GDBusMethodTable sync_methods[] = {
 	{ GDBUS_METHOD("SetLocation",
 			GDBUS_ARGS({ "location", "s" }), NULL,
 			sync_setlocation) },
-	{ GDBUS_ASYNC_METHOD("GetPhonebook",
-			NULL, GDBUS_ARGS({ "obj", "s" }),
+	{ GDBUS_METHOD("GetPhonebook",
+			GDBUS_ARGS({ "targetfile", "s" }),
+			GDBUS_ARGS({ "transfer", "o" },
+					{ "properties", "a{sv}" }),
 			sync_getphonebook) },
-	{ GDBUS_ASYNC_METHOD("PutPhonebook",
-			GDBUS_ARGS({ "obj", "s" }), NULL,
+	{ GDBUS_METHOD("PutPhonebook",
+			GDBUS_ARGS({ "sourcefile", "s" }),
+			GDBUS_ARGS({ "transfer", "o" },
+					{ "properties", "a{sv}" }),
 			sync_putphonebook) },
 	{ }
 };
-- 
1.7.7.6

