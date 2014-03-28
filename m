Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv4 3/7] android/gatt: Add implementation of get_included_cb
Date: Fri, 28 Mar 2014 11:49:18 +0100
Message-Id: <1396003762-9350-3-git-send-email-marcin.kraglak@tieto.com>
In-Reply-To: <1396003762-9350-1-git-send-email-marcin.kraglak@tieto.com>
References: <1396003762-9350-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

It will pass found services to upper layer with notification.
Caching included services should be done later.
---
 android/gatt.c | 44 +++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 43 insertions(+), 1 deletion(-)

diff --git a/android/gatt.c b/android/gatt.c
index ac753b7..d6a0a2a 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -974,10 +974,52 @@ struct get_included_data {
 
 static void get_included_cb(uint8_t status, GSList *included, void *user_data)
 {
+	struct hal_ev_gatt_client_get_inc_service ev;
 	struct get_included_data *data = user_data;
+	struct gatt_device *device = data->device;
+	struct service *service = data->service;
+	bt_uuid_t uuid;
+
+	DBG("");
 
-	/* TODO pass included services to notification */
 	free(data);
+
+	if (status) {
+		error("gatt: no included services found");
+		return;
+	}
+
+	bt_string_to_uuid(&uuid, service->primary.uuid);
+
+	/* TODO store included services in device->services list */
+	for (; included; included = included->next) {
+		struct gatt_included *included_service = included->data;
+		bt_uuid_t included_uuid;
+
+		ev.conn_id = device->conn_id;
+		ev.status = HAL_STATUS_SUCCESS;
+
+		ev.srvc_id.inst_id = 0;
+		uuid2android(&uuid, ev.srvc_id.uuid);
+
+		ev.incl_srvc_id.inst_id = 0;
+		bt_string_to_uuid(&included_uuid, included_service->uuid);
+		uuid2android(&included_uuid, ev.incl_srvc_id.uuid);
+
+		ipc_send_notif(hal_ipc, HAL_SERVICE_ID_GATT ,
+					HAL_EV_GATT_CLIENT_GET_INC_SERVICE,
+					sizeof(ev), &ev);
+	}
+
+	/* Android expects notification with error status in the end */
+	ev.conn_id = device->conn_id;
+	ev.status = HAL_STATUS_FAILED;
+	ev.srvc_id.inst_id = 0;
+	uuid2android(&uuid, ev.srvc_id.uuid);
+
+	ipc_send_notif(hal_ipc, HAL_SERVICE_ID_GATT ,
+					HAL_EV_GATT_CLIENT_GET_INC_SERVICE,
+					sizeof(ev), &ev);
 }
 
 static void handle_client_get_included_service(const void *buf, uint16_t len)
-- 
1.8.3.1

