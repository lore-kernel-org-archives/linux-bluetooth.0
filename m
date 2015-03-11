Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 1/5] android/gatt: Implement MTU exchange HAL API
Date: Wed, 11 Mar 2015 15:41:19 +0100
Message-Id: <1426084883-10291-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This allow application to query for current MTU. MTU is always
exchanged on connection and notifications are sent to framework.

When client requests MTU exchange we just report current value but
don't trigger another exchange procedure (since this is against spec).
---
 android/gatt.c | 63 +++++++++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 60 insertions(+), 3 deletions(-)

diff --git a/android/gatt.c b/android/gatt.c
index 9c2a280..1a264ba 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -941,6 +941,39 @@ static bool get_local_mtu(struct gatt_device *dev, uint16_t *mtu)
 	return true;
 }
 
+static void notify_client_mtu_change(struct app_connection *conn, bool success)
+{
+	struct hal_ev_gatt_client_configure_mtu ev;
+	size_t mtu;
+
+	g_attrib_get_buffer(conn->device->attrib, &mtu);
+
+	ev.conn_id = conn->id;
+	ev.status = success ? GATT_SUCCESS : GATT_FAILURE;
+	ev.mtu = mtu;
+
+	ipc_send_notif(hal_ipc, HAL_SERVICE_ID_GATT,
+			HAL_EV_GATT_CLIENT_CONFIGURE_MTU, sizeof(ev), &ev);
+}
+
+static void notify_mtu_change(void *data, void *user_data)
+{
+	struct gatt_device *device = user_data;
+	struct app_connection *conn = data;
+
+	if (conn->device != device)
+		return;
+
+	switch (conn->app->type) {
+	case GATT_CLIENT:
+		notify_client_mtu_change(conn, true);
+		break;
+	case GATT_SERVER:
+	default:
+		break;
+	}
+}
+
 static bool update_mtu(struct gatt_device *device, uint16_t rmtu)
 {
 	uint16_t mtu, lmtu;
@@ -965,6 +998,8 @@ static bool update_mtu(struct gatt_device *device, uint16_t rmtu)
 		return false;
 	}
 
+	queue_foreach(app_connections, notify_mtu_change, device);
+
 	return true;
 }
 
@@ -1600,6 +1635,11 @@ reply:
 	data.status = status;
 	queue_foreach(app_connections, notify_app_connect_status_by_device,
 									&data);
+
+	/* For BR/EDR notify about MTU since it is not negotiable*/
+	if (cid != ATT_CID)
+		queue_foreach(app_connections, notify_mtu_change, dev);
+
 	device_unref(dev);
 
 	/* Check if we should restart scan */
@@ -5676,14 +5716,31 @@ static void handle_client_scan_filter_enable(const void *buf, uint16_t len)
 static void handle_client_configure_mtu(const void *buf, uint16_t len)
 {
 	const struct hal_cmd_gatt_client_configure_mtu *cmd = buf;
+	static struct app_connection *conn;
+	uint8_t status;
 
-	DBG("conn_id %u", cmd->conn_id);
+	DBG("conn_id %u mtu %d", cmd->conn_id, cmd->mtu);
 
-	/* TODO */
+	conn = find_connection_by_id(cmd->conn_id);
+	if (!conn) {
+		status = HAL_STATUS_FAILED;
+		goto failed;
+	}
 
+	/*
+	 * currently MTU is always exchanged on connection, just report current
+	 * value
+	 *
+	 * TODO figure out when send failed status
+	 * TODO should we fail for BR/EDR?
+	 */
+	notify_client_mtu_change(conn, false);
+	status = HAL_STATUS_SUCCESS;
+
+failed:
 	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_GATT,
 					HAL_OP_GATT_CLIENT_CONFIGURE_MTU,
-					HAL_STATUS_UNSUPPORTED);
+					status);
 }
 
 static void handle_client_conn_param_update(const void *buf, uint16_t len)
-- 
1.9.3

