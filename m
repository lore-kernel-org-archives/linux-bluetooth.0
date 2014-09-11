Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 03/14] android/gatt: Fix sending callback in get_characteristic
Date: Thu, 11 Sep 2014 08:08:41 +0200
Message-Id: <1410415732-23212-3-git-send-email-marcin.kraglak@tieto.com>
In-Reply-To: <1410415732-23212-1-git-send-email-marcin.kraglak@tieto.com>
References: <1410415732-23212-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Notification should be send to client in case of error.
---
 android/gatt.c | 50 +++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 37 insertions(+), 13 deletions(-)

diff --git a/android/gatt.c b/android/gatt.c
index fb29339..f16d365 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -2517,28 +2517,49 @@ reply:
 			HAL_OP_GATT_CLIENT_GET_INCLUDED_SERVICE, status);
 }
 
-static void send_client_char_notify(const struct characteristic *ch,
-					int32_t conn_id,
-					const struct service *service)
+static void send_client_char_notify(const struct hal_gatt_srvc_id *service,
+					const struct hal_gatt_gatt_id *charac,
+					int32_t char_prop, int32_t conn_id)
 {
 	struct hal_ev_gatt_client_get_characteristic ev;
 
-	memset(&ev, 0, sizeof(ev));
-	ev.status = ch ? GATT_SUCCESS : GATT_FAILURE;
+	ev.conn_id = conn_id;
 
-	if (ch) {
-		ev.char_prop = ch->ch.properties;
-		element_id_to_hal_gatt_id(&ch->id, &ev.char_id);
+	if (charac) {
+		memcpy(&ev.char_id, charac, sizeof(struct hal_gatt_gatt_id));
+		ev.char_prop = char_prop;
+		ev.status = GATT_SUCCESS;
+	} else {
+		memset(&ev.char_id, 0, sizeof(struct hal_gatt_gatt_id));
+		ev.char_prop = 0;
+		ev.status = GATT_FAILURE;
 	}
 
-	ev.conn_id = conn_id;
-	element_id_to_hal_srvc_id(&service->id, service->primary, &ev.srvc_id);
+	memcpy(&ev.srvc_id, service, sizeof(struct hal_gatt_srvc_id));
 
 	ipc_send_notif(hal_ipc, HAL_SERVICE_ID_GATT,
 					HAL_EV_GATT_CLIENT_GET_CHARACTERISTIC,
 					sizeof(ev), &ev);
 }
 
+static void convert_send_client_char_notify(const struct characteristic *ch,
+					int32_t conn_id,
+					const struct service *service)
+{
+	struct hal_gatt_srvc_id srvc;
+	struct hal_gatt_gatt_id charac;
+
+	element_id_to_hal_srvc_id(&service->id, service->primary, &srvc);
+
+	if (ch) {
+		element_id_to_hal_gatt_id(&ch->id, &charac);
+		send_client_char_notify(&srvc, &charac, ch->ch.properties,
+								conn_id);
+	} else {
+		send_client_char_notify(&srvc, NULL, 0, conn_id);
+	}
+}
+
 static void cache_all_srvc_chars(struct service *srvc, GSList *characteristics)
 {
 	uint16_t inst_id = 0;
@@ -2604,8 +2625,8 @@ static void discover_char_cb(uint8_t status, GSList *characteristics,
 	if (queue_isempty(srvc->chars))
 		cache_all_srvc_chars(srvc, characteristics);
 
-	send_client_char_notify(queue_peek_head(srvc->chars), data->conn_id,
-									srvc);
+	convert_send_client_char_notify(queue_peek_head(srvc->chars),
+							data->conn_id, srvc);
 
 	free(data);
 }
@@ -2671,11 +2692,14 @@ static void handle_client_get_characteristic(const void *buf, uint16_t len)
 	else
 		ch = queue_peek_head(srvc->chars);
 
-	send_client_char_notify(ch, conn->id, srvc);
+	convert_send_client_char_notify(ch, conn->id, srvc);
 
 	status = HAL_STATUS_SUCCESS;
 
 done:
+	if (status != HAL_STATUS_SUCCESS)
+		send_client_char_notify(&cmd->srvc_id, NULL, 0, cmd->conn_id);
+
 	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_GATT,
 				HAL_OP_GATT_CLIENT_GET_CHARACTERISTIC, status);
 }
-- 
1.9.3

