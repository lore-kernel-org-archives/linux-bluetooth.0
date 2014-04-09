Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC 10/16] android/gatt: Add included service implementation
Date: Wed,  9 Apr 2014 09:07:08 +0200
Message-Id: <1397027234-12003-11-git-send-email-marcin.kraglak@tieto.com>
In-Reply-To: <1397027234-12003-1-git-send-email-marcin.kraglak@tieto.com>
References: <1397027234-12003-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

It will add included service attribute to database.
---
 android/gatt.c | 31 ++++++++++++++++++++++++++++++-
 1 file changed, 30 insertions(+), 1 deletion(-)

diff --git a/android/gatt.c b/android/gatt.c
index 5f054c7..10e3dfd 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -2726,10 +2726,39 @@ failed:
 
 static void handle_server_add_included_service(const void *buf, uint16_t len)
 {
+	const struct hal_cmd_gatt_server_add_inc_service *cmd = buf;
+	struct hal_ev_gatt_server_inc_srvc_added ev;
+	struct gatt_server *server;
+	uint8_t status;
+
 	DBG("");
 
+	server = find_server_by_id(cmd->server_if);
+	if (!server) {
+		status = HAL_STATUS_FAILED;
+		goto failed;
+	}
+
+	ev.incl_srvc_handle = gatt_db_new_included_service(gatt_db,
+							cmd->service_handle,
+							cmd->included_handle);
+	if (!ev.incl_srvc_handle) {
+		status = HAL_STATUS_FAILED;
+		goto failed;
+	}
+
+	status = HAL_STATUS_SUCCESS;
+failed:
+	ev.srvc_handle = cmd->service_handle;
+	ev.status = status;
+	ev.server_if = cmd->server_if;
+	ev.status = status == HAL_STATUS_SUCCESS ? GATT_SUCCESS : GATT_FAILURE;
+
+	ipc_send_notif(hal_ipc, HAL_SERVICE_ID_GATT,
+			HAL_EV_GATT_SERVER_INC_SRVC_ADDED, sizeof(ev), &ev);
+
 	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_GATT,
-			HAL_OP_GATT_SERVER_ADD_INC_SERVICE, HAL_STATUS_FAILED);
+				HAL_OP_GATT_SERVER_ADD_INC_SERVICE, status);
 }
 
 static void handle_server_add_characteristic(const void *buf, uint16_t len)
-- 
1.8.5.3

