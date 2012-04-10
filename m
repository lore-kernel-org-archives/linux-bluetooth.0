Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH BlueZ] audio: Fix memory leak when headset server probe() fails
Date: Tue, 10 Apr 2012 16:22:48 -0400
Message-Id: <1334089368-6920-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

If RFCOMM is disabled on the kernel, headset_server_probe() fails.
Relevant log messages:

 audio/manager.c:headset_server_probe() path /org/bluez/499/hci0
 src/adapter.c:btd_adapter_ref() 0x4bb4f78: ref=6
 audio/manager.c:audio_adapter_ref() 0x4ca3010: ref=1
 socket(STREAM, RFCOMM): Protocol not supported (93)
 audio/manager.c:audio_adapter_unref() 0x4ca3010: ref=0
 src/adapter.c:btd_adapter_unref() 0x4bb4f78: ref=5
 audio-headset: Operation not permitted (1)

The powered callback should only be registered if adapter driver probe
was successful. The callback unregister was moved to the beginning of
headset_server_remove() for consistency.

This fixes this memory leak:

==499== 8 bytes in 1 blocks are definitely lost in loss record 44 of 182
==499==    at 0x4826444: malloc (vg_replace_malloc.c:263)
==499==    by 0x4877243: g_malloc (gmem.c:132)
==499==    by 0x488D088: g_slice_alloc (gslice.c:836)
==499==    by 0x488E8A5: g_slist_append (gslist.c:230)
==499==    by 0x18AEEE: btd_adapter_register_powered_callback
(adapter.c:3416)
==499==    by 0x11AF61: headset_server_probe (manager.c:919)
==499==    by 0x18B67B: probe_driver (adapter.c:2033)
==499==    by 0x1908F5: adapter_init (adapter.c:2048)
==499==    by 0x189D20: btd_manager_register_adapter (manager.c:397)
==499==    by 0x1649AF: mgmt_cmd_complete (mgmtops.c:1075)
==499==    by 0x16665E: mgmt_event (mgmtops.c:1780)
==499==    by 0x48B2EFA: g_io_unix_dispatch (giounix.c:162)
---
 audio/manager.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

NOTE: I was only able to test the failure case as illustrated below, but I
expect that nothing else is affected, given that no other code is expected to
run after probe() fails (right?)
 
diff --git a/audio/manager.c b/audio/manager.c
index 170ed23..aa2547c 100644
--- a/audio/manager.c
+++ b/audio/manager.c
@@ -916,14 +916,14 @@ static int headset_server_probe(struct btd_adapter *adapter)
 	if (!adp)
 		return -EINVAL;
 
-	btd_adapter_register_powered_callback(adapter, state_changed);
-
 	err = headset_server_init(adp);
 	if (err < 0) {
 		audio_adapter_unref(adp);
 		return err;
 	}
 
+	btd_adapter_register_powered_callback(adapter, state_changed);
+
 	return 0;
 }
 
@@ -934,6 +934,8 @@ static void headset_server_remove(struct btd_adapter *adapter)
 
 	DBG("path %s", path);
 
+	btd_adapter_unregister_powered_callback(adapter, state_changed);
+
 	adp = find_adapter(adapters, adapter);
 	if (!adp)
 		return;
@@ -960,8 +962,6 @@ static void headset_server_remove(struct btd_adapter *adapter)
 		adp->hfp_ag_server = NULL;
 	}
 
-	btd_adapter_unregister_powered_callback(adapter, state_changed);
-
 	audio_adapter_unref(adp);
 }
 
-- 
1.7.5.4

