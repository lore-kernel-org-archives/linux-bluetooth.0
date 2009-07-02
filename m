Return-Path: <cyrus@holtmann.org>
From: Filippo Giunchedi <filippo@esaurito.net>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 5/5] test/agent.c: rename "target device" into device
Date: Thu,  2 Jul 2009 11:14:28 +0200
Message-Id: <1246526068-13364-5-git-send-email-filippo@esaurito.net>
In-Reply-To: <1246526068-13364-1-git-send-email-filippo@esaurito.net>
References: <1246526068-13364-1-git-send-email-filippo@esaurito.net>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 test/agent.c |   16 ++++++++--------
 1 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/test/agent.c b/test/agent.c
index b625b88..4c12ea3 100644
--- a/test/agent.c
+++ b/test/agent.c
@@ -374,7 +374,7 @@ static int unregister_agent(DBusConnection *conn, const char *adapter_path,
 static int create_paired_device(DBusConnection *conn, const char *adapter_path,
 						const char *agent_path,
 						const char *capabilities,
-						const char *target)
+						const char *device)
 {
 	dbus_bool_t success;
 	DBusMessage *msg;
@@ -387,7 +387,7 @@ static int create_paired_device(DBusConnection *conn, const char *adapter_path,
 		return -1;
 	}
 
-	dbus_message_append_args(msg, DBUS_TYPE_STRING, &target,
+	dbus_message_append_args(msg, DBUS_TYPE_STRING, &device,
 					DBUS_TYPE_OBJECT_PATH, &agent_path,
 					DBUS_TYPE_STRING, &capabilities,
 					DBUS_TYPE_INVALID);
@@ -521,7 +521,7 @@ static void usage(void)
 	printf("Bluetooth agent ver %s\n\n", VERSION);
 
 	printf("Usage:\n"
-		"\tagent [--adapter adapter-path] [--path agent-path] <passkey> [<target_device>]\n"
+		"\tagent [--adapter adapter-path] [--path agent-path] <passkey> [<device>]\n"
 		"\n");
 }
 
@@ -540,7 +540,7 @@ int main(int argc, char *argv[])
 	struct sigaction sa;
 	DBusConnection *conn;
 	char match_string[128], default_path[128], *adapter_id = NULL;
-	char *adapter_path = NULL, *agent_path = NULL, *target = NULL;
+	char *adapter_path = NULL, *agent_path = NULL, *device = NULL;
 	int opt;
 
 	snprintf(default_path, sizeof(default_path),
@@ -584,7 +584,7 @@ int main(int argc, char *argv[])
 	passkey = strdup(argv[0]);
 
 	if (argc > 1)
-		target = strdup(argv[1]);
+		device = strdup(argv[1]);
 
 	if (!agent_path)
 		agent_path = strdup(default_path);
@@ -599,9 +599,9 @@ int main(int argc, char *argv[])
 	if (!adapter_path)
 		exit(1);
 
-	if (target) {
+	if (device) {
 		if (create_paired_device(conn, adapter_path, agent_path,
-						capabilities, target) < 0) {
+						capabilities, device) < 0) {
 			dbus_connection_unref(conn);
 			exit(1);
 		}
@@ -633,7 +633,7 @@ int main(int argc, char *argv[])
 			break;
 	}
 
-	if (!__io_terminated && !target)
+	if (!__io_terminated && !device)
 		unregister_agent(conn, adapter_path, agent_path);
 
 	free(adapter_path);
-- 
1.6.3.3

