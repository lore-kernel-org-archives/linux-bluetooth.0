Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/3] android/gatt: Add support for uuid filter in search services
Date: Fri, 11 Apr 2014 12:29:49 +0200
Message-Id: <1397212190-3240-2-git-send-email-grzegorz.kolodziejczyk@tieto.com>
In-Reply-To: <1397212190-3240-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1397212190-3240-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This adds support for filtering by uuid in searched services.
---
 android/gatt.c | 140 ++++++++++++++++++++++++++++++++++++++++-----------------
 1 file changed, 99 insertions(+), 41 deletions(-)

diff --git a/android/gatt.c b/android/gatt.c
index 4e548c8..33acf71 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -314,6 +314,14 @@ static bool match_char_by_higher_inst_id(const void *data,
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
@@ -523,22 +531,6 @@ static void send_client_primary_notify(void *data, void *user_data)
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
@@ -587,27 +579,20 @@ static struct service *create_service(uint8_t id, bool primary, char *uuid,
 	return s;
 }
 
-static void primary_cb(uint8_t status, GSList *services, void *user_data)
+static void primary_cb(uint8_t status, GSList *services,
+						struct gatt_device *dev)
 {
-	struct gatt_device *dev = user_data;
 	GSList *l;
-	int32_t gatt_status;
 	uint8_t instance_id;
 
 	DBG("Status %d", status);
 
-	if (status) {
+	if (status)
 		error("gatt: Discover all primary services failed: %s",
 							att_ecode2str(status));
-		gatt_status = GATT_FAILURE;
-		goto done;
-	}
 
-	if (!services) {
+	if (!services)
 		info("gatt: No primary services found");
-		gatt_status = GATT_SUCCESS;
-		goto done;
-	}
 
 	/* There might be multiply services with same uuid. Therefore make sure
 	 * each primary service one has unique instance_id
@@ -631,11 +616,6 @@ static void primary_cb(uint8_t status, GSList *services, void *user_data)
 		DBG("attr handle = 0x%04x, end grp handle = 0x%04x uuid: %s",
 			prim->range.start, prim->range.end, prim->uuid);
 	}
-
-	gatt_status = GATT_SUCCESS;
-
-done:
-	send_client_all_primary(gatt_status, dev->services, dev->conn_id);
 }
 
 static void connection_cleanup(struct gatt_device *device)
@@ -1202,11 +1182,59 @@ static void handle_client_refresh(const void *buf, uint16_t len)
 							HAL_STATUS_FAILED);
 }
 
+struct discover_srvc_data {
+	bt_uuid_t uuid;
+	struct gatt_device *dev;
+	bool number;
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
+static void discover_srvc_cb(uint8_t status, GSList *services, void *user_data)
+{
+	struct discover_srvc_data *cb_data = user_data;
+	struct service *s;
+
+	/* Caching primary and included services from remote */
+	primary_cb(status, services, cb_data->dev);
+
+	/* Send filtered service by uuid */
+	if (cb_data->number) {
+		s = queue_find(cb_data->dev->services, match_srvc_by_bt_uuid,
+								&cb_data->uuid);
+		if (s)
+			send_client_primary_notify(s,
+					INT_TO_PTR(cb_data->dev->conn_id));
+		else
+			error("gatt: Service with given UUID not found");
+	} else {
+		/* Send all found services */
+		queue_foreach(cb_data->dev->services,
+					send_client_primary_notify,
+					INT_TO_PTR(cb_data->dev->conn_id));
+	}
+
+	send_client_search_complete_notify(GATT_SUCCESS,
+							cb_data->dev->conn_id);
+	free(cb_data);
+}
+
 static void handle_client_search_service(const void *buf, uint16_t len)
 {
 	const struct hal_cmd_gatt_client_search_service *cmd = buf;
 	struct gatt_device *dev;
 	uint8_t status;
+	struct service *s;
+	bt_uuid_t uuid;
+	bool number;
 
 	DBG("");
 
@@ -1217,26 +1245,56 @@ static void handle_client_search_service(const void *buf, uint16_t len)
 		goto reply;
 	}
 
-	/*TODO:  Handle filter uuid */
+	number = cmd->number;
+
+	if (number)
+		android2uuid(cmd->filter_uuid, &uuid);
+
+	if (queue_isempty(dev->services)) {
+		struct discover_srvc_data *cb_data =
+					new0(struct discover_srvc_data, 1);
+
+		if (!cb_data) {
+			error("gatt: Cannot allocate cb data");
+			status = HAL_STATUS_FAILED;
+			goto reply;
+		}
+
+		cb_data->dev = dev;
+		cb_data->number = number;
+		if (number)
+			memcpy(&cb_data->uuid, &uuid, sizeof(cb_data->uuid));
+
+		if (!gatt_discover_primary(dev->attrib, NULL, discover_srvc_cb,
+								cb_data)) {
+			free(cb_data);
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
+		s = queue_find(dev->services, match_srvc_by_bt_uuid, &uuid);
+
+		if (s)
+			send_client_primary_notify(s, INT_TO_PTR(dev->conn_id));
+		else
+			error("gatt: Service with given UUID not found");
+	} else {
+		queue_foreach(dev->services, send_client_primary_notify,
+						INT_TO_PTR(dev->conn_id));
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

