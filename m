Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 4/8] client: Rename set-tx-power to tx-power
Date: Tue, 16 Jan 2018 17:24:52 -0200
Message-Id: <20180116192456.12186-5-luiz.dentz@gmail.com>
In-Reply-To: <20180116192456.12186-1-luiz.dentz@gmail.com>
References: <20180116192456.12186-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Make the command return the current value if no parameters:

[bluetooth]# tx-power on
[bluetooth]# tx-power
Tx Power: on
---
 client/advertising.c | 11 ++++++++---
 client/advertising.h |  2 +-
 client/main.c        | 11 ++++++++---
 3 files changed, 17 insertions(+), 7 deletions(-)

diff --git a/client/advertising.c b/client/advertising.c
index 304ae683e..05c69102c 100644
--- a/client/advertising.c
+++ b/client/advertising.c
@@ -587,12 +587,17 @@ void ad_advertise_manufacturer(DBusConnection *conn, int argc, char *argv[])
 							"ManufacturerData");
 }
 
-void ad_advertise_tx_power(DBusConnection *conn, bool value)
+void ad_advertise_tx_power(DBusConnection *conn, dbus_bool_t *value)
 {
-	if (ad.tx_power == value)
+	if (!value) {
+		bt_shell_printf("Tx Power: %s\n", ad.tx_power ? "on" : "off");
+		return;
+	}
+
+	if (ad.tx_power == *value)
 		return;
 
-	ad.tx_power = value;
+	ad.tx_power = *value;
 
 	g_dbus_emit_property_changed(conn, AD_PATH, AD_IFACE, "Includes");
 }
diff --git a/client/advertising.h b/client/advertising.h
index d7472e1a5..6c73b638d 100644
--- a/client/advertising.h
+++ b/client/advertising.h
@@ -27,7 +27,7 @@ void ad_unregister(DBusConnection *conn, GDBusProxy *manager);
 void ad_advertise_uuids(DBusConnection *conn, int argc, char *argv[]);
 void ad_advertise_service(DBusConnection *conn, int argc, char *argv[]);
 void ad_advertise_manufacturer(DBusConnection *conn, int argc, char *argv[]);
-void ad_advertise_tx_power(DBusConnection *conn, bool value);
+void ad_advertise_tx_power(DBusConnection *conn, dbus_bool_t *value);
 void ad_advertise_name(DBusConnection *conn, bool value);
 void ad_advertise_appearance(DBusConnection *conn, bool value);
 void ad_advertise_local_name(DBusConnection *conn, const char *name);
diff --git a/client/main.c b/client/main.c
index 26bbc7e80..195a86141 100644
--- a/client/main.c
+++ b/client/main.c
@@ -2206,14 +2206,19 @@ static void cmd_advertise_manufacturer(int argc, char *argv[])
 	ad_advertise_manufacturer(dbus_conn, argc, argv);
 }
 
-static void cmd_set_advertise_tx_power(int argc, char *argv[])
+static void cmd_advertise_tx_power(int argc, char *argv[])
 {
 	dbus_bool_t powered;
 
+	if (argc < 2) {
+		ad_advertise_tx_power(dbus_conn, NULL);
+		return;
+	}
+
 	if (!parse_argument(argc, argv, NULL, NULL, &powered, NULL))
 		return;
 
-	ad_advertise_tx_power(dbus_conn, powered);
+	ad_advertise_tx_power(dbus_conn, &powered);
 }
 
 static void cmd_set_advertise_name(int argc, char *argv[])
@@ -2294,7 +2299,7 @@ static const struct bt_shell_menu advertise_menu = {
 	{ "manufacturer", "[id] [data=xx xx ...]",
 			cmd_advertise_manufacturer,
 			"Set advertise manufacturer data" },
-	{ "set-tx-power", "<on/off>", cmd_set_advertise_tx_power,
+	{ "tx-power", "[on/off]", cmd_advertise_tx_power,
 			"Enable/disable TX power to be advertised",
 							mode_generator },
 	{ "set-name", "<on/off/name>", cmd_set_advertise_name,
-- 
2.14.3

