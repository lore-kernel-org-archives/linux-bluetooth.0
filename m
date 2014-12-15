Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/3] shared/gatt-client: Remove removed flag
Date: Mon, 15 Dec 2014 10:13:18 -0200
Message-Id: <1418645599-20169-3-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1418645599-20169-1-git-send-email-luiz.dentz@gmail.com>
References: <1418645599-20169-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 src/shared/gatt-client.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
index a15f3b8..e523085 100644
--- a/src/shared/gatt-client.c
+++ b/src/shared/gatt-client.c
@@ -104,7 +104,6 @@ struct notify_chrc {
 
 struct notify_data {
 	struct bt_gatt_client *client;
-	bool removed;
 	bool invalid;
 	unsigned int id;
 	int ref_count;
@@ -1372,9 +1371,6 @@ static void notify_handler(void *data, void *user_data)
 	uint16_t value_handle;
 	const uint8_t *value = NULL;
 
-	if (notify_data->removed)
-		return;
-
 	value_handle = get_le16(pdu_data->pdu);
 
 	if (notify_data->chrc->value_handle != value_handle)
@@ -2420,7 +2416,7 @@ bool bt_gatt_client_unregister_notify(struct bt_gatt_client *client,
 
 	notify_data = queue_find(client->notify_list, match_notify_data_id,
 							UINT_TO_PTR(id));
-	if (!notify_data || notify_data->removed)
+	if (!notify_data)
 		return false;
 
 	assert(notify_data->chrc->notify_count > 0);
-- 
1.9.3

