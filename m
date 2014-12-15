Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 3/3] shared/gatt-client: Use queue_remove_if
Date: Mon, 15 Dec 2014 10:13:19 -0200
Message-Id: <1418645599-20169-4-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1418645599-20169-1-git-send-email-luiz.dentz@gmail.com>
References: <1418645599-20169-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This make use of queue_remove_if instead of queue_find + queue_remove
whenever possible.
---
 src/shared/gatt-client.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
index e523085..27aef44 100644
--- a/src/shared/gatt-client.c
+++ b/src/shared/gatt-client.c
@@ -2414,7 +2414,7 @@ bool bt_gatt_client_unregister_notify(struct bt_gatt_client *client,
 	if (!client || !id)
 		return false;
 
-	notify_data = queue_find(client->notify_list, match_notify_data_id,
+	notify_data = queue_remove_if(client->notify_list, match_notify_data_id,
 							UINT_TO_PTR(id));
 	if (!notify_data)
 		return false;
@@ -2422,7 +2422,6 @@ bool bt_gatt_client_unregister_notify(struct bt_gatt_client *client,
 	assert(notify_data->chrc->notify_count > 0);
 	assert(!notify_data->chrc->ccc_write_id);
 
-	queue_remove(client->notify_list, notify_data);
 	complete_unregister_notify(notify_data);
 	return true;
 }
-- 
1.9.3

