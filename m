Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 6/6] client: Commit changes to scan filter if active
Date: Mon, 30 Jul 2018 14:14:27 +0300
Message-Id: <20180730111427.29947-6-luiz.dentz@gmail.com>
In-Reply-To: <20180730111427.29947-1-luiz.dentz@gmail.com>
References: <20180730111427.29947-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This detects if the command scan has been triggered and if so commit
changes to filter immediatelly so they take effect in the current
session.
---
 client/main.c | 55 +++++++++++++++++++++++++++++++++++----------------
 1 file changed, 38 insertions(+), 17 deletions(-)

diff --git a/client/main.c b/client/main.c
index 1a66a3ab4..4d848176c 100644
--- a/client/main.c
+++ b/client/main.c
@@ -1139,6 +1139,24 @@ static void cmd_default_agent(int argc, char *argv[])
 	agent_default(dbus_conn, agent_manager);
 }
 
+#define	DISTANCE_VAL_INVALID	0x7FFF
+
+static struct set_discovery_filter_args {
+	char *transport;
+	dbus_uint16_t rssi;
+	dbus_int16_t pathloss;
+	char **uuids;
+	size_t uuids_len;
+	dbus_bool_t duplicate;
+	dbus_bool_t discoverable;
+	bool set;
+	bool active;
+} filter = {
+	.rssi = DISTANCE_VAL_INVALID,
+	.pathloss = DISTANCE_VAL_INVALID,
+	.set = true,
+};
+
 static void start_discovery_reply(DBusMessage *message, void *user_data)
 {
 	dbus_bool_t enable = GPOINTER_TO_UINT(user_data);
@@ -1154,26 +1172,11 @@ static void start_discovery_reply(DBusMessage *message, void *user_data)
 	}
 
 	bt_shell_printf("Discovery %s\n", enable ? "started" : "stopped");
+
+	filter.active = enable;
 	/* Leave the discovery running even on noninteractive mode */
 }
 
-#define	DISTANCE_VAL_INVALID	0x7FFF
-
-static struct set_discovery_filter_args {
-	char *transport;
-	dbus_uint16_t rssi;
-	dbus_int16_t pathloss;
-	char **uuids;
-	size_t uuids_len;
-	dbus_bool_t duplicate;
-	dbus_bool_t discoverable;
-	bool set;
-} filter = {
-	.rssi = DISTANCE_VAL_INVALID,
-	.pathloss = DISTANCE_VAL_INVALID,
-	.set = true,
-};
-
 static void set_discovery_filter_setup(DBusMessageIter *iter, void *user_data)
 {
 	struct set_discovery_filter_args *args = user_data;
@@ -1302,6 +1305,9 @@ static void cmd_scan_filter_uuids(int argc, char *argv[])
 
 commit:
 	filter.set = false;
+
+	if (filter.active)
+		set_discovery_filter();
 }
 
 static void cmd_scan_filter_rssi(int argc, char *argv[])
@@ -1316,6 +1322,9 @@ static void cmd_scan_filter_rssi(int argc, char *argv[])
 	filter.rssi = atoi(argv[1]);
 
 	filter.set = false;
+
+	if (filter.active)
+		set_discovery_filter();
 }
 
 static void cmd_scan_filter_pathloss(int argc, char *argv[])
@@ -1331,6 +1340,9 @@ static void cmd_scan_filter_pathloss(int argc, char *argv[])
 	filter.pathloss = atoi(argv[1]);
 
 	filter.set = false;
+
+	if (filter.active)
+		set_discovery_filter();
 }
 
 static void cmd_scan_filter_transport(int argc, char *argv[])
@@ -1346,6 +1358,9 @@ static void cmd_scan_filter_transport(int argc, char *argv[])
 	filter.transport = g_strdup(argv[1]);
 
 	filter.set = false;
+
+	if (filter.active)
+		set_discovery_filter();
 }
 
 static void cmd_scan_filter_duplicate_data(int argc, char *argv[])
@@ -1366,6 +1381,9 @@ static void cmd_scan_filter_duplicate_data(int argc, char *argv[])
 	}
 
 	filter.set = false;
+
+	if (filter.active)
+		set_discovery_filter();
 }
 
 static void cmd_scan_filter_discoverable(int argc, char *argv[])
@@ -1386,6 +1404,9 @@ static void cmd_scan_filter_discoverable(int argc, char *argv[])
 	}
 
 	filter.set = false;
+
+	if (filter.active)
+		set_discovery_filter();
 }
 
 static void filter_clear_uuids(void)
-- 
2.17.1

