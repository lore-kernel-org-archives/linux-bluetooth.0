Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] Fix possible invalid read/free when using g_slist_free_full
Date: Fri,  1 Jul 2011 12:44:13 +0300
Message-Id: <1309513453-25423-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This is probably a glib bug on g_slist_free_full which doesn't handle the
case where the list is modified inside the callback:

 Invalid read of size 8
    at 0x50AD5B2: g_slice_free_chain_with_offset (in /usr/lib64/libglib-2.0.so.0.2800.8)
    by 0x13057B: a2dp_unregister (a2dp.c:1550)
    by 0x12144C: a2dp_server_remove (manager.c:1032)
    by 0x50ADF16: g_slist_foreach (in /usr/lib64/libglib-2.0.so.0.2800.8)
    by 0x178B55: adapter_remove (adapter.c:2326)
    by 0x175205: manager_remove_adapter (manager.c:290)
    by 0x50ADF16: g_slist_foreach (in /usr/lib64/libglib-2.0.so.0.2800.8)
    by 0x50ADF3A: g_slist_free_full (in /usr/lib64/libglib-2.0.so.0.2800.8)
    by 0x175086: manager_cleanup (manager.c:298)
    by 0x11D7A8: main (main.c:305)
  Address 0x637a5e8 is 8 bytes inside a block of size 16 free'd
    at 0x4C27D6E: free (vg_replace_malloc.c:366)
    by 0x50AD9FC: g_slist_remove (in /usr/lib64/libglib-2.0.so.0.2800.8)
    by 0x12E5C6: a2dp_remove_sep (a2dp.c:1667)
    by 0x50ADF16: g_slist_foreach (in /usr/lib64/libglib-2.0.so.0.2800.8)
    by 0x50ADF3A: g_slist_free_full (in /usr/lib64/libglib-2.0.so.0.2800.8)
    by 0x13057B: a2dp_unregister (a2dp.c:1550)
    by 0x12144C: a2dp_server_remove (manager.c:1032)
    by 0x50ADF16: g_slist_foreach (in /usr/lib64/libglib-2.0.so.0.2800.8)
    by 0x178B55: adapter_remove (adapter.c:2326)
    by 0x175205: manager_remove_adapter (manager.c:290)
    by 0x50ADF16: g_slist_foreach (in /usr/lib64/libglib-2.0.so.0.2800.8)
    by 0x50ADF3A: g_slist_free_full (in /usr/lib64/libglib-2.0.so.0.2800.8)

 Invalid free() / delete / delete[]
    at 0x4C27D6E: free (vg_replace_malloc.c:366)
    by 0x50AD5A3: g_slice_free_chain_with_offset (in /usr/lib64/libglib-2.0.so.0.2800.8)
    by 0x13057B: a2dp_unregister (a2dp.c:1550)
    by 0x12144C: a2dp_server_remove (manager.c:1032)
    by 0x50ADF16: g_slist_foreach (in /usr/lib64/libglib-2.0.so.0.2800.8)
    by 0x178B55: adapter_remove (adapter.c:2326)
    by 0x175205: manager_remove_adapter (manager.c:290)
    by 0x50ADF16: g_slist_foreach (in /usr/lib64/libglib-2.0.so.0.2800.8)
    by 0x50ADF3A: g_slist_free_full (in /usr/lib64/libglib-2.0.so.0.2800.8)
    by 0x175086: manager_cleanup (manager.c:298)
    by 0x11D7A8: main (main.c:305)
  Address 0x637a5e0 is 0 bytes inside a block of size 16 free'd
    at 0x4C27D6E: free (vg_replace_malloc.c:366)
    by 0x50AD9FC: g_slist_remove (in /usr/lib64/libglib-2.0.so.0.2800.8)
    by 0x12E5C6: a2dp_remove_sep (a2dp.c:1667)
    by 0x50ADF16: g_slist_foreach (in /usr/lib64/libglib-2.0.so.0.2800.8)
    by 0x50ADF3A: g_slist_free_full (in /usr/lib64/libglib-2.0.so.0.2800.8)
    by 0x13057B: a2dp_unregister (a2dp.c:1550)
    by 0x12144C: a2dp_server_remove (manager.c:1032)
    by 0x50ADF16: g_slist_foreach (in /usr/lib64/libglib-2.0.so.0.2800.8)
    by 0x178B55: adapter_remove (adapter.c:2326)
    by 0x175205: manager_remove_adapter (manager.c:290)
    by 0x50ADF16: g_slist_foreach (in /usr/lib64/libglib-2.0.so.0.2800.8)
    by 0x50ADF3A: g_slist_free_full (in /usr/lib64/libglib-2.0.so.0.2800.8)

Invalid read of size 8
    at 0x50AD5B2: g_slice_free_chain_with_offset (in /usr/lib64/libglib-2.0.so.0.2800.8)
    by 0x175086: manager_cleanup (manager.c:298)
    by 0x11D7A8: main (main.c:305)
  Address 0x62b7ea8 is 8 bytes inside a block of size 16 free'd
    at 0x4C27D6E: free (vg_replace_malloc.c:366)
    by 0x50AD9FC: g_slist_remove (in /usr/lib64/libglib-2.0.so.0.2800.8)
    by 0x1751AE: manager_remove_adapter (manager.c:275)
    by 0x50ADF16: g_slist_foreach (in /usr/lib64/libglib-2.0.so.0.2800.8)
    by 0x50ADF3A: g_slist_free_full (in /usr/lib64/libglib-2.0.so.0.2800.8)
    by 0x175086: manager_cleanup (manager.c:298)
    by 0x11D7A8: main (main.c:305)

 Invalid free() / delete / delete[]
    at 0x4C27D6E: free (vg_replace_malloc.c:366)
    by 0x50AD5A3: g_slice_free_chain_with_offset (in /usr/lib64/libglib-2.0.so.0.2800.8)
    by 0x175086: manager_cleanup (manager.c:298)
    by 0x11D7A8: main (main.c:305)
  Address 0x62b7ea0 is 0 bytes inside a block of size 16 free'd
    at 0x4C27D6E: free (vg_replace_malloc.c:366)
    by 0x50AD9FC: g_slist_remove (in /usr/lib64/libglib-2.0.so.0.2800.8)
    by 0x1751AE: manager_remove_adapter (manager.c:275)
    by 0x50ADF16: g_slist_foreach (in /usr/lib64/libglib-2.0.so.0.2800.8)
    by 0x50ADF3A: g_slist_free_full (in /usr/lib64/libglib-2.0.so.0.2800.8)
    by 0x175086: manager_cleanup (manager.c:298)
    by 0x11D7A8: main (main.c:305)

To fix this now adapter_remove and a2dp_unregister_sep are passed
directly as a callbacks so g_slist_remove is not triggered.
---
 audio/a2dp.c  |   12 ++++++++++--
 src/manager.c |    5 ++++-
 2 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/audio/a2dp.c b/audio/a2dp.c
index 01a378c..aa5f865 100644
--- a/audio/a2dp.c
+++ b/audio/a2dp.c
@@ -1599,12 +1599,20 @@ void a2dp_unregister(const bdaddr_t *src)
 	if (!server)
 		return;
 
-	g_slist_free_full(server->sinks, (GDestroyNotify) a2dp_remove_sep);
-	g_slist_free_full(server->sources, (GDestroyNotify) a2dp_remove_sep);
+	g_slist_free_full(server->sinks, (GDestroyNotify) a2dp_unregister_sep);
+	g_slist_free_full(server->sources,
+					(GDestroyNotify) a2dp_unregister_sep);
 
 	avdtp_exit(src);
 
 	servers = g_slist_remove(servers, server);
+
+	if (server->source_record_id)
+		remove_record_from_server(server->source_record_id);
+
+	if (server->sink_record_id)
+		remove_record_from_server(server->sink_record_id);
+
 	g_free(server);
 
 	if (servers)
diff --git a/src/manager.c b/src/manager.c
index dd8cb50..f737ded 100644
--- a/src/manager.c
+++ b/src/manager.c
@@ -295,7 +295,10 @@ static void manager_remove_adapter(struct btd_adapter *adapter)
 
 void manager_cleanup(DBusConnection *conn, const char *path)
 {
-	g_slist_free_full(adapters, (GDestroyNotify) manager_remove_adapter);
+	g_slist_free_full(adapters, (GDestroyNotify) adapter_remove);
+
+	adapters = NULL;
+	btd_start_exit_timer();
 
 	g_dbus_unregister_interface(conn, "/", MANAGER_INTERFACE);
 }
-- 
1.7.5.4

