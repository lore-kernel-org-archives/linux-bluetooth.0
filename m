Return-Path: <cyrus@holtmann.org>
Date: Sun, 7 Jun 2009 12:14:33 +0200
From: Filippo Giunchedi <filippo@esaurito.net>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] test/agent.c: update dbus API usage
Message-ID: <20090607101433.GA1297@esaurito.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1244364150.23850.80.camel@localhost.localdomain>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch implements and updates some parts of dbus API missing from
test/agent.c, namely Authorize, RequestPinCode and RequestPasskey.
---
 test/agent.c |  111 ++++++++++++++++++++++++++++++++++++++++++++++++++-------
 1 files changed, 97 insertions(+), 14 deletions(-)

diff --git a/test/agent.c b/test/agent.c
index 7cd4b6e..4796e90 100644
--- a/test/agent.c
+++ b/test/agent.c
@@ -70,20 +70,18 @@ static DBusHandlerResult agent_filter(DBusConnection *conn,
 	return DBUS_HANDLER_RESULT_NOT_YET_HANDLED;
 }
 
-static DBusHandlerResult request_message(DBusConnection *conn,
+static DBusHandlerResult request_pincode_message(DBusConnection *conn,
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
+		fprintf(stderr, "Invalid arguments for RequestPinCode method");
 		return DBUS_HANDLER_RESULT_NOT_YET_HANDLED;
 	}
 
@@ -99,7 +97,7 @@ static DBusHandlerResult request_message(DBusConnection *conn,
 		return DBUS_HANDLER_RESULT_NEED_MEMORY;
 	}
 
-	printf("Passkey request for device %s\n", address);
+	printf("Pincode request for device %s\n", path);
 
 	dbus_message_append_args(reply, DBUS_TYPE_STRING, &passkey,
 					DBUS_TYPE_INVALID);
@@ -114,20 +112,63 @@ send:
 	return DBUS_HANDLER_RESULT_HANDLED;
 }
 
-static DBusHandlerResult cancel_message(DBusConnection *conn,
+static DBusHandlerResult request_passkey_message(DBusConnection *conn,
 						DBusMessage *msg, void *data)
 {
 	DBusMessage *reply;
-	const char *path, *address;
+	const char *path;
+	unsigned int int_passkey;
+
+	if (!passkey)
+		return DBUS_HANDLER_RESULT_NOT_YET_HANDLED;
+
 
 	if (!dbus_message_get_args(msg, NULL,
-			DBUS_TYPE_STRING, &path, DBUS_TYPE_STRING, &address,
-							DBUS_TYPE_INVALID)) {
+			DBUS_TYPE_OBJECT_PATH, &path, DBUS_TYPE_INVALID)) {
+		fprintf(stderr, "Invalid arguments for RequestPasskey method");
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
+	printf("Passkey request for device %s\n", path);
+
+	int_passkey = strtoul(passkey, NULL, 10);
+
+	dbus_message_append_args(reply, DBUS_TYPE_UINT32, &int_passkey,
+					DBUS_TYPE_INVALID);
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
+static DBusHandlerResult cancel_message(DBusConnection *conn,
+						DBusMessage *msg, void *data)
+{
+	DBusMessage *reply;
+
+	if (!dbus_message_get_args(msg, NULL, DBUS_TYPE_INVALID)) {
 		fprintf(stderr, "Invalid arguments for passkey Confirm method");
 		return DBUS_HANDLER_RESULT_NOT_YET_HANDLED;
 	}
 
-	printf("Request canceled for device %s\n", address);
+	printf("Request canceled\n");
 
 	reply = dbus_message_new_method_return(msg);
 	if (!reply) {
@@ -174,11 +215,50 @@ static DBusHandlerResult release_message(DBusConnection *conn,
 	return DBUS_HANDLER_RESULT_HANDLED;
 }
 
+static DBusHandlerResult authorize_message(DBusConnection *conn,
+						DBusMessage *msg, void *data)
+{
+	DBusMessage *reply;
+	const char *path, *uuid;
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
-		return request_message(conn, msg, data);
+	if (dbus_message_is_method_call(msg, "org.bluez.Agent", "RequestPinCode"))
+		return request_pincode_message(conn, msg, data);
+
+	if (dbus_message_is_method_call(msg, "org.bluez.Agent", "RequestPasskey"))
+		return request_passkey_message(conn, msg, data);
 
 	if (dbus_message_is_method_call(msg, "org.bluez.Agent", "Cancel"))
 		return cancel_message(conn, msg, data);
@@ -186,6 +266,9 @@ static DBusHandlerResult agent_message(DBusConnection *conn,
 	if (dbus_message_is_method_call(msg, "org.bluez.Agent", "Release"))
 		return release_message(conn, msg, data);
 
+	if (dbus_message_is_method_call(msg, "org.bluez.Agent", "Authorize"))
+		return authorize_message(conn, msg, data);
+
 	return DBUS_HANDLER_RESULT_NOT_YET_HANDLED;
 }
 
-- 
1.6.3.1
