Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCH 1/2] android/gatt: Refactor characteristic notify function
Date: Wed, 26 Mar 2014 19:23:35 +0100
Message-Id: <1395858216-26503-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This removes redundant status from function parameter list, as sent
status is different than success only when there is no characteristic.
---
 android/gatt.c | 18 +++++-------------
 1 file changed, 5 insertions(+), 13 deletions(-)

diff --git a/android/gatt.c b/android/gatt.c
index d7c7c93..cad7e1a 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -951,13 +951,12 @@ static void handle_client_get_included_service(const void *buf, uint16_t len)
 
 static void send_client_char_notify(const struct characteristic *ch,
 					int32_t conn_id,
-					const struct service *service,
-					uint8_t status)
+					const struct service *service)
 {
 	struct hal_ev_gatt_client_get_characteristic ev;
 
 	memset(&ev, 0, sizeof(ev));
-	ev.status = status;
+	ev.status = ch ? HAL_STATUS_SUCCESS : HAL_STATUS_FAILED;
 
 	if (ch) {
 		ev.char_prop = ch->ch.properties;
@@ -1026,11 +1025,9 @@ static void discover_char_cb(uint8_t status, GSList *characteristics,
 
 	if (!queue_isempty(data->service->chars))
 		send_client_char_notify(queue_peek_head(data->service->chars),
-						data->conn_id, data->service,
-						HAL_STATUS_SUCCESS);
+						data->conn_id, data->service);
 	else
-		send_client_char_notify(NULL, data->conn_id, data->service,
-							HAL_STATUS_FAILED);
+		send_client_char_notify(NULL, data->conn_id, data->service);
 
 	free(data);
 }
@@ -1126,12 +1123,7 @@ static void handle_client_get_characteristic(const void *buf, uint16_t len)
 	else
 		ch = queue_peek_head(srvc->chars);
 
-	if (ch)
-		send_client_char_notify(ch, dev->conn_id, srvc,
-							HAL_STATUS_SUCCESS);
-	else
-		send_client_char_notify(NULL, dev->conn_id, srvc,
-							HAL_STATUS_FAILED);
+	send_client_char_notify(ch, dev->conn_id, srvc);
 
 	status = HAL_STATUS_SUCCESS;
 
-- 
1.9.0

