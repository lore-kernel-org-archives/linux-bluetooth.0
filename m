Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 4/6] client: Move advertise related commands to a submenu
Date: Thu, 16 Nov 2017 12:59:23 +0200
Message-Id: <20171116105925.2117-4-luiz.dentz@gmail.com>
In-Reply-To: <20171116105925.2117-1-luiz.dentz@gmail.com>
References: <20171116105925.2117-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

All commands related to advertise settings are now under advertise
submenu:

> menu advertise
Menu advertise:
Available commands:
-------------------
set-uuids [uuid1 uuid2 ...]                       Set advertise uuids
set-service [uuid][data=[xx xx ...]               Set advertise service data
set-manufacturer [id][data=[xx xx ...]            Set advertise manufacturer data
set-tx-power <on/off>                             Enable/disable TX power to be advertised
set-name <on/off/name>                            Enable/disable local name to be advertised
set-appearance <value>                            Set custom appearance to be advertised
set-duration <seconds>                            Set advertise duration
set-timeout <seconds>                             Set advertise timeout
back                                              Return to main menu
version                                           Display version
quit                                              Quit program
exit                                              Quit program
help
---
 client/main.c | 45 +++++++++++++++++++++++++--------------------
 1 file changed, 25 insertions(+), 20 deletions(-)

diff --git a/client/main.c b/client/main.c
index cf04047cb..c5703c184 100644
--- a/client/main.c
+++ b/client/main.c
@@ -2358,6 +2358,30 @@ static void cmd_set_advertise_timeout(const char *arg)
 	ad_advertise_timeout(dbus_conn, value);
 }
 
+static const struct bt_shell_menu advertise_menu = {
+	.name = "advertise",
+	.entries = {
+	{ "set-uuids", "[uuid1 uuid2 ...]",
+			cmd_set_advertise_uuids, "Set advertise uuids" },
+	{ "set-service", "[uuid][data=[xx xx ...]", cmd_set_advertise_service,
+			"Set advertise service data" },
+	{ "set-manufacturer", "[id][data=[xx xx ...]",
+			cmd_set_advertise_manufacturer,
+			"Set advertise manufacturer data" },
+	{ "set-tx-power", "<on/off>", cmd_set_advertise_tx_power,
+			"Enable/disable TX power to be advertised",
+							mode_generator },
+	{ "set-name", "<on/off/name>", cmd_set_advertise_name,
+			"Enable/disable local name to be advertised" },
+	{ "set-appearance", "<value>", cmd_set_advertise_appearance,
+			"Set custom appearance to be advertised" },
+	{ "set-duration", "<seconds>", cmd_set_advertise_duration,
+			"Set advertise duration" },
+	{ "set-timeout", "<seconds>", cmd_set_advertise_timeout,
+			"Set advertise timeout" },
+	{ } },
+};
+
 static const struct bt_shell_menu main_menu = {
 	.name = "main",
 	.entries = {
@@ -2389,26 +2413,6 @@ static const struct bt_shell_menu main_menu = {
 	{ "advertise",    "<on/off/type>", cmd_advertise,
 				"Enable/disable advertising with given type",
 							ad_generator},
-	{ "set-advertise-uuids", "[uuid1 uuid2 ...]",
-			cmd_set_advertise_uuids, "Set advertise uuids" },
-	{ "set-advertise-service", "[uuid][data=[xx xx ...]",
-			cmd_set_advertise_service,
-			"Set advertise service data" },
-	{ "set-advertise-manufacturer", "[id][data=[xx xx ...]",
-			cmd_set_advertise_manufacturer,
-			"Set advertise manufacturer data" },
-	{ "set-advertise-tx-power", "<on/off>",
-			cmd_set_advertise_tx_power,
-			"Enable/disable TX power to be advertised",
-							mode_generator },
-	{ "set-advertise-name", "<on/off/name>", cmd_set_advertise_name,
-			"Enable/disable local name to be advertised" },
-	{ "set-advertise-appearance", "<value>", cmd_set_advertise_appearance,
-			"Set custom appearance to be advertised" },
-	{ "set-advertise-duration", "<seconds>", cmd_set_advertise_duration,
-			"Set advertise duration" },
-	{ "set-advertise-timeout", "<seconds>", cmd_set_advertise_timeout,
-			"Set advertise timeout" },
 	{ "set-scan-filter-uuids", "[uuid1 uuid2 ...]",
 			cmd_set_scan_filter_uuids, "Set scan filter uuids" },
 	{ "set-scan-filter-rssi", "[rssi]", cmd_set_scan_filter_rssi,
@@ -2534,6 +2538,7 @@ int main(int argc, char *argv[])
 
 	bt_shell_init(&argc, &argv);
 	bt_shell_set_menu(&main_menu);
+	bt_shell_add_submenu(&advertise_menu);
 	bt_shell_set_prompt(PROMPT_OFF);
 
 	dbus_conn = g_dbus_setup_bus(DBUS_BUS_SYSTEM, NULL, NULL);
-- 
2.13.6

