Return-Path: <cyrus@holtmann.org>
Message-ID: <37367b3a0811280738t4fa4f39bv5f03eb51f8cdb27d@mail.gmail.com>
Date: Fri, 28 Nov 2008 15:38:26 +0000
From: "Alan Carvalho de Assis" <acassis@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Modification on agent.c in order to it support new API
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is my effort to adapt agent.c to new API.

I started doing it as single agent, but jhe suggest me to separate it
on two agents, but after doing that none agent Methods are called.

As single agent I got it:

# agent 00:0E:ED:29:4F:2D
Pairing to 00:0E:ED:29:4F:2D
Adapter path: /org/bluez/1780/hci0
Agent_message was called!
Agent called: RequestPinCode
Device path = /org/bluez/1780/hci0/dev_00_0E_ED_29_4F_2D
Agent has been released
Agent_message was called!
Agent called: Cancel
Request canceled for device
Agent_message was called!
Agent called: Release
Agent has been released

To test it as double agent just remove C++ style comments on main
scope, then execute:

# agent &

# agent 00:0E:ED:29:4F:2D
Pairing to 00:0E:ED:29:4F:2D
Adapter path: /org/bluez/1780/hci0

As you can see it doesn't call any agent methods.

Please, some idea about this problem?

Best Regards,

Alan


Signed-off-by: Alan Carvalho <acassis@gmail.com>
---
 test/agent.c |  194 ++++++++++++++++++++++++++++++++++++++++++----------------
 1 files changed, 142 insertions(+), 52 deletions(-)

diff --git a/test/agent.c b/test/agent.c
index a8d880a..fdab641 100644
--- a/test/agent.c
+++ b/test/agent.c
@@ -35,7 +35,7 @@

 #include <dbus/dbus.h>

-static char *passkey = NULL;
+static char *devaddr = NULL, *pincode = "0000";

 static int do_reject = 0;

@@ -70,28 +70,19 @@ static DBusHandlerResult agent_filter(DBusConnection *conn,
 	return DBUS_HANDLER_RESULT_NOT_YET_HANDLED;
 }

-static DBusHandlerResult request_message(DBusConnection *conn,
+
+static DBusHandlerResult cancel_message(DBusConnection *conn,
 						DBusMessage *msg, void *data)
 {
 	DBusMessage *reply;
 	const char *path, *address;
-	dbus_bool_t numeric;
-
-	if (!passkey)
-		return DBUS_HANDLER_RESULT_NOT_YET_HANDLED;

-	if (!dbus_message_get_args(msg, NULL,
-			DBUS_TYPE_STRING, &path, DBUS_TYPE_STRING, &address,
-			DBUS_TYPE_BOOLEAN, &numeric, DBUS_TYPE_INVALID)) {
-		fprintf(stderr, "Invalid arguments for passkey Request method");
+	if (!dbus_message_get_args(msg, NULL, DBUS_TYPE_INVALID)) {
+		fprintf(stderr, "Invalid arguments for Cancel method");
 		return DBUS_HANDLER_RESULT_NOT_YET_HANDLED;
 	}

-	if (do_reject) {
-		reply = dbus_message_new_error(msg,
-					"org.bluez.Error.Rejected", "");
-		goto send;
-	}
+	printf("Request canceled for device %s\n", address);

 	reply = dbus_message_new_method_return(msg);
 	if (!reply) {
@@ -99,12 +90,6 @@ static DBusHandlerResult
request_message(DBusConnection *conn,
 		return DBUS_HANDLER_RESULT_NEED_MEMORY;
 	}

-	printf("Passkey request for device %s\n", address);
-
-	dbus_message_append_args(reply, DBUS_TYPE_STRING, &passkey,
-					DBUS_TYPE_INVALID);
-
-send:
 	dbus_connection_send(conn, reply, NULL);

 	dbus_connection_flush(conn);
@@ -114,20 +99,23 @@ send:
 	return DBUS_HANDLER_RESULT_HANDLED;
 }

-static DBusHandlerResult cancel_message(DBusConnection *conn,
+static DBusHandlerResult reqpincode_message(DBusConnection *conn,
 						DBusMessage *msg, void *data)
 {
 	DBusMessage *reply;
-	const char *path, *address;
+	char *dev_path;

-	if (!dbus_message_get_args(msg, NULL,
-			DBUS_TYPE_STRING, &path, DBUS_TYPE_STRING, &address,
-							DBUS_TYPE_INVALID)) {
-		fprintf(stderr, "Invalid arguments for passkey Confirm method");
+	if (!dbus_message_get_args(msg, NULL, DBUS_TYPE_OBJECT_PATH,
&dev_path, DBUS_TYPE_INVALID)) {
+		fprintf(stderr, "Invalid arguments for RequestPinCode method");
 		return DBUS_HANDLER_RESULT_NOT_YET_HANDLED;
 	}

-	printf("Request canceled for device %s\n", address);
+	printf("Device path = %s\n",dev_path);
+
+	if (!__io_canceled)
+		fprintf(stderr, "Agent has been released\n");
+
+	//__io_terminated = 1;

 	reply = dbus_message_new_method_return(msg);
 	if (!reply) {
@@ -135,6 +123,9 @@ static DBusHandlerResult
cancel_message(DBusConnection *conn,
 		return DBUS_HANDLER_RESULT_NEED_MEMORY;
 	}

+	dbus_message_append_args(reply, DBUS_TYPE_STRING, &pincode,
+					DBUS_TYPE_INVALID);
+
 	dbus_connection_send(conn, reply, NULL);

 	dbus_connection_flush(conn);
@@ -177,14 +168,37 @@ static DBusHandlerResult
release_message(DBusConnection *conn,
 static DBusHandlerResult agent_message(DBusConnection *conn,
 						DBusMessage *msg, void *data)
 {
-	if (dbus_message_is_method_call(msg, "org.bluez.Agent", "Request"))
-		return request_message(conn, msg, data);
+	printf("Agent_message was called!\n");

-	if (dbus_message_is_method_call(msg, "org.bluez.Agent", "Cancel"))
-		return cancel_message(conn, msg, data);
-
-	if (dbus_message_is_method_call(msg, "org.bluez.Agent", "Release"))
+	if (dbus_message_is_method_call(msg, "org.bluez.Agent", "Release")){
+		printf("Agent called: Release\n");
 		return release_message(conn, msg, data);
+	}
+
+	if (dbus_message_is_method_call(msg, "org.bluez.Agent", "RequestPinCode")){
+		printf("Agent called: RequestPinCode\n");
+		return reqpincode_message(conn, msg, data);
+	}
+
+	if (dbus_message_is_method_call(msg, "org.bluez.Agent", "RequestPasskey"))
+		printf("Agent called: RequestPasskey\n");
+
+	if (dbus_message_is_method_call(msg, "org.bluez.Agent", "DisplayPasskey"))
+		printf("Agent called: DisplayPasskey\n");
+
+	if (dbus_message_is_method_call(msg, "org.bluez.Agent",
"RequestConfirmation"))
+		printf("Agent called: RequestConfirmation\n");
+
+	if (dbus_message_is_method_call(msg, "org.bluez.Agent", "Authorize"))
+		printf("Agent called: Authorize\n");
+
+	if (dbus_message_is_method_call(msg, "org.bluez.Agent", "ConfirmModeChange"))
+		printf("Agent called: ConfirmModeChange\n");
+
+	if (dbus_message_is_method_call(msg, "org.bluez.Agent", "Cancel")){
+		printf("Agent called: Cancel\n");
+		return cancel_message(conn, msg, data);
+	}

 	return DBUS_HANDLER_RESULT_NOT_YET_HANDLED;
 }
@@ -279,21 +293,88 @@ static int unregister_agent(DBusConnection
*conn, const char *device_path,
 	return 0;
 }

-static char *get_device(const char *device)
+static char *get_device(DBusConnection *conn)
 {
-	char *path;
+	char *path, *device_path = NULL;
+	DBusMessage *msg, *reply;
+	DBusError err;

-	path = strdup("/org/bluez/hci0");
+	msg = dbus_message_new_method_call("org.bluez", "/",
+					"org.bluez.Manager", "DefaultAdapter");
+	if (!msg) {
+		fprintf(stderr, "Can't allocate new method call\n");
+		return NULL;
+	}

-	return path;
+	dbus_error_init(&err);
+
+	reply = dbus_connection_send_with_reply_and_block(conn, msg, -1, &err);
+
+	dbus_message_unref(msg);
+
+	if (!reply) {
+		fprintf(stderr, "Can't get Adapter path\n");
+		if (dbus_error_is_set(&err)) {
+			fprintf(stderr, "%s\n", err.message);
+			dbus_error_free(&err);
+		}
+		return NULL;
+	}
+
+	dbus_message_get_args(reply, NULL, DBUS_TYPE_OBJECT_PATH,
&device_path, DBUS_TYPE_INVALID);
+
+	dbus_message_unref(reply);
+
+	dbus_connection_flush(conn);
+
+	return device_path;
+}
+
+static int pair_device(DBusConnection *conn, const char *device_path,
+					const char *agent_path,
+					const char *capabilities)
+{
+	DBusMessage *msg;
+	DBusPendingCall *pending;
+	int ret;
+
+
+	printf("Adapter path: %s\n", device_path);
+
+	msg = dbus_message_new_method_call("org.bluez", device_path,
+					"org.bluez.Adapter", "CreatePairedDevice");
+	if (!msg) {
+		fprintf(stderr, "Can't allocate new method call\n");
+		return -1;
+	}
+
+	dbus_message_append_args(msg, DBUS_TYPE_STRING, &devaddr,
+					DBUS_TYPE_OBJECT_PATH, &agent_path,
+					DBUS_TYPE_STRING, &capabilities,
+							DBUS_TYPE_INVALID);
+
+	ret = dbus_connection_send_with_reply(conn, msg, &pending, 100000);
+
+	if (!ret) {
+		fprintf(stderr, "Can't pair to device\n");
+		return -1;
+	}
+
+	dbus_message_unref(msg);
+
+	dbus_connection_flush(conn);
+
+	dbus_pending_call_block(pending);
+
+	return 0;
 }

 static void usage(void)
 {
-	printf("Bluetooth agent ver %s\n\n", VERSION);
+	printf("Bluetooth agent ver %s\n\n", "4.18");

 	printf("Usage:\n"
-		"\tagent [--device interface] [--path agent-path] <passkey>\n"
+		"\tagent <device address> [pincode]\n"
 		"\n");
 }

@@ -348,12 +429,10 @@ int main(int argc, char *argv[])
 	argv += optind;
 	optind = 0;

-	if (argc < 1) {
+	/*if (argc < 1) {
 		usage();
 		exit(1);
-	}
-
-	passkey = strdup(argv[0]);
+	}*/

 	if (!agent_path)
 		agent_path = strdup(default_path);
@@ -365,12 +444,25 @@ int main(int argc, char *argv[])
 	}

 	if (!device_path)
-		device_path = get_device(device_id);
+		device_path = get_device(conn);

-	if (register_agent(conn, device_path, agent_path, capabilities) < 0) {
-		dbus_connection_unref(conn);
-		exit(1);
-	}
+
+	//if (argc >= 1){
+		devaddr = strdup(argv[0]);
+		printf("Pairing to %s\n",devaddr);
+		if (pair_device(conn, device_path, agent_path, capabilities) < 0){
+				dbus_connection_unref(conn);
+				printf("Pairing failed\n");
+				exit(1);
+		}
+	//}
+	//else {
+		if (register_agent(conn, device_path, agent_path, capabilities) < 0) {
+			dbus_connection_unref(conn);
+			exit(1);
+		}
+
+	//}

 	if (!dbus_connection_add_filter(conn, agent_filter, NULL, NULL))
 		fprintf(stderr, "Can't add signal filter");
@@ -395,11 +487,9 @@ int main(int argc, char *argv[])
 	if (!__io_terminated)
 		unregister_agent(conn, device_path, agent_path);

-	free(device_path);
+	free(devaddr);
 	free(agent_path);

-	free(passkey);
-
 	dbus_connection_unref(conn);

 	return 0;
-- 
1.5.6.3
