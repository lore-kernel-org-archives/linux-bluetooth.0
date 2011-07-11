Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/3] Fix possible invalid read/free on a2dp.c
Date: Mon, 11 Jul 2011 12:10:31 +0300
Message-Id: <1310375432-18449-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1310375432-18449-1-git-send-email-luiz.dentz@gmail.com>
References: <1310375432-18449-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

 Invalid read of size 8
    at 0x4EA8CC2: g_slice_free_chain_with_offset (in /lib64/libglib-2.0.so.0.2908.0)
    by 0x13AEE3: path_free (media.c:412)
    by 0x11EAF9: remove_interface (object.c:563)
    by 0x11F320: g_dbus_unregister_interface (object.c:715)
    by 0x120C09: media_server_remove (manager.c:1098)
    by 0x4EA9826: g_slist_foreach (in /lib64/libglib-2.0.so.0.2908.0)
    by 0x178845: adapter_remove (adapter.c:2326)
    by 0x17528F: btd_manager_unregister_adapter (manager.c:293)
    by 0x153FE1: device_event (hciops.c:2643)
    by 0x154321: io_stack_event (hciops.c:2763)
    by 0x4E8C88C: g_main_context_dispatch (in /lib64/libglib-2.0.so.0.2908.0)
    by 0x4E8D087: ??? (in /lib64/libglib-2.0.so.0.2908.0)
  Address 0x637fe18 is 8 bytes inside a block of size 16 free'd
    at 0x4A055FE: free (vg_replace_malloc.c:366)
    by 0x4E938F2: g_free (in /lib64/libglib-2.0.so.0.2908.0)
    by 0x4EA854E: g_slice_free1 (in /lib64/libglib-2.0.so.0.2908.0)
    by 0x4EA930C: g_slist_remove (in /lib64/libglib-2.0.so.0.2908.0)
    by 0x13AE03: media_endpoint_remove (media.c:118)
    by 0x4EA9826: g_slist_foreach (in /lib64/libglib-2.0.so.0.2908.0)
    by 0x4EA984A: g_slist_free_full (in /lib64/libglib-2.0.so.0.2908.0)
    by 0x13AEE3: path_free (media.c:412)
    by 0x11EAF9: remove_interface (object.c:563)
    by 0x11F320: g_dbus_unregister_interface (object.c:715)
    by 0x120C09: media_server_remove (manager.c:1098)
    by 0x4EA9826: g_slist_foreach (in /lib64/libglib-2.0.so.0.2908.0)

 Invalid write of size 4
    at 0x4A08D20: memset (mc_replace_strmem.c:751)
    by 0x4EA8CAB: g_slice_free_chain_with_offset (in /lib64/libglib-2.0.so.0.2908.0)
    by 0x13AEE3: path_free (media.c:412)
    by 0x11EAF9: remove_interface (object.c:563)
    by 0x11F320: g_dbus_unregister_interface (object.c:715)
    by 0x120C09: media_server_remove (manager.c:1098)
    by 0x4EA9826: g_slist_foreach (in /lib64/libglib-2.0.so.0.2908.0)
    by 0x178845: adapter_remove (adapter.c:2326)
    by 0x17528F: btd_manager_unregister_adapter (manager.c:293)
    by 0x153FE1: device_event (hciops.c:2643)
    by 0x154321: io_stack_event (hciops.c:2763)
    by 0x4E8C88C: g_main_context_dispatch (in /lib64/libglib-2.0.so.0.2908.0)
  Address 0x637fe10 is 0 bytes inside a block of size 16 free'd
    at 0x4A055FE: free (vg_replace_malloc.c:366)
    by 0x4E938F2: g_free (in /lib64/libglib-2.0.so.0.2908.0)
    by 0x4EA854E: g_slice_free1 (in /lib64/libglib-2.0.so.0.2908.0)
    by 0x4EA930C: g_slist_remove (in /lib64/libglib-2.0.so.0.2908.0)
    by 0x13AE03: media_endpoint_remove (media.c:118)
    by 0x4EA9826: g_slist_foreach (in /lib64/libglib-2.0.so.0.2908.0)
    by 0x4EA984A: g_slist_free_full (in /lib64/libglib-2.0.so.0.2908.0)
    by 0x13AEE3: path_free (media.c:412)
    by 0x11EAF9: remove_interface (object.c:563)
    by 0x11F320: g_dbus_unregister_interface (object.c:715)
    by 0x120C09: media_server_remove (manager.c:1098)
    by 0x4EA9826: g_slist_foreach (in /lib64/libglib-2.0.so.0.2908.0)

 Invalid write of size 4
    at 0x4A08D2B: memset (mc_replace_strmem.c:751)
    by 0x4EA8CAB: g_slice_free_chain_with_offset (in /lib64/libglib-2.0.so.0.2908.0)
    by 0x13AEE3: path_free (media.c:412)
    by 0x11EAF9: remove_interface (object.c:563)
    by 0x11F320: g_dbus_unregister_interface (object.c:715)
    by 0x120C09: media_server_remove (manager.c:1098)
    by 0x4EA9826: g_slist_foreach (in /lib64/libglib-2.0.so.0.2908.0)
    by 0x178845: adapter_remove (adapter.c:2326)
    by 0x17528F: btd_manager_unregister_adapter (manager.c:293)
    by 0x153FE1: device_event (hciops.c:2643)
    by 0x154321: io_stack_event (hciops.c:2763)
    by 0x4E8C88C: g_main_context_dispatch (in /lib64/libglib-2.0.so.0.2908.0)
  Address 0x637fe18 is 8 bytes inside a block of size 16 free'd
    at 0x4A055FE: free (vg_replace_malloc.c:366)
    by 0x4E938F2: g_free (in /lib64/libglib-2.0.so.0.2908.0)
    by 0x4EA854E: g_slice_free1 (in /lib64/libglib-2.0.so.0.2908.0)
    by 0x4EA930C: g_slist_remove (in /lib64/libglib-2.0.so.0.2908.0)
    by 0x13AE03: media_endpoint_remove (media.c:118)
    by 0x4EA9826: g_slist_foreach (in /lib64/libglib-2.0.so.0.2908.0)
    by 0x4EA984A: g_slist_free_full (in /lib64/libglib-2.0.so.0.2908.0)
    by 0x13AEE3: path_free (media.c:412)
    by 0x11EAF9: remove_interface (object.c:563)
    by 0x11F320: g_dbus_unregister_interface (object.c:715)
    by 0x120C09: media_server_remove (manager.c:1098)
    by 0x4EA9826: g_slist_foreach (in /lib64/libglib-2.0.so.0.2908.0)

 Invalid free() / delete / delete[]
    at 0x4A055FE: free (vg_replace_malloc.c:366)
    by 0x4E938F2: g_free (in /lib64/libglib-2.0.so.0.2908.0)
    by 0x4EA8CB3: g_slice_free_chain_with_offset (in /lib64/libglib-2.0.so.0.2908.0)
    by 0x13AEE3: path_free (media.c:412)
    by 0x11EAF9: remove_interface (object.c:563)
    by 0x11F320: g_dbus_unregister_interface (object.c:715)
    by 0x120C09: media_server_remove (manager.c:1098)
    by 0x4EA9826: g_slist_foreach (in /lib64/libglib-2.0.so.0.2908.0)
    by 0x178845: adapter_remove (adapter.c:2326)
    by 0x17528F: btd_manager_unregister_adapter (manager.c:293)
    by 0x153FE1: device_event (hciops.c:2643)
    by 0x154321: io_stack_event (hciops.c:2763)
  Address 0x637fe10 is 0 bytes inside a block of size 16 free'd
    at 0x4A055FE: free (vg_replace_malloc.c:366)
    by 0x4E938F2: g_free (in /lib64/libglib-2.0.so.0.2908.0)
    by 0x4EA854E: g_slice_free1 (in /lib64/libglib-2.0.so.0.2908.0)
    by 0x4EA930C: g_slist_remove (in /lib64/libglib-2.0.so.0.2908.0)
    by 0x13AE03: media_endpoint_remove (media.c:118)
    by 0x4EA9826: g_slist_foreach (in /lib64/libglib-2.0.so.0.2908.0)
    by 0x4EA984A: g_slist_free_full (in /lib64/libglib-2.0.so.0.2908.0)
    by 0x13AEE3: path_free (media.c:412)
    by 0x11EAF9: remove_interface (object.c:563)
    by 0x11F320: g_dbus_unregister_interface (object.c:715)
    by 0x120C09: media_server_remove (manager.c:1098)
    by 0x4EA9826: g_slist_foreach (in /lib64/libglib-2.0.so.0.2908.0)
---
 audio/a2dp.c |   11 ++++++++---
 1 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/audio/a2dp.c b/audio/a2dp.c
index 72a0df5..8f32fdb 100644
--- a/audio/a2dp.c
+++ b/audio/a2dp.c
@@ -1595,14 +1595,19 @@ static void a2dp_unregister_sep(struct a2dp_sep *sep)
 void a2dp_unregister(const bdaddr_t *src)
 {
 	struct a2dp_server *server;
+	GSList *sources, *sinks;
 
 	server = find_server(servers, src);
 	if (!server)
 		return;
 
-	g_slist_free_full(server->sinks, (GDestroyNotify) a2dp_unregister_sep);
-	g_slist_free_full(server->sources,
-					(GDestroyNotify) a2dp_unregister_sep);
+	sinks = server->sinks;
+	server->sinks = NULL;
+	g_slist_free_full(sinks, (GDestroyNotify) a2dp_unregister_sep);
+
+	sources = server->sources;
+	server->sources = NULL;
+	g_slist_free_full(sources, (GDestroyNotify) a2dp_unregister_sep);
 
 	avdtp_exit(src);
 
-- 
1.7.6

