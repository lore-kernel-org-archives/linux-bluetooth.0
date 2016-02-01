Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 4/4] shared/gatt-client: Fix crash unregistering notification
Date: Mon,  1 Feb 2016 16:13:22 +0200
Message-Id: <1454336002-4954-4-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1454336002-4954-1-git-send-email-luiz.dentz@gmail.com>
References: <1454336002-4954-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This fixes the following crash which happen when a notification is queued
waiting for CCC to be written but it cancelled before it completes:

Invalid read of size 4
  at 0x4E0C38: notify_data_unref (gatt-client.c:201)
  by 0x4D9BBE: queue_remove_all (queue.c:351)
  by 0x4D9C14: queue_destroy (queue.c:73)
  by 0x4E0DBB: notify_chrc_free (gatt-client.c:277)
  by 0x4D9BBE: queue_remove_all (queue.c:351)
  by 0x4D9C14: queue_destroy (queue.c:73)
  by 0x4E3860: bt_gatt_client_free (gatt-client.c:1664)
  by 0x4E38D0: bt_gatt_client_unref (gatt-client.c:1749)
  by 0x45D324: gas_free (gas.c:65)
  by 0x45D324: gap_driver_remove (gas.c:254)
  by 0x4A72A0: service_remove (service.c:176)
  by 0x4B74E9: device_remove (device.c:3865)
  by 0x492971: adapter_remove (adapter.c:5236)
Address 0x8cb8830 is 16 bytes inside a block of size 64 free'd
  at 0x4C29E00: free (vg_replace_malloc.c:530)
  by 0x4E0C69: notify_data_unref (gatt-client.c:207)
  by 0x4E58C9: complete_unregister_notify (gatt-client.c:1593)
  by 0x4E58C9: bt_gatt_client_unregister_notify (gatt-client.c:2961)
  by 0x4A8D77: characteristic_stop_notify (gatt-client.c:1214)
  by 0x4D4E82: process_message.isra.3 (object.c:259)
  by 0x4D56DC: generic_message (object.c:1071)
  by 0x53DD1A2: ??? (in /usr/lib64/libdbus-1.so.3.14.6)
  by 0x53CE733: dbus_connection_dispatch (in /usr/lib64/libdbus-1.so.3.14.6)
  by 0x4CFADF: message_dispatch (mainloop.c:72)
  by 0x50C8E39: g_main_context_dispatch (in /usr/lib64/libglib-2.0.so.0.4600.2)
  by 0x50C91CF: ??? (in /usr/lib64/libglib-2.0.so.0.4600.2)
  by 0x50C94F1: g_main_loop_run (in /usr/lib64/libglib-2.0.so.0.4600.2)
---
 src/shared/gatt-client.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
index 91acad5..130d602 100644
--- a/src/shared/gatt-client.c
+++ b/src/shared/gatt-client.c
@@ -2958,6 +2958,9 @@ bool bt_gatt_client_unregister_notify(struct bt_gatt_client *client,
 	if (!notify_data)
 		return false;
 
+	/* Remove data if it has been queued */
+	queue_remove(notify_data->chrc->reg_notify_queue, notify_data);
+
 	complete_unregister_notify(notify_data);
 	return true;
 }
-- 
2.5.0

