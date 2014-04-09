Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC 08/16] android/gatt: Add service functionality
Date: Wed,  9 Apr 2014 09:07:06 +0200
Message-Id: <1397027234-12003-9-git-send-email-marcin.kraglak@tieto.com>
In-Reply-To: <1397027234-12003-1-git-send-email-marcin.kraglak@tieto.com>
References: <1397027234-12003-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

It will Add service to local database.
---
 android/gatt.c | 56 +++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 55 insertions(+), 1 deletion(-)

diff --git a/android/gatt.c b/android/gatt.c
index a33ce25..76753a8 100644
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
@@ -130,6 +131,8 @@ static struct queue *conn_list	= NULL;		/* Connected devices */
 static struct queue *conn_wait_queue = NULL;	/* Devs waiting to connect */
 static struct queue *disc_dev_list = NULL;	/* Disconnected devices */
 
+static struct gatt_db *gatt_db = NULL;
+
 static void bt_le_discovery_stop_cb(void);
 
 static void android2uuid(const uint8_t *uuid, bt_uuid_t *dst)
@@ -2669,12 +2672,56 @@ static void handle_server_disconnect(const void *buf, uint16_t len)
 			HAL_OP_GATT_SERVER_DISCONNECT, HAL_STATUS_FAILED);
 }
 
+static struct gatt_server *find_server_by_id(int32_t id)
+{
+	return queue_find(gatt_servers, match_server_by_id, INT_TO_PTR(id));
+}
+
 static void handle_server_add_service(const void *buf, uint16_t len)
 {
+	const struct hal_cmd_gatt_server_add_service *cmd = buf;
+	struct hal_ev_gatt_server_service_added ev;
+	enum gatt_db_service_type type;
+	struct gatt_server *server;
+	uint8_t status;
+	bt_uuid_t uuid;
+
 	DBG("");
 
+	memset(&ev, 0, sizeof(ev));
+
+	server = find_server_by_id(cmd->server_if);
+	if (!server) {
+		status = HAL_STATUS_FAILED;
+		goto failed;
+	}
+
+	if (cmd->srvc_id.is_primary)
+		type = GATT_DB_SERVICE_PRIMARY;
+	else
+		type = GATT_DB_SERVICE_SECONDARY;
+
+	android2uuid(cmd->srvc_id.uuid, &uuid);
+
+	ev.srvc_handle = gatt_db_new_service(gatt_db, &uuid, type,
+							cmd->num_handles);
+	if (!ev.srvc_handle) {
+		status = HAL_STATUS_FAILED;
+		goto failed;
+	}
+
+	status = HAL_STATUS_SUCCESS;
+
+failed:
+	ev.status = status == HAL_STATUS_SUCCESS ? GATT_SUCCESS : GATT_FAILURE;
+	ev.srvc_id = cmd->srvc_id;
+	ev.server_if = cmd->server_if;
+
+	ipc_send_notif(hal_ipc, HAL_SERVICE_ID_GATT,
+		HAL_EV_GATT_SERVER_SERVICE_ADDED, sizeof(ev), &ev);
+
 	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_GATT,
-			HAL_OP_GATT_SERVER_ADD_SERVICE, HAL_STATUS_FAILED);
+			HAL_OP_GATT_SERVER_ADD_SERVICE, status);
 }
 
 static void handle_server_add_included_service(const void *buf, uint16_t len)
@@ -2859,6 +2906,7 @@ bool bt_gatt_register(struct ipc *ipc, const bdaddr_t *addr)
 	gatt_clients = queue_new();
 	gatt_servers = queue_new();
 	disc_dev_list = queue_new();
+	gatt_db = gatt_db_new();
 
 	if (!conn_list || !conn_wait_queue || !gatt_clients || !gatt_servers ||
 							!disc_dev_list) {
@@ -2879,6 +2927,9 @@ bool bt_gatt_register(struct ipc *ipc, const bdaddr_t *addr)
 		queue_destroy(disc_dev_list, NULL);
 		disc_dev_list = NULL;
 
+		gatt_db_destroy(gatt_db);
+		gatt_db = NULL;
+
 		return false;
 	}
 
@@ -2913,4 +2964,7 @@ void bt_gatt_unregister(void)
 
 	queue_destroy(disc_dev_list, destroy_device);
 	disc_dev_list = NULL;
+
+	gatt_db_destroy(gatt_db);
+	gatt_db = NULL;
 }
-- 
1.8.5.3

