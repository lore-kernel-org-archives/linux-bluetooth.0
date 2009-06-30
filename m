Return-Path: <cyrus@holtmann.org>
From: Filippo Giunchedi <filippo@esaurito.net>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/3] test/agent.c: pairing via CreatePairedDevice
Date: Tue, 30 Jun 2009 17:16:48 +0200
Message-Id: <1246375008-8282-3-git-send-email-filippo@esaurito.net>
In-Reply-To: <20090630133439.GA27640@jh-x301>
References: <20090630133439.GA27640@jh-x301>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

introduce optional argument target for remote address, if passed pairing
will be called
---
 test/agent.c |   60 +++++++++++++++++++++++++++++++++++++++++++++++++++------
 1 files changed, 53 insertions(+), 7 deletions(-)

diff --git a/test/agent.c b/test/agent.c
index 25e3d54..7c492b7 100644
--- a/test/agent.c
+++ b/test/agent.c
@@ -362,6 +362,39 @@ static int unregister_agent(DBusConnection *conn, const char *device_path,
 	return 0;
 }
 
+static int create_paired_device(DBusConnection *conn, const char *device_path,
+						const char *agent_path,
+						const char *capabilities, const char *target)
+{
+	dbus_bool_t success;
+	DBusMessage *msg;
+
+	msg = dbus_message_new_method_call("org.bluez", device_path,
+					"org.bluez.Adapter", "CreatePairedDevice");
+	if (!msg) {
+		fprintf(stderr, "Can't allocate new method call\n");
+		return -1;
+	}
+
+	dbus_message_append_args(msg, DBUS_TYPE_STRING, &target,
+					DBUS_TYPE_OBJECT_PATH, &agent_path,
+					DBUS_TYPE_STRING, &capabilities,
+							DBUS_TYPE_INVALID);
+
+	success = dbus_connection_send(conn, msg, NULL);
+
+	dbus_message_unref(msg);
+
+	if (!success) {
+		fprintf(stderr, "Not enough memory for message send\n");
+		return -1;
+	}
+
+	dbus_connection_flush(conn);
+
+	return 0;
+}
+
 static char *get_device(const char *device)
 {
 	char *path = "/org/bluez/hci0";
@@ -377,7 +410,7 @@ static void usage(void)
 	printf("Bluetooth agent ver %s\n\n", VERSION);
 
 	printf("Usage:\n"
-		"\tagent [--device interface] [--path agent-path] <passkey>\n"
+		"\tagent [--device interface] [--path agent-path] <passkey> [<target_device>]\n"
 		"\n");
 }
 
@@ -396,7 +429,7 @@ int main(int argc, char *argv[])
 	struct sigaction sa;
 	DBusConnection *conn;
 	char match_string[128], default_path[128], *device_id = NULL;
-	char *device_path = NULL, *agent_path = NULL;
+	char *device_path = NULL, *agent_path = NULL, *target = NULL;
 	int opt;
 
 	snprintf(default_path, sizeof(default_path),
@@ -439,6 +472,9 @@ int main(int argc, char *argv[])
 
 	passkey = strdup(argv[0]);
 
+	if (argc > 1)
+		target = strdup(argv[1]);
+
 	if (!agent_path)
 		agent_path = strdup(default_path);
 
@@ -451,9 +487,17 @@ int main(int argc, char *argv[])
 	if (!device_path)
 		device_path = get_device(device_id);
 
-	if (register_agent(conn, device_path, agent_path, capabilities) < 0) {
-		dbus_connection_unref(conn);
-		exit(1);
+	if (!target) {
+		if (register_agent(conn, device_path, agent_path, capabilities) < 0) {
+			dbus_connection_unref(conn);
+			exit(1);
+		}
+	} else {
+		if (create_paired_device(conn, device_path, agent_path,
+						capabilities, target) < 0) {
+			dbus_connection_unref(conn);
+			exit(1);
+		}
 	}
 
 	if (!dbus_connection_add_filter(conn, agent_filter, NULL, NULL))
@@ -476,8 +520,10 @@ int main(int argc, char *argv[])
 			break;
 	}
 
-	if (!__io_terminated)
-		unregister_agent(conn, device_path, agent_path);
+	if (!__io_terminated) {
+		if (!target)
+			unregister_agent(conn, device_path, agent_path);
+	}
 
 	free(device_path);
 	free(agent_path);
-- 
1.6.3.3

