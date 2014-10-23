Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv6 11/14] shared/gatt: Discover included services
Date: Thu, 23 Oct 2014 12:15:34 +0200
Message-Id: <1414059337-12040-12-git-send-email-marcin.kraglak@tieto.com>
In-Reply-To: <1414059337-12040-1-git-send-email-marcin.kraglak@tieto.com>
References: <1414059337-12040-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/shared/gatt-client.c | 106 +++++++++++++++++++++++++++++++++++++++++++++--
 src/shared/gatt-client.h |   7 ++++
 2 files changed, 109 insertions(+), 4 deletions(-)

diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
index e04724c..b2c33e3 100644
--- a/src/shared/gatt-client.c
+++ b/src/shared/gatt-client.c
@@ -69,6 +69,8 @@ struct service_list {
 	bt_gatt_service_t service;
 	struct chrc_data *chrcs;
 	size_t num_chrcs;
+	bt_gatt_included_service_t *includes;
+	size_t num_includes;
 	struct service_list *next;
 };
 
@@ -253,6 +255,14 @@ static void service_destroy_characteristics(struct service_list *service)
 	free(service->chrcs);
 }
 
+static void service_destroy_includes(struct service_list *service)
+{
+	free(service->includes);
+
+	service->includes = NULL;
+	service->num_includes = 0;
+}
+
 static void service_list_clear(struct service_list **head,
 						struct service_list **tail)
 {
@@ -265,6 +275,7 @@ static void service_list_clear(struct service_list **head,
 
 	while (l) {
 		service_destroy_characteristics(l);
+		service_destroy_includes(l);
 		tmp = l;
 		l = tmp->next;
 		free(tmp);
@@ -293,6 +304,7 @@ static void service_list_clear_range(struct service_list **head,
 		}
 
 		service_destroy_characteristics(cur);
+		service_destroy_includes(cur);
 
 		if (!prev)
 			*head = cur->next;
@@ -428,6 +440,91 @@ static int uuid_cmp(const uint8_t uuid128[16], uint16_t uuid16)
 	return memcmp(uuid128, rhs_uuid, sizeof(rhs_uuid));
 }
 
+static void discover_incl_cb(bool success, uint8_t att_ecode,
+				struct bt_gatt_result *result, void *user_data)
+{
+	struct discovery_op *op = user_data;
+	struct bt_gatt_client *client = op->client;
+	struct bt_gatt_iter iter;
+	char uuid_str[MAX_LEN_UUID_STR];
+	bt_gatt_included_service_t *includes;
+	unsigned int includes_count, i;
+
+	if (!success) {
+		if (att_ecode == BT_ATT_ERROR_ATTRIBUTE_NOT_FOUND)
+			goto next;
+
+		goto failed;
+	}
+
+	if (!result || !bt_gatt_iter_init(&iter, result))
+		goto failed;
+
+	includes_count = bt_gatt_result_included_count(result);
+	if (includes_count == 0)
+		goto failed;
+
+	includes = new0(bt_gatt_included_service_t, includes_count);
+	if (!includes)
+		goto failed;
+
+	util_debug(client->debug_callback, client->debug_data,
+						"Included services found: %u",
+						includes_count);
+
+	for (i = 0; i < includes_count; i++) {
+		if (!bt_gatt_iter_next_included_service(&iter,
+						&includes[i].handle,
+						&includes[i].start_handle,
+						&includes[i].end_handle,
+						includes[i].uuid))
+			break;
+
+		uuid_to_string(includes[i].uuid, uuid_str);
+		util_debug(client->debug_callback, client->debug_data,
+				"handle: 0x%04x, start: 0x%04x, end: 0x%04x,"
+				"uuid: %s", includes[i].handle,
+				includes[i].start_handle,
+				includes[i].end_handle, uuid_str);
+	}
+
+	op->cur_service->includes = includes;
+	op->cur_service->num_includes = includes_count;
+
+next:
+	if (!op->cur_service->next) {
+		op->cur_service = op->result_head;
+		if (bt_gatt_discover_characteristics(client->att,
+					op->cur_service->service.start_handle,
+					op->cur_service->service.end_handle,
+					discover_chrcs_cb,
+					discovery_op_ref(op),
+					discovery_op_unref))
+			return;
+
+		util_debug(client->debug_callback, client->debug_data,
+				"Failed to start characteristic discovery");
+		discovery_op_unref(op);
+		goto failed;
+	}
+
+	op->cur_service = op->cur_service->next;
+	if (bt_gatt_discover_included_services(client->att,
+				op->cur_service->service.start_handle,
+				op->cur_service->service.end_handle,
+				discover_incl_cb,
+				discovery_op_ref(op),
+				discovery_op_unref))
+		return;
+
+	util_debug(client->debug_callback, client->debug_data,
+					"Failed to start included discovery");
+	discovery_op_unref(op);
+
+failed:
+	op->complete_func(op, false, att_ecode);
+}
+
 static void discover_descs_cb(bool success, uint8_t att_ecode,
 						struct bt_gatt_result *result,
 						void *user_data)
@@ -532,6 +629,7 @@ done:
 	op->complete_func(op, success, att_ecode);
 }
 
+
 static void discover_chrcs_cb(bool success, uint8_t att_ecode,
 						struct bt_gatt_result *result,
 						void *user_data)
@@ -703,18 +801,18 @@ static void discover_secondary_cb(bool success, uint8_t att_ecode,
 	}
 
 next:
-	/* Sequentially discover the characteristics of all services */
+	/* Sequentially discover included services */
 	op->cur_service = op->result_head;
-	if (bt_gatt_discover_characteristics(client->att,
+	if (bt_gatt_discover_included_services(client->att,
 					op->cur_service->service.start_handle,
 					op->cur_service->service.end_handle,
-					discover_chrcs_cb,
+					discover_incl_cb,
 					discovery_op_ref(op),
 					discovery_op_unref))
 		return;
 
 	util_debug(client->debug_callback, client->debug_data,
-				"Failed to start characteristic discovery");
+				"Failed to start included services discovery");
 	discovery_op_unref(op);
 	success = false;
 
diff --git a/src/shared/gatt-client.h b/src/shared/gatt-client.h
index 22d4dc0..05b4838 100644
--- a/src/shared/gatt-client.h
+++ b/src/shared/gatt-client.h
@@ -96,6 +96,13 @@ typedef struct {
 	size_t num_descs;
 } bt_gatt_characteristic_t;
 
+typedef struct {
+	uint16_t handle;
+	uint16_t start_handle;
+	uint16_t end_handle;
+	uint8_t uuid[BT_GATT_UUID_SIZE];
+} bt_gatt_included_service_t;
+
 struct bt_gatt_service_iter {
 	struct bt_gatt_client *client;
 	void *ptr;
-- 
1.9.3

