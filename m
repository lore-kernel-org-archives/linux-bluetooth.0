Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v4 2/2] android/gatt: Add support for uuid filter in search services
Date: Thu,  8 May 2014 15:30:53 +0200
Message-Id: <1399555853-11553-2-git-send-email-grzegorz.kolodziejczyk@tieto.com>
In-Reply-To: <1399555853-11553-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1399555853-11553-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This adds support for filtering by uuid in searched services. If device
is scanned for service by uuid, if found - will be added to cache and
partial service search flag will be set. While performing whole services
device scan then if partial scan was performed earlier, service cache
will be refreshed.
---
 android/gatt.c | 311 +++++++++++++++++++++++++++++++++++++++++----------------
 1 file changed, 223 insertions(+), 88 deletions(-)

diff --git a/android/gatt.c b/android/gatt.c
index da68adc..ccb3efb 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -147,6 +147,7 @@ struct gatt_device {
 	GAttrib *attrib;
 	GIOChannel *att_io;
 	struct queue *services;
+	bool partial_srvc_search;
 
 	bool notify_services_changed;
 
@@ -416,6 +417,22 @@ static bool match_srvc_by_higher_inst_id(const void *data,
 	return inst_id < s->id.instance;
 }
 
+static bool match_srvc_by_bt_uuid(const void *data, const void *user_data)
+{
+	const bt_uuid_t *exp_uuid = user_data;
+	const struct service *service = data;
+
+	return !bt_uuid_cmp(exp_uuid, &service->id.uuid);
+}
+
+static bool match_srvc_by_range(const void *data, const void *user_data)
+{
+	const struct service *srvc = data;
+	const struct att_range *range = user_data;
+
+	return !memcmp(&srvc->prim.range, range, sizeof(srvc->prim.range));
+}
+
 static bool match_char_by_higher_inst_id(const void *data,
 							const void *user_data)
 {
@@ -808,22 +825,6 @@ static void send_client_primary_notify(void *data, void *user_data)
 			HAL_EV_GATT_CLIENT_SEARCH_RESULT, sizeof(ev), &ev);
 }
 
-static void send_client_all_primary(struct app_connection *connection,
-								int32_t status)
-{
-	struct hal_ev_gatt_client_search_complete ev;
-
-	if (!status)
-		queue_foreach(connection->device->services,
-						send_client_primary_notify,
-						INT_TO_PTR(connection->id));
-
-	ev.status = status;
-	ev.conn_id = connection->id;
-	ipc_send_notif(hal_ipc, HAL_SERVICE_ID_GATT,
-			HAL_EV_GATT_CLIENT_SEARCH_COMPLETE, sizeof(ev), &ev);
-}
-
 static struct service *create_service(uint8_t id, bool primary, char *uuid,
 								void *data)
 {
@@ -871,64 +872,6 @@ static struct service *create_service(uint8_t id, bool primary, char *uuid,
 	return s;
 }
 
-static void primary_cb(uint8_t status, GSList *services, void *user_data)
-{
-	struct app_connection *conn = user_data;
-	GSList *l;
-	int32_t gatt_status;
-	uint8_t instance_id;
-
-	DBG("Status %d", status);
-
-	if (status) {
-		error("gatt: Discover all primary services failed: %s",
-							att_ecode2str(status));
-		gatt_status = GATT_FAILURE;
-		goto done;
-	}
-
-	if (!services) {
-		info("gatt: No primary services found");
-		gatt_status = GATT_SUCCESS;
-		goto done;
-	}
-
-	if (!queue_isempty(conn->device->services)) {
-		info("gatt: Services already cached");
-		gatt_status = GATT_SUCCESS;
-		goto done;
-	}
-
-	/*
-	 * There might be multiply services with same uuid. Therefore make sure
-	 * each primary service one has unique instance_id
-	 */
-	instance_id = 0;
-
-	for (l = services; l; l = l->next) {
-		struct gatt_primary *prim = l->data;
-		struct service *p;
-
-		p = create_service(instance_id++, true, prim->uuid, prim);
-		if (!p)
-			continue;
-
-		if (!queue_push_tail(conn->device->services, p)) {
-			error("gatt: Cannot push primary service to the list");
-			free(p);
-			continue;
-		}
-
-		DBG("attr handle = 0x%04x, end grp handle = 0x%04x uuid: %s",
-			prim->range.start, prim->range.end, prim->uuid);
-	}
-
-	gatt_status = GATT_SUCCESS;
-
-done:
-	send_client_all_primary(conn, gatt_status);
-}
-
 static void le_device_found_handler(const bdaddr_t *addr, uint8_t addr_type,
 						int rssi, uint16_t eir_len,
 							const void *eir,
@@ -1568,11 +1511,173 @@ done:
 									status);
 }
 
+struct discover_srvc_data {
+	bt_uuid_t uuid;
+	struct app_connection *conn;
+};
+
+static void send_client_search_complete_notify(int32_t status, int32_t conn_id)
+{
+	struct hal_ev_gatt_client_search_complete ev;
+
+	ev.status = status;
+	ev.conn_id = conn_id;
+	ipc_send_notif(hal_ipc, HAL_SERVICE_ID_GATT,
+			HAL_EV_GATT_CLIENT_SEARCH_COMPLETE, sizeof(ev), &ev);
+}
+
+static void discover_srvc_all_cb(uint8_t status, GSList *services,
+								void *user_data)
+{
+	struct discover_srvc_data *cb_data = user_data;
+	struct gatt_device *dev = cb_data->conn->device;
+	int32_t gatt_status;
+	GSList *l;
+	/*
+	 * There might be multiply services with same uuid. Therefore make sure
+	 * each primary service one has unique instance_id
+	 */
+	uint8_t instance_id = queue_length(dev->services);
+
+	DBG("Status %d", status);
+
+	if (status) {
+		error("gatt: Discover all primary services failed: %s",
+							att_ecode2str(status));
+		gatt_status = GATT_FAILURE;
+		goto reply;
+	}
+
+	if (!services) {
+		info("gatt: No primary services found");
+		gatt_status = GATT_SUCCESS;
+		goto reply;
+	}
+
+	for (l = services; l; l = l->next) {
+		struct gatt_primary *prim = l->data;
+		struct service *p;
+
+		if (queue_find(dev->services, match_srvc_by_range,
+								&prim->range))
+			continue;
+
+		p = create_service(instance_id++, true, prim->uuid, prim);
+		if (!p)
+			continue;
+
+		if (!queue_push_tail(dev->services, p)) {
+			error("gatt: Cannot push primary service to the list");
+			free(p);
+			continue;
+		}
+
+		DBG("attr handle = 0x%04x, end grp handle = 0x%04x uuid: %s",
+			prim->range.start, prim->range.end, prim->uuid);
+	}
+
+	/* Send all found services notifications - first cache,
+	 * then send notifies
+	 */
+	queue_foreach(dev->services, send_client_primary_notify,
+						INT_TO_PTR(cb_data->conn->id));
+
+	/* Full search service scanning was performed */
+	dev->partial_srvc_search = false;
+	gatt_status = GATT_SUCCESS;
+
+reply:
+	send_client_search_complete_notify(gatt_status, cb_data->conn->id);
+	free(cb_data);
+}
+
+static void discover_srvc_by_uuid_cb(uint8_t status, GSList *ranges,
+								void *user_data)
+{
+	struct discover_srvc_data *cb_data = user_data;
+	struct gatt_primary prim;
+	struct service *s;
+	int32_t gatt_status;
+	struct gatt_device *dev = cb_data->conn->device;
+	uint8_t instance_id = queue_length(dev->services);
+
+	DBG("Status %d", status);
+
+	if (status) {
+		error("gatt: Discover pri srvc filtered by uuid failed: %s",
+							att_ecode2str(status));
+		gatt_status = GATT_FAILURE;
+		goto reply;
+	}
+
+	if (!ranges) {
+		info("gatt: No primary services searched by uuid found");
+		gatt_status = GATT_SUCCESS;
+		goto reply;
+	}
+
+	bt_uuid_to_string(&cb_data->uuid, prim.uuid, sizeof(prim.uuid));
+	/* If multiple instances of the same service (as identified by UUID)
+	 * exist, the first instance of the service is returned.
+	 */
+	memcpy(&prim.range, ranges->data, sizeof(prim.range));
+
+	s = create_service(instance_id++, true, prim.uuid, &prim);
+	if (!s) {
+		gatt_status = GATT_FAILURE;
+		goto reply;
+	}
+
+	if (!queue_push_tail(dev->services, s)) {
+		error("gatt: Cannot push primary service to the list");
+		gatt_status = GATT_FAILURE;
+		goto reply;
+	}
+
+	send_client_primary_notify(s, INT_TO_PTR(cb_data->conn->id));
+
+	DBG("attr handle = 0x%04x, end grp handle = 0x%04x uuid: %s",
+		prim.range.start, prim.range.end, prim.uuid);
+
+	/* Partial search service scanning was performed */
+	dev->partial_srvc_search = true;
+	gatt_status = GATT_SUCCESS;
+
+reply:
+	send_client_search_complete_notify(gatt_status, cb_data->conn->id);
+	free(cb_data);
+}
+
+static guint search_dev_for_srvc(struct app_connection *conn, bt_uuid_t *uuid)
+{
+	struct discover_srvc_data *cb_data =
+					new0(struct discover_srvc_data, 1);
+
+	if (!cb_data) {
+		error("gatt: Cannot allocate cb data");
+		return 0;
+	}
+
+	cb_data->conn = conn;
+
+	if (uuid) {
+		memcpy(&cb_data->uuid, uuid, sizeof(cb_data->uuid));
+		return gatt_discover_primary(conn->device->attrib, uuid,
+					discover_srvc_by_uuid_cb, cb_data);
+	} else {
+		return gatt_discover_primary(conn->device->attrib, NULL,
+						discover_srvc_all_cb, cb_data);
+	}
+}
+
 static void handle_client_search_service(const void *buf, uint16_t len)
 {
 	const struct hal_cmd_gatt_client_search_service *cmd = buf;
 	struct app_connection *conn;
 	uint8_t status;
+	struct service *s;
+	bt_uuid_t uuid;
+	guint srvc_search_success;
 
 	DBG("");
 
@@ -1591,16 +1696,6 @@ static void handle_client_search_service(const void *buf, uint16_t len)
 		goto reply;
 	}
 
-	/* TODO:  Handle filter uuid */
-
-	/* Use cache if possible */
-	if (!queue_isempty(conn->device->services)) {
-		send_client_all_primary(conn, GATT_SUCCESS);
-
-		status = HAL_STATUS_SUCCESS;
-		goto reply;
-	}
-
 	if (conn->device->state != DEVICE_CONNECTED) {
 		char bda[18];
 
@@ -1611,17 +1706,57 @@ static void handle_client_search_service(const void *buf, uint16_t len)
 		goto reply;
 	}
 
-	if (!gatt_discover_primary(conn->device->attrib, NULL, primary_cb,
-									conn)) {
-		status = HAL_STATUS_FAILED;
+	if (cmd->filtered)
+		android2uuid(cmd->filter_uuid, &uuid);
+
+	/* Services not cached yet */
+	if (queue_isempty(conn->device->services)) {
+		if (cmd->filtered)
+			srvc_search_success = search_dev_for_srvc(conn, &uuid);
+		else
+			srvc_search_success = search_dev_for_srvc(conn, NULL);
+
+		if (!srvc_search_success) {
+			status = HAL_STATUS_FAILED;
+			goto reply;
+		}
+
+		status = HAL_STATUS_SUCCESS;
 		goto reply;
 	}
 
+	/* Search in cached services for given service */
+	if (cmd->filtered) {
+		/* Search in cache for service by uuid */
+		s = queue_find(conn->device->services, match_srvc_by_bt_uuid,
+									&uuid);
+
+		if (s) {
+			send_client_primary_notify(s, INT_TO_PTR(conn->id));
+		} else {
+			if (!search_dev_for_srvc(conn, &uuid))
+				status = HAL_STATUS_FAILED;
+
+			status = HAL_STATUS_SUCCESS;
+			goto reply;
+		}
+	} else {
+		/* Refresh service cache if only partial search was performed */
+		if (conn->device->partial_srvc_search)
+			srvc_search_success = search_dev_for_srvc(conn, NULL);
+		else
+			queue_foreach(conn->device->services,
+						send_client_primary_notify,
+						INT_TO_PTR(cmd->conn_id));
+	}
+
+	send_client_search_complete_notify(GATT_SUCCESS, conn->id);
+
 	status = HAL_STATUS_SUCCESS;
 
 reply:
 	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_GATT,
-			HAL_OP_GATT_CLIENT_SEARCH_SERVICE, status);
+				HAL_OP_GATT_CLIENT_SEARCH_SERVICE, status);
 }
 
 static void send_client_incl_service_notify(const struct element_id *srvc_id,
-- 
1.9.2

