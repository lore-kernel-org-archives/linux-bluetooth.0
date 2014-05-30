Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2 1/3] android/gatt: Fix parallel reading/writing attributes values from applications
Date: Fri, 30 May 2014 11:37:40 +0200
Message-Id: <1401442662-11475-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

It is needed because in some cases we send few read requests to applications.
Now all transactions data are overriden by last one, and if application wants
to respond to previous requests, transaction data is not found.
---
 android/gatt.c | 85 ++++++++++++++++++++++++++++++++++++++++------------------
 1 file changed, 59 insertions(+), 26 deletions(-)

diff --git a/android/gatt.c b/android/gatt.c
index 66d6224..80d9f30 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -106,9 +106,6 @@ struct gatt_app {
 
 	/* Valid for client applications */
 	struct queue *notifications;
-
-	/* Transaction data valid for server application */
-	struct pending_trans_data trans_id;
 };
 
 struct element_id {
@@ -175,6 +172,7 @@ struct gatt_device {
 struct app_connection {
 	struct gatt_device *device;
 	struct gatt_app *app;
+	struct queue *transactions;
 	int32_t id;
 };
 
@@ -182,6 +180,7 @@ static struct ipc *hal_ipc = NULL;
 static bdaddr_t adapter_addr;
 static bool scanning = false;
 static unsigned int advertising_cnt = 0;
+static int32_t trans_id = 1;
 
 static struct queue *gatt_apps = NULL;
 static struct queue *gatt_devices = NULL;
@@ -855,6 +854,8 @@ static void destroy_connection(void *data)
 	if (conn->device->conn_cnt == 0)
 		connection_cleanup(conn->device);
 
+	queue_destroy(conn->transactions, free);
+
 cleanup:
 	device_unref(conn->device);
 	free(conn);
@@ -1305,6 +1306,12 @@ static struct app_connection *create_connection(struct gatt_device *device,
 	new_conn->app = app;
 	new_conn->id = last_conn_id++;
 
+	new_conn->transactions = queue_new();
+	if (!new_conn->transactions) {
+		free(new_conn);
+		return NULL;
+	}
+
 	if (!queue_push_head(app_connections, new_conn)) {
 		error("gatt: Cannot push client on the client queue!?");
 
@@ -4169,26 +4176,29 @@ done:
 		send_dev_pending_response(dev, opcode);
 }
 
-static void set_trans_id(struct gatt_app *app, unsigned int id, int8_t opcode)
+static struct pending_trans_data *new_transaction(unsigned int id,
+								uint8_t opcode)
 {
-	app->trans_id.id = id;
-	app->trans_id.opcode = opcode;
-}
+	struct pending_trans_data *transaction;
 
-static void clear_trans_id(struct gatt_app *app)
-{
-	app->trans_id.id = 0;
-	app->trans_id.opcode = 0;
+	transaction = new0(struct pending_trans_data, 1);
+	if (!transaction)
+		return NULL;
+
+	transaction->id = id;
+	transaction->opcode = opcode;
+
+	return transaction;
 }
 
 static void read_cb(uint16_t handle, uint16_t offset, uint8_t att_opcode,
 					bdaddr_t *bdaddr, void *user_data)
 {
+	struct pending_trans_data *transaction;
 	struct hal_ev_gatt_server_request_read ev;
 	struct gatt_app *app;
 	struct app_connection *conn;
 	int32_t id = PTR_TO_INT(user_data);
-	static int32_t trans_id = 1;
 
 	app = find_app_by_id(id);
 	if (!app) {
@@ -4205,14 +4215,23 @@ static void read_cb(uint16_t handle, uint16_t offset, uint8_t att_opcode,
 	memset(&ev, 0, sizeof(ev));
 
 	/* Store the request data, complete callback and transaction id */
-	set_trans_id(app, trans_id++, att_opcode);
+	transaction = new_transaction(trans_id++, att_opcode);
+	if (!transaction) {
+		error("gatt: failed to allocate memory for transaction");
+		goto failed;
+	}
+
+	if (!queue_push_tail(conn->transactions, transaction)) {
+		free(transaction);
+		goto failed;
+	}
 
 	bdaddr2android(bdaddr, ev.bdaddr);
 	ev.conn_id = conn->id;
 	ev.attr_handle = handle;
 	ev.offset = offset;
 	ev.is_long = att_opcode == ATT_OP_READ_BLOB_REQ;
-	ev.trans_id = app->trans_id.id;
+	ev.trans_id = transaction->id;
 
 	ipc_send_notif(hal_ipc, HAL_SERVICE_ID_GATT,
 					HAL_EV_GATT_SERVER_REQUEST_READ,
@@ -4232,9 +4251,9 @@ static void write_cb(uint16_t handle, uint16_t offset,
 {
 	uint8_t buf[IPC_MTU];
 	struct hal_ev_gatt_server_request_write *ev = (void *) buf;
+	struct pending_trans_data *transaction;
 	struct gatt_app *app;
 	int32_t id = PTR_TO_INT(user_data);
-	static int32_t trans_id = 1;
 	struct app_connection *conn;
 
 	app = find_app_by_id(id);
@@ -4250,7 +4269,16 @@ static void write_cb(uint16_t handle, uint16_t offset,
 	}
 
 	/* Store the request data, complete callback and transaction id */
-	set_trans_id(app, trans_id++, att_opcode);
+	transaction = new_transaction(trans_id++, att_opcode);
+	if (!transaction) {
+		error("gatt: failed to allocate memory for transaction");
+		goto failed;
+	}
+
+	if (!queue_push_tail(conn->transactions, transaction)) {
+		free(transaction);
+		goto failed;
+	}
 
 	/* TODO figure it out */
 	if (att_opcode == ATT_OP_EXEC_WRITE_REQ)
@@ -4263,7 +4291,7 @@ static void write_cb(uint16_t handle, uint16_t offset,
 	ev->offset = offset;
 
 	ev->conn_id = conn->id;
-	ev->trans_id = app->trans_id.id;
+	ev->trans_id = transaction->id;
 
 	ev->is_prep = att_opcode == ATT_OP_PREP_WRITE_REQ;
 	ev->need_rsp = att_opcode == ATT_OP_WRITE_REQ;
@@ -4557,11 +4585,18 @@ reply:
 				HAL_OP_GATT_SERVER_SEND_INDICATION, status);
 }
 
+static bool match_trans_id(const void *data, const void *user_data)
+{
+	const struct pending_trans_data *transaction = data;
+
+	return transaction->id == PTR_TO_UINT(user_data);
+}
+
 static void handle_server_send_response(const void *buf, uint16_t len)
 {
 	const struct hal_cmd_gatt_server_send_response *cmd = buf;
+	struct pending_trans_data *transaction;
 	struct app_connection *conn;
-	struct gatt_app *app;
 	uint8_t status;
 
 	DBG("");
@@ -4573,22 +4608,20 @@ static void handle_server_send_response(const void *buf, uint16_t len)
 		goto reply;
 	}
 
-	app = conn->app;
-
-	if ((unsigned int)cmd->trans_id != app->trans_id.id) {
-		error("gatt: transaction ID mismatch (%d!=%d)",
-					cmd->trans_id, app->trans_id.id);
-
+	transaction = queue_remove_if(conn->transactions, match_trans_id,
+						UINT_TO_PTR(cmd->trans_id));
+	if (!transaction) {
+		error("gatt: transaction ID = %d not found", cmd->trans_id);
 		status = HAL_STATUS_FAILED;
 		goto reply;
 	}
 
-	send_gatt_response(conn->app->trans_id.opcode, cmd->handle, cmd->offset,
+	send_gatt_response(transaction->opcode, cmd->handle, cmd->offset,
 					cmd->status, cmd->len, cmd->data,
 					&conn->device->bdaddr);
 
 	/* Clean request data */
-	clear_trans_id(app);
+	free(transaction);
 
 	status = HAL_STATUS_SUCCESS;
 
-- 
1.9.0

