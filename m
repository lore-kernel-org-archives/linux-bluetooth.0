Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 1/4] client: Group discovery filter variables into a struct
Date: Fri, 15 Dec 2017 14:09:51 -0200
Message-Id: <20171215160954.3527-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This should be easier to read and maintain.
---
 client/main.c | 82 +++++++++++++++++++++++++----------------------------------
 1 file changed, 35 insertions(+), 47 deletions(-)

diff --git a/client/main.c b/client/main.c
index 04937bc4b..5f7ec0103 100644
--- a/client/main.c
+++ b/client/main.c
@@ -1267,31 +1267,19 @@ static void set_discovery_filter_reply(DBusMessage *message, void *user_data)
 	bt_shell_printf("SetDiscoveryFilter success\n");
 }
 
-static gint filtered_scan_rssi = DISTANCE_VAL_INVALID;
-static gint filtered_scan_pathloss = DISTANCE_VAL_INVALID;
-static char **filtered_scan_uuids;
-static size_t filtered_scan_uuids_len;
-static char *filtered_scan_transport;
-static bool filtered_scan_duplicate_data;
+static struct set_discovery_filter_args filter = {
+	.rssi = DISTANCE_VAL_INVALID,
+	.pathloss = DISTANCE_VAL_INVALID,
+};
 
 static void cmd_set_scan_filter_commit(void)
 {
-	struct set_discovery_filter_args args;
-
-	args.uuids = NULL;
-	args.pathloss = filtered_scan_pathloss;
-	args.rssi = filtered_scan_rssi;
-	args.transport = filtered_scan_transport;
-	args.uuids = filtered_scan_uuids;
-	args.uuids_len = filtered_scan_uuids_len;
-	args.duplicate = filtered_scan_duplicate_data;
-
 	if (check_default_ctrl() == FALSE)
 		return;
 
 	if (g_dbus_proxy_method_call(default_ctrl->proxy, "SetDiscoveryFilter",
 		set_discovery_filter_setup, set_discovery_filter_reply,
-		&args, NULL) == FALSE) {
+		&filter, NULL) == FALSE) {
 		bt_shell_printf("Failed to set discovery filter\n");
 		return;
 	}
@@ -1302,26 +1290,26 @@ static void cmd_scan_filter_uuids(int argc, char *argv[])
 	if (argc < 2 || !strlen(argv[1])) {
 		char **uuid;
 
-		for (uuid = filtered_scan_uuids; uuid && *uuid; uuid++)
+		for (uuid = filter.uuids; uuid && *uuid; uuid++)
 			print_uuid(*uuid);
 
 		return;
 	}
 
-	g_strfreev(filtered_scan_uuids);
-	filtered_scan_uuids = NULL;
-	filtered_scan_uuids_len = 0;
+	g_strfreev(filter.uuids);
+	filter.uuids = NULL;
+	filter.uuids_len = 0;
 
 	if (!strcmp(argv[1], "all"))
 		goto commit;
 
-	filtered_scan_uuids = g_strdupv(&argv[1]);
-	if (!filtered_scan_uuids) {
+	filter.uuids = g_strdupv(&argv[1]);
+	if (!filter.uuids) {
 		bt_shell_printf("Failed to parse input\n");
 		return;
 	}
 
-	filtered_scan_uuids_len = g_strv_length(filtered_scan_uuids);
+	filter.uuids_len = g_strv_length(filter.uuids);
 
 commit:
 	cmd_set_scan_filter_commit();
@@ -1330,13 +1318,13 @@ commit:
 static void cmd_scan_filter_rssi(int argc, char *argv[])
 {
 	if (argc < 2 || !strlen(argv[1])) {
-		if (filtered_scan_rssi != DISTANCE_VAL_INVALID)
-			bt_shell_printf("RSSI: %d\n", filtered_scan_rssi);
+		if (filter.rssi != DISTANCE_VAL_INVALID)
+			bt_shell_printf("RSSI: %d\n", filter.rssi);
 		return;
 	}
 
-	filtered_scan_pathloss = DISTANCE_VAL_INVALID;
-	filtered_scan_rssi = atoi(argv[1]);
+	filter.pathloss = DISTANCE_VAL_INVALID;
+	filter.rssi = atoi(argv[1]);
 
 	cmd_set_scan_filter_commit();
 }
@@ -1344,14 +1332,14 @@ static void cmd_scan_filter_rssi(int argc, char *argv[])
 static void cmd_scan_filter_pathloss(int argc, char *argv[])
 {
 	if (argc < 2 || !strlen(argv[1])) {
-		if (filtered_scan_pathloss != DISTANCE_VAL_INVALID)
+		if (filter.pathloss != DISTANCE_VAL_INVALID)
 			bt_shell_printf("Pathloss: %d\n",
-						filtered_scan_pathloss);
+						filter.pathloss);
 		return;
 	}
 
-	filtered_scan_rssi = DISTANCE_VAL_INVALID;
-	filtered_scan_pathloss = atoi(argv[1]);
+	filter.rssi = DISTANCE_VAL_INVALID;
+	filter.pathloss = atoi(argv[1]);
 
 	cmd_set_scan_filter_commit();
 }
@@ -1359,14 +1347,14 @@ static void cmd_scan_filter_pathloss(int argc, char *argv[])
 static void cmd_scan_filter_transport(int argc, char *argv[])
 {
 	if (argc < 2 || !strlen(argv[1])) {
-		if (filtered_scan_transport)
+		if (filter.transport)
 			bt_shell_printf("Transport: %s\n",
-					filtered_scan_transport);
+					filter.transport);
 		return;
 	}
 
-	g_free(filtered_scan_transport);
-	filtered_scan_transport = g_strdup(argv[1]);
+	g_free(filter.transport);
+	filter.transport = g_strdup(argv[1]);
 
 	cmd_set_scan_filter_commit();
 }
@@ -1375,14 +1363,14 @@ static void cmd_scan_filter_duplicate_data(int argc, char *argv[])
 {
 	if (argc < 2 || !strlen(argv[1])) {
 		bt_shell_printf("DuplicateData: %s\n",
-				filtered_scan_duplicate_data ? "on" : "off");
+				filter.duplicate ? "on" : "off");
 		return;
 	}
 
 	if (!strcmp(argv[1], "on"))
-		filtered_scan_duplicate_data = true;
+		filter.duplicate = true;
 	else if (!strcmp(argv[1], "off"))
-		filtered_scan_duplicate_data = false;
+		filter.duplicate = false;
 	else {
 		bt_shell_printf("Invalid option: %s\n", argv[1]);
 		return;
@@ -1407,14 +1395,14 @@ static void clear_discovery_filter_setup(DBusMessageIter *iter, void *user_data)
 static void cmd_scan_filter_clear(int argc, char *argv[])
 {
 	/* set default values for all options */
-	filtered_scan_rssi = DISTANCE_VAL_INVALID;
-	filtered_scan_pathloss = DISTANCE_VAL_INVALID;
-	g_strfreev(filtered_scan_uuids);
-	filtered_scan_uuids = NULL;
-	filtered_scan_uuids_len = 0;
-	g_free(filtered_scan_transport);
-	filtered_scan_transport = NULL;
-	filtered_scan_duplicate_data = false;
+	filter.rssi = DISTANCE_VAL_INVALID;
+	filter.pathloss = DISTANCE_VAL_INVALID;
+	g_strfreev(filter.uuids);
+	filter.uuids = NULL;
+	filter.uuids_len = 0;
+	g_free(filter.transport);
+	filter.transport = NULL;
+	filter.duplicate = false;
 
 	if (check_default_ctrl() == FALSE)
 		return;
-- 
2.13.6

