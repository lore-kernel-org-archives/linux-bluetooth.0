Return-Path: <cyrus@holtmann.org>
From: Tomasz Bursztyka <tomasz.bursztyka@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com,
	Tomasz Bursztyka <tomasz.bursztyka@linux.intel.com>
Subject: [PATCH] gdbus: Always unreference the message in g_dbus_send_message()
Date: Fri,  8 Feb 2013 15:58:10 +0200
Message-Id: <1360331890-21983-1-git-send-email-tomasz.bursztyka@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---

Hi,

A quick fix on g_dbus_send_message(), if check_signal() fails it returns FALSE without unreferencing
the message as it should. This patch fixes it.

 gdbus/object.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/gdbus/object.c b/gdbus/object.c
index 0c11246..ba8be94 100644
--- a/gdbus/object.c
+++ b/gdbus/object.c
@@ -1496,7 +1496,7 @@ DBusMessage *g_dbus_create_reply(DBusMessage *message, int type, ...)
 
 gboolean g_dbus_send_message(DBusConnection *connection, DBusMessage *message)
 {
-	dbus_bool_t result;
+	dbus_bool_t result = FALSE;
 
 	if (dbus_message_get_type(message) == DBUS_MESSAGE_TYPE_METHOD_CALL)
 		dbus_message_set_no_reply(message, TRUE);
@@ -1507,11 +1507,12 @@ gboolean g_dbus_send_message(DBusConnection *connection, DBusMessage *message)
 		const GDBusArgInfo *args;
 
 		if (!check_signal(connection, path, interface, name, &args))
-			return FALSE;
+			goto out;
 	}
 
 	result = dbus_connection_send(connection, message, NULL);
 
+out:
 	dbus_message_unref(message);
 
 	return result;
-- 
1.8.1.2

