Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Steve Brown <sbrown@cortland.com>
Message-ID: <1512404933.29399.10.camel@ewol.com>
Subject: [PATCH BlueZ]mesh: meshctl add Node Identity option to connect
 command
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Date: Mon, 04 Dec 2017 09:28:53 -0700
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This adds the option to connect via either Node Identity or Network ID
advertisements. Adding the node unicast address selects Node Identity.

See Mesh Profile Specification 7.2.2.2 for further details.

---

diff --git a/mesh/main.c b/mesh/main.c
index d7e45e56b..e19b7f413 100644
--- a/mesh/main.c
+++ b/mesh/main.c
@@ -1773,6 +1774,8 @@ static void cmd_connect(const char *arg)
 			rl_printf("Invalid network index %s\n", arg);
 			return;
 		}
+
+		connection.unicast = strtol(end, NULL, 16);
 	}
 
 	if (discovering)
@@ -1782,11 +1785,17 @@ static void cmd_connect(const char *arg)
 	set_scan_filter_uuids(MESH_PROXY_SVC_UUID);
 	discover_mesh = true;
 
-	connection.type = CONN_TYPE_NETWORK;
-
+	if (connection.unicast == UNASSIGNED_ADDRESS) {
+		connection.type = CONN_TYPE_NETWORK;
+		rl_printf("Looking for mesh network with net index %4.4x\n",
+				connection.net_idx);
+	} else {
+		connection.type = CONN_TYPE_IDENTITY;
+		rl_printf("Looking for node id %4.4x"
+				" on network with net index %4.4x\n",
+				connection.unicast, connection.net_idx);
+	}
 
-	rl_printf("Looking for mesh network with net index %4.4x\n",
-							connection.net_idx);
 
 	if (g_dbus_proxy_method_call(default_ctrl->proxy,
 			"StartDiscovery", NULL, start_discovery_reply,
@@ -2005,7 +2014,8 @@ static const struct menu_entry meshctl_cmd_table[] = {
 	{ "security",     "[0(low)/1(medium)/2(high)]", cmd_security,
 				"Display or change provision security level"},
 	{ "info",         "[dev]",    cmd_info, "Device information"},
-	{ "connect",      "[net_idx]",cmd_connect, "Connect to mesh network"},
+	{ "connect",      "[net_idx] [dst]",cmd_connect,
+				"Connect to mesh network or node on network"},
 	{ "discover-unprovisioned", "<on/off>", cmd_scan_unprovisioned_devices,
 					"Look for devices to provision" },
 	{ "provision",    "<uuid>",   cmd_start_prov, "Initiate provisioning"},
