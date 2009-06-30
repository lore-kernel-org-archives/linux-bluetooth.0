Return-Path: <cyrus@holtmann.org>
From: Filippo Giunchedi <filippo@esaurito.net>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] test/agent.c: get_device select default device
Date: Tue, 30 Jun 2009 17:52:49 +0200
Message-Id: <1246377169-14306-1-git-send-email-filippo@esaurito.net>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

mimick simple-agent, i.e. search for default device
---
 test/agent.c |   53 +++++++++++++++++++++++++++++++++++++++++++++++++----
 1 files changed, 49 insertions(+), 4 deletions(-)

diff --git a/test/agent.c b/test/agent.c
index b256f52..e8584f3 100644
--- a/test/agent.c
+++ b/test/agent.c
@@ -279,11 +279,56 @@ static int unregister_agent(DBusConnection *conn, const char *device_path,
 	return 0;
 }
 
-static char *get_device(const char *device)
+static char *get_device(DBusConnection *conn, const char *device)
 {
-	char *path;
+	DBusMessage *msg, *reply;
+	DBusError err;
+	const char *tmppath;
+	char *path, *default_path = "/org/bluez/hci0";
+
+	if (device) {
+		path = strdup(device);
+		return path;
+	}
+
+	msg = dbus_message_new_method_call("org.bluez", "/",
+					"org.bluez.Manager", "DefaultAdapter");
+
+	if (!msg) {
+		fprintf(stderr, "Can't allocate new method call\n");
+		return default_path;
+	}
+
+	dbus_error_init(&err);
+
+	reply = dbus_connection_send_with_reply_and_block(conn, msg, -1, &err);
+
+	dbus_message_unref(msg);
+
+	if (!reply) {
+		fprintf(stderr, "Can't get default adapter, using default adapter\n");
+		if (dbus_error_is_set(&err)) {
+			fprintf(stderr, "%s\n", err.message);
+			dbus_error_free(&err);
+		}
+		return default_path;
+	}
+
+	if (!dbus_message_get_args(reply, &err,
+			DBUS_TYPE_OBJECT_PATH, &tmppath, DBUS_TYPE_INVALID)) {
+		fprintf(stderr, "Can't get reply arguments, using default adapter\n");
+		if (dbus_error_is_set(&err)) {
+			fprintf(stderr, "%s\n", err.message);
+			dbus_error_free(&err);
+		}
+		return default_path;
+	}
 
-	path = strdup("/org/bluez/hci0");
+	path = strdup(tmppath);
+
+	dbus_message_unref(reply);
+
+	dbus_connection_flush(conn);
 
 	return path;
 }
@@ -365,7 +410,7 @@ int main(int argc, char *argv[])
 	}
 
 	if (!device_path)
-		device_path = get_device(device_id);
+		device_path = get_device(conn, device_id);
 
 	if (register_agent(conn, device_path, agent_path, capabilities) < 0) {
 		dbus_connection_unref(conn);
-- 
1.6.3.3

