Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] shared/gatt-client: Fix invalid read
Date: Thu, 12 Feb 2015 14:54:10 +0200
Message-Id: <1423745650-27470-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

The following backtrace can be reproduced when bt_gatt_client_unref is
with a pending request:

Invalid read of size 1
   at 0x428D37: cancel_request (gatt-client.c:1766)
   by 0x43235F: queue_remove_all (queue.c:387)
   by 0x429C3D: bt_gatt_client_cancel_all (gatt-client.c:1786)
   by 0x429C70: bt_gatt_client_free (gatt-client.c:1516)
   by 0x429DF0: bt_gatt_client_unref (gatt-client.c:1639)
   by 0x41F3AD: destroy_context (test-gatt.c:279)
   by 0x41F3AD: context_quit (test-gatt.c:302)
   by 0x41F817: test_read_cb (test-gatt.c:672)
   by 0x427030: read_cb (gatt-client.c:1835)
   by 0x42465B: handle_rsp (att.c:600)
   by 0x42465B: can_read_data (att.c:732)
   by 0x4312BA: watch_callback (io-glib.c:170)
   by 0x4E7EAEA: g_main_context_dispatch (in /usr/lib64/libglib-2.0.so.0.4200.1)
   by 0x4E7EE87: ??? (in /usr/lib64/libglib-2.0.so.0.4200.1)
 Address 0x57e5748 is 8 bytes inside a block of size 40 free'd
   at 0x4C2ACE9: free (in /usr/lib64/valgrind/vgpreload_memcheck-amd64-linux.so)
   by 0x428C8F: request_unref (gatt-client.c:153)
   by 0x423CA6: cancel_att_send_op (att.c:204)
   by 0x423CA6: bt_att_cancel (att.c:1069)
   by 0x428D36: cancel_request (gatt-client.c:1764)
   by 0x43235F: queue_remove_all (queue.c:387)
   by 0x429C3D: bt_gatt_client_cancel_all (gatt-client.c:1786)
   by 0x429C70: bt_gatt_client_free (gatt-client.c:1516)
   by 0x429DF0: bt_gatt_client_unref (gatt-client.c:1639)
   by 0x41F3AD: destroy_context (test-gatt.c:279)
   by 0x41F3AD: context_quit (test-gatt.c:302)
   by 0x41F817: test_read_cb (test-gatt.c:672)
   by 0x427030: read_cb (gatt-client.c:1835)
   by 0x42465B: handle_rsp (att.c:600)
   by 0x42465B: can_read_data (att.c:732)
---
 src/shared/gatt-client.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
index bfb9427..a7c52dc 100644
--- a/src/shared/gatt-client.c
+++ b/src/shared/gatt-client.c
@@ -1761,10 +1761,11 @@ static void cancel_request(void *data)
 	uint8_t pdu = 0x00;
 
 	req->removed = true;
-	bt_att_cancel(req->client->att, req->att_id);
 
-	if (!req->long_write)
+	if (!req->long_write) {
+		bt_att_cancel(req->client->att, req->att_id);
 		return;
+	}
 
 	if (!req->att_id)
 		queue_remove(req->client->long_write_queue, req);
@@ -1776,6 +1777,8 @@ static void cancel_request(void *data)
 							&pdu, sizeof(pdu),
 							cancel_long_write_cb,
 							NULL, NULL);
+
+	bt_att_cancel(req->client->att, req->att_id);
 }
 
 bool bt_gatt_client_cancel_all(struct bt_gatt_client *client)
-- 
2.1.0

