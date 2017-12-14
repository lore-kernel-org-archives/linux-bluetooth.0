Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 03/11] client: Rename set-filter-uuids to uuids
Date: Thu, 14 Dec 2017 10:02:52 -0200
Message-Id: <20171214120300.20018-3-luiz.dentz@gmail.com>
In-Reply-To: <20171214120300.20018-1-luiz.dentz@gmail.com>
References: <20171214120300.20018-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

All commands under scan submenu are related to set-filter so remove its
portion from it and make the command return the current value if no
parameters:

[bluetooth]# uuids 0x1820
SetDiscoveryFilter success
[bluetooth]# uuids
	UUID: Internet Protocol Support (0x1820)

Note that to filter all UUIDs user must now use "all" instead of empty
list.
---
 client/main.c | 67 ++++++++++++++++++++++++++++++++++++-----------------------
 1 file changed, 41 insertions(+), 26 deletions(-)

diff --git a/client/main.c b/client/main.c
index b8454abdc..461eb8487 100644
--- a/client/main.c
+++ b/client/main.c
@@ -325,6 +325,32 @@ static void print_property(GDBusProxy *proxy, const char *name)
 	print_iter("\t", name, &iter);
 }
 
+static void print_uuid(const char *uuid)
+{
+	const char *text;
+
+	text = uuidstr_to_str(uuid);
+	if (text) {
+		char str[26];
+		unsigned int n;
+
+		str[sizeof(str) - 1] = '\0';
+
+		n = snprintf(str, sizeof(str), "%s", text);
+		if (n > sizeof(str) - 1) {
+			str[sizeof(str) - 2] = '.';
+			str[sizeof(str) - 3] = '.';
+			if (str[sizeof(str) - 4] == ' ')
+				str[sizeof(str) - 4] = '.';
+
+			n = sizeof(str) - 1;
+		}
+
+		bt_shell_printf("\tUUID: %s%*c(%s)\n", str, 26 - n, ' ', uuid);
+	} else
+		bt_shell_printf("\tUUID: %*c(%s)\n", 26, ' ', uuid);
+}
+
 static void print_uuids(GDBusProxy *proxy)
 {
 	DBusMessageIter iter, value;
@@ -335,31 +361,11 @@ static void print_uuids(GDBusProxy *proxy)
 	dbus_message_iter_recurse(&iter, &value);
 
 	while (dbus_message_iter_get_arg_type(&value) == DBUS_TYPE_STRING) {
-		const char *uuid, *text;
+		const char *uuid;
 
 		dbus_message_iter_get_basic(&value, &uuid);
 
-		text = uuidstr_to_str(uuid);
-		if (text) {
-			char str[26];
-			unsigned int n;
-
-			str[sizeof(str) - 1] = '\0';
-
-			n = snprintf(str, sizeof(str), "%s", text);
-			if (n > sizeof(str) - 1) {
-				str[sizeof(str) - 2] = '.';
-				str[sizeof(str) - 3] = '.';
-				if (str[sizeof(str) - 4] == ' ')
-					str[sizeof(str) - 4] = '.';
-
-				n = sizeof(str) - 1;
-			}
-
-			bt_shell_printf("\tUUID: %s%*c(%s)\n",
-						str, 26 - n, ' ', uuid);
-		} else
-			bt_shell_printf("\tUUID: %*c(%s)\n", 26, ' ', uuid);
+		print_uuid(uuid);
 
 		dbus_message_iter_next(&value);
 	}
@@ -1291,13 +1297,22 @@ static void cmd_set_scan_filter_commit(void)
 	}
 }
 
-static void cmd_set_scan_filter_uuids(int argc, char *argv[])
+static void cmd_scan_filter_uuids(int argc, char *argv[])
 {
+	if (argc < 2 || !strlen(argv[1])) {
+		char **uuid;
+
+		for (uuid = filtered_scan_uuids; uuid && *uuid; uuid++)
+			print_uuid(*uuid);
+
+		return;
+	}
+
 	g_strfreev(filtered_scan_uuids);
 	filtered_scan_uuids = NULL;
 	filtered_scan_uuids_len = 0;
 
-	if (argc < 2 || !strlen(argv[1]))
+	if (!strcmp(argv[1], "all"))
 		goto commit;
 
 	filtered_scan_uuids = g_strdupv(&argv[1]);
@@ -2229,8 +2244,8 @@ static const struct bt_shell_menu scan_menu = {
 	.name = "scan",
 	.desc = "Scan Options Submenu",
 	.entries = {
-	{ "set-filter-uuids", "[uuid1 uuid2 ...]", cmd_set_scan_filter_uuids,
-				"Set scan filter uuids" },
+	{ "uuids", "[all/uuid1 uuid2 ...]", cmd_scan_filter_uuids,
+				"Set/Get UUIDs filter" },
 	{ "set-filter-rssi", "[rssi]", cmd_set_scan_filter_rssi,
 				"Set scan filter rssi, and clears pathloss" },
 	{ "set-filter-pathloss", "[pathloss]", cmd_set_scan_filter_pathloss,
-- 
2.13.6

