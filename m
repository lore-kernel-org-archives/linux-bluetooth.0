Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 5/8] client: Rename set-name to name
Date: Tue, 16 Jan 2018 17:24:53 -0200
Message-Id: <20180116192456.12186-6-luiz.dentz@gmail.com>
In-Reply-To: <20180116192456.12186-1-luiz.dentz@gmail.com>
References: <20180116192456.12186-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Make the command return the current value if no parameters:

[bluetooth]# name blah
[bluetooth]# name
LocalName: blah
---
 client/advertising.c | 6 ++++++
 client/main.c        | 9 +++++++--
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/client/advertising.c b/client/advertising.c
index 05c69102c..f5ba0b97b 100644
--- a/client/advertising.c
+++ b/client/advertising.c
@@ -619,6 +619,12 @@ void ad_advertise_name(DBusConnection *conn, bool value)
 
 void ad_advertise_local_name(DBusConnection *conn, const char *name)
 {
+	if (!name) {
+		if (ad.local_name)
+			bt_shell_printf("LocalName: %s\n", ad.local_name);
+		return;
+	}
+
 	if (ad.local_name && !strcmp(name, ad.local_name))
 		return;
 
diff --git a/client/main.c b/client/main.c
index 195a86141..01a3c2131 100644
--- a/client/main.c
+++ b/client/main.c
@@ -2221,8 +2221,13 @@ static void cmd_advertise_tx_power(int argc, char *argv[])
 	ad_advertise_tx_power(dbus_conn, &powered);
 }
 
-static void cmd_set_advertise_name(int argc, char *argv[])
+static void cmd_advertise_name(int argc, char *argv[])
 {
+	if (argc < 2) {
+		ad_advertise_local_name(dbus_conn, NULL);
+		return;
+	}
+
 	if (strcmp(argv[1], "on") == 0 || strcmp(argv[1], "yes") == 0) {
 		ad_advertise_name(dbus_conn, true);
 		return;
@@ -2302,7 +2307,7 @@ static const struct bt_shell_menu advertise_menu = {
 	{ "tx-power", "[on/off]", cmd_advertise_tx_power,
 			"Enable/disable TX power to be advertised",
 							mode_generator },
-	{ "set-name", "<on/off/name>", cmd_set_advertise_name,
+	{ "name", "[on/off/name]", cmd_advertise_name,
 			"Enable/disable local name to be advertised" },
 	{ "set-appearance", "<value>", cmd_set_advertise_appearance,
 			"Set custom appearance to be advertised" },
-- 
2.14.3

