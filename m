Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 5/8] gdbus/watch: Fix crash when disconnecting from D-Bus
Date: Mon,  9 Sep 2013 17:49:36 +0300
Message-Id: <1378738179-21047-5-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1378738179-21047-1-git-send-email-luiz.dentz@gmail.com>
References: <1378738179-21047-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

When disconnecting from D-Bus a message could be recieved with no sender:
Invalid read of size 1
   at 0x4A09EE1: strcmp (in /usr/lib64/valgrind/vgpreload_memcheck-amd64-linux.so)
   by 0x3B03C386B8: g_str_equal (in /usr/lib64/libglib-2.0.so.0.3600.3)
   by 0x4065D6: message_filter (watch.c:529)
   by 0x3B0700F9E5: dbus_connection_dispatch (in /usr/lib64/libdbus-1.so.3.7.4)
   by 0x4052E7: message_dispatch (mainloop.c:76)
   by 0x3B03C48962: ??? (in /usr/lib64/libglib-2.0.so.0.3600.3)
   by 0x3B03C47E05: g_main_context_dispatch (in /usr/lib64/libglib-2.0.so.0.3600.3)
   by 0x3B03C48157: ??? (in /usr/lib64/libglib-2.0.so.0.3600.3)
   by 0x3B03C48559: g_main_loop_run (in /usr/lib64/libglib-2.0.so.0.3600.3)
   by 0x4038C5: client_proxy_removed (test-gdbus-client.c:902)
   by 0x3B03C6B566: ??? (in /usr/lib64/libglib-2.0.so.0.3600.3)
   by 0x3B03C6B6E5: ??? (in /usr/lib64/libglib-2.0.so.0.3600.3)
 Address 0x0 is not stack'd, malloc'd or (recently) free'd
---
 gdbus/watch.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/gdbus/watch.c b/gdbus/watch.c
index a918535..1532795 100644
--- a/gdbus/watch.c
+++ b/gdbus/watch.c
@@ -519,6 +519,8 @@ static DBusHandlerResult message_filter(DBusConnection *connection,
 	dbus_message_get_args(message, NULL, DBUS_TYPE_STRING, &arg, DBUS_TYPE_INVALID);
 
 	/* Sender is always the owner */
+	if (sender == NULL)
+		return DBUS_HANDLER_RESULT_NOT_YET_HANDLED;
 
 	for (current = listeners; current != NULL; current = current->next) {
 		data = current->data;
-- 
1.8.3.1

