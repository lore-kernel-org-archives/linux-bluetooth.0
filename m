Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH obexd 5/6] client: move bluetooth specific code from session.c to bluetooth.c
Date: Fri, 20 Jan 2012 11:50:00 +0200
Message-Id: <1327053001-9506-5-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1327053001-9506-1-git-send-email-luiz.dentz@gmail.com>
References: <1327053001-9506-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This simplifies session.c code quite a bit and enables supporting other
transports in the future.
---
 client/bluetooth.c |  576 ++++++++++++++++++++++++++++++++++++++++++++++++-
 client/session.c   |  621 +++++++---------------------------------------------
 2 files changed, 658 insertions(+), 539 deletions(-)

diff --git a/client/bluetooth.c b/client/bluetooth.c
index 5bde9be..563124d 100644
--- a/client/bluetooth.c
+++ b/client/bluetooth.c
@@ -29,23 +29,597 @@
 #include <inttypes.h>
 
 #include <glib.h>
+#include <gdbus.h>
+#include <btio.h>
+
+#include <bluetooth/bluetooth.h>
+#include <bluetooth/rfcomm.h>
+#include <bluetooth/sdp.h>
+#include <bluetooth/sdp_lib.h>
 
 #include "log.h"
 #include "transport.h"
 #include "bluetooth.h"
 
+#define BT_BUS_NAME		"org.bluez"
+#define BT_PATH			"/"
+#define BT_ADAPTER_IFACE	"org.bluez.Adapter"
+#define BT_MANAGER_IFACE	"org.bluez.Manager"
+
+#define OBC_BT_ERROR obc_bt_error_quark()
+
+struct bluetooth_session {
+	guint id;
+	bdaddr_t src;
+	bdaddr_t dst;
+	uint16_t port;
+	DBusConnection *conn_system; /* system bus connection */
+	sdp_session_t *sdp;
+	GIOChannel *io;
+	GSList *pending_calls;
+	char *adapter;
+	char *service;
+	obc_transport_func func;
+	void *user_data;
+};
+
+struct pending_req {
+	DBusPendingCall *call;
+	void *user_data;
+};
+
+static GSList *sessions = NULL;
+
+static GQuark obc_bt_error_quark(void)
+{
+	return g_quark_from_static_string("obc-bluetooth-error-quark");
+}
+
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
+	if (!cb) {
+		g_dbus_send_message(connection, msg);
+		return 0;
+	}
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
+static void pending_req_finalize(struct pending_req *req)
+{
+	if (!dbus_pending_call_get_completed(req->call))
+		dbus_pending_call_cancel(req->call);
+
+	dbus_pending_call_unref(req->call);
+	g_free(req);
+}
+
+static void session_destroy(struct bluetooth_session *session)
+{
+	GSList *l;
+
+	DBG("%p", session);
+
+	if (g_slist_find(sessions, session) == NULL)
+		return;
+
+	sessions = g_slist_remove(sessions, session);
+
+	if (session->adapter)
+		send_method_call(session->conn_system,
+				BT_BUS_NAME, session->adapter,
+				BT_ADAPTER_IFACE, "ReleaseSession",
+				NULL, NULL,
+				DBUS_TYPE_INVALID);
+
+	l = session->pending_calls;
+
+	while (l) {
+		struct pending_req *req = l->data;
+		l = l->next;
+
+		session->pending_calls = g_slist_remove(session->pending_calls, req);
+		pending_req_finalize(req);
+	}
+
+	if (session->io != NULL) {
+		g_io_channel_shutdown(session->io, TRUE, NULL);
+		g_io_channel_unref(session->io);
+	}
+
+	if (session->conn_system)
+		dbus_connection_unref(session->conn_system);
+
+	g_free(session->service);
+	g_free(session->adapter);
+	g_free(session);
+}
+
+static void rfcomm_callback(GIOChannel *io, GError *err, gpointer user_data)
+{
+	struct bluetooth_session *session = user_data;
+
+	DBG("");
+
+	if (session->func)
+		session->func(io, err, session->user_data);
+
+	if (err != NULL)
+		session_destroy(session);
+}
+
+static GIOChannel *rfcomm_connect(const bdaddr_t *src, const bdaddr_t *dst,
+					uint8_t channel, BtIOConnect function,
+					gpointer user_data)
+{
+	GIOChannel *io;
+	GError *err = NULL;
+
+	DBG("");
+
+	io = bt_io_connect(BT_IO_RFCOMM, function, user_data, NULL, &err,
+				BT_IO_OPT_SOURCE_BDADDR, src,
+				BT_IO_OPT_DEST_BDADDR, dst,
+				BT_IO_OPT_CHANNEL, channel,
+				BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_LOW,
+				BT_IO_OPT_INVALID);
+	if (io != NULL)
+		return io;
+
+	error("%s", err->message);
+	g_error_free(err);
+	return NULL;
+}
+
+static void search_callback(uint8_t type, uint16_t status,
+			uint8_t *rsp, size_t size, void *user_data)
+{
+	struct bluetooth_session *session = user_data;
+	unsigned int scanned, bytesleft = size;
+	int seqlen = 0;
+	uint8_t dataType, channel = 0;
+	GError *gerr = NULL;
+
+	if (status || type != SDP_SVC_SEARCH_ATTR_RSP)
+		goto failed;
+
+	scanned = sdp_extract_seqtype(rsp, bytesleft, &dataType, &seqlen);
+	if (!scanned || !seqlen)
+		goto failed;
+
+	rsp += scanned;
+	bytesleft -= scanned;
+	do {
+		sdp_record_t *rec;
+		sdp_list_t *protos;
+		int recsize, ch = -1;
+
+		recsize = 0;
+		rec = sdp_extract_pdu(rsp, bytesleft, &recsize);
+		if (!rec)
+			break;
+
+		if (!recsize) {
+			sdp_record_free(rec);
+			break;
+		}
+
+		if (!sdp_get_access_protos(rec, &protos)) {
+			ch = sdp_get_proto_port(protos, RFCOMM_UUID);
+			sdp_list_foreach(protos,
+					(sdp_list_func_t) sdp_list_free, NULL);
+			sdp_list_free(protos, NULL);
+			protos = NULL;
+		}
+
+		sdp_record_free(rec);
+
+		if (ch > 0) {
+			channel = ch;
+			break;
+		}
+
+		scanned += recsize;
+		rsp += recsize;
+		bytesleft -= recsize;
+	} while (scanned < size && bytesleft > 0);
+
+	if (channel == 0)
+		goto failed;
+
+	session->port = channel;
+
+	g_io_channel_set_close_on_unref(session->io, FALSE);
+	g_io_channel_unref(session->io);
+
+	session->io = rfcomm_connect(&session->src, &session->dst, channel,
+					rfcomm_callback, session);
+	if (session->io != NULL) {
+		sdp_close(session->sdp);
+		session->sdp = NULL;
+		return;
+	}
+
+failed:
+	g_io_channel_shutdown(session->io, TRUE, NULL);
+	g_io_channel_unref(session->io);
+	session->io = NULL;
+
+	g_set_error(&gerr, OBC_BT_ERROR, -EIO,
+					"Unable to find service record");
+	if (session->func)
+		session->func(session->io, gerr, session->user_data);
+	g_clear_error(&gerr);
+
+	session_destroy(session);
+}
+
+static gboolean process_callback(GIOChannel *io, GIOCondition cond,
+							gpointer user_data)
+{
+	struct bluetooth_session *session = user_data;
+
+	if (cond & (G_IO_ERR | G_IO_HUP | G_IO_NVAL))
+		return FALSE;
+
+	if (sdp_process(session->sdp) < 0)
+		return FALSE;
+
+	return TRUE;
+}
+
+static int bt_string2uuid(uuid_t *uuid, const char *string)
+{
+	uint32_t data0, data4;
+	uint16_t data1, data2, data3, data5;
+
+	if (sscanf(string, "%08x-%04hx-%04hx-%04hx-%08x%04hx",
+				&data0, &data1, &data2, &data3, &data4, &data5) == 6) {
+		uint8_t val[16];
+
+		data0 = g_htonl(data0);
+		data1 = g_htons(data1);
+		data2 = g_htons(data2);
+		data3 = g_htons(data3);
+		data4 = g_htonl(data4);
+		data5 = g_htons(data5);
+
+		memcpy(&val[0], &data0, 4);
+		memcpy(&val[4], &data1, 2);
+		memcpy(&val[6], &data2, 2);
+		memcpy(&val[8], &data3, 2);
+		memcpy(&val[10], &data4, 4);
+		memcpy(&val[14], &data5, 2);
+
+		sdp_uuid128_create(uuid, val);
+
+		return 0;
+	}
+
+	return -EINVAL;
+}
+
+static gboolean service_callback(GIOChannel *io, GIOCondition cond,
+							gpointer user_data)
+{
+	struct bluetooth_session *session = user_data;
+	sdp_list_t *search, *attrid;
+	uint32_t range = 0x0000ffff;
+	GError *gerr = NULL;
+	uuid_t uuid;
+
+	if (cond & G_IO_NVAL)
+		return FALSE;
+
+	if (cond & G_IO_ERR)
+		goto failed;
+
+	if (sdp_set_notify(session->sdp, search_callback, session) < 0)
+		goto failed;
+
+	if (bt_string2uuid(&uuid, session->service) < 0)
+		goto failed;
+
+	search = sdp_list_append(NULL, &uuid);
+	attrid = sdp_list_append(NULL, &range);
+
+	if (sdp_service_search_attr_async(session->sdp,
+				search, SDP_ATTR_REQ_RANGE, attrid) < 0) {
+		sdp_list_free(attrid, NULL);
+		sdp_list_free(search, NULL);
+		goto failed;
+	}
+
+	sdp_list_free(attrid, NULL);
+	sdp_list_free(search, NULL);
+
+	g_io_add_watch(io, G_IO_IN | G_IO_HUP | G_IO_ERR | G_IO_NVAL,
+						process_callback, session);
+
+	return FALSE;
+
+failed:
+	g_io_channel_shutdown(session->io, TRUE, NULL);
+	g_io_channel_unref(session->io);
+	session->io = NULL;
+
+	g_set_error(&gerr, OBC_BT_ERROR, -EIO,
+					"Unable to find service record");
+	if (session->func)
+		session->func(session->io, gerr, session->user_data);
+	g_clear_error(&gerr);
+
+	session_destroy(session);
+	return FALSE;
+}
+
+static sdp_session_t *service_connect(const bdaddr_t *src, const bdaddr_t *dst,
+					GIOFunc function, gpointer user_data)
+{
+	struct bluetooth_session *session = user_data;
+	sdp_session_t *sdp;
+	GIOChannel *io;
+
+	sdp = sdp_connect(src, dst, SDP_NON_BLOCKING);
+	if (sdp == NULL)
+		return NULL;
+
+	io = g_io_channel_unix_new(sdp_get_socket(sdp));
+	if (io == NULL) {
+		sdp_close(sdp);
+		return NULL;
+	}
+
+	g_io_add_watch(io, G_IO_OUT | G_IO_HUP | G_IO_ERR | G_IO_NVAL,
+							function, user_data);
+
+	session->io = io;
+
+	return sdp;
+}
+
+static int session_connect(struct bluetooth_session *session)
+{
+	int err;
+
+	if (session->port > 0) {
+		session->io = rfcomm_connect(&session->src, &session->dst,
+							session->port,
+							rfcomm_callback,
+							session);
+		err = (session->io == NULL) ? -EINVAL : 0;
+	} else {
+		session->sdp = service_connect(&session->src, &session->dst,
+						service_callback, session);
+		err = (session->sdp == NULL) ? -ENOMEM : 0;
+	}
+
+	return err;
+}
+
+static struct pending_req *find_session_request(
+				const struct bluetooth_session *session,
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
+static void adapter_reply(DBusPendingCall *call, void *user_data)
+{
+	DBusError err;
+	DBusMessage *reply;
+	struct bluetooth_session *session = user_data;
+	struct pending_req *req = find_session_request(session, call);
+	GError *gerr = NULL;
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
+	if (session_connect(session) < 0)
+		goto failed;
+
+	goto proceed;
+
+failed:
+	g_set_error(&gerr, OBC_BT_ERROR, -EINVAL,
+					"Unable to request session");
+	if (session->func)
+		session->func(session->io, gerr, session->user_data);
+	g_clear_error(&gerr);
+
+	session_destroy(session);
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
+	struct bluetooth_session *session = user_data;
+	struct pending_req *req = find_session_request(session, call);
+	GError *gerr = NULL;
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
+					adapter_reply, session,
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
+	g_set_error(&gerr, OBC_BT_ERROR, -EINVAL, "No adapter found");
+	if (session->func)
+		session->func(session->io, gerr, session->user_data);
+	g_clear_error(&gerr);
+
+	session_destroy(session);
+
+proceed:
+	dbus_message_unref(reply);
+}
+
 static guint bluetooth_connect(const char *source, const char *destination,
 				const char *service, uint16_t port,
 				obc_transport_func func, void *user_data)
 {
+	struct bluetooth_session *session;
+	struct pending_req *req;
+	static guint id = 0;
+
 	DBG("");
 
-	return 0;
+	if (destination == NULL)
+		return 0;
+
+	session = g_try_malloc0(sizeof(*session));
+	if (session == NULL)
+		return 0;
+
+	session->id = ++id;
+	session->func = func;
+	session->user_data = user_data;
+
+	session->conn_system = g_dbus_setup_bus(DBUS_BUS_SYSTEM, NULL, NULL);
+	if (session->conn_system == NULL) {
+		g_free(session);
+		return 0;
+	}
+
+	session->service = g_strdup(service);
+	str2ba(destination, &session->dst);
+
+	if (source == NULL) {
+		bacpy(&session->src, BDADDR_ANY);
+		req = send_method_call(session->conn_system,
+				BT_BUS_NAME, BT_PATH,
+				BT_MANAGER_IFACE, "DefaultAdapter",
+				manager_reply, session,
+				DBUS_TYPE_INVALID);
+	} else {
+		str2ba(source, &session->src);
+		req = send_method_call(session->conn_system,
+				BT_BUS_NAME, BT_PATH,
+				BT_MANAGER_IFACE, "FindAdapter",
+				manager_reply, session,
+				DBUS_TYPE_STRING, &source,
+				DBUS_TYPE_INVALID);
+	}
+
+	if (req == NULL) {
+		g_free(session);
+		return 0;
+	}
+
+	session->pending_calls = g_slist_prepend(session->pending_calls, req);
+	sessions = g_slist_prepend(sessions, session);
+
+	return session->id;
 }
 
 static void bluetooth_disconnect(guint id)
 {
+	GSList *l;
+
 	DBG("");
+
+	for (l = sessions; l; l = l->next) {
+		struct bluetooth_session *session = l->data;
+
+		if (session->id == id) {
+			session_destroy(session);
+			return;
+		}
+	}
 }
 
 static struct obc_transport bluetooth = {
diff --git a/client/session.c b/client/session.c
index 7de1492..c127974 100644
--- a/client/session.c
+++ b/client/session.c
@@ -35,33 +35,22 @@
 #include <gdbus.h>
 #include <gobex.h>
 
-#include <bluetooth/bluetooth.h>
-#include <bluetooth/rfcomm.h>
-#include <bluetooth/sdp.h>
-#include <bluetooth/sdp_lib.h>
-
 #include "log.h"
 #include "transfer.h"
 #include "session.h"
-#include "btio.h"
 #include "agent.h"
 #include "driver.h"
+#include "transport.h"
 
 #define SESSION_INTERFACE  "org.openobex.Session"
 #define SESSION_BASEPATH   "/org/openobex"
 
 #define OBEX_IO_ERROR obex_io_error_quark()
 
-#define BT_BUS_NAME		"org.bluez"
-#define BT_PATH			"/"
-#define BT_ADAPTER_IFACE	"org.bluez.Adapter"
-#define BT_MANAGER_IFACE	"org.bluez.Manager"
-
 static guint64 counter = 0;
 
 struct callback_data {
 	struct obc_session *session;
-	sdp_session_t *sdp;
 	session_callback_t func;
 	void *data;
 };
@@ -77,30 +66,23 @@ struct pending_data {
 	struct obc_transfer *transfer;
 };
 
-struct pending_req {
-	DBusPendingCall *call;
-	void *user_data;
-};
-
 struct obc_session {
+	guint id;
 	gint refcount;
-	bdaddr_t src;
-	bdaddr_t dst;
+	char *source;
+	char *destination;
 	uint8_t channel;
+	struct obc_transport *transport;
 	struct obc_driver *driver;
 	gchar *path;		/* Session path */
 	DBusConnection *conn;
-	DBusConnection *conn_system; /* system bus connection */
 	DBusMessage *msg;
 	GObex *obex;
-	GIOChannel *io;
 	struct obc_agent *agent;
 	struct session_callback *callback;
 	gchar *owner;		/* Session owner */
 	guint watch;
 	GSList *pending;
-	GSList *pending_calls;
-	char *adapter;
 };
 
 static GSList *sessions = NULL;
@@ -142,45 +124,10 @@ static void session_unregistered(struct obc_session *session)
 	g_free(path);
 }
 
-static struct pending_req *find_session_request(
-				const struct obc_session *session,
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
-static void pending_req_finalize(struct pending_req *req)
-{
-	if (!dbus_pending_call_get_completed(req->call))
-		dbus_pending_call_cancel(req->call);
-
-	dbus_pending_call_unref(req->call);
-	g_free(req);
-}
-
 static void session_free(struct obc_session *session)
 {
-	GSList *l = session->pending_calls;
-
 	DBG("%p", session);
 
-	while (l) {
-		struct pending_req *req = l->data;
-		l = l->next;
-
-		session->pending_calls = g_slist_remove(session->pending_calls, req);
-		pending_req_finalize(req);
-	}
-
 	if (session->agent) {
 		obc_agent_release(session->agent);
 		obc_agent_free(session->agent);
@@ -192,10 +139,8 @@ static void session_free(struct obc_session *session)
 	if (session->obex != NULL)
 		g_obex_unref(session->obex);
 
-	if (session->io != NULL) {
-		g_io_channel_shutdown(session->io, TRUE, NULL);
-		g_io_channel_unref(session->io);
-	}
+	if (session->id > 0 && session->transport != NULL)
+		session->transport->disconnect(session->id);
 
 	if (session->path)
 		session_unregistered(session);
@@ -203,67 +148,16 @@ static void session_free(struct obc_session *session)
 	if (session->conn)
 		dbus_connection_unref(session->conn);
 
-	if (session->conn_system)
-		dbus_connection_unref(session->conn_system);
-
 	sessions = g_slist_remove(sessions, session);
 
-	g_free(session->adapter);
 	g_free(session->callback);
 	g_free(session->path);
 	g_free(session->owner);
+	g_free(session->source);
+	g_free(session->destination);
 	g_free(session);
 }
 
-static struct pending_req *send_method_call(DBusConnection *connection,
-				const char *dest, const char *path,
-				const char *interface, const char *method,
-				DBusPendingCallNotifyFunction cb,
-				void *user_data, int type, ...)
-{
-	DBusMessage *msg;
-	DBusPendingCall *call;
-	va_list args;
-	struct pending_req *req;
-
-	msg = dbus_message_new_method_call(dest, path, interface, method);
-	if (!msg) {
-		error("Unable to allocate new D-Bus %s message", method);
-		return NULL;
-	}
-
-	va_start(args, type);
-
-	if (!dbus_message_append_args_valist(msg, type, args)) {
-		dbus_message_unref(msg);
-		va_end(args);
-		return NULL;
-	}
-
-	va_end(args);
-
-	if (!cb) {
-		g_dbus_send_message(connection, msg);
-		return 0;
-	}
-
-	if (!dbus_connection_send_with_reply(connection, msg, &call, -1)) {
-		error("Sending %s failed", method);
-		dbus_message_unref(msg);
-		return NULL;
-	}
-
-	dbus_pending_call_set_notify(call, cb, user_data, NULL);
-
-	req = g_new0(struct pending_req, 1);
-	req->call = call;
-	req->user_data = user_data;
-
-	dbus_message_unref(msg);
-
-	return req;
-}
-
 void obc_session_unref(struct obc_session *session)
 {
 	gboolean ret;
@@ -275,11 +169,6 @@ void obc_session_unref(struct obc_session *session)
 	if (ret == FALSE)
 		return;
 
-	send_method_call(session->conn_system,
-				BT_BUS_NAME, session->adapter,
-				BT_ADAPTER_IFACE, "ReleaseSession",
-				NULL, NULL,
-				DBUS_TYPE_INVALID);
 	session_free(session);
 }
 
@@ -309,7 +198,7 @@ done:
 	g_free(callback);
 }
 
-static void rfcomm_callback(GIOChannel *io, GError *err, gpointer user_data)
+static void transport_func(GIOChannel *io, GError *err, gpointer user_data)
 {
 	struct callback_data *callback = user_data;
 	struct obc_session *session = callback->session;
@@ -323,15 +212,13 @@ static void rfcomm_callback(GIOChannel *io, GError *err, gpointer user_data)
 		goto done;
 	}
 
-	g_io_channel_set_close_on_unref(session->io, FALSE);
+	g_io_channel_set_close_on_unref(io, FALSE);
 
-	obex = g_obex_new(session->io, G_OBEX_TRANSPORT_STREAM, -1, -1);
+	obex = g_obex_new(io, G_OBEX_TRANSPORT_STREAM, -1, -1);
 	if (obex == NULL)
 		goto done;
 
-	g_io_channel_set_close_on_unref(session->io, TRUE);
-	g_io_channel_unref(session->io);
-	session->io = NULL;
+	g_io_channel_set_close_on_unref(io, TRUE);
 
 	if (driver->target != NULL)
 		g_obex_connect(obex, connect_cb, callback, &err,
@@ -357,247 +244,6 @@ done:
 	g_free(callback);
 }
 
-static GIOChannel *rfcomm_connect(const bdaddr_t *src, const bdaddr_t *dst,
-					uint8_t channel, BtIOConnect function,
-					gpointer user_data)
-{
-	GIOChannel *io;
-	GError *err = NULL;
-
-	DBG("");
-
-	io = bt_io_connect(BT_IO_RFCOMM, function, user_data, NULL, &err,
-				BT_IO_OPT_SOURCE_BDADDR, src,
-				BT_IO_OPT_DEST_BDADDR, dst,
-				BT_IO_OPT_CHANNEL, channel,
-				BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_LOW,
-				BT_IO_OPT_INVALID);
-	if (io != NULL)
-		return io;
-
-	error("%s", err->message);
-	g_error_free(err);
-	return NULL;
-}
-
-static void search_callback(uint8_t type, uint16_t status,
-			uint8_t *rsp, size_t size, void *user_data)
-{
-	struct callback_data *callback = user_data;
-	struct obc_session *session = callback->session;
-	unsigned int scanned, bytesleft = size;
-	int seqlen = 0;
-	uint8_t dataType, channel = 0;
-	GError *gerr = NULL;
-
-	if (status || type != SDP_SVC_SEARCH_ATTR_RSP)
-		goto failed;
-
-	scanned = sdp_extract_seqtype(rsp, bytesleft, &dataType, &seqlen);
-	if (!scanned || !seqlen)
-		goto failed;
-
-	rsp += scanned;
-	bytesleft -= scanned;
-	do {
-		sdp_record_t *rec;
-		sdp_list_t *protos;
-		int recsize, ch = -1;
-
-		recsize = 0;
-		rec = sdp_extract_pdu(rsp, bytesleft, &recsize);
-		if (!rec)
-			break;
-
-		if (!recsize) {
-			sdp_record_free(rec);
-			break;
-		}
-
-		if (!sdp_get_access_protos(rec, &protos)) {
-			ch = sdp_get_proto_port(protos, RFCOMM_UUID);
-			sdp_list_foreach(protos,
-					(sdp_list_func_t) sdp_list_free, NULL);
-			sdp_list_free(protos, NULL);
-			protos = NULL;
-		}
-
-		sdp_record_free(rec);
-
-		if (ch > 0) {
-			channel = ch;
-			break;
-		}
-
-		scanned += recsize;
-		rsp += recsize;
-		bytesleft -= recsize;
-	} while (scanned < size && bytesleft > 0);
-
-	if (channel == 0)
-		goto failed;
-
-	session->channel = channel;
-
-	g_io_channel_set_close_on_unref(session->io, FALSE);
-	g_io_channel_unref(session->io);
-
-	session->io = rfcomm_connect(&session->src, &session->dst, channel,
-					rfcomm_callback, callback);
-	if (session->io != NULL) {
-		sdp_close(callback->sdp);
-		return;
-	}
-
-failed:
-	g_io_channel_shutdown(session->io, TRUE, NULL);
-	g_io_channel_unref(session->io);
-	session->io = NULL;
-
-	g_set_error(&gerr, OBEX_IO_ERROR, -EIO,
-					"Unable to find service record");
-	callback->func(session, gerr, callback->data);
-	g_clear_error(&gerr);
-
-	obc_session_unref(callback->session);
-	g_free(callback);
-}
-
-static gboolean process_callback(GIOChannel *io, GIOCondition cond,
-							gpointer user_data)
-{
-	struct callback_data *callback = user_data;
-
-	if (cond & (G_IO_ERR | G_IO_HUP | G_IO_NVAL))
-		return FALSE;
-
-	if (sdp_process(callback->sdp) < 0)
-		return FALSE;
-
-	return TRUE;
-}
-
-static int bt_string2uuid(uuid_t *uuid, const char *string)
-{
-	uint32_t data0, data4;
-	uint16_t data1, data2, data3, data5;
-
-	if (sscanf(string, "%08x-%04hx-%04hx-%04hx-%08x%04hx",
-				&data0, &data1, &data2, &data3, &data4, &data5) == 6) {
-		uint8_t val[16];
-
-		data0 = g_htonl(data0);
-		data1 = g_htons(data1);
-		data2 = g_htons(data2);
-		data3 = g_htons(data3);
-		data4 = g_htonl(data4);
-		data5 = g_htons(data5);
-
-		memcpy(&val[0], &data0, 4);
-		memcpy(&val[4], &data1, 2);
-		memcpy(&val[6], &data2, 2);
-		memcpy(&val[8], &data3, 2);
-		memcpy(&val[10], &data4, 4);
-		memcpy(&val[14], &data5, 2);
-
-		sdp_uuid128_create(uuid, val);
-
-		return 0;
-	}
-
-	return -EINVAL;
-}
-
-static gboolean service_callback(GIOChannel *io, GIOCondition cond,
-							gpointer user_data)
-{
-	struct callback_data *callback = user_data;
-	struct obc_session *session = callback->session;
-	sdp_list_t *search, *attrid;
-	uint32_t range = 0x0000ffff;
-	GError *gerr = NULL;
-	uuid_t uuid;
-
-	if (cond & (G_IO_NVAL | G_IO_ERR))
-		goto failed;
-
-	if (sdp_set_notify(callback->sdp, search_callback, callback) < 0)
-		goto failed;
-
-	if (bt_string2uuid(&uuid, session->driver->uuid) < 0)
-		goto failed;
-
-	search = sdp_list_append(NULL, &uuid);
-	attrid = sdp_list_append(NULL, &range);
-
-	if (sdp_service_search_attr_async(callback->sdp,
-				search, SDP_ATTR_REQ_RANGE, attrid) < 0) {
-		sdp_list_free(attrid, NULL);
-		sdp_list_free(search, NULL);
-		goto failed;
-	}
-
-	sdp_list_free(attrid, NULL);
-	sdp_list_free(search, NULL);
-
-	g_io_add_watch(io, G_IO_IN | G_IO_HUP | G_IO_ERR | G_IO_NVAL,
-						process_callback, callback);
-
-	return FALSE;
-
-failed:
-	g_io_channel_shutdown(session->io, TRUE, NULL);
-	g_io_channel_unref(session->io);
-	session->io = NULL;
-
-	g_set_error(&gerr, OBEX_IO_ERROR, -EIO,
-					"Unable to find service record");
-	callback->func(callback->session, gerr, callback->data);
-	g_clear_error(&gerr);
-
-	obc_session_unref(callback->session);
-	g_free(callback);
-	return FALSE;
-}
-
-static sdp_session_t *service_connect(const bdaddr_t *src, const bdaddr_t *dst,
-					GIOFunc function, gpointer user_data)
-{
-	struct callback_data *cb = user_data;
-	sdp_session_t *sdp;
-	GIOChannel *io;
-
-	sdp = sdp_connect(src, dst, SDP_NON_BLOCKING);
-	if (sdp == NULL)
-		return NULL;
-
-	io = g_io_channel_unix_new(sdp_get_socket(sdp));
-	if (io == NULL) {
-		sdp_close(sdp);
-		return NULL;
-	}
-
-	g_io_add_watch(io, G_IO_OUT | G_IO_HUP | G_IO_ERR | G_IO_NVAL,
-							function, user_data);
-
-	cb->session->io = io;
-
-	return sdp;
-}
-
-static gboolean connection_complete(gpointer data)
-{
-	struct callback_data *cb = data;
-
-	cb->func(cb->session, 0, cb->data);
-
-	obc_session_unref(cb->session);
-
-	g_free(cb);
-
-	return FALSE;
-}
-
 static void owner_disconnected(DBusConnection *connection, void *user_data)
 {
 	struct obc_session *session = user_data;
@@ -626,6 +272,7 @@ int obc_session_set_owner(struct obc_session *session, const char *name,
 	return 0;
 }
 
+
 static struct obc_session *session_find(const char *source,
 						const char *destination,
 						const char *service,
@@ -636,21 +283,16 @@ static struct obc_session *session_find(const char *source,
 
 	for (l = sessions; l; l = l->next) {
 		struct obc_session *session = l->data;
-		bdaddr_t adr;
 
-		if (source) {
-			str2ba(source, &adr);
-			if (bacmp(&session->src, &adr))
-				continue;
-		}
-
-		str2ba(destination, &adr);
-		if (bacmp(&session->dst, &adr))
+		if (g_strcmp0(session->destination, destination))
 			continue;
 
 		if (g_strcmp0(service, session->driver->service))
 			continue;
 
+		if (source && g_strcmp0(session->source, source))
+			continue;
+
 		if (channel && session->channel != channel)
 			continue;
 
@@ -663,114 +305,54 @@ static struct obc_session *session_find(const char *source,
 	return NULL;
 }
 
-static int session_connect(struct obc_session *session,
-						struct callback_data *callback)
-{
-	int err;
-
-	if (session->obex) {
-		g_idle_add(connection_complete, callback);
-		err = 0;
-	} else if (session->channel > 0) {
-		session->io = rfcomm_connect(&session->src, &session->dst,
-							session->channel,
-							rfcomm_callback,
-							callback);
-		err = (session->io == NULL) ? -EINVAL : 0;
-	} else {
-		callback->sdp = service_connect(&session->src, &session->dst,
-						service_callback, callback);
-		err = (callback->sdp == NULL) ? -ENOMEM : 0;
-	}
-
-	return err;
-}
-
-static void adapter_reply(DBusPendingCall *call, void *user_data)
+static gboolean connection_complete(gpointer data)
 {
-	DBusError err;
-	DBusMessage *reply;
-	struct callback_data *callback = user_data;
-	struct obc_session *session = callback->session;
-	struct pending_req *req = find_session_request(session, call);
-
-	reply = dbus_pending_call_steal_reply(call);
-
-	session->pending_calls = g_slist_remove(session->pending_calls, req);
-	pending_req_finalize(req);
-
-	dbus_error_init(&err);
-	if (dbus_set_error_from_message(&err, reply)) {
-		error("manager replied with an error: %s, %s",
-				err.name, err.message);
-		dbus_error_free(&err);
-
-		goto failed;
-	}
+	struct callback_data *cb = data;
 
-	if (session_connect(session, callback) < 0)
-		goto failed;
+	cb->func(cb->session, 0, cb->data);
 
-	goto proceed;
+	obc_session_unref(cb->session);
 
-failed:
-	obc_session_unref(session);
-	g_free(callback);
+	g_free(cb);
 
-proceed:
-	dbus_message_unref(reply);
+	return FALSE;
 }
 
-static void manager_reply(DBusPendingCall *call, void *user_data)
+static int session_connect(struct obc_session *session,
+				session_callback_t function, void *user_data)
 {
-	DBusError err;
-	DBusMessage *reply;
-	char *adapter;
-	struct callback_data *callback = user_data;
-	struct obc_session *session = callback->session;
-	struct pending_req *req = find_session_request(session, call);
-
-	reply = dbus_pending_call_steal_reply(call);
+	struct callback_data *callback;
+	struct obc_transport *transport = session->transport;
+	struct obc_driver *driver = session->driver;
 
-	session->pending_calls = g_slist_remove(session->pending_calls, req);
-	pending_req_finalize(req);
+	callback = g_try_malloc0(sizeof(*callback));
+	if (callback == NULL)
+		return -ENOMEM;
 
-	dbus_error_init(&err);
-	if (dbus_set_error_from_message(&err, reply)) {
-		error("manager replied with an error: %s, %s",
-				err.name, err.message);
-		dbus_error_free(&err);
+	callback->func = function;
+	callback->data = user_data;
+	callback->session = obc_session_ref(session);
 
-		goto failed;
+	/* Connection completed */
+	if (session->obex) {
+		g_idle_add(connection_complete, callback);
+		return 0;
 	}
 
-	if (dbus_message_get_args(reply, NULL,
-				DBUS_TYPE_OBJECT_PATH, &adapter,
-				DBUS_TYPE_INVALID)) {
-		DBG("adapter path %s", adapter);
-
-		session->adapter = g_strdup(adapter);
-		req = send_method_call(session->conn_system,
-					BT_BUS_NAME, adapter,
-					BT_ADAPTER_IFACE, "RequestSession",
-					adapter_reply, callback,
-					DBUS_TYPE_INVALID);
-		if (!req)
-			goto failed;
-
-		session->pending_calls = g_slist_prepend(session->pending_calls,
-									req);
-	} else
-		goto failed;
-
-	goto proceed;
+	/* Ongoing connection */
+	if (session->id > 0)
+		return 0;
 
-failed:
-	obc_session_unref(session);
-	g_free(callback);
+	session->id = transport->connect(session->source, session->destination,
+					driver->uuid, session->channel,
+					transport_func, callback);
+	if (session->id == 0) {
+		obc_session_unref(callback->session);
+		g_free(callback);
+		return -EINVAL;
+	}
 
-proceed:
-	dbus_message_unref(reply);
+	return 0;
 }
 
 struct obc_session *obc_session_create(const char *source,
@@ -781,89 +363,54 @@ struct obc_session *obc_session_create(const char *source,
 						session_callback_t function,
 						void *user_data)
 {
+	DBusConnection *conn;
 	struct obc_session *session;
-	struct callback_data *callback;
-	struct pending_req *req;
+	struct obc_transport *transport;
 	struct obc_driver *driver;
 
 	if (destination == NULL)
 		return NULL;
 
 	session = session_find(source, destination, service, channel, owner);
-	if (session) {
-		obc_session_ref(session);
+	if (session != NULL)
 		goto proceed;
-	}
 
-	driver = obc_driver_find(service);
-	if (!driver)
+	/* FIXME: Do proper transport lookup when the API supports it */
+	transport = obc_transport_find("Bluetooth");
+	if (transport == NULL)
 		return NULL;
 
-	session = g_try_malloc0(sizeof(*session));
-	if (session == NULL)
+	driver = obc_driver_find(service);
+	if (driver == NULL)
 		return NULL;
 
-	session->refcount = 1;
-	session->channel = channel;
-
-	session->conn = dbus_bus_get(DBUS_BUS_SESSION, NULL);
-	if (session->conn == NULL) {
-		session_free(session);
+	conn = dbus_bus_get(DBUS_BUS_SESSION, NULL);
+	if (conn == NULL)
 		return NULL;
-	}
 
-	session->conn_system = g_dbus_setup_bus(DBUS_BUS_SYSTEM, NULL, NULL);
-	if (session->conn_system == NULL) {
-		session_free(session);
+	session = g_try_malloc0(sizeof(*session));
+	if (session == NULL)
 		return NULL;
-	}
-
-	if (source == NULL)
-		bacpy(&session->src, BDADDR_ANY);
-	else
-		str2ba(source, &session->src);
 
-	str2ba(destination, &session->dst);
+	session->refcount = 1;
+	session->transport = transport;
 	session->driver = driver;
+	session->conn = conn;
+	session->source = g_strdup(source);
+	session->destination = g_strdup(destination);
+	session->channel = channel;
 
-	DBG("driver %s", driver->service);
+	if (owner)
+		obc_session_set_owner(session, owner, owner_disconnected);
 
 proceed:
-	callback = g_try_malloc0(sizeof(*callback));
-	if (callback == NULL) {
+	if (session_connect(session, function, user_data) < 0) {
 		obc_session_unref(session);
 		return NULL;
 	}
 
-	callback->session = obc_session_ref(session);
-	callback->func = function;
-	callback->data = user_data;
-
-	if (source) {
-		req = send_method_call(session->conn_system,
-				BT_BUS_NAME, BT_PATH,
-				BT_MANAGER_IFACE, "FindAdapter",
-				manager_reply, callback,
-				DBUS_TYPE_STRING, &source,
-				DBUS_TYPE_INVALID);
-	} else {
-		req = send_method_call(session->conn_system,
-				BT_BUS_NAME, BT_PATH,
-				BT_MANAGER_IFACE, "DefaultAdapter",
-				manager_reply, callback,
-				DBUS_TYPE_INVALID);
-	}
-
-	if (!req) {
-		obc_session_unref(session);
-		g_free(callback);
-		return NULL;
-	}
-
-	session->pending_calls = g_slist_prepend(session->pending_calls, req);
-
-	if (owner)
-		obc_session_set_owner(session, owner, owner_disconnected);
+	DBG("session %p transport %s driver %s", session,
+			session->transport->name, session->driver->service);
 
 	return session;
 }
@@ -900,15 +447,14 @@ void obc_session_shutdown(struct obc_session *session)
 		obc_session_remove_transfer(session, transfer);
 	}
 
-
 	/* Unregister interfaces */
 	if (session->path)
 		session_unregistered(session);
 
-	/* Shutdown io */
-	if (session->io) {
-		int fd = g_io_channel_unix_get_fd(session->io);
-		shutdown(fd, SHUT_RDWR);
+	/* Disconnect transport */
+	if (session->id > 0 && session->transport != NULL) {
+		session->transport->disconnect(session->id);
+		session->id = 0;
 	}
 
 	obc_session_unref(session);
@@ -1008,8 +554,6 @@ static DBusMessage *session_get_properties(DBusConnection *connection,
 	struct obc_session *session = user_data;
 	DBusMessage *reply;
 	DBusMessageIter iter, dict;
-	char addr[18];
-	char *paddr = addr;
 
 	reply = dbus_message_new_method_return(message);
 	if (!reply)
@@ -1022,11 +566,12 @@ static DBusMessage *session_get_properties(DBusConnection *connection,
 			DBUS_TYPE_STRING_AS_STRING DBUS_TYPE_VARIANT_AS_STRING
 			DBUS_DICT_ENTRY_END_CHAR_AS_STRING, &dict);
 
-	ba2str(&session->src, addr);
-	append_entry(&dict, "Source", DBUS_TYPE_STRING, &paddr);
+	if (session->source != NULL)
+		append_entry(&dict, "Source", DBUS_TYPE_STRING,
+							&session->source);
 
-	ba2str(&session->dst, addr);
-	append_entry(&dict, "Destination", DBUS_TYPE_STRING, &paddr);
+	append_entry(&dict, "Destination", DBUS_TYPE_STRING,
+							&session->destination);
 
 	append_entry(&dict, "Channel", DBUS_TYPE_BYTE, &session->channel);
 
-- 
1.7.7.5

