Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 7/8] client: Rename set-duration to duration
Date: Tue, 16 Jan 2018 17:24:55 -0200
Message-Id: <20180116192456.12186-8-luiz.dentz@gmail.com>
In-Reply-To: <20180116192456.12186-1-luiz.dentz@gmail.com>
References: <20180116192456.12186-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Make the command return the current value if no parameters:

[bluetooth]# duration 1
[bluetooth]# duration
Duration: 1 sec
---
 client/advertising.c | 11 ++++++++---
 client/advertising.h |  2 +-
 client/main.c        | 13 +++++++++----
 3 files changed, 18 insertions(+), 8 deletions(-)

diff --git a/client/advertising.c b/client/advertising.c
index d95974f08..ae639df9b 100644
--- a/client/advertising.c
+++ b/client/advertising.c
@@ -669,12 +669,17 @@ void ad_advertise_local_appearance(DBusConnection *conn, long int *value)
 	g_dbus_emit_property_changed(conn, AD_PATH, AD_IFACE, "Appearance");
 }
 
-void ad_advertise_duration(DBusConnection *conn, uint16_t value)
+void ad_advertise_duration(DBusConnection *conn, long int *value)
 {
-	if (ad.duration == value)
+	if (!value) {
+		bt_shell_printf("Duration: %u sec\n", ad.duration);
+		return;
+	}
+
+	if (ad.duration == *value)
 		return;
 
-	ad.duration = value;
+	ad.duration = *value;
 
 	g_dbus_emit_property_changed(conn, AD_PATH, AD_IFACE, "Duration");
 }
diff --git a/client/advertising.h b/client/advertising.h
index 7edf4fd95..04fe38b1a 100644
--- a/client/advertising.h
+++ b/client/advertising.h
@@ -32,5 +32,5 @@ void ad_advertise_name(DBusConnection *conn, bool value);
 void ad_advertise_appearance(DBusConnection *conn, bool value);
 void ad_advertise_local_name(DBusConnection *conn, const char *name);
 void ad_advertise_local_appearance(DBusConnection *conn, long int *value);
-void ad_advertise_duration(DBusConnection *conn, uint16_t value);
+void ad_advertise_duration(DBusConnection *conn, long int *value);
 void ad_advertise_timeout(DBusConnection *conn, uint16_t value);
diff --git a/client/main.c b/client/main.c
index 49b165231..80e4c82ed 100644
--- a/client/main.c
+++ b/client/main.c
@@ -2270,18 +2270,23 @@ static void cmd_advertise_appearance(int argc, char *argv[])
 	ad_advertise_local_appearance(dbus_conn, &value);
 }
 
-static void cmd_set_advertise_duration(int argc, char *argv[])
+static void cmd_advertise_duration(int argc, char *argv[])
 {
 	long int value;
 	char *endptr = NULL;
 
+	if (argc < 2) {
+		ad_advertise_duration(dbus_conn, NULL);
+		return;
+	}
+
 	value = strtol(argv[1], &endptr, 0);
 	if (!endptr || *endptr != '\0' || value > UINT16_MAX) {
 		bt_shell_printf("Invalid argument\n");
 		return;
 	}
 
-	ad_advertise_duration(dbus_conn, value);
+	ad_advertise_duration(dbus_conn, &value);
 }
 
 static void cmd_set_advertise_timeout(int argc, char *argv[])
@@ -2316,8 +2321,8 @@ static const struct bt_shell_menu advertise_menu = {
 			"Enable/disable local name to be advertised" },
 	{ "appearance", "[value]", cmd_advertise_appearance,
 			"Set custom appearance to be advertised" },
-	{ "set-duration", "<seconds>", cmd_set_advertise_duration,
-			"Set advertise duration" },
+	{ "duration", "[seconds]", cmd_advertise_duration,
+			"Set/Get advertise duration" },
 	{ "set-timeout", "<seconds>", cmd_set_advertise_timeout,
 			"Set advertise timeout" },
 	{ } },
-- 
2.14.3

