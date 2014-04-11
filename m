Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCH 2/8] android/gatt: Add Server's add_service stub
Date: Fri, 11 Apr 2014 15:15:13 +0200
Message-Id: <1397222119-31158-3-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1397222119-31158-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1397222119-31158-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/gatt.c | 26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/android/gatt.c b/android/gatt.c
index 7b7b399..bc41f72 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -2748,10 +2748,34 @@ static void handle_server_disconnect(const void *buf, uint16_t len)
 
 static void handle_server_add_service(const void *buf, uint16_t len)
 {
+	const struct hal_cmd_gatt_server_add_service *cmd = buf;
+	char uuidstr[MAX_LEN_UUID_STR];
+	struct gatt_server *server;
+	struct element_id srvc_id;
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
+	hal_srvc_id_to_element_id(&cmd->srvc_id, &srvc_id);
+	bt_uuid_to_string(&srvc_id.uuid, uuidstr, MAX_LEN_UUID_STR);
+
+	/* TODO: execute attribute database transaction */
+	DBG("Add primary service: server: %d, srvc_uuid: %s, num_handles: %d",
+				cmd->server_if, uuidstr, cmd->num_handles);
+
+	status = HAL_STATUS_SUCCESS;
+
+failed:
 	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_GATT,
-			HAL_OP_GATT_SERVER_ADD_SERVICE, HAL_STATUS_FAILED);
+					HAL_OP_GATT_SERVER_ADD_SERVICE, status);
 }
 
 static void handle_server_add_included_service(const void *buf, uint16_t len)
-- 
1.9.1

