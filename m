Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/3] Fix possible invalid read/free on manager.c
Date: Mon, 11 Jul 2011 12:10:30 +0300
Message-Id: <1310375432-18449-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

==6091== Invalid read of size 4
==6091==    at 0x178A20: adapter_get_address (string3.h:52)
==6091==    by 0x174C28: adapter_cmp (manager.c:324)
==6091==    by 0x4EA95B0: g_slist_find_custom (in /lib64/libglib-2.0.so.0.2908.0)
==6091==    by 0x174ED9: manager_find_adapter (manager.c:333)
==6091==    by 0x16ABFA: sdp_record_remove (sdpd-database.c:270)
==6091==    by 0x16A4D6: remove_record_from_server (sdpd-service.c:286)
==6091==    by 0x12A947: avrcp_unregister (control.c:972)
==6091==    by 0x1208CC: avrcp_server_remove (manager.c:1066)
==6091==    by 0x4EA9826: g_slist_foreach (in /lib64/libglib-2.0.so.0.2908.0)
==6091==    by 0x178985: adapter_remove (adapter.c:2326)
==6091==    by 0x4EA9826: g_slist_foreach (in /lib64/libglib-2.0.so.0.2908.0)
==6091==    by 0x4EA984A: g_slist_free_full (in /lib64/libglib-2.0.so.0.2908.0)
==6091==  Address 0x603ccd0 is 16 bytes inside a block of size 448 free'd
==6091==    at 0x4A055FE: free (vg_replace_malloc.c:366)
==6091==    by 0x4E938F2: g_free (in /lib64/libglib-2.0.so.0.2908.0)
==6091==    by 0x11EB59: remove_interface (object.c:563)
==6091==    by 0x11F380: g_dbus_unregister_interface (object.c:715)
==6091==    by 0x1787EC: btd_adapter_unref (adapter.c:2496)
==6091==    by 0x4EA9826: g_slist_foreach (in /lib64/libglib-2.0.so.0.2908.0)
==6091==    by 0x4EA984A: g_slist_free_full (in /lib64/libglib-2.0.so.0.2908.0)
==6091==    by 0x174E96: manager_cleanup (manager.c:301)
==6091==    by 0x11CCE8: main (main.c:305)
==6091==
==6091== Invalid read of size 2
==6091==    at 0x178A25: adapter_get_address (string3.h:52)
==6091==    by 0x174C28: adapter_cmp (manager.c:324)
==6091==    by 0x4EA95B0: g_slist_find_custom (in /lib64/libglib-2.0.so.0.2908.0)
==6091==    by 0x174ED9: manager_find_adapter (manager.c:333)
==6091==    by 0x16ABFA: sdp_record_remove (sdpd-database.c:270)
==6091==    by 0x16A4D6: remove_record_from_server (sdpd-service.c:286)
==6091==    by 0x12A947: avrcp_unregister (control.c:972)
==6091==    by 0x1208CC: avrcp_server_remove (manager.c:1066)
==6091==    by 0x4EA9826: g_slist_foreach (in /lib64/libglib-2.0.so.0.2908.0)
==6091==    by 0x178985: adapter_remove (adapter.c:2326)
==6091==    by 0x4EA9826: g_slist_foreach (in /lib64/libglib-2.0.so.0.2908.0)
==6091==    by 0x4EA984A: g_slist_free_full (in /lib64/libglib-2.0.so.0.2908.0)
==6091==  Address 0x603ccd4 is 20 bytes inside a block of size 448 free'd
==6091==    at 0x4A055FE: free (vg_replace_malloc.c:366)
==6091==    by 0x4E938F2: g_free (in /lib64/libglib-2.0.so.0.2908.0)
==6091==    by 0x11EB59: remove_interface (object.c:563)
==6091==    by 0x11F380: g_dbus_unregister_interface (object.c:715)
==6091==    by 0x1787EC: btd_adapter_unref (adapter.c:2496)
==6091==    by 0x4EA9826: g_slist_foreach (in /lib64/libglib-2.0.so.0.2908.0)
==6091==    by 0x4EA984A: g_slist_free_full (in /lib64/libglib-2.0.so.0.2908.0)
==6091==    by 0x174E96: manager_cleanup (manager.c:301)
==6091==    by 0x11CCE8: main (main.c:305)
---
 src/manager.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/src/manager.c b/src/manager.c
index a725588..8dde48c 100644
--- a/src/manager.c
+++ b/src/manager.c
@@ -298,9 +298,11 @@ static void manager_remove_adapter(struct btd_adapter *adapter)
 
 void manager_cleanup(DBusConnection *conn, const char *path)
 {
-	g_slist_free_full(adapters, (GDestroyNotify) adapter_remove);
+	GSList *l = adapters;
 
 	adapters = NULL;
+	g_slist_free_full(l, (GDestroyNotify) adapter_remove);
+
 	btd_start_exit_timer();
 
 	g_dbus_unregister_interface(conn, "/", MANAGER_INTERFACE);
-- 
1.7.6

