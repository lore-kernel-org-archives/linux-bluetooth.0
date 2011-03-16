Return-Path: <cyrus@holtmann.org>
From: Waldemar Rymarkiewicz <waldemar.rymarkiewicz@tieto.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
CC: <linux-bluetooth@vger.kernel.org>,
	Waldemar Rymarkiewicz <waldemar.rymarkiewicz@tieto.com>
Subject: [PATCH v5 1/4] Sim Access Profile connect/disconnect procedures
Date: Wed, 16 Mar 2011 13:10:18 +0100
Message-ID: <1300277421-8053-1-git-send-email-waldemar.rymarkiewicz@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Add support for SAP protocol features:
	* connect and disconnect requests
	* connect and disconnect responses
	* disconnect indication
	* timeouts for the valid connection
---
 sap/sap.h    |    2 +-
 sap/server.c |  433 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 424 insertions(+), 11 deletions(-)

diff --git a/sap/sap.h b/sap/sap.h
index bd0f06d..24240ca 100644
--- a/sap/sap.h
+++ b/sap/sap.h
@@ -143,7 +143,7 @@ enum sap_param_id {
 #define SAP_PARAM_ID_DISCONNECT_IND_LEN		0x01
 #define SAP_PARAM_ID_CARD_READER_STATUS_LEN	0x01
 #define SAP_PARAM_ID_STATUS_CHANGE_LEN		0x01
-#define SAP_PARAM_ID_TRANSPORT_PROTOCOL_LEN	0x01
+#define SAP_PARAM_ID_TRANSPORT_PROTO_LEN	0x01
 
 /* Transport Protocol - SAP v1.1 section 5.2.9 */
 enum sap_transport_protocol {
diff --git a/sap/server.c b/sap/server.c
index 1c62a3e..8337fe1 100644
--- a/sap/server.c
+++ b/sap/server.c
@@ -50,14 +50,28 @@
 #define SAP_SERVER_CHANNEL	8
 #define SAP_BUF_SIZE		512
 
+#define PADDING4(x) (4 - (x & 0x03))
+#define PARAMETER_SIZE(x) (sizeof(struct sap_parameter) + x + PADDING4(x))
+
+#define SAP_NO_REQ 0xFF
+
+#define SAP_TIMER_GRACEFUL_DISCONNECT 30
+#define SAP_TIMER_NO_ACTIVITY 30
+
 enum {
 	SAP_STATE_DISCONNECTED,
+	SAP_STATE_CONNECT_IN_PROGRESS,
 	SAP_STATE_CONNECTED,
+	SAP_STATE_GRACEFUL_DISCONNECT,
+	SAP_STATE_IMMEDIATE_DISCONNECT,
+	SAP_STATE_CLIENT_DISCONNECT
 };
 
 struct sap_connection {
 	GIOChannel *io;
 	uint32_t state;
+	uint8_t processing_req;
+	guint timer_id;
 };
 
 struct sap_server {
@@ -71,6 +85,72 @@ struct sap_server {
 static DBusConnection *connection;
 static struct sap_server *server;
 
+static void start_guard_timer(struct sap_connection *conn, guint interval);
+static void stop_guard_timer(struct sap_connection *conn);
+static gboolean guard_timeout(gpointer data);
+
+static int check_msg(struct sap_message *msg)
+{
+	if (!msg)
+		return -EINVAL;
+
+	switch (msg->id) {
+	case SAP_CONNECT_REQ:
+		if (msg->nparam != 0x01)
+			return -EBADMSG;
+
+		if (msg->param->id != SAP_PARAM_ID_MAX_MSG_SIZE)
+			return -EBADMSG;
+
+		if (ntohs(msg->param->len) != SAP_PARAM_ID_MAX_MSG_SIZE_LEN)
+			return -EBADMSG;
+
+		break;
+
+	case SAP_TRANSFER_APDU_REQ:
+		if (msg->nparam != 0x01)
+			return -EBADMSG;
+
+		if (msg->param->id != SAP_PARAM_ID_COMMAND_APDU)
+			if ( msg->param->id != SAP_PARAM_ID_COMMAND_APDU7816)
+				return -EBADMSG;
+
+		if (msg->param->len == 0x00)
+			return -EBADMSG;
+
+		break;
+
+	case SAP_SET_TRANSPORT_PROTOCOL_REQ:
+		if (msg->nparam != 0x01)
+			return -EBADMSG;
+
+		if (msg->param->id != SAP_PARAM_ID_TRANSPORT_PROTOCOL)
+			return -EBADMSG;
+
+		if (ntohs(msg->param->len) != SAP_PARAM_ID_TRANSPORT_PROTO_LEN)
+			return -EBADMSG;
+
+		if (*msg->param->val != SAP_TRANSPORT_PROTOCOL_T0)
+			if (*msg->param->val != SAP_TRANSPORT_PROTOCOL_T1)
+				return -EBADMSG;
+
+		break;
+
+	case SAP_DISCONNECT_REQ:
+	case SAP_TRANSFER_ATR_REQ:
+	case SAP_POWER_SIM_OFF_REQ:
+	case SAP_POWER_SIM_ON_REQ:
+	case SAP_RESET_SIM_REQ:
+	case SAP_TRANSFER_CARD_READER_STATUS_REQ:
+		if (msg->nparam != 0x00)
+			return -EBADMSG;
+
+		break;
+	}
+
+	return 0;
+}
+
 static sdp_record_t *create_sap_record(uint8_t channel)
 {
 	sdp_list_t *apseq, *aproto, *profiles, *proto[2], *root, *svclass_id;
@@ -126,16 +206,170 @@ static sdp_record_t *create_sap_record(uint8_t channel)
 	return record;
 }
 
+static int send_message(struct sap_connection *conn, void *buf, size_t size)
+{
+	size_t written = 0;
+	GError *gerr = NULL;
+	GIOStatus gstatus;
+
+	if (!conn || !buf)
+		return -EINVAL;
+
+	DBG("size %zu", size);
+
+	gstatus = g_io_channel_write_chars(conn->io, buf, size, &written,
+						&gerr);
+	if (gstatus != G_IO_STATUS_NORMAL) {
+		if (gerr)
+			g_error_free(gerr);
+
+		error("write error (0x%02x).", gstatus);
+		return -EINVAL;
+	}
+
+	if (written != size)
+		error("write error.(written %zu size %zu)", written, size);
+
+	return 0;
+}
+
+static int disconnect_ind(void *sap_device, uint8_t disc_type)
+{
+	struct sap_connection *conn = sap_device;
+	char buf[SAP_BUF_SIZE];
+	struct sap_message *msg = (struct sap_message *) buf;
+	struct sap_parameter *param = (struct sap_parameter *) msg->param;
+	size_t size = sizeof(struct sap_message);
+
+	if (!conn)
+		return -EINVAL;
+
+	DBG("data %p state %d disc_type 0x%02x", conn, conn->state, disc_type);
+
+	if (conn->state != SAP_STATE_GRACEFUL_DISCONNECT &&
+			conn->state != SAP_STATE_IMMEDIATE_DISCONNECT) {
+		error("Processing error (state %d pr 0x%02x)", conn->state,
+							conn->processing_req);
+		return -EPERM;
+	}
+
+	memset(buf, 0, sizeof(buf));
+	msg->id = SAP_DISCONNECT_IND;
+	msg->nparam = 0x01;
+
+	/* Add disconnection type param. */
+	param->id  = SAP_PARAM_ID_DISCONNECT_IND;
+	param->len = htons(SAP_PARAM_ID_DISCONNECT_IND_LEN);
+	*param->val = disc_type;
+	size += PARAMETER_SIZE(SAP_PARAM_ID_DISCONNECT_IND_LEN);
+
+	return send_message(sap_device, buf, size);
+}
+
 static void connect_req(struct sap_connection *conn,
-					struct sap_parameter *param)
+				struct sap_parameter *param)
 {
-	DBG("SAP_CONNECT_REQUEST");
+	uint16_t maxmsgsize, *val;
+
+	DBG("conn %p state %d", conn, conn->state);
+
+	if (!param)
+		goto error_rsp;
+
+	if (conn->state != SAP_STATE_DISCONNECTED)
+		goto error_rsp;
+
+	stop_guard_timer(conn);
+
+	val = (uint16_t *) &param->val;
+	maxmsgsize = ntohs(*val);
+
+	DBG("Connect MaxMsgSize: 0x%04x", maxmsgsize);
+
+	conn->state = SAP_STATE_CONNECT_IN_PROGRESS;
+
+	if (maxmsgsize <= SAP_BUF_SIZE) {
+		conn->processing_req = SAP_CONNECT_REQ;
+		sap_connect_req(conn, maxmsgsize);
+	} else {
+		sap_connect_rsp(conn, SAP_STATUS_MAX_MSG_SIZE_NOT_SUPPORTED,
+								SAP_BUF_SIZE);
+	}
+
+	return;
+
+error_rsp:
+	error("Processing error (param %p state %d pr 0x%02x)", param,
+					conn->state, conn->processing_req);
+	sap_error_rsp(conn);
 }
 
 static int disconnect_req(struct sap_connection *conn, uint8_t disc_type)
 {
-	DBG("SAP_DISCONNECT_REQUEST");
-	return 0;
+	DBG("conn %p state %d disc_type 0x%02x", conn, conn->state, disc_type);
+
+	switch (disc_type) {
+	case SAP_DISCONNECTION_TYPE_GRACEFUL:
+		if (conn->state == SAP_STATE_DISCONNECTED)
+			goto error_req;
+
+		if (conn->state == SAP_STATE_CONNECT_IN_PROGRESS)
+			goto error_req;
+
+		if (conn->state == SAP_STATE_CONNECTED) {
+			conn->state = SAP_STATE_GRACEFUL_DISCONNECT;
+			conn->processing_req = SAP_NO_REQ;
+
+			disconnect_ind(conn, disc_type);
+			/* Timer will disconnect if client won't do.*/
+			start_guard_timer(conn, SAP_TIMER_GRACEFUL_DISCONNECT);
+		}
+
+		return 0;
+
+	case SAP_DISCONNECTION_TYPE_IMMEDIATE:
+		if (conn->state == SAP_STATE_DISCONNECTED)
+			goto error_req;
+
+		if (conn->state == SAP_STATE_CONNECT_IN_PROGRESS)
+			goto error_req;
+
+		if (conn->state == SAP_STATE_CONNECTED ||
+				conn->state == SAP_STATE_GRACEFUL_DISCONNECT) {
+			conn->state = SAP_STATE_IMMEDIATE_DISCONNECT;
+			conn->processing_req = SAP_NO_REQ;
+
+			stop_guard_timer(conn);
+			disconnect_ind(conn, disc_type);
+			sap_disconnect_req(conn, 0);
+		}
+
+		return 0;
+
+	case SAP_DISCONNECTION_TYPE_CLIENT:
+		if (conn->state != SAP_STATE_CONNECTED &&
+				conn->state != SAP_STATE_GRACEFUL_DISCONNECT)
+			goto error_rsp;
+
+		conn->state = SAP_STATE_CLIENT_DISCONNECT;
+		conn->processing_req = SAP_NO_REQ;
+
+		stop_guard_timer(conn);
+		sap_disconnect_req(conn, 0);
+
+		return 0;
+
+	default:
+		error("Unknown disconnection type (0x%02x).", disc_type);
+		return -EINVAL;
+	}
+
+error_rsp:
+	sap_error_rsp(conn);
+error_req:
+	error("Processing error (state %d pr 0x%02x)", conn->state,
+						conn->processing_req);
+	return -EPERM;
 }
 
 static void transfer_apdu_req(struct sap_connection *conn,
@@ -175,13 +409,163 @@ static void set_transport_protocol_req(struct sap_connection *conn,
 	DBG("SAP_SET_TRANSPORT_PROTOCOL_REQUEST");
 }
 
+static void start_guard_timer(struct sap_connection *conn, guint interval)
+{
+	if (!conn)
+		return;
+
+	if (!conn->timer_id)
+		conn->timer_id = g_timeout_add_seconds(interval, guard_timeout,
+									conn);
+	else
+		error("Timer is already active.");
+}
+
+static void stop_guard_timer(struct sap_connection *conn)
+{
+	if (conn  && conn->timer_id) {
+		g_source_remove(conn->timer_id);
+		conn->timer_id = 0;
+	}
+}
+
+static gboolean guard_timeout(gpointer data)
+{
+	struct sap_connection *conn = data;
+
+	if (!conn)
+		return FALSE;
+
+	DBG("conn %p state %d pr 0x%02x", conn, conn->state,
+						conn->processing_req);
+
+	conn->timer_id = 0;
+
+	switch (conn->state) {
+	case SAP_STATE_DISCONNECTED:
+		/* Client opened RFCOMM channel but didn't send CONNECT_REQ,
+		 * in fixed time or client disconnected SAP connection but
+		 * didn't closed RFCOMM channel in fixed time.*/
+		if (conn->io) {
+			g_io_channel_shutdown(conn->io, TRUE, NULL);
+			g_io_channel_unref(conn->io);
+		}
+		break;
+
+	case SAP_STATE_GRACEFUL_DISCONNECT:
+		/* Client didn't disconnect SAP connection in fixed time,
+		 * so close SAP connection immediately. */
+		disconnect_req(conn, SAP_DISCONNECTION_TYPE_IMMEDIATE);
+		break;
+
+	default:
+		error("Unexpected state (%d).", conn->state);
+		break;
+	}
+
+	return FALSE;
+}
+
 int sap_connect_rsp(void *sap_device, uint8_t status, uint16_t maxmsgsize)
 {
-	return 0;
+	struct sap_connection *conn = sap_device;
+	char buf[SAP_BUF_SIZE];
+	struct sap_message *msg = (struct sap_message *) buf;
+	struct sap_parameter *param = (struct sap_parameter *) msg->param;
+	size_t size = sizeof(struct sap_message);
+
+	if (!conn)
+		return -EINVAL;
+
+	DBG("state %d pr 0x%02x status 0x%02x", conn->state,
+						conn->processing_req, status);
+
+	if (conn->state != SAP_STATE_CONNECT_IN_PROGRESS)
+		return -EPERM;
+
+	memset(buf, 0, sizeof(buf));
+	msg->id = SAP_CONNECT_RESP;
+	msg->nparam = 0x01;
+
+	/* Add connection status */
+	param->id = SAP_PARAM_ID_CONN_STATUS;
+	param->len = htons(SAP_PARAM_ID_CONN_STATUS_LEN);
+	*param->val = status;
+	size += PARAMETER_SIZE(SAP_PARAM_ID_CONN_STATUS_LEN);
+
+	/* Add MaxMsgSize */
+	if (maxmsgsize && (status == SAP_STATUS_MAX_MSG_SIZE_NOT_SUPPORTED ||
+				status == SAP_STATUS_MAX_MSG_SIZE_TOO_SMALL)) {
+		uint16_t *len;
+
+		msg->nparam++;
+		param = (struct sap_parameter *) &buf[size];
+		param->id = SAP_PARAM_ID_MAX_MSG_SIZE;
+		param->len = htons(SAP_PARAM_ID_MAX_MSG_SIZE_LEN);
+		len = (uint16_t *) &param->val;
+		*len = htons(maxmsgsize);
+		size += PARAMETER_SIZE(SAP_PARAM_ID_MAX_MSG_SIZE_LEN);
+	}
+
+	if (status == SAP_STATUS_OK) {
+		gboolean connected = TRUE;
+
+		emit_property_changed(connection, server->path,
+						SAP_SERVER_INTERFACE,
+			"Connected", DBUS_TYPE_BOOLEAN, &connected);
+
+		conn->state = SAP_STATE_CONNECTED;
+	} else {
+		conn->state = SAP_STATE_DISCONNECTED;
+
+		/* Timer will shutdown channel if client doesn't send
+		 * CONNECT_REQ or doesn't shutdown channel itself.*/
+		start_guard_timer(conn, SAP_TIMER_NO_ACTIVITY);
+	}
+
+	conn->processing_req = SAP_NO_REQ;
+
+	return send_message(sap_device, buf, size);
 }
 
 int sap_disconnect_rsp(void *sap_device)
 {
+	struct sap_connection *conn = sap_device;
+	struct sap_message msg;
+
+	if (!conn)
+		return -EINVAL;
+
+	DBG("state %d pr 0x%02x", conn->state, conn->processing_req);
+
+	switch (conn->state) {
+	case SAP_STATE_CLIENT_DISCONNECT:
+		memset(&msg, 0, sizeof(msg));
+		msg.id = SAP_DISCONNECT_RESP;
+
+		conn->state = SAP_STATE_DISCONNECTED;
+		conn->processing_req = SAP_NO_REQ;
+
+		/* Timer will close channel if client doesn't do it.*/
+		start_guard_timer(conn, SAP_TIMER_NO_ACTIVITY);
+
+		return send_message(sap_device, &msg, sizeof(msg));
+
+	case SAP_STATE_IMMEDIATE_DISCONNECT:
+		conn->state = SAP_STATE_DISCONNECTED;
+		conn->processing_req = SAP_NO_REQ;
+
+		if (conn->io) {
+			g_io_channel_shutdown(conn->io, TRUE, NULL);
+			g_io_channel_unref(conn->io);
+		}
+
+		return 0;
+
+	default:
+		break;
+	}
+
 	return 0;
 }
 
@@ -242,11 +626,14 @@ static int handle_cmd(void *data, void *buf, size_t size)
 		return -EINVAL;
 
 	if (size < sizeof(struct sap_message))
-		return -EINVAL;
+		goto error_rsp;
 
 	if (msg->nparam != 0 && size < (sizeof(struct sap_message) +
 					sizeof(struct sap_parameter) + 4))
-		return -EBADMSG;
+		goto error_rsp;
+
+	if (check_msg(msg) < 0)
+		goto error_rsp;
 
 	switch (msg->id) {
 	case SAP_CONNECT_REQ:
@@ -278,10 +665,13 @@ static int handle_cmd(void *data, void *buf, size_t size)
 		return 0;
 	default:
 		DBG("SAP unknown message.");
-		return -ENOMSG;
+		break;
 	}
 
-	return -1;
+error_rsp:
+	DBG("Bad request message format.");
+	sap_error_rsp(conn);
+	return -EBADMSG;
 }
 
 static void sap_conn_remove(struct sap_connection *conn)
@@ -347,6 +737,20 @@ static void sap_io_destroy(void *data)
 	DBG("conn %p", conn);
 
 	if (conn && conn->io) {
+		gboolean connected = FALSE;
+
+		stop_guard_timer(conn);
+
+		if (conn->state != SAP_STATE_CONNECT_IN_PROGRESS)
+			emit_property_changed(connection, server->path,
+					SAP_SERVER_INTERFACE, "Connected",
+					DBUS_TYPE_BOOLEAN, &connected);
+
+		if (conn->state == SAP_STATE_CONNECT_IN_PROGRESS ||
+				conn->state == SAP_STATE_CONNECTED ||
+				conn->state == SAP_STATE_GRACEFUL_DISCONNECT)
+			sap_disconnect_req(NULL, 1);
+
 		conn->io = NULL;
 		sap_conn_remove(conn);
 	}
@@ -361,6 +765,10 @@ static void sap_connect_cb(GIOChannel *io, GError *gerr, gpointer data)
 	if (!conn)
 		return;
 
+	/* Timer will shutdown the channel in case of lack of client
+	   activity */
+	start_guard_timer(conn, SAP_TIMER_NO_ACTIVITY);
+
 	g_io_add_watch_full(io, G_PRIORITY_DEFAULT,
 			G_IO_IN | G_IO_ERR | G_IO_HUP | G_IO_NVAL,
 			sap_io_cb, conn, sap_io_destroy);
@@ -468,6 +876,10 @@ static DBusMessage *disconnect(DBusConnection *conn, DBusMessage *msg,
 	if (!server->conn)
 		return message_failed(msg, "Client already disconnected");
 
+	if (disconnect_req(server->conn, SAP_DISCONNECTION_TYPE_GRACEFUL) < 0)
+		return g_dbus_create_error(msg, ERROR_INTERFACE	".Failed",
+				"There is no active connection");
+
 	return dbus_message_new_method_return(msg);
 }
 
@@ -494,7 +906,8 @@ static DBusMessage *get_properties(DBusConnection *c,
 			DBUS_TYPE_STRING_AS_STRING DBUS_TYPE_VARIANT_AS_STRING
 			DBUS_DICT_ENTRY_END_CHAR_AS_STRING, &dict);
 
-	connected = (conn->state == SAP_STATE_CONNECTED);
+	connected = (conn->state == SAP_STATE_CONNECTED ||
+			conn->state == SAP_STATE_GRACEFUL_DISCONNECT);
 	dict_append_entry(&dict, "Connected", DBUS_TYPE_BOOLEAN, &connected);
 
 	dbus_message_iter_close_container(&iter, &dict);
-- 
1.7.1

