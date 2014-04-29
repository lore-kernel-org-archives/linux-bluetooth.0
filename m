Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: szymon.janc@tieto.com, Marcin Kraglak <marcin.kraglak@tieto.com>
Subject: [PATCH 04/36] android/gatt: Add included service implementation
Date: Tue, 29 Apr 2014 03:14:35 +0200
Message-Id: <1398734107-4793-6-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1398734107-4793-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1398734107-4793-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Marcin Kraglak <marcin.kraglak@tieto.com>

It will add included service attribute to database.
---
 android/gatt.c | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/android/gatt.c b/android/gatt.c
index 014458e..2885c51 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -3237,25 +3237,38 @@ failed:
 static void handle_server_add_included_service(const void *buf, uint16_t len)
 {
 	const struct hal_cmd_gatt_server_add_inc_service *cmd = buf;
+	struct hal_ev_gatt_server_inc_srvc_added ev;
 	struct gatt_app *server;
 	uint8_t status;
 
 	DBG("");
 
+	memset(&ev, 0, sizeof(ev));
+
 	server = find_app_by_id(cmd->server_if);
 	if (!server) {
-		error("gatt: server_if=%d not found", cmd->server_if);
 		status = HAL_STATUS_FAILED;
 		goto failed;
 	}
 
-	/* TODO: Add included service to attribute database */
-	DBG("Add included service: server: %d, srvc_hnd: %d, incl_hnd: %d",
-		cmd->server_if, cmd->service_handle, cmd->included_handle);
+	ev.incl_srvc_handle = gatt_db_add_included_service(gatt_db,
+							cmd->service_handle,
+							cmd->included_handle);
+	if (!ev.incl_srvc_handle) {
+		status = HAL_STATUS_FAILED;
+		goto failed;
+	}
 
 	status = HAL_STATUS_SUCCESS;
-
 failed:
+	ev.srvc_handle = cmd->service_handle;
+	ev.status = status;
+	ev.server_if = cmd->server_if;
+	ev.status = status == HAL_STATUS_SUCCESS ? GATT_SUCCESS : GATT_FAILURE;
+
+	ipc_send_notif(hal_ipc, HAL_SERVICE_ID_GATT,
+			HAL_EV_GATT_SERVER_INC_SRVC_ADDED, sizeof(ev), &ev);
+
 	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_GATT,
 				HAL_OP_GATT_SERVER_ADD_INC_SERVICE, status);
 }
-- 
1.8.4

