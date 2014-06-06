Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [RFC 08/13] android/gatt: Use common code for server and client apps unregister
Date: Fri,  6 Jun 2014 15:46:21 +0200
Message-Id: <1402062386-4632-9-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1402062386-4632-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1402062386-4632-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/gatt.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/android/gatt.c b/android/gatt.c
index 76844f7..7d22901 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -3640,21 +3640,11 @@ static void handle_server_unregister(const void *buf, uint16_t len)
 {
 	const struct hal_cmd_gatt_server_unregister *cmd = buf;
 	uint8_t status;
-	struct gatt_app *server;
 
 	DBG("");
 
-	server = find_app_by_id(cmd->server_if);
-	if (!server) {
-		error("gatt: server_if=%d not found", cmd->server_if);
-		status = HAL_STATUS_FAILED;
-		goto failed;
-	}
-
-	destroy_gatt_app(server);
-	status = HAL_STATUS_SUCCESS;
+	status = unregister_client(cmd->server_if);
 
-failed:
 	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_GATT,
 					HAL_OP_GATT_SERVER_UNREGISTER, status);
 }
-- 
2.0.0

