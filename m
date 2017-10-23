Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/3] shared/att: Fix crash when calling disconnect handlers
Date: Mon, 23 Oct 2017 14:17:21 +0300
Message-Id: <20171023111723.20729-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

When calling disconnect handlers the callback itself may remove items
from the queue causing the following crash:

Invalid read of size 8
  at 0x4D1D3C: queue_foreach (queue.c:219)
  by 0x4D8369: disconnect_cb (att.c:590)
  by 0x4E4FAA: watch_callback (io-glib.c:170)
  by 0x50CD246: g_main_context_dispatch (in /usr/lib64/libglib-2.0.so.0.5200.3)
  by 0x50CD5E7: ??? (in /usr/lib64/libglib-2.0.so.0.5200.3)
  by 0x50CD901: g_main_loop_run (in /usr/lib64/libglib-2.0.so.0.5200.3)
  by 0x40CCC0: main (main.c:770)
Address 0x888a888 is 8 bytes inside a block of size 16 free'd
  at 0x4C2FD18: free (vg_replace_malloc.c:530)
  by 0x4D1F9B: queue_remove_if (queue.c:302)
  by 0x4D763B: bt_att_unregister_disconnect (att.c:1206)
  by 0x4DC11E: bt_gatt_client_free (gatt-client.c:1762)
  by 0x4DC270: bt_gatt_client_unref (gatt-client.c:1903)
  by 0x4A316F: gatt_client_cleanup (device.c:573)
  by 0x4A326E: attio_cleanup (device.c:598)
  by 0x4A5EB9: att_disconnected_cb (device.c:4679)
  by 0x4D66D5: disconn_handler (att.c:538)
  by 0x4D1D4F: queue_foreach (queue.c:220)
  by 0x4D8369: disconnect_cb (att.c:590)
  by 0x4E4FAA: watch_callback (io-glib.c:170)
---
 src/shared/att.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/src/shared/att.c b/src/shared/att.c
index 4670de74f..8d58156c1 100644
--- a/src/shared/att.c
+++ b/src/shared/att.c
@@ -1203,6 +1203,17 @@ bool bt_att_unregister_disconnect(struct bt_att *att, unsigned int id)
 	if (!att || !id)
 		return false;
 
+	/* Check if disconnect is running */
+	if (!att->io) {
+		disconn = queue_find(att->disconn_list, match_disconn_id,
+							UINT_TO_PTR(id));
+		if (!disconn)
+			return false;
+
+		disconn->removed = true;
+		return true;
+	}
+
 	disconn = queue_remove_if(att->disconn_list, match_disconn_id,
 							UINT_TO_PTR(id));
 	if (!disconn)
-- 
2.13.6

