Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCH 1/2] android/hal-gatt: Fix wrong pointer usage
Date: Mon, 17 Mar 2014 09:20:41 +0100
Message-Id: <1395044442-14350-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/hal-gatt.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/android/hal-gatt.c b/android/hal-gatt.c
index 8f906fd..bd61576 100644
--- a/android/hal-gatt.c
+++ b/android/hal-gatt.c
@@ -683,7 +683,7 @@ static bt_status_t get_descriptor(int conn_id, btgatt_srvc_id_t *srvc_id,
 
 	return hal_ipc_cmd(HAL_SERVICE_ID_GATT,
 					HAL_OP_GATT_CLIENT_GET_DESCRIPTOR,
-					len, &cmd, 0 , NULL, NULL);
+					len, cmd, 0 , NULL, NULL);
 }
 
 static bt_status_t read_characteristic(int conn_id, btgatt_srvc_id_t *srvc_id,
@@ -1065,7 +1065,7 @@ static bt_status_t send_indication(int server_if, int attribute_handle,
 
 	return hal_ipc_cmd(HAL_SERVICE_ID_GATT,
 					HAL_OP_GATT_SERVER_SEND_INDICATION,
-					cmd_len, &cmd, 0, NULL, NULL);
+					cmd_len, cmd, 0, NULL, NULL);
 }
 
 static bt_status_t send_response(int conn_id, int trans_id, int status,
@@ -1084,7 +1084,7 @@ static bt_status_t send_response(int conn_id, int trans_id, int status,
 
 	return hal_ipc_cmd(HAL_SERVICE_ID_GATT,
 					HAL_OP_GATT_SERVER_SEND_RESPONSE,
-					cmd_len, &cmd, 0, NULL, NULL);
+					cmd_len, cmd, 0, NULL, NULL);
 }
 
 static bt_status_t init(const btgatt_callbacks_t *callbacks)
-- 
1.9.0

