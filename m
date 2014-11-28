Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH BlueZ 4/8] shared/gatt-client: Use gatt_db in bt_gatt_register_notify
Date: Fri, 28 Nov 2014 09:49:18 -0800
Message-Id: <1417196962-3876-5-git-send-email-armansito@chromium.org>
In-Reply-To: <1417196962-3876-1-git-send-email-armansito@chromium.org>
References: <1417196962-3876-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch rewrites the notification/indication logic in gatt-client to
use the internal gatt-db.
---
 src/shared/gatt-client.c | 203 ++++++++++++++++++++++++++++++++++-------------
 1 file changed, 147 insertions(+), 56 deletions(-)

diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
index 2dc6735..a26f43a 100644
--- a/src/shared/gatt-client.c
+++ b/src/shared/gatt-client.c
@@ -45,27 +45,6 @@
 #define GATT_SVC_UUID	0x1801
 #define SVC_CHNGD_UUID	0x2a05
 
-struct chrc_data {
-	/* The public characteristic entry. */
-	bt_gatt_characteristic_t chrc_external;
-
-	/* The private entries. */
-	uint16_t ccc_handle;
-	int notify_count;  /* Reference count of registered notify callbacks */
-
-	/* Internal non-const pointer to the descriptor array. We use this
-	 * internally to modify/free the array, while we expose it externally
-	 * using the const pointer "descs" field in bt_gatt_characteristic_t.
-	 */
-	bt_gatt_descriptor_t *descs;
-
-	/* Pending calls to register_notify are queued here so that they can be
-	 * processed after a write that modifies the CCC descriptor.
-	 */
-	struct queue *reg_notify_queue;
-	unsigned int ccc_write_id;
-};
-
 struct bt_gatt_client {
 	struct bt_att *att;
 	int ref_count;
@@ -97,6 +76,7 @@ struct bt_gatt_client {
 
 	/* List of registered disconnect/notification/indication callbacks */
 	struct queue *notify_list;
+	struct queue *notify_chrcs;
 	int next_reg_id;
 	unsigned int disc_id, notify_id, ind_id;
 	bool in_notify;
@@ -111,13 +91,26 @@ struct bt_gatt_client {
 	bool in_svc_chngd;
 };
 
+struct notify_chrc {
+	uint16_t value_handle;
+	uint16_t ccc_handle;
+	uint16_t properties;
+	int notify_count;  /* Reference count of registered notify callbacks */
+
+	/* Pending calls to register_notify are queued here so that they can be
+	 * processed after a write that modifies the CCC descriptor.
+	 */
+	struct queue *reg_notify_queue;
+	unsigned int ccc_write_id;
+};
+
 struct notify_data {
 	struct bt_gatt_client *client;
 	bool removed;
 	bool invalid;
 	unsigned int id;
 	int ref_count;
-	struct chrc_data *chrc;
+	struct notify_chrc *chrc;
 	bt_gatt_client_notify_id_callback_t callback;
 	bt_gatt_client_notify_callback_t notify;
 	void *user_data;
@@ -144,6 +137,76 @@ static void notify_data_unref(void *data)
 	free(notify_data);
 }
 
+static void find_ccc(struct gatt_db_attribute *attr, void *user_data)
+{
+	struct gatt_db_attribute **ccc_ptr = user_data;
+	bt_uuid_t uuid;
+
+	if (*ccc_ptr)
+		return;
+
+	bt_uuid16_create(&uuid, GATT_CLIENT_CHARAC_CFG_UUID);
+
+	if (bt_uuid_cmp(&uuid, gatt_db_attribute_get_type(attr)))
+		return;
+
+	*ccc_ptr = attr;
+}
+
+static struct notify_chrc *notify_chrc_create(struct bt_gatt_client *client,
+							uint16_t value_handle)
+{
+	struct gatt_db_attribute *attr, *ccc;
+	struct notify_chrc *chrc;
+	bt_uuid_t uuid;
+	uint8_t properties;
+
+	/* Check that chrc_value_handle belongs to a known characteristic */
+	attr = gatt_db_get_attribute(client->db, value_handle - 1);
+	if (!attr)
+		return NULL;
+
+	bt_uuid16_create(&uuid, GATT_CHARAC_UUID);
+	if (bt_uuid_cmp(&uuid, gatt_db_attribute_get_type(attr)))
+		return NULL;
+
+	if (!gatt_db_attribute_get_char_data(attr, NULL, NULL,
+							&properties, NULL))
+			return NULL;
+
+	/* Find the CCC characteristic */
+	ccc = NULL;
+	gatt_db_service_foreach_desc(attr, find_ccc, &ccc);
+	if (!ccc)
+		return NULL;
+
+	chrc = new0(struct notify_chrc, 1);
+	if (!chrc)
+		return NULL;
+
+	chrc->reg_notify_queue = queue_new();
+	if (!chrc->reg_notify_queue) {
+		free(chrc);
+		return NULL;
+	}
+
+	chrc->value_handle = value_handle;
+	chrc->ccc_handle = gatt_db_attribute_get_handle(ccc);
+	chrc->properties = properties;
+
+	queue_push_tail(client->notify_chrcs, chrc);
+
+	return chrc;
+}
+
+static void notify_chrc_free(void *data)
+{
+	struct notify_chrc *chrc = data;
+
+	queue_destroy(chrc->reg_notify_queue, notify_data_unref);
+	free(chrc);
+}
+
 static bool match_notify_data_id(const void *a, const void *b)
 {
 	const struct notify_data *notify_data = a;
@@ -174,7 +237,7 @@ struct handle_range {
 static bool match_notify_data_handle_range(const void *a, const void *b)
 {
 	const struct notify_data *notify_data = a;
-	bt_gatt_characteristic_t *chrc = &notify_data->chrc->chrc_external;
+	struct notify_chrc *chrc = notify_data->chrc;
 	const struct handle_range *range = b;
 
 	return chrc->value_handle >= range->start &&
@@ -184,7 +247,7 @@ static bool match_notify_data_handle_range(const void *a, const void *b)
 static void mark_notify_data_invalid_if_in_range(void *data, void *user_data)
 {
 	struct notify_data *notify_data = data;
-	bt_gatt_characteristic_t *chrc = &notify_data->chrc->chrc_external;
+	struct notify_chrc *chrc = notify_data->chrc;
 	struct handle_range *range = user_data;
 
 	if (chrc->value_handle >= range->start &&
@@ -192,6 +255,15 @@ static void mark_notify_data_invalid_if_in_range(void *data, void *user_data)
 		notify_data->invalid = true;
 }
 
+static bool match_notify_chrc_handle_range(const void *a, const void *b)
+{
+	const struct notify_chrc *chrc = a;
+	const struct handle_range *range = b;
+
+	return chrc->value_handle >= range->start &&
+					chrc->value_handle <= range->end;
+}
+
 static void gatt_client_remove_all_notify_in_range(
 				struct bt_gatt_client *client,
 				uint16_t start_handle, uint16_t end_handle)
@@ -213,6 +285,19 @@ static void gatt_client_remove_all_notify_in_range(
 						&range, notify_data_unref);
 }
 
+static void gatt_client_remove_notify_chrcs_in_range(
+				struct bt_gatt_client *client,
+				uint16_t start_handle, uint16_t end_handle)
+{
+	struct handle_range range;
+
+	range.start = start_handle;
+	range.end = end_handle;
+
+	queue_remove_all(client->notify_chrcs, match_notify_chrc_handle_range,
+						&range, notify_chrc_free);
+}
+
 struct discovery_op;
 
 typedef void (*discovery_op_complete_func_t)(struct discovery_op *op,
@@ -988,6 +1073,8 @@ static void process_service_changed(struct bt_gatt_client *client,
 	/* Invalidate and remove all effected notify callbacks */
 	gatt_client_remove_all_notify_in_range(client, start_handle,
 								end_handle);
+	gatt_client_remove_notify_chrcs_in_range(client, start_handle,
+								end_handle);
 
 	/* Remove all services that overlap the modified range since we'll
 	 * rediscover them
@@ -1206,12 +1293,10 @@ static bool notify_data_write_ccc(struct notify_data *notify_data, bool enable,
 		/* Try to enable notifications and/or indications based on
 		 * whatever the characteristic supports.
 		 */
-		if (notify_data->chrc->chrc_external.properties &
-						BT_GATT_CHRC_PROP_NOTIFY)
+		if (notify_data->chrc->properties & BT_GATT_CHRC_PROP_NOTIFY)
 			pdu[2] = 0x01;
 
-		if (notify_data->chrc->chrc_external.properties &
-						BT_GATT_CHRC_PROP_INDICATE)
+		if (notify_data->chrc->properties & BT_GATT_CHRC_PROP_INDICATE)
 			pdu[2] |= 0x02;
 
 		if (!pdu[2])
@@ -1322,7 +1407,7 @@ static void notify_handler(void *data, void *user_data)
 
 	value_handle = get_le16(pdu_data->pdu);
 
-	if (notify_data->chrc->chrc_external.value_handle != value_handle)
+	if (notify_data->chrc->value_handle != value_handle)
 		return;
 
 	if (pdu_data->length > 2)
@@ -1389,6 +1474,7 @@ static void bt_gatt_client_free(struct bt_gatt_client *client)
 	queue_destroy(client->svc_chngd_queue, free);
 	queue_destroy(client->long_write_queue, long_write_op_unref);
 	queue_destroy(client->notify_list, notify_data_unref);
+	queue_destroy(client->notify_chrcs, notify_chrc_free);
 
 	free(client);
 }
@@ -1438,6 +1524,10 @@ struct bt_gatt_client *bt_gatt_client_new(struct bt_att *att, uint16_t mtu)
 	if (!client->notify_list)
 		goto fail;
 
+	client->notify_chrcs = queue_new();
+	if (!client->notify_chrcs)
+		goto fail;
+
 	client->notify_id = bt_att_register(att, BT_ATT_OP_HANDLE_VAL_NOT,
 						notify_cb, client, NULL);
 	if (!client->notify_id)
@@ -2379,6 +2469,14 @@ bool bt_gatt_client_write_long_value(struct bt_gatt_client *client,
 	return true;
 }
 
+static bool match_notify_chrc_value_handle(const void *a, const void *b)
+{
+	const struct notify_chrc *chrc = a;
+	uint16_t value_handle = PTR_TO_UINT(b);
+
+	return chrc->value_handle == value_handle;
+}
+
 bool bt_gatt_client_register_notify(struct bt_gatt_client *client,
 				uint16_t chrc_value_handle,
 				bt_gatt_client_notify_id_callback_t callback,
@@ -2387,40 +2485,31 @@ bool bt_gatt_client_register_notify(struct bt_gatt_client *client,
 				bt_gatt_client_destroy_func_t destroy)
 {
 	struct notify_data *notify_data;
-	struct service_list *svc_data = NULL;
-	struct chrc_data *chrc = NULL;
-	struct bt_gatt_service_iter iter;
-	const bt_gatt_service_t *service;
+	struct notify_chrc *chrc = NULL;
 
-	if (!client || !chrc_value_handle || !callback)
+	if (!client || !client->db || !chrc_value_handle || !callback)
 		return false;
 
 	if (!bt_gatt_client_is_ready(client) || client->in_svc_chngd)
 		return false;
 
-	/* Check that chrc_value_handle belongs to a known characteristic */
-	if (!bt_gatt_service_iter_init(&iter, client))
-		return false;
+	/* Check if a characteristic ref count has been started already */
+	chrc = queue_find(client->notify_chrcs, match_notify_chrc_value_handle,
+						UINT_TO_PTR(chrc_value_handle));
 
-	while (bt_gatt_service_iter_next(&iter, &service)) {
-		if (chrc_value_handle >= service->start_handle &&
-				chrc_value_handle <= service->end_handle) {
-			svc_data = (void *) service;
-			break;
-		}
-	}
-
-	if (!svc_data)
-		return false;
+	if (!chrc) {
+		/*
+		 * Create an entry if the characteristic is known and has a CCC
+		 * descriptor.
+		 */
+		chrc = notify_chrc_create(client, chrc_value_handle);
+		if (!chrc)
+			return false;
 
-	/*
-	 * TODO: Lookup characteristic and CCC in database. Add entries for each
-	 * characteristic to a list on demand.
-	 */
-	return false;
+	}
 
-	/* Check that the characteristic supports notifications/indications */
-	if (!chrc || !chrc->ccc_handle || chrc->notify_count == INT_MAX)
+	/* Fail if we've hit the maximum allowed notify sessions */
+	if (chrc->notify_count == INT_MAX)
 		return false;
 
 	notify_data = new0(struct notify_data, 1);
@@ -2435,7 +2524,8 @@ bool bt_gatt_client_register_notify(struct bt_gatt_client *client,
 	notify_data->user_data = user_data;
 	notify_data->destroy = destroy;
 
-	/* If a write to the CCC descriptor is in progress, then queue this
+	/*
+	 * If a write to the CCC descriptor is in progress, then queue this
 	 * request.
 	 */
 	if (chrc->ccc_write_id) {
@@ -2443,7 +2533,8 @@ bool bt_gatt_client_register_notify(struct bt_gatt_client *client,
 		return true;
 	}
 
-	/* If the ref count is not zero, then notifications are already enabled.
+	/*
+	 * If the ref count is not zero, then notifications are already enabled.
 	 */
 	if (chrc->notify_count > 0) {
 		complete_notify_request(notify_data);
-- 
2.2.0.rc0.207.ga3a616c

