Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCH 4/8] android/gatt: Add Server's add_characteristic stub
Date: Fri, 11 Apr 2014 15:15:15 +0200
Message-Id: <1397222119-31158-5-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1397222119-31158-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1397222119-31158-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/gatt.c | 28 ++++++++++++++++++++++++++--
 1 file changed, 26 insertions(+), 2 deletions(-)

diff --git a/android/gatt.c b/android/gatt.c
index 7c81ff2..0757436 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -2807,11 +2807,35 @@ failed:
 
 static void handle_server_add_characteristic(const void *buf, uint16_t len)
 {
+	const struct hal_cmd_gatt_server_add_characteristic *cmd = buf;
+	char uuidstr[MAX_LEN_UUID_STR];
+	struct gatt_server *server;
+	bt_uuid_t char_uuid;
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
+	android2uuid(cmd->uuid, &char_uuid);
+	bt_uuid_to_string(&char_uuid, uuidstr, MAX_LEN_UUID_STR);
+
+	/* TODO: Add characteristic to database */
+	DBG("Add char: server: %d, uuid: %s, srvc_hnd: %d, prop: %d, perm: %d",
+		cmd->server_if, uuidstr, cmd->service_handle, cmd->properties,
+		cmd->permissions);
+
+	status = HAL_STATUS_SUCCESS;
+
+failed:
 	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_GATT,
-					HAL_OP_GATT_SERVER_ADD_CHARACTERISTIC,
-					HAL_STATUS_FAILED);
+				HAL_OP_GATT_SERVER_ADD_CHARACTERISTIC, status);
 }
 
 static void handle_server_add_descriptor(const void *buf, uint16_t len)
-- 
1.9.1

