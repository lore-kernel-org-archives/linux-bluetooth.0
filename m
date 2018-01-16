Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 8/8] client: Rename set-timeout to timeout
Date: Tue, 16 Jan 2018 17:24:56 -0200
Message-Id: <20180116192456.12186-9-luiz.dentz@gmail.com>
In-Reply-To: <20180116192456.12186-1-luiz.dentz@gmail.com>
References: <20180116192456.12186-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Make the command return the current value if no parameters:

[bluetooth]# timeout 1
[bluetooth]# timeout
Timeout: 1 sec
---
 client/advertising.c | 11 ++++++++---
 client/advertising.h |  2 +-
 client/main.c        | 13 +++++++++----
 3 files changed, 18 insertions(+), 8 deletions(-)

diff --git a/client/advertising.c b/client/advertising.c
index ae639df9b..f7d054c73 100644
--- a/client/advertising.c
+++ b/client/advertising.c
@@ -684,12 +684,17 @@ void ad_advertise_duration(DBusConnection *conn, long int *value)
 	g_dbus_emit_property_changed(conn, AD_PATH, AD_IFACE, "Duration");
 }
 
-void ad_advertise_timeout(DBusConnection *conn, uint16_t value)
+void ad_advertise_timeout(DBusConnection *conn, long int *value)
 {
-	if (ad.timeout == value)
+	if (!value) {
+		bt_shell_printf("Timeout: %u sec\n", ad.timeout);
+		return;
+	}
+
+	if (ad.timeout == *value)
 		return;
 
-	ad.timeout = value;
+	ad.timeout = *value;
 
 	g_dbus_emit_property_changed(conn, AD_PATH, AD_IFACE, "Timeout");
 }
diff --git a/client/advertising.h b/client/advertising.h
index 04fe38b1a..13e076438 100644
--- a/client/advertising.h
+++ b/client/advertising.h
@@ -33,4 +33,4 @@ void ad_advertise_appearance(DBusConnection *conn, bool value);
 void ad_advertise_local_name(DBusConnection *conn, const char *name);
 void ad_advertise_local_appearance(DBusConnection *conn, long int *value);
 void ad_advertise_duration(DBusConnection *conn, long int *value);
-void ad_advertise_timeout(DBusConnection *conn, uint16_t value);
+void ad_advertise_timeout(DBusConnection *conn, long int *value);
diff --git a/client/main.c b/client/main.c
index 80e4c82ed..85803f1a3 100644
--- a/client/main.c
+++ b/client/main.c
@@ -2289,18 +2289,23 @@ static void cmd_advertise_duration(int argc, char *argv[])
 	ad_advertise_duration(dbus_conn, &value);
 }
 
-static void cmd_set_advertise_timeout(int argc, char *argv[])
+static void cmd_advertise_timeout(int argc, char *argv[])
 {
 	long int value;
 	char *endptr = NULL;
 
+	if (argc < 2) {
+		ad_advertise_timeout(dbus_conn, NULL);
+		return;
+	}
+
 	value = strtol(argv[1], &endptr, 0);
 	if (!endptr || *endptr != '\0' || value > UINT16_MAX) {
 		bt_shell_printf("Invalid argument\n");
 		return;
 	}
 
-	ad_advertise_timeout(dbus_conn, value);
+	ad_advertise_timeout(dbus_conn, &value);
 }
 
 static const struct bt_shell_menu advertise_menu = {
@@ -2323,8 +2328,8 @@ static const struct bt_shell_menu advertise_menu = {
 			"Set custom appearance to be advertised" },
 	{ "duration", "[seconds]", cmd_advertise_duration,
 			"Set/Get advertise duration" },
-	{ "set-timeout", "<seconds>", cmd_set_advertise_timeout,
-			"Set advertise timeout" },
+	{ "timeout", "[seconds]", cmd_advertise_timeout,
+			"Set/Get advertise timeout" },
 	{ } },
 };
 
-- 
2.14.3

