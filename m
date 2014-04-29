Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: szymon.janc@tieto.com, johan.hedberg@gmail.com,
	Marcin Kraglak <marcin.kraglak@tieto.com>
Subject: [PATCH v2 06/40] android/gatt: Add characteristic implementation
Date: Tue, 29 Apr 2014 18:46:55 +0200
Message-Id: <1398790049-30303-7-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1398790049-30303-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1398790049-30303-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Marcin Kraglak <marcin.kraglak@tieto.com>

It will add characteristic declaration and value attributes to
local database.
---
 android/gatt.c | 34 +++++++++++++++++++++++-----------
 1 file changed, 23 insertions(+), 11 deletions(-)

diff --git a/android/gatt.c b/android/gatt.c
index f8398fc..7522c65 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -3258,31 +3258,43 @@ failed:
 static void handle_server_add_characteristic(const void *buf, uint16_t len)
 {
 	const struct hal_cmd_gatt_server_add_characteristic *cmd = buf;
-	char uuidstr[MAX_LEN_UUID_STR];
+	struct hal_ev_gatt_server_characteristic_added ev;
 	struct gatt_app *server;
-	bt_uuid_t char_uuid;
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
 
-	android2uuid(cmd->uuid, &char_uuid);
-	bt_uuid_to_string(&char_uuid, uuidstr, MAX_LEN_UUID_STR);
+	android2uuid(cmd->uuid, &uuid);
 
-	/* TODO: Add characteristic to database */
-	DBG("Add char: server: %d, uuid: %s, srvc_hnd: %d, prop: %d, perm: %d",
-		cmd->server_if, uuidstr, cmd->service_handle, cmd->properties,
-		cmd->permissions);
-
-	status = HAL_STATUS_SUCCESS;
+	ev.char_handle = gatt_db_add_characteristic(gatt_db,
+							cmd->service_handle,
+							&uuid, cmd->permissions,
+							cmd->properties,
+							NULL, NULL, NULL);
+	if (!ev.char_handle)
+		status = HAL_STATUS_FAILED;
+	else
+		status = HAL_STATUS_SUCCESS;
 
 failed:
+	ev.srvc_handle = cmd->service_handle;
+	ev.status = status;
+	ev.server_if = cmd->server_if;
+	ev.status = status == HAL_STATUS_SUCCESS ? GATT_SUCCESS : GATT_FAILURE;
+	memcpy(ev.uuid, cmd->uuid, sizeof(cmd->uuid));
+
+	ipc_send_notif(hal_ipc, HAL_SERVICE_ID_GATT,
+				HAL_EV_GATT_SERVER_CHAR_ADDED, sizeof(ev), &ev);
+
 	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_GATT,
 				HAL_OP_GATT_SERVER_ADD_CHARACTERISTIC, status);
 }
-- 
1.8.4

