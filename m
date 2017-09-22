Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Subject: [PATCH BlueZ 1/6] client: Fix memory leak of advertise command
From: ERAMOTO Masaya <eramoto.masaya@jp.fujitsu.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
References: <d5f5eeb2-9207-ae2e-231e-0826307926a9@jp.fujitsu.com>
Message-ID: <f2a81dba-ee78-9658-7add-47712c7d79ad@jp.fujitsu.com>
Date: Fri, 22 Sep 2017 21:19:00 +0900
MIME-Version: 1.0
In-Reply-To: <d5f5eeb2-9207-ae2e-231e-0826307926a9@jp.fujitsu.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Since advertise command does not free type when repeating to enable and
disable advertising, the following memory leak occurs.

  11 bytes in 1 blocks are definitely lost in loss record 20 of 190
     at 0x4C2DB8F: malloc (in /usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so)
     by 0x4E89718: g_malloc (in /lib/x86_64-linux-gnu/libglib-2.0.so.0.4800.2)
     by 0x4EA24EE: g_strdup (in /lib/x86_64-linux-gnu/libglib-2.0.so.0.4800.2)
     by 0x40EBC8: ad_register (advertising.c:343)
     by 0x40A666: cmd_advertise (main.c:2344)
     by 0x40ABA3: rl_handler (main.c:2664)
     by 0x53C16F4: rl_callback_read_char (in /lib/x86_64-linux-gnu/libreadline.so.6.3)
     by 0x405AFC: input_handler (main.c:110)
     by 0x4E84049: g_main_context_dispatch (in /lib/x86_64-linux-gnu/libglib-2.0.so.0.4800.2)
     by 0x4E843EF: ??? (in /lib/x86_64-linux-gnu/libglib-2.0.so.0.4800.2)
     by 0x4E84711: g_main_loop_run (in /lib/x86_64-linux-gnu/libglib-2.0.so.0.4800.2)
     by 0x4055FE: main (main.c:2865)
---
 client/advertising.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/client/advertising.c b/client/advertising.c
index 72c4ccb..b105da9 100644
--- a/client/advertising.c
+++ b/client/advertising.c
@@ -340,6 +340,7 @@ void ad_register(DBusConnection *conn, GDBusProxy *manager, const char *type)
 		return;
 	}
 
+	g_free(ad.type);
 	ad.type = g_strdup(type);
 
 	if (g_dbus_register_interface(conn, AD_PATH, AD_IFACE, ad_methods,
@@ -391,6 +392,9 @@ void ad_unregister(DBusConnection *conn, GDBusProxy *manager)
 	if (!ad.registered)
 		return;
 
+	g_free(ad.type);
+	ad.type = NULL;
+
 	if (g_dbus_proxy_method_call(manager, "UnregisterAdvertisement",
 					unregister_setup, unregister_reply,
 					conn, NULL) == FALSE) {
-- 
2.7.4


