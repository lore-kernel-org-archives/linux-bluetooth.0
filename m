Return-Path: <cyrus@holtmann.org>
From: Filippo Giunchedi <filippo@esaurito.net>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/5] test/agent.c: rename device into adapter in main
Date: Thu,  2 Jul 2009 11:14:24 +0200
Message-Id: <1246526068-13364-1-git-send-email-filippo@esaurito.net>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 test/agent.c |   18 +++++++++---------
 1 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/test/agent.c b/test/agent.c
index 01f9b7f..64362e8 100644
--- a/test/agent.c
+++ b/test/agent.c
@@ -486,8 +486,8 @@ int main(int argc, char *argv[])
 	const char *capabilities = "DisplayYesNo";
 	struct sigaction sa;
 	DBusConnection *conn;
-	char match_string[128], default_path[128], *device_id = NULL;
-	char *device_path = NULL, *agent_path = NULL, *target = NULL;
+	char match_string[128], default_path[128], *adapter_id = NULL;
+	char *adapter_path = NULL, *agent_path = NULL, *target = NULL;
 	int opt;
 
 	snprintf(default_path, sizeof(default_path),
@@ -496,7 +496,7 @@ int main(int argc, char *argv[])
 	while ((opt = getopt_long(argc, argv, "+i:p:c:rh", main_options, NULL)) != EOF) {
 		switch(opt) {
 		case 'i':
-			device_id = optarg;
+			adapter_id = optarg;
 			break;
 		case 'p':
 			if (optarg[0] != '/') {
@@ -542,17 +542,17 @@ int main(int argc, char *argv[])
 		exit(1);
 	}
 
-	if (!device_path)
-		device_path = get_device(conn, device_id);
+	if (!adapter_path)
+		adapter_path = get_device(conn, adapter_id);
 
 	if (target) {
-		if (create_paired_device(conn, device_path, agent_path,
+		if (create_paired_device(conn, adapter_path, agent_path,
 						capabilities, target) < 0) {
 			dbus_connection_unref(conn);
 			exit(1);
 		}
 	} else {
-		if (register_agent(conn, device_path, agent_path,
+		if (register_agent(conn, adapter_path, agent_path,
 							capabilities) < 0) {
 			dbus_connection_unref(conn);
 			exit(1);
@@ -580,9 +580,9 @@ int main(int argc, char *argv[])
 	}
 
 	if (!__io_terminated && !target)
-		unregister_agent(conn, device_path, agent_path);
+		unregister_agent(conn, adapter_path, agent_path);
 
-	free(device_path);
+	free(adapter_path);
 	free(agent_path);
 
 	free(passkey);
-- 
1.6.3.3

