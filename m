Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 10/10] mesh: Remove cmd_scan
Date: Fri,  8 Dec 2017 08:52:56 -0200
Message-Id: <20171208105256.18635-10-luiz.dentz@gmail.com>
In-Reply-To: <20171208105256.18635-1-luiz.dentz@gmail.com>
References: <20171208105256.18635-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

cmd_scan is only used internally by discover-unprovisioned.
---
 mesh/main.c | 45 ++++++++++++++++-----------------------------
 1 file changed, 16 insertions(+), 29 deletions(-)

diff --git a/mesh/main.c b/mesh/main.c
index 4b9d65d6f..9360481f8 100644
--- a/mesh/main.c
+++ b/mesh/main.c
@@ -1398,32 +1398,6 @@ static void cmd_power(int argc, char *argv[])
 	g_free(str);
 }
 
-static void cmd_scan(int argc, char *argv[])
-{
-	dbus_bool_t enable;
-	const char *method;
-
-	if (parse_argument_on_off(argc, argv, &enable) == FALSE)
-		return;
-
-	if (check_default_ctrl() == FALSE)
-		return;
-
-	if (enable == TRUE) {
-		method = "StartDiscovery";
-	} else {
-		method = "StopDiscovery";
-	}
-
-	if (g_dbus_proxy_method_call(default_ctrl->proxy, method,
-				NULL, start_discovery_reply,
-				GUINT_TO_POINTER(enable), NULL) == FALSE) {
-		bt_shell_printf("Failed to %s discovery\n",
-					enable == TRUE ? "start" : "stop");
-		return;
-	}
-}
-
 static void append_variant(DBusMessageIter *iter, int type, void *val)
 {
 	DBusMessageIter value;
@@ -1617,19 +1591,32 @@ commit:
 	set_scan_filter_commit();
 }
 
-static void cmd_scan_unprovisioned_devices(int argc, char *argv[])
+static void cmd_scan_unprovisioned(int argc, char *argv[])
 {
 	dbus_bool_t enable;
 	char *filters[] = { MESH_PROV_SVC_UUID, NULL };
+	const char *method;
 
 	if (parse_argument_on_off(argc, argv, &enable) == FALSE)
 		return;
 
+	if (check_default_ctrl() == FALSE)
+		return;
+
 	if (enable == TRUE) {
 		discover_mesh = false;
 		set_scan_filter_uuids(filters);
+		method = "StartDiscovery";
+	} else {
+		method = "StopDiscovery";
+	}
+
+	if (g_dbus_proxy_method_call(default_ctrl->proxy, method,
+				NULL, start_discovery_reply,
+				GUINT_TO_POINTER(enable), NULL) == FALSE) {
+		bt_shell_printf("Failed to %s discovery\n",
+					enable == TRUE ? "start" : "stop");
 	}
-	cmd_scan(argc, argv);
 }
 
 static void cmd_info(int argc, char *argv[])
@@ -1912,7 +1899,7 @@ static const struct bt_shell_menu main_menu = {
 	{ "info",         "[dev]",    cmd_info, "Device information"},
 	{ "connect",      "[net_idx] [dst]", cmd_connect,
 				"Connect to mesh network or node on network"},
-	{ "discover-unprovisioned", "<on/off>", cmd_scan_unprovisioned_devices,
+	{ "discover-unprovisioned", "<on/off>", cmd_scan_unprovisioned,
 					"Look for devices to provision" },
 	{ "provision",    "<uuid>",   cmd_start_prov, "Initiate provisioning"},
 	{ "power",        "<on/off>", cmd_power, "Set controller power" },
-- 
2.13.6

