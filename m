Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: szymon.janc@tieto.com,
	Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH v4 2/2] android/gatt: Add support for client listen command
Date: Tue, 15 Apr 2014 10:16:10 +0200
Message-Id: <1397549770-861-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds support for gatt client listen which start/stop
advertising
---
 android/gatt.c | 134 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 132 insertions(+), 2 deletions(-)

diff --git a/android/gatt.c b/android/gatt.c
index 66fc3fc..0a9c7fc 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -130,6 +130,8 @@ static struct queue *conn_list = NULL;		/* Connected devices */
 static struct queue *conn_wait_queue = NULL;	/* Devs waiting to connect */
 static struct queue *disc_dev_list = NULL;	/* Disconnected devices */
 
+static struct queue *listen_clients = NULL;
+
 static void bt_le_discovery_stop_cb(void);
 
 static void android2uuid(const uint8_t *uuid, bt_uuid_t *dst)
@@ -1282,12 +1284,133 @@ reply:
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
+}
+
+struct listen_data {
+	int32_t client_id;
+	bool start;
+};
+
+static void set_advertising_cb(uint8_t status, void *user_data)
+{
+	struct listen_data *l = user_data;
+
+	send_client_listen_notify(l->client_id, status);
+
+	/* Let's remove client from the list in two cases
+	 * 1. Start failed
+	 * 2. Stop succeed
+	 */
+	if ((l->start && status) || (!l->start && !status))
+		queue_remove(listen_clients, INT_TO_PTR(l->client_id));
+
+	free(l);
+}
+
 static void handle_client_listen(const void *buf, uint16_t len)
 {
+	const struct hal_cmd_gatt_client_listen *cmd = buf;
+	uint8_t status;
+	struct listen_data *data;
+	bool req_sent = false;
+	void *listening_client;
+
 	DBG("");
 
+	if (!find_client_by_id(cmd->client_if)) {
+		error("gatt: Client not registered");
+		status = HAL_STATUS_FAILED;
+		goto reply;
+	}
+
+	listening_client = queue_find(listen_clients, match_by_value,
+						INT_TO_PTR(cmd->client_if));
+	/* Start listening */
+	if (cmd->start) {
+		if (listening_client) {
+			status = HAL_STATUS_SUCCESS;
+			goto reply;
+		}
+
+		if (!queue_push_tail(listen_clients,
+						INT_TO_PTR(cmd->client_if))) {
+			error("gatt: Could not put client on listen queue");
+			status = HAL_STATUS_FAILED;
+			goto reply;
+		}
+
+		/* If listen is already on just return success*/
+		if (queue_length(listen_clients) > 1) {
+			status = HAL_STATUS_SUCCESS;
+			goto reply;
+		}
+	} else {
+		/* Stop listening.
+		 * Check if client was listening
+		 */
+		if (!listening_client) {
+			error("gatt: This client %d does not listen",
+							cmd->client_if);
+			status = HAL_STATUS_FAILED;
+			goto reply;
+		}
+
+		/* In case there is more listening clients don't stop
+		 * advertising
+		*/
+		if (queue_length(listen_clients) > 1) {
+			queue_remove(listen_clients,
+						INT_TO_PTR(cmd->client_if));
+			status = HAL_STATUS_SUCCESS;
+			goto reply;
+		}
+	}
+
+	data = new0(struct listen_data, 1);
+	if (!data) {
+		error("gatt: Could not allocate memory for listen data");
+		status = HAL_STATUS_NOMEM;
+		goto reply;
+	}
+
+	data->client_id = cmd->client_if;
+	data->start = cmd->start;
+
+	if (!bt_le_set_advertising(cmd->start, set_advertising_cb, data)) {
+		error("gatt: Could not set advertising");
+		status = HAL_STATUS_FAILED;
+		free(data);
+		goto reply;
+	}
+
+	/* Use this flag to keep in mind that we are waiting for callback with
+	 * result
+	 */
+	req_sent = true;
+
+	status = HAL_STATUS_SUCCESS;
+
+reply:
 	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_GATT, HAL_OP_GATT_CLIENT_LISTEN,
-							HAL_STATUS_FAILED);
+							status);
+
+	/* In case of early success or error, just send notification up */
+	if (!req_sent) {
+		int32_t gatt_status = status == HAL_STATUS_SUCCESS ?
+						GATT_SUCCESS : GATT_FAILURE;
+		send_client_listen_notify(cmd->client_if, gatt_status);
+	}
 }
 
 static void handle_client_refresh(const void *buf, uint16_t len)
@@ -3052,9 +3175,10 @@ bool bt_gatt_register(struct ipc *ipc, const bdaddr_t *addr)
 	gatt_clients = queue_new();
 	gatt_servers = queue_new();
 	disc_dev_list = queue_new();
+	listen_clients = queue_new();
 
 	if (!conn_list || !conn_wait_queue || !gatt_clients || !gatt_servers ||
-							!disc_dev_list) {
+					!disc_dev_list || !listen_clients) {
 		error("gatt: Failed to allocate memory for queues");
 
 		queue_destroy(gatt_servers, NULL);
@@ -3072,6 +3196,9 @@ bool bt_gatt_register(struct ipc *ipc, const bdaddr_t *addr)
 		queue_destroy(disc_dev_list, NULL);
 		disc_dev_list = NULL;
 
+		queue_destroy(listen_clients, NULL);
+		listen_clients = NULL;
+
 		return false;
 	}
 
@@ -3106,4 +3233,7 @@ void bt_gatt_unregister(void)
 
 	queue_destroy(disc_dev_list, destroy_device);
 	disc_dev_list = NULL;
+
+	queue_destroy(listen_clients, NULL);
+	listen_clients = NULL;
 }
-- 
1.8.4

