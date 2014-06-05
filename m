Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH 3/3] android/gatt: Handle prepare and execute write
Date: Thu,  5 Jun 2014 11:38:52 +0200
Message-Id: <1401961132-29459-3-git-send-email-marcin.kraglak@tieto.com>
In-Reply-To: <1401961132-29459-1-git-send-email-marcin.kraglak@tieto.com>
References: <1401961132-29459-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>

Once remote device sends write execute we need to notify all the
server applications with this. Application will send response on this and
once we collect all the responses we should send execute write response
to remote device

This is initial version of handling execute write. Still many corner cases
have to be handled. Some of them seems to be not easy to solve with
existing BT HAL API e.g. BlueZ sends execute write to couple of server
applications and one of them reply with error. According to spec execute
write shall be atomic. In scenario that one server out of many replies
with error makes this write not atomic. There is no way to handle it with current
BT HAL API.
---
 android/gatt.c | 112 +++++++++++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 106 insertions(+), 6 deletions(-)

diff --git a/android/gatt.c b/android/gatt.c
index ddba505..147c4d1 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -173,6 +173,8 @@ struct app_connection {
 	struct gatt_app *app;
 	struct queue *transactions;
 	int32_t id;
+
+	bool wait_execute_write;
 };
 
 static struct ipc *hal_ipc = NULL;
@@ -4263,15 +4265,18 @@ static void write_cb(uint16_t handle, uint16_t offset,
 		goto failed;
 	}
 
+	/*
+	 * Remember that this application has ongoing prep write
+	 * Need it later to find out where to send execute write
+	 */
+	if (att_opcode == ATT_OP_PREP_WRITE_REQ)
+		conn->wait_execute_write = true;
+
 	/* Store the request data, complete callback and transaction id */
 	transaction = conn_add_transact(conn, att_opcode);
 	if (!transaction)
 		goto failed;
 
-	/* TODO figure it out */
-	if (att_opcode == ATT_OP_EXEC_WRITE_REQ)
-		goto failed;
-
 	memset(ev, 0, sizeof(*ev));
 
 	bdaddr2android(bdaddr, &ev->bdaddr);
@@ -4580,10 +4585,25 @@ static bool match_trans_id(const void *data, const void *user_data)
 	return transaction->id == PTR_TO_UINT(user_data);
 }
 
+
+static bool find_conn_waiting_exec_write(const void *data,
+							const void *user_data)
+{
+	const struct app_connection *conn = data;
+
+	return conn->wait_execute_write;
+}
+
+static bool pending_execute_write(void)
+{
+	return queue_find(app_connections, find_conn_waiting_exec_write, NULL);
+}
+
 static void handle_server_send_response(const void *buf, uint16_t len)
 {
 	const struct hal_cmd_gatt_server_send_response *cmd = buf;
 	struct pending_trans_data *transaction;
+	uint16_t handle = cmd->handle;
 	struct app_connection *conn;
 	uint8_t status;
 
@@ -4604,10 +4624,27 @@ static void handle_server_send_response(const void *buf, uint16_t len)
 		goto reply;
 	}
 
-	send_gatt_response(transaction->opcode, cmd->handle, cmd->offset,
+	if (transaction->opcode == ATT_OP_EXEC_WRITE_REQ) {
+		conn->wait_execute_write = false;
+
+		/* Check for execute response from all server applications */
+		if (pending_execute_write())
+			goto done;
+
+		/* Make sure handle is 0. We need it to find pending request */
+		handle = 0;
+
+		/*
+		 * FIXME: Handle situation when not all server applications
+		 * respond with a success.
+		 */
+	}
+
+	send_gatt_response(transaction->opcode, handle, cmd->offset,
 					cmd->status, cmd->len, cmd->data,
 					&conn->device->bdaddr);
 
+done:
 	/* Clean request data */
 	free(transaction);
 
@@ -5233,6 +5270,66 @@ static uint8_t write_prep_request(const uint8_t *cmd, uint16_t cmd_len,
 	return 0;
 }
 
+static void send_server_write_execute_notify(void *data, void *user_data)
+{
+	struct hal_ev_gatt_server_request_exec_write *ev = user_data;
+	struct pending_trans_data *transaction;
+	struct app_connection *conn = data;
+
+	if (!conn->wait_execute_write)
+		return;
+
+	ev->conn_id = conn->id;
+
+	transaction = conn_add_transact(conn, ATT_OP_EXEC_WRITE_REQ);
+	if (!transaction) {
+		conn->wait_execute_write = false;
+		return;
+	}
+
+	ev->trans_id = transaction->id;
+
+	ipc_send_notif(hal_ipc, HAL_SERVICE_ID_GATT,
+				HAL_EV_GATT_SERVER_REQUEST_EXEC_WRITE,
+				sizeof(*ev), ev);
+}
+
+static uint8_t write_execute_request(const uint8_t *cmd, uint16_t cmd_len,
+						struct gatt_device *dev)
+{
+	struct hal_ev_gatt_server_request_exec_write ev;
+	uint8_t value;
+	struct pending_request *data;
+
+	/*
+	 * Check if there was any write prep before.
+	 * TODO: Try to find better error code if possible
+	 */
+	if (!pending_execute_write())
+		return ATT_ECODE_UNLIKELY;
+
+	if (!dec_exec_write_req(cmd, cmd_len, &value))
+		return ATT_ECODE_INVALID_PDU;
+
+	memset(&ev, 0, sizeof(ev));
+	bdaddr2android(&dev->bdaddr, &ev.bdaddr);
+	ev.exec_write = value;
+
+	data = new0(struct pending_request, 1);
+	if (!data)
+		return ATT_ECODE_INSUFF_RESOURCES;
+
+	data->state = REQUEST_PENDING;
+	if (!queue_push_tail(dev->pending_requests, data)) {
+		free(data);
+		return ATT_ECODE_INSUFF_RESOURCES;
+	}
+
+	queue_foreach(app_connections, send_server_write_execute_notify, &ev);
+
+	return 0;
+}
+
 static void att_handler(const uint8_t *ipdu, uint16_t len, gpointer user_data)
 {
 	struct gatt_device *dev = user_data;
@@ -5301,7 +5398,10 @@ static void att_handler(const uint8_t *ipdu, uint16_t len, gpointer user_data)
 		/* Client will handle this */
 		return;
 	case ATT_OP_EXEC_WRITE_REQ:
-		/* TODO */
+		status = write_execute_request(ipdu, len, dev);
+		if (!status)
+			return;
+		break;
 	case ATT_OP_HANDLE_CNF:
 	case ATT_OP_READ_MULTI_REQ:
 	default:
-- 
1.9.3

