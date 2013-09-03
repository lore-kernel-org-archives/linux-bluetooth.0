Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 04/10 v3] gdbus: Add g_dbus_send_message_with_reply
Date: Tue,  3 Sep 2013 14:21:13 +0300
Message-Id: <1378207279-14557-5-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1378207279-14557-1-git-send-email-luiz.dentz@gmail.com>
References: <1378207279-14557-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

g_dbus_send_message_with_reply flushes pending signals before calling
dbus_connection_send_with_reply so it does not alter the message order
---
 gdbus/gdbus.h  |  3 +++
 gdbus/object.c | 11 +++++++++++
 2 files changed, 14 insertions(+)

diff --git a/gdbus/gdbus.h b/gdbus/gdbus.h
index 8b13393..9542109 100644
--- a/gdbus/gdbus.h
+++ b/gdbus/gdbus.h
@@ -250,6 +250,9 @@ DBusMessage *g_dbus_create_reply_valist(DBusMessage *message,
 						int type, va_list args);
 
 gboolean g_dbus_send_message(DBusConnection *connection, DBusMessage *message);
+gboolean g_dbus_send_message_with_reply(DBusConnection *connection,
+					DBusMessage *message,
+					DBusPendingCall **call, int timeout);
 gboolean g_dbus_send_error(DBusConnection *connection, DBusMessage *message,
 				const char *name, const char *format, ...)
 					 __attribute__((format(printf, 4, 5)));
diff --git a/gdbus/object.c b/gdbus/object.c
index 83fc4e6..773128c 100644
--- a/gdbus/object.c
+++ b/gdbus/object.c
@@ -1556,6 +1556,17 @@ out:
 	return result;
 }
 
+gboolean g_dbus_send_message_with_reply(DBusConnection *connection,
+					DBusMessage *message,
+					DBusPendingCall **call, int timeout)
+{
+	/* Flush pending signal to guarantee message order */
+	g_dbus_flush(connection);
+
+	return dbus_connection_send_with_reply(connection, message, call,
+								timeout);
+}
+
 gboolean g_dbus_send_error_valist(DBusConnection *connection,
 					DBusMessage *message, const char *name,
 					const char *format, va_list args)
-- 
1.8.3.1

