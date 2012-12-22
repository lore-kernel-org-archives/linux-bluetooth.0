Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH BlueZ] core: Fix memory leak from pending UUID removal
Date: Sat, 22 Dec 2012 18:59:21 -0400
Message-Id: <1356217161-3787-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When bluetoothd is shutting down, profile cleanup will usually issue
many "Remove UUID" management commands. These may not complete before
the process exits, resulting on this memory leak:

==2461== 144 (8 direct, 136 indirect) bytes in 1 blocks are definitely
lost in loss record 153 of 176
==2461==    at 0x402BE68: malloc (in
/usr/lib/valgrind/vgpreload_memcheck-x86-linux.so)
==2461==    by 0x40869AA: standard_malloc (gmem.c:85)
==2461==    by 0x4086E42: g_malloc (gmem.c:159)
==2461==    by 0x409B26D: g_slice_alloc (gslice.c:1003)
==2461==    by 0x409C659: g_slist_append (gslist.c:222)
==2461==    by 0x80B5E12: mgmt_remove_uuid (mgmt.c:1034)
==2461==    by 0x80A734E: adapter_service_remove (adapter.c:708)
==2461==    by 0x80994B4: sdp_record_remove (sdpd-database.c:272)
==2461==    by 0x8098CC0: remove_record_from_server (sdpd-service.c:290)
==2461==    by 0x8062B5B: avrcp_unregister (avrcp.c:2354)
==2461==    by 0x409C797: g_slist_foreach (gslist.c:840)
==2461==    by 0x80A7D77: adapter_remove (adapter.c:1630)

The leak seems to only happen during bluetoothd shutdown, because the
list of pending UUIDs is cleared when controller is removed. Therefore,
only cleanup the list on shutdown path.
---
 src/mgmt.c |   11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/src/mgmt.c b/src/mgmt.c
index 52441e8..ae4a95c 100644
--- a/src/mgmt.c
+++ b/src/mgmt.c
@@ -2231,6 +2231,17 @@ fail:
 
 void mgmt_cleanup(void)
 {
+	int index;
+
+	for (index = 0; index <= max_index; index++) {
+		struct controller_info *info = &controllers[index];
+
+		if (!info->valid)
+			continue;
+
+		g_slist_free_full(info->pending_uuids, g_free);
+	}
+
 	g_free(controllers);
 	controllers = NULL;
 	max_index = -1;
-- 
1.7.9.5

