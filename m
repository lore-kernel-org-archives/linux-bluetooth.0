Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: szymon.janc@tieto.com, Marcin Kraglak <marcin.kraglak@tieto.com>
Subject: [PATCH 08/36] android/gatt: Add descriptor implementation
Date: Tue, 29 Apr 2014 03:14:39 +0200
Message-Id: <1398734107-4793-10-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1398734107-4793-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1398734107-4793-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Marcin Kraglak <marcin.kraglak@tieto.com>

It will add characteristic descriptor attribute to local database.
---
 android/gatt.c | 31 +++++++++++++++++++++----------
 1 file changed, 21 insertions(+), 10 deletions(-)

diff --git a/android/gatt.c b/android/gatt.c
index 46128af..d20b87a 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -3320,30 +3320,41 @@ failed:
 static void handle_server_add_descriptor(const void *buf, uint16_t len)
 {
 	const struct hal_cmd_gatt_server_add_descriptor *cmd = buf;
-	char uuidstr[MAX_LEN_UUID_STR];
+	struct hal_ev_gatt_server_descriptor_added ev;
 	struct gatt_app *server;
-	bt_uuid_t descr_uuid;
+	bt_uuid_t uuid;
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
 
-	android2uuid(cmd->uuid, &descr_uuid);
-	bt_uuid_to_string(&descr_uuid, uuidstr, MAX_LEN_UUID_STR);
-
-	/* TODO: Add descriptor to attribute database */
-	DBG("Add descriptor: server: %d, srvc_hnd: %d, uuid: %s, perm: %d",
-		cmd->server_if, cmd->service_handle, uuidstr, cmd->permissions);
+	android2uuid(cmd->uuid, &uuid);
 
-	status = HAL_STATUS_SUCCESS;
+	ev.descr_handle = gatt_db_add_char_descriptor(gatt_db,
+							cmd->service_handle,
+							&uuid, cmd->permissions,
+							NULL, NULL, NULL);
+	if (!ev.descr_handle)
+		status = HAL_STATUS_FAILED;
+	else
+		status = HAL_STATUS_SUCCESS;
 
 failed:
+	ev.server_if = cmd->server_if;
+	ev.srvc_handle = cmd->service_handle;
+	memcpy(ev.uuid, cmd->uuid, sizeof(cmd->uuid));
+	ev.status = status == HAL_STATUS_SUCCESS ? GATT_SUCCESS : GATT_FAILURE;
+
+	ipc_send_notif(hal_ipc, HAL_SERVICE_ID_GATT,
+			HAL_EV_GATT_SERVER_DESCRIPTOR_ADDED, sizeof(ev), &ev);
+
 	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_GATT,
 				HAL_OP_GATT_SERVER_ADD_DESCRIPTOR, status);
 }
-- 
1.8.4

