Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] obex-client: Remove calls to org.bluez.Manager and org.bluez.Adapter
Date: Wed, 12 Dec 2012 14:16:31 +0200
Message-Id: <1355314591-8773-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

With BlueZ 5 this API no longer exist or have changed.
---
 obexd/client/bluetooth.c | 199 +----------------------------------------------
 1 file changed, 2 insertions(+), 197 deletions(-)

diff --git a/obexd/client/bluetooth.c b/obexd/client/bluetooth.c
index 293eb8f..e453b68 100644
--- a/obexd/client/bluetooth.c
+++ b/obexd/client/bluetooth.c
@@ -41,11 +41,6 @@
 #include "transport.h"
 #include "bluetooth.h"
 
-#define BT_BUS_NAME		"org.bluez"
-#define BT_PATH			"/"
-#define BT_ADAPTER_IFACE	"org.bluez.Adapter"
-#define BT_MANAGER_IFACE	"org.bluez.Manager"
-
 #define BT_RX_MTU 32767
 #define BT_TX_MTU 32767
 
@@ -56,11 +51,8 @@ struct bluetooth_session {
 	bdaddr_t src;
 	bdaddr_t dst;
 	uint16_t port;
-	DBusConnection *conn; /* system bus connection */
 	sdp_session_t *sdp;
 	GIOChannel *io;
-	GSList *pending_calls;
-	char *adapter;
 	char *service;
 	obc_transport_func func;
 	void *user_data;
@@ -73,66 +65,8 @@ static GQuark obc_bt_error_quark(void)
 	return g_quark_from_static_string("obc-bluetooth-error-quark");
 }
 
-static int send_method_call(struct bluetooth_session *session,
-					const char *path,
-					const char *interface,
-					const char *method,
-					DBusPendingCallNotifyFunction cb,
-					int type, ...)
-{
-	DBusMessage *msg;
-	DBusPendingCall *call;
-	va_list args;
-
-	msg = dbus_message_new_method_call(BT_BUS_NAME, path, interface,
-								method);
-	if (!msg) {
-		error("Unable to allocate new D-Bus %s message", method);
-		return -ENOMEM;
-	}
-
-	va_start(args, type);
-
-	if (!dbus_message_append_args_valist(msg, type, args)) {
-		dbus_message_unref(msg);
-		va_end(args);
-		return -EINVAL;
-	}
-
-	va_end(args);
-
-	if (!cb) {
-		g_dbus_send_message(session->conn, msg);
-		return 0;
-	}
-
-	if (!dbus_connection_send_with_reply(session->conn, msg, &call, -1)) {
-		error("Sending %s failed", method);
-		dbus_message_unref(msg);
-		return -EIO;
-	}
-
-	dbus_pending_call_set_notify(call, cb, session, NULL);
-
-	session->pending_calls = g_slist_prepend(session->pending_calls, call);
-
-	dbus_message_unref(msg);
-
-	return 0;
-}
-
-static void finalize_call(DBusPendingCall *call)
-{
-	if (!dbus_pending_call_get_completed(call))
-		dbus_pending_call_cancel(call);
-
-	dbus_pending_call_unref(call);
-}
-
 static void session_destroy(struct bluetooth_session *session)
 {
-	GSList *l;
-
 	DBG("%p", session);
 
 	if (g_slist_find(sessions, session) == NULL)
@@ -140,21 +74,6 @@ static void session_destroy(struct bluetooth_session *session)
 
 	sessions = g_slist_remove(sessions, session);
 
-	if (session->adapter)
-		send_method_call(session, session->adapter, BT_ADAPTER_IFACE,
-						"ReleaseSession", NULL,
-						DBUS_TYPE_INVALID);
-
-	l = session->pending_calls;
-
-	while (l) {
-		DBusPendingCall *call = l->data;
-		l = l->next;
-
-		session->pending_calls = g_slist_remove(session->pending_calls, call);
-		finalize_call(call);
-	}
-
 	if (session->io != NULL) {
 		g_io_channel_shutdown(session->io, TRUE, NULL);
 		g_io_channel_unref(session->io);
@@ -163,11 +82,7 @@ static void session_destroy(struct bluetooth_session *session)
 	if (session->sdp)
 		sdp_close(session->sdp);
 
-	if (session->conn)
-		dbus_connection_unref(session->conn);
-
 	g_free(session->service);
-	g_free(session->adapter);
 	g_free(session);
 }
 
@@ -458,111 +373,6 @@ static int session_connect(struct bluetooth_session *session)
 	return err;
 }
 
-static void adapter_reply(DBusPendingCall *call, void *user_data)
-{
-	struct bluetooth_session *session = user_data;
-	DBusError err;
-	DBusMessage *reply;
-	GError *gerr = NULL;
-
-	reply = dbus_pending_call_steal_reply(call);
-
-	session->pending_calls = g_slist_remove(session->pending_calls, call);
-	finalize_call(call);
-
-	dbus_error_init(&err);
-	if (dbus_set_error_from_message(&err, reply)) {
-		error("manager replied with an error: %s, %s",
-				err.name, err.message);
-		dbus_error_free(&err);
-
-		goto failed;
-	}
-
-	if (session_connect(session) == 0)
-		goto proceed;
-
-failed:
-	g_set_error(&gerr, OBC_BT_ERROR, -EINVAL,
-					"Unable to request session");
-	if (session->func)
-		session->func(session->io, gerr, session->user_data);
-	g_clear_error(&gerr);
-
-	session_destroy(session);
-
-proceed:
-	dbus_message_unref(reply);
-}
-
-static int request_session(struct bluetooth_session *session, const char *adapter)
-{
-	session->adapter = g_strdup(adapter);
-	return send_method_call(session, adapter, BT_ADAPTER_IFACE,
-					"RequestSession", adapter_reply,
-					DBUS_TYPE_INVALID);
-}
-
-static void manager_reply(DBusPendingCall *call, void *user_data)
-{
-	struct bluetooth_session *session = user_data;
-	DBusError err;
-	DBusMessage *reply;
-	char *adapter;
-	GError *gerr = NULL;
-
-	reply = dbus_pending_call_steal_reply(call);
-
-	session->pending_calls = g_slist_remove(session->pending_calls, call);
-	finalize_call(call);
-
-	dbus_error_init(&err);
-	if (dbus_set_error_from_message(&err, reply)) {
-		error("manager replied with an error: %s, %s",
-				err.name, err.message);
-		dbus_error_free(&err);
-
-		goto failed;
-	}
-
-	if (!dbus_message_get_args(reply, NULL,
-				DBUS_TYPE_OBJECT_PATH, &adapter,
-				DBUS_TYPE_INVALID))
-		goto failed;
-
-	DBG("adapter path %s", adapter);
-
-	if (request_session(session, adapter) == 0)
-		goto proceed;
-
-failed:
-	g_set_error(&gerr, OBC_BT_ERROR, -EINVAL, "No adapter found");
-	if (session->func)
-		session->func(session->io, gerr, session->user_data);
-	g_clear_error(&gerr);
-
-	session_destroy(session);
-
-proceed:
-	dbus_message_unref(reply);
-}
-
-static int find_adapter(struct bluetooth_session *session, const char *source)
-{
-	if (source == NULL) {
-		bacpy(&session->src, BDADDR_ANY);
-		return send_method_call(session, BT_PATH, BT_MANAGER_IFACE,
-					"DefaultAdapter", manager_reply,
-					DBUS_TYPE_INVALID);
-	}
-
-	str2ba(source, &session->src);
-	return send_method_call(session, BT_PATH, BT_MANAGER_IFACE,
-					"FindAdapter", manager_reply,
-					DBUS_TYPE_STRING, &source,
-					DBUS_TYPE_INVALID);
-}
-
 static guint bluetooth_connect(const char *source, const char *destination,
 				const char *service, uint16_t port,
 				obc_transport_func func, void *user_data)
@@ -584,16 +394,11 @@ static guint bluetooth_connect(const char *source, const char *destination,
 	session->port = port;
 	session->user_data = user_data;
 
-	session->conn = g_dbus_setup_bus(DBUS_BUS_SYSTEM, NULL, NULL);
-	if (session->conn == NULL) {
-		g_free(session);
-		return 0;
-	}
-
 	session->service = g_strdup(service);
 	str2ba(destination, &session->dst);
+	str2ba(source, &session->src);
 
-	if (find_adapter(session, source) < 0) {
+	if (session_connect(session) < 0) {
 		g_free(session);
 		return 0;
 	}
-- 
1.7.11.7

