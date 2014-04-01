Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCHv2 2/3] android/gatt: Add helpers for element_id to hal structs conversion
Date: Tue,  1 Apr 2014 10:03:23 +0200
Message-Id: <1396339404-14418-2-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1396339404-14418-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1396339404-14418-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

We have helpers for hal structs to element_id conversion, so we should
use symetrical element_id to hal struct helpers when sending
notifications.
---
 android/gatt.c | 45 +++++++++++++++++++++++----------------------
 1 file changed, 23 insertions(+), 22 deletions(-)

diff --git a/android/gatt.c b/android/gatt.c
index 39195f0..37a1986 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -142,6 +142,15 @@ static void hal_srvc_id_to_element_id(const struct hal_gatt_srvc_id *from,
 	android2uuid(from->uuid, &to->uuid);
 }
 
+static void element_id_to_hal_srvc_id(const struct element_id *from,
+						uint8_t primary,
+						struct hal_gatt_srvc_id *to)
+{
+	to->is_primary = primary;
+	to->inst_id = from->instance;
+	uuid2android(&from->uuid, to->uuid);
+}
+
 static void hal_gatt_id_to_element_id(const struct hal_gatt_gatt_id *from,
 							struct element_id *to)
 {
@@ -149,6 +158,13 @@ static void hal_gatt_id_to_element_id(const struct hal_gatt_gatt_id *from,
 	android2uuid(from->uuid, &to->uuid);
 }
 
+static void element_id_to_hal_gatt_id(const struct element_id *from,
+						struct hal_gatt_gatt_id *to)
+{
+	to->inst_id = from->instance;
+	uuid2android(&from->uuid, to->uuid);
+}
+
 static void destroy_service(void *data)
 {
 	struct service *srvc = data;
@@ -468,10 +484,7 @@ static void primary_cb(uint8_t status, GSList *services, void *user_data)
 
 		/* Set event data */
 		ev_res.conn_id  = dev->conn_id;
-		ev_res.srvc_id.is_primary = 1;
-		ev_res.srvc_id.inst_id = 0;
-
-		uuid2android(&p->id.uuid, ev_res.srvc_id.uuid);
+		element_id_to_hal_srvc_id(&p->id, 1, &ev_res.srvc_id);
 
 		ipc_send_notif(hal_ipc, HAL_SERVICE_ID_GATT ,
 					HAL_EV_GATT_CLIENT_SEARCH_RESULT,
@@ -1206,16 +1219,12 @@ static void send_client_char_notify(const struct characteristic *ch,
 
 	if (ch) {
 		ev.char_prop = ch->ch.properties;
-
-		ev.char_id.inst_id = ch->id.instance;
-		uuid2android(&ch->id.uuid, ev.char_id.uuid);
+		element_id_to_hal_gatt_id(&ch->id, &ev.char_id);
 	}
 
 	ev.conn_id = conn_id;
 	/* TODO need to be handled for included services too */
-	ev.srvc_id.is_primary = 1;
-	ev.srvc_id.inst_id = service->id.instance;
-	uuid2android(&service->id.uuid, ev.srvc_id.uuid);
+	element_id_to_hal_srvc_id(&service->id, 1, &ev.srvc_id);
 
 	ipc_send_notif(hal_ipc, HAL_SERVICE_ID_GATT,
 					HAL_EV_GATT_CLIENT_GET_CHARACTERISTIC,
@@ -1397,12 +1406,8 @@ static void send_client_read_char_notify(int32_t status, const uint8_t *pdu,
 	ev->conn_id = conn_id;
 	ev->status = status;
 
-	ev->data.srvc_id.inst_id = srvc_id->instance;
-	uuid2android(&srvc_id->uuid, ev->data.srvc_id.uuid);
-	ev->data.srvc_id.is_primary = primary;
-
-	ev->data.char_id.inst_id = char_id->instance;
-	uuid2android(&char_id->uuid, ev->data.char_id.uuid);
+	element_id_to_hal_srvc_id(srvc_id, primary, &ev->data.srvc_id);
+	element_id_to_hal_gatt_id(char_id, &ev->data.char_id);
 
 	if (pdu) {
 		vlen = dec_read_resp(pdu, len, ev->data.value, sizeof(buf));
@@ -1518,12 +1523,8 @@ static void send_client_write_char_notify(int32_t status, int32_t conn_id,
 	ev.conn_id = conn_id;
 	ev.status = status;
 
-	ev.data.srvc_id.inst_id = srvc_id->instance;
-	uuid2android(&srvc_id->uuid, ev.data.srvc_id.uuid);
-	ev.data.srvc_id.is_primary = primary;
-
-	ev.data.char_id.inst_id = char_id->instance;
-	uuid2android(&char_id->uuid, ev.data.srvc_id.uuid);
+	element_id_to_hal_srvc_id(srvc_id, primary, &ev.data.srvc_id);
+	element_id_to_hal_gatt_id(char_id, &ev.data.char_id);
 
 	ipc_send_notif(hal_ipc, HAL_SERVICE_ID_GATT,
 					HAL_EV_GATT_CLIENT_WRITE_CHARACTERISTIC,
-- 
1.9.0

