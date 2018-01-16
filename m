Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/8] client: Rename set-service to service
Date: Tue, 16 Jan 2018 17:24:50 -0200
Message-Id: <20180116192456.12186-3-luiz.dentz@gmail.com>
In-Reply-To: <20180116192456.12186-1-luiz.dentz@gmail.com>
References: <20180116192456.12186-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Make the command return the current value if no parameters:

[bluetooth]# service 0x1820 00 00 00
[bluetooth]# service
	UUID: Internet Protocol Support (0x1820)
  00 00 00                                         ...
---
 client/advertising.c | 9 +++++----
 client/main.c        | 4 ++--
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/client/advertising.c b/client/advertising.c
index 5174417a8..974462124 100644
--- a/client/advertising.c
+++ b/client/advertising.c
@@ -498,15 +498,16 @@ void ad_advertise_service(DBusConnection *conn, int argc, char *argv[])
 	unsigned int i;
 	struct ad_data *data;
 
-	ad_clear_service();
-
-	if (argc < 2)
+	if (argc < 2 || !strlen(argv[1])) {
+		print_uuid(ad.service.uuid);
+		bt_shell_hexdump(ad.service.data.data, ad.service.data.len);
 		return;
+	}
 
 	ad.service.uuid = g_strdup(argv[1]);
 	data = &ad.service.data;
 
-	for (i = 1; i < (unsigned int) argc; i++) {
+	for (i = 2; i < (unsigned int) argc; i++) {
 		long int val;
 		char *endptr = NULL;
 
diff --git a/client/main.c b/client/main.c
index d13dabdd0..9d68be62f 100644
--- a/client/main.c
+++ b/client/main.c
@@ -2196,7 +2196,7 @@ static void cmd_advertise_uuids(int argc, char *argv[])
 	ad_advertise_uuids(dbus_conn, argc, argv);
 }
 
-static void cmd_set_advertise_service(int argc, char *argv[])
+static void cmd_advertise_service(int argc, char *argv[])
 {
 	ad_advertise_service(dbus_conn, argc, argv);
 }
@@ -2289,7 +2289,7 @@ static const struct bt_shell_menu advertise_menu = {
 	.entries = {
 	{ "uuids", "[uuid1 uuid2 ...]", cmd_advertise_uuids,
 			"Set advertise uuids" },
-	{ "set-service", "[uuid] [data=xx xx ...]", cmd_set_advertise_service,
+	{ "service", "[uuid] [data=xx xx ...]", cmd_advertise_service,
 			"Set advertise service data" },
 	{ "set-manufacturer", "[id] [data=xx xx ...]",
 			cmd_set_advertise_manufacturer,
-- 
2.14.3

