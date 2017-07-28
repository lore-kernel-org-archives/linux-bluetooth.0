Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/5] client: Add set-scan-filter-reset-data command
Date: Fri, 28 Jul 2017 15:07:51 +0300
Message-Id: <20170728120754.5263-2-luiz.dentz@gmail.com>
In-Reply-To: <20170728120754.5263-1-luiz.dentz@gmail.com>
References: <20170728120754.5263-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds set-scan-filter-reset-data that makes use of ResetData
filter:

[bluetooth]# set-scan-filter-reset-data on
SetDiscoveryFilter success
[bluetooth]# scan on
Discovery started
[CHG] Controller B8:8A:60:D8:17:D7 Discovering: yes
[CHG] Device F0:79:59:2F:D6:5A RSSI: -87
[NEW] Device 39:5B:8F:12:84:2E 39-5B-8F-12-84-2E
[CHG] Device 14:99:E2:0E:AC:6B RSSI: -80
[CHG] Device 14:99:E2:0E:AC:6B ManufacturerData Key: 0x004c
[CHG] Device 14:99:E2:0E:AC:6B ManufacturerData Value: 0x09
[CHG] Device 14:99:E2:0E:AC:6B ManufacturerData Value: 0x06
[CHG] Device 14:99:E2:0E:AC:6B ManufacturerData Value: 0x03
[CHG] Device 14:99:E2:0E:AC:6B ManufacturerData Value: 0x19
[CHG] Device 14:99:E2:0E:AC:6B ManufacturerData Value: 0x00
[CHG] Device 14:99:E2:0E:AC:6B ManufacturerData Value: 0x00
[CHG] Device 14:99:E2:0E:AC:6B ManufacturerData Value: 0x00
[CHG] Device 14:99:E2:0E:AC:6B ManufacturerData Value: 0x00
[CHG] Device 39:5B:8F:12:84:2E RSSI: -30
[CHG] Device F0:79:59:2F:D6:5A RSSI: -87
[CHG] Device 00:1B:DC:07:31:88 RSSI: -31
[CHG] Device 00:1B:DC:07:31:88 ServiceData Key: 00001827-0000-1000-8000-00805f9b34fb
[CHG] Device 00:1B:DC:07:31:88 ServiceData Value: 0xdd
[CHG] Device 00:1B:DC:07:31:88 ServiceData Value: 0xdd
[CHG] Device 00:1B:DC:07:31:88 ServiceData Value: 0x00
[CHG] Device 00:1B:DC:07:31:88 ServiceData Value: 0x00
[CHG] Device 00:1B:DC:07:31:88 ServiceData Value: 0x00
[CHG] Device 00:1B:DC:07:31:88 ServiceData Value: 0x00
[CHG] Device 00:1B:DC:07:31:88 ServiceData Value: 0x00
[CHG] Device 00:1B:DC:07:31:88 ServiceData Value: 0x00
[CHG] Device 00:1B:DC:07:31:88 ServiceData Value: 0x00
[CHG] Device 00:1B:DC:07:31:88 ServiceData Value: 0x00
[CHG] Device 00:1B:DC:07:31:88 ServiceData Value: 0x00
[CHG] Device 00:1B:DC:07:31:88 ServiceData Value: 0x00
[CHG] Device 00:1B:DC:07:31:88 ServiceData Value: 0x00
[CHG] Device 00:1B:DC:07:31:88 ServiceData Value: 0x00
[CHG] Device 00:1B:DC:07:31:88 ServiceData Value: 0x00
[CHG] Device 00:1B:DC:07:31:88 ServiceData Value: 0x00
[CHG] Device 00:1B:DC:07:31:88 ServiceData Value: 0x00
[CHG] Device 00:1B:DC:07:31:88 ServiceData Value: 0x00
[CHG] Device 14:99:E2:0E:AC:6B RSSI: -75
[CHG] Device 14:99:E2:0E:AC:6B ManufacturerData Key: 0x004c
[CHG] Device 14:99:E2:0E:AC:6B ManufacturerData Value: 0x09
[CHG] Device 14:99:E2:0E:AC:6B ManufacturerData Value: 0x06
[CHG] Device 14:99:E2:0E:AC:6B ManufacturerData Value: 0x03
[CHG] Device 14:99:E2:0E:AC:6B ManufacturerData Value: 0x19
[CHG] Device 14:99:E2:0E:AC:6B ManufacturerData Value: 0x00
[CHG] Device 14:99:E2:0E:AC:6B ManufacturerData Value: 0x00
[CHG] Device 14:99:E2:0E:AC:6B ManufacturerData Value: 0x00
[CHG] Device 14:99:E2:0E:AC:6B ManufacturerData Value: 0x00
[CHG] Device F0:79:59:2F:D6:5A RSSI: -86
[CHG] Device F0:79:59:2F:D6:5A RSSI: -86
[CHG] Device F0:79:59:2F:D6:5A RSSI: -86
[CHG] Device 00:1B:DC:07:31:88 RSSI: -27
[CHG] Device 00:1B:DC:07:31:88 ServiceData Key: 00001827-0000-1000-8000-00805f9b34fb
[CHG] Device 00:1B:DC:07:31:88 ServiceData Value: 0xdd
[CHG] Device 00:1B:DC:07:31:88 ServiceData Value: 0xdd
[CHG] Device 00:1B:DC:07:31:88 ServiceData Value: 0x00
[CHG] Device 00:1B:DC:07:31:88 ServiceData Value: 0x00
[CHG] Device 00:1B:DC:07:31:88 ServiceData Value: 0x00
[CHG] Device 00:1B:DC:07:31:88 ServiceData Value: 0x00
[CHG] Device 00:1B:DC:07:31:88 ServiceData Value: 0x00
[CHG] Device 00:1B:DC:07:31:88 ServiceData Value: 0x00
[CHG] Device 00:1B:DC:07:31:88 ServiceData Value: 0x00
[CHG] Device 00:1B:DC:07:31:88 ServiceData Value: 0x00
[CHG] Device 00:1B:DC:07:31:88 ServiceData Value: 0x00
[CHG] Device 00:1B:DC:07:31:88 ServiceData Value: 0x00
[CHG] Device 00:1B:DC:07:31:88 ServiceData Value: 0x00
[CHG] Device 00:1B:DC:07:31:88 ServiceData Value: 0x00
[CHG] Device 00:1B:DC:07:31:88 ServiceData Value: 0x00
[CHG] Device 00:1B:DC:07:31:88 ServiceData Value: 0x00
[CHG] Device 00:1B:DC:07:31:88 ServiceData Value: 0x00
[CHG] Device 00:1B:DC:07:31:88 ServiceData Value: 0x00
---
 client/main.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/client/main.c b/client/main.c
index e0336a14c..76e337c3d 100644
--- a/client/main.c
+++ b/client/main.c
@@ -1189,6 +1189,7 @@ struct set_discovery_filter_args {
 	dbus_int16_t pathloss;
 	char **uuids;
 	size_t uuids_len;
+	dbus_bool_t reset;
 };
 
 static void set_discovery_filter_setup(DBusMessageIter *iter, void *user_data)
@@ -1216,6 +1217,10 @@ static void set_discovery_filter_setup(DBusMessageIter *iter, void *user_data)
 		dict_append_entry(&dict, "Transport", DBUS_TYPE_STRING,
 						&args->transport);
 
+	if (args->reset)
+		dict_append_entry(&dict, "ResetData", DBUS_TYPE_BOOLEAN,
+						&args->reset);
+
 	dbus_message_iter_close_container(iter, &dict);
 }
 
@@ -1239,6 +1244,7 @@ static gint filtered_scan_pathloss = DISTANCE_VAL_INVALID;
 static char **filtered_scan_uuids;
 static size_t filtered_scan_uuids_len;
 static char *filtered_scan_transport;
+static bool filtered_scan_reset_data;
 
 static void cmd_set_scan_filter_commit(void)
 {
@@ -1250,6 +1256,7 @@ static void cmd_set_scan_filter_commit(void)
 	args.transport = filtered_scan_transport;
 	args.uuids = filtered_scan_uuids;
 	args.uuids_len = filtered_scan_uuids_len;
+	args.reset = filtered_scan_reset_data;
 
 	if (check_default_ctrl() == FALSE)
 		return;
@@ -1319,6 +1326,22 @@ static void cmd_set_scan_filter_transport(const char *arg)
 	cmd_set_scan_filter_commit();
 }
 
+static void cmd_set_scan_filter_reset_data(const char *arg)
+{
+	if (!arg || !strlen(arg))
+		filtered_scan_reset_data = false;
+	else if (!strcmp(arg, "on"))
+		filtered_scan_reset_data = true;
+	else if (!strcmp(arg, "off"))
+		filtered_scan_reset_data = false;
+	else {
+		rl_printf("Invalid option: %s\n", arg);
+		return;
+	}
+
+	cmd_set_scan_filter_commit();
+}
+
 static void clear_discovery_filter_setup(DBusMessageIter *iter, void *user_data)
 {
 	DBusMessageIter dict;
@@ -2319,6 +2342,8 @@ static const struct {
 				"Set scan filter pathloss, and clears rssi" },
 	{ "set-scan-filter-transport", "[transport]",
 		cmd_set_scan_filter_transport, "Set scan filter transport" },
+	{ "set-scan-filter-reset-data", "[on/off]",
+		cmd_set_scan_filter_reset_data, "Set scan filter reset data" },
 	{ "set-scan-filter-clear", "", cmd_set_scan_filter_clear,
 						"Clears discovery filter." },
 	{ "scan",         "<on/off>", cmd_scan, "Scan for devices" },
-- 
2.13.3

