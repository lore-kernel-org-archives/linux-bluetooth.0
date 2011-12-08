Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz@bmw-carit.de>
To: <linux-bluetooth@vger.kernel.org>
CC: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [RFC obexd v2 17/21] client: Synchronization sessions return transports
Date: Thu, 8 Dec 2011 16:27:51 +0100
Message-ID: <1323358075-27857-18-git-send-email-mikel.astiz@bmw-carit.de>
In-Reply-To: <1323358075-27857-1-git-send-email-mikel.astiz@bmw-carit.de>
References: <1323358075-27857-1-git-send-email-mikel.astiz@bmw-carit.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 client/sync.c |   76 +++++++++++++++++++++++++++------------------------------
 1 files changed, 36 insertions(+), 40 deletions(-)

diff --git a/client/sync.c b/client/sync.c
index 25600e6..eb65c61 100644
--- a/client/sync.c
+++ b/client/sync.c
@@ -84,40 +84,21 @@ static DBusMessage *sync_setlocation(DBusConnection *connection,
 	return dbus_message_new_method_return(message);
 }
 
-static void sync_getphonebook_callback(struct obc_session *session,
-					GError *err,
-					const struct obc_transfer *transfer,
-					void *user_data)
-{
-	struct sync_data *sync = user_data;
-	DBusMessage *reply;
-	const void *buf;
-
-	if (err) {
-		reply = g_dbus_create_error(sync->msg,
-						"org.openobex.Error.Failed",
-						"%s", err->message);
-		goto done;
-	}
-
-	reply = dbus_message_new_method_return(sync->msg);
-
-	buf = obc_transfer_get_buffer(transfer);
-
-	dbus_message_append_args(reply,
-		DBUS_TYPE_STRING, &buf,
-		DBUS_TYPE_INVALID);
-
-done:
-	g_dbus_send_message(conn, reply);
-	dbus_message_unref(sync->msg);
-	sync->msg = NULL;
-}
-
 static DBusMessage *sync_getphonebook(DBusConnection *connection,
 			DBusMessage *message, void *user_data)
 {
 	struct sync_data *sync = user_data;
+	DBusMessage *reply;
+	struct obc_transfer *transfer;
+	const char *path;
+	const char *targetfile;
+
+	if (dbus_message_get_args(message, NULL,
+					DBUS_TYPE_STRING, &targetfile,
+					DBUS_TYPE_INVALID) == FALSE)
+		return g_dbus_create_error(message,
+				"org.openobex.Error.InvalidArguments",
+				"Invalid arguments in method call");
 
 	if (sync->msg)
 		return g_dbus_create_error(message,
@@ -128,14 +109,19 @@ static DBusMessage *sync_getphonebook(DBusConnection *connection,
 		sync->phonebook_path = g_strdup("telecom/pb.vcf");
 
 	if (obc_session_get(sync->session, "phonebook", sync->phonebook_path,
-				NULL, NULL, 0, sync_getphonebook_callback,
-				sync, NULL) < 0)
+				targetfile, NULL, 0, NULL, NULL, &transfer) < 0)
 		return g_dbus_create_error(message,
 			ERROR_INF ".Failed", "Failed");
 
-	sync->msg = dbus_message_ref(message);
+	path = obc_transfer_get_path(transfer);
+
+	reply = dbus_message_new_method_return(message);
 
-	return NULL;
+	dbus_message_append_args(reply,
+			DBUS_TYPE_OBJECT_PATH, &path,
+			DBUS_TYPE_INVALID);
+
+	return reply;
 }
 
 static DBusMessage *sync_putphonebook(DBusConnection *connection,
@@ -144,6 +130,9 @@ static DBusMessage *sync_putphonebook(DBusConnection *connection,
 	struct sync_data *sync = user_data;
 	const char *buf;
 	char *buffer;
+	DBusMessage *reply;
+	struct obc_transfer *transfer;
+	const char *path;
 
 	if (dbus_message_get_args(message, NULL,
 			DBUS_TYPE_STRING, &buf,
@@ -158,19 +147,26 @@ static DBusMessage *sync_putphonebook(DBusConnection *connection,
 	buffer = g_strdup(buf);
 
 	if (obc_session_put_mem(sync->session, sync->phonebook_path,
-				buffer, strlen(buffer), g_free, NULL) < 0)
+				buffer, strlen(buffer), g_free,
+				&transfer) < 0)
 		return g_dbus_create_error(message,
 				ERROR_INF ".Failed", "Failed");
 
-	return dbus_message_new_method_return(message);
+	path = obc_transfer_get_path(transfer);
+
+	reply = dbus_message_new_method_return(message);
+
+	dbus_message_append_args(reply,
+			DBUS_TYPE_OBJECT_PATH, &path,
+			DBUS_TYPE_INVALID);
+
+	return reply;
 }
 
 static GDBusMethodTable sync_methods[] = {
 	{ "SetLocation", "s", "", sync_setlocation },
-	{ "GetPhonebook", "", "s", sync_getphonebook,
-			G_DBUS_METHOD_FLAG_ASYNC },
-	{ "PutPhonebook", "s", "", sync_putphonebook,
-			G_DBUS_METHOD_FLAG_ASYNC },
+	{ "GetPhonebook", "s", "o", sync_getphonebook },
+	{ "PutPhonebook", "s", "o", sync_putphonebook },
 	{}
 };
 
-- 
1.7.6.4

