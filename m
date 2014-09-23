Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH BlueZ 2/9] shared/gatt-client: Make service discovery more modular.
Date: Tue, 23 Sep 2014 13:47:10 -0700
Message-Id: <1411505237-10932-3-git-send-email-armansito@chromium.org>
In-Reply-To: <1411505237-10932-1-git-send-email-armansito@chromium.org>
References: <1411505237-10932-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch makes the existing service discovery procedures more modular by
making the following changes:

  - Don't accumulate the discovery results in struct bt_gatt_client's internal
    service list. Instead, accumulate them inside struct discovery_op and assign
    them to bt_gatt_client during completion.

  - Add a completion callback to struct discovery_op which gets called at the
    end of a discovery operation. This allows discovery ops triggered for
    different reasons (e.g. init vs "Service Changed") to process discovery
    results separately.
---
 src/shared/gatt-client.c | 80 +++++++++++++++++++++++++++++-------------------
 1 file changed, 49 insertions(+), 31 deletions(-)

diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
index 997a280..d0c12df 100644
--- a/src/shared/gatt-client.c
+++ b/src/shared/gatt-client.c
@@ -102,7 +102,8 @@ struct bt_gatt_client {
 	bool need_notify_cleanup;
 };
 
-static bool gatt_client_add_service(struct bt_gatt_client *client,
+static bool service_list_add_service(struct service_list **head,
+						struct service_list **tail,
 						uint16_t start, uint16_t end,
 						uint8_t uuid[BT_GATT_UUID_SIZE])
 {
@@ -116,11 +117,11 @@ static bool gatt_client_add_service(struct bt_gatt_client *client,
 	list->service.end_handle = end;
 	memcpy(list->service.uuid, uuid, UUID_BYTES);
 
-	if (!client->svc_head)
-		client->svc_head = client->svc_tail = list;
+	if (!(*head))
+		*head = *tail = list;
 	else {
-		client->svc_tail->next = list;
-		client->svc_tail = list;
+		(*tail)->next = list;
+		*tail = list;
 	}
 
 	return true;
@@ -141,11 +142,15 @@ static void service_destroy_characteristics(struct service_list *service)
 	free(service->chrcs);
 }
 
-static void gatt_client_clear_services(struct bt_gatt_client *client)
+static void service_list_clear(struct service_list **head,
+						struct service_list **tail)
 {
 	struct service_list *l, *tmp;
 
-	l = client->svc_head;
+	if (!(*head) || !(*tail))
+		return;
+
+	l = *head;
 
 	while (l) {
 		service_destroy_characteristics(l);
@@ -154,15 +159,22 @@ static void gatt_client_clear_services(struct bt_gatt_client *client)
 		free(tmp);
 	}
 
-	client->svc_head = client->svc_tail = NULL;
+	*head = *tail = NULL;
+}
+
+static void gatt_client_clear_services(struct bt_gatt_client *client)
+{
+	service_list_clear(&client->svc_head, &client->svc_tail);
 }
 
 struct discovery_op {
 	struct bt_gatt_client *client;
-	struct service_list *cur_service;
+	struct service_list *result_head, *result_tail, *cur_service;
 	struct chrc_data *cur_chrc;
 	int cur_chrc_index;
 	int ref_count;
+	void (*complete_func)(struct discovery_op *op, bool success,
+							uint8_t att_ecode);
 };
 
 static struct discovery_op *discovery_op_ref(struct discovery_op *op)
@@ -182,22 +194,6 @@ static void discovery_op_unref(void *data)
 	free(data);
 }
 
-static void discovery_op_complete(struct discovery_op *op, bool success,
-							uint8_t att_ecode)
-{
-	struct bt_gatt_client *client = op->client;
-
-	client->in_init = false;
-
-	if (success)
-		client->ready = true;
-	else
-		gatt_client_clear_services(client);
-
-	if (client->ready_callback)
-		client->ready_callback(success, att_ecode, client->ready_data);
-}
-
 static void uuid_to_string(const uint8_t uuid[BT_GATT_UUID_SIZE],
 						char str[MAX_LEN_UUID_STR])
 {
@@ -325,7 +321,7 @@ next:
 	success = false;
 
 done:
-	discovery_op_complete(op, success, att_ecode);
+	op->complete_func(op, success, att_ecode);
 }
 
 static void discover_chrcs_cb(bool success, uint8_t att_ecode,
@@ -438,7 +434,7 @@ next:
 	success = false;
 
 done:
-	discovery_op_complete(op, success, att_ecode);
+	op->complete_func(op, success, att_ecode);
 }
 
 static void discover_primary_cb(bool success, uint8_t att_ecode,
@@ -476,7 +472,8 @@ static void discover_primary_cb(bool success, uint8_t att_ecode,
 				start, end, uuid_str);
 
 		/* Store the service */
-		if (!gatt_client_add_service(client, start, end, uuid)) {
+		if (!service_list_add_service(&op->result_head,
+					&op->result_tail, start, end, uuid)) {
 			util_debug(client->debug_callback, client->debug_data,
 						"Failed to store service");
 			success = false;
@@ -485,11 +482,11 @@ static void discover_primary_cb(bool success, uint8_t att_ecode,
 	}
 
 	/* Complete the process if the service list is empty */
-	if (!client->svc_head)
+	if (!op->result_head)
 		goto done;
 
 	/* Sequentially discover the characteristics of all services */
-	op->cur_service = client->svc_head;
+	op->cur_service = op->result_head;
 	if (bt_gatt_discover_characteristics(client->att,
 					op->cur_service->service.start_handle,
 					op->cur_service->service.end_handle,
@@ -504,7 +501,7 @@ static void discover_primary_cb(bool success, uint8_t att_ecode,
 	success = false;
 
 done:
-	discovery_op_complete(op, success, att_ecode);
+	op->complete_func(op, success, att_ecode);
 }
 
 static void exchange_mtu_cb(bool success, uint8_t att_ecode, void *user_data)
@@ -547,6 +544,24 @@ static void exchange_mtu_cb(bool success, uint8_t att_ecode, void *user_data)
 	discovery_op_unref(op);
 }
 
+static void init_complete(struct discovery_op *op, bool success,
+							uint8_t att_ecode)
+{
+	struct bt_gatt_client *client = op->client;
+
+	client->in_init = false;
+
+	if (success) {
+		client->svc_head = op->result_head;
+		client->svc_tail = op->result_tail;
+		client->ready = true;
+	} else
+		service_list_clear(&op->result_head, &op->result_tail);
+
+	if (client->ready_callback)
+		client->ready_callback(success, att_ecode, client->ready_data);
+}
+
 static bool gatt_client_init(struct bt_gatt_client *client, uint16_t mtu)
 {
 	struct discovery_op *op;
@@ -559,6 +574,7 @@ static bool gatt_client_init(struct bt_gatt_client *client, uint16_t mtu)
 		return false;
 
 	op->client = client;
+	op->complete_func = init_complete;
 
 	/* Configure the MTU */
 	if (!bt_gatt_exchange_mtu(client->att, MAX(BT_ATT_DEFAULT_LE_MTU, mtu),
@@ -896,6 +912,8 @@ void bt_gatt_client_unref(struct bt_gatt_client *client)
 	queue_destroy(client->long_write_queue, long_write_op_unref);
 	queue_destroy(client->notify_list, notify_data_unref);
 
+	gatt_client_clear_services(client);
+
 	bt_att_unref(client->att);
 	free(client);
 }
-- 
2.1.0.rc2.206.gedb03e5

