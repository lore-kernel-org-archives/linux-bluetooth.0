Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCHv2 1/2] android/gatt: Fix sendig wrong byte ordered uuids
Date: Thu, 27 Mar 2014 17:05:04 +0100
Message-Id: <1395936305-23188-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

We were sending wrong byte ordered uuids since the last gatt library
changes. Two helpers were introduced for swapping uuids sent to, and
received from HAL.
---
 android/gatt.c | 43 ++++++++++++++++++++++++++++++-------------
 1 file changed, 30 insertions(+), 13 deletions(-)

diff --git a/android/gatt.c b/android/gatt.c
index fe8ba74..0327d54 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -96,6 +96,31 @@ static struct queue *conn_wait_queue = NULL;	/* Devs waiting to connect */
 
 static void bt_le_discovery_stop_cb(void);
 
+static void android2uuid(const uint8_t *uuid, bt_uuid_t *dst)
+{
+	uint8_t i;
+
+	dst->type = BT_UUID128;
+
+	for (i = 0; i < 16; i++)
+		dst->value.u128.data[i] = uuid[15 - i];
+
+}
+
+static void uuid2android(const bt_uuid_t *src, uint8_t *uuid)
+{
+	bt_uuid_t uu128;
+	uint8_t i;
+
+	if (src->type != BT_UUID128) {
+		bt_uuid_to_uuid128(src, &uu128);
+		src = &uu128;
+	}
+
+	for (i = 0; i < 16; i++)
+		uuid[15 - i] = src->value.u128.data[i];
+}
+
 static void destroy_service(void *data)
 {
 	struct service *srvc = data;
@@ -317,7 +342,7 @@ static void primary_cb(uint8_t status, GSList *services, void *user_data)
 			continue;
 		}
 
-		memcpy(&ev_res.srvc_id.uuid, &uuid.value, sizeof(uuid.value));
+		uuid2android(&uuid, ev_res.srvc_id.uuid);
 
 		ipc_send_notif(hal_ipc, HAL_SERVICE_ID_GATT ,
 					HAL_EV_GATT_CLIENT_SEARCH_RESULT,
@@ -929,26 +954,22 @@ static void send_client_char_notify(const struct characteristic *ch,
 					uint8_t status)
 {
 	struct hal_ev_gatt_client_get_characteristic ev;
-	bt_uuid_t uuid;
 
 	memset(&ev, 0, sizeof(ev));
 	ev.status = status;
 
 	if (ch) {
 		ev.char_prop = ch->ch.properties;
+
 		ev.char_id.inst_id = ch->id.instance;
-		bt_string_to_uuid(&uuid, ch->ch.uuid);
-		memcpy(&ev.char_id.uuid, &uuid.value.u128.data,
-						sizeof(ev.char_id.uuid));
+		uuid2android(&ch->id.uuid, ev.char_id.uuid);
 	}
 
 	ev.conn_id = conn_id;
 	/* TODO need to be handled for included services too */
 	ev.srvc_id.is_primary = 1;
 	ev.srvc_id.inst_id = service->id.instance;
-	bt_string_to_uuid(&uuid, service->primary.uuid);
-	memcpy(&ev.srvc_id.uuid, &uuid.value.u128.data,
-					sizeof(ev.srvc_id.uuid));
+	uuid2android(&service->id.uuid, ev.srvc_id.uuid);
 
 	ipc_send_notif(hal_ipc, HAL_SERVICE_ID_GATT,
 					HAL_EV_GATT_CLIENT_GET_CHARACTERISTIC,
@@ -1016,12 +1037,8 @@ static void discover_char_cb(uint8_t status, GSList *characteristics,
 static void hal_srvc_id_to_element_id(const struct hal_gatt_srvc_id *from,
 							struct element_id *to)
 {
-	uint128_t uuid128;
-
 	to->instance = from->inst_id;
-
-	memcpy(&uuid128.data, &from->uuid, sizeof(uuid128));
-	bt_uuid128_create(&to->uuid, uuid128);
+	android2uuid(from->uuid, &to->uuid);
 }
 
 static bool find_service(int32_t conn_id, struct element_id *service_id,
-- 
1.9.0

