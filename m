Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Seungyoun Ju <sy39.ju@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: Seungyoun Ju <sy39.ju@samsung.com>
Subject: [PATCH] shared/gatt-client: Fix notify_list corruption
Date: Tue, 24 Nov 2015 17:32:36 +0900
Message-Id: <1448353956-8880-1-git-send-email-sy39.ju@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When gatt-client processes service changed indication,
notify_list is modified in its foreach callback.

This makes queue_foreach's "next" point to freed memory area and process
crash.

This patch adds service changed indication to queue.
After notify_list's foreach is done, queued one is processed smoothly.

Invalid read of size 4
   at 0x8056B91: queue_foreach (queue.c:219)
   by 0x8051F44: notify_cb (gatt-client.c:1633)
   by 0x804E1A9: can_read_data (att.c:800)
   by 0x80558E1: io_callback (io-mainloop.c:123)
   by 0x8056505: mainloop_run (mainloop.c:157)
   by 0x804995E: main (btgatt-client.c:1664)
 Address 0x41a3784 is 4 bytes inside a block of size 8 free'd
   at 0x402750C: free (vg_replace_malloc.c:427)
   by 0x8056D2F: queue_remove_if (queue.c:302)
   by 0x8056DD0: queue_remove_all (queue.c:331)
   by 0x804F61E: process_service_changed (gatt-client.c:332)
   by 0x804E7F1: notify_handler (gatt-client.c:1617)
   by 0x8056B9E: queue_foreach (queue.c:220)
   by 0x8051F44: notify_cb (gatt-client.c:1633)
   by 0x804E1A9: can_read_data (att.c:800)
   by 0x80558E1: io_callback (io-mainloop.c:123)
   by 0x8056505: mainloop_run (mainloop.c:157)
   by 0x804995E: main (btgatt-client.c:1664)
---
 src/shared/gatt-client.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
index 06ac763..95304ca 100644
--- a/src/shared/gatt-client.c
+++ b/src/shared/gatt-client.c
@@ -1469,11 +1469,6 @@ static void service_changed_cb(uint16_t value_handle, const uint8_t *value,
 			"Service Changed received - start: 0x%04x end: 0x%04x",
 			start, end);
 
-	if (!client->in_svc_chngd) {
-		process_service_changed(client, start, end);
-		return;
-	}
-
 	op = new0(struct service_changed_op, 1);
 
 	op->start_handle = start;
@@ -1623,6 +1618,7 @@ static void notify_cb(uint8_t opcode, const void *pdu, uint16_t length,
 {
 	struct bt_gatt_client *client = user_data;
 	struct pdu_data pdu_data;
+	struct service_changed_op *sc_op;
 
 	bt_gatt_client_ref(client);
 
@@ -1632,6 +1628,13 @@ static void notify_cb(uint8_t opcode, const void *pdu, uint16_t length,
 
 	queue_foreach(client->notify_list, notify_handler, &pdu_data);
 
+	if (client->in_svc_chngd == false &&
+	    (sc_op = queue_pop_head(client->svc_chngd_queue))) {
+		process_service_changed(client, sc_op->start_handle,
+						sc_op->end_handle);
+		free(sc_op);
+	}
+
 	if (opcode == BT_ATT_OP_HANDLE_VAL_IND)
 		bt_att_send(client->att, BT_ATT_OP_HANDLE_VAL_CONF, NULL, 0,
 							NULL, NULL, NULL);
-- 
2.1.0

