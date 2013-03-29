Return-Path: <cyrus@holtmann.org>
From: Alex Deymo <deymo@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: keybuk@chromium.org, Alex Deymo <deymo@chromium.org>
Subject: [PATCH] core: Memory leak on device_free for eir_uuids field.
Date: Fri, 29 Mar 2013 14:19:43 -0700
Message-Id: <1364591983-30077-1-git-send-email-deymo@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The eir_uuids list is usually freed by device_svc_resolved, but that
doesn't happen if the device is removed before a SDP browse ends.
This fix deletes the eir_uuids list on device_free.

---

==5593== 1,431 (48 direct, 1,383 indirect) bytes in 3 blocks are definitely lost in loss record 214 of 224
==5593==    at 0x4C2B6CD: malloc (in /usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so)
==5593==    by 0x4E7FA78: g_malloc (gmem.c:159)
==5593==    by 0x4E92CA2: g_slice_alloc (gslice.c:1003)
==5593==    by 0x4E93FC2: g_slist_append (gslist.c:222)
==5593==    by 0x46D039: device_add_eir_uuids (device.c:1138)
==5593==    by 0x462049: update_found_devices (adapter.c:4148)
==5593==    by 0x462328: device_found_callback (adapter.c:4232)
==5593==    by 0x47614A: process_notify (mgmt.c:252)
==5593==    by 0x476479: received_data (mgmt.c:336)
==5593==    by 0x4E79D52: g_main_context_dispatch (gmain.c:2539)
==5593==    by 0x4E7A09F: g_main_context_iterate.isra.23 (gmain.c:3146)
==5593==    by 0x4E7A499: g_main_loop_run (gmain.c:3340)
==5593==

 src/device.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/src/device.c b/src/device.c
index 1630082..ee17514 100644
--- a/src/device.c
+++ b/src/device.c
@@ -445,6 +445,9 @@ static void device_free(gpointer user_data)
 		g_free(device->authr);
 	}
 
+	if (device->eir_uuids)
+		g_slist_free_full(device->eir_uuids, g_free);
+
 	g_free(device->path);
 	g_free(device->alias);
 	g_free(device->modalias);
-- 
1.8.1.3

