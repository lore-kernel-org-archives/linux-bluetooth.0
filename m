Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [RFC BlueZ] adapter: Fix memory leak on discovery cleanup
Date: Wed, 17 Oct 2012 20:15:09 -0300
Message-Id: <1350515709-30389-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

During discovery cleanup, it was attempted to send a DevicesFound()
D-Bus signal for pending found devices, but adapter->discovery was set
to NULL before calling send_devices_found(), therefore it never sent any
signal (and there was a leak of discovery->pending list).

Fixes this memory leak when pairing two LE devices:

==1822== 8 bytes in 1 blocks are definitely lost in loss record 42 of
246
==1822==    at 0x482BE68: malloc (in
/usr/lib/valgrind/vgpreload_memcheck-x86-linux.so)
==1822==    by 0x48869AA: standard_malloc (gmem.c:85)
==1822==    by 0x4886E42: g_malloc (gmem.c:159)
==1822==    by 0x489B26D: g_slice_alloc (gslice.c:1003)
==1822==    by 0x489C10A: g_slist_prepend (gslist.c:265)
==1822==    by 0x1855AE: adapter_update_found_devices (adapter.c:2846)
==1822==    by 0x191431: btd_event_device_found (event.c:260)
==1822==    by 0xBC01001A: ???
==1822==
---
 src/adapter.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 7c2aec0..3b24816 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -556,8 +556,6 @@ static void discovery_cleanup(struct btd_adapter *adapter)
 {
 	struct discovery *discovery = adapter->discovery;
 
-	adapter->discovery = NULL;
-
 	if (!discovery)
 		return;
 
@@ -566,6 +564,8 @@ static void discovery_cleanup(struct btd_adapter *adapter)
 
 	send_devices_found(adapter);
 
+	adapter->discovery = NULL;
+
 	g_slist_free_full(discovery->found, invalidate_rssi);
 
 	g_free(discovery);
-- 
1.7.9.5

