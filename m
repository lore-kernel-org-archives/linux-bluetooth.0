Return-Path: <cyrus@holtmann.org>
Date: Sat, 6 Jun 2009 22:34:16 +0200
From: Filippo Giunchedi <filippo@esaurito.net>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] update test/agent.c API usage
Message-ID: <20090606203416.GA27173@esaurito.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,
as per subject:

* switch from Request to RequestPin/RequestPasskey
* change argument check in Release
* add Authorize method

thanks,
filippo

---
 test/agent.c |   59 ++++++++++++++++++++++++++++++++++++++++++++++-----------
 1 files changed, 47 insertions(+), 12 deletions(-)

diff --git a/test/agent.c b/test/agent.c
index b256f52..588f488 100644
--- a/test/agent.c
+++ b/test/agent.c
@@ -74,16 +74,14 @@ static DBusHandlerResult request_message(DBusConnection *conn,
 						DBusMessage *msg, void *data)
 {
 	DBusMessage *reply;
-	const char *path, *address;
-	dbus_bool_t numeric;
+	const char *path;
 
 	if (!passkey)
 		return DBUS_HANDLER_RESULT_NOT_YET_HANDLED;
 
 	if (!dbus_message_get_args(msg, NULL,
-			DBUS_TYPE_STRING, &path, DBUS_TYPE_STRING, &address,
-			DBUS_TYPE_BOOLEAN, &numeric, DBUS_TYPE_INVALID)) {
-		fprintf(stderr, "Invalid arguments for passkey Request method");
+			DBUS_TYPE_OBJECT_PATH, &path, DBUS_TYPE_INVALID)) {
+		fprintf(stderr, "Invalid arguments for RequestPinCode/RequestPasskey method");
 		return DBUS_HANDLER_RESULT_NOT_YET_HANDLED;
 	}
 
@@ -99,7 +97,7 @@ static DBusHandlerResult request_message(DBusConnection *conn,
 		return DBUS_HANDLER_RESULT_NEED_MEMORY;
 	}
 
-	printf("Passkey request for device %s\n", address);
+	printf("Passkey request for device %s\n", path);
 
 	dbus_message_append_args(reply, DBUS_TYPE_STRING, &passkey,
 					DBUS_TYPE_INVALID);
@@ -118,16 +116,13 @@ static DBusHandlerResult cancel_message(DBusConnection *conn,
 						DBusMessage *msg, void *data)
 {
 	DBusMessage *reply;
-	const char *path, *address;
 
-	if (!dbus_message_get_args(msg, NULL,
-			DBUS_TYPE_STRING, &path, DBUS_TYPE_STRING, &address,
-							DBUS_TYPE_INVALID)) {
+	if (!dbus_message_get_args(msg, NULL, DBUS_TYPE_INVALID)) {
 		fprintf(stderr, "Invalid arguments for passkey Confirm method");
 		return DBUS_HANDLER_RESULT_NOT_YET_HANDLED;
 	}
 
-	printf("Request canceled for device %s\n", address);
+	printf("Request canceled\n");
 
 	reply = dbus_message_new_method_return(msg);
 	if (!reply) {
@@ -174,10 +169,47 @@ static DBusHandlerResult release_message(DBusConnection *conn,
 	return DBUS_HANDLER_RESULT_HANDLED;
 }
 
+static DBusHandlerResult authorize_message(DBusConnection *conn,
+						DBusMessage *msg, void *data)
+{
+	DBusMessage *reply;
+    const char *path, *uuid;
+
+	if (!dbus_message_get_args(msg, NULL, DBUS_TYPE_OBJECT_PATH, &path,
+			DBUS_TYPE_STRING, &uuid, DBUS_TYPE_INVALID)) {
+		fprintf(stderr, "Invalid arguments for Authorize method");
+		return DBUS_HANDLER_RESULT_NOT_YET_HANDLED;
+	}
+
+	if (do_reject) {
+		reply = dbus_message_new_error(msg,
+					"org.bluez.Error.Rejected", "");
+		goto send;
+	}
+
+	reply = dbus_message_new_method_return(msg);
+	if (!reply) {
+		fprintf(stderr, "Can't create reply message\n");
+		return DBUS_HANDLER_RESULT_NEED_MEMORY;
+	}
+
+	printf("Authorizing request for %s\n", path);
+
+send:
+	dbus_connection_send(conn, reply, NULL);
+
+	dbus_connection_flush(conn);
+
+	dbus_message_unref(reply);
+
+	return DBUS_HANDLER_RESULT_HANDLED;
+}
+
 static DBusHandlerResult agent_message(DBusConnection *conn,
 						DBusMessage *msg, void *data)
 {
-	if (dbus_message_is_method_call(msg, "org.bluez.Agent", "Request"))
+	if (dbus_message_is_method_call(msg, "org.bluez.Agent", "RequestPinCode") ||
+			dbus_message_is_method_call(msg, "org.bluez.Agent", "RequestPasskey"))
 		return request_message(conn, msg, data);
 
 	if (dbus_message_is_method_call(msg, "org.bluez.Agent", "Cancel"))
@@ -186,6 +218,9 @@ static DBusHandlerResult agent_message(DBusConnection *conn,
 	if (dbus_message_is_method_call(msg, "org.bluez.Agent", "Release"))
 		return release_message(conn, msg, data);
 
+	if (dbus_message_is_method_call(msg, "org.bluez.Agent", "Authorize"))
+		return authorize_message(conn, msg, data);
+
 	return DBUS_HANDLER_RESULT_NOT_YET_HANDLED;
 }
 
-- 
1.6.3.1
