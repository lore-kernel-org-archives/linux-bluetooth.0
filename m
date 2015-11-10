Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] shared/gatt-client: Don't reset database on service changed
Date: Tue, 10 Nov 2015 15:13:15 +0200
Message-Id: <1447161195-8830-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

If the remote send a full reset, 0x0001 - 0xffff, just discovery the
attributes again as device may send this even though nothing has
changed.
---
 src/shared/gatt-client.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
index 3aaa089..06ac763 100644
--- a/src/shared/gatt-client.c
+++ b/src/shared/gatt-client.c
@@ -1406,6 +1406,10 @@ static void process_service_changed(struct bt_gatt_client *client,
 {
 	struct discovery_op *op;
 
+	/* On full database reset just re-run attribute discovery */
+	if (start_handle == 0x0001 && end_handle == 0xffff)
+		goto discover;
+
 	/* Invalidate and remove all effected notify callbacks */
 	gatt_client_remove_all_notify_in_range(client, start_handle,
 								end_handle);
@@ -1417,6 +1421,7 @@ static void process_service_changed(struct bt_gatt_client *client,
 	 */
 	gatt_db_clear_range(client->db, start_handle, end_handle);
 
+discover:
 	op = discovery_op_create(client, start_handle, end_handle,
 						service_changed_complete,
 						service_changed_failure);
-- 
2.4.3

