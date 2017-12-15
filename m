Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 4/4] clien: Only set the discovery filter when necessary
Date: Fri, 15 Dec 2017 14:09:54 -0200
Message-Id: <20171215160954.3527-4-luiz.dentz@gmail.com>
In-Reply-To: <20171215160954.3527-1-luiz.dentz@gmail.com>
References: <20171215160954.3527-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Only set the discovery filter when the user wants execute the scan
command.
---
 client/main.c | 101 ++++++++++++++++++++++++++--------------------------------
 1 file changed, 45 insertions(+), 56 deletions(-)

diff --git a/client/main.c b/client/main.c
index 9c77a34b9..3b43ed777 100644
--- a/client/main.c
+++ b/client/main.c
@@ -1097,31 +1097,6 @@ static void start_discovery_reply(DBusMessage *message, void *user_data)
 	bt_shell_printf("Discovery %s\n", enable == TRUE ? "started" : "stopped");
 }
 
-static void cmd_scan(int argc, char *argv[])
-{
-	dbus_bool_t enable;
-	const char *method;
-
-	if (!parse_argument(argc, argv, NULL, NULL, &enable, NULL))
-		return;
-
-	if (check_default_ctrl() == FALSE)
-		return;
-
-	if (enable == TRUE)
-		method = "StartDiscovery";
-	else
-		method = "StopDiscovery";
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
@@ -1211,13 +1186,18 @@ static void dict_append_array(DBusMessageIter *dict, const char *key, int type,
 
 #define	DISTANCE_VAL_INVALID	0x7FFF
 
-struct set_discovery_filter_args {
+static struct set_discovery_filter_args {
 	char *transport;
 	dbus_uint16_t rssi;
 	dbus_int16_t pathloss;
 	char **uuids;
 	size_t uuids_len;
 	dbus_bool_t duplicate;
+	bool set;
+} filter = {
+	.rssi = DISTANCE_VAL_INVALID,
+	.pathloss = DISTANCE_VAL_INVALID,
+	.set = true,
 };
 
 static void set_discovery_filter_setup(DBusMessageIter *iter, void *user_data)
@@ -1264,17 +1244,14 @@ static void set_discovery_filter_reply(DBusMessage *message, void *user_data)
 		return;
 	}
 
+	filter.set = true;
+
 	bt_shell_printf("SetDiscoveryFilter success\n");
 }
 
-static struct set_discovery_filter_args filter = {
-	.rssi = DISTANCE_VAL_INVALID,
-	.pathloss = DISTANCE_VAL_INVALID,
-};
-
-static void cmd_set_scan_filter_commit(void)
+static void set_discovery_filter(void)
 {
-	if (check_default_ctrl() == FALSE)
+	if (check_default_ctrl() == FALSE || filter.set)
 		return;
 
 	if (g_dbus_proxy_method_call(default_ctrl->proxy, "SetDiscoveryFilter",
@@ -1283,6 +1260,34 @@ static void cmd_set_scan_filter_commit(void)
 		bt_shell_printf("Failed to set discovery filter\n");
 		return;
 	}
+
+	filter.set = true;
+}
+
+static void cmd_scan(int argc, char *argv[])
+{
+	dbus_bool_t enable;
+	const char *method;
+
+	if (!parse_argument(argc, argv, NULL, NULL, &enable, NULL))
+		return;
+
+	if (check_default_ctrl() == FALSE)
+		return;
+
+	if (enable == TRUE) {
+		set_discovery_filter();
+		method = "StartDiscovery";
+	} else
+		method = "StopDiscovery";
+
+	if (g_dbus_proxy_method_call(default_ctrl->proxy, method,
+				NULL, start_discovery_reply,
+				GUINT_TO_POINTER(enable), NULL) == FALSE) {
+		bt_shell_printf("Failed to %s discovery\n",
+					enable == TRUE ? "start" : "stop");
+		return;
+	}
 }
 
 static void cmd_scan_filter_uuids(int argc, char *argv[])
@@ -1312,7 +1317,7 @@ static void cmd_scan_filter_uuids(int argc, char *argv[])
 	filter.uuids_len = g_strv_length(filter.uuids);
 
 commit:
-	cmd_set_scan_filter_commit();
+	filter.set = false;
 }
 
 static void cmd_scan_filter_rssi(int argc, char *argv[])
@@ -1326,7 +1331,7 @@ static void cmd_scan_filter_rssi(int argc, char *argv[])
 	filter.pathloss = DISTANCE_VAL_INVALID;
 	filter.rssi = atoi(argv[1]);
 
-	cmd_set_scan_filter_commit();
+	filter.set = false;
 }
 
 static void cmd_scan_filter_pathloss(int argc, char *argv[])
@@ -1341,7 +1346,7 @@ static void cmd_scan_filter_pathloss(int argc, char *argv[])
 	filter.rssi = DISTANCE_VAL_INVALID;
 	filter.pathloss = atoi(argv[1]);
 
-	cmd_set_scan_filter_commit();
+	filter.set = false;
 }
 
 static void cmd_scan_filter_transport(int argc, char *argv[])
@@ -1356,7 +1361,7 @@ static void cmd_scan_filter_transport(int argc, char *argv[])
 	g_free(filter.transport);
 	filter.transport = g_strdup(argv[1]);
 
-	cmd_set_scan_filter_commit();
+	filter.set = false;
 }
 
 static void cmd_scan_filter_duplicate_data(int argc, char *argv[])
@@ -1376,20 +1381,7 @@ static void cmd_scan_filter_duplicate_data(int argc, char *argv[])
 		return;
 	}
 
-	cmd_set_scan_filter_commit();
-}
-
-static void clear_discovery_filter_setup(DBusMessageIter *iter, void *user_data)
-{
-	DBusMessageIter dict;
-
-	dbus_message_iter_open_container(iter, DBUS_TYPE_ARRAY,
-				DBUS_DICT_ENTRY_BEGIN_CHAR_AS_STRING
-				DBUS_TYPE_STRING_AS_STRING
-				DBUS_TYPE_VARIANT_AS_STRING
-				DBUS_DICT_ENTRY_END_CHAR_AS_STRING, &dict);
-
-	dbus_message_iter_close_container(iter, &dict);
+	filter.set = false;
 }
 
 static void filter_clear_uuids(void)
@@ -1463,6 +1455,7 @@ static void cmd_scan_filter_clear(int argc, char *argv[])
 	for (fc = filter_clear; fc && fc->name; fc++) {
 		if (all || !strcmp(fc->name, argv[1])) {
 			fc->clear();
+			filter.set = false;
 			if (!all)
 				goto done;
 		}
@@ -1477,11 +1470,7 @@ done:
 	if (check_default_ctrl() == FALSE)
 		return;
 
-	if (g_dbus_proxy_method_call(default_ctrl->proxy, "SetDiscoveryFilter",
-		clear_discovery_filter_setup, set_discovery_filter_reply,
-		NULL, NULL) == FALSE) {
-		bt_shell_printf("Failed to clear discovery filter\n");
-	}
+	set_discovery_filter();
 }
 
 static struct GDBusProxy *find_device(int argc, char *argv[])
-- 
2.13.6

