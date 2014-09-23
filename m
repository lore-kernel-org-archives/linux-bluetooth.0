Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH BlueZ 4/9] shared/gatt-client: Remove effected services from cache on Service Changed.
Date: Tue, 23 Sep 2014 13:47:12 -0700
Message-Id: <1411505237-10932-5-git-send-email-armansito@chromium.org>
In-Reply-To: <1411505237-10932-1-git-send-email-armansito@chromium.org>
References: <1411505237-10932-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch implements the first step of handling "Service Changed", which
involves removing all effected services from the internal list of services and
removing all registered notify handlers that have a handle on a characteristic
within the effected handle range.
---
 src/shared/gatt-client.c | 245 +++++++++++++++++++++++++++++++++++++----------
 1 file changed, 194 insertions(+), 51 deletions(-)

diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
index 1a6fd86..cc0a894 100644
--- a/src/shared/gatt-client.c
+++ b/src/shared/gatt-client.c
@@ -111,8 +111,91 @@ struct bt_gatt_client {
 	uint16_t gatt_svc_handle;
 	uint16_t svc_chngd_val_handle;
 	unsigned int svc_chngd_ind_id;
+	struct queue *svc_chngd_queue;  /* Queued service changed events */
+	bool in_svc_chngd;
 };
 
+struct notify_data {
+	struct bt_gatt_client *client;
+	bool removed;
+	bool invalid;
+	unsigned int id;
+	int ref_count;
+	struct chrc_data *chrc;
+	bt_gatt_client_notify_id_callback_t callback;
+	bt_gatt_client_notify_callback_t notify;
+	void *user_data;
+	bt_gatt_client_destroy_func_t destroy;
+};
+
+static struct notify_data *notify_data_ref(struct notify_data *notify_data)
+{
+	__sync_fetch_and_add(&notify_data->ref_count, 1);
+
+	return notify_data;
+}
+
+static void notify_data_unref(void *data)
+{
+	struct notify_data *notify_data = data;
+
+	if (__sync_sub_and_fetch(&notify_data->ref_count, 1))
+		return;
+
+	if (notify_data->destroy)
+		notify_data->destroy(notify_data->user_data);
+
+	free(notify_data);
+}
+
+static bool match_notify_data_id(const void *a, const void *b)
+{
+	const struct notify_data *notify_data = a;
+	unsigned int id = PTR_TO_UINT(b);
+
+	return notify_data->id == id;
+}
+
+static bool match_notify_data_removed(const void *a, const void *b)
+{
+	const struct notify_data *notify_data = a;
+
+	return notify_data->removed;
+}
+
+static bool match_notify_data_invalid(const void *a, const void *b)
+{
+	const struct notify_data *notify_data = a;
+
+	return notify_data->invalid;
+}
+
+struct handle_range {
+	uint16_t start;
+	uint16_t end;
+};
+
+static bool match_notify_data_handle_range(const void *a, const void *b)
+{
+	const struct notify_data *notify_data = a;
+	bt_gatt_characteristic_t *chrc = &notify_data->chrc->chrc_external;
+	const struct handle_range *range = b;
+
+	return chrc->value_handle >= range->start &&
+					chrc->value_handle <= range->end;
+}
+
+static void mark_notify_data_invalid_if_in_range(void *data, void *user_data)
+{
+	struct notify_data *notify_data = data;
+	bt_gatt_characteristic_t *chrc = &notify_data->chrc->chrc_external;
+	struct handle_range *range = user_data;
+
+	if (chrc->value_handle >= range->start &&
+					chrc->value_handle <= range->end)
+		notify_data->invalid = true;
+}
+
 static bool service_list_add_service(struct service_list **head,
 						struct service_list **tail,
 						uint16_t start, uint16_t end,
@@ -138,8 +221,6 @@ static bool service_list_add_service(struct service_list **head,
 	return true;
 }
 
-static void notify_data_unref(void *data);
-
 static void service_destroy_characteristics(struct service_list *service)
 {
 	unsigned int i;
@@ -173,8 +254,66 @@ static void service_list_clear(struct service_list **head,
 	*head = *tail = NULL;
 }
 
+static void service_list_clear_range(struct service_list **head,
+						struct service_list **tail,
+						uint16_t start, uint16_t end)
+{
+	struct service_list *cur, *prev, *tmp;
+
+	if (!(*head) || !(*tail))
+		return;
+
+	prev = NULL;
+	cur = *head;
+	while (cur) {
+		if (cur->service.end_handle < start ||
+					cur->service.start_handle > end) {
+			prev = cur;
+			cur = cur->next;
+			continue;
+		}
+
+		service_destroy_characteristics(cur);
+
+		if (!prev)
+			*head = cur->next;
+		else
+			prev->next = cur->next;
+
+		if (*tail == cur)
+			*tail = prev;
+
+		tmp = cur;
+		cur = cur->next;
+		free(tmp);
+	}
+}
+
+static void gatt_client_remove_all_notify_in_range(
+				struct bt_gatt_client *client,
+				uint16_t start_handle, uint16_t end_handle)
+{
+	struct handle_range range;
+
+	range.start = start_handle;
+	range.end = end_handle;
+
+	if (client->in_notify) {
+		queue_foreach(client->notify_list,
+					mark_notify_data_invalid_if_in_range,
+					&range);
+		client->need_notify_cleanup = true;
+		return;
+	}
+
+	queue_remove_all(client->notify_list, match_notify_data_handle_range,
+						&range, notify_data_unref);
+}
+
 static void gatt_client_clear_services(struct bt_gatt_client *client)
 {
+
+	gatt_client_remove_all_notify_in_range(client, 0x0001, 0xffff);
 	service_list_clear(&client->svc_head, &client->svc_tail);
 }
 
@@ -562,10 +701,37 @@ static void exchange_mtu_cb(bool success, uint8_t att_ecode, void *user_data)
 	discovery_op_unref(op);
 }
 
+struct service_changed_op {
+	struct bt_gatt_client *client;
+	uint16_t start_handle;
+	uint16_t end_handle;
+};
+
+static void process_service_changed(struct bt_gatt_client *client,
+							uint16_t start_handle,
+							uint16_t end_handle)
+{
+	/* Invalidate and remove all effected notify callbacks */
+	gatt_client_remove_all_notify_in_range(client, start_handle,
+								end_handle);
+
+	/* Remove all services that overlap the modified range since we'll
+	 * rediscover them
+	 */
+	service_list_clear_range(&client->svc_head, &client->svc_tail,
+						start_handle, end_handle);
+
+	/* TODO Rediscover all services within the modified service range. If
+	 * the GATT service was effected, then register a new handler for
+	 * "Service Changed"
+	 */
+}
+
 static void service_changed_cb(uint16_t value_handle, const uint8_t *value,
 					uint16_t length, void *user_data)
 {
 	struct bt_gatt_client *client = user_data;
+	struct service_changed_op *op;
 	uint16_t start, end;
 
 	if (value_handle != client->svc_chngd_val_handle || length != 4)
@@ -578,7 +744,16 @@ static void service_changed_cb(uint16_t value_handle, const uint8_t *value,
 			"Service Changed received - start: 0x%04x end: 0x%04x",
 			start, end);
 
-	/* TODO: Process changed services */
+	if (!client->in_svc_chngd) {
+		process_service_changed(client, start, end);
+		return;
+	}
+
+	op = new0(struct service_changed_op, 1);
+	if (!op)
+		return;
+
+	queue_push_tail(client->svc_chngd_queue, op);
 }
 
 static void service_changed_register_cb(unsigned int id, uint16_t att_ecode,
@@ -685,53 +860,6 @@ static bool gatt_client_init(struct bt_gatt_client *client, uint16_t mtu)
 	return true;
 }
 
-struct notify_data {
-	struct bt_gatt_client *client;
-	bool removed;
-	unsigned int id;
-	int ref_count;
-	struct chrc_data *chrc;
-	bt_gatt_client_notify_id_callback_t callback;
-	bt_gatt_client_notify_callback_t notify;
-	void *user_data;
-	bt_gatt_client_destroy_func_t destroy;
-};
-
-static struct notify_data *notify_data_ref(struct notify_data *notify_data)
-{
-	__sync_fetch_and_add(&notify_data->ref_count, 1);
-
-	return notify_data;
-}
-
-static void notify_data_unref(void *data)
-{
-	struct notify_data *notify_data = data;
-
-	if (__sync_sub_and_fetch(&notify_data->ref_count, 1))
-		return;
-
-	if (notify_data->destroy)
-		notify_data->destroy(notify_data->user_data);
-
-	free(notify_data);
-}
-
-static bool match_notify_data_id(const void *a, const void *b)
-{
-	const struct notify_data *notify_data = a;
-	unsigned int id = PTR_TO_UINT(b);
-
-	return notify_data->id == id;
-}
-
-static bool match_notify_data_removed(const void *a, const void *b)
-{
-	const struct notify_data *notify_data = a;
-
-	return notify_data->removed;
-}
-
 struct pdu_data {
 	const void *pdu;
 	uint16_t length;
@@ -913,6 +1041,8 @@ static void notify_cb(uint8_t opcode, const void *pdu, uint16_t length,
 	client->in_notify = false;
 
 	if (client->need_notify_cleanup) {
+		queue_remove_all(client->notify_list, match_notify_data_invalid,
+						NULL, notify_data_unref);
 		queue_remove_all(client->notify_list, match_notify_data_removed,
 					NULL, complete_unregister_notify);
 		client->need_notify_cleanup = false;
@@ -942,8 +1072,16 @@ struct bt_gatt_client *bt_gatt_client_new(struct bt_att *att, uint16_t mtu)
 		return NULL;
 	}
 
+	client->svc_chngd_queue = queue_new();
+	if (!client->svc_chngd_queue) {
+		queue_destroy(client->long_write_queue, NULL);
+		free(client);
+		return NULL;
+	}
+
 	client->notify_list = queue_new();
 	if (!client->notify_list) {
+		queue_destroy(client->svc_chngd_queue, NULL);
 		queue_destroy(client->long_write_queue, NULL);
 		free(client);
 		return NULL;
@@ -952,6 +1090,8 @@ struct bt_gatt_client *bt_gatt_client_new(struct bt_att *att, uint16_t mtu)
 	client->notify_id = bt_att_register(att, BT_ATT_OP_HANDLE_VAL_NOT,
 						notify_cb, client, NULL);
 	if (!client->notify_id) {
+		queue_destroy(client->notify_list, NULL);
+		queue_destroy(client->svc_chngd_queue, NULL);
 		queue_destroy(client->long_write_queue, NULL);
 		free(client);
 		return NULL;
@@ -961,6 +1101,8 @@ struct bt_gatt_client *bt_gatt_client_new(struct bt_att *att, uint16_t mtu)
 						notify_cb, client, NULL);
 	if (!client->ind_id) {
 		bt_att_unregister(att, client->notify_id);
+		queue_destroy(client->notify_list, NULL);
+		queue_destroy(client->svc_chngd_queue, NULL);
 		queue_destroy(client->long_write_queue, NULL);
 		free(client);
 		return NULL;
@@ -1002,6 +1144,7 @@ void bt_gatt_client_unref(struct bt_gatt_client *client)
 	bt_att_unregister(client->att, client->notify_id);
 	bt_att_unregister(client->att, client->ind_id);
 
+	queue_destroy(client->svc_chngd_queue, free);
 	queue_destroy(client->long_write_queue, long_write_op_unref);
 	queue_destroy(client->notify_list, notify_data_unref);
 
@@ -1057,7 +1200,7 @@ bool bt_gatt_service_iter_init(struct bt_gatt_service_iter *iter,
 	if (!iter || !client)
 		return false;
 
-	if (client->in_init)
+	if (client->in_init || client->in_svc_chngd)
 		return false;
 
 	memset(iter, 0, sizeof(*iter));
-- 
2.1.0.rc2.206.gedb03e5

