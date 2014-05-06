Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/4] android/gatt: Trivial fix of indention style
Date: Tue,  6 May 2014 11:57:05 +0200
Message-Id: <1399370226-19126-3-git-send-email-grzegorz.kolodziejczyk@tieto.com>
In-Reply-To: <1399370226-19126-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1399370226-19126-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/gatt.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/android/gatt.c b/android/gatt.c
index 6262c93..810a8c7 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -778,8 +778,7 @@ static void send_client_primary_notify(void *data, void *user_data)
 	uuid2android(&p->id.uuid, ev.srvc_id.uuid);
 
 	ipc_send_notif(hal_ipc, HAL_SERVICE_ID_GATT,
-					HAL_EV_GATT_CLIENT_SEARCH_RESULT,
-					sizeof(ev), &ev);
+			HAL_EV_GATT_CLIENT_SEARCH_RESULT, sizeof(ev), &ev);
 }
 
 static void send_client_all_primary(struct app_connection *connection,
@@ -1379,7 +1378,7 @@ static void handle_client_disconnect(const void *buf, uint16_t len)
 	status = HAL_STATUS_SUCCESS;
 
 	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_GATT,
-			HAL_OP_GATT_CLIENT_DISCONNECT, status);
+					HAL_OP_GATT_CLIENT_DISCONNECT, status);
 }
 
 static void send_client_listen_notify(int32_t id, int32_t status)
@@ -1390,9 +1389,8 @@ static void send_client_listen_notify(int32_t id, int32_t status)
 	ev.server_if = id;
 	ev.status = status;
 
-	ipc_send_notif(hal_ipc, HAL_SERVICE_ID_GATT,
-						HAL_EV_GATT_CLIENT_LISTEN,
-						sizeof(ev), &ev);
+	ipc_send_notif(hal_ipc, HAL_SERVICE_ID_GATT, HAL_EV_GATT_CLIENT_LISTEN,
+							sizeof(ev), &ev);
 }
 
 struct listen_data {
@@ -2938,8 +2936,7 @@ failed:
 	send_register_for_notification_ev(conn_id, 1, gatt_status,
 						&cmd->srvc_id, &cmd->char_id);
 	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_GATT,
-				HAL_OP_GATT_CLIENT_REGISTER_FOR_NOTIFICATION,
-				status);
+			HAL_OP_GATT_CLIENT_REGISTER_FOR_NOTIFICATION, status);
 }
 
 static void handle_client_deregister_for_notification(const void *buf,
@@ -2986,8 +2983,7 @@ failed:
 						&cmd->srvc_id, &cmd->char_id);
 
 	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_GATT,
-				HAL_OP_GATT_CLIENT_DEREGISTER_FOR_NOTIFICATION,
-				status);
+			HAL_OP_GATT_CLIENT_DEREGISTER_FOR_NOTIFICATION, status);
 }
 
 static void handle_client_read_remote_rssi(const void *buf, uint16_t len)
-- 
1.9.2

