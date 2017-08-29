Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 2/3] client: Use DuplicateData filter
Date: Tue, 29 Aug 2017 15:56:51 +0300
Message-Id: <20170829125652.4344-2-luiz.dentz@gmail.com>
In-Reply-To: <20170829125652.4344-1-luiz.dentz@gmail.com>
References: <20170829125652.4344-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Also use the term duplicate instead of reset to make it more clear
the intent of the filter.
---
 client/main.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/client/main.c b/client/main.c
index 825647d5e..87eb13165 100644
--- a/client/main.c
+++ b/client/main.c
@@ -1267,7 +1267,7 @@ struct set_discovery_filter_args {
 	dbus_int16_t pathloss;
 	char **uuids;
 	size_t uuids_len;
-	dbus_bool_t reset;
+	dbus_bool_t duplicate;
 };
 
 static void set_discovery_filter_setup(DBusMessageIter *iter, void *user_data)
@@ -1295,9 +1295,9 @@ static void set_discovery_filter_setup(DBusMessageIter *iter, void *user_data)
 		dict_append_entry(&dict, "Transport", DBUS_TYPE_STRING,
 						&args->transport);
 
-	if (args->reset)
-		dict_append_entry(&dict, "ResetData", DBUS_TYPE_BOOLEAN,
-						&args->reset);
+	if (args->duplicate)
+		dict_append_entry(&dict, "DuplicateData", DBUS_TYPE_BOOLEAN,
+						&args->duplicate);
 
 	dbus_message_iter_close_container(iter, &dict);
 }
@@ -1322,7 +1322,7 @@ static gint filtered_scan_pathloss = DISTANCE_VAL_INVALID;
 static char **filtered_scan_uuids;
 static size_t filtered_scan_uuids_len;
 static char *filtered_scan_transport;
-static bool filtered_scan_reset_data;
+static bool filtered_scan_duplicate_data;
 
 static void cmd_set_scan_filter_commit(void)
 {
@@ -1334,7 +1334,7 @@ static void cmd_set_scan_filter_commit(void)
 	args.transport = filtered_scan_transport;
 	args.uuids = filtered_scan_uuids;
 	args.uuids_len = filtered_scan_uuids_len;
-	args.reset = filtered_scan_reset_data;
+	args.duplicate = filtered_scan_duplicate_data;
 
 	if (check_default_ctrl() == FALSE)
 		return;
@@ -1404,14 +1404,14 @@ static void cmd_set_scan_filter_transport(const char *arg)
 	cmd_set_scan_filter_commit();
 }
 
-static void cmd_set_scan_filter_reset_data(const char *arg)
+static void cmd_set_scan_filter_duplicate_data(const char *arg)
 {
 	if (!arg || !strlen(arg))
-		filtered_scan_reset_data = false;
+		filtered_scan_duplicate_data = false;
 	else if (!strcmp(arg, "on"))
-		filtered_scan_reset_data = true;
+		filtered_scan_duplicate_data = true;
 	else if (!strcmp(arg, "off"))
-		filtered_scan_reset_data = false;
+		filtered_scan_duplicate_data = false;
 	else {
 		rl_printf("Invalid option: %s\n", arg);
 		return;
@@ -2473,9 +2473,10 @@ static const struct {
 				"Set scan filter pathloss, and clears rssi" },
 	{ "set-scan-filter-transport", "[transport]",
 		cmd_set_scan_filter_transport, "Set scan filter transport" },
-	{ "set-scan-filter-reset-data", "[on/off]",
-		cmd_set_scan_filter_reset_data, "Set scan filter reset data",
-							mode_generator },
+	{ "set-scan-filter-duplicate-data", "[on/off]",
+			cmd_set_scan_filter_duplicate_data,
+				"Set scan filter duplicate data",
+				mode_generator },
 	{ "set-scan-filter-clear", "", cmd_set_scan_filter_clear,
 						"Clears discovery filter." },
 	{ "scan",         "<on/off>", cmd_scan, "Scan for devices",
-- 
2.13.5

