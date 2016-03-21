Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] core/gatt-client: Fix crash on service changed
Date: Mon, 21 Mar 2016 13:53:36 +0200
Message-Id: <1458561216-20844-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

The following crash can be observed when a service is removed from the
remote device leading to remove a client but instead a different
pointer was given causing which may leave the notification queue with
invalid clients:

Invalid read of size 8
  at 0x4A80D1: remove_client (gatt-client.c:1311)
  by 0x4DA16E: queue_remove_all (queue.c:351)
  by 0x4A7DF3: unregister_characteristic (gatt-client.c:1331)
  by 0x4DA16E: queue_remove_all (queue.c:351)
  by 0x4A7D65: unregister_service (gatt-client.c:1447)
  by 0x4DA0D5: queue_remove_all (queue.c:336)
  by 0x4AB11C: btd_gatt_client_service_removed (gatt-client.c:1747)
  by 0x4AFEA3: gatt_service_removed (device.c:3448)
  by 0x4E8FD1: handle_notify (gatt-db.c:249)
  by 0x4D9DC3: queue_foreach (queue.c:220)
  by 0x4E9ECB: notify_service_changed (gatt-db.c:266)
  by 0x4E9F7C: gatt_db_service_destroy (gatt-db.c:277)
Address 0x8cf8620 is 0 bytes inside a block of size 32 free'd
  at 0x4C29E00: free (vg_replace_malloc.c:530)
  by 0x4A9405: register_notify (gatt-client.c:1669)
  by 0x4D9DC3: queue_foreach (queue.c:220)
  by 0x4AAFBB: btd_gatt_client_connected (gatt-client.c:1714)
  by 0x4B2DAA: gatt_client_init (device.c:4591)
  by 0x4B2DAA: device_attach_att (device.c:4705)
  by 0x4B4712: att_connect_cb (device.c:4742)
  by 0x47375B: connect_cb (btio.c:232)
  by 0x50C8E39: g_main_context_dispatch (in /usr/lib64/libglib-2.0.so.0.4600.2)
  by 0x50C91CF: ??? (in /usr/lib64/libglib-2.0.so.0.4600.2)
  by 0x50C94F1: g_main_loop_run (in /usr/lib64/libglib-2.0.so.0.4600.2)
  by 0x40C258: main (main.c:687)
---
 src/gatt-client.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/gatt-client.c b/src/gatt-client.c
index cfe14da..a018c8c 100644
--- a/src/gatt-client.c
+++ b/src/gatt-client.c
@@ -1663,8 +1663,8 @@ static void register_notify(void *data, void *user_data)
 
 	DBG("Failed to re-register notification client");
 
-	queue_remove(notify_client->chrc->notify_clients, client);
-	queue_remove(client->all_notify_clients, client);
+	queue_remove(notify_client->chrc->notify_clients, notify_client);
+	queue_remove(client->all_notify_clients, notify_client);
 
 	notify_client_free(notify_client);
 }
-- 
2.5.0

