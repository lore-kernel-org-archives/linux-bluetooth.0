Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 04/11] client: Rename set-filter-rssi to rssi
Date: Thu, 14 Dec 2017 10:02:53 -0200
Message-Id: <20171214120300.20018-4-luiz.dentz@gmail.com>
In-Reply-To: <20171214120300.20018-1-luiz.dentz@gmail.com>
References: <20171214120300.20018-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

All commands under scan submenu are related to set-filter so remove its
portion from it and make the command return the current value if no
parameters:

[bluetooth]# rssi 0
SetDiscoveryFilter success
[bluetooth]# rssi
RSSI: 0
---
 client/main.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/client/main.c b/client/main.c
index 461eb8487..faeb57758 100644
--- a/client/main.c
+++ b/client/main.c
@@ -1327,14 +1327,16 @@ commit:
 	cmd_set_scan_filter_commit();
 }
 
-static void cmd_set_scan_filter_rssi(int argc, char *argv[])
+static void cmd_scan_filter_rssi(int argc, char *argv[])
 {
-	filtered_scan_pathloss = DISTANCE_VAL_INVALID;
+	if (argc < 2 || !strlen(argv[1])) {
+		if (filtered_scan_rssi != DISTANCE_VAL_INVALID)
+			bt_shell_printf("RSSI: %d\n", filtered_scan_rssi);
+		return;
+	}
 
-	if (argc < 2 || !strlen(argv[1]))
-		filtered_scan_rssi = DISTANCE_VAL_INVALID;
-	else
-		filtered_scan_rssi = atoi(argv[1]);
+	filtered_scan_pathloss = DISTANCE_VAL_INVALID;
+	filtered_scan_rssi = atoi(argv[1]);
 
 	cmd_set_scan_filter_commit();
 }
@@ -2246,8 +2248,8 @@ static const struct bt_shell_menu scan_menu = {
 	.entries = {
 	{ "uuids", "[all/uuid1 uuid2 ...]", cmd_scan_filter_uuids,
 				"Set/Get UUIDs filter" },
-	{ "set-filter-rssi", "[rssi]", cmd_set_scan_filter_rssi,
-				"Set scan filter rssi, and clears pathloss" },
+	{ "rssi", "[rssi]", cmd_scan_filter_rssi,
+				"Set/Get RSSI filter, and clears pathloss" },
 	{ "set-filter-pathloss", "[pathloss]", cmd_set_scan_filter_pathloss,
 				"Set scan filter pathloss, and clears rssi" },
 	{ "set-filter-transport", "[transport]", cmd_set_scan_filter_transport,
-- 
2.13.6

