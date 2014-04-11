Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCH 5/8] android/gatt: Add Server's add_descriptor stub
Date: Fri, 11 Apr 2014 15:15:16 +0200
Message-Id: <1397222119-31158-6-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1397222119-31158-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1397222119-31158-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/gatt.c | 26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/android/gatt.c b/android/gatt.c
index 0757436..dd9fb42 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -2840,10 +2840,34 @@ failed:
 
 static void handle_server_add_descriptor(const void *buf, uint16_t len)
 {
+	const struct hal_cmd_gatt_server_add_descriptor *cmd = buf;
+	char uuidstr[MAX_LEN_UUID_STR];
+	struct gatt_server *server;
+	bt_uuid_t descr_uuid;
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
+	android2uuid(cmd->uuid, &descr_uuid);
+	bt_uuid_to_string(&descr_uuid, uuidstr, MAX_LEN_UUID_STR);
+
+	/* TODO: Add descriptor to attribute database */
+	DBG("Add descriptor: server: %d, srvc_hnd: %d, uuid: %s, perm: %d",
+		cmd->server_if, cmd->service_handle, uuidstr, cmd->permissions);
+
+	status = HAL_STATUS_SUCCESS;
+
+failed:
 	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_GATT,
-			HAL_OP_GATT_SERVER_ADD_DESCRIPTOR, HAL_STATUS_FAILED);
+				HAL_OP_GATT_SERVER_ADD_DESCRIPTOR, status);
 }
 
 static void handle_server_start_service(const void *buf, uint16_t len)
-- 
1.9.1

