Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 5/6] client: Move scan related commands to a submenu
Date: Thu, 16 Nov 2017 12:59:24 +0200
Message-Id: <20171116105925.2117-5-luiz.dentz@gmail.com>
In-Reply-To: <20171116105925.2117-1-luiz.dentz@gmail.com>
References: <20171116105925.2117-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

All commands related to scan settings are now under scan
submenu:

[bluetooth]# menu scan
Menu scan:
Available commands:
-------------------
set-filter-uuids [uuid1 uuid2 ...]                Set scan filter uuids
set-filter-rssi [rssi]                            Set scan filter rssi, and clears pathloss
set-filter-pathloss [pathloss]                    Set scan filter pathloss, and clears rssi
set-filter-transport [transport]                  Set scan filter transport
set-filter-duplicate-data [on/off]                Set scan filter duplicate data
set-filter-clear                                  Clears discovery filter.
back                                              Return to main menu
version                                           Display version
quit                                              Quit program
exit                                              Quit program
help                                              Display help about this program
---
 client/main.c | 36 +++++++++++++++++++++---------------
 1 file changed, 21 insertions(+), 15 deletions(-)

diff --git a/client/main.c b/client/main.c
index c5703c184..a60228833 100644
--- a/client/main.c
+++ b/client/main.c
@@ -2382,6 +2382,26 @@ static const struct bt_shell_menu advertise_menu = {
 	{ } },
 };
 
+static const struct bt_shell_menu scan_menu = {
+	.name = "scan",
+	.entries = {
+	{ "set-filter-uuids", "[uuid1 uuid2 ...]", cmd_set_scan_filter_uuids,
+				"Set scan filter uuids" },
+	{ "set-filter-rssi", "[rssi]", cmd_set_scan_filter_rssi,
+				"Set scan filter rssi, and clears pathloss" },
+	{ "set-filter-pathloss", "[pathloss]", cmd_set_scan_filter_pathloss,
+				"Set scan filter pathloss, and clears rssi" },
+	{ "set-filter-transport", "[transport]", cmd_set_scan_filter_transport,
+				"Set scan filter transport" },
+	{ "set-filter-duplicate-data", "[on/off]",
+				cmd_set_scan_filter_duplicate_data,
+				"Set scan filter duplicate data",
+				mode_generator },
+	{ "set-filter-clear", "", cmd_set_scan_filter_clear,
+				"Clears discovery filter." },
+	{ } },
+};
+
 static const struct bt_shell_menu main_menu = {
 	.name = "main",
 	.entries = {
@@ -2413,21 +2433,6 @@ static const struct bt_shell_menu main_menu = {
 	{ "advertise",    "<on/off/type>", cmd_advertise,
 				"Enable/disable advertising with given type",
 							ad_generator},
-	{ "set-scan-filter-uuids", "[uuid1 uuid2 ...]",
-			cmd_set_scan_filter_uuids, "Set scan filter uuids" },
-	{ "set-scan-filter-rssi", "[rssi]", cmd_set_scan_filter_rssi,
-				"Set scan filter rssi, and clears pathloss" },
-	{ "set-scan-filter-pathloss", "[pathloss]",
-						cmd_set_scan_filter_pathloss,
-				"Set scan filter pathloss, and clears rssi" },
-	{ "set-scan-filter-transport", "[transport]",
-		cmd_set_scan_filter_transport, "Set scan filter transport" },
-	{ "set-scan-filter-duplicate-data", "[on/off]",
-			cmd_set_scan_filter_duplicate_data,
-				"Set scan filter duplicate data",
-				mode_generator },
-	{ "set-scan-filter-clear", "", cmd_set_scan_filter_clear,
-						"Clears discovery filter." },
 	{ "scan",         "<on/off>", cmd_scan, "Scan for devices",
 							mode_generator },
 	{ "info",         "[dev]",    cmd_info, "Device information",
@@ -2539,6 +2544,7 @@ int main(int argc, char *argv[])
 	bt_shell_init(&argc, &argv);
 	bt_shell_set_menu(&main_menu);
 	bt_shell_add_submenu(&advertise_menu);
+	bt_shell_add_submenu(&scan_menu);
 	bt_shell_set_prompt(PROMPT_OFF);
 
 	dbus_conn = g_dbus_setup_bus(DBUS_BUS_SYSTEM, NULL, NULL);
-- 
2.13.6

