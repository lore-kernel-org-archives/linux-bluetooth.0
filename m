Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH BlueZ 3/7] shared/gatt-client: Implement bt_gatt_client_unregister_notify.
Date: Mon,  8 Sep 2014 18:03:07 -0700
Message-Id: <1410224591-5402-4-git-send-email-armansito@chromium.org>
In-Reply-To: <1410224591-5402-1-git-send-email-armansito@chromium.org>
References: <1410224591-5402-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch implements bt_gatt_client_unregister_notify, which is used to remove
a previous registered notification/indication handler. This function decreases
the per-characteristic count of handlers, and if the count drops to 0, a write
request is sent to the CCC descriptor to disable notifications/indications.
---
 src/shared/gatt-client.c | 52 +++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 49 insertions(+), 3 deletions(-)

diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
index d1b5c12..dfd37f8 100644
--- a/src/shared/gatt-client.c
+++ b/src/shared/gatt-client.c
@@ -1480,6 +1480,14 @@ static void notify_data_unref(void *data)
 	free(notd);
 }
 
+static bool match_notify_data_id(const void *a, const void *b)
+{
+	const struct notify_data *notd = a;
+	unsigned int id = PTR_TO_UINT(b);
+
+	return notd->id == id;
+}
+
 static void complete_notify_request(void *data)
 {
 	struct notify_data *notd = data;
@@ -1541,13 +1549,27 @@ static void enable_ccc_callback(uint8_t opcode, const void *pdu,
 static void disable_ccc_callback(uint8_t opcode, const void *pdu,
 					uint16_t length, void *user_data)
 {
-	/* TODO */
+	struct notify_data *notd = user_data;
+
+	assert(!notd->chrc->not_ref_count);
+	assert(notd->chrc->ccc_write_id);
+
+	notd->chrc->ccc_write_id = 0;
+
+	/* This is a best effort procedure, so ignore errors and process any
+	 * queued requests.
+	 */
+	while ((notd = queue_pop_head(notd->chrc->register_not_queue))) {
+		if (notify_data_write_ccc(notd, true))
+			return;
+	}
 }
 
 static bool notify_data_write_ccc(struct notify_data *notd, bool enable)
 {
 	uint8_t pdu[4];
 
+	assert(notd->chrc->ccc_handle);
 	memset(pdu, 0, sizeof(pdu));
 	put_le16(notd->chrc->ccc_handle, pdu);
 
@@ -1659,6 +1681,30 @@ bool bt_gatt_client_register_notify(struct bt_gatt_client *client,
 bool bt_gatt_client_unregister_notify(struct bt_gatt_client *client,
 							unsigned int id)
 {
-	/* TODO */
-	return false;
+	struct notify_data *notd;
+
+	if (!client || !id)
+		return false;
+
+	notd = queue_find(client->notify_list, match_notify_data_id,
+							UINT_TO_PTR(id));
+	if (!notd)
+		return false;
+
+	assert(notd->chrc->not_ref_count > 0);
+	assert(!notd->chrc->ccc_write_id);
+
+	/* TODO: Delay destruction/removal if we're in the middle of processing
+	 * a notification.
+	 */
+	queue_remove(client->notify_list, notd);
+
+	if (__sync_sub_and_fetch(&notd->chrc->not_ref_count, 1)) {
+		notify_data_unref(notd);
+		return true;
+	}
+
+	notify_data_write_ccc(notd, false);
+
+	return true;
 }
-- 
2.1.0.rc2.206.gedb03e5

