Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: szymon.janc@tieto.com, johan.hedberg@gmail.com,
	Marcin Kraglak <marcin.kraglak@tieto.com>
Subject: [PATCH v2 03/40] android/gatt: Add service functionality
Date: Tue, 29 Apr 2014 18:46:52 +0200
Message-Id: <1398790049-30303-4-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1398790049-30303-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1398790049-30303-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Marcin Kraglak <marcin.kraglak@tieto.com>

It will Add service to local database.
---
 android/gatt.c | 40 ++++++++++++++++++++++++++++++----------
 1 file changed, 30 insertions(+), 10 deletions(-)

diff --git a/android/gatt.c b/android/gatt.c
index 0bb5a70..6e578e1 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -43,6 +43,7 @@
 #include "utils.h"
 #include "src/shared/util.h"
 #include "src/shared/queue.h"
+#include "src/shared/gatt-db.h"
 #include "attrib/gattrib.h"
 #include "attrib/att.h"
 #include "attrib/gatt.h"
@@ -153,6 +154,7 @@ static struct queue *gatt_devices = NULL;
 static struct queue *app_connections = NULL;
 
 static struct queue *listen_apps = NULL;
+static struct gatt_db *gatt_db = NULL;
 
 static void bt_le_discovery_stop_cb(void);
 
@@ -3175,32 +3177,43 @@ static void handle_server_disconnect(const void *buf, uint16_t len)
 static void handle_server_add_service(const void *buf, uint16_t len)
 {
 	const struct hal_cmd_gatt_server_add_service *cmd = buf;
-	char uuidstr[MAX_LEN_UUID_STR];
+	struct hal_ev_gatt_server_service_added ev;
 	struct gatt_app *server;
-	struct element_id srvc_id;
 	uint8_t status;
+	bt_uuid_t uuid;
 
 	DBG("");
 
+	memset(&ev, 0, sizeof(ev));
+
 	server = find_app_by_id(cmd->server_if);
 	if (!server) {
-		error("gatt: server_if=%d not found", cmd->server_if);
 		status = HAL_STATUS_FAILED;
 		goto failed;
 	}
 
-	hal_srvc_id_to_element_id(&cmd->srvc_id, &srvc_id);
-	bt_uuid_to_string(&srvc_id.uuid, uuidstr, MAX_LEN_UUID_STR);
+	android2uuid(cmd->srvc_id.uuid, &uuid);
 
-	/* TODO: execute attribute database transaction */
-	DBG("Add primary service: server: %d, srvc_uuid: %s, num_handles: %d",
-				cmd->server_if, uuidstr, cmd->num_handles);
+	ev.srvc_handle = gatt_db_add_service(gatt_db, &uuid,
+							cmd->srvc_id.is_primary,
+							cmd->num_handles);
+	if (!ev.srvc_handle) {
+		status = HAL_STATUS_FAILED;
+		goto failed;
+	}
 
 	status = HAL_STATUS_SUCCESS;
 
 failed:
+	ev.status = status == HAL_STATUS_SUCCESS ? GATT_SUCCESS : GATT_FAILURE;
+	ev.srvc_id = cmd->srvc_id;
+	ev.server_if = cmd->server_if;
+
+	ipc_send_notif(hal_ipc, HAL_SERVICE_ID_GATT,
+			HAL_EV_GATT_SERVER_SERVICE_ADDED, sizeof(ev), &ev);
+
 	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_GATT,
-					HAL_OP_GATT_SERVER_ADD_SERVICE, status);
+			HAL_OP_GATT_SERVER_ADD_SERVICE, status);
 }
 
 static void handle_server_add_included_service(const void *buf, uint16_t len)
@@ -3503,9 +3516,10 @@ bool bt_gatt_register(struct ipc *ipc, const bdaddr_t *addr)
 	gatt_apps = queue_new();
 	app_connections = queue_new();
 	listen_apps = queue_new();
+	gatt_db = gatt_db_new();
 
 	if (!gatt_devices || !gatt_apps || !listen_apps ||
-							!app_connections) {
+						!app_connections || !gatt_db) {
 		error("gatt: Failed to allocate memory for queues");
 
 		queue_destroy(gatt_apps, NULL);
@@ -3520,6 +3534,9 @@ bool bt_gatt_register(struct ipc *ipc, const bdaddr_t *addr)
 		queue_destroy(listen_apps, NULL);
 		listen_apps = NULL;
 
+		gatt_db_destroy(gatt_db);
+		gatt_db = NULL;
+
 		return false;
 	}
 
@@ -3551,4 +3568,7 @@ void bt_gatt_unregister(void)
 
 	queue_destroy(listen_apps, NULL);
 	listen_apps = NULL;
+
+	gatt_db_destroy(gatt_db);
+	gatt_db = NULL;
 }
-- 
1.8.4

