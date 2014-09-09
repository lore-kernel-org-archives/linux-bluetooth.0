Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH BlueZ v1 4/7] shared/gatt-client: Handle incoming not/ind PDUs.
Date: Tue,  9 Sep 2014 10:04:06 -0700
Message-Id: <1410282249-22004-5-git-send-email-armansito@chromium.org>
In-Reply-To: <1410282249-22004-1-git-send-email-armansito@chromium.org>
References: <1410282249-22004-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

bt_gatt_client now registers an incoming PDU handler for notification and
indication PDUs. The PDU is parsed and routed to the notify handler registered
with bt_gatt_client_register_notify for the corresponding characteristic value
handle. A confirmation PDU is sent automatically for received indications.

This patch removes the bt_gatt_register function from shared/gatt-helpers.
---
 src/shared/gatt-client.c  | 120 ++++++++++++++++++++++++++++++++++++++++++----
 src/shared/gatt-helpers.c |  67 --------------------------
 src/shared/gatt-helpers.h |   9 ----
 3 files changed, 110 insertions(+), 86 deletions(-)

diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
index d68c8aa..d3c9225 100644
--- a/src/shared/gatt-client.c
+++ b/src/shared/gatt-client.c
@@ -97,6 +97,9 @@ struct bt_gatt_client {
 	/* List of registered notification/indication callbacks */
 	struct queue *notify_list;
 	int next_reg_id;
+	unsigned int notify_id, indic_id;
+	bool in_notify;
+	bool need_notify_cleanup;
 };
 
 static bool gatt_client_add_service(struct bt_gatt_client *client,
@@ -575,6 +578,7 @@ static bool gatt_client_init(struct bt_gatt_client *client, uint16_t mtu)
 
 struct notify_data {
 	struct bt_gatt_client *client;
+	bool removed;
 	unsigned int id;
 	int ref_count;
 	struct chrc_data *chrc;
@@ -612,6 +616,18 @@ static bool match_notify_data_id(const void *a, const void *b)
 	return notify_data->id == id;
 }
 
+static bool match_notify_data_removed(const void *a, const void *b)
+{
+	const struct notify_data *notify_data = a;
+
+	return notify_data->removed;
+}
+
+struct pdu_data {
+	const void *pdu;
+	uint16_t length;
+};
+
 static void complete_notify_request(void *data)
 {
 	struct notify_data *notify_data = data;
@@ -638,6 +654,7 @@ static bool notify_data_write_ccc(struct notify_data *notify_data, bool enable,
 {
 	uint8_t pdu[4];
 
+	assert(notify_data->chrc->ccc_handle);
 	memset(pdu, 0, sizeof(pdu));
 	put_le16(notify_data->chrc->ccc_handle, pdu);
 
@@ -733,6 +750,72 @@ static void disable_ccc_callback(uint8_t opcode, const void *pdu,
 	}
 }
 
+static void complete_unregister_notify(void *data)
+{
+	struct notify_data *notify_data = data;
+
+	if (__sync_sub_and_fetch(&notify_data->chrc->not_ref_count, 1)) {
+		notify_data_unref(notify_data);
+		return;
+	}
+
+	notify_data_write_ccc(notify_data, false, disable_ccc_callback);
+}
+
+static void notify_handler(void *data, void *user_data)
+{
+	struct notify_data *notify_data = data;
+	struct pdu_data *pdu_data = user_data;
+	uint16_t value_handle;
+	const uint8_t *value = NULL;
+
+	if (notify_data->removed)
+		return;
+
+	value_handle = get_le16(pdu_data->pdu);
+
+	if (notify_data->chrc->chrc_external.value_handle != value_handle)
+		return;
+
+	if (pdu_data->length > 2)
+		value = pdu_data->pdu + 2;
+
+	if (notify_data->notify)
+		notify_data->notify(value_handle, value, pdu_data->length - 2,
+							notify_data->user_data);
+}
+
+static void notify_cb(uint8_t opcode, const void *pdu, uint16_t length,
+								void *user_data)
+{
+	struct bt_gatt_client *client = user_data;
+	struct pdu_data pdu_data;
+
+	bt_gatt_client_ref(client);
+
+	client->in_notify = true;
+
+	memset(&pdu_data, 0, sizeof(pdu_data));
+	pdu_data.pdu = pdu;
+	pdu_data.length = length;
+
+	queue_foreach(client->notify_list, notify_handler, &pdu_data);
+
+	client->in_notify = false;
+
+	if (client->need_notify_cleanup) {
+		queue_remove_all(client->notify_list, match_notify_data_removed,
+					NULL, complete_unregister_notify);
+		client->need_notify_cleanup = false;
+	}
+
+	if (opcode == BT_ATT_OP_HANDLE_VAL_IND)
+		bt_att_send(client->att, BT_ATT_OP_HANDLE_VAL_CONF, NULL, 0,
+							NULL, NULL, NULL);
+
+	bt_gatt_client_unref(client);
+}
+
 struct bt_gatt_client *bt_gatt_client_new(struct bt_att *att, uint16_t mtu)
 {
 	struct bt_gatt_client *client;
@@ -757,6 +840,23 @@ struct bt_gatt_client *bt_gatt_client_new(struct bt_att *att, uint16_t mtu)
 		return NULL;
 	}
 
+	client->notify_id = bt_att_register(att, BT_ATT_OP_HANDLE_VAL_NOT,
+						notify_cb, client, NULL);
+	if (!client->notify_id) {
+		queue_destroy(client->long_write_queue, NULL);
+		free(client);
+		return NULL;
+	}
+
+	client->indic_id = bt_att_register(att, BT_ATT_OP_HANDLE_VAL_IND,
+						notify_cb, client, NULL);
+	if (!client->indic_id) {
+		bt_att_unregister(att, client->notify_id);
+		queue_destroy(client->long_write_queue, NULL);
+		free(client);
+		return NULL;
+	}
+
 	client->att = bt_att_ref(att);
 
 	gatt_client_init(client, mtu);
@@ -790,8 +890,12 @@ void bt_gatt_client_unref(struct bt_gatt_client *client)
 	if (client->debug_destroy)
 		client->debug_destroy(client->debug_data);
 
+	bt_att_unregister(client->att, client->notify_id);
+	bt_att_unregister(client->att, client->indic_id);
+
 	queue_destroy(client->long_write_queue, long_write_op_unref);
 	queue_destroy(client->notify_list, notify_data_unref);
+
 	bt_att_unref(client->att);
 	free(client);
 }
@@ -1698,23 +1802,19 @@ bool bt_gatt_client_unregister_notify(struct bt_gatt_client *client,
 
 	notify_data = queue_find(client->notify_list, match_notify_data_id,
 							UINT_TO_PTR(id));
-	if (!notify_data)
+	if (!notify_data || notify_data->removed)
 		return false;
 
 	assert(notify_data->chrc->not_ref_count > 0);
 	assert(!notify_data->chrc->ccc_write_id);
 
-	/* TODO: Delay destruction/removal if we're in the middle of processing
-	 * a notification.
-	 */
-	queue_remove(client->notify_list, notify_data);
-
-	if (__sync_sub_and_fetch(&notify_data->chrc->not_ref_count, 1)) {
-		notify_data_unref(notify_data);
+	if (!client->in_notify) {
+		queue_remove(client->notify_list, notify_data);
+		complete_unregister_notify(notify_data);
 		return true;
 	}
 
-	notify_data_write_ccc(notify_data, false, disable_ccc_callback);
-
+	notify_data->removed = true;
+	client->need_notify_cleanup = true;
 	return true;
 }
diff --git a/src/shared/gatt-helpers.c b/src/shared/gatt-helpers.c
index ede6a67..54876bc 100644
--- a/src/shared/gatt-helpers.c
+++ b/src/shared/gatt-helpers.c
@@ -911,70 +911,3 @@ bool bt_gatt_discover_descriptors(struct bt_att *att,
 
 	return true;
 }
-
-struct notify_data {
-	struct bt_att *att;
-	bt_gatt_notify_callback_t callback;
-	void *user_data;
-	bt_gatt_destroy_func_t destroy;
-};
-
-static void notify_data_destroy(void *data)
-{
-	struct notify_data *notd = data;
-
-	if (notd->destroy)
-		notd->destroy(notd->user_data);
-
-	free(notd);
-}
-
-static void notify_cb(uint8_t opcode, const void *pdu, uint16_t length,
-								void *user_data)
-{
-	struct notify_data *data = user_data;
-	uint16_t value_handle;
-	const uint8_t *value = NULL;
-
-	value_handle = get_le16(pdu);
-
-	if (length > 2)
-		value = pdu + 2;
-
-	if (data->callback)
-		data->callback(value_handle, value, length - 2, data->user_data);
-
-	if (opcode == BT_ATT_OP_HANDLE_VAL_IND)
-		bt_att_send(data->att, BT_ATT_OP_HANDLE_VAL_CONF, NULL, 0,
-							NULL, NULL, NULL);
-}
-
-unsigned int bt_gatt_register(struct bt_att *att, bool indications,
-					bt_gatt_notify_callback_t callback,
-					void *user_data,
-					bt_gatt_destroy_func_t destroy)
-{
-	struct notify_data *data;
-	uint8_t opcode;
-	unsigned int id;
-
-	if (!att)
-		return 0;
-
-	data = new0(struct notify_data, 1);
-	if (!data)
-		return 0;
-
-	data->att = att;
-	data->callback = callback;
-	data->user_data = user_data;
-	data->destroy = destroy;
-
-	opcode = indications ? BT_ATT_OP_HANDLE_VAL_IND : BT_ATT_OP_HANDLE_VAL_NOT;
-
-	id = bt_att_register(att, opcode, notify_cb, data, notify_data_destroy);
-	if (!id)
-		free(data);
-
-	return id;
-}
diff --git a/src/shared/gatt-helpers.h b/src/shared/gatt-helpers.h
index 75ad4b0..c4a6578 100644
--- a/src/shared/gatt-helpers.h
+++ b/src/shared/gatt-helpers.h
@@ -58,10 +58,6 @@ typedef void (*bt_gatt_discovery_callback_t)(bool success, uint8_t att_ecode,
 						struct bt_gatt_result *result,
 						void *user_data);
 
-typedef void (*bt_gatt_notify_callback_t)(uint16_t value_handle,
-					const uint8_t *value, uint16_t length,
-					void *user_data);
-
 bool bt_gatt_exchange_mtu(struct bt_att *att, uint16_t client_rx_mtu,
 					bt_gatt_result_callback_t callback,
 					void *user_data,
@@ -87,8 +83,3 @@ bool bt_gatt_discover_descriptors(struct bt_att *att,
 					bt_gatt_discovery_callback_t callback,
 					void *user_data,
 					bt_gatt_destroy_func_t destroy);
-
-unsigned int bt_gatt_register(struct bt_att *att, bool indications,
-					bt_gatt_notify_callback_t callback,
-					void *user_data,
-					bt_gatt_destroy_func_t destroy);
-- 
2.1.0.rc2.206.gedb03e5

