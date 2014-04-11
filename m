Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCH 6/8] android/gatt: Add Server's start_service stub
Date: Fri, 11 Apr 2014 15:15:17 +0200
Message-Id: <1397222119-31158-7-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1397222119-31158-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1397222119-31158-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/gatt.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/android/gatt.c b/android/gatt.c
index dd9fb42..d227eca 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -2872,10 +2872,30 @@ failed:
 
 static void handle_server_start_service(const void *buf, uint16_t len)
 {
+	const struct hal_cmd_gatt_server_start_service *cmd = buf;
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
+	/* TODO: support BR/EDR (cmd->transport) */
+	/* TODO: activate service in attribute database */
+	DBG("Start service: server: %d, srvc_hnd: %d, transport_layer: %d",
+			cmd->server_if, cmd->service_handle, cmd->transport);
+
+	status = HAL_STATUS_SUCCESS;
+
+failed:
 	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_GATT,
-			HAL_OP_GATT_SERVER_START_SERVICE, HAL_STATUS_FAILED);
+				HAL_OP_GATT_SERVER_START_SERVICE, status);
 }
 
 static void handle_server_stop_service(const void *buf, uint16_t len)
-- 
1.9.1

