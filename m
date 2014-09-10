Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH BlueZ v2 3/7] shared/gatt-client: Implement bt_gatt_client_unregister_notify.
Date: Wed, 10 Sep 2014 09:36:23 -0700
Message-Id: <1410366987-8128-4-git-send-email-armansito@chromium.org>
In-Reply-To: <1410366987-8128-1-git-send-email-armansito@chromium.org>
References: <1410366987-8128-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch implements bt_gatt_client_unregister_notify, which is used to remove
a previous registered notification/indication handler. This function decreases
the per-characteristic count of handlers, and if the count drops to 0, a write
request is sent to the CCC descriptor to disable notifications/indications.
---
 src/shared/gatt-client.c | 54 +++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 51 insertions(+), 3 deletions(-)

diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
index 76fa91c..0de4308 100644
--- a/src/shared/gatt-client.c
+++ b/src/shared/gatt-client.c
@@ -604,6 +604,14 @@ static void notify_data_unref(void *data)
 	free(notify_data);
 }
 
+static bool match_notify_data_id(const void *a, const void *b)
+{
+	const struct notify_data *notify_data = a;
+	unsigned int id = PTR_TO_UINT(b);
+
+	return notify_data->id == id;
+}
+
 static void complete_notify_request(void *data)
 {
 	struct notify_data *notify_data = data;
@@ -706,7 +714,23 @@ static void enable_ccc_callback(uint8_t opcode, const void *pdu,
 static void disable_ccc_callback(uint8_t opcode, const void *pdu,
 					uint16_t length, void *user_data)
 {
-	/* TODO */
+	struct notify_data *notify_data = user_data;
+	struct notify_data *next_data;
+
+	assert(!notify_data->chrc->notify_count);
+	assert(notify_data->chrc->ccc_write_id);
+
+	notify_data->chrc->ccc_write_id = 0;
+
+	/* This is a best effort procedure, so ignore errors and process any
+	 * queued requests.
+	 */
+	while (1) {
+		next_data = queue_pop_head(notify_data->chrc->reg_notify_queue);
+		if (!next_data || notify_data_write_ccc(notify_data, true,
+							enable_ccc_callback))
+			return;
+	}
 }
 
 struct bt_gatt_client *bt_gatt_client_new(struct bt_att *att, uint16_t mtu)
@@ -1667,6 +1691,30 @@ bool bt_gatt_client_register_notify(struct bt_gatt_client *client,
 bool bt_gatt_client_unregister_notify(struct bt_gatt_client *client,
 							unsigned int id)
 {
-	/* TODO */
-	return false;
+	struct notify_data *notify_data;
+
+	if (!client || !id)
+		return false;
+
+	notify_data = queue_find(client->notify_list, match_notify_data_id,
+							UINT_TO_PTR(id));
+	if (!notify_data)
+		return false;
+
+	assert(notify_data->chrc->notify_count > 0);
+	assert(!notify_data->chrc->ccc_write_id);
+
+	/* TODO: Delay destruction/removal if we're in the middle of processing
+	 * a notification.
+	 */
+	queue_remove(client->notify_list, notify_data);
+
+	if (__sync_sub_and_fetch(&notify_data->chrc->notify_count, 1)) {
+		notify_data_unref(notify_data);
+		return true;
+	}
+
+	notify_data_write_ccc(notify_data, false, disable_ccc_callback);
+
+	return true;
 }
-- 
2.1.0.rc2.206.gedb03e5

