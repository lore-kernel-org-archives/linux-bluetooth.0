Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 4/6] gdbus: Call check_signals when sending signals with g_dbus_send_message
Date: Sun, 23 Dec 2012 17:24:56 +0200
Message-Id: <1356276298-13795-4-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1356276298-13795-1-git-send-email-luiz.dentz@gmail.com>
References: <1356276298-13795-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

If message passed to g_dbus_send_message is a signal verify if it is a
valid and there really exists an interface with respective signal name.
---
 gdbus/object.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/gdbus/object.c b/gdbus/object.c
index 510763a..6951171 100644
--- a/gdbus/object.c
+++ b/gdbus/object.c
@@ -1475,6 +1475,15 @@ gboolean g_dbus_send_message(DBusConnection *connection, DBusMessage *message)
 
 	if (dbus_message_get_type(message) == DBUS_MESSAGE_TYPE_METHOD_CALL)
 		dbus_message_set_no_reply(message, TRUE);
+	else {
+		const char *path = dbus_message_get_path(message);
+		const char *interface = dbus_message_get_interface(message);
+		const char *name = dbus_message_get_member(message);
+		const GDBusArgInfo *args;
+
+		if (!check_signal(connection, path, interface, name, &args))
+			return FALSE;
+	}
 
 	result = dbus_connection_send(connection, message, NULL);
 
-- 
1.7.11.7

