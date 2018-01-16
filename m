Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/8] client: Rename set-uuids to uuids
Date: Tue, 16 Jan 2018 17:24:48 -0200
Message-Id: <20180116192456.12186-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Make the command return the current value if no parameters:

[bluetooth]# uuids 0x1820
[bluetooth]# uuids
UUID: Internet Protocol Support (0x1820
---
 client/advertising.c | 39 ++++++++++++++++++++++++++++++++++++---
 client/main.c        |  6 +++---
 2 files changed, 39 insertions(+), 6 deletions(-)

diff --git a/client/advertising.c b/client/advertising.c
index f0fd3599e..5174417a8 100644
--- a/client/advertising.c
+++ b/client/advertising.c
@@ -32,6 +32,7 @@
 #include <string.h>
 
 #include "gdbus/gdbus.h"
+#include "src/shared/util.h"
 #include "src/shared/shell.h"
 #include "advertising.h"
 
@@ -434,15 +435,47 @@ void ad_unregister(DBusConnection *conn, GDBusProxy *manager)
 	}
 }
 
+static void print_uuid(const char *uuid)
+{
+	const char *text;
+
+	text = bt_uuidstr_to_str(uuid);
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
+		bt_shell_printf("\tUUID: %s(%s)\n", str, uuid);
+	} else
+		bt_shell_printf("\tUUID: (%s)\n", uuid);
+}
+
 void ad_advertise_uuids(DBusConnection *conn, int argc, char *argv[])
 {
+	if (argc < 2 || !strlen(argv[1])) {
+		char **uuid;
+
+		for (uuid = ad.uuids; uuid && *uuid; uuid++)
+			print_uuid(*uuid);
+
+		return;
+	}
+
 	g_strfreev(ad.uuids);
 	ad.uuids = NULL;
 	ad.uuids_len = 0;
 
-	if (argc < 2 || !strlen(argv[1]))
-		return;
-
 	ad.uuids = g_strdupv(&argv[1]);
 	if (!ad.uuids) {
 		bt_shell_printf("Failed to parse input\n");
diff --git a/client/main.c b/client/main.c
index a52599deb..d13dabdd0 100644
--- a/client/main.c
+++ b/client/main.c
@@ -2191,7 +2191,7 @@ static char *ad_generator(const char *text, int state)
 	return argument_generator(text, state, ad_arguments);
 }
 
-static void cmd_set_advertise_uuids(int argc, char *argv[])
+static void cmd_advertise_uuids(int argc, char *argv[])
 {
 	ad_advertise_uuids(dbus_conn, argc, argv);
 }
@@ -2287,8 +2287,8 @@ static const struct bt_shell_menu advertise_menu = {
 	.name = "advertise",
 	.desc = "Advertise Options Submenu",
 	.entries = {
-	{ "set-uuids", "[uuid1 uuid2 ...]",
-			cmd_set_advertise_uuids, "Set advertise uuids" },
+	{ "uuids", "[uuid1 uuid2 ...]", cmd_advertise_uuids,
+			"Set advertise uuids" },
 	{ "set-service", "[uuid] [data=xx xx ...]", cmd_set_advertise_service,
 			"Set advertise service data" },
 	{ "set-manufacturer", "[id] [data=xx xx ...]",
-- 
2.14.3

