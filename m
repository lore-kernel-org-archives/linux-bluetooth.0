Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 9/9] unit/test-gdbus-client: Fix memory leak on client_no_object_manager
Date: Fri, 10 Apr 2015 17:06:01 +0300
Message-Id: <1428674761-24609-9-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1428674761-24609-1-git-send-email-luiz.dentz@gmail.com>
References: <1428674761-24609-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

When creating a proxy manually with g_dbus_proxy_new it has to be freed
with g_dbus_proxy_unref otherwise it leaks:

395 (80 direct, 315 indirect) bytes in 1 blocks are definitely lost in loss record 800 of 834
   at 0x4C29BCF: malloc (in /usr/lib64/valgrind/vgpreload_memcheck-amd64-linux.so)
   by 0x4E84575: g_try_malloc0 (in /usr/lib64/libglib-2.0.so.0.4200.2)
   by 0x40E244: proxy_new (client.c:411)
   by 0x40F7FD: g_dbus_proxy_new (client.c:485)
   by 0x405844: client_no_object_manager (test-gdbus-client.c:837)
   by 0x410882: run_callback (tester.c:413)
   by 0x4E7E7FA: g_main_context_dispatch (in /usr/lib64/libglib-2.0.so.0.4200.2)
   by 0x4E7EB97: ??? (in /usr/lib64/libglib-2.0.so.0.4200.2)
   by 0x4E7EEC1: g_main_loop_run (in /usr/lib64/libglib-2.0.so.0.4200.2)
   by 0x411CF1: tester_run (tester.c:831)
   by 0x4045E1: main (test-gdbus-client.c:986)
---
 unit/test-gdbus-client.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/unit/test-gdbus-client.c b/unit/test-gdbus-client.c
index ecbe51e..5a4b974 100644
--- a/unit/test-gdbus-client.c
+++ b/unit/test-gdbus-client.c
@@ -322,6 +322,11 @@ static void proxy_get_string(GDBusProxy *proxy, void *user_data)
 	g_assert(g_dbus_proxy_get_property(proxy, "String", &iter));
 	g_assert(dbus_message_iter_get_arg_type(&iter) == DBUS_TYPE_STRING);
 
+	if (context->proxy) {
+		g_assert(context->proxy == proxy);
+		g_dbus_proxy_unref(context->proxy);
+	}
+
 	dbus_message_iter_get_basic(&iter, &string);
 	g_assert_cmpstr(string, ==, "value");
 
-- 
2.1.0

