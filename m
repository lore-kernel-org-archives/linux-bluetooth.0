Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Subject: [PATCH BlueZ 2/2] client: Add autocompletion for on/off
From: ERAMOTO Masaya <eramoto.masaya@jp.fujitsu.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
References: <25fbc871-706b-d435-6c78-120d74ce3505@jp.fujitsu.com>
Message-ID: <c0ca8d3f-bb6e-c639-2ac2-f6ab2fa29064@jp.fujitsu.com>
Date: Fri, 25 Aug 2017 17:35:47 +0900
MIME-Version: 1.0
In-Reply-To: <25fbc871-706b-d435-6c78-120d74ce3505@jp.fujitsu.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

For some commands bluetoothctl gives the hint of argument, which is "on"
and "off", it is convenient even if the argument of command was overlooked
in help message.
---
 client/main.c | 32 +++++++++++++++++++++++++-------
 1 file changed, 25 insertions(+), 7 deletions(-)

diff --git a/client/main.c b/client/main.c
index 34fcbd7..825647d 100644
--- a/client/main.c
+++ b/client/main.c
@@ -73,6 +73,12 @@ static GList *ctrl_list;
 
 static guint input = 0;
 
+static const char * const mode_arguments[] = {
+	"on",
+	"off",
+	NULL
+};
+
 static const char * const agent_arguments[] = {
 	"on",
 	"off",
@@ -2255,6 +2261,11 @@ static char *argument_generator(const char *text, int state,
 	return NULL;
 }
 
+static char *mode_generator(const char *text, int state)
+{
+	return argument_generator(text, state, mode_arguments);
+}
+
 static char *capability_generator(const char *text, int state)
 {
 	return argument_generator(text, state, agent_arguments);
@@ -2421,11 +2432,14 @@ static const struct {
 					"Set controller alias" },
 	{ "reset-alias",  NULL,       cmd_reset_alias,
 					"Reset controller alias" },
-	{ "power",        "<on/off>", cmd_power, "Set controller power" },
+	{ "power",        "<on/off>", cmd_power, "Set controller power",
+							mode_generator },
 	{ "pairable",     "<on/off>", cmd_pairable,
-					"Set controller pairable mode" },
+					"Set controller pairable mode",
+							mode_generator },
 	{ "discoverable", "<on/off>", cmd_discoverable,
-					"Set controller discoverable mode" },
+					"Set controller discoverable mode",
+							mode_generator },
 	{ "agent",        "<on/off/capability>", cmd_agent,
 				"Enable/disable agent with given capability",
 							capability_generator},
@@ -2444,7 +2458,8 @@ static const struct {
 			"Set advertise manufacturer data" },
 	{ "set-advertise-tx-power", "<on/off>",
 			cmd_set_advertise_tx_power,
-			"Enable/disable TX power to be advertised" },
+			"Enable/disable TX power to be advertised",
+							mode_generator },
 	{ "set-advertise-name", "<on/off/name>", cmd_set_advertise_name,
 			"Enable/disable local name to be advertised" },
 	{ "set-advertise-appearance", "<value>", cmd_set_advertise_appearance,
@@ -2459,10 +2474,12 @@ static const struct {
 	{ "set-scan-filter-transport", "[transport]",
 		cmd_set_scan_filter_transport, "Set scan filter transport" },
 	{ "set-scan-filter-reset-data", "[on/off]",
-		cmd_set_scan_filter_reset_data, "Set scan filter reset data" },
+		cmd_set_scan_filter_reset_data, "Set scan filter reset data",
+							mode_generator },
 	{ "set-scan-filter-clear", "", cmd_set_scan_filter_clear,
 						"Clears discovery filter." },
-	{ "scan",         "<on/off>", cmd_scan, "Scan for devices" },
+	{ "scan",         "<on/off>", cmd_scan, "Scan for devices",
+							mode_generator },
 	{ "info",         "[dev]",    cmd_info, "Device information",
 							dev_generator },
 	{ "pair",         "[dev]",    cmd_pair, "Pair with device",
@@ -2499,7 +2516,8 @@ static const struct {
 					"Acquire Notify file descriptor" },
 	{ "release-notify", NULL, cmd_release_notify,
 					"Release Notify file descriptor" },
-	{ "notify",       "<on/off>", cmd_notify, "Notify attribute value" },
+	{ "notify",       "<on/off>", cmd_notify, "Notify attribute value",
+							mode_generator },
 	{ "register-application", "[UUID ...]", cmd_register_app,
 						"Register profile to connect" },
 	{ "unregister-application", NULL, cmd_unregister_app,
-- 
2.7.4

