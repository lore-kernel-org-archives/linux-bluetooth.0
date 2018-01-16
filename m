Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 3/8] client: Rename set-manufacturer to manufacturer
Date: Tue, 16 Jan 2018 17:24:51 -0200
Message-Id: <20180116192456.12186-4-luiz.dentz@gmail.com>
In-Reply-To: <20180116192456.12186-1-luiz.dentz@gmail.com>
References: <20180116192456.12186-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Make the command return the current value if no parameters:

[bluetooth]# manufacturer 2 00
[bluetooth]# manufacturer
Manufacturer: 2
  00
---
 client/advertising.c | 12 ++++++++++--
 client/main.c        |  6 +++---
 2 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/client/advertising.c b/client/advertising.c
index 974462124..304ae683e 100644
--- a/client/advertising.c
+++ b/client/advertising.c
@@ -543,10 +543,18 @@ void ad_advertise_manufacturer(DBusConnection *conn, int argc, char *argv[])
 	long int val;
 	struct ad_data *data;
 
-	ad_clear_manufacturer();
+	if (argc < 2 || !strlen(argv[1])) {
+		if (ad.manufacturer.data.len) {
+			bt_shell_printf("Manufacturer: %u\n",
+						ad.manufacturer.id);
+			bt_shell_hexdump(ad.manufacturer.data.data,
+						ad.manufacturer.data.len);
+		}
 
-	if (argc < 2)
 		return;
+	}
+
+	ad_clear_manufacturer();
 
 	val = strtol(argv[1], &endptr, 0);
 	if (!endptr || *endptr != '\0' || val > UINT16_MAX) {
diff --git a/client/main.c b/client/main.c
index 9d68be62f..26bbc7e80 100644
--- a/client/main.c
+++ b/client/main.c
@@ -2201,7 +2201,7 @@ static void cmd_advertise_service(int argc, char *argv[])
 	ad_advertise_service(dbus_conn, argc, argv);
 }
 
-static void cmd_set_advertise_manufacturer(int argc, char *argv[])
+static void cmd_advertise_manufacturer(int argc, char *argv[])
 {
 	ad_advertise_manufacturer(dbus_conn, argc, argv);
 }
@@ -2291,8 +2291,8 @@ static const struct bt_shell_menu advertise_menu = {
 			"Set advertise uuids" },
 	{ "service", "[uuid] [data=xx xx ...]", cmd_advertise_service,
 			"Set advertise service data" },
-	{ "set-manufacturer", "[id] [data=xx xx ...]",
-			cmd_set_advertise_manufacturer,
+	{ "manufacturer", "[id] [data=xx xx ...]",
+			cmd_advertise_manufacturer,
 			"Set advertise manufacturer data" },
 	{ "set-tx-power", "<on/off>", cmd_set_advertise_tx_power,
 			"Enable/disable TX power to be advertised",
-- 
2.14.3

