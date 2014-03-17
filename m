Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <szymon.janc@tieto.com>,
	Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH v2] android/gatt: Find primary services
Date: Mon, 17 Mar 2014 11:07:07 +0100
Message-ID: <1395050827-11996-1-git-send-email-lukasz.rymanowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

With this patch it is possible to search all primary services.
---
 android/gatt.c | 106 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 105 insertions(+), 1 deletion(-)

diff --git a/android/gatt.c b/android/gatt.c
index 1081121..59954ab 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -64,6 +64,7 @@ struct gatt_device {
 
 	GAttrib *attrib;
 	GIOChannel *att_io;
+	struct queue *services;
 
 	guint watch_id;
 };
@@ -127,6 +128,7 @@ static void destroy_device(void *data)
 	struct gatt_device *dev = data;
 
 	queue_destroy(dev->clients, NULL);
+	queue_destroy(dev->services, free);
 	free(dev);
 }
 
@@ -205,6 +207,78 @@ failed:
 					HAL_OP_GATT_CLIENT_UNREGISTER, status);
 }
 
+static void primary_cb(uint8_t status, GSList *services, void *user_data)
+{
+	GSList *l;
+	struct gatt_device *dev = user_data;
+	struct hal_ev_gatt_client_search_complete ev;
+
+	DBG("Status %d", status);
+
+	if (status) {
+		error("gatt: Discover all primary services failed: %s",
+							att_ecode2str(status));
+		ev.status = HAL_STATUS_FAILED;
+		goto done;
+	}
+
+	if (!services) {
+		info("gatt: No primary services found");
+		ev.status = HAL_STATUS_SUCCESS;
+		goto done;
+	}
+
+	for (l = services; l; l = l->next) {
+		uint8_t buf[IPC_MTU];
+		struct hal_ev_gatt_client_search_result *ev_res = (void *)buf;
+		struct gatt_primary *prim = l->data;
+		struct gatt_primary *p;
+		bt_uuid_t uuid;
+
+		p = new0(struct gatt_primary, 1);
+		if (!p) {
+			error("gatt: Cannot allocate memory for gatt_primary");
+			continue;
+		}
+
+		memset(buf, 0, sizeof(buf));
+
+		/* Put primary service to our local list */
+		memcpy(p, prim, sizeof(*p));
+		if (!queue_push_tail(dev->services, p)) {
+			error("gatt: Cannot push primary service to the list");
+			free(p);
+			continue;
+		}
+
+		DBG("attr handle = 0x%04x, end grp handle = 0x%04x uuid: %s\n",
+					prim->range.start, prim->range.end,
+					prim->uuid);
+		/* Set event data */
+		ev_res->conn_id  = dev->conn_id;
+		ev_res->srvc_id.is_primary = 1;
+		ev_res->srvc_id.inst_id = 0;
+
+		if (bt_string_to_uuid(&uuid, prim->uuid) < 0) {
+			error("gatt: Cannot convert string to uuid");
+			continue;
+		}
+		memcpy(&ev_res->srvc_id.uuid, &uuid.value, sizeof(uuid.value));
+
+		ipc_send_notif(hal_ipc, HAL_SERVICE_ID_GATT ,
+					HAL_EV_GATT_CLIENT_SEARCH_RESULT,
+					sizeof(*ev_res), ev_res);
+	}
+
+	ev.status = HAL_STATUS_SUCCESS;
+
+done:
+	ev.conn_id = dev->conn_id;
+	ipc_send_notif(hal_ipc, HAL_SERVICE_ID_GATT,
+					HAL_EV_GATT_CLIENT_SEARCH_COMPLETE,
+					sizeof(ev), &ev);
+}
+
 static void connection_cleanup(struct gatt_device *device)
 {
 	if (device->watch_id) {
@@ -635,6 +709,14 @@ static void handle_client_connect(const void *buf, uint16_t len)
 		goto reply;
 	}
 
+	dev->services = queue_new();
+	if (!dev->services) {
+		error("gatt: Cannot create services queue");
+		queue_destroy(dev->clients, NULL);
+		status = HAL_STATUS_FAILED;
+		goto reply;
+	}
+
 	/* Update client list of device */
 	if (!queue_push_tail(dev->clients, INT_TO_PTR(cmd->client_if))) {
 		error("gatt: Cannot push client on the client queue!?");
@@ -755,10 +837,32 @@ static void handle_client_refresh(const void *buf, uint16_t len)
 
 static void handle_client_search_service(const void *buf, uint16_t len)
 {
+	const struct hal_cmd_gatt_client_search_service *cmd = buf;
+	struct gatt_device *dev;
+	uint8_t status;
+
 	DBG("");
 
+	dev = queue_find(conn_list, match_dev_by_conn_id,
+						INT_TO_PTR(cmd->conn_id));
+	if (!dev) {
+		error("gatt: dev with conn_id=%d not found", cmd->conn_id);
+		status = HAL_STATUS_FAILED;
+		goto reply;
+	}
+
+	/*TODO:  Handle filter uuid */
+
+	if (!gatt_discover_primary(dev->attrib, NULL, primary_cb, dev)) {
+		status = HAL_STATUS_FAILED;
+		goto reply;
+	}
+
+	status = HAL_STATUS_SUCCESS;
+
+reply:
 	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_GATT,
-			HAL_OP_GATT_CLIENT_SEARCH_SERVICE, HAL_STATUS_FAILED);
+			HAL_OP_GATT_CLIENT_SEARCH_SERVICE, status);
 }
 
 static void handle_client_get_included_service(const void *buf, uint16_t len)
-- 
1.8.4

