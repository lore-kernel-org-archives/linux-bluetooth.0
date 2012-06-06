Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 11/17] SAP: Use sap_server instead of sap_connection as key for drivers
Date: Wed, 6 Jun 2012 15:19:21 +0200
Message-ID: <1338988767-19467-11-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1338988767-19467-1-git-send-email-szymon.janc@tieto.com>
References: <1338988767-19467-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is a preparation for fixing SAP server when multiple adapters are
present. This is to avoid having extra pointer from sap_connection to
its sap_server struture. Only one connection per server is allowed
anyway so using sap_server as key is safe.
---
 sap/server.c |  208 ++++++++++++++++++++++++++++++++++------------------------
 1 file changed, 121 insertions(+), 87 deletions(-)

diff --git a/sap/server.c b/sap/server.c
index 648fa58..f259bb0 100644
--- a/sap/server.c
+++ b/sap/server.c
@@ -82,8 +82,8 @@ struct sap_server {
 static DBusConnection *connection;
 static struct sap_server *sap_server;
 
-static void start_guard_timer(struct sap_connection *conn, guint interval);
-static void stop_guard_timer(struct sap_connection *conn);
+static void start_guard_timer(struct sap_server *server, guint interval);
+static void stop_guard_timer(struct sap_server *server);
 static gboolean guard_timeout(gpointer data);
 
 static size_t add_result_parameter(uint8_t result,
@@ -299,9 +299,10 @@ static int sap_error_rsp(struct sap_connection *conn)
 	return send_message(conn, &msg, sizeof(msg));
 }
 
-static void connect_req(struct sap_connection *conn,
+static void connect_req(struct sap_server *server,
 				struct sap_parameter *param)
 {
+	struct sap_connection *conn = server->conn;
 	uint16_t maxmsgsize, *val;
 
 	DBG("conn %p state %d", conn, conn->state);
@@ -312,7 +313,7 @@ static void connect_req(struct sap_connection *conn,
 	if (conn->state != SAP_STATE_DISCONNECTED)
 		goto error_rsp;
 
-	stop_guard_timer(conn);
+	stop_guard_timer(server);
 
 	val = (uint16_t *) &param->val;
 	maxmsgsize = ntohs(*val);
@@ -323,9 +324,9 @@ static void connect_req(struct sap_connection *conn,
 
 	if (maxmsgsize <= SAP_BUF_SIZE) {
 		conn->processing_req = SAP_CONNECT_REQ;
-		sap_connect_req(conn, maxmsgsize);
+		sap_connect_req(server, maxmsgsize);
 	} else {
-		sap_connect_rsp(conn, SAP_STATUS_MAX_MSG_SIZE_NOT_SUPPORTED);
+		sap_connect_rsp(server, SAP_STATUS_MAX_MSG_SIZE_NOT_SUPPORTED);
 	}
 
 	return;
@@ -334,8 +335,10 @@ error_rsp:
 	sap_error_rsp(conn);
 }
 
-static int disconnect_req(struct sap_connection *conn, uint8_t disc_type)
+static int disconnect_req(struct sap_server *server, uint8_t disc_type)
 {
+	struct sap_connection *conn = server->conn;
+
 	DBG("conn %p state %d disc_type 0x%02x", conn, conn->state, disc_type);
 
 	switch (disc_type) {
@@ -351,7 +354,8 @@ static int disconnect_req(struct sap_connection *conn, uint8_t disc_type)
 
 			disconnect_ind(conn, disc_type);
 			/* Timer will disconnect if client won't do.*/
-			start_guard_timer(conn, SAP_TIMER_GRACEFUL_DISCONNECT);
+			start_guard_timer(server,
+					SAP_TIMER_GRACEFUL_DISCONNECT);
 		}
 
 		return 0;
@@ -367,9 +371,9 @@ static int disconnect_req(struct sap_connection *conn, uint8_t disc_type)
 			conn->state = SAP_STATE_IMMEDIATE_DISCONNECT;
 			conn->processing_req = SAP_NO_REQ;
 
-			stop_guard_timer(conn);
+			stop_guard_timer(server);
 			disconnect_ind(conn, disc_type);
-			sap_disconnect_req(conn, 0);
+			sap_disconnect_req(server, 0);
 		}
 
 		return 0;
@@ -384,8 +388,8 @@ static int disconnect_req(struct sap_connection *conn, uint8_t disc_type)
 		conn->state = SAP_STATE_CLIENT_DISCONNECT;
 		conn->processing_req = SAP_NO_REQ;
 
-		stop_guard_timer(conn);
-		sap_disconnect_req(conn, 0);
+		stop_guard_timer(server);
+		sap_disconnect_req(server, 0);
 
 		return 0;
 
@@ -395,9 +399,11 @@ static int disconnect_req(struct sap_connection *conn, uint8_t disc_type)
 	}
 }
 
-static void transfer_apdu_req(struct sap_connection *conn,
+static void transfer_apdu_req(struct sap_server *server,
 					struct sap_parameter *param)
 {
+	struct sap_connection *conn = server->conn;
+
 	SAP_VDBG("conn %p state %d", conn, conn->state);
 
 	if (!param)
@@ -413,7 +419,7 @@ static void transfer_apdu_req(struct sap_connection *conn,
 		goto error_rsp;
 
 	conn->processing_req = SAP_TRANSFER_APDU_REQ;
-	sap_transfer_apdu_req(conn, param);
+	sap_transfer_apdu_req(server, param);
 
 	return;
 
@@ -421,8 +427,10 @@ error_rsp:
 	sap_error_rsp(conn);
 }
 
-static void transfer_atr_req(struct sap_connection *conn)
+static void transfer_atr_req(struct sap_server *server)
 {
+	struct sap_connection *conn = server->conn;
+
 	DBG("conn %p state %d", conn, conn->state);
 
 	if (conn->state != SAP_STATE_CONNECTED)
@@ -432,7 +440,7 @@ static void transfer_atr_req(struct sap_connection *conn)
 		goto error_rsp;
 
 	conn->processing_req = SAP_TRANSFER_ATR_REQ;
-	sap_transfer_atr_req(conn);
+	sap_transfer_atr_req(server);
 
 	return;
 
@@ -440,8 +448,10 @@ error_rsp:
 	sap_error_rsp(conn);
 }
 
-static void power_sim_off_req(struct sap_connection *conn)
+static void power_sim_off_req(struct sap_server *server)
 {
+	struct sap_connection *conn = server->conn;
+
 	DBG("conn %p state %d", conn, conn->state);
 
 	if (conn->state != SAP_STATE_CONNECTED)
@@ -451,7 +461,7 @@ static void power_sim_off_req(struct sap_connection *conn)
 		goto error_rsp;
 
 	conn->processing_req = SAP_POWER_SIM_OFF_REQ;
-	sap_power_sim_off_req(conn);
+	sap_power_sim_off_req(server);
 
 	return;
 
@@ -459,8 +469,10 @@ error_rsp:
 	sap_error_rsp(conn);
 }
 
-static void power_sim_on_req(struct sap_connection *conn)
+static void power_sim_on_req(struct sap_server *server)
 {
+	struct sap_connection *conn = server->conn;
+
 	DBG("conn %p state %d", conn, conn->state);
 
 	if (conn->state != SAP_STATE_CONNECTED)
@@ -470,7 +482,7 @@ static void power_sim_on_req(struct sap_connection *conn)
 		goto error_rsp;
 
 	conn->processing_req = SAP_POWER_SIM_ON_REQ;
-	sap_power_sim_on_req(conn);
+	sap_power_sim_on_req(server);
 
 	return;
 
@@ -478,8 +490,10 @@ error_rsp:
 	sap_error_rsp(conn);
 }
 
-static void reset_sim_req(struct sap_connection *conn)
+static void reset_sim_req(struct sap_server *server)
 {
+	struct sap_connection *conn = server->conn;
+
 	DBG("conn %p state %d", conn, conn->state);
 
 	if (conn->state != SAP_STATE_CONNECTED)
@@ -489,7 +503,7 @@ static void reset_sim_req(struct sap_connection *conn)
 		goto error_rsp;
 
 	conn->processing_req = SAP_RESET_SIM_REQ;
-	sap_reset_sim_req(conn);
+	sap_reset_sim_req(server);
 
 	return;
 
@@ -497,8 +511,10 @@ error_rsp:
 	sap_error_rsp(conn);
 }
 
-static void transfer_card_reader_status_req(struct sap_connection *conn)
+static void transfer_card_reader_status_req(struct sap_server *server)
 {
+	struct sap_connection *conn = server->conn;
+
 	DBG("conn %p state %d", conn, conn->state);
 
 	if (conn->state != SAP_STATE_CONNECTED)
@@ -508,7 +524,7 @@ static void transfer_card_reader_status_req(struct sap_connection *conn)
 		goto error_rsp;
 
 	conn->processing_req = SAP_TRANSFER_CARD_READER_STATUS_REQ;
-	sap_transfer_card_reader_status_req(conn);
+	sap_transfer_card_reader_status_req(server);
 
 	return;
 
@@ -516,9 +532,11 @@ error_rsp:
 	sap_error_rsp(conn);
 }
 
-static void set_transport_protocol_req(struct sap_connection *conn,
+static void set_transport_protocol_req(struct sap_server *server,
 					struct sap_parameter *param)
 {
+	struct sap_connection *conn = server->conn;
+
 	if (!param)
 		goto error_rsp;
 
@@ -531,7 +549,7 @@ static void set_transport_protocol_req(struct sap_connection *conn,
 		goto error_rsp;
 
 	conn->processing_req = SAP_SET_TRANSPORT_PROTOCOL_REQ;
-	sap_set_transport_protocol_req(conn, param);
+	sap_set_transport_protocol_req(server, param);
 
 	return;
 
@@ -539,20 +557,24 @@ error_rsp:
 	sap_error_rsp(conn);
 }
 
-static void start_guard_timer(struct sap_connection *conn, guint interval)
+static void start_guard_timer(struct sap_server *server, guint interval)
 {
+	struct sap_connection *conn = server->conn;
+
 	if (!conn)
 		return;
 
 	if (!conn->timer_id)
 		conn->timer_id = g_timeout_add_seconds(interval, guard_timeout,
-									conn);
+								server);
 	else
 		error("Timer is already active.");
 }
 
-static void stop_guard_timer(struct sap_connection *conn)
+static void stop_guard_timer(struct sap_server *server)
 {
+	struct sap_connection *conn = server->conn;
+
 	if (conn  && conn->timer_id) {
 		g_source_remove(conn->timer_id);
 		conn->timer_id = 0;
@@ -561,7 +583,8 @@ static void stop_guard_timer(struct sap_connection *conn)
 
 static gboolean guard_timeout(gpointer data)
 {
-	struct sap_connection *conn = data;
+	struct sap_server *server = data;
+	struct sap_connection *conn = server->conn;
 
 	if (!conn)
 		return FALSE;
@@ -586,7 +609,7 @@ static gboolean guard_timeout(gpointer data)
 	case SAP_STATE_GRACEFUL_DISCONNECT:
 		/* Client didn't disconnect SAP connection in fixed time,
 		 * so close SAP connection immediately. */
-		disconnect_req(conn, SAP_DISCONNECTION_TYPE_IMMEDIATE);
+		disconnect_req(server, SAP_DISCONNECTION_TYPE_IMMEDIATE);
 		break;
 
 	default:
@@ -597,20 +620,21 @@ static gboolean guard_timeout(gpointer data)
 	return FALSE;
 }
 
-static void sap_set_connected(struct sap_connection *conn)
+static void sap_set_connected(struct sap_server *server)
 {
 	gboolean connected = TRUE;
 
-	emit_property_changed(connection, sap_server->path,
+	emit_property_changed(connection, server->path,
 					SAP_SERVER_INTERFACE,
 		"Connected", DBUS_TYPE_BOOLEAN, &connected);
 
-	conn->state = SAP_STATE_CONNECTED;
+	server->conn->state = SAP_STATE_CONNECTED;
 }
 
 int sap_connect_rsp(void *sap_device, uint8_t status)
 {
-	struct sap_connection *conn = sap_device;
+	struct sap_server *server = sap_device;
+	struct sap_connection *conn = server->conn;
 	char buf[SAP_BUF_SIZE];
 	struct sap_message *msg = (struct sap_message *) buf;
 	struct sap_parameter *param = (struct sap_parameter *) msg->param;
@@ -639,7 +663,7 @@ int sap_connect_rsp(void *sap_device, uint8_t status)
 
 	switch (status) {
 	case SAP_STATUS_OK:
-		sap_set_connected(conn);
+		sap_set_connected(server);
 		break;
 	case SAP_STATUS_OK_ONGOING_CALL:
 		DBG("ongoing call. Wait for reset indication!");
@@ -660,18 +684,19 @@ int sap_connect_rsp(void *sap_device, uint8_t status)
 
 		/* Timer will shutdown channel if client doesn't send
 		 * CONNECT_REQ or doesn't shutdown channel itself.*/
-		start_guard_timer(conn, SAP_TIMER_NO_ACTIVITY);
+		start_guard_timer(server, SAP_TIMER_NO_ACTIVITY);
 		break;
 	}
 
 	conn->processing_req = SAP_NO_REQ;
 
-	return send_message(sap_device, buf, size);
+	return send_message(conn, buf, size);
 }
 
 int sap_disconnect_rsp(void *sap_device)
 {
-	struct sap_connection *conn = sap_device;
+	struct sap_server *server = sap_device;
+	struct sap_connection *conn = server->conn;
 	struct sap_message msg;
 
 	if (!conn)
@@ -688,9 +713,9 @@ int sap_disconnect_rsp(void *sap_device)
 		conn->processing_req = SAP_NO_REQ;
 
 		/* Timer will close channel if client doesn't do it.*/
-		start_guard_timer(conn, SAP_TIMER_NO_ACTIVITY);
+		start_guard_timer(server, SAP_TIMER_NO_ACTIVITY);
 
-		return send_message(sap_device, &msg, sizeof(msg));
+		return send_message(conn, &msg, sizeof(msg));
 
 	case SAP_STATE_IMMEDIATE_DISCONNECT:
 		conn->state = SAP_STATE_DISCONNECTED;
@@ -714,7 +739,8 @@ int sap_disconnect_rsp(void *sap_device)
 int sap_transfer_apdu_rsp(void *sap_device, uint8_t result, uint8_t *apdu,
 					uint16_t length)
 {
-	struct sap_connection *conn = sap_device;
+	struct sap_server *server = sap_device;
+	struct sap_connection *conn = server->conn;
 	char buf[SAP_BUF_SIZE];
 	struct sap_message *msg = (struct sap_message *) buf;
 	struct sap_parameter *param = (struct sap_parameter *) msg->param;
@@ -753,13 +779,14 @@ int sap_transfer_apdu_rsp(void *sap_device, uint8_t result, uint8_t *apdu,
 
 	conn->processing_req = SAP_NO_REQ;
 
-	return send_message(sap_device, buf, size);
+	return send_message(conn, buf, size);
 }
 
 int sap_transfer_atr_rsp(void *sap_device, uint8_t result, uint8_t *atr,
 					uint16_t length)
 {
-	struct sap_connection *conn = sap_device;
+	struct sap_server *server = sap_device;
+	struct sap_connection *conn = server->conn;
 	char buf[SAP_BUF_SIZE];
 	struct sap_message *msg = (struct sap_message *) buf;
 	struct sap_parameter *param = (struct sap_parameter *) msg->param;
@@ -798,12 +825,13 @@ int sap_transfer_atr_rsp(void *sap_device, uint8_t result, uint8_t *atr,
 
 	conn->processing_req = SAP_NO_REQ;
 
-	return send_message(sap_device, buf, size);
+	return send_message(conn, buf, size);
 }
 
 int sap_power_sim_off_rsp(void *sap_device, uint8_t result)
 {
-	struct sap_connection *conn = sap_device;
+	struct sap_server *server = sap_device;
+	struct sap_connection *conn = server->conn;
 	char buf[SAP_BUF_SIZE];
 	struct sap_message *msg = (struct sap_message *) buf;
 	size_t size = sizeof(struct sap_message);
@@ -823,12 +851,13 @@ int sap_power_sim_off_rsp(void *sap_device, uint8_t result)
 
 	conn->processing_req = SAP_NO_REQ;
 
-	return send_message(sap_device, buf, size);
+	return send_message(conn, buf, size);
 }
 
 int sap_power_sim_on_rsp(void *sap_device, uint8_t result)
 {
-	struct sap_connection *conn = sap_device;
+	struct sap_server *server = sap_device;
+	struct sap_connection *conn = server->conn;
 	char buf[SAP_BUF_SIZE];
 	struct sap_message *msg = (struct sap_message *) buf;
 	size_t size = sizeof(struct sap_message);
@@ -848,12 +877,13 @@ int sap_power_sim_on_rsp(void *sap_device, uint8_t result)
 
 	conn->processing_req = SAP_NO_REQ;
 
-	return send_message(sap_device, buf, size);
+	return send_message(conn, buf, size);
 }
 
 int sap_reset_sim_rsp(void *sap_device, uint8_t result)
 {
-	struct sap_connection *conn = sap_device;
+	struct sap_server *server = sap_device;
+	struct sap_connection *conn = server->conn;
 	char buf[SAP_BUF_SIZE];
 	struct sap_message *msg = (struct sap_message *) buf;
 	size_t size = sizeof(struct sap_message);
@@ -874,13 +904,14 @@ int sap_reset_sim_rsp(void *sap_device, uint8_t result)
 
 	conn->processing_req = SAP_NO_REQ;
 
-	return send_message(sap_device, buf, size);
+	return send_message(conn, buf, size);
 }
 
 int sap_transfer_card_reader_status_rsp(void *sap_device, uint8_t result,
 						uint8_t status)
 {
-	struct sap_connection *conn = sap_device;
+	struct sap_server *server = sap_device;
+	struct sap_connection *conn = server->conn;
 	char buf[SAP_BUF_SIZE];
 	struct sap_message *msg = (struct sap_message *) buf;
 	struct sap_parameter *param = (struct sap_parameter *) msg->param;
@@ -912,12 +943,13 @@ int sap_transfer_card_reader_status_rsp(void *sap_device, uint8_t result,
 
 	conn->processing_req = SAP_NO_REQ;
 
-	return send_message(sap_device, buf, size);
+	return send_message(conn, buf, size);
 }
 
 int sap_transport_protocol_rsp(void *sap_device, uint8_t result)
 {
-	struct sap_connection *conn = sap_device;
+	struct sap_server *server = sap_device;
+	struct sap_connection *conn = server->conn;
 	char buf[SAP_BUF_SIZE];
 	struct sap_message *msg = (struct sap_message *) buf;
 	size_t size = sizeof(struct sap_message);
@@ -938,12 +970,13 @@ int sap_transport_protocol_rsp(void *sap_device, uint8_t result)
 
 	conn->processing_req = SAP_NO_REQ;
 
-	return send_message(sap_device, buf, size);
+	return send_message(conn, buf, size);
 }
 
 int sap_status_ind(void *sap_device, uint8_t status_change)
 {
-	struct sap_connection *conn = sap_device;
+	struct sap_server *server = sap_device;
+	struct sap_connection *conn = server->conn;
 	char buf[SAP_BUF_SIZE];
 	struct sap_message *msg = (struct sap_message *) buf;
 	struct sap_parameter *param = (struct sap_parameter *) msg->param;
@@ -961,7 +994,7 @@ int sap_status_ind(void *sap_device, uint8_t status_change)
 			break;
 
 		/* Change state to connected after ongoing call ended */
-		sap_set_connected(conn);
+		sap_set_connected(server);
 		/* fall */
 	case SAP_STATE_CONNECTED:
 	case SAP_STATE_GRACEFUL_DISCONNECT:
@@ -975,7 +1008,7 @@ int sap_status_ind(void *sap_device, uint8_t status_change)
 		*param->val = status_change;
 		size += PARAMETER_SIZE(SAP_PARAM_ID_STATUS_CHANGE_LEN);
 
-		return send_message(sap_device, buf, size);
+		return send_message(conn, buf, size);
 	case SAP_STATE_DISCONNECTED:
 	case SAP_STATE_CONNECT_IN_PROGRESS:
 	case SAP_STATE_IMMEDIATE_DISCONNECT:
@@ -988,13 +1021,12 @@ int sap_status_ind(void *sap_device, uint8_t status_change)
 
 int sap_disconnect_ind(void *sap_device, uint8_t disc_type)
 {
-	struct sap_connection *conn = sap_device;
-
-	return disconnect_req(conn, SAP_DISCONNECTION_TYPE_IMMEDIATE);
+	return disconnect_req(sap_device, SAP_DISCONNECTION_TYPE_IMMEDIATE);
 }
 
-static int handle_cmd(struct sap_connection *conn, void *buf, size_t size)
+static int handle_cmd(struct sap_server *server, void *buf, size_t size)
 {
+	struct sap_connection *conn = server->conn;
 	struct sap_message *msg = buf;
 
 	if (!conn)
@@ -1012,31 +1044,31 @@ static int handle_cmd(struct sap_connection *conn, void *buf, size_t size)
 
 	switch (msg->id) {
 	case SAP_CONNECT_REQ:
-		connect_req(conn, msg->param);
+		connect_req(server, msg->param);
 		return 0;
 	case SAP_DISCONNECT_REQ:
-		disconnect_req(conn, SAP_DISCONNECTION_TYPE_CLIENT);
+		disconnect_req(server, SAP_DISCONNECTION_TYPE_CLIENT);
 		return 0;
 	case SAP_TRANSFER_APDU_REQ:
-		transfer_apdu_req(conn, msg->param);
+		transfer_apdu_req(server, msg->param);
 		return 0;
 	case SAP_TRANSFER_ATR_REQ:
-		transfer_atr_req(conn);
+		transfer_atr_req(server);
 		return 0;
 	case SAP_POWER_SIM_OFF_REQ:
-		power_sim_off_req(conn);
+		power_sim_off_req(server);
 		return 0;
 	case SAP_POWER_SIM_ON_REQ:
-		power_sim_on_req(conn);
+		power_sim_on_req(server);
 		return 0;
 	case SAP_RESET_SIM_REQ:
-		reset_sim_req(conn);
+		reset_sim_req(server);
 		return 0;
 	case SAP_TRANSFER_CARD_READER_STATUS_REQ:
-		transfer_card_reader_status_req(conn);
+		transfer_card_reader_status_req(server);
 		return 0;
 	case SAP_SET_TRANSPORT_PROTOCOL_REQ:
-		set_transport_protocol_req(conn, msg->param);
+		set_transport_protocol_req(server, msg->param);
 		return 0;
 	default:
 		DBG("Unknown SAP message id 0x%02x.", msg->id);
@@ -1068,8 +1100,6 @@ static void sap_conn_remove(struct sap_connection *conn)
 
 static gboolean sap_io_cb(GIOChannel *io, GIOCondition cond, gpointer data)
 {
-	struct sap_connection *conn = data;
-
 	char buf[SAP_BUF_SIZE];
 	size_t bytes_read = 0;
 	GError *gerr = NULL;
@@ -1101,7 +1131,7 @@ static gboolean sap_io_cb(GIOChannel *io, GIOCondition cond, gpointer data)
 		return TRUE;
 	}
 
-	if (handle_cmd(conn, buf, bytes_read) < 0)
+	if (handle_cmd(data, buf, bytes_read) < 0)
 		error("SAP protocol processing failure.");
 
 	return TRUE;
@@ -1109,7 +1139,8 @@ static gboolean sap_io_cb(GIOChannel *io, GIOCondition cond, gpointer data)
 
 static void sap_io_destroy(void *data)
 {
-	struct sap_connection *conn = data;
+	struct sap_server *server = data;
+	struct sap_connection *conn = server->conn;
 	gboolean connected = FALSE;
 
 	DBG("conn %p", conn);
@@ -1117,11 +1148,11 @@ static void sap_io_destroy(void *data)
 	if (!conn || !conn->io)
 		return;
 
-	stop_guard_timer(conn);
+	stop_guard_timer(server);
 
 	if (conn->state != SAP_STATE_CONNECT_IN_PROGRESS &&
 			conn->state != SAP_STATE_CONNECT_MODEM_BUSY)
-		emit_property_changed(connection, sap_server->path,
+		emit_property_changed(connection, server->path,
 					SAP_SERVER_INTERFACE, "Connected",
 					DBUS_TYPE_BOOLEAN, &connected);
 
@@ -1129,14 +1160,15 @@ static void sap_io_destroy(void *data)
 			conn->state == SAP_STATE_CONNECT_MODEM_BUSY ||
 			conn->state == SAP_STATE_CONNECTED ||
 			conn->state == SAP_STATE_GRACEFUL_DISCONNECT)
-		sap_disconnect_req(NULL, 1);
+		sap_disconnect_req(server, 1);
 
 	sap_conn_remove(conn);
 }
 
 static void sap_connect_cb(GIOChannel *io, GError *gerr, gpointer data)
 {
-	struct sap_connection *conn = data;
+	struct sap_server *server = data;
+	struct sap_connection *conn = server->conn;
 
 	DBG("conn %p, io %p", conn, io);
 
@@ -1145,16 +1177,17 @@ static void sap_connect_cb(GIOChannel *io, GError *gerr, gpointer data)
 
 	/* Timer will shutdown the channel in case of lack of client
 	   activity */
-	start_guard_timer(conn, SAP_TIMER_NO_ACTIVITY);
+	start_guard_timer(server, SAP_TIMER_NO_ACTIVITY);
 
 	g_io_add_watch_full(io, G_PRIORITY_DEFAULT,
 			G_IO_IN | G_IO_ERR | G_IO_HUP | G_IO_NVAL,
-			sap_io_cb, conn, sap_io_destroy);
+			sap_io_cb, server, sap_io_destroy);
 }
 
 static void connect_auth_cb(DBusError *derr, void *data)
 {
-	struct sap_connection *conn = data;
+	struct sap_server *server = data;
+	struct sap_connection *conn = server->conn;
 	GError *gerr = NULL;
 
 	DBG("conn %p", conn);
@@ -1168,7 +1201,7 @@ static void connect_auth_cb(DBusError *derr, void *data)
 		return;
 	}
 
-	if (!bt_io_accept(conn->io, sap_connect_cb, conn, NULL, &gerr)) {
+	if (!bt_io_accept(conn->io, sap_connect_cb, server, NULL, &gerr)) {
 		error("bt_io_accept: %s", gerr->message);
 		g_error_free(gerr);
 		sap_conn_remove(conn);
@@ -1180,7 +1213,8 @@ static void connect_auth_cb(DBusError *derr, void *data)
 
 static void connect_confirm_cb(GIOChannel *io, gpointer data)
 {
-	struct sap_connection *conn = sap_server->conn;
+	struct sap_server *server = data;
+	struct sap_connection *conn = server->conn;
 	GError *gerr = NULL;
 	bdaddr_t src, dst;
 	char dstaddr[18];
@@ -1207,7 +1241,7 @@ static void connect_confirm_cb(GIOChannel *io, gpointer data)
 	g_io_channel_set_encoding(io, NULL, NULL);
 	g_io_channel_set_buffered(io, FALSE);
 
-	sap_server->conn = conn;
+	server->conn = conn;
 	conn->io = g_io_channel_ref(io);
 	conn->state = SAP_STATE_DISCONNECTED;
 
@@ -1225,7 +1259,7 @@ static void connect_confirm_cb(GIOChannel *io, gpointer data)
 	ba2str(&dst, dstaddr);
 
 	err = btd_request_authorization(&src, &dst, SAP_UUID, connect_auth_cb,
-									conn);
+								server);
 	if (err < 0) {
 		error("Authorization failure (err %d)", err);
 		sap_conn_remove(conn);
@@ -1255,7 +1289,7 @@ static DBusMessage *disconnect(DBusConnection *conn, DBusMessage *msg,
 	if (!server->conn)
 		return message_failed(msg, "Client already disconnected");
 
-	if (disconnect_req(server->conn, SAP_DISCONNECTION_TYPE_GRACEFUL) < 0)
+	if (disconnect_req(server, SAP_DISCONNECTION_TYPE_GRACEFUL) < 0)
 		return g_dbus_create_error(msg, ERROR_INTERFACE ".Failed",
 					"There is no active connection");
 
-- 
on behalf of ST-Ericsson

