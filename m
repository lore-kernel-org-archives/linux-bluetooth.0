Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv6 10/14] shared/gatt: Discover secondary services
Date: Thu, 23 Oct 2014 14:35:25 +0200
Message-Id: <1414067725-17047-1-git-send-email-marcin.kraglak@tieto.com>
In-Reply-To: <1414059337-12040-11-git-send-email-marcin.kraglak@tieto.com>
References: <1414059337-12040-11-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Add searching of secondary services in gatt-client.
---
 src/shared/gatt-client.c | 113 +++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 100 insertions(+), 13 deletions(-)

diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
index 724fde2..acc0cb9 100644
--- a/src/shared/gatt-client.c
+++ b/src/shared/gatt-client.c
@@ -200,23 +200,36 @@ static void mark_notify_data_invalid_if_in_range(void *data, void *user_data)
 		notify_data->invalid = true;
 }
 
-static bool service_list_add_service(struct service_list **head,
-						struct service_list **tail,
-						bool primary, uint16_t start,
-						uint16_t end,
+static struct service_list *new_service_list(uint16_t start, uint16_t end,
+						bool primary,
 						uint8_t uuid[BT_GATT_UUID_SIZE])
 {
 	struct service_list *list;
 
 	list = new0(struct service_list, 1);
 	if (!list)
-		return false;
+		return NULL;
 
 	list->service.primary = primary;
 	list->service.start_handle = start;
 	list->service.end_handle = end;
 	memcpy(list->service.uuid, uuid, UUID_BYTES);
 
+	return list;
+}
+
+static bool service_list_add_service(struct service_list **head,
+						struct service_list **tail,
+						bool primary, uint16_t start,
+						uint16_t end,
+						uint8_t uuid[BT_GATT_UUID_SIZE])
+{
+	struct service_list *list;
+
+	list = new_service_list(start, end, primary, uuid);
+	if (!list)
+		return false;
+
 	if (!(*head))
 		*head = *tail = list;
 	else {
@@ -364,6 +377,8 @@ struct discovery_op {
 	struct bt_gatt_client *client;
 	struct service_list *result_head, *result_tail, *cur_service;
 	struct chrc_data *cur_chrc;
+	uint16_t start;
+	uint16_t end;
 	int cur_chrc_index;
 	int ref_count;
 	void (*complete_func)(struct discovery_op *op, bool success,
@@ -634,6 +649,75 @@ done:
 	op->complete_func(op, success, att_ecode);
 }
 
+static void discover_secondary_cb(bool success, uint8_t att_ecode,
+						struct bt_gatt_result *result,
+						void *user_data)
+{
+	struct discovery_op *op = user_data;
+	struct bt_gatt_client *client = op->client;
+	struct bt_gatt_iter iter;
+	uint16_t start, end;
+	uint8_t uuid[BT_GATT_UUID_SIZE];
+	char uuid_str[MAX_LEN_UUID_STR];
+	struct service_list *service;
+
+	if (!success) {
+		util_debug(client->debug_callback, client->debug_data,
+					"Secondary service discovery failed."
+					" ATT ECODE: 0x%02x", att_ecode);
+		switch (att_ecode) {
+		case BT_ATT_ERROR_ATTRIBUTE_NOT_FOUND:
+		case BT_ATT_ERROR_UNSUPPORTED_GROUP_TYPE:
+			goto next;
+		default:
+			goto done;
+		}
+	}
+
+	if (!result || !bt_gatt_iter_init(&iter, result))
+		goto done;
+
+	util_debug(client->debug_callback, client->debug_data,
+					"Secondary services found: %u",
+					bt_gatt_result_service_count(result));
+
+	while (bt_gatt_iter_next_service(&iter, &start, &end, uuid)) {
+		uuid_to_string(uuid, uuid_str);
+		util_debug(client->debug_callback, client->debug_data,
+				"start: 0x%04x, end: 0x%04x, uuid: %s",
+				start, end, uuid_str);
+
+		/* Store the service */
+		service = new_service_list(start, end, false, uuid);
+		if (!service) {
+			util_debug(client->debug_callback, client->debug_data,
+						"Failed to create service");
+			goto done;
+		}
+
+		service_list_insert_services(&op->result_head, &op->result_tail,
+							service, service);
+	}
+
+next:
+	/* Sequentially discover the characteristics of all services */
+	op->cur_service = op->result_head;
+	if (bt_gatt_discover_characteristics(client->att,
+					op->cur_service->service.start_handle,
+					op->cur_service->service.end_handle,
+					discover_chrcs_cb,
+					discovery_op_ref(op),
+					discovery_op_unref))
+		return;
+
+	util_debug(client->debug_callback, client->debug_data,
+				"Failed to start characteristic discovery");
+	discovery_op_unref(op);
+
+done:
+	op->complete_func(op, false, att_ecode);
+}
+
 static void discover_primary_cb(bool success, uint8_t att_ecode,
 						struct bt_gatt_result *result,
 						void *user_data)
@@ -686,18 +770,17 @@ static void discover_primary_cb(bool success, uint8_t att_ecode,
 	if (!op->result_head)
 		goto done;
 
-	/* Sequentially discover the characteristics of all services */
+	/* Discover secondary services */
 	op->cur_service = op->result_head;
-	if (bt_gatt_discover_characteristics(client->att,
-					op->cur_service->service.start_handle,
-					op->cur_service->service.end_handle,
-					discover_chrcs_cb,
-					discovery_op_ref(op),
-					discovery_op_unref))
+	if (bt_gatt_discover_secondary_services(client->att, NULL,
+							op->start, op->end,
+							discover_secondary_cb,
+							discovery_op_ref(op),
+							discovery_op_unref))
 		return;
 
 	util_debug(client->debug_callback, client->debug_data,
-				"Failed to start characteristic discovery");
+				"Failed to start secondary service discovery");
 	discovery_op_unref(op);
 	success = false;
 
@@ -870,6 +953,8 @@ static void process_service_changed(struct bt_gatt_client *client,
 
 	op->client = client;
 	op->complete_func = service_changed_complete;
+	op->start = start_handle;
+	op->end = end_handle;
 
 	if (!bt_gatt_discover_primary_services(client->att, NULL,
 						start_handle, end_handle,
@@ -1002,6 +1087,8 @@ static bool gatt_client_init(struct bt_gatt_client *client, uint16_t mtu)
 
 	op->client = client;
 	op->complete_func = init_complete;
+	op->start = 0x0001;
+	op->end = 0xffff;
 
 	/* Configure the MTU */
 	if (!bt_gatt_exchange_mtu(client->att, MAX(BT_ATT_DEFAULT_LE_MTU, mtu),
-- 
1.9.3

