Return-Path: <cyrus@holtmann.org>
From: Waldemar Rymarkiewicz <waldemar.rymarkiewicz@tieto.com>
To: Johan Hedberg <johan.hedberg@gmail.com>,
	<linux-bluetooth@vger.kernel.org>
CC: Waldemar Rymarkiewicz <waldemar.rymarkiewicz@tieto.com>
Subject: [PATCH v2 1/3] Clean SAP server error printouts
Date: Mon, 30 May 2011 11:59:33 +0200
Message-ID: <1306749575-21119-1-git-send-email-waldemar.rymarkiewicz@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 sap/server.c |   75 ++++++++++++++++++++++++----------------------------------
 1 files changed, 31 insertions(+), 44 deletions(-)

diff --git a/sap/server.c b/sap/server.c
index 56a62f7..c5ea97c 100644
--- a/sap/server.c
+++ b/sap/server.c
@@ -338,8 +338,6 @@ static void connect_req(struct sap_connection *conn,
 	return;
 
 error_rsp:
-	error("Processing error (param %p state %d pr 0x%02x)", param,
-					conn->state, conn->processing_req);
 	sap_error_rsp(conn);
 }
 
@@ -387,8 +385,10 @@ static int disconnect_req(struct sap_connection *conn, uint8_t disc_type)
 
 	case SAP_DISCONNECTION_TYPE_CLIENT:
 		if (conn->state != SAP_STATE_CONNECTED &&
-				conn->state != SAP_STATE_GRACEFUL_DISCONNECT)
-			goto error_rsp;
+				conn->state != SAP_STATE_GRACEFUL_DISCONNECT) {
+			sap_error_rsp(conn);
+			goto error_req;
+		}
 
 		conn->state = SAP_STATE_CLIENT_DISCONNECT;
 		conn->processing_req = SAP_NO_REQ;
@@ -403,11 +403,7 @@ static int disconnect_req(struct sap_connection *conn, uint8_t disc_type)
 		return -EINVAL;
 	}
 
-error_rsp:
-	sap_error_rsp(conn);
 error_req:
-	error("Processing error (state %d pr 0x%02x)", conn->state,
-						conn->processing_req);
 	return -EPERM;
 }
 
@@ -434,8 +430,6 @@ static void transfer_apdu_req(struct sap_connection *conn,
 	return;
 
 error_rsp:
-	error("Processing error (param %p state %d pr 0x%02x)", param,
-					conn->state, conn->processing_req);
 	sap_error_rsp(conn);
 }
 
@@ -455,8 +449,6 @@ static void transfer_atr_req(struct sap_connection *conn)
 	return;
 
 error_rsp:
-	error("Processing error (state %d pr 0x%02x)", conn->state,
-						conn->processing_req);
 	sap_error_rsp(conn);
 }
 
@@ -476,8 +468,6 @@ static void power_sim_off_req(struct sap_connection *conn)
 	return;
 
 error_rsp:
-	error("Processing error (state %d pr 0x%02x)", conn->state,
-						conn->processing_req);
 	sap_error_rsp(conn);
 }
 
@@ -497,8 +487,6 @@ static void power_sim_on_req(struct sap_connection *conn)
 	return;
 
 error_rsp:
-	error("Processing error (state %d pr 0x%02x)", conn->state,
-						conn->processing_req);
 	sap_error_rsp(conn);
 }
 
@@ -518,8 +506,6 @@ static void reset_sim_req(struct sap_connection *conn)
 	return;
 
 error_rsp:
-	error("Processing error (state %d pr 0x%02x param)", conn->state,
-						conn->processing_req);
 	sap_error_rsp(conn);
 }
 
@@ -539,8 +525,6 @@ static void transfer_card_reader_status_req(struct sap_connection *conn)
 	return;
 
 error_rsp:
-	error("Processing error (state %d pr 0x%02x)", conn->state,
-						conn->processing_req);
 	sap_error_rsp(conn);
 }
 
@@ -564,8 +548,6 @@ static void set_transport_protocol_req(struct sap_connection *conn,
 	return;
 
 error_rsp:
-	error("Processing error (param %p state %d pr 0x%02x)", param,
-					conn->state, conn->processing_req);
 	sap_error_rsp(conn);
 }
 
@@ -967,6 +949,9 @@ int sap_error_rsp(void *sap_device)
 	memset(&msg, 0, sizeof(msg));
 	msg.id = SAP_ERROR_RESP;
 
+	error("SAP error (state %d pr 0x%02x).", conn->state,
+							conn->processing_req);
+
 	return send_message(conn, &msg, sizeof(msg));
 }
 
@@ -1008,10 +993,9 @@ int sap_disconnect_ind(void *sap_device, uint8_t disc_type)
 	return disconnect_req(conn, SAP_DISCONNECTION_TYPE_IMMEDIATE);
 }
 
-static int handle_cmd(void *data, void *buf, size_t size)
+static int handle_cmd(struct sap_connection *conn, void *buf, size_t size)
 {
 	struct sap_message *msg = buf;
-	struct sap_connection *conn = data;
 
 	if (!conn)
 		return -EINVAL;
@@ -1055,12 +1039,12 @@ static int handle_cmd(void *data, void *buf, size_t size)
 		set_transport_protocol_req(conn, msg->param);
 		return 0;
 	default:
-		DBG("SAP unknown message.");
+		DBG("Unknown SAP message id 0x%02x.", msg->id);
 		break;
 	}
 
 error_rsp:
-	DBG("Bad request message format.");
+	DBG("Invalid SAP message format.");
 	sap_error_rsp(conn);
 	return -EBADMSG;
 }
@@ -1084,12 +1068,14 @@ static void sap_conn_remove(struct sap_connection *conn)
 
 static gboolean sap_io_cb(GIOChannel *io, GIOCondition cond, gpointer data)
 {
+	struct sap_connection *conn = data;
+
 	char buf[SAP_BUF_SIZE];
 	size_t bytes_read = 0;
 	GError *gerr = NULL;
 	GIOStatus gstatus;
 
-	DBG("io %p", io);
+	DBG("conn %p io %p", conn, io);
 
 	if (cond & G_IO_NVAL) {
 		DBG("ERR (G_IO_NVAL) on rfcomm socket.");
@@ -1115,8 +1101,8 @@ static gboolean sap_io_cb(GIOChannel *io, GIOCondition cond, gpointer data)
 		return TRUE;
 	}
 
-	if (handle_cmd(data, buf, bytes_read) < 0)
-		error("Invalid SAP message.");
+	if (handle_cmd(conn, buf, bytes_read) < 0)
+		error("SAP protocol processing failure.");
 
 	return TRUE;
 }
@@ -1151,7 +1137,7 @@ static void sap_connect_cb(GIOChannel *io, GError *gerr, gpointer data)
 {
 	struct sap_connection *conn = data;
 
-	DBG("io %p gerr %p data %p ", io, gerr, data);
+	DBG("conn %p, io %p", conn, io);
 
 	if (!conn)
 		return;
@@ -1170,13 +1156,13 @@ static void connect_auth_cb(DBusError *derr, void *data)
 	struct sap_connection *conn = data;
 	GError *gerr = NULL;
 
-	DBG("derr %p data %p ", derr, data);
+	DBG("conn %p", conn);
 
 	if (!conn)
 		return;
 
 	if (derr && dbus_error_is_set(derr)) {
-		error("Access denied: %s", derr->message);
+		error("Access has been denied (%s)", derr->message);
 		sap_conn_remove(conn);
 		return;
 	}
@@ -1188,7 +1174,7 @@ static void connect_auth_cb(DBusError *derr, void *data)
 		return;
 	}
 
-	DBG("Client has been authorized.");
+	DBG("Access has been granted.");
 }
 
 static void connect_confirm_cb(GIOChannel *io, gpointer data)
@@ -1196,14 +1182,16 @@ static void connect_confirm_cb(GIOChannel *io, gpointer data)
 	struct sap_connection *conn = server->conn;
 	GError *gerr = NULL;
 	bdaddr_t src, dst;
+	char dstaddr[18];
 	int err;
 
-	DBG("io %p data %p ", io, data);
+	DBG("conn %p io %p", conn, io);
 
 	if (!io)
 		return;
 
 	if (conn) {
+		DBG("Another SAP connection already exists.");
 		g_io_channel_shutdown(io, TRUE, NULL);
 		return;
 	}
@@ -1233,16 +1221,17 @@ static void connect_confirm_cb(GIOChannel *io, gpointer data)
 		return;
 	}
 
-	err = btd_request_authorization(&src, &dst, SAP_UUID,
-					connect_auth_cb, conn);
+	ba2str(&dst, dstaddr);
+
+	err = btd_request_authorization(&src, &dst, SAP_UUID, connect_auth_cb,
+									conn);
 	if (err < 0) {
-		DBG("Authorization denied: %d %s", err,  strerror(err));
+		error("Authorization failure (err %d)", err);
 		sap_conn_remove(conn);
 		return;
 	}
 
-	DBG("SAP incoming connection (sock %d) authorization.",
-				g_io_channel_unix_get_fd(io));
+	DBG("Authorizing incomming SAP connection from %s", dstaddr);
 }
 
 static inline DBusMessage *message_failed(DBusMessage *msg,
@@ -1257,8 +1246,6 @@ static DBusMessage *disconnect(DBusConnection *conn, DBusMessage *msg,
 {
 	struct sap_server *server = data;
 
-	DBG("server %p", server);
-
 	if (!server)
 		return message_failed(msg, "Server internal error.");
 
@@ -1332,8 +1319,8 @@ static void destroy_sap_interface(void *data)
 {
 	struct sap_server *server = data;
 
-	DBG("Unregistered interface %s on path %s",
-			SAP_SERVER_INTERFACE, server->path);
+	DBG("Unregistered interface %s on path %s", SAP_SERVER_INTERFACE,
+								server->path);
 
 	server_free(server);
 }
@@ -1394,7 +1381,7 @@ int sap_server_register(const char *path, bdaddr_t *src)
 				server_methods, server_signals, NULL,
 				server, destroy_sap_interface)) {
 		error("D-Bus failed to register %s interface",
-						SAP_SERVER_INTERFACE);
+							SAP_SERVER_INTERFACE);
 		goto server_err;
 	}
 
-- 
1.7.4.1

