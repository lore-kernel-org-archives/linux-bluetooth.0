Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/2] Fix possible invalid read/free on manager.c
Date: Thu, 14 Jul 2011 09:28:47 +0300
Message-Id: <1310624928-17720-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

 Invalid read of size 4
    at 0x178A20: adapter_get_address (string3.h:52)
    by 0x174C28: adapter_cmp (manager.c:324)
    by 0x4EA95B0: g_slist_find_custom (in /lib64/libglib-2.0.so.0.2908.0)
    by 0x174ED9: manager_find_adapter (manager.c:333)
    by 0x16ABFA: sdp_record_remove (sdpd-database.c:270)
    by 0x16A4D6: remove_record_from_server (sdpd-service.c:286)
    by 0x12A947: avrcp_unregister (control.c:972)
    by 0x1208CC: avrcp_server_remove (manager.c:1066)
    by 0x4EA9826: g_slist_foreach (in /lib64/libglib-2.0.so.0.2908.0)
    by 0x178985: adapter_remove (adapter.c:2326)
    by 0x4EA9826: g_slist_foreach (in /lib64/libglib-2.0.so.0.2908.0)
    by 0x4EA984A: g_slist_free_full (in /lib64/libglib-2.0.so.0.2908.0)
  Address 0x603ccd0 is 16 bytes inside a block of size 448 free'd
    at 0x4A055FE: free (vg_replace_malloc.c:366)
    by 0x4E938F2: g_free (in /lib64/libglib-2.0.so.0.2908.0)
    by 0x11EB59: remove_interface (object.c:563)
    by 0x11F380: g_dbus_unregister_interface (object.c:715)
    by 0x1787EC: btd_adapter_unref (adapter.c:2496)
    by 0x4EA9826: g_slist_foreach (in /lib64/libglib-2.0.so.0.2908.0)
    by 0x4EA984A: g_slist_free_full (in /lib64/libglib-2.0.so.0.2908.0)
    by 0x174E96: manager_cleanup (manager.c:301)
    by 0x11CCE8: main (main.c:305)

 Invalid read of size 2
    at 0x178A25: adapter_get_address (string3.h:52)
    by 0x174C28: adapter_cmp (manager.c:324)
    by 0x4EA95B0: g_slist_find_custom (in /lib64/libglib-2.0.so.0.2908.0)
    by 0x174ED9: manager_find_adapter (manager.c:333)
    by 0x16ABFA: sdp_record_remove (sdpd-database.c:270)
    by 0x16A4D6: remove_record_from_server (sdpd-service.c:286)
    by 0x12A947: avrcp_unregister (control.c:972)
    by 0x1208CC: avrcp_server_remove (manager.c:1066)
    by 0x4EA9826: g_slist_foreach (in /lib64/libglib-2.0.so.0.2908.0)
    by 0x178985: adapter_remove (adapter.c:2326)
    by 0x4EA9826: g_slist_foreach (in /lib64/libglib-2.0.so.0.2908.0)
    by 0x4EA984A: g_slist_free_full (in /lib64/libglib-2.0.so.0.2908.0)
  Address 0x603ccd4 is 20 bytes inside a block of size 448 free'd
    at 0x4A055FE: free (vg_replace_malloc.c:366)
    by 0x4E938F2: g_free (in /lib64/libglib-2.0.so.0.2908.0)
    by 0x11EB59: remove_interface (object.c:563)
    by 0x11F380: g_dbus_unregister_interface (object.c:715)
    by 0x1787EC: btd_adapter_unref (adapter.c:2496)
    by 0x4EA9826: g_slist_foreach (in /lib64/libglib-2.0.so.0.2908.0)
    by 0x4EA984A: g_slist_free_full (in /lib64/libglib-2.0.so.0.2908.0)
    by 0x174E96: manager_cleanup (manager.c:301)
    by 0x11CCE8: main (main.c:305)
---
 src/adapter.c |    2 --
 src/manager.c |   16 +++++++++++++---
 2 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 0909a22..415a6b8 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -2576,8 +2576,6 @@ void adapter_remove(struct btd_adapter *adapter)
 
 	/* Return adapter to down state if it was not up on init */
 	adapter_ops->restore_powered(adapter->dev_id);
-
-	btd_adapter_unref(adapter);
 }
 
 uint16_t adapter_get_dev_id(struct btd_adapter *adapter)
diff --git a/src/manager.c b/src/manager.c
index a725588..15a1746 100644
--- a/src/manager.c
+++ b/src/manager.c
@@ -270,6 +270,14 @@ struct btd_adapter *manager_get_default_adapter(void)
 	return manager_find_adapter_by_id(default_adapter_id);
 }
 
+static void remove_adapter(void *data)
+{
+	struct btd_adapter *adapter = data;
+
+	adapter_remove(adapter);
+	btd_adapter_unref(adapter);
+}
+
 static void manager_remove_adapter(struct btd_adapter *adapter)
 {
 	uint16_t dev_id = adapter_get_dev_id(adapter);
@@ -290,7 +298,7 @@ static void manager_remove_adapter(struct btd_adapter *adapter)
 			DBUS_TYPE_OBJECT_PATH, &path,
 			DBUS_TYPE_INVALID);
 
-	adapter_remove(adapter);
+	remove_adapter(adapter);
 
 	if (adapters == NULL)
 		btd_start_exit_timer();
@@ -298,9 +306,11 @@ static void manager_remove_adapter(struct btd_adapter *adapter)
 
 void manager_cleanup(DBusConnection *conn, const char *path)
 {
-	g_slist_free_full(adapters, (GDestroyNotify) adapter_remove);
+	while (adapters) {
+		remove_adapter(adapters->data);
+		adapters = g_slist_remove(adapters, adapters->data);
+	}
 
-	adapters = NULL;
 	btd_start_exit_timer();
 
 	g_dbus_unregister_interface(conn, "/", MANAGER_INTERFACE);
-- 
1.7.6

