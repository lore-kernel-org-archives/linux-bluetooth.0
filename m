Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] shared/gatt-client: Fix use after free
Date: Fri,  6 Nov 2015 11:40:19 +0200
Message-Id: <1446802819-9059-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This fixes the following crash which happens when a service changed
removes characteristics which have notification pending:

==42544== Invalid read of size 4
==42544==    at 0x4939FA: enable_ccc_callback (gatt-client.c:1163)
==42544==    by 0x490D37: handle_rsp (att.c:673)
==42544==    by 0x490D37: can_read_data (att.c:845)
==42544==    by 0x498ED4: watch_callback (io-glib.c:170)
==42544==    by 0x4E7EE39: g_main_context_dispatch (in /usr/lib64/libglib-2.0.so.0.4600.1)
==42544==    by 0x4E7F1CF: ??? (in /usr/lib64/libglib-2.0.so.0.4600.1)
==42544==    by 0x4E7F4F1: g_main_loop_run (in /usr/lib64/libglib-2.0.so.0.4600.1)
==42544==    by 0x40B12E: main (main.c:661)
==42544==  Address 0x7e4eaa8 is 8 bytes inside a block of size 32 free'd
==42544==    at 0x4C29D6A: free (in /usr/lib64/valgrind/vgpreload_memcheck-amd64-linux.so)
==42544==    by 0x48C96D: queue_remove_all (queue.c:360)
==42544==    by 0x491AA2: gatt_client_remove_notify_chrcs_in_range (gatt-client.c:331)
==42544==    by 0x491AA2: process_service_changed (gatt-client.c:1398)
==42544==    by 0x48C74D: queue_foreach (queue.c:239)
==42544==    by 0x4936B2: notify_cb (gatt-client.c:1614)
==42544==    by 0x490BC6: handle_notify (att.c:800)
==42544==    by 0x490BC6: can_read_data (att.c:881)
==42544==    by 0x498ED4: watch_callback (io-glib.c:170)
==42544==    by 0x4E7EE39: g_main_context_dispatch (in /usr/lib64/libglib-2.0.so.0.4600.1)
==42544==    by 0x4E7F1CF: ??? (in /usr/lib64/libglib-2.0.so.0.4600.1)
==42544==    by 0x4E7F4F1: g_main_loop_run (in /usr/lib64/libglib-2.0.so.0.4600.1)
==42544==    by 0x40B12E: main (main.c:661)
---
 src/shared/gatt-client.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
index fd306ac..bb264d3 100644
--- a/src/shared/gatt-client.c
+++ b/src/shared/gatt-client.c
@@ -306,6 +306,16 @@ static bool match_notify_chrc_handle_range(const void *a, const void *b)
 					chrc->value_handle <= range->end;
 }
 
+static void notify_data_cleanup(void *data)
+{
+	struct notify_data *notify_data = data;
+
+	if (notify_data->att_id)
+		bt_att_cancel(notify_data->client->att, notify_data->att_id);
+
+	notify_data_unref(notify_data);
+}
+
 static void gatt_client_remove_all_notify_in_range(
 				struct bt_gatt_client *client,
 				uint16_t start_handle, uint16_t end_handle)
@@ -316,7 +326,7 @@ static void gatt_client_remove_all_notify_in_range(
 	range.end = end_handle;
 
 	queue_remove_all(client->notify_list, match_notify_data_handle_range,
-						&range, notify_data_unref);
+						&range, notify_data_cleanup);
 }
 
 static void gatt_client_remove_notify_chrcs_in_range(
@@ -1620,16 +1630,6 @@ static void notify_cb(uint8_t opcode, const void *pdu, uint16_t length,
 	bt_gatt_client_unref(client);
 }
 
-static void notify_data_cleanup(void *data)
-{
-	struct notify_data *notify_data = data;
-
-	if (notify_data->att_id)
-		bt_att_cancel(notify_data->client->att, notify_data->att_id);
-
-	notify_data_unref(notify_data);
-}
-
 static void bt_gatt_client_free(struct bt_gatt_client *client)
 {
 	bt_gatt_client_cancel_all(client);
-- 
2.4.3

