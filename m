Return-Path: <cyrus@holtmann.org>
From: Gowtham Anandha Babu <gowtham.ab@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: bharat.panda@samsung.com,
	Gowtham Anandha Babu <gowtham.ab@samsung.com>
Subject: [PATCH] core/advertising: Fix memory leak on
 btd_advertising_manager_destroy
Date: Mon, 22 Jun 2015 19:21:06 +0530
Message-id: <1434981066-20836-1-git-send-email-gowtham.ab@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When creating an adv_manager using advertising_manager_create(),
it should be properly freed using advertising_manager_destroy().

==19916== 64 (32 direct, 32 indirect) bytes in 1 blocks are definitely lost in loss record 167 of 234
==19916==    at 0x4C2CC70: calloc (in /usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so)
==19916==    by 0x45B0D0: btd_advertising_manager_new (advertising.c:764)
==19916==    by 0x468DF9: read_info_complete (adapter.c:7353)
==19916==    by 0x48E3A5: request_complete (mgmt.c:242)
==19916==    by 0x48ED1C: can_read_data (mgmt.c:321)
==19916==    by 0x49A504: watch_callback (io-glib.c:170)
==19916==    by 0x4E7FCE4: g_main_context_dispatch (in /lib/x86_64-linux-gnu/libglib-2.0.so.0.4002.0)
==19916==    by 0x4E80047: g_main_context_iterate.isra.24 (in /lib/x86_64-linux-gnu/libglib-2.0.so.0.4002.0)
==19916==    by 0x4E80309: g_main_loop_run (in /lib/x86_64-linux-gnu/libglib-2.0.so.0.4002.0)
==19916==    by 0x40B2AE: main (main.c:661)
---
 src/advertising.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/src/advertising.c b/src/advertising.c
index d6ab084..421a5e9 100644
--- a/src/advertising.c
+++ b/src/advertising.c
@@ -818,4 +818,6 @@ void btd_advertising_manager_destroy(struct btd_advertising *manager)
 	g_dbus_unregister_interface(btd_get_dbus_connection(),
 					adapter_get_path(manager->adapter),
 					LE_ADVERTISING_MGR_IFACE);
+
+	advertising_manager_destroy(manager);
 }
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
