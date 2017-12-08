Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 09/10] mesh: Rework set_scan_filter_uuids parameters
Date: Fri,  8 Dec 2017 08:52:55 -0200
Message-Id: <20171208105256.18635-9-luiz.dentz@gmail.com>
In-Reply-To: <20171208105256.18635-1-luiz.dentz@gmail.com>
References: <20171208105256.18635-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

set_scan_filter_uuids is not a command handler which means it doesn't
need to take argc and argv instead just pass the filter array.
---
 mesh/main.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/mesh/main.c b/mesh/main.c
index 4d63c5751..4b9d65d6f 100644
--- a/mesh/main.c
+++ b/mesh/main.c
@@ -1596,16 +1596,16 @@ static void set_scan_filter_commit(void)
 	}
 }
 
-static void set_scan_filter_uuids(int argc, char *argv[])
+static void set_scan_filter_uuids(char *filters[])
 {
 	g_strfreev(filtered_scan_uuids);
 	filtered_scan_uuids = NULL;
 	filtered_scan_uuids_len = 0;
 
-	if (!argc || !strlen(argv[0]))
+	if (!filters)
 		goto commit;
 
-	filtered_scan_uuids = g_strdupv(argv);
+	filtered_scan_uuids = g_strdupv(filters);
 	if (!filtered_scan_uuids) {
 		bt_shell_printf("Failed to parse input\n");
 		return;
@@ -1627,7 +1627,7 @@ static void cmd_scan_unprovisioned_devices(int argc, char *argv[])
 
 	if (enable == TRUE) {
 		discover_mesh = false;
-		set_scan_filter_uuids(1, filters);
+		set_scan_filter_uuids(filters);
 	}
 	cmd_scan(argc, argv);
 }
@@ -1721,7 +1721,7 @@ static void cmd_connect(int argc, char *argv[])
 		g_dbus_proxy_method_call(default_ctrl->proxy, "StopDiscovery",
 						NULL, NULL, NULL, NULL);
 
-	set_scan_filter_uuids(1, filters);
+	set_scan_filter_uuids(filters);
 	discover_mesh = true;
 
 	if (connection.unicast == UNASSIGNED_ADDRESS) {
@@ -1761,7 +1761,7 @@ static void prov_disconn_reply(DBusMessage *message, void *user_data)
 
 	set_connected_device(NULL);
 
-	set_scan_filter_uuids(1, filters);
+	set_scan_filter_uuids(filters);
 	discover_mesh = true;
 
 	connection.type = CONN_TYPE_IDENTITY;
-- 
2.13.6

