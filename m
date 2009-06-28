Return-Path: <cyrus@holtmann.org>
From: Filippo Giunchedi <filippo@esaurito.net>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/4] test/agent.c: register object path only
Date: Sun, 28 Jun 2009 20:27:38 +0200
Message-Id: <1246213659-24559-3-git-send-email-filippo@esaurito.net>
In-Reply-To: <1246213659-24559-1-git-send-email-filippo@esaurito.net>
References: <1246213659-24559-1-git-send-email-filippo@esaurito.net>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

remove unused register_agent and unregister_agent, will be handled by
CreatePairedDevice
---
 test/agent.c |   96 ++-------------------------------------------------------
 1 files changed, 4 insertions(+), 92 deletions(-)

diff --git a/test/agent.c b/test/agent.c
index 4796e90..30af926 100644
--- a/test/agent.c
+++ b/test/agent.c
@@ -276,92 +276,6 @@ static const DBusObjectPathVTable agent_table = {
 	.message_function = agent_message,
 };
 
-static int register_agent(DBusConnection *conn, const char *device_path,
-						const char *agent_path,
-						const char *capabilities)
-{
-	DBusMessage *msg, *reply;
-	DBusError err;
-
-	if (!dbus_connection_register_object_path(conn, agent_path,
-							&agent_table, NULL)) {
-		fprintf(stderr, "Can't register object path for agent\n");
-		return -1;
-	}
-
-	msg = dbus_message_new_method_call("org.bluez", device_path,
-					"org.bluez.Adapter", "RegisterAgent");
-	if (!msg) {
-		fprintf(stderr, "Can't allocate new method call\n");
-		return -1;
-	}
-
-	dbus_message_append_args(msg, DBUS_TYPE_OBJECT_PATH, &agent_path,
-					DBUS_TYPE_STRING, &capabilities,
-							DBUS_TYPE_INVALID);
-
-	dbus_error_init(&err);
-
-	reply = dbus_connection_send_with_reply_and_block(conn, msg, -1, &err);
-
-	dbus_message_unref(msg);
-
-	if (!reply) {
-		fprintf(stderr, "Can't register agent\n");
-		if (dbus_error_is_set(&err)) {
-			fprintf(stderr, "%s\n", err.message);
-			dbus_error_free(&err);
-		}
-		return -1;
-	}
-
-	dbus_message_unref(reply);
-
-	dbus_connection_flush(conn);
-
-	return 0;
-}
-
-static int unregister_agent(DBusConnection *conn, const char *device_path,
-							const char *agent_path)
-{
-	DBusMessage *msg, *reply;
-	DBusError err;
-
-	msg = dbus_message_new_method_call("org.bluez", device_path,
-					"org.bluez.Adapter", "UnregisterAgent");
-	if (!msg) {
-		fprintf(stderr, "Can't allocate new method call\n");
-		return -1;
-	}
-
-	dbus_message_append_args(msg, DBUS_TYPE_OBJECT_PATH, &agent_path,
-							DBUS_TYPE_INVALID);
-
-	dbus_error_init(&err);
-
-	reply = dbus_connection_send_with_reply_and_block(conn, msg, -1, &err);
-
-	dbus_message_unref(msg);
-
-	if (!reply) {
-		fprintf(stderr, "Can't unregister agent\n");
-		if (dbus_error_is_set(&err)) {
-			fprintf(stderr, "%s\n", err.message);
-			dbus_error_free(&err);
-		}
-		return -1;
-	}
-
-	dbus_message_unref(reply);
-
-	dbus_connection_flush(conn);
-
-	dbus_connection_unregister_object_path(conn, agent_path);
-
-	return 0;
-}
-
 static char *get_device(const char *device)
 {
 	char *path;
@@ -450,9 +364,10 @@ int main(int argc, char *argv[])
 	if (!device_path)
 		device_path = get_device(device_id);
 
-	if (register_agent(conn, device_path, agent_path, capabilities) < 0) {
-		dbus_connection_unref(conn);
-		exit(1);
+	if (!dbus_connection_register_object_path(conn, agent_path,
+							&agent_table, NULL)) {
+		fprintf(stderr, "Can't register object path for agent\n");
+		return -1;
 	}
 
 	if (!dbus_connection_add_filter(conn, agent_filter, NULL, NULL))
@@ -475,9 +390,6 @@ int main(int argc, char *argv[])
 			break;
 	}
 
-	if (!__io_terminated)
-		unregister_agent(conn, device_path, agent_path);
-
 	free(device_path);
 	free(agent_path);
 
-- 
1.6.3.1

