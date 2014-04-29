Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: szymon.janc@tieto.com, johan.hedberg@gmail.com,
	Marcin Kraglak <marcin.kraglak@tieto.com>
Subject: [PATCH v2 08/40] android/gatt: Add stop service command handling
Date: Tue, 29 Apr 2014 18:46:57 +0200
Message-Id: <1398790049-30303-9-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1398790049-30303-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1398790049-30303-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Marcin Kraglak <marcin.kraglak@tieto.com>

It will stop service in local database.
---
 android/gatt.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/android/gatt.c b/android/gatt.c
index 2913007..e888268 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -3372,25 +3372,33 @@ failed:
 static void handle_server_stop_service(const void *buf, uint16_t len)
 {
 	const struct hal_cmd_gatt_server_stop_service *cmd = buf;
+	struct hal_ev_gatt_server_service_stopped ev;
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
 
-	status = HAL_STATUS_SUCCESS;
-
-	/* TODO: stop service in attribute database */
-	DBG("Stop service: server: %d, srvc_hnd: %d", cmd->server_if,
-							cmd->service_handle);
+	if (!gatt_db_service_set_active(gatt_db, cmd->service_handle, false))
+		status = HAL_STATUS_FAILED;
+	else
+		status = HAL_STATUS_SUCCESS;
 
 failed:
+	ev.status = status == HAL_STATUS_SUCCESS ? GATT_SUCCESS : GATT_FAILURE;
+	ev.server_if = cmd->server_if;
+	ev.srvc_handle = cmd->service_handle;
+
+	ipc_send_notif(hal_ipc, HAL_SERVICE_ID_GATT,
+			HAL_EV_GATT_SERVER_SERVICE_STOPPED, sizeof(ev), &ev);
+
 	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_GATT,
 				HAL_OP_GATT_SERVER_STOP_SERVICE, status);
 }
-- 
1.8.4

