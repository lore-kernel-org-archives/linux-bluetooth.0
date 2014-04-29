Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: szymon.janc@tieto.com, Marcin Kraglak <marcin.kraglak@tieto.com>
Subject: [PATCH 06/36] android/gatt: Add handling of start service command
Date: Tue, 29 Apr 2014 03:14:37 +0200
Message-Id: <1398734107-4793-8-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1398734107-4793-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1398734107-4793-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Marcin Kraglak <marcin.kraglak@tieto.com>

It will start service added to local database.
---
 android/gatt.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/android/gatt.c b/android/gatt.c
index f34e786..adee9d0 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -3351,26 +3351,38 @@ failed:
 static void handle_server_start_service(const void *buf, uint16_t len)
 {
 	const struct hal_cmd_gatt_server_start_service *cmd = buf;
+	struct hal_ev_gatt_server_service_started ev;
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
 
 	/* TODO: support BR/EDR (cmd->transport) */
-	/* TODO: activate service in attribute database */
-	DBG("Start service: server: %d, srvc_hnd: %d, transport_layer: %d",
-			cmd->server_if, cmd->service_handle, cmd->transport);
+
+	if (!gatt_db_service_set_active(gatt_db, cmd->service_handle, true)) {
+		/* we ignore service now */
+		status = HAL_STATUS_FAILED;
+		goto failed;
+	}
 
 	status = HAL_STATUS_SUCCESS;
 
 failed:
+	ev.status = status == HAL_STATUS_SUCCESS ? GATT_SUCCESS : GATT_FAILURE;
+	ev.server_if = cmd->server_if;
+	ev.srvc_handle = cmd->service_handle;
+
+	ipc_send_notif(hal_ipc, HAL_SERVICE_ID_GATT,
+		HAL_EV_GATT_SERVER_SERVICE_STARTED, sizeof(ev), &ev);
+
 	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_GATT,
 				HAL_OP_GATT_SERVER_START_SERVICE, status);
 }
-- 
1.8.4

