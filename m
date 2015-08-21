Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/3] unit/test-gdbus-client: Fix memory leak
Date: Fri, 21 Aug 2015 17:01:42 +0300
Message-Id: <1440165704-6885-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

The following memory leak is causes if not all interfaces are freed
once closing the connecting:

7,738 (232 direct, 7,506 indirect) bytes in 1 blocks are definitely lost in loss record 302 of 302
       at 0x4C2A9C7: calloc (in /usr/lib64/valgrind/vgpreload_memcheck-amd64-linux.so)
       by 0x519517F: ??? (in /usr/lib64/libdbus-1.so.3.8.13)
       by 0x519EF8E: ??? (in /usr/lib64/libdbus-1.so.3.8.13)
       by 0x519F462: ??? (in /usr/lib64/libdbus-1.so.3.8.13)
       by 0x5193419: ??? (in /usr/lib64/libdbus-1.so.3.8.13)
       by 0x517E6AE: ??? (in /usr/lib64/libdbus-1.so.3.8.13)
       by 0x517A06B: ??? (in /usr/lib64/libdbus-1.so.3.8.13)
       by 0x4076B9: g_dbus_setup_private (mainloop.c:314)
       by 0x404B8C: client_force_disconnect (test-gdbus-client.c:882)
       by 0x410B52: run_callback (tester.c:417)
       by 0x4E7EA89: g_main_context_dispatch (in /usr/lib64/libglib-2.0.so.0.4400.1)
       by 0x4E7EE1F: ??? (in /usr/lib64/libglib-2.0.so.0.4400.1)
---
 unit/test-gdbus-client.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/unit/test-gdbus-client.c b/unit/test-gdbus-client.c
index b25289f..dd17c00 100644
--- a/unit/test-gdbus-client.c
+++ b/unit/test-gdbus-client.c
@@ -861,6 +861,10 @@ static void proxy_force_disconnect(GDBusProxy *proxy, void *user_data)
 	context->timeout_source = g_timeout_add_seconds(2, timeout_test,
 								context);
 
+	g_dbus_detach_object_manager(conn);
+
+	g_dbus_unregister_interface(conn, SERVICE_PATH, SERVICE_NAME1);
+
 	dbus_connection_flush(conn);
 	dbus_connection_close(conn);
 	dbus_connection_unref(conn);
-- 
2.4.3

