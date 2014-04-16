Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/2] android/gatt: Add support for uuid filter in search services
Date: Wed, 16 Apr 2014 12:06:53 +0200
Message-Id: <1397642813-18424-2-git-send-email-grzegorz.kolodziejczyk@tieto.com>
In-Reply-To: <1397642813-18424-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1397642813-18424-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This adds support for filtering by uuid in searched services. If device
is scanned for service by uuid, if found - will be added to cache and
partial service search flag will be set. While performing whole services
device scan then if partial scan was performed earlier, service cache
will be refreshed.
---
 android/gatt.c | 295 +++++++++++++++++++++++++++++++++++++++++----------------
 1 file changed, 213 insertions(+), 82 deletions(-)

diff --git a/android/gatt.c b/android/gatt.c
index 9163f6d..ff5472b 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -124,6 +124,7 @@ struct gatt_device {
 	GAttrib *attrib;
 	GIOChannel *att_io;
 	struct queue *services;
+	bool partial_srvc_scan;
 
 	guint watch_id;
 };
@@ -356,6 +357,14 @@ static bool match_char_by_higher_inst_id(const void *data,
 	return inst_id < ch->id.instance;
 }
 
+static bool match_srvc_by_bt_uuid(const void *data, const void *user_data)
+{
+	const bt_uuid_t *exp_uuid = user_data;
+	const struct service *service = data;
+
+	return !bt_uuid_cmp(exp_uuid, &service->id.uuid);
+}
+
 static bool match_descr_by_element_id(const void *data, const void *user_data)
 {
 	const struct element_id *exp_id = user_data;
@@ -576,22 +585,6 @@ static void send_client_primary_notify(void *data, void *user_data)
 					sizeof(ev), &ev);
 }
 
-static void send_client_all_primary(int32_t status, struct queue *services,
-							int32_t conn_id)
-{
-	struct hal_ev_gatt_client_search_complete ev;
-
-	if (!status)
-		queue_foreach(services, send_client_primary_notify,
-							INT_TO_PTR(conn_id));
-
-	ev.status = status;
-	ev.conn_id = conn_id;
-	ipc_send_notif(hal_ipc, HAL_SERVICE_ID_GATT,
-			HAL_EV_GATT_CLIENT_SEARCH_COMPLETE, sizeof(ev), &ev);
-
-}
-
 static struct service *create_service(uint8_t id, bool primary, char *uuid,
 								void *data)
 {
@@ -639,63 +632,6 @@ static struct service *create_service(uint8_t id, bool primary, char *uuid,
 	return s;
 }
 
-static void primary_cb(uint8_t status, GSList *services, void *user_data)
-{
-	struct gatt_device *dev = user_data;
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
-	if (!queue_isempty(dev->services)) {
-		info("gatt: Services already cached");
-		gatt_status = GATT_SUCCESS;
-		goto done;
-	}
-
-	/* There might be multiply services with same uuid. Therefore make sure
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
-		if (!queue_push_tail(dev->services, p)) {
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
-	send_client_all_primary(gatt_status, dev->services, dev->conn_id);
-}
-
 static void connection_cleanup(struct gatt_device *device)
 {
 	if (device->watch_id) {
@@ -1282,11 +1218,175 @@ done:
 									status);
 }
 
+struct discover_srvc_data {
+	bt_uuid_t uuid;
+	struct gatt_device *dev;
+	uint8_t number;
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
+	int32_t gatt_status;
+	GSList *l;
+	/* There might be multiply services with same uuid. Therefore make sure
+	 * each primary service one has unique instance_id
+	 */
+	uint8_t instance_id = 0;
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
+		p = create_service(instance_id++, true, prim->uuid, prim);
+		if (!p)
+			continue;
+
+		if (!queue_push_tail(cb_data->dev->services, p)) {
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
+	queue_foreach(cb_data->dev->services, send_client_primary_notify,
+					INT_TO_PTR(cb_data->dev->conn_id));
+
+	/* Full search service scanning was performed */
+	cb_data->dev->partial_srvc_scan = false;
+	gatt_status = GATT_SUCCESS;
+
+reply:
+	send_client_search_complete_notify(gatt_status, cb_data->dev->conn_id);
+	free(cb_data);
+}
+
+static void discover_srvc_by_uuid_cb(uint8_t status, GSList *ranges,
+								void *user_data)
+{
+	struct discover_srvc_data *cb_data = user_data;
+	struct gatt_primary *prim;
+	struct service *s;
+	int32_t gatt_status;
+	uint8_t instance_id = queue_length(cb_data->dev->services);
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
+		info("gatt: No primary services found");
+		gatt_status = GATT_SUCCESS;
+		goto reply;
+	}
+
+	prim = new0(struct gatt_primary, 1);
+	if (!prim) {
+		error("gatt: Error while caching primary service");
+		return;
+	}
+
+	bt_uuid_to_string(&cb_data->uuid, prim->uuid,
+						sizeof(prim->uuid));
+	/* If multiple instances of the same service (as identified by UUID)
+	 * exist, the first instance of the service is returned.
+	 */
+	memcpy(&prim->range, ranges->data, sizeof(prim->range));
+
+	s = create_service(instance_id++, true, prim->uuid, prim);
+	if (!s)
+		return;
+
+	if (!queue_push_tail(cb_data->dev->services, s)) {
+		error("gatt: Cannot push primary service to the list");
+		free(s);
+		return;
+	}
+
+	send_client_primary_notify(s, INT_TO_PTR(cb_data->dev->conn_id));
+
+	DBG("attr handle = 0x%04x, end grp handle = 0x%04x uuid: %s",
+		prim->range.start, prim->range.end, prim->uuid);
+
+	/* Partial search service scanning was performed */
+	cb_data->dev->partial_srvc_scan = true;
+	gatt_status = GATT_SUCCESS;
+
+reply:
+	send_client_search_complete_notify(gatt_status, cb_data->dev->conn_id);
+	free(cb_data);
+}
+
+static guint scan_dev_for_srvc(struct gatt_device *dev, bool number,
+								bt_uuid_t *uuid)
+{
+	struct discover_srvc_data *cb_data =
+					new0(struct discover_srvc_data, 1);
+
+	if (!cb_data) {
+		error("gatt: Cannot allocate cb data");
+		return 0;
+	}
+
+	cb_data->dev = dev;
+	cb_data->number = number;
+
+	if (number) {
+		memcpy(&cb_data->uuid, uuid, sizeof(cb_data->uuid));
+		return gatt_discover_primary(dev->attrib, uuid,
+					discover_srvc_by_uuid_cb, cb_data);
+	} else {
+		return gatt_discover_primary(dev->attrib, NULL,
+						discover_srvc_all_cb, cb_data);
+	}
+}
+
 static void handle_client_search_service(const void *buf, uint16_t len)
 {
 	const struct hal_cmd_gatt_client_search_service *cmd = buf;
 	struct gatt_device *dev;
 	uint8_t status;
+	struct service *s;
+	bt_uuid_t uuid;
+	uint8_t number;
+	guint srvc_scan_success;
 
 	DBG("");
 
@@ -1297,26 +1397,57 @@ static void handle_client_search_service(const void *buf, uint16_t len)
 		goto reply;
 	}
 
-	/*TODO:  Handle filter uuid */
+	number = cmd->number;
+
+	if (number)
+		android2uuid(cmd->filter_uuid, &uuid);
+
+	if (queue_isempty(dev->services)) {
+		if (number)
+			srvc_scan_success = scan_dev_for_srvc(dev, 1, &uuid);
+		else
+			srvc_scan_success = scan_dev_for_srvc(dev, 0, NULL);
+
+		if (!srvc_scan_success) {
+			status = HAL_STATUS_FAILED;
+			goto reply;
+		}
 
-	/* Use cache if possible */
-	if (!queue_isempty(dev->services)) {
 		status = HAL_STATUS_SUCCESS;
-		send_client_all_primary(GATT_SUCCESS, dev->services,
-								dev->conn_id);
 		goto reply;
 	}
 
-	if (!gatt_discover_primary(dev->attrib, NULL, primary_cb, dev)) {
-		status = HAL_STATUS_FAILED;
-		goto reply;
+	if (number) {
+		/* Search in cache for service by uuid */
+		s = queue_find(dev->services, match_srvc_by_bt_uuid, &uuid);
+
+		if (s) {
+			send_client_primary_notify(s, INT_TO_PTR(dev->conn_id));
+		} else {
+			if (!scan_dev_for_srvc(dev, 1, &uuid))
+				status = HAL_STATUS_FAILED;
+
+			status = HAL_STATUS_SUCCESS;
+			goto reply;
+		}
+	} else {
+		/* Refresh service cache if only partial search was performed */
+		if (dev->partial_srvc_scan) {
+			queue_remove_all(dev->services, NULL, NULL, NULL);
+			srvc_scan_success = scan_dev_for_srvc(dev, 0, NULL);
+		} else {
+			queue_foreach(dev->services, send_client_primary_notify,
+						INT_TO_PTR(cmd->conn_id));
+		}
 	}
 
+	send_client_search_complete_notify(GATT_SUCCESS, dev->conn_id);
+
 	status = HAL_STATUS_SUCCESS;
 
 reply:
 	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_GATT,
-			HAL_OP_GATT_CLIENT_SEARCH_SERVICE, status);
+				HAL_OP_GATT_CLIENT_SEARCH_SERVICE, status);
 }
 
 static void send_client_incl_service_notify(const struct service *prim,
-- 
1.9.1

