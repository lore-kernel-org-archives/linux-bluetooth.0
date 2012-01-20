Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH obexd 6/6] client: simplify handling of D-Bus pending calls in bluetooth.c
Date: Fri, 20 Jan 2012 11:50:01 +0200
Message-Id: <1327053001-9506-6-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1327053001-9506-1-git-send-email-luiz.dentz@gmail.com>
References: <1327053001-9506-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

There is no much of point to have a user_data if it is always the same
type, besides this code is very inefficient and cause a lookup in the list
of pending calls everytime a reply is received.
---
 client/bluetooth.c |  177 ++++++++++++++++++++-------------------------------
 1 files changed, 70 insertions(+), 107 deletions(-)

diff --git a/client/bluetooth.c b/client/bluetooth.c
index 563124d..3441d4b 100644
--- a/client/bluetooth.c
+++ b/client/bluetooth.c
@@ -53,7 +53,7 @@ struct bluetooth_session {
 	bdaddr_t src;
 	bdaddr_t dst;
 	uint16_t port;
-	DBusConnection *conn_system; /* system bus connection */
+	DBusConnection *conn; /* system bus connection */
 	sdp_session_t *sdp;
 	GIOChannel *io;
 	GSList *pending_calls;
@@ -63,11 +63,6 @@ struct bluetooth_session {
 	void *user_data;
 };
 
-struct pending_req {
-	DBusPendingCall *call;
-	void *user_data;
-};
-
 static GSList *sessions = NULL;
 
 static GQuark obc_bt_error_quark(void)
@@ -75,21 +70,22 @@ static GQuark obc_bt_error_quark(void)
 	return g_quark_from_static_string("obc-bluetooth-error-quark");
 }
 
-static struct pending_req *send_method_call(DBusConnection *connection,
-				const char *dest, const char *path,
-				const char *interface, const char *method,
-				DBusPendingCallNotifyFunction cb,
-				void *user_data, int type, ...)
+static int send_method_call(struct bluetooth_session *session,
+					const char *path,
+					const char *interface,
+					const char *method,
+					DBusPendingCallNotifyFunction cb,
+					int type, ...)
 {
 	DBusMessage *msg;
 	DBusPendingCall *call;
 	va_list args;
-	struct pending_req *req;
 
-	msg = dbus_message_new_method_call(dest, path, interface, method);
+	msg = dbus_message_new_method_call(BT_BUS_NAME, path, interface,
+								method);
 	if (!msg) {
 		error("Unable to allocate new D-Bus %s message", method);
-		return NULL;
+		return -ENOMEM;
 	}
 
 	va_start(args, type);
@@ -97,40 +93,35 @@ static struct pending_req *send_method_call(DBusConnection *connection,
 	if (!dbus_message_append_args_valist(msg, type, args)) {
 		dbus_message_unref(msg);
 		va_end(args);
-		return NULL;
+		return -EINVAL;
 	}
 
 	va_end(args);
 
 	if (!cb) {
-		g_dbus_send_message(connection, msg);
+		g_dbus_send_message(session->conn, msg);
 		return 0;
 	}
 
-	if (!dbus_connection_send_with_reply(connection, msg, &call, -1)) {
+	if (!dbus_connection_send_with_reply(session->conn, msg, &call, -1)) {
 		error("Sending %s failed", method);
 		dbus_message_unref(msg);
-		return NULL;
+		return -EIO;
 	}
 
-	dbus_pending_call_set_notify(call, cb, user_data, NULL);
-
-	req = g_new0(struct pending_req, 1);
-	req->call = call;
-	req->user_data = user_data;
+	dbus_pending_call_set_notify(call, cb, session, NULL);
 
-	dbus_message_unref(msg);
+	session->pending_calls = g_slist_prepend(session->pending_calls, call);
 
-	return req;
+	return 0;
 }
 
-static void pending_req_finalize(struct pending_req *req)
+static void finalize_call(DBusPendingCall *call)
 {
-	if (!dbus_pending_call_get_completed(req->call))
-		dbus_pending_call_cancel(req->call);
+	if (!dbus_pending_call_get_completed(call))
+		dbus_pending_call_cancel(call);
 
-	dbus_pending_call_unref(req->call);
-	g_free(req);
+	dbus_pending_call_unref(call);
 }
 
 static void session_destroy(struct bluetooth_session *session)
@@ -145,20 +136,18 @@ static void session_destroy(struct bluetooth_session *session)
 	sessions = g_slist_remove(sessions, session);
 
 	if (session->adapter)
-		send_method_call(session->conn_system,
-				BT_BUS_NAME, session->adapter,
-				BT_ADAPTER_IFACE, "ReleaseSession",
-				NULL, NULL,
-				DBUS_TYPE_INVALID);
+		send_method_call(session, session->adapter, BT_ADAPTER_IFACE,
+						"ReleaseSession", NULL,
+						DBUS_TYPE_INVALID);
 
 	l = session->pending_calls;
 
 	while (l) {
-		struct pending_req *req = l->data;
+		DBusPendingCall *call = l->data;
 		l = l->next;
 
-		session->pending_calls = g_slist_remove(session->pending_calls, req);
-		pending_req_finalize(req);
+		session->pending_calls = g_slist_remove(session->pending_calls, call);
+		finalize_call(call);
 	}
 
 	if (session->io != NULL) {
@@ -166,8 +155,8 @@ static void session_destroy(struct bluetooth_session *session)
 		g_io_channel_unref(session->io);
 	}
 
-	if (session->conn_system)
-		dbus_connection_unref(session->conn_system);
+	if (session->conn)
+		dbus_connection_unref(session->conn);
 
 	g_free(session->service);
 	g_free(session->adapter);
@@ -436,34 +425,17 @@ static int session_connect(struct bluetooth_session *session)
 	return err;
 }
 
-static struct pending_req *find_session_request(
-				const struct bluetooth_session *session,
-				const DBusPendingCall *call)
-{
-	GSList *l;
-
-	for (l = session->pending_calls; l; l = l->next) {
-		struct pending_req *req = l->data;
-
-		if (req->call == call)
-			return req;
-	}
-
-	return NULL;
-}
-
 static void adapter_reply(DBusPendingCall *call, void *user_data)
 {
+	struct bluetooth_session *session = user_data;
 	DBusError err;
 	DBusMessage *reply;
-	struct bluetooth_session *session = user_data;
-	struct pending_req *req = find_session_request(session, call);
 	GError *gerr = NULL;
 
 	reply = dbus_pending_call_steal_reply(call);
 
-	session->pending_calls = g_slist_remove(session->pending_calls, req);
-	pending_req_finalize(req);
+	session->pending_calls = g_slist_remove(session->pending_calls, call);
+	finalize_call(call);
 
 	dbus_error_init(&err);
 	if (dbus_set_error_from_message(&err, reply)) {
@@ -474,10 +446,8 @@ static void adapter_reply(DBusPendingCall *call, void *user_data)
 		goto failed;
 	}
 
-	if (session_connect(session) < 0)
-		goto failed;
-
-	goto proceed;
+	if (session_connect(session) == 0)
+		goto proceed;
 
 failed:
 	g_set_error(&gerr, OBC_BT_ERROR, -EINVAL,
@@ -492,19 +462,26 @@ proceed:
 	dbus_message_unref(reply);
 }
 
+static int request_session(struct bluetooth_session *session, const char *adapter)
+{
+	session->adapter = g_strdup(adapter);
+	return send_method_call(session, adapter, BT_ADAPTER_IFACE,
+					"RequestSession", adapter_reply,
+					DBUS_TYPE_INVALID);
+}
+
 static void manager_reply(DBusPendingCall *call, void *user_data)
 {
+	struct bluetooth_session *session = user_data;
 	DBusError err;
 	DBusMessage *reply;
 	char *adapter;
-	struct bluetooth_session *session = user_data;
-	struct pending_req *req = find_session_request(session, call);
 	GError *gerr = NULL;
 
 	reply = dbus_pending_call_steal_reply(call);
 
-	session->pending_calls = g_slist_remove(session->pending_calls, req);
-	pending_req_finalize(req);
+	session->pending_calls = g_slist_remove(session->pending_calls, call);
+	finalize_call(call);
 
 	dbus_error_init(&err);
 	if (dbus_set_error_from_message(&err, reply)) {
@@ -515,26 +492,15 @@ static void manager_reply(DBusPendingCall *call, void *user_data)
 		goto failed;
 	}
 
-	if (dbus_message_get_args(reply, NULL,
+	if (!dbus_message_get_args(reply, NULL,
 				DBUS_TYPE_OBJECT_PATH, &adapter,
-				DBUS_TYPE_INVALID)) {
-		DBG("adapter path %s", adapter);
-
-		session->adapter = g_strdup(adapter);
-		req = send_method_call(session->conn_system,
-					BT_BUS_NAME, adapter,
-					BT_ADAPTER_IFACE, "RequestSession",
-					adapter_reply, session,
-					DBUS_TYPE_INVALID);
-		if (!req)
-			goto failed;
-
-		session->pending_calls = g_slist_prepend(session->pending_calls,
-									req);
-	} else
+				DBUS_TYPE_INVALID))
 		goto failed;
 
-	goto proceed;
+	DBG("adapter path %s", adapter);
+
+	if (request_session(session, adapter) == 0)
+		goto proceed;
 
 failed:
 	g_set_error(&gerr, OBC_BT_ERROR, -EINVAL, "No adapter found");
@@ -548,12 +514,27 @@ proceed:
 	dbus_message_unref(reply);
 }
 
+static int find_adapter(struct bluetooth_session *session, const char *source)
+{
+	if (source == NULL) {
+		bacpy(&session->src, BDADDR_ANY);
+		return send_method_call(session, BT_PATH, BT_MANAGER_IFACE,
+					"DefaultAdapter", manager_reply,
+					DBUS_TYPE_INVALID);
+	}
+
+	str2ba(source, &session->src);
+	return send_method_call(session, BT_PATH, BT_MANAGER_IFACE,
+					"FindAdapter", manager_reply,
+					DBUS_TYPE_STRING, &source,
+					DBUS_TYPE_INVALID);
+}
+
 static guint bluetooth_connect(const char *source, const char *destination,
 				const char *service, uint16_t port,
 				obc_transport_func func, void *user_data)
 {
 	struct bluetooth_session *session;
-	struct pending_req *req;
 	static guint id = 0;
 
 	DBG("");
@@ -569,8 +550,8 @@ static guint bluetooth_connect(const char *source, const char *destination,
 	session->func = func;
 	session->user_data = user_data;
 
-	session->conn_system = g_dbus_setup_bus(DBUS_BUS_SYSTEM, NULL, NULL);
-	if (session->conn_system == NULL) {
+	session->conn = g_dbus_setup_bus(DBUS_BUS_SYSTEM, NULL, NULL);
+	if (session->conn == NULL) {
 		g_free(session);
 		return 0;
 	}
@@ -578,29 +559,11 @@ static guint bluetooth_connect(const char *source, const char *destination,
 	session->service = g_strdup(service);
 	str2ba(destination, &session->dst);
 
-	if (source == NULL) {
-		bacpy(&session->src, BDADDR_ANY);
-		req = send_method_call(session->conn_system,
-				BT_BUS_NAME, BT_PATH,
-				BT_MANAGER_IFACE, "DefaultAdapter",
-				manager_reply, session,
-				DBUS_TYPE_INVALID);
-	} else {
-		str2ba(source, &session->src);
-		req = send_method_call(session->conn_system,
-				BT_BUS_NAME, BT_PATH,
-				BT_MANAGER_IFACE, "FindAdapter",
-				manager_reply, session,
-				DBUS_TYPE_STRING, &source,
-				DBUS_TYPE_INVALID);
-	}
-
-	if (req == NULL) {
+	if (find_adapter(session, source) < 0) {
 		g_free(session);
 		return 0;
 	}
 
-	session->pending_calls = g_slist_prepend(session->pending_calls, req);
 	sessions = g_slist_prepend(sessions, session);
 
 	return session->id;
-- 
1.7.7.5

