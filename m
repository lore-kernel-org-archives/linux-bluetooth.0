Return-Path: <cyrus@holtmann.org>
From: Filippo Giunchedi <filippo@esaurito.net>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 4/4] test/agent.c: pairing via CreatePairedDevice
Date: Sun, 28 Jun 2009 20:27:39 +0200
Message-Id: <1246213659-24559-4-git-send-email-filippo@esaurito.net>
In-Reply-To: <1246213659-24559-1-git-send-email-filippo@esaurito.net>
References: <1246213659-24559-1-git-send-email-filippo@esaurito.net>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Introduce mandatory target argument for remote address
---
 test/agent.c |   46 +++++++++++++++++++++++++++++++++++++++++++---
 1 files changed, 43 insertions(+), 3 deletions(-)

diff --git a/test/agent.c b/test/agent.c
index 30af926..7f7bfe4 100644
--- a/test/agent.c
+++ b/test/agent.c
@@ -276,6 +276,39 @@ static const DBusObjectPathVTable agent_table = {
 	.message_function = agent_message,
 };
 
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
 	char *path;
@@ -290,7 +323,7 @@ static void usage(void)
 	printf("Bluetooth agent ver %s\n\n", VERSION);
 
 	printf("Usage:\n"
-		"\tagent [--device interface] [--path agent-path] <passkey>\n"
+		"\tagent [--device interface] [--path agent-path] <passkey> <target_device>\n"
 		"\n");
 }
 
@@ -309,7 +342,7 @@ int main(int argc, char *argv[])
 	struct sigaction sa;
 	DBusConnection *conn;
 	char match_string[128], default_path[128], *device_id = NULL;
-	char *device_path = NULL, *agent_path = NULL;
+	char *device_path = NULL, *agent_path = NULL, *target = NULL;
 	int opt;
 
 	snprintf(default_path, sizeof(default_path),
@@ -345,13 +378,15 @@ int main(int argc, char *argv[])
 	argv += optind;
 	optind = 0;
 
-	if (argc < 1) {
+	if (argc < 2) {
 		usage();
 		exit(1);
 	}
 
 	passkey = strdup(argv[0]);
 
+	target = strdup(argv[1]);
+
 	if (!agent_path)
 		agent_path = strdup(default_path);
 
@@ -370,6 +405,11 @@ int main(int argc, char *argv[])
 		return -1;
 	}
 
+	if (create_paired_device(conn, device_path, agent_path, capabilities, target) < 0) {
+		dbus_connection_unref(conn);
+		exit(1);
+	}
+
 	if (!dbus_connection_add_filter(conn, agent_filter, NULL, NULL))
 		fprintf(stderr, "Can't add signal filter");
 
-- 
1.6.3.1

