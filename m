Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 3/6] client: Add scan.discoverable command
Date: Mon, 30 Jul 2018 14:14:24 +0300
Message-Id: <20180730111427.29947-3-luiz.dentz@gmail.com>
In-Reply-To: <20180730111427.29947-1-luiz.dentz@gmail.com>
References: <20180730111427.29947-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds discoverable command to scan menu which can be used to set
if adapter should become discoverable while scanning:

[bluetooth]# scan.discoverable on
[bluetooth]# scan on
SetDiscoveryFilter success
[CHG] Controller XX:XX:XX:XX:XX:XX Discoverable: yes
Discovery started
[CHG] Controller XX:XX:XX:XX:XX:XX Discovering: yes
[bluetooth]# scan off
Discovery stopped
[CHG] Controller XX:XX:XX:XX:XX:XX Discoverable: no
---
 client/main.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/client/main.c b/client/main.c
index 6f472d050..6e6f6d2fb 100644
--- a/client/main.c
+++ b/client/main.c
@@ -1166,6 +1166,7 @@ static struct set_discovery_filter_args {
 	char **uuids;
 	size_t uuids_len;
 	dbus_bool_t duplicate;
+	dbus_bool_t discoverable;
 	bool set;
 } filter = {
 	.rssi = DISTANCE_VAL_INVALID,
@@ -1205,6 +1206,11 @@ static void set_discovery_filter_setup(DBusMessageIter *iter, void *user_data)
 						DBUS_TYPE_BOOLEAN,
 						&args->duplicate);
 
+	if (args->discoverable)
+		g_dbus_dict_append_entry(&dict, "Discoverable",
+						DBUS_TYPE_BOOLEAN,
+						&args->discoverable);
+
 	dbus_message_iter_close_container(iter, &dict);
 }
 
@@ -1362,6 +1368,26 @@ static void cmd_scan_filter_duplicate_data(int argc, char *argv[])
 	filter.set = false;
 }
 
+static void cmd_scan_filter_discoverable(int argc, char *argv[])
+{
+	if (argc < 2 || !strlen(argv[1])) {
+		bt_shell_printf("Discoverable: %s\n",
+				filter.discoverable ? "on" : "off");
+		return bt_shell_noninteractive_quit(EXIT_SUCCESS);
+	}
+
+	if (!strcmp(argv[1], "on"))
+		filter.discoverable = true;
+	else if (!strcmp(argv[1], "off"))
+		filter.discoverable = false;
+	else {
+		bt_shell_printf("Invalid option: %s\n", argv[1]);
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+
+	filter.set = false;
+}
+
 static void filter_clear_uuids(void)
 {
 	g_strfreev(filter.uuids);
@@ -2510,6 +2536,9 @@ static const struct bt_shell_menu scan_menu = {
 	{ "duplicate-data", "[on/off]", cmd_scan_filter_duplicate_data,
 				"Set/Get duplicate data filter",
 				NULL },
+	{ "discoverable", "[on/off]", cmd_scan_filter_discoverable,
+				"Set/Get discoverable filter",
+				NULL },
 	{ "clear", "[uuids/rssi/pathloss/transport/duplicate-data]",
 				cmd_scan_filter_clear,
 				"Clears discovery filter.",
-- 
2.17.1

