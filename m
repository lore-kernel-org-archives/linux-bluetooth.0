Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 05/11] gdbus: Call check_signals when sending signals with g_dbus_send_message
Date: Fri, 28 Dec 2012 14:51:03 +0200
Message-Id: <1356699069-5469-6-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1356699069-5469-1-git-send-email-luiz.dentz@gmail.com>
References: <1356699069-5469-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

If message passed to g_dbus_send_message is a signal verify if it is a
valid and there really exists an interface with respective signal name.
---
 gdbus/object.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/gdbus/object.c b/gdbus/object.c
index c9cf595..d5eb267 100644
--- a/gdbus/object.c
+++ b/gdbus/object.c
@@ -1511,6 +1511,15 @@ gboolean g_dbus_send_message(DBusConnection *connection, DBusMessage *message)
 
 	if (dbus_message_get_type(message) == DBUS_MESSAGE_TYPE_METHOD_CALL)
 		dbus_message_set_no_reply(message, TRUE);
+	else if (dbus_message_get_type(message) == DBUS_MESSAGE_TYPE_SIGNAL) {
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
1.8.0.1

