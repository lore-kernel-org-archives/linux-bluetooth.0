Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 07/11] client: Rename set-filter-duplicate-data to duplicate-data
Date: Thu, 14 Dec 2017 10:02:56 -0200
Message-Id: <20171214120300.20018-7-luiz.dentz@gmail.com>
In-Reply-To: <20171214120300.20018-1-luiz.dentz@gmail.com>
References: <20171214120300.20018-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

All commands under scan submenu are related to set-filter so remove its
portion from it and make the command return the current value if no
parameters:

[bluetooth]# duplicate-data on
SetDiscoveryFilter success
[bluetooth]# duplicate-data
DuplicateData: on
---
 client/main.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/client/main.c b/client/main.c
index af29dca8b..f6f27ea6b 100644
--- a/client/main.c
+++ b/client/main.c
@@ -1371,11 +1371,15 @@ static void cmd_scan_filter_transport(int argc, char *argv[])
 	cmd_set_scan_filter_commit();
 }
 
-static void cmd_set_scan_filter_duplicate_data(int argc, char *argv[])
+static void cmd_scan_filter_duplicate_data(int argc, char *argv[])
 {
-	if (argc < 2 || !strlen(argv[1]))
-		filtered_scan_duplicate_data = false;
-	else if (!strcmp(argv[1], "on"))
+	if (argc < 2 || !strlen(argv[1])) {
+		bt_shell_printf("DuplicateData: %s\n",
+				filtered_scan_duplicate_data ? "on" : "off");
+		return;
+	}
+
+	if (!strcmp(argv[1], "on"))
 		filtered_scan_duplicate_data = true;
 	else if (!strcmp(argv[1], "off"))
 		filtered_scan_duplicate_data = false;
@@ -2260,9 +2264,8 @@ static const struct bt_shell_menu scan_menu = {
 				"Set/Get Pathloss filter, and clears RSSI" },
 	{ "transport", "[transport]", cmd_scan_filter_transport,
 				"Set/Get transport filter" },
-	{ "set-filter-duplicate-data", "[on/off]",
-				cmd_set_scan_filter_duplicate_data,
-				"Set scan filter duplicate data",
+	{ "duplicate-data", "[on/off]", cmd_scan_filter_duplicate_data,
+				"Set/Get duplicate data filter",
 				mode_generator },
 	{ "set-filter-clear", NULL, cmd_set_scan_filter_clear,
 				"Clears discovery filter." },
-- 
2.13.6

