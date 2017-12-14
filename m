Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 06/11] client: Rename set-filter-transport to transport
Date: Thu, 14 Dec 2017 10:02:55 -0200
Message-Id: <20171214120300.20018-6-luiz.dentz@gmail.com>
In-Reply-To: <20171214120300.20018-1-luiz.dentz@gmail.com>
References: <20171214120300.20018-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

All commands under scan submenu are related to set-filter so remove its
portion from it and make the command return the current value if no
parameters:

[bluetooth]# transport le
SetDiscoveryFilter success
[bluetooth]# transport
Transport: le
---
 client/main.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/client/main.c b/client/main.c
index ce9697e19..af29dca8b 100644
--- a/client/main.c
+++ b/client/main.c
@@ -1356,14 +1356,17 @@ static void cmd_scan_filter_pathloss(int argc, char *argv[])
 	cmd_set_scan_filter_commit();
 }
 
-static void cmd_set_scan_filter_transport(int argc, char *argv[])
+static void cmd_scan_filter_transport(int argc, char *argv[])
 {
-	g_free(filtered_scan_transport);
+	if (argc < 2 || !strlen(argv[1])) {
+		if (filtered_scan_transport)
+			bt_shell_printf("Transport: %s\n",
+					filtered_scan_transport);
+		return;
+	}
 
-	if (argc < 2 || !strlen(argv[1]))
-		filtered_scan_transport = NULL;
-	else
-		filtered_scan_transport = g_strdup(argv[1]);
+	g_free(filtered_scan_transport);
+	filtered_scan_transport = g_strdup(argv[1]);
 
 	cmd_set_scan_filter_commit();
 }
@@ -2255,8 +2258,8 @@ static const struct bt_shell_menu scan_menu = {
 				"Set/Get RSSI filter, and clears pathloss" },
 	{ "pathloss", "[pathloss]", cmd_scan_filter_pathloss,
 				"Set/Get Pathloss filter, and clears RSSI" },
-	{ "set-filter-transport", "[transport]", cmd_set_scan_filter_transport,
-				"Set scan filter transport" },
+	{ "transport", "[transport]", cmd_scan_filter_transport,
+				"Set/Get transport filter" },
 	{ "set-filter-duplicate-data", "[on/off]",
 				cmd_set_scan_filter_duplicate_data,
 				"Set scan filter duplicate data",
-- 
2.13.6

