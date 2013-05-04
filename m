Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH BlueZ] gdbus: Fix segfault when D-Bus daemon exits
Date: Sat,  4 May 2013 14:36:41 -0400
Message-Id: <1367692601-3578-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Fix this crash if D-Bus exits while the client is still connected to it:

==5570== Invalid read of size 1
==5570==    at 0x402D28E: strcmp (in
/usr/lib/valgrind/vgpreload_memcheck-x86-linux.so)
==5570==    by 0x4070E22: g_str_equal (ghash.c:1704)
==5570==    by 0x8055F61: message_filter (client.c:1123)
==5570==    by 0x4141500: dbus_connection_dispatch (in
/lib/i386-linux-gnu/libdbus-1.so.3.5.8)
==5570==    by 0x80506F7: message_dispatch (mainloop.c:76)
==5570==    by 0x4081A7E: g_timeout_dispatch (gmain.c:3882)
==5570==    by 0x4080D85: g_main_context_dispatch (gmain.c:2539)
==5570==    by 0x4081124: g_main_context_iterate.isra.21 (gmain.c:3146)
==5570==    by 0x408156A: g_main_loop_run (gmain.c:3340)
==5570==    by 0x41BF4D2: (below main) (libc-start.c:226)
==5570==  Address 0x0 is not stack'd, malloc'd or (recently) free'd
==5570==
==5570==

Also make sure that dbus_pending_call_set_notify() and
dbus_pending_call_unref() are not called on a NULL DBusPendingCall. From
D-Bus documentation for dbus_connection_send_with_reply():

"Warning: if the connection is disconnected or you try to send Unix file
descriptors on a connection that does not support them, the
DBusPendingCall will be set to NULL, so be careful with this."
---
 gdbus/client.c |    9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/gdbus/client.c b/gdbus/client.c
index 55f1d89..b5e2ebc 100644
--- a/gdbus/client.c
+++ b/gdbus/client.c
@@ -105,8 +105,11 @@ static gboolean modify_match(DBusConnection *conn, const char *member,
 		return FALSE;
 	}
 
-	dbus_pending_call_set_notify(call, modify_match_reply, NULL, NULL);
-	dbus_pending_call_unref(call);
+	if (call != NULL) {
+		dbus_pending_call_set_notify(call, modify_match_reply, NULL,
+									NULL);
+		dbus_pending_call_unref(call);
+	}
 
 	dbus_message_unref(msg);
 
@@ -1119,6 +1122,8 @@ static DBusHandlerResult message_filter(DBusConnection *connection,
 		return DBUS_HANDLER_RESULT_NOT_YET_HANDLED;
 
 	sender = dbus_message_get_sender(message);
+	if (sender == NULL)
+		return DBUS_HANDLER_RESULT_NOT_YET_HANDLED;
 
 	if (g_str_equal(sender, DBUS_SERVICE_DBUS) == TRUE) {
 		const char *interface, *member;
-- 
1.7.9.5

