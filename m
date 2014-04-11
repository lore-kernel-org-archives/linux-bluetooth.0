Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCH 1/2] android/gatt: Set proper primary flag for sending characteristics
Date: Fri, 11 Apr 2014 14:40:25 +0200
Message-Id: <1397220026-27177-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Fix sending included service's characteristics.
---
 android/gatt.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/android/gatt.c b/android/gatt.c
index aa2a5fd..13ae340 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -1510,8 +1510,7 @@ static void send_client_char_notify(const struct characteristic *ch,
 	}
 
 	ev.conn_id = conn_id;
-	/* TODO need to be handled for included services too */
-	element_id_to_hal_srvc_id(&service->id, 1, &ev.srvc_id);
+	element_id_to_hal_srvc_id(&service->id, service->primary, &ev.srvc_id);
 
 	ipc_send_notif(hal_ipc, HAL_SERVICE_ID_GATT,
 					HAL_EV_GATT_CLIENT_GET_CHARACTERISTIC,
-- 
1.9.1

