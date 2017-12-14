Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 05/11] client: Rename set-filter-pathloss to pathloss
Date: Thu, 14 Dec 2017 10:02:54 -0200
Message-Id: <20171214120300.20018-5-luiz.dentz@gmail.com>
In-Reply-To: <20171214120300.20018-1-luiz.dentz@gmail.com>
References: <20171214120300.20018-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

All commands under scan submenu are related to set-filter so remove its
portion from it and make the command return the current value if no
parameters:

[bluetooth]# pathloss 0
SetDiscoveryFilter success
[bluetooth]# pathloss
Pathloss: 0
---
 client/main.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/client/main.c b/client/main.c
index faeb57758..ce9697e19 100644
--- a/client/main.c
+++ b/client/main.c
@@ -1341,14 +1341,17 @@ static void cmd_scan_filter_rssi(int argc, char *argv[])
 	cmd_set_scan_filter_commit();
 }
 
-static void cmd_set_scan_filter_pathloss(int argc, char *argv[])
+static void cmd_scan_filter_pathloss(int argc, char *argv[])
 {
-	filtered_scan_rssi = DISTANCE_VAL_INVALID;
+	if (argc < 2 || !strlen(argv[1])) {
+		if (filtered_scan_pathloss != DISTANCE_VAL_INVALID)
+			bt_shell_printf("Pathloss: %d\n",
+						filtered_scan_pathloss);
+		return;
+	}
 
-	if (argc < 2 || !strlen(argv[1]))
-		filtered_scan_pathloss = DISTANCE_VAL_INVALID;
-	else
-		filtered_scan_pathloss = atoi(argv[1]);
+	filtered_scan_rssi = DISTANCE_VAL_INVALID;
+	filtered_scan_pathloss = atoi(argv[1]);
 
 	cmd_set_scan_filter_commit();
 }
@@ -2250,8 +2253,8 @@ static const struct bt_shell_menu scan_menu = {
 				"Set/Get UUIDs filter" },
 	{ "rssi", "[rssi]", cmd_scan_filter_rssi,
 				"Set/Get RSSI filter, and clears pathloss" },
-	{ "set-filter-pathloss", "[pathloss]", cmd_set_scan_filter_pathloss,
-				"Set scan filter pathloss, and clears rssi" },
+	{ "pathloss", "[pathloss]", cmd_scan_filter_pathloss,
+				"Set/Get Pathloss filter, and clears RSSI" },
 	{ "set-filter-transport", "[transport]", cmd_set_scan_filter_transport,
 				"Set scan filter transport" },
 	{ "set-filter-duplicate-data", "[on/off]",
-- 
2.13.6

