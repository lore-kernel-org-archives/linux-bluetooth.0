Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <szymon.janc@tieto.com>,
	Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH 14/15] android/gatt: Use cache for included services
Date: Tue, 8 Apr 2014 11:22:31 +0200
Message-ID: <1396948952-2035-15-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1396948952-2035-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1396948952-2035-1-git-send-email-lukasz.rymanowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

We should used cached included services as ofter as possible

This patch do bit refactor of handling included service.
Removes some unsed helper functions used to match in queue.
Also moves up find_service function as it is need now higier in the
code.
---
 android/gatt.c | 175 +++++++++++++++++++++++++++++++--------------------------
 1 file changed, 94 insertions(+), 81 deletions(-)

diff --git a/android/gatt.c b/android/gatt.c
index 58b228d..d1deae4 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -91,6 +91,7 @@ struct service {
 
 	struct queue *chars;
 	struct queue *included;	/* Valid only for primary services */
+	bool incl_search_done;
 };
 
 struct notification_data {
@@ -294,6 +295,16 @@ static bool match_srvc_by_element_id(const void *data, const void *user_data)
 	return false;
 }
 
+static bool match_srvc_by_higher_inst_id(const void *data,
+							const void *user_data)
+{
+	const struct service *s = data;
+	uint8_t inst_id = PTR_TO_INT(user_data);
+
+	/* For now we match inst_id as it is unique */
+	return inst_id < s->id.instance;
+}
+
 static bool match_char_by_higher_inst_id(const void *data,
 							const void *user_data)
 {
@@ -1229,29 +1240,6 @@ reply:
 			HAL_OP_GATT_CLIENT_SEARCH_SERVICE, status);
 }
 
-static bool match_service_by_uuid(const void *data, const void *user_data)
-{
-	const struct service *service = data;
-	const bt_uuid_t *uuid = user_data;
-	bt_uuid_t service_uuid;
-	int res;
-
-	if (service->primary)
-		res = bt_string_to_uuid(&service_uuid, service->prim.uuid);
-	else
-		res = bt_string_to_uuid(&service_uuid, service->incl.uuid);
-	if (res < 0)
-		return false;
-
-	return !bt_uuid_cmp(uuid, &service_uuid);
-}
-
-static struct service *find_service_by_uuid(struct gatt_device *device,
-								bt_uuid_t *uuid)
-{
-	return queue_find(device->services, match_service_by_uuid, uuid);
-}
-
 static void send_client_incl_service_notify(const struct service *prim,
 						const struct service *incl,
 						int32_t conn_id,
@@ -1284,7 +1272,6 @@ static void get_included_cb(uint8_t status, GSList *included, void *user_data)
 	struct get_included_data *data = user_data;
 	struct gatt_device *device = data->device;
 	struct service *service = data->prim;
-	bt_uuid_t uuid;
 	struct service *incl;
 
 	DBG("");
@@ -1296,7 +1283,9 @@ static void get_included_cb(uint8_t status, GSList *included, void *user_data)
 		return;
 	}
 
-	bt_string_to_uuid(&uuid, service->prim.uuid);
+	/* Remember that we already search included services.*/
+	service->incl_search_done = true;
+
 
 	for (; included; included = included->next) {
 		struct gatt_included *included_service = included->data;
@@ -1331,12 +1320,59 @@ static void get_included_cb(uint8_t status, GSList *included, void *user_data)
 								GATT_FAILURE);
 }
 
-static void handle_client_get_included_service(const void *buf, uint16_t len)
+static bool search_included_services(struct gatt_device *dev,
+							struct service *prim)
 {
-	const struct hal_cmd_gatt_client_get_included_service *cmd = buf;
 	struct get_included_data *data;
+
+	data = new0(struct get_included_data, 1);
+	if (!data) {
+		error("gatt: failed to allocate memory for included_data");
+		return false;
+	}
+
+	data->prim = prim;
+	data->device = dev;
+
+	gatt_find_included(dev->attrib, prim->prim.range.start,
+							prim->prim.range.end,
+							get_included_cb, data);
+	return true;
+}
+
+static bool find_service(int32_t conn_id, struct element_id *service_id,
+				struct gatt_device **dev, struct service **srvc)
+{
 	struct gatt_device *device;
 	struct service *service;
+
+	device = find_device_by_conn_id(conn_id);
+	if (!device) {
+		error("gatt: conn_id=%d not found", conn_id);
+		return false;
+	}
+
+	service = queue_find(device->services, match_srvc_by_element_id,
+								service_id);
+	if (!service) {
+		error("gatt: Service with inst_id: %d not found",
+							service_id->instance);
+		return false;
+	}
+
+	*dev = device;
+	*srvc = service;
+
+	return true;
+}
+
+static void handle_client_get_included_service(const void *buf, uint16_t len)
+{
+	const struct hal_cmd_gatt_client_get_included_service *cmd = buf;
+	struct gatt_device *device;
+	struct service *prim_service;
+	struct service *incl_service;
+	struct element_id match_id;
 	uint8_t status;
 
 	DBG("");
@@ -1348,44 +1384,40 @@ static void handle_client_get_included_service(const void *buf, uint16_t len)
 		return;
 	}
 
-	device = find_device_by_conn_id(cmd->conn_id);
-	if (!device) {
-		status = HAL_STATUS_FAILED;
-		goto reply;
-	}
-
-	if (queue_isempty(device->services)) {
+	hal_srvc_id_to_element_id(&cmd->srvc_id[0], &match_id);
+	if (!find_service(cmd->conn_id, &match_id, &device, &prim_service)) {
 		status = HAL_STATUS_FAILED;
 		goto reply;
 	}
 
-	if (!cmd->number) {
-		service = queue_peek_head(device->services);
-	} else {
-		bt_uuid_t uuid;
-
-		android2uuid(cmd->srvc_id->uuid, &uuid);
-		service = find_service_by_uuid(device, &uuid);
-	}
+	if (!prim_service->incl_search_done) {
+		if (search_included_services(device, prim_service))
+			status = HAL_STATUS_SUCCESS;
+		else
+			status = HAL_STATUS_FAILED;
 
-	if (!service) {
-		status = HAL_STATUS_FAILED;
 		goto reply;
 	}
 
-	data = new0(struct get_included_data, 1);
-	if (!data) {
-		error("gatt: failed to allocate memory for included_data");
-		status = HAL_STATUS_FAILED;
-		goto reply;
+	/* Try to use cache here */
+	if (cmd->number == 1) {
+		incl_service = queue_peek_head(prim_service->included);
+	} else {
+		uint8_t inst_id = cmd->srvc_id[1].inst_id;
+		incl_service = queue_find(prim_service->included,
+						match_srvc_by_higher_inst_id,
+						INT_TO_PTR(inst_id));
 	}
 
-	data->prim = service;
-	data->device = device;
-
-	gatt_find_included(device->attrib, service->prim.range.start,
-				service->prim.range.end, get_included_cb,
-				data);
+	/* Note that Android framework expects failure notification
+	 * which is treat as the end of included services
+	 */
+	if (!incl_service)
+		send_client_incl_service_notify(prim_service, NULL,
+						device->conn_id, GATT_FAILURE);
+	else
+		send_client_incl_service_notify(prim_service, incl_service,
+						device->conn_id, GATT_SUCCESS);
 
 	status = HAL_STATUS_SUCCESS;
 
@@ -1393,6 +1425,13 @@ reply:
 	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_GATT,
 					HAL_OP_GATT_CLIENT_GET_INCLUDED_SERVICE,
 					status);
+
+	/* In case of error in handling request we need to send event with
+	 * Android framework is stupid and do not check status of response
+	 */
+	if (status)
+		send_client_incl_service_notify(prim_service, NULL,
+						device->conn_id, GATT_FAILURE);
 }
 
 static void send_client_char_notify(const struct characteristic *ch,
@@ -1478,32 +1517,6 @@ static void discover_char_cb(uint8_t status, GSList *characteristics,
 	free(data);
 }
 
-static bool find_service(int32_t conn_id, struct element_id *service_id,
-				struct gatt_device **dev, struct service **srvc)
-{
-	struct gatt_device *device;
-	struct service *service;
-
-	device = find_device_by_conn_id(conn_id);
-	if (!device) {
-		error("gatt: conn_id=%d not found", conn_id);
-		return false;
-	}
-
-	service = queue_find(device->services, match_srvc_by_element_id,
-								service_id);
-	if (!service) {
-		error("gatt: Service with inst_id: %d not found",
-							service_id->instance);
-		return false;
-	}
-
-	*dev = device;
-	*srvc = service;
-
-	return true;
-}
-
 static void handle_client_get_characteristic(const void *buf, uint16_t len)
 {
 	const struct hal_cmd_gatt_client_get_characteristic *cmd = buf;
-- 
1.8.4

