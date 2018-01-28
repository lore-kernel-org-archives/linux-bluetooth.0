Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/2] gdbus: Fix replying to messages marked with NOREPLY flag
Date: Sun, 28 Jan 2018 11:50:29 -0200
Message-Id: <20180128135030.18468-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

When a sender flags a D-Bus message as not expecting a reply, it is
against D-Bus policy to send a reply — sending one can result in an
error as reported in:

https://bugzilla.kernel.org/show_bug.cgi?id=198453
---
 gdbus/object.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/gdbus/object.c b/gdbus/object.c
index 5c8ad7a55..e572c9f01 100644
--- a/gdbus/object.c
+++ b/gdbus/object.c
@@ -1421,6 +1421,10 @@ DBusMessage *g_dbus_create_error_valist(DBusMessage *message, const char *name,
 {
 	char str[1024];
 
+	/* Check if the message can be replied */
+	if (dbus_message_get_no_reply(message))
+		return NULL;
+
 	if (format)
 		vsnprintf(str, sizeof(str), format, args);
 	else
@@ -1449,6 +1453,10 @@ DBusMessage *g_dbus_create_reply_valist(DBusMessage *message,
 {
 	DBusMessage *reply;
 
+	/* Check if the message can be replied */
+	if (dbus_message_get_no_reply(message))
+		return NULL;
+
 	reply = dbus_message_new_method_return(message);
 	if (reply == NULL)
 		return NULL;
@@ -1571,14 +1579,9 @@ gboolean g_dbus_send_reply_valist(DBusConnection *connection,
 {
 	DBusMessage *reply;
 
-	reply = dbus_message_new_method_return(message);
-	if (reply == NULL)
-		return FALSE;
-
-	if (dbus_message_append_args_valist(reply, type, args) == FALSE) {
-		dbus_message_unref(reply);
+	reply = g_dbus_create_reply_valist(message, type, args);
+	if (!reply)
 		return FALSE;
-	}
 
 	return g_dbus_send_message(connection, reply);
 }
-- 
2.14.3

