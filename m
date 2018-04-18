Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/3] client: Add missing newline character to shell printfs
Date: Wed, 18 Apr 2018 10:37:10 +0200
Message-Id: <20180418083712.30846-1-grzegorz.kolodziejczyk@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds missing newline characters to shell printfs. It fixes
printig issues.
---
 client/gatt.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/client/gatt.c b/client/gatt.c
index 7103c4f83..52a999dc9 100644
--- a/client/gatt.c
+++ b/client/gatt.c
@@ -627,7 +627,8 @@ static void write_attribute(GDBusProxy *proxy, char *arg)
 		bt_shell_printf("Attempting to write fd %d\n",
 						io_get_fd(write_io.io));
 		if (io_send(write_io.io, &iov, 1) < 0) {
-			bt_shell_printf("Failed to write: %s", strerror(errno));
+			bt_shell_printf("Failed to write: %s\n",
+							strerror(errno));
 			return bt_shell_noninteractive_quit(EXIT_FAILURE);
 		}
 		return;
@@ -1622,7 +1623,7 @@ static void authorize_write_response(const char *input, void *user_data)
 		goto error;
 	}
 
-	bt_shell_printf("[" COLORED_CHG "] Attribute %s written" , chrc->path);
+	bt_shell_printf("[" COLORED_CHG "] Attribute %s written\n", chrc->path);
 
 	g_dbus_emit_property_changed(aad->conn, chrc->path, CHRC_INTERFACE,
 								"Value");
@@ -1671,7 +1672,7 @@ static DBusMessage *chrc_write_value(DBusConnection *conn, DBusMessage *msg,
 					"org.bluez.Error.InvalidArguments",
 					NULL);
 
-	bt_shell_printf("[" COLORED_CHG "] Attribute %s written" , chrc->path);
+	bt_shell_printf("[" COLORED_CHG "] Attribute %s written\n", chrc->path);
 
 	g_dbus_emit_property_changed(conn, chrc->path, CHRC_INTERFACE, "Value");
 
@@ -1789,8 +1790,8 @@ static DBusMessage *chrc_start_notify(DBusConnection *conn, DBusMessage *msg,
 		return g_dbus_create_reply(msg, DBUS_TYPE_INVALID);
 
 	chrc->notifying = true;
-	bt_shell_printf("[" COLORED_CHG "] Attribute %s notifications enabled",
-							chrc->path);
+	bt_shell_printf("[" COLORED_CHG "] Attribute %s notifications "
+						"enabled\n", chrc->path);
 	g_dbus_emit_property_changed(conn, chrc->path, CHRC_INTERFACE,
 							"Notifying");
 
@@ -1806,8 +1807,8 @@ static DBusMessage *chrc_stop_notify(DBusConnection *conn, DBusMessage *msg,
 		return g_dbus_create_reply(msg, DBUS_TYPE_INVALID);
 
 	chrc->notifying = false;
-	bt_shell_printf("[" COLORED_CHG "] Attribute %s notifications disabled",
-							chrc->path);
+	bt_shell_printf("[" COLORED_CHG "] Attribute %s notifications "
+						"disabled\n", chrc->path);
 	g_dbus_emit_property_changed(conn, chrc->path, CHRC_INTERFACE,
 							"Notifying");
 
@@ -1819,7 +1820,8 @@ static DBusMessage *chrc_confirm(DBusConnection *conn, DBusMessage *msg,
 {
 	struct chrc *chrc = user_data;
 
-	bt_shell_printf("Attribute %s indication confirm received", chrc->path);
+	bt_shell_printf("Attribute %s indication confirm received\n",
+								chrc->path);
 
 	return dbus_message_new_method_return(msg);
 }
@@ -2012,7 +2014,7 @@ static DBusMessage *desc_write_value(DBusConnection *conn, DBusMessage *msg,
 	bt_shell_printf("WriteValue: %s offset %u link %s\n",
 			path_to_address(device), offset, link);
 
-	bt_shell_printf("[" COLORED_CHG "] Attribute %s written" , desc->path);
+	bt_shell_printf("[" COLORED_CHG "] Attribute %s written\n" , desc->path);
 
 	g_dbus_emit_property_changed(conn, desc->path, CHRC_INTERFACE, "Value");
 
-- 
2.13.6

