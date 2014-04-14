Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: szymon.janc@tieto.com,
	Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH 3/3] android/gatt: Add support for client->listen
Date: Mon, 14 Apr 2014 10:58:39 +0200
Message-Id: <1397465919-12677-3-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1397465919-12677-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1397465919-12677-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds support for gatt client listen which start/stop
advertising
---
 android/gatt.c | 66 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 64 insertions(+), 2 deletions(-)

diff --git a/android/gatt.c b/android/gatt.c
index 53131d4..e076a72 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -130,6 +130,8 @@ static struct queue *conn_list = NULL;		/* Connected devices */
 static struct queue *conn_wait_queue = NULL;	/* Devs waiting to connect */
 static struct queue *disc_dev_list = NULL;	/* Disconnected devices */
 
+static struct queue *listen_clients = NULL;
+
 static void bt_le_discovery_stop_cb(void);
 
 static void android2uuid(const uint8_t *uuid, bt_uuid_t *dst)
@@ -1279,12 +1281,65 @@ reply:
 	put_device_on_disc_list(dev);
 }
 
+static void send_client_listen_notify(int32_t id, int32_t status)
+{
+	struct hal_ev_gatt_client_listen ev;
+
+	/* Server if because of typo in android headers */
+	ev.server_if = id;
+	ev.status = status;
+
+	ipc_send_notif(hal_ipc, HAL_SERVICE_ID_GATT,
+						HAL_EV_GATT_CLIENT_LISTEN,
+						sizeof(ev), &ev);
+	if (!status)
+		queue_remove(listen_clients, INT_TO_PTR(id));
+}
+
+static void set_advertising_cb(uint8_t status, void *user_data)
+{
+	int32_t client_id = PTR_TO_INT(user_data);
+
+	send_client_listen_notify(client_id, status);
+}
+
 static void handle_client_listen(const void *buf, uint16_t len)
 {
+	const struct hal_cmd_gatt_client_listen *cmd = buf;
+	uint8_t status;
+
 	DBG("");
 
+	if (queue_find(listen_clients, match_by_value,
+						INT_TO_PTR(cmd->client_if))) {
+
+		status = HAL_STATUS_SUCCESS;
+		goto reply;
+	}
+
+	if (!queue_push_tail(listen_clients, INT_TO_PTR(cmd->client_if))) {
+		error("gatt: Could not put client on listen queue");
+		status = HAL_STATUS_FAILED;
+		goto reply;
+	}
+
+	if (!bt_le_set_advertising(cmd->start, set_advertising_cb,
+						INT_TO_PTR(cmd->client_if))) {
+		error("gatt: Could not set advertising");
+		status = HAL_STATUS_FAILED;
+		queue_remove(listen_clients, INT_TO_PTR(cmd->client_if));
+		goto reply;
+	}
+
+	status = HAL_STATUS_SUCCESS;
+
+reply:
 	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_GATT, HAL_OP_GATT_CLIENT_LISTEN,
-							HAL_STATUS_FAILED);
+							status);
+
+	if (status != HAL_STATUS_SUCCESS)
+		send_client_listen_notify(cmd->client_if, GATT_FAILURE);
+
 }
 
 static void handle_client_refresh(const void *buf, uint16_t len)
@@ -3008,9 +3063,10 @@ bool bt_gatt_register(struct ipc *ipc, const bdaddr_t *addr)
 	gatt_clients = queue_new();
 	gatt_servers = queue_new();
 	disc_dev_list = queue_new();
+	listen_clients = queue_new();
 
 	if (!conn_list || !conn_wait_queue || !gatt_clients || !gatt_servers ||
-							!disc_dev_list) {
+					!disc_dev_list || !listen_clients) {
 		error("gatt: Failed to allocate memory for queues");
 
 		queue_destroy(gatt_servers, NULL);
@@ -3028,6 +3084,9 @@ bool bt_gatt_register(struct ipc *ipc, const bdaddr_t *addr)
 		queue_destroy(disc_dev_list, NULL);
 		disc_dev_list = NULL;
 
+		queue_destroy(listen_clients, NULL);
+		listen_clients = NULL;
+
 		return false;
 	}
 
@@ -3062,4 +3121,7 @@ void bt_gatt_unregister(void)
 
 	queue_destroy(disc_dev_list, destroy_device);
 	disc_dev_list = NULL;
+
+	queue_destroy(listen_clients, NULL);
+	listen_clients = NULL;
 }
-- 
1.8.4

