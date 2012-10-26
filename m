Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] core: Fix memory leak
Date: Fri, 26 Oct 2012 10:56:56 +0300
Message-Id: <1351238216-7583-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

1,262 (64 direct, 1,198 indirect) bytes in 1 blocks are definitely lost in loss record 280 of 290
   at 0x4A0881C: malloc (vg_replace_malloc.c:270)
   by 0x4C813FE: g_malloc (in /usr/lib64/libglib-2.0.so.0.3200.4)
   by 0x4C95801: g_slice_alloc (in /usr/lib64/libglib-2.0.so.0.3200.4)
   by 0x4C95D55: g_slice_alloc0 (in /usr/lib64/libglib-2.0.so.0.3200.4)
   by 0x4C746AA: g_key_file_new (in /usr/lib64/libglib-2.0.so.0.3200.4)
   by 0x18136C: load_config (adapter.c:2620)
   by 0x18353B: adapter_init (adapter.c:2708)
   by 0x17E62E: btd_manager_register_adapter (manager.c:337)
   by 0x191171: mgmt_event.part.36 (mgmt.c:1081)
   by 0x4C7B824: g_main_context_dispatch (in /usr/lib64/libglib-2.0.so.0.3200.4)
   by 0x4C7BB57: ??? (in /usr/lib64/libglib-2.0.so.0.3200.4)
   by 0x4C7BF51: g_main_loop_run (in /usr/lib64/libglib-2.0.so.0.3200.4)
---
 src/adapter.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/src/adapter.c b/src/adapter.c
index c7b8c7f..54b1a64 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -2684,6 +2684,8 @@ static void load_config(struct btd_adapter *adapter)
 	mgmt_set_connectable(adapter->dev_id, TRUE);
 	mgmt_set_discoverable(adapter->dev_id, adapter->discoverable,
 				adapter->discov_timeout);
+
+	g_key_file_free(key_file);
 }
 
 gboolean adapter_init(struct btd_adapter *adapter, gboolean up)
-- 
1.7.11.7

