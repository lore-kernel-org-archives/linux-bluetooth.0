Return-Path: <cyrus@holtmann.org>
From: Michael Janssen <jamuraa@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Michael Janssen <jamuraa@chromium.org>
Subject: [PATCH BlueZ v2 01/12] gatt_db: use callback for gatt_db_find_by_type
Date: Mon,  5 Jan 2015 13:32:43 -0800
Message-Id: <1420493574-37305-2-git-send-email-jamuraa@chromium.org>
In-Reply-To: <1420493574-37305-1-git-send-email-jamuraa@chromium.org>
References: <1420493574-37305-1-git-send-email-jamuraa@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

It is preferred to not expose queue, so switch the function to a
callback style instead, and update the uses of it, eliminating a set of
queue uses.
---
 android/gatt.c           | 85 ++++++++++++++++++++++++++++--------------------
 src/shared/gatt-client.c | 43 +++++++++++-------------
 src/shared/gatt-db.c     | 15 +++++----
 src/shared/gatt-db.h     | 13 ++++----
 4 files changed, 84 insertions(+), 72 deletions(-)

diff --git a/android/gatt.c b/android/gatt.c
index 3a35bd6..b749705 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -6243,15 +6243,53 @@ static uint8_t find_info_handle(const uint8_t *cmd, uint16_t cmd_len,
 	return ret;
 }
 
+struct find_by_type_request_data {
+	struct gatt_device *device;
+	uint8_t *search_value;
+	size_t search_vlen;
+	uint8_t error;
+};
+
+static void find_by_type_request_cb(struct gatt_db_attribute *attrib,
+								void *user_data)
+{
+	struct find_by_type_request_data *find_data = user_data;
+	struct pending_request *request_data;
+
+	if (find_data->error)
+		return;
+
+	request_data = new0(struct pending_request, 1);
+	if (!request_data) {
+		find_data->error = ATT_ECODE_INSUFF_RESOURCES;
+		return;
+	}
+
+	request_data->filter_value = malloc0(find_data->search_vlen);
+	if (!request_data->filter_value) {
+		destroy_pending_request(request_data);
+		find_data->error = ATT_ECODE_INSUFF_RESOURCES;
+		return;
+	}
+
+	request_data->state = REQUEST_INIT;
+	request_data->attrib = attrib;
+	request_data->filter_vlen = find_data->search_vlen;
+	memcpy(request_data->filter_value, find_data->search_value,
+							find_data->search_vlen);
+
+	queue_push_tail(find_data->device->pending_requests, request_data);
+}
+
 static uint8_t find_by_type_request(const uint8_t *cmd, uint16_t cmd_len,
 						struct gatt_device *device)
 {
 	uint8_t search_value[cmd_len];
 	size_t search_vlen;
 	uint16_t start, end;
-	struct queue *q;
 	bt_uuid_t uuid;
 	uint16_t len;
+	struct find_by_type_request_data data;
 
 	DBG("");
 
@@ -6263,53 +6301,28 @@ static uint8_t find_by_type_request(const uint8_t *cmd, uint16_t cmd_len,
 	if (start > end || start == 0)
 		return ATT_ECODE_INVALID_HANDLE;
 
-	q = queue_new();
-	if (!q)
-		return ATT_ECODE_UNLIKELY;
+	data.error = 0;
+	data.search_vlen = search_vlen;
+	data.search_value = search_value;
+	data.device = device;
 
-	gatt_db_find_by_type(gatt_db, start, end, &uuid, q);
+	gatt_db_find_by_type(gatt_db, start, end, &uuid,
+						find_by_type_request_cb, &data);
 
-	if (queue_isempty(q)) {
+	if (data.error == ATT_ECODE_ATTR_NOT_FOUND) {
 		size_t mtu;
 		uint8_t *rsp = g_attrib_get_buffer(device->attrib, &mtu);
 
 		len = enc_error_resp(ATT_OP_FIND_BY_TYPE_REQ, start,
 					ATT_ECODE_ATTR_NOT_FOUND, rsp, mtu);
 		g_attrib_send(device->attrib, 0, rsp, len, NULL, NULL, NULL);
-		queue_destroy(q, NULL);
 		return 0;
 	}
 
-	while (queue_peek_head(q)) {
-		struct gatt_db_attribute *attrib = queue_pop_head(q);
-		struct pending_request *data;
-
-		data = new0(struct pending_request, 1);
-		if (!data) {
-			queue_destroy(q, NULL);
-			return ATT_ECODE_INSUFF_RESOURCES;
-		}
+	if (!data.error)
+		process_dev_pending_requests(device, ATT_OP_FIND_BY_TYPE_REQ);
 
-		data->filter_value = malloc0(search_vlen);
-		if (!data->filter_value) {
-			destroy_pending_request(data);
-			queue_destroy(q, NULL);
-			return ATT_ECODE_INSUFF_RESOURCES;
-		}
-
-		data->state = REQUEST_INIT;
-		data->attrib = attrib;
-		data->filter_vlen = search_vlen;
-		memcpy(data->filter_value, search_value, search_vlen);
-
-		queue_push_tail(device->pending_requests, data);
-	}
-
-	queue_destroy(q, NULL);
-
-	process_dev_pending_requests(device, ATT_OP_FIND_BY_TYPE_REQ);
-
-	return 0;
+	return data.error;
 }
 
 static void write_confirm(struct gatt_db_attribute *attrib,
diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
index 6768892..e9fb852 100644
--- a/src/shared/gatt-client.c
+++ b/src/shared/gatt-client.c
@@ -973,6 +973,17 @@ static void process_service_changed(struct bt_gatt_client *client,
 static void service_changed_cb(uint16_t value_handle, const uint8_t *value,
 					uint16_t length, void *user_data);
 
+static void get_first_attribute(struct gatt_db_attribute *attrib,
+								void *user_data)
+{
+	struct gatt_db_attribute **stored = user_data;
+
+	if (*stored)
+		return;
+
+	*stored = attrib;
+}
+
 static void service_changed_complete(struct discovery_op *op, bool success,
 							uint8_t att_ecode)
 {
@@ -982,7 +993,6 @@ static void service_changed_complete(struct discovery_op *op, bool success,
 	uint16_t end_handle = op->end;
 	struct gatt_db_attribute *attr;
 	bt_uuid_t uuid;
-	struct queue *q;
 
 	client->in_svc_chngd = false;
 
@@ -1008,21 +1018,13 @@ static void service_changed_complete(struct discovery_op *op, bool success,
 		return;
 	}
 
-	/* Check if the GATT service was among the changed services */
-	q = queue_new();
-	if (!q)
-		return;
-
 	bt_uuid16_create(&uuid, SVC_CHNGD_UUID);
 
-	gatt_db_find_by_type(client->db, start_handle, end_handle, &uuid, q);
-	if (queue_isempty(q)) {
-		queue_destroy(q, NULL);
-		return;
-	}
+	gatt_db_find_by_type(client->db, start_handle, end_handle, &uuid,
+						get_first_attribute, &attr);
 
-	attr = queue_pop_head(q);
-	queue_destroy(q, NULL);
+	if (!attr)
+		return;
 
 	/* The GATT service was modified. Re-register the handler for
 	 * indications from the "Service Changed" characteristic.
@@ -1150,29 +1152,22 @@ static void init_complete(struct discovery_op *op, bool success,
 	bool registered;
 	struct gatt_db_attribute *attr;
 	bt_uuid_t uuid;
-	struct queue *q;
 
 	client->in_init = false;
 
 	if (!success)
 		goto fail;
 
-	q = queue_new();
-	if (!q)
-		goto fail;
-
 	bt_uuid16_create(&uuid, SVC_CHNGD_UUID);
 
-	gatt_db_find_by_type(client->db, 0x0001, 0xffff, &uuid, q);
-	if (queue_isempty(q)) {
-		queue_destroy(q, NULL);
+	gatt_db_find_by_type(client->db, 0x0001, 0xffff, &uuid,
+						get_first_attribute, &attr);
+
+	if (!attr) {
 		client->ready = true;
 		goto done;
 	}
 
-	attr = queue_pop_head(q);
-	queue_destroy(q, NULL);
-
 	/* Register an indication handler for the "Service Changed"
 	 * characteristic and report ready only if the handler is registered
 	 * successfully. Temporarily set "ready" to true so that we can register
diff --git a/src/shared/gatt-db.c b/src/shared/gatt-db.c
index d2cdacc..f519bcb 100644
--- a/src/shared/gatt-db.c
+++ b/src/shared/gatt-db.c
@@ -826,10 +826,11 @@ next_service:
 }
 
 struct find_by_type_value_data {
-	struct queue *queue;
 	bt_uuid_t uuid;
 	uint16_t start_handle;
 	uint16_t end_handle;
+	gatt_db_attribute_cb_t func;
+	void *user_data;
 };
 
 static void find_by_type(void *data, void *user_data)
@@ -855,21 +856,23 @@ static void find_by_type(void *data, void *user_data)
 		if (bt_uuid_cmp(&search_data->uuid, &attribute->uuid))
 			continue;
 
-		queue_push_tail(search_data->queue, attribute);
+		search_data->func(attribute, search_data->user_data);
 	}
 }
 
 void gatt_db_find_by_type(struct gatt_db *db, uint16_t start_handle,
-							uint16_t end_handle,
-							const bt_uuid_t *type,
-							struct queue *queue)
+						uint16_t end_handle,
+						const bt_uuid_t *type,
+						gatt_db_attribute_cb_t func,
+						void *user_data)
 {
 	struct find_by_type_value_data data;
 
 	data.uuid = *type;
 	data.start_handle = start_handle;
 	data.end_handle = end_handle;
-	data.queue = queue;
+	data.func = func;
+	data.user_data = user_data;
 
 	queue_foreach(db->services, find_by_type, &data);
 }
diff --git a/src/shared/gatt-db.h b/src/shared/gatt-db.h
index f188944..9fc1b11 100644
--- a/src/shared/gatt-db.h
+++ b/src/shared/gatt-db.h
@@ -83,15 +83,19 @@ gatt_db_service_add_included(struct gatt_db_attribute *attrib,
 bool gatt_db_service_set_active(struct gatt_db_attribute *attrib, bool active);
 bool gatt_db_service_get_active(struct gatt_db_attribute *attrib);
 
+typedef void (*gatt_db_attribute_cb_t)(struct gatt_db_attribute *attrib,
+							void *user_data);
+
 void gatt_db_read_by_group_type(struct gatt_db *db, uint16_t start_handle,
 							uint16_t end_handle,
 							const bt_uuid_t type,
 							struct queue *queue);
 
 void gatt_db_find_by_type(struct gatt_db *db, uint16_t start_handle,
-							uint16_t end_handle,
-							const bt_uuid_t *type,
-							struct queue *queue);
+						uint16_t end_handle,
+						const bt_uuid_t *type,
+						gatt_db_attribute_cb_t func,
+						void *user_data);
 
 void gatt_db_read_by_type(struct gatt_db *db, uint16_t start_handle,
 							uint16_t end_handle,
@@ -103,9 +107,6 @@ void gatt_db_find_information(struct gatt_db *db, uint16_t start_handle,
 							struct queue *queue);
 
 
-typedef void (*gatt_db_attribute_cb_t)(struct gatt_db_attribute *attrib,
-							void *user_data);
-
 void gatt_db_foreach_service(struct gatt_db *db, const bt_uuid_t *uuid,
 						gatt_db_attribute_cb_t func,
 						void *user_data);
-- 
2.2.0.rc0.207.ga3a616c

