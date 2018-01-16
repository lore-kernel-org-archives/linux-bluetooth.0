Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 6/8] client: Rename set-appearance to appearance
Date: Tue, 16 Jan 2018 17:24:54 -0200
Message-Id: <20180116192456.12186-7-luiz.dentz@gmail.com>
In-Reply-To: <20180116192456.12186-1-luiz.dentz@gmail.com>
References: <20180116192456.12186-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Make the command return the current value if no parameters:

[bluetooth]# appearance 0x0001
[bluetooth]# appearance
Appearance: Unknown (0x0001)
---
 client/advertising.c | 18 +++++++++++++++---
 client/advertising.h |  2 +-
 client/main.c        | 11 ++++++++---
 3 files changed, 24 insertions(+), 7 deletions(-)

diff --git a/client/advertising.c b/client/advertising.c
index f5ba0b97b..d95974f08 100644
--- a/client/advertising.c
+++ b/client/advertising.c
@@ -647,12 +647,24 @@ void ad_advertise_appearance(DBusConnection *conn, bool value)
 	g_dbus_emit_property_changed(conn, AD_PATH, AD_IFACE, "Includes");
 }
 
-void ad_advertise_local_appearance(DBusConnection *conn, uint16_t value)
+void ad_advertise_local_appearance(DBusConnection *conn, long int *value)
 {
-	if (ad.local_appearance == value)
+	if (!value) {
+		if (ad.local_appearance != UINT16_MAX)
+			bt_shell_printf("Appearance: %s (0x%04x)\n",
+					bt_appear_to_str(ad.local_appearance),
+					ad.local_appearance);
+		else
+			bt_shell_printf("Apperance: %s\n",
+					ad.appearance ? "on" : "off");
+
+		return;
+	}
+
+	if (ad.local_appearance == *value)
 		return;
 
-	ad.local_appearance = value;
+	ad.local_appearance = *value;
 
 	g_dbus_emit_property_changed(conn, AD_PATH, AD_IFACE, "Appearance");
 }
diff --git a/client/advertising.h b/client/advertising.h
index 6c73b638d..7edf4fd95 100644
--- a/client/advertising.h
+++ b/client/advertising.h
@@ -31,6 +31,6 @@ void ad_advertise_tx_power(DBusConnection *conn, dbus_bool_t *value);
 void ad_advertise_name(DBusConnection *conn, bool value);
 void ad_advertise_appearance(DBusConnection *conn, bool value);
 void ad_advertise_local_name(DBusConnection *conn, const char *name);
-void ad_advertise_local_appearance(DBusConnection *conn, uint16_t value);
+void ad_advertise_local_appearance(DBusConnection *conn, long int *value);
 void ad_advertise_duration(DBusConnection *conn, uint16_t value);
 void ad_advertise_timeout(DBusConnection *conn, uint16_t value);
diff --git a/client/main.c b/client/main.c
index 01a3c2131..49b165231 100644
--- a/client/main.c
+++ b/client/main.c
@@ -2241,11 +2241,16 @@ static void cmd_advertise_name(int argc, char *argv[])
 	ad_advertise_local_name(dbus_conn, argv[1]);
 }
 
-static void cmd_set_advertise_appearance(int argc, char *argv[])
+static void cmd_advertise_appearance(int argc, char *argv[])
 {
 	long int value;
 	char *endptr = NULL;
 
+	if (argc < 2) {
+		ad_advertise_local_appearance(dbus_conn, NULL);
+		return;
+	}
+
 	if (strcmp(argv[1], "on") == 0 || strcmp(argv[1], "yes") == 0) {
 		ad_advertise_appearance(dbus_conn, true);
 		return;
@@ -2262,7 +2267,7 @@ static void cmd_set_advertise_appearance(int argc, char *argv[])
 		return;
 	}
 
-	ad_advertise_local_appearance(dbus_conn, value);
+	ad_advertise_local_appearance(dbus_conn, &value);
 }
 
 static void cmd_set_advertise_duration(int argc, char *argv[])
@@ -2309,7 +2314,7 @@ static const struct bt_shell_menu advertise_menu = {
 							mode_generator },
 	{ "name", "[on/off/name]", cmd_advertise_name,
 			"Enable/disable local name to be advertised" },
-	{ "set-appearance", "<value>", cmd_set_advertise_appearance,
+	{ "appearance", "[value]", cmd_advertise_appearance,
 			"Set custom appearance to be advertised" },
 	{ "set-duration", "<seconds>", cmd_set_advertise_duration,
 			"Set advertise duration" },
-- 
2.14.3

