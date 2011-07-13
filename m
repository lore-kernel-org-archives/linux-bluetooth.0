Return-Path: <cyrus@holtmann.org>
From: Dmitriy Paliy <dmitriy.paliy@nokia.com>
To: linux-bluetooth@vger.kernel.org
Cc: Dmitriy Paliy <dmitriy.paliy@nokia.com>
Subject: [PATCH obexd v3 1/2] Add handling of system D-Bus method calls
Date: Wed, 13 Jul 2011 12:43:45 +0300
Message-Id: <1310550226-9656-2-git-send-email-dmitriy.paliy@nokia.com>
In-Reply-To: <1310550226-9656-1-git-send-email-dmitriy.paliy@nokia.com>
References: <1310550226-9656-1-git-send-email-dmitriy.paliy@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Sending system D-Bus method calls (DefaultAdapter, FindAdapter
and RequestSession) and handling of pending D-Bus calls is added
to obex-client.
---
 client/session.c |  197 +++++++++++++++++++++++++++++++++++++++++++++++++++++-
 client/session.h |    2 +
 2 files changed, 198 insertions(+), 1 deletions(-)

diff --git a/client/session.c b/client/session.c
index e6b95de..a84b74e 100644
--- a/client/session.c
+++ b/client/session.c
@@ -56,6 +56,11 @@
 
 #define OBEX_IO_ERROR obex_io_error_quark()
 
+#define BT_BUS_NAME		"org.bluez"
+#define BT_PATH			"/"
+#define BT_ADAPTER_IFACE	"org.bluez.Adapter"
+#define BT_MANAGER_IFACE	"org.bluez.Manager"
+
 static guint64 counter = 0;
 
 static unsigned char pcsuite_uuid[] = { 0x00, 0x00, 0x50, 0x05, 0x00, 0x00,
@@ -87,6 +92,11 @@ struct agent_data {
 	struct pending_data *pending;
 };
 
+struct pending_req {
+	DBusPendingCall *call;
+	void *user_data;
+};
+
 static GSList *sessions = NULL;
 
 static void session_prepare_put(struct session_data *session, GError *err,
@@ -176,10 +186,45 @@ static void session_unregistered(struct session_data *session)
 	session->path = NULL;
 }
 
+static struct pending_req *find_session_request(
+				const struct session_data *session,
+				const DBusPendingCall *call)
+{
+	GSList *l;
+
+	for (l = session->pending_calls; l; l = l->next) {
+		struct pending_req *req = l->data;
+
+		if (req->call == call)
+			return req;
+	}
+
+	return NULL;
+}
+
+static void pending_req_finalize(struct pending_req *req)
+{
+	if (!dbus_pending_call_get_completed(req->call))
+		dbus_pending_call_cancel(req->call);
+
+	dbus_pending_call_unref(req->call);
+	g_free(req);
+}
+
 static void session_free(struct session_data *session)
 {
+	GSList *l = session->pending_calls;
+
 	DBG("%p", session);
 
+	while (l) {
+		struct pending_req *req = l->data;
+		l = l->next;
+
+		session->pending_calls = g_slist_remove(session->pending_calls, req);
+		pending_req_finalize(req);
+	}
+
 	if (session->agent)
 		agent_release(session);
 
@@ -205,6 +250,7 @@ static void session_free(struct session_data *session)
 
 	sessions = g_slist_remove(sessions, session);
 
+	g_free(session->adapter);
 	g_free(session->callback);
 	g_free(session->path);
 	g_free(session->service);
@@ -212,6 +258,50 @@ static void session_free(struct session_data *session)
 	g_free(session);
 }
 
+static struct pending_req *send_method_call(DBusConnection *connection,
+				const char *dest, const char *path,
+				const char *interface, const char *method,
+				DBusPendingCallNotifyFunction cb,
+				void *user_data, int type, ...)
+{
+	DBusMessage *msg;
+	DBusPendingCall *call;
+	va_list args;
+	struct pending_req *req;
+
+	msg = dbus_message_new_method_call(dest, path, interface, method);
+	if (!msg) {
+		error("Unable to allocate new D-Bus %s message", method);
+		return NULL;
+	}
+
+	va_start(args, type);
+
+	if (!dbus_message_append_args_valist(msg, type, args)) {
+		dbus_message_unref(msg);
+		va_end(args);
+		return NULL;
+	}
+
+	va_end(args);
+
+	if (!dbus_connection_send_with_reply(connection, msg, &call, -1)) {
+		error("Sending %s failed", method);
+		dbus_message_unref(msg);
+		return NULL;
+	}
+
+	dbus_pending_call_set_notify(call, cb, user_data, NULL);
+
+	req = g_new0(struct pending_req, 1);
+	req->call = call;
+	req->user_data = user_data;
+
+	dbus_message_unref(msg);
+
+	return req;
+}
+
 void session_unref(struct session_data *session)
 {
 	gboolean ret;
@@ -556,6 +646,93 @@ static int session_connect(struct session_data *session,
 	return err;
 }
 
+static void adapter_reply(DBusPendingCall *call, void *user_data)
+{
+	DBusError err;
+	DBusMessage *reply;
+	struct callback_data *callback = user_data;
+	struct session_data *session = callback->session;
+	struct pending_req *req = find_session_request(session, call);
+
+	reply = dbus_pending_call_steal_reply(call);
+
+	session->pending_calls = g_slist_remove(session->pending_calls, req);
+	pending_req_finalize(req);
+
+	dbus_error_init(&err);
+	if (dbus_set_error_from_message(&err, reply)) {
+		error("manager replied with an error: %s, %s",
+				err.name, err.message);
+		dbus_error_free(&err);
+
+		goto failed;
+	}
+
+	if (session_connect(session, callback) < 0)
+		goto failed;
+
+	goto proceed;
+
+failed:
+	session_unref(session);
+	g_free(callback);
+
+proceed:
+	dbus_message_unref(reply);
+}
+
+static void manager_reply(DBusPendingCall *call, void *user_data)
+{
+	DBusError err;
+	DBusMessage *reply;
+	char *adapter;
+	struct callback_data *callback = user_data;
+	struct session_data *session = callback->session;
+	struct pending_req *req = find_session_request(session, call);
+
+	reply = dbus_pending_call_steal_reply(call);
+
+	session->pending_calls = g_slist_remove(session->pending_calls, req);
+	pending_req_finalize(req);
+
+	dbus_error_init(&err);
+	if (dbus_set_error_from_message(&err, reply)) {
+		error("manager replied with an error: %s, %s",
+				err.name, err.message);
+		dbus_error_free(&err);
+
+		goto failed;
+	}
+
+	if (dbus_message_get_args(reply, NULL,
+				DBUS_TYPE_OBJECT_PATH, &adapter,
+				DBUS_TYPE_INVALID)) {
+		DBG("adapter path %s", adapter);
+
+		session->adapter = g_strdup(adapter);
+		req = send_method_call(session->conn_system,
+					BT_BUS_NAME, adapter,
+					BT_ADAPTER_IFACE, "RequestSession",
+					adapter_reply, callback,
+					DBUS_TYPE_INVALID);
+		if (!req)
+			goto failed;
+
+		session->pending_calls = g_slist_prepend(session->pending_calls,
+									req);
+	} else
+		goto failed;
+
+	goto proceed;
+
+failed:
+	session_unref(session);
+	g_free(callback);
+
+proceed:
+	dbus_message_unref(reply);
+}
+
 struct session_data *session_create(const char *source,
 						const char *destination,
 						const char *service,
@@ -566,6 +743,7 @@ struct session_data *session_create(const char *source,
 {
 	struct session_data *session;
 	struct callback_data *callback;
+	struct pending_req *req;
 
 	if (destination == NULL)
 		return NULL;
@@ -634,12 +812,29 @@ proceed:
 	callback->func = function;
 	callback->data = user_data;
 
-	if (session_connect(session, callback) < 0) {
+	if (source) {
+		req = send_method_call(session->conn_system,
+				BT_BUS_NAME, BT_PATH,
+				BT_MANAGER_IFACE, "FindAdapter",
+				manager_reply, callback,
+				DBUS_TYPE_STRING, &source,
+				DBUS_TYPE_INVALID);
+	} else {
+		req = send_method_call(session->conn_system,
+				BT_BUS_NAME, BT_PATH,
+				BT_MANAGER_IFACE, "DefaultAdapter",
+				manager_reply, callback,
+				DBUS_TYPE_INVALID);
+	}
+
+	if (!req) {
 		session_unref(session);
 		g_free(callback);
 		return NULL;
 	}
 
+	session->pending_calls = g_slist_prepend(session->pending_calls, req);
+
 	if (owner)
 		session_set_owner(session, owner, owner_disconnected);
 
diff --git a/client/session.h b/client/session.h
index 554b494..39f5742 100644
--- a/client/session.h
+++ b/client/session.h
@@ -51,7 +51,9 @@ struct session_data {
 	gchar *owner;		/* Session owner */
 	guint watch;
 	GSList *pending;
+	GSList *pending_calls;
 	void *priv;
+	char *adapter;
 };
 
 typedef void (*session_callback_t) (struct session_data *session,
-- 
1.7.4.1

