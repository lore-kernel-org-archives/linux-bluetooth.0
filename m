Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv4 5/7] android/gatt: Add send_register_for_notif_ev function
Date: Fri, 28 Mar 2014 11:49:20 +0100
Message-Id: <1396003762-9350-5-git-send-email-marcin.kraglak@tieto.com>
In-Reply-To: <1396003762-9350-1-git-send-email-marcin.kraglak@tieto.com>
References: <1396003762-9350-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

It will be called with register/deregister will be called.
It will send status, service id and characteristic id.
---
 android/gatt.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/android/gatt.c b/android/gatt.c
index d7ea745..e87237a 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -1398,6 +1398,23 @@ static void handle_client_execute_write(const void *buf, uint16_t len)
 			HAL_OP_GATT_CLIENT_EXECUTE_WRITE, HAL_STATUS_FAILED);
 }
 
+static void send_register_for_notification_ev(int32_t id, int32_t registered,
+					int32_t status,
+					const struct hal_gatt_srvc_id *srvc,
+					const struct hal_gatt_gatt_id *ch)
+{
+	struct hal_ev_gatt_client_reg_for_notif ev;
+
+	ev.conn_id = id;
+	ev.status = status;
+	ev.registered = registered;
+	memcpy(&ev.srvc_id, srvc, sizeof(ev.srvc_id));
+	memcpy(&ev.char_id, ch, sizeof(ev.char_id));
+
+	ipc_send_notif(hal_ipc, HAL_SERVICE_ID_GATT,
+			HAL_EV_GATT_CLIENT_REGISTER_FOR_NOTIF, sizeof(ev), &ev);
+}
+
 static void handle_client_register_for_notification(const void *buf,
 								uint16_t len)
 {
@@ -1409,6 +1426,7 @@ static void handle_client_register_for_notification(const void *buf,
 	struct element_id match_id;
 	struct gatt_device *dev;
 	struct service *service;
+	int32_t conn_id = 0;
 	uint8_t status;
 	bdaddr_t addr;
 
@@ -1428,6 +1446,8 @@ static void handle_client_register_for_notification(const void *buf,
 		goto failed;
 	}
 
+	conn_id = dev->conn_id;
+
 	hal_srvc_id_to_element_id(&cmd->srvc_id, &match_id);
 	service = queue_find(dev->services, match_srvc_by_element_id,
 								&match_id);
@@ -1500,7 +1520,8 @@ static void handle_client_register_for_notification(const void *buf,
 	status = HAL_STATUS_SUCCESS;
 
 failed:
-	/* TODO: send callback with notification enabled/disabled */
+	send_register_for_notification_ev(conn_id, 1, status, &cmd->srvc_id,
+								&cmd->char_id);
 	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_GATT,
 				HAL_OP_GATT_CLIENT_REGISTER_FOR_NOTIFICATION,
 				status);
-- 
1.8.3.1

