Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH BlueZ 1/2] gdbus: Fix segfault when D-Bus daemon exits
Date: Sat,  4 May 2013 15:39:42 -0400
Message-Id: <1367696383-14831-1-git-send-email-anderson.lizardo@openbossa.org>
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
---
 gdbus/client.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/gdbus/client.c b/gdbus/client.c
index 55f1d89..a21b66a 100644
--- a/gdbus/client.c
+++ b/gdbus/client.c
@@ -1119,6 +1119,8 @@ static DBusHandlerResult message_filter(DBusConnection *connection,
 		return DBUS_HANDLER_RESULT_NOT_YET_HANDLED;
 
 	sender = dbus_message_get_sender(message);
+	if (sender == NULL)
+		return DBUS_HANDLER_RESULT_NOT_YET_HANDLED;
 
 	if (g_str_equal(sender, DBUS_SERVICE_DBUS) == TRUE) {
 		const char *interface, *member;
-- 
1.7.9.5

