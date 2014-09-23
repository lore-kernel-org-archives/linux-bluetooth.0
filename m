Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH BlueZ 5/9] shared/gatt-client: Rediscover services within changed range.
Date: Tue, 23 Sep 2014 13:47:13 -0700
Message-Id: <1411505237-10932-6-git-send-email-armansito@chromium.org>
In-Reply-To: <1411505237-10932-1-git-send-email-armansito@chromium.org>
References: <1411505237-10932-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds the discovery step of handling "Service Changed". A primary
service discovery is performed within the affected handle range and results are
inserted into the service list as a contiguous block of services, sorted by
handle.
---
 src/shared/gatt-client.c | 111 ++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 106 insertions(+), 5 deletions(-)

diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
index cc0a894..3f092ac 100644
--- a/src/shared/gatt-client.c
+++ b/src/shared/gatt-client.c
@@ -289,6 +289,43 @@ static void service_list_clear_range(struct service_list **head,
 	}
 }
 
+static void service_list_insert_services(struct service_list **head,
+						struct service_list **tail,
+						struct service_list *svc_head,
+						struct service_list *svc_tail)
+{
+	struct service_list *cur, *prev;
+
+	if (!(*head) || !(*tail)) {
+		*head = svc_head;
+		*tail = svc_tail;
+		return;
+	}
+
+	prev = NULL;
+	cur = *head;
+	while (cur) {
+		if (svc_tail->service.end_handle < cur->service.start_handle) {
+			if (!prev)
+				*head = svc_head;
+			else
+				prev->next = svc_head;
+
+			svc_tail->next = cur;
+			return;
+		}
+
+		prev = cur;
+		cur = cur->next;
+	}
+
+	if (prev != *tail)
+		return;
+
+	prev->next = svc_head;
+	*tail = svc_tail;
+}
+
 static void gatt_client_remove_all_notify_in_range(
 				struct bt_gatt_client *client,
 				uint16_t start_handle, uint16_t end_handle)
@@ -709,8 +746,52 @@ struct service_changed_op {
 
 static void process_service_changed(struct bt_gatt_client *client,
 							uint16_t start_handle,
+							uint16_t end_handle);
+
+static void service_changed_complete(struct discovery_op *op, bool success,
+							uint8_t att_ecode)
+{
+	struct bt_gatt_client *client = op->client;
+	struct service_changed_op *next_sc_op;
+
+	client->in_svc_chngd = false;
+
+	if (!success) {
+		util_debug(client->debug_callback, client->debug_data,
+			"Failed to discover services within changed range - "
+			"error: 0x%02x", att_ecode);
+		return;
+	}
+
+	/* No new services in the modified range */
+	if (!op->result_head || !op->result_tail)
+		return;
+
+	/* Insert all newly discovered services in their correct place as a
+	 * contiguous chunk */
+	service_list_insert_services(&client->svc_head, &client->svc_tail,
+					op->result_head, op->result_tail);
+
+	/* Process any queued events */
+	next_sc_op = queue_pop_head(client->svc_chngd_queue);
+	if (next_sc_op) {
+		process_service_changed(client, next_sc_op->start_handle,
+							next_sc_op->end_handle);
+		free(next_sc_op);
+		return;
+	}
+
+	/* TODO: if the GATT service has changed then register a handler
+	 * for "Service Changed".
+	 */
+}
+
+static void process_service_changed(struct bt_gatt_client *client,
+							uint16_t start_handle,
 							uint16_t end_handle)
 {
+	struct discovery_op *op;
+
 	/* Invalidate and remove all effected notify callbacks */
 	gatt_client_remove_all_notify_in_range(client, start_handle,
 								end_handle);
@@ -721,10 +802,30 @@ static void process_service_changed(struct bt_gatt_client *client,
 	service_list_clear_range(&client->svc_head, &client->svc_tail,
 						start_handle, end_handle);
 
-	/* TODO Rediscover all services within the modified service range. If
-	 * the GATT service was effected, then register a new handler for
-	 * "Service Changed"
-	 */
+	op = new0(struct discovery_op, 1);
+	if (!op) {
+		util_debug(client->debug_callback, client->debug_data,
+				"Failed to initiate primary service discovery"
+				" after Service Changed");
+		return;
+	}
+
+	op->client = client;
+	op->complete_func = service_changed_complete;
+
+	if (!bt_gatt_discover_primary_services(client->att, NULL,
+						start_handle, end_handle,
+						discover_primary_cb,
+						discovery_op_ref(op),
+						discovery_op_unref)) {
+		util_debug(client->debug_callback, client->debug_data,
+				"Failed to initiate primary service discovery"
+				" after Service Changed");
+		free(op);
+		return;
+	}
+
+	client->in_svc_chngd = true;
 }
 
 static void service_changed_cb(uint16_t value_handle, const uint8_t *value,
@@ -1980,7 +2081,7 @@ bool bt_gatt_client_register_notify(struct bt_gatt_client *client,
 	if (!client || !chrc_value_handle || !callback)
 		return false;
 
-	if (!bt_gatt_client_is_ready(client))
+	if (!bt_gatt_client_is_ready(client) || client->in_svc_chngd)
 		return false;
 
 	/* Check that chrc_value_handle belongs to a known characteristic */
-- 
2.1.0.rc2.206.gedb03e5

