Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCH 3/8] android/gatt: Add Server's add_included_service stub
Date: Fri, 11 Apr 2014 15:15:14 +0200
Message-Id: <1397222119-31158-4-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1397222119-31158-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1397222119-31158-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/gatt.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/android/gatt.c b/android/gatt.c
index bc41f72..7c81ff2 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -2780,10 +2780,29 @@ failed:
 
 static void handle_server_add_included_service(const void *buf, uint16_t len)
 {
+	const struct hal_cmd_gatt_server_add_inc_service *cmd = buf;
+	struct gatt_server *server;
+	uint8_t status;
+
 	DBG("");
 
+	server = find_server_by_id(cmd->server_if);
+
+	if (!server) {
+		error("gatt: server_if=%d not found", cmd->server_if);
+		status = HAL_STATUS_FAILED;
+		goto failed;
+	}
+
+	/* TODO: Add included service to attribute database */
+	DBG("Add included service: server: %d, srvc_hnd: %d, incl_hnd: %d",
+		cmd->server_if, cmd->service_handle, cmd->included_handle);
+
+	status = HAL_STATUS_SUCCESS;
+
+failed:
 	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_GATT,
-			HAL_OP_GATT_SERVER_ADD_INC_SERVICE, HAL_STATUS_FAILED);
+				HAL_OP_GATT_SERVER_ADD_INC_SERVICE, status);
 }
 
 static void handle_server_add_characteristic(const void *buf, uint16_t len)
-- 
1.9.1

