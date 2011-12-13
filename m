Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz@bmw-carit.de>
To: <linux-bluetooth@vger.kernel.org>
CC: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [RFC obexd v3 17/20] client: Synchronization sessions return transfers
Date: Tue, 13 Dec 2011 17:44:20 +0100
Message-ID: <1323794663-2711-18-git-send-email-mikel.astiz@bmw-carit.de>
In-Reply-To: <1323794663-2711-1-git-send-email-mikel.astiz@bmw-carit.de>
References: <1323794663-2711-1-git-send-email-mikel.astiz@bmw-carit.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Additionally the parameter in PutPhonebook has been changed such that
instead of taking the content of the phonebook, the name of a file is
passed. This should reduce the D-Bus traffic significantly.
---
 client/sync.c      |   84 ++++++++++++++++++++++++++--------------------------
 doc/client-api.txt |    2 +-
 2 files changed, 43 insertions(+), 43 deletions(-)

diff --git a/client/sync.c b/client/sync.c
index 4c8d19a..83f37bf 100644
--- a/client/sync.c
+++ b/client/sync.c
@@ -84,42 +84,23 @@ static DBusMessage *sync_setlocation(DBusConnection *connection,
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
 	int err;
 
+	if (dbus_message_get_args(message, NULL,
+					DBUS_TYPE_STRING, &targetfile,
+					DBUS_TYPE_INVALID) == FALSE)
+		return g_dbus_create_error(message,
+				"org.openobex.Error.InvalidArguments",
+				"Invalid arguments in method call");
+
 	if (sync->msg)
 		return g_dbus_create_error(message,
 			ERROR_INF ".InProgress", "Transfer in progress");
@@ -128,15 +109,23 @@ static DBusMessage *sync_getphonebook(DBusConnection *connection,
 	if (!sync->phonebook_path)
 		sync->phonebook_path = g_strdup("telecom/pb.vcf");
 
-	if (obc_session_get(sync->session, "phonebook", sync->phonebook_path,
-				NULL, NULL, 0, sync_getphonebook_callback,
-				sync, TRUE, &err) == NULL)
+	transfer = obc_session_get(sync->session, "phonebook",
+				sync->phonebook_path,
+				targetfile, NULL, 0, NULL, NULL, TRUE, &err);
+
+	if (err < 0)
 		return g_dbus_create_error(message,
 				ERROR_INF ".Failed", "%s", strerror(err));
 
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
@@ -145,6 +134,9 @@ static DBusMessage *sync_putphonebook(DBusConnection *connection,
 	struct sync_data *sync = user_data;
 	const char *buf;
 	char *buffer;
+	DBusMessage *reply;
+	struct obc_transfer *transfer;
+	const char *path;
 	int err;
 
 	if (dbus_message_get_args(message, NULL,
@@ -159,21 +151,29 @@ static DBusMessage *sync_putphonebook(DBusConnection *connection,
 
 	buffer = g_strdup(buf);
 
-	if (obc_session_put_mem(sync->session, sync->phonebook_path,
+	transfer = obc_session_put_mem(sync->session, sync->phonebook_path,
 				buffer, strlen(buffer), g_free, TRUE,
-				&err) == NULL)
+				&err);
+
+	if (err < 0)
 		return g_dbus_create_error(message,
 				ERROR_INF ".Failed", "%s", strerror(err));
 
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
 
diff --git a/doc/client-api.txt b/doc/client-api.txt
index 92e4e42..5030909 100644
--- a/doc/client-api.txt
+++ b/doc/client-api.txt
@@ -301,7 +301,7 @@ Methods		void SetLocation(string location)
 			which should be used to find out if the content has been
 			successfully transferred or if the operation fails.
 
-		object PutPhonebook(string obj)
+		object PutPhonebook(string sourcefile)
 
 			Send an entire Phonebook Object store to remote device.
 
-- 
1.7.6.4

