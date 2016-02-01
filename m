Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 3/4] shared/gatt-client: Fix bogus asserts
Date: Mon,  1 Feb 2016 16:13:21 +0200
Message-Id: <1454336002-4954-3-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1454336002-4954-1-git-send-email-luiz.dentz@gmail.com>
References: <1454336002-4954-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

The asserts involving notify_count were bogus because it should be
possible to disable a notification even before the remote respond to
the write command.
---
 src/shared/gatt-client.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
index 5fd0208..91acad5 100644
--- a/src/shared/gatt-client.c
+++ b/src/shared/gatt-client.c
@@ -1116,9 +1116,6 @@ static void complete_notify_request(void *data)
 {
 	struct notify_data *notify_data = data;
 
-	/* Increment the per-characteristic ref count of notify handlers */
-	__sync_fetch_and_add(&notify_data->chrc->notify_count, 1);
-
 	notify_data->att_id = 0;
 	notify_data->callback(0, notify_data->user_data);
 }
@@ -1174,7 +1171,6 @@ static void enable_ccc_callback(uint8_t opcode, const void *pdu,
 	struct notify_data *notify_data = user_data;
 	uint16_t att_ecode;
 
-	assert(!notify_data->chrc->notify_count);
 	assert(notify_data->chrc->ccc_write_id);
 
 	notify_data->chrc->ccc_write_id = 0;
@@ -1264,6 +1260,9 @@ static unsigned int register_notify(struct bt_gatt_client *client,
 
 	notify_data->id = client->next_reg_id++;
 
+	/* Increment the per-characteristic ref count of notify handlers */
+	__sync_fetch_and_add(&notify_data->chrc->notify_count, 1);
+
 	/*
 	 * If a write to the CCC descriptor is in progress, then queue this
 	 * request.
@@ -1274,9 +1273,9 @@ static unsigned int register_notify(struct bt_gatt_client *client,
 	}
 
 	/*
-	 * If the ref count is not zero, then notifications are already enabled.
+	 * If the ref count > 1, then notifications are already enabled.
 	 */
-	if (chrc->notify_count > 0 || !chrc->ccc_handle) {
+	if (chrc->notify_count > 1 || !chrc->ccc_handle) {
 		complete_notify_request(notify_data);
 		return notify_data->id;
 	}
@@ -1555,7 +1554,6 @@ static void disable_ccc_callback(uint8_t opcode, const void *pdu,
 	struct notify_data *notify_data = user_data;
 	struct notify_data *next_data;
 
-	assert(!notify_data->chrc->notify_count);
 	assert(notify_data->chrc->ccc_write_id);
 
 	notify_data->chrc->ccc_write_id = 0;
@@ -2960,9 +2958,6 @@ bool bt_gatt_client_unregister_notify(struct bt_gatt_client *client,
 	if (!notify_data)
 		return false;
 
-	assert(notify_data->chrc->notify_count > 0);
-	assert(!notify_data->chrc->ccc_write_id);
-
 	complete_unregister_notify(notify_data);
 	return true;
 }
-- 
2.5.0

