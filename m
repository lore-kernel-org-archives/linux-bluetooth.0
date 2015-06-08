Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/4] shared/gatt-client: Consolidate service changed registration
Date: Mon,  8 Jun 2015 16:35:43 +0300
Message-Id: <1433770545-14938-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1433770545-14938-1-git-send-email-luiz.dentz@gmail.com>
References: <1433770545-14938-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This rework the code using service changed registration so it becomes
reusable by different part of code.
---
 src/shared/gatt-client.c | 495 +++++++++++++++++++++++------------------------
 1 file changed, 239 insertions(+), 256 deletions(-)

diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
index feb30f6..ee3f984 100644
--- a/src/shared/gatt-client.c
+++ b/src/shared/gatt-client.c
@@ -1085,28 +1085,193 @@ struct service_changed_op {
 	uint16_t end_handle;
 };
 
-static void service_changed_reregister_cb(uint16_t att_ecode, void *user_data)
+static void process_service_changed(struct bt_gatt_client *client,
+							uint16_t start_handle,
+							uint16_t end_handle);
+static void service_changed_cb(uint16_t value_handle, const uint8_t *value,
+					uint16_t length, void *user_data);
+
+static void complete_notify_request(void *data)
 {
-	struct bt_gatt_client *client = user_data;
+	struct notify_data *notify_data = data;
+
+	/* Increment the per-characteristic ref count of notify handlers */
+	__sync_fetch_and_add(&notify_data->chrc->notify_count, 1);
+
+	notify_data->att_id = 0;
+	notify_data->callback(0, notify_data->user_data);
+}
+
+static bool notify_data_write_ccc(struct notify_data *notify_data, bool enable,
+						bt_att_response_func_t callback)
+{
+	uint8_t pdu[4];
+	unsigned int att_id;
+
+	assert(notify_data->chrc->ccc_handle);
+	memset(pdu, 0, sizeof(pdu));
+	put_le16(notify_data->chrc->ccc_handle, pdu);
+
+	if (enable) {
+		/* Try to enable notifications and/or indications based on
+		 * whatever the characteristic supports.
+		 */
+		if (notify_data->chrc->properties & BT_GATT_CHRC_PROP_NOTIFY)
+			pdu[2] = 0x01;
+
+		if (notify_data->chrc->properties & BT_GATT_CHRC_PROP_INDICATE)
+			pdu[2] |= 0x02;
+
+		if (!pdu[2])
+			return false;
+	}
+
+	att_id = bt_att_send(notify_data->client->att, BT_ATT_OP_WRITE_REQ,
+						pdu, sizeof(pdu), callback,
+						notify_data_ref(notify_data),
+						notify_data_unref);
+	notify_data->chrc->ccc_write_id = notify_data->att_id = att_id;
+
+	return !!att_id;
+}
+
+static uint8_t process_error(const void *pdu, uint16_t length)
+{
+	const struct bt_att_pdu_error_rsp *error_pdu;
+
+	if (!pdu || length != sizeof(struct bt_att_pdu_error_rsp))
+		return 0;
+
+	error_pdu = pdu;
+
+	return error_pdu->ecode;
+}
+
+static void enable_ccc_callback(uint8_t opcode, const void *pdu,
+					uint16_t length, void *user_data)
+{
+	struct notify_data *notify_data = user_data;
+	uint16_t att_ecode;
+
+	assert(!notify_data->chrc->notify_count);
+	assert(notify_data->chrc->ccc_write_id);
+
+	notify_data->chrc->ccc_write_id = 0;
+
+	if (opcode == BT_ATT_OP_ERROR_RSP) {
+		att_ecode = process_error(pdu, length);
+
+		/* Failed to enable. Complete the current request and move on to
+		 * the next one in the queue. If there was an error sending the
+		 * write request, then just move on to the next queued entry.
+		 */
+		queue_remove(notify_data->client->notify_list, notify_data);
+		notify_data->callback(att_ecode, notify_data->user_data);
+
+		while ((notify_data = queue_pop_head(
+					notify_data->chrc->reg_notify_queue))) {
+
+			if (notify_data_write_ccc(notify_data, true,
+							enable_ccc_callback))
+				return;
+		}
 
-	if (!att_ecode) {
-		util_debug(client->debug_callback, client->debug_data,
-			"Re-registered handler for \"Service Changed\" after "
-			"change in GATT service");
-		client->svc_chngd_registered = true;
 		return;
 	}
 
-	util_debug(client->debug_callback, client->debug_data,
-		"Failed to register handler for \"Service Changed\"");
-	client->svc_chngd_ind_id = 0;
+	/* Success! Report success for all remaining requests. */
+	bt_gatt_client_ref(notify_data->client);
+
+	complete_notify_request(notify_data);
+	queue_remove_all(notify_data->chrc->reg_notify_queue, NULL, NULL,
+						complete_notify_request);
+
+	bt_gatt_client_unref(notify_data->client);
 }
 
-static void process_service_changed(struct bt_gatt_client *client,
-							uint16_t start_handle,
-							uint16_t end_handle);
-static void service_changed_cb(uint16_t value_handle, const uint8_t *value,
-					uint16_t length, void *user_data);
+static bool match_notify_chrc_value_handle(const void *a, const void *b)
+{
+	const struct notify_chrc *chrc = a;
+	uint16_t value_handle = PTR_TO_UINT(b);
+
+	return chrc->value_handle == value_handle;
+}
+
+static unsigned int register_notify(struct bt_gatt_client *client,
+				uint16_t handle,
+				bt_gatt_client_register_callback_t callback,
+				bt_gatt_client_notify_callback_t notify,
+				void *user_data,
+				bt_gatt_client_destroy_func_t destroy)
+{
+	struct notify_data *notify_data;
+	struct notify_chrc *chrc = NULL;
+
+	/* Check if a characteristic ref count has been started already */
+	chrc = queue_find(client->notify_chrcs, match_notify_chrc_value_handle,
+						UINT_TO_PTR(handle));
+
+	if (!chrc) {
+		/*
+		 * Create an entry if the characteristic is known and has a CCC
+		 * descriptor.
+		 */
+		chrc = notify_chrc_create(client, handle);
+		if (!chrc)
+			return 0;
+	}
+
+	/* Fail if we've hit the maximum allowed notify sessions */
+	if (chrc->notify_count == INT_MAX)
+		return 0;
+
+	notify_data = new0(struct notify_data, 1);
+	if (!notify_data)
+		return 0;
+
+	notify_data->client = client;
+	notify_data->ref_count = 1;
+	notify_data->chrc = chrc;
+	notify_data->callback = callback;
+	notify_data->notify = notify;
+	notify_data->user_data = user_data;
+	notify_data->destroy = destroy;
+
+	/* Add the handler to the bt_gatt_client's general list */
+	queue_push_tail(client->notify_list, notify_data);
+
+	/* Assign an ID to the handler. */
+	if (client->next_reg_id < 1)
+		client->next_reg_id = 1;
+
+	notify_data->id = client->next_reg_id++;
+
+	/*
+	 * If a write to the CCC descriptor is in progress, then queue this
+	 * request.
+	 */
+	if (chrc->ccc_write_id) {
+		queue_push_tail(chrc->reg_notify_queue, notify_data);
+		return notify_data->id;
+	}
+
+	/*
+	 * If the ref count is not zero, then notifications are already enabled.
+	 */
+	if (chrc->notify_count > 0 || !chrc->ccc_handle) {
+		complete_notify_request(notify_data);
+		return notify_data->id;
+	}
+
+	/* Write to the CCC descriptor */
+	if (!notify_data_write_ccc(notify_data, true, enable_ccc_callback)) {
+		queue_remove(client->notify_list, notify_data);
+		free(notify_data);
+		return 0;
+	}
+
+	return notify_data->id;
+}
 
 static void get_first_attribute(struct gatt_db_attribute *attrib,
 								void *user_data)
@@ -1119,6 +1284,61 @@ static void get_first_attribute(struct gatt_db_attribute *attrib,
 	*stored = attrib;
 }
 
+static void service_changed_register_cb(uint16_t att_ecode, void *user_data)
+{
+	bool success;
+	struct bt_gatt_client *client = user_data;
+
+	if (att_ecode) {
+		util_debug(client->debug_callback, client->debug_data,
+			"Failed to register handler for \"Service Changed\"");
+		success = false;
+		client->svc_chngd_ind_id = 0;
+		goto done;
+	}
+
+	client->svc_chngd_registered = true;
+	success = true;
+	util_debug(client->debug_callback, client->debug_data,
+			"Registered handler for \"Service Changed\": %u",
+			client->svc_chngd_ind_id);
+
+done:
+	if (!client->ready) {
+		client->ready = success;
+		notify_client_ready(client, success, att_ecode);
+	}
+}
+
+static bool register_service_changed(struct bt_gatt_client *client)
+{
+	bt_uuid_t uuid;
+	struct gatt_db_attribute *attr = NULL;
+
+	bt_uuid16_create(&uuid, SVC_CHNGD_UUID);
+
+	if (client->svc_chngd_ind_id)
+		return true;
+
+	gatt_db_find_by_type(client->db, 0x0001, 0xffff, &uuid,
+						get_first_attribute, &attr);
+	if (!attr)
+		return true;
+
+	/*
+	 * Register an indication handler for the "Service Changed"
+	 * characteristic and report ready only if the handler is registered
+	 * successfully.
+	 */
+	client->svc_chngd_ind_id = register_notify(client,
+					gatt_db_attribute_get_handle(attr),
+					service_changed_register_cb,
+					service_changed_cb,
+					client, NULL);
+
+	return client->svc_chngd_ind_id ? true : false;
+}
+
 static void service_changed_complete(struct discovery_op *op, bool success,
 							uint8_t att_ecode)
 {
@@ -1126,8 +1346,6 @@ static void service_changed_complete(struct discovery_op *op, bool success,
 	struct service_changed_op *next_sc_op;
 	uint16_t start_handle = op->start;
 	uint16_t end_handle = op->end;
-	struct gatt_db_attribute *attr = NULL;
-	bt_uuid_t uuid;
 
 	client->in_svc_chngd = false;
 
@@ -1153,23 +1371,7 @@ static void service_changed_complete(struct discovery_op *op, bool success,
 		return;
 	}
 
-	bt_uuid16_create(&uuid, SVC_CHNGD_UUID);
-
-	gatt_db_find_by_type(client->db, start_handle, end_handle, &uuid,
-						get_first_attribute, &attr);
-	if (!attr)
-		return;
-
-	/* The GATT service was modified. Re-register the handler for
-	 * indications from the "Service Changed" characteristic.
-	 */
-	client->svc_chngd_registered = false;
-	client->svc_chngd_ind_id = bt_gatt_client_register_notify(client,
-					gatt_db_attribute_get_handle(attr),
-					service_changed_reregister_cb,
-					service_changed_cb,
-					client, NULL);
-	if (client->svc_chngd_ind_id)
+	if (register_service_changed(client))
 		return;
 
 	util_debug(client->debug_callback, client->debug_data,
@@ -1262,69 +1464,21 @@ static void service_changed_cb(uint16_t value_handle, const uint8_t *value,
 	queue_push_tail(client->svc_chngd_queue, op);
 }
 
-static void service_changed_register_cb(uint16_t att_ecode, void *user_data)
-{
-	bool success;
-	struct bt_gatt_client *client = user_data;
-
-	if (att_ecode) {
-		util_debug(client->debug_callback, client->debug_data,
-			"Failed to register handler for \"Service Changed\"");
-		success = false;
-		client->svc_chngd_ind_id = 0;
-		goto done;
-	}
-
-	client->svc_chngd_registered = true;
-	client->ready = true;
-	success = true;
-	util_debug(client->debug_callback, client->debug_data,
-			"Registered handler for \"Service Changed\": %u",
-			client->svc_chngd_ind_id);
-
-done:
-	notify_client_ready(client, success, att_ecode);
-}
-
 static void init_complete(struct discovery_op *op, bool success,
 							uint8_t att_ecode)
 {
 	struct bt_gatt_client *client = op->client;
-	struct gatt_db_attribute *attr = NULL;
-	bt_uuid_t uuid;
 
 	client->in_init = false;
 
 	if (!success)
 		goto fail;
 
-	bt_uuid16_create(&uuid, SVC_CHNGD_UUID);
-
-	gatt_db_find_by_type(client->db, 0x0001, 0xffff, &uuid,
-						get_first_attribute, &attr);
-	if (!attr) {
+	if (register_service_changed(client)) {
 		client->ready = true;
 		goto done;
 	}
 
-	/* Register an indication handler for the "Service Changed"
-	 * characteristic and report ready only if the handler is registered
-	 * successfully. Temporarily set "ready" to true so that we can register
-	 * the handler using the existing framework.
-	 */
-	client->ready = true;
-	client->svc_chngd_ind_id = bt_gatt_client_register_notify(client,
-					gatt_db_attribute_get_handle(attr),
-					service_changed_register_cb,
-					service_changed_cb,
-					client, NULL);
-
-	if (!client->svc_chngd_registered)
-		client->ready = false;
-
-	if (client->svc_chngd_ind_id)
-		return;
-
 	util_debug(client->debug_callback, client->debug_data,
 			"Failed to register handler for \"Service Changed\"");
 	success = false;
@@ -1379,104 +1533,6 @@ struct pdu_data {
 	uint16_t length;
 };
 
-static void complete_notify_request(void *data)
-{
-	struct notify_data *notify_data = data;
-
-	/* Increment the per-characteristic ref count of notify handlers */
-	__sync_fetch_and_add(&notify_data->chrc->notify_count, 1);
-
-	notify_data->att_id = 0;
-	notify_data->callback(0, notify_data->user_data);
-}
-
-static bool notify_data_write_ccc(struct notify_data *notify_data, bool enable,
-						bt_att_response_func_t callback)
-{
-	uint8_t pdu[4];
-	unsigned int att_id;
-
-	assert(notify_data->chrc->ccc_handle);
-	memset(pdu, 0, sizeof(pdu));
-	put_le16(notify_data->chrc->ccc_handle, pdu);
-
-	if (enable) {
-		/* Try to enable notifications and/or indications based on
-		 * whatever the characteristic supports.
-		 */
-		if (notify_data->chrc->properties & BT_GATT_CHRC_PROP_NOTIFY)
-			pdu[2] = 0x01;
-
-		if (notify_data->chrc->properties & BT_GATT_CHRC_PROP_INDICATE)
-			pdu[2] |= 0x02;
-
-		if (!pdu[2])
-			return false;
-	}
-
-	att_id = bt_att_send(notify_data->client->att, BT_ATT_OP_WRITE_REQ,
-						pdu, sizeof(pdu), callback,
-						notify_data_ref(notify_data),
-						notify_data_unref);
-	notify_data->chrc->ccc_write_id = notify_data->att_id = att_id;
-
-	return !!att_id;
-}
-
-static uint8_t process_error(const void *pdu, uint16_t length)
-{
-	const struct bt_att_pdu_error_rsp *error_pdu;
-
-	if (!pdu || length != sizeof(struct bt_att_pdu_error_rsp))
-		return 0;
-
-	error_pdu = pdu;
-
-	return error_pdu->ecode;
-}
-
-static void enable_ccc_callback(uint8_t opcode, const void *pdu,
-					uint16_t length, void *user_data)
-{
-	struct notify_data *notify_data = user_data;
-	uint16_t att_ecode;
-
-	assert(!notify_data->chrc->notify_count);
-	assert(notify_data->chrc->ccc_write_id);
-
-	notify_data->chrc->ccc_write_id = 0;
-
-	if (opcode == BT_ATT_OP_ERROR_RSP) {
-		att_ecode = process_error(pdu, length);
-
-		/* Failed to enable. Complete the current request and move on to
-		 * the next one in the queue. If there was an error sending the
-		 * write request, then just move on to the next queued entry.
-		 */
-		queue_remove(notify_data->client->notify_list, notify_data);
-		notify_data->callback(att_ecode, notify_data->user_data);
-
-		while ((notify_data = queue_pop_head(
-					notify_data->chrc->reg_notify_queue))) {
-
-			if (notify_data_write_ccc(notify_data, true,
-							enable_ccc_callback))
-				return;
-		}
-
-		return;
-	}
-
-	/* Success! Report success for all remaining requests. */
-	bt_gatt_client_ref(notify_data->client);
-
-	complete_notify_request(notify_data);
-	queue_remove_all(notify_data->chrc->reg_notify_queue, NULL, NULL,
-						complete_notify_request);
-
-	bt_gatt_client_unref(notify_data->client);
-}
-
 static void disable_ccc_callback(uint8_t opcode, const void *pdu,
 					uint16_t length, void *user_data)
 {
@@ -2900,14 +2956,6 @@ unsigned int bt_gatt_client_write_execute(struct bt_gatt_client *client,
 	return id;
 }
 
-static bool match_notify_chrc_value_handle(const void *a, const void *b)
-{
-	const struct notify_chrc *chrc = a;
-	uint16_t value_handle = PTR_TO_UINT(b);
-
-	return chrc->value_handle == value_handle;
-}
-
 unsigned int bt_gatt_client_register_notify(struct bt_gatt_client *client,
 				uint16_t chrc_value_handle,
 				bt_gatt_client_register_callback_t callback,
@@ -2915,79 +2963,14 @@ unsigned int bt_gatt_client_register_notify(struct bt_gatt_client *client,
 				void *user_data,
 				bt_gatt_client_destroy_func_t destroy)
 {
-	struct notify_data *notify_data;
-	struct notify_chrc *chrc = NULL;
-
 	if (!client || !client->db || !chrc_value_handle || !callback)
 		return 0;
 
 	if (!bt_gatt_client_is_ready(client) || client->in_svc_chngd)
 		return 0;
 
-	/* Check if a characteristic ref count has been started already */
-	chrc = queue_find(client->notify_chrcs, match_notify_chrc_value_handle,
-						UINT_TO_PTR(chrc_value_handle));
-
-	if (!chrc) {
-		/*
-		 * Create an entry if the characteristic is known and has a CCC
-		 * descriptor.
-		 */
-		chrc = notify_chrc_create(client, chrc_value_handle);
-		if (!chrc)
-			return 0;
-	}
-
-	/* Fail if we've hit the maximum allowed notify sessions */
-	if (chrc->notify_count == INT_MAX)
-		return 0;
-
-	notify_data = new0(struct notify_data, 1);
-	if (!notify_data)
-		return 0;
-
-	notify_data->client = client;
-	notify_data->ref_count = 1;
-	notify_data->chrc = chrc;
-	notify_data->callback = callback;
-	notify_data->notify = notify;
-	notify_data->user_data = user_data;
-	notify_data->destroy = destroy;
-
-	/* Add the handler to the bt_gatt_client's general list */
-	queue_push_tail(client->notify_list, notify_data);
-
-	/* Assign an ID to the handler. */
-	if (client->next_reg_id < 1)
-		client->next_reg_id = 1;
-
-	notify_data->id = client->next_reg_id++;
-
-	/*
-	 * If a write to the CCC descriptor is in progress, then queue this
-	 * request.
-	 */
-	if (chrc->ccc_write_id) {
-		queue_push_tail(chrc->reg_notify_queue, notify_data);
-		return notify_data->id;
-	}
-
-	/*
-	 * If the ref count is not zero, then notifications are already enabled.
-	 */
-	if (chrc->notify_count > 0 || !chrc->ccc_handle) {
-		complete_notify_request(notify_data);
-		return notify_data->id;
-	}
-
-	/* Write to the CCC descriptor */
-	if (!notify_data_write_ccc(notify_data, true, enable_ccc_callback)) {
-		queue_remove(client->notify_list, notify_data);
-		free(notify_data);
-		return 0;
-	}
-
-	return notify_data->id;
+	return register_notify(client, chrc_value_handle, callback, notify,
+							user_data, destroy);
 }
 
 bool bt_gatt_client_unregister_notify(struct bt_gatt_client *client,
-- 
2.1.0

