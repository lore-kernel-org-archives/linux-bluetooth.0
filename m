Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <szymon.janc@tieto.com>,
	Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH 03/15] android/gatt: Add helper functions to send all primary services
Date: Tue, 8 Apr 2014 11:22:20 +0200
Message-ID: <1396948952-2035-4-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1396948952-2035-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1396948952-2035-1-git-send-email-lukasz.rymanowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds helper functions to send all the primary services.
This will be useful for following patches where we want to send to
client cached data.
---
 android/gatt.c | 64 +++++++++++++++++++++++++++++++++++++++++-----------------
 1 file changed, 45 insertions(+), 19 deletions(-)

diff --git a/android/gatt.c b/android/gatt.c
index 8b0833c..f4cf569 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -479,29 +479,67 @@ failed:
 					HAL_OP_GATT_CLIENT_UNREGISTER, status);
 }
 
-static void primary_cb(uint8_t status, GSList *services, void *user_data)
+static void send_client_primary_notify(void *data, void *user_data)
+{
+	struct hal_ev_gatt_client_search_result ev;
+	struct service *p = data;
+	int32_t conn_id = PTR_TO_INT(user_data);
+
+	/* In service queue we will have also included services */
+	if (!p->primary)
+		return;
+
+	ev.conn_id  = conn_id;
+	element_id_to_hal_srvc_id(&p->id, 1, &ev.srvc_id);
+
+	uuid2android(&p->id.uuid, ev.srvc_id.uuid);
+
+	ipc_send_notif(hal_ipc, HAL_SERVICE_ID_GATT,
+					HAL_EV_GATT_CLIENT_SEARCH_RESULT,
+					sizeof(ev), &ev);
+}
+
+static void send_client_all_primary(int32_t status, struct queue *services,
+							int32_t conn_id)
 {
 	struct hal_ev_gatt_client_search_complete ev;
+
+	if (status)
+		goto done;
+
+	queue_foreach(services, send_client_primary_notify,
+						INT_TO_PTR(conn_id));
+
+done:
+	ev.status = status;
+	ev.conn_id = conn_id;
+	ipc_send_notif(hal_ipc, HAL_SERVICE_ID_GATT,
+			HAL_EV_GATT_CLIENT_SEARCH_COMPLETE, sizeof(ev), &ev);
+
+}
+
+static void primary_cb(uint8_t status, GSList *services, void *user_data)
+{
 	struct gatt_device *dev = user_data;
 	GSList *l;
+	int32_t gatt_status;
 
 	DBG("Status %d", status);
 
 	if (status) {
 		error("gatt: Discover all primary services failed: %s",
 							att_ecode2str(status));
-		ev.status = GATT_FAILURE;
+		gatt_status = GATT_FAILURE;
 		goto done;
 	}
 
 	if (!services) {
 		info("gatt: No primary services found");
-		ev.status = GATT_SUCCESS;
+		gatt_status = GATT_SUCCESS;
 		goto done;
 	}
 
 	for (l = services; l; l = l->next) {
-		struct hal_ev_gatt_client_search_result ev_res;
 		struct gatt_primary *prim = l->data;
 		struct service *p;
 
@@ -518,8 +556,6 @@ static void primary_cb(uint8_t status, GSList *services, void *user_data)
 			continue;
 		}
 
-		memset(&ev_res, 0, sizeof(ev_res));
-
 		if (bt_string_to_uuid(&p->id.uuid, prim->uuid) < 0) {
 			error("gatt: Cannot convert string to uuid");
 			continue;
@@ -536,23 +572,13 @@ static void primary_cb(uint8_t status, GSList *services, void *user_data)
 		}
 
 		DBG("attr handle = 0x%04x, end grp handle = 0x%04x uuid: %s",
-				prim->range.start, prim->range.end, prim->uuid);
-
-		/* Set event data */
-		ev_res.conn_id  = dev->conn_id;
-		element_id_to_hal_srvc_id(&p->id, 1, &ev_res.srvc_id);
-
-		ipc_send_notif(hal_ipc, HAL_SERVICE_ID_GATT ,
-					HAL_EV_GATT_CLIENT_SEARCH_RESULT,
-					sizeof(ev_res), &ev_res);
+			prim->range.start, prim->range.end, prim->uuid);
 	}
 
-	ev.status = GATT_SUCCESS;
+	gatt_status = GATT_SUCCESS;
 
 done:
-	ev.conn_id = dev->conn_id;
-	ipc_send_notif(hal_ipc, HAL_SERVICE_ID_GATT,
-			HAL_EV_GATT_CLIENT_SEARCH_COMPLETE, sizeof(ev), &ev);
+	send_client_all_primary(gatt_status, dev->services, dev->conn_id);
 }
 
 static void connection_cleanup(struct gatt_device *device)
-- 
1.8.4

