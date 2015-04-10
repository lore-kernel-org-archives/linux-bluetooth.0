Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 8/9] unit/test-gdbus-client: Fix memory leak
Date: Fri, 10 Apr 2015 17:06:00 +0300
Message-Id: <1428674761-24609-8-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1428674761-24609-1-git-send-email-luiz.dentz@gmail.com>
References: <1428674761-24609-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This fixes leaking DBusConnection created by client_force_disconnect
causing the following trace:

40 bytes in 1 blocks are definitely lost in loss record 501 of 839
   at 0x4C29BCF: malloc (in /usr/lib64/valgrind/vgpreload_memcheck-amd64-linux.so)
   by 0x519D9E1: ??? (in /usr/lib64/libdbus-1.so.3.8.11)
   by 0x5191F94: ??? (in /usr/lib64/libdbus-1.so.3.8.11)
   by 0x517AC1A: ??? (in /usr/lib64/libdbus-1.so.3.8.11)
   by 0x517D754: ??? (in /usr/lib64/libdbus-1.so.3.8.11)
   by 0x51790FB: ??? (in /usr/lib64/libdbus-1.so.3.8.11)
   by 0x407739: g_dbus_setup_private (mainloop.c:314)
   by 0x404ECC: client_force_disconnect (test-gdbus-client.c:879)
   by 0x4108B2: run_callback (tester.c:413)
   by 0x4E7E7FA: g_main_context_dispatch (in /usr/lib64/libglib-2.0.so.0.4200.2)
   by 0x4E7EB97: ??? (in /usr/lib64/libglib-2.0.so.0.4200.2)
   by 0x4E7EEC1: g_main_loop_run (in /usr/lib64/libglib-2.0.so.0.4200.2)
---
 unit/test-gdbus-client.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/unit/test-gdbus-client.c b/unit/test-gdbus-client.c
index 51cf8b4..ecbe51e 100644
--- a/unit/test-gdbus-client.c
+++ b/unit/test-gdbus-client.c
@@ -857,6 +857,7 @@ static void proxy_force_disconnect(GDBusProxy *proxy, void *user_data)
 
 	dbus_connection_flush(conn);
 	dbus_connection_close(conn);
+	dbus_connection_unref(conn);
 	context->data = NULL;
 }
 
-- 
2.1.0

