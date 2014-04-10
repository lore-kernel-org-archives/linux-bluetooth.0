Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] android/gatt: Fix incorrect event status
Date: Thu, 10 Apr 2014 08:29:58 +0200
Message-Id: <1397111398-18137-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Return proper gatt_status in register_for_notification event.
---
 android/gatt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/android/gatt.c b/android/gatt.c
index 15e788a..971e2dd 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -2482,7 +2482,7 @@ static void handle_client_register_for_notification(const void *buf,
 	status = HAL_STATUS_SUCCESS;
 
 failed:
-	gatt_status  = status ? GATT_SUCCESS : GATT_FAILURE;
+	gatt_status = status ? GATT_FAILURE : GATT_SUCCESS;
 	send_register_for_notification_ev(conn_id, 1, gatt_status,
 						&cmd->srvc_id, &cmd->char_id);
 	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_GATT,
@@ -2535,7 +2535,7 @@ static void handle_client_deregister_for_notification(const void *buf,
 	status = HAL_STATUS_SUCCESS;
 
 failed:
-	gatt_status  = status ? GATT_SUCCESS : GATT_FAILURE;
+	gatt_status = status ? GATT_FAILURE : GATT_SUCCESS;
 	send_register_for_notification_ev(conn_id, 0, gatt_status,
 						&cmd->srvc_id, &cmd->char_id);
 
-- 
1.8.5.3

