Return-Path: <cyrus@holtmann.org>
Date: Sun, 19 Jun 2011 21:11:03 -0700
From: Steven Luo <steven@steven676.net>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] test/agent.c: Wait for reply from CreatePairedDevice
 before exiting
Message-ID: <20110620041103.GA5000@steven676.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This matches the behavior of the Python sample agent, and is needed to
get my Bluetooth keyboard to pair.

Signed-off-by: Steven Luo <steven@steven676.net>
---

diff -urpN a/test/agent.c b/test/agent.c
--- a/test/agent.c	2011-03-28 11:10:44.000000000 -0700
+++ b/test/agent.c	2011-06-19 03:19:12.000000000 -0700
@@ -41,6 +41,7 @@ static int do_reject = 0;
 
 static volatile sig_atomic_t __io_canceled = 0;
 static volatile sig_atomic_t __io_terminated = 0;
+static volatile sig_atomic_t exit_on_release = 1;
 
 static void sig_term(int sig)
 {
@@ -286,7 +287,8 @@ static DBusHandlerResult release_message
 	if (!__io_canceled)
 		fprintf(stderr, "Agent has been released\n");
 
-	__io_terminated = 1;
+	if (exit_on_release)
+		__io_terminated = 1;
 
 	reply = dbus_message_new_method_return(msg);
 	if (!reply) {
@@ -414,6 +416,13 @@ static int unregister_agent(DBusConnecti
 	return 0;
 }
 
+static void create_paired_device_reply(DBusPendingCall *pending,
+						void *user_data)
+{
+	__io_terminated = 1;
+	return;
+}
+
 static int create_paired_device(DBusConnection *conn, const char *adapter_path,
 						const char *agent_path,
 						const char *capabilities,
@@ -421,6 +430,7 @@ static int create_paired_device(DBusConn
 {
 	dbus_bool_t success;
 	DBusMessage *msg;
+	DBusPendingCall *pending;
 
 	msg = dbus_message_new_method_call("org.bluez", adapter_path,
 						"org.bluez.Adapter",
@@ -435,7 +445,12 @@ static int create_paired_device(DBusConn
 					DBUS_TYPE_STRING, &capabilities,
 					DBUS_TYPE_INVALID);
 
-	success = dbus_connection_send(conn, msg, NULL);
+	exit_on_release = 0;
+	success = dbus_connection_send_with_reply(conn, msg, &pending, -1);
+	if (pending)
+		dbus_pending_call_set_notify(pending,
+						create_paired_device_reply,
+						NULL, NULL);
 
 	dbus_message_unref(msg);
 
