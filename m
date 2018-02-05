Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 4/4] client: Don't set generators for modes
Date: Mon,  5 Feb 2018 10:48:18 -0200
Message-Id: <20180205124818.23566-4-luiz.dentz@gmail.com>
In-Reply-To: <20180205124818.23566-1-luiz.dentz@gmail.com>
References: <20180205124818.23566-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Commands that already have all values set on the argument string don't
need to add a generator since bt_shell can now auto complete them.
---
 client/main.c | 26 +++++++-------------------
 1 file changed, 7 insertions(+), 19 deletions(-)

diff --git a/client/main.c b/client/main.c
index 85803f1a3..a6adb70d2 100644
--- a/client/main.c
+++ b/client/main.c
@@ -65,12 +65,6 @@ static GDBusProxy *default_dev;
 static GDBusProxy *default_attr;
 static GList *ctrl_list;
 
-static const char *mode_arguments[] = {
-	"on",
-	"off",
-	NULL
-};
-
 static const char *agent_arguments[] = {
 	"on",
 	"off",
@@ -2156,11 +2150,6 @@ static char *argument_generator(const char *text, int state,
 	return NULL;
 }
 
-static char *mode_generator(const char *text, int state)
-{
-	return argument_generator(text, state, mode_arguments);
-}
-
 static char *capability_generator(const char *text, int state)
 {
 	return argument_generator(text, state, agent_arguments);
@@ -2321,7 +2310,7 @@ static const struct bt_shell_menu advertise_menu = {
 			"Set advertise manufacturer data" },
 	{ "tx-power", "[on/off]", cmd_advertise_tx_power,
 			"Enable/disable TX power to be advertised",
-							mode_generator },
+							NULL },
 	{ "name", "[on/off/name]", cmd_advertise_name,
 			"Enable/disable local name to be advertised" },
 	{ "appearance", "[value]", cmd_advertise_appearance,
@@ -2347,7 +2336,7 @@ static const struct bt_shell_menu scan_menu = {
 				"Set/Get transport filter" },
 	{ "duplicate-data", "[on/off]", cmd_scan_filter_duplicate_data,
 				"Set/Get duplicate data filter",
-				mode_generator },
+				NULL },
 	{ "clear", "[uuids/rssi/pathloss/transport/duplicate-data]",
 				cmd_scan_filter_clear,
 				"Clears discovery filter.",
@@ -2377,7 +2366,7 @@ static const struct bt_shell_menu gatt_menu = {
 	{ "release-notify", NULL, cmd_release_notify,
 					"Release Notify file descriptor" },
 	{ "notify",       "<on/off>", cmd_notify, "Notify attribute value",
-							mode_generator },
+							NULL },
 	{ "register-application", "[UUID ...]", cmd_register_app,
 						"Register profile to connect" },
 	{ "unregister-application", NULL, cmd_unregister_app,
@@ -2417,13 +2406,13 @@ static const struct bt_shell_menu main_menu = {
 	{ "reset-alias",  NULL,       cmd_reset_alias,
 					"Reset controller alias" },
 	{ "power",        "<on/off>", cmd_power, "Set controller power",
-							mode_generator },
+							NULL },
 	{ "pairable",     "<on/off>", cmd_pairable,
 					"Set controller pairable mode",
-							mode_generator },
+							NULL },
 	{ "discoverable", "<on/off>", cmd_discoverable,
 					"Set controller discoverable mode",
-							mode_generator },
+							NULL },
 	{ "agent",        "<on/off/capability>", cmd_agent,
 				"Enable/disable agent with given capability",
 							capability_generator},
@@ -2433,8 +2422,7 @@ static const struct bt_shell_menu main_menu = {
 				"Enable/disable advertising with given type",
 							ad_generator},
 	{ "set-alias",    "<alias>",  cmd_set_alias, "Set device alias" },
-	{ "scan",         "<on/off>", cmd_scan, "Scan for devices",
-							mode_generator },
+	{ "scan",         "<on/off>", cmd_scan, "Scan for devices", NULL },
 	{ "info",         "[dev]",    cmd_info, "Device information",
 							dev_generator },
 	{ "pair",         "[dev]",    cmd_pair, "Pair with device",
-- 
2.14.3

