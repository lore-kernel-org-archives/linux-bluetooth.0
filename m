Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH v3 4/5] android/gatt: Add disconnect GATT device
Date: Mon, 17 Mar 2014 01:01:12 +0100
Message-ID: <1395014473-7600-5-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1395014473-7600-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1395014473-7600-1-git-send-email-lukasz.rymanowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Disconnect scenarios:

1. If there is more then one client for a given gatt_device then
client id is removed from dev->clients, success response is sent
together with success disconnect event.

2. If there is only one client for a given remote device then we
do what is decribed above plus clean of gattrib stuff

3. In case client_if or conn_id is incorrect, response failed is sent
---
 android/gatt.c | 55 ++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 54 insertions(+), 1 deletion(-)

diff --git a/android/gatt.c b/android/gatt.c
index f2a1b07..1081121 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -114,6 +114,14 @@ static bool match_dev_connect_ready(const void *data, const void *user_data)
 	return dev->connect_ready;
 }
 
+static bool match_dev_by_conn_id(const void *data, const void *user_data)
+{
+	const struct gatt_device *dev = data;
+	const int32_t conn_id = PTR_TO_INT(user_data);
+
+	return dev->conn_id == conn_id;
+}
+
 static void destroy_device(void *data)
 {
 	struct gatt_device *dev = data;
@@ -678,10 +686,55 @@ reply:
 
 static void handle_client_disconnect(const void *buf, uint16_t len)
 {
+	const struct hal_cmd_gatt_client_disconnect *cmd = buf;
+	struct gatt_device *dev;
+	uint8_t status;
+	char addr[18];
+
 	DBG("");
 
+	ba2str((bdaddr_t *)&cmd->bdaddr, addr);
+
+	dev = queue_find(conn_list, match_dev_by_conn_id,
+						INT_TO_PTR(cmd->conn_id));
+	if (!dev) {
+		error("gatt: dev %s with conn_id=%d not found",
+							addr, cmd->conn_id);
+		status = HAL_STATUS_FAILED;
+		goto reply;
+	}
+
+	/*Check if client owns this connection */
+	if (!queue_remove_if(dev->clients, match_by_value,
+						INT_TO_PTR(cmd->client_if))) {
+		error("gatt: cannot remove conn_id=%d", cmd->client_if);
+		status = HAL_STATUS_FAILED;
+	} else {
+		status = HAL_STATUS_SUCCESS;
+	}
+
+reply:
 	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_GATT,
-			HAL_OP_GATT_CLIENT_DISCONNECT, HAL_STATUS_FAILED);
+			HAL_OP_GATT_CLIENT_DISCONNECT, status);
+
+	if (status == HAL_STATUS_FAILED)
+		return;
+
+	/* Just send disconnect event. If there is more clients on this
+	 * device then this is what we shall to do.
+	 * If this is last client, this is still OK to do because on connect
+	 * request we do le scan and wait until remote device start
+	 * advertisement */
+	send_disconnect_notify(cmd->client_if, dev, HAL_STATUS_SUCCESS);
+
+	/* If there is more clients just return */
+	if (!queue_isempty(dev->clients))
+		return;
+
+	/* If this is last client do more cleaning */
+	connection_cleanup(dev);
+	dev = queue_remove_if(conn_list, match_dev_by_bdaddr, &dev->bdaddr);
+	destroy_device(dev);
 }
 
 static void handle_client_listen(const void *buf, uint16_t len)
-- 
1.8.4

