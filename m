Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 3/3] Fix possible invalid read/free on media.c
Date: Mon, 11 Jul 2011 12:10:32 +0300
Message-Id: <1310375432-18449-3-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1310375432-18449-1-git-send-email-luiz.dentz@gmail.com>
References: <1310375432-18449-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

 Invalid read of size 8
    at 0x4EA8CC2: g_slice_free_chain_with_offset (in /lib64/libglib-2.0.so.0.2908.0)
    by 0x13AF33: path_free (media.c:417)
    by 0x11EB39: remove_interface (object.c:563)
    by 0x11F360: g_dbus_unregister_interface (object.c:715)
    by 0x120C49: media_server_remove (manager.c:1098)
    by 0x4EA9826: g_slist_foreach (in /lib64/libglib-2.0.so.0.2908.0)
    by 0x178915: adapter_remove (adapter.c:2326)
    by 0x17535F: btd_manager_unregister_adapter (manager.c:293)
    by 0x154081: device_event (hciops.c:2643)
    by 0x1543C1: io_stack_event (hciops.c:2763)
    by 0x4E8C88C: g_main_context_dispatch (in /lib64/libglib-2.0.so.0.2908.0)
    by 0x4E8D087: ??? (in /lib64/libglib-2.0.so.0.2908.0)
  Address 0x63f6638 is 8 bytes inside a block of size 16 free'd
    at 0x4A055FE: free (vg_replace_malloc.c:366)
    by 0x4E938F2: g_free (in /lib64/libglib-2.0.so.0.2908.0)
    by 0x4EA854E: g_slice_free1 (in /lib64/libglib-2.0.so.0.2908.0)
    by 0x4EA930C: g_slist_remove (in /lib64/libglib-2.0.so.0.2908.0)
    by 0x13AE53: media_endpoint_remove (media.c:118)
    by 0x4EA9826: g_slist_foreach (in /lib64/libglib-2.0.so.0.2908.0)
    by 0x4EA984A: g_slist_free_full (in /lib64/libglib-2.0.so.0.2908.0)
    by 0x13AF33: path_free (media.c:417)
    by 0x11EB39: remove_interface (object.c:563)
    by 0x11F360: g_dbus_unregister_interface (object.c:715)
    by 0x120C49: media_server_remove (manager.c:1098)
    by 0x4EA9826: g_slist_foreach (in /lib64/libglib-2.0.so.0.2908.0)

 Invalid write of size 4
    at 0x4A08D20: memset (mc_replace_strmem.c:751)
    by 0x4EA8CAB: g_slice_free_chain_with_offset (in /lib64/libglib-2.0.so.0.2908.0)
    by 0x13AF33: path_free (media.c:417)
    by 0x11EB39: remove_interface (object.c:563)
    by 0x11F360: g_dbus_unregister_interface (object.c:715)
    by 0x120C49: media_server_remove (manager.c:1098)
    by 0x4EA9826: g_slist_foreach (in /lib64/libglib-2.0.so.0.2908.0)
    by 0x178915: adapter_remove (adapter.c:2326)
    by 0x17535F: btd_manager_unregister_adapter (manager.c:293)
    by 0x154081: device_event (hciops.c:2643)
    by 0x1543C1: io_stack_event (hciops.c:2763)
    by 0x4E8C88C: g_main_context_dispatch (in /lib64/libglib-2.0.so.0.2908.0)
  Address 0x63f6630 is 0 bytes inside a block of size 16 free'd
    at 0x4A055FE: free (vg_replace_malloc.c:366)
    by 0x4E938F2: g_free (in /lib64/libglib-2.0.so.0.2908.0)
    by 0x4EA854E: g_slice_free1 (in /lib64/libglib-2.0.so.0.2908.0)
    by 0x4EA930C: g_slist_remove (in /lib64/libglib-2.0.so.0.2908.0)
    by 0x13AE53: media_endpoint_remove (media.c:118)
    by 0x4EA9826: g_slist_foreach (in /lib64/libglib-2.0.so.0.2908.0)
    by 0x4EA984A: g_slist_free_full (in /lib64/libglib-2.0.so.0.2908.0)
    by 0x13AF33: path_free (media.c:417)
    by 0x11EB39: remove_interface (object.c:563)
    by 0x11F360: g_dbus_unregister_interface (object.c:715)
    by 0x120C49: media_server_remove (manager.c:1098)
    by 0x4EA9826: g_slist_foreach (in /lib64/libglib-2.0.so.0.2908.0)

 Invalid write of size 4
    at 0x4A08D2B: memset (mc_replace_strmem.c:751)
    by 0x4EA8CAB: g_slice_free_chain_with_offset (in /lib64/libglib-2.0.so.0.2908.0)
    by 0x13AF33: path_free (media.c:417)
    by 0x11EB39: remove_interface (object.c:563)
    by 0x11F360: g_dbus_unregister_interface (object.c:715)
    by 0x120C49: media_server_remove (manager.c:1098)
    by 0x4EA9826: g_slist_foreach (in /lib64/libglib-2.0.so.0.2908.0)
    by 0x178915: adapter_remove (adapter.c:2326)
    by 0x17535F: btd_manager_unregister_adapter (manager.c:293)
    by 0x154081: device_event (hciops.c:2643)
    by 0x1543C1: io_stack_event (hciops.c:2763)
    by 0x4E8C88C: g_main_context_dispatch (in /lib64/libglib-2.0.so.0.2908.0)
  Address 0x63f6638 is 8 bytes inside a block of size 16 free'd
    at 0x4A055FE: free (vg_replace_malloc.c:366)
    by 0x4E938F2: g_free (in /lib64/libglib-2.0.so.0.2908.0)
    by 0x4EA854E: g_slice_free1 (in /lib64/libglib-2.0.so.0.2908.0)
    by 0x4EA930C: g_slist_remove (in /lib64/libglib-2.0.so.0.2908.0)
    by 0x13AE53: media_endpoint_remove (media.c:118)
    by 0x4EA9826: g_slist_foreach (in /lib64/libglib-2.0.so.0.2908.0)
    by 0x4EA984A: g_slist_free_full (in /lib64/libglib-2.0.so.0.2908.0)
    by 0x13AF33: path_free (media.c:417)
    by 0x11EB39: remove_interface (object.c:563)
    by 0x11F360: g_dbus_unregister_interface (object.c:715)
    by 0x120C49: media_server_remove (manager.c:1098)
    by 0x4EA9826: g_slist_foreach (in /lib64/libglib-2.0.so.0.2908.0)

 Invalid free() / delete / delete[]
    at 0x4A055FE: free (vg_replace_malloc.c:366)
    by 0x4E938F2: g_free (in /lib64/libglib-2.0.so.0.2908.0)
    by 0x4EA8CB3: g_slice_free_chain_with_offset (in /lib64/libglib-2.0.so.0.2908.0)
    by 0x13AF33: path_free (media.c:417)
    by 0x11EB39: remove_interface (object.c:563)
    by 0x11F360: g_dbus_unregister_interface (object.c:715)
    by 0x120C49: media_server_remove (manager.c:1098)
    by 0x4EA9826: g_slist_foreach (in /lib64/libglib-2.0.so.0.2908.0)
    by 0x178915: adapter_remove (adapter.c:2326)
    by 0x17535F: btd_manager_unregister_adapter (manager.c:293)
    by 0x154081: device_event (hciops.c:2643)
    by 0x1543C1: io_stack_event (hciops.c:2763)
  Address 0x63f6630 is 0 bytes inside a block of size 16 free'd
    at 0x4A055FE: free (vg_replace_malloc.c:366)
    by 0x4E938F2: g_free (in /lib64/libglib-2.0.so.0.2908.0)
    by 0x4EA854E: g_slice_free1 (in /lib64/libglib-2.0.so.0.2908.0)
    by 0x4EA930C: g_slist_remove (in /lib64/libglib-2.0.so.0.2908.0)
    by 0x13AE53: media_endpoint_remove (media.c:118)
    by 0x4EA9826: g_slist_foreach (in /lib64/libglib-2.0.so.0.2908.0)
    by 0x4EA984A: g_slist_free_full (in /lib64/libglib-2.0.so.0.2908.0)
    by 0x13AF33: path_free (media.c:417)
    by 0x11EB39: remove_interface (object.c:563)
    by 0x11F360: g_dbus_unregister_interface (object.c:715)
    by 0x120C49: media_server_remove (manager.c:1098)
    by 0x4EA9826: g_slist_foreach (in /lib64/libglib-2.0.so.0.2908.0)
---
 audio/media.c |   34 ++++++++++++++++++++++++----------
 1 files changed, 24 insertions(+), 10 deletions(-)

diff --git a/audio/media.c b/audio/media.c
index 57bf7c9..7f93dfe 100644
--- a/audio/media.c
+++ b/audio/media.c
@@ -105,17 +105,11 @@ static void media_endpoint_cancel(struct media_endpoint *endpoint)
 	endpoint->request = NULL;
 }
 
-static void media_endpoint_remove(struct media_endpoint *endpoint)
+static void media_endpoint_destroy(struct media_endpoint *endpoint)
 {
 	struct media_adapter *adapter = endpoint->adapter;
 
-	if (g_slist_find(adapter->endpoints, endpoint) == NULL)
-		return;
-
-	info("Endpoint unregistered: sender=%s path=%s", endpoint->sender,
-			endpoint->path);
-
-	adapter->endpoints = g_slist_remove(adapter->endpoints, endpoint);
+	DBG("sender=%s path=%s", endpoint->sender, endpoint->path);
 
 	if (endpoint->sep)
 		a2dp_remove_sep(endpoint->sep);
@@ -137,6 +131,23 @@ static void media_endpoint_remove(struct media_endpoint *endpoint)
 	g_free(endpoint);
 }
 
+static void media_endpoint_remove(struct media_endpoint *endpoint)
+{
+	struct media_adapter *adapter = endpoint->adapter;
+
+	if (g_slist_find(adapter->endpoints, endpoint) == NULL) {
+		media_endpoint_destroy(endpoint);
+		return;
+	}
+
+	info("Endpoint unregistered: sender=%s path=%s", endpoint->sender,
+			endpoint->path);
+
+	adapter->endpoints = g_slist_remove(adapter->endpoints, endpoint);
+
+	media_endpoint_destroy(endpoint);
+}
+
 static void media_endpoint_exit(DBusConnection *connection, void *user_data)
 {
 	struct media_endpoint *endpoint = user_data;
@@ -413,9 +424,12 @@ static GDBusMethodTable media_methods[] = {
 static void path_free(void *data)
 {
 	struct media_adapter *adapter = data;
+	GSList *endpoints;
+
+	endpoints = adapter->endpoints;
+	adapter->endpoints = NULL;
 
-	g_slist_free_full(adapter->endpoints,
-				(GDestroyNotify) media_endpoint_release);
+	g_slist_free_full(endpoints, (GDestroyNotify) media_endpoint_release);
 
 	dbus_connection_unref(adapter->conn);
 
-- 
1.7.6

