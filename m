Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <szymon.janc@tieto.com>,
	Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH 12/15] android/gatt: Add helper to send included service
Date: Tue, 8 Apr 2014 11:22:29 +0200
Message-ID: <1396948952-2035-13-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1396948952-2035-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1396948952-2035-1-git-send-email-lukasz.rymanowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/gatt.c | 57 +++++++++++++++++++++++++++++++++------------------------
 1 file changed, 33 insertions(+), 24 deletions(-)

diff --git a/android/gatt.c b/android/gatt.c
index 06dbf8b..1b48730 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -1252,6 +1252,28 @@ static struct service *find_service_by_uuid(struct gatt_device *device,
 	return queue_find(device->services, match_service_by_uuid, uuid);
 }
 
+static void send_client_incl_service_notify(const struct service *prim,
+						const struct service *incl,
+						int32_t conn_id,
+						int32_t status)
+{
+	struct hal_ev_gatt_client_get_inc_service ev;
+
+	memset(&ev, 0, sizeof(ev));
+
+	ev.conn_id = conn_id;
+	ev.status = status;
+
+	element_id_to_hal_srvc_id(&prim->id, 1, &ev.srvc_id);
+
+	if (incl)
+		element_id_to_hal_srvc_id(&incl->id, 0, &ev.incl_srvc_id);
+
+	ipc_send_notif(hal_ipc, HAL_SERVICE_ID_GATT ,
+					HAL_EV_GATT_CLIENT_GET_INC_SERVICE,
+					sizeof(ev), &ev);
+}
+
 struct get_included_data {
 	struct service *prim;
 	struct gatt_device *device;
@@ -1259,11 +1281,11 @@ struct get_included_data {
 
 static void get_included_cb(uint8_t status, GSList *included, void *user_data)
 {
-	struct hal_ev_gatt_client_get_inc_service ev;
 	struct get_included_data *data = user_data;
 	struct gatt_device *device = data->device;
 	struct service *service = data->prim;
 	bt_uuid_t uuid;
+	struct service *incl;
 
 	DBG("");
 
@@ -1278,8 +1300,6 @@ static void get_included_cb(uint8_t status, GSList *included, void *user_data)
 
 	for (; included; included = included->next) {
 		struct gatt_included *included_service = included->data;
-		bt_uuid_t included_uuid;
-		struct service *incl;
 
 		incl = create_service(false, included_service->uuid,
 							included_service);
@@ -1296,30 +1316,19 @@ static void get_included_cb(uint8_t status, GSList *included, void *user_data)
 			free(incl);
 			continue;
 		}
-		ev.conn_id = device->conn_id;
-		ev.status = GATT_SUCCESS;
-
-		ev.srvc_id.inst_id = 0;
-		uuid2android(&uuid, ev.srvc_id.uuid);
-
-		ev.incl_srvc_id.inst_id = 0;
-		bt_string_to_uuid(&included_uuid, included_service->uuid);
-		uuid2android(&included_uuid, ev.incl_srvc_id.uuid);
-
-		ipc_send_notif(hal_ipc, HAL_SERVICE_ID_GATT ,
-					HAL_EV_GATT_CLIENT_GET_INC_SERVICE,
-					sizeof(ev), &ev);
 	}
 
-	/* Android expects notification with error status in the end */
-	ev.conn_id = device->conn_id;
-	ev.status = GATT_FAILURE;
-	ev.srvc_id.inst_id = 0;
-	uuid2android(&uuid, ev.srvc_id.uuid);
+	/* Notify upper layer about first included service.
+	 * Android framework will iterate for next one.
+	 */
+	incl = queue_peek_head(service->included);
 
-	ipc_send_notif(hal_ipc, HAL_SERVICE_ID_GATT ,
-					HAL_EV_GATT_CLIENT_GET_INC_SERVICE,
-					sizeof(ev), &ev);
+	if (incl)
+		send_client_incl_service_notify(service,incl, device->conn_id,
+								GATT_SUCCESS);
+	else
+		send_client_incl_service_notify(service, NULL, device->conn_id,
+								GATT_FAILURE);
 }
 
 static void handle_client_get_included_service(const void *buf, uint16_t len)
-- 
1.8.4

