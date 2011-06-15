Return-Path: <cyrus@holtmann.org>
From: Nami <nami.li@atheros.com>
To: <linux-bluetooth@vger.kernel.org>
CC: nami <nami.li@atheros.com>
Subject: [PATCH 1/2] Bluetooth:  FTP and OPP over L2CAP
Date: Wed, 15 Jun 2011 11:51:29 +0800
Message-ID: <1308109889-5597-1-git-send-email-nami.li@atheros.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: nami <nami.li@atheros.com>


Signed-off-by: Nami <nami.li@atheros.com>
---
 client/main.c       |   26 +++++++----
 client/session.c    |  119 ++++++++++++++++++++++++++++++++++++++++++++++----
 client/session.h    |    6 +++
 gwobex/gw-obex.c    |    6 +-
 gwobex/gw-obex.h    |    3 +-
 gwobex/obex-priv.c  |    4 +-
 gwobex/obex-priv.h  |    2 +-
 plugins/bluetooth.c |  112 +++++++++++++++++++++++++++++++++++++++++++++---
 plugins/ftp.c       |    8 +++-
 plugins/opp.c       |    8 +++-
 src/obex.c          |   10 +++-
 src/service.h       |    7 +++
 test/main.c         |    2 +-
 13 files changed, 275 insertions(+), 38 deletions(-)

diff --git a/client/main.c b/client/main.c
index 478181c..5752831 100644
--- a/client/main.c
+++ b/client/main.c
@@ -125,7 +125,7 @@ done:

 static int parse_device_dict(DBusMessageIter *iter,
 		const char **source, const char **dest, const char **target,
-		uint8_t *channel)
+		uint8_t *channel, uint16_t *psm)
 {
 	while (dbus_message_iter_get_arg_type(iter) == DBUS_TYPE_DICT_ENTRY) {
 		DBusMessageIter entry, value;
@@ -150,6 +150,10 @@ static int parse_device_dict(DBusMessageIter *iter,
 			if (g_str_equal(key, "Channel") == TRUE)
 				dbus_message_iter_get_basic(&value, channel);
 			break;
+		case DBUS_TYPE_UINT16:
+			if (g_str_equal(key, "Psm") == TRUE)
+				dbus_message_iter_get_basic(&value, psm);
+			break;
 		}

 		dbus_message_iter_next(iter);
@@ -168,11 +172,12 @@ static DBusMessage *send_files(DBusConnection *connection,
 	const char *agent, *source = NULL, *dest = NULL, *target = NULL;
 	const char *sender;
 	uint8_t channel = 0;
+	uint16_t psm = 0;

 	dbus_message_iter_init(message, &iter);
 	dbus_message_iter_recurse(&iter, &array);

-	parse_device_dict(&array, &source, &dest, &target, &channel);
+	parse_device_dict(&array, &source, &dest, &target, &channel, &psm);
 	if (dest == NULL)
 		return g_dbus_create_error(message,
 				"org.openobex.Error.InvalidArguments", NULL);
@@ -218,7 +223,7 @@ static DBusMessage *send_files(DBusConnection *connection,
 	data->agent = g_strdup(agent);
 	data->files = files;

-	session = session_create(source, dest, "OPP", channel, sender,
+	session = session_create(source, dest, "OPP", channel, psm, sender,
 							create_callback, data);
 	if (session != NULL) {
 		sessions = g_slist_append(sessions, session);
@@ -295,11 +300,12 @@ static DBusMessage *pull_business_card(DBusConnection *connection,
 	const char *source = NULL, *dest = NULL, *target = NULL;
 	const char *name = NULL;
 	uint8_t channel = 0;
+	uint16_t psm = 0;

 	dbus_message_iter_init(message, &iter);
 	dbus_message_iter_recurse(&iter, &dict);

-	parse_device_dict(&dict, &source, &dest, &target, &channel);
+	parse_device_dict(&dict, &source, &dest, &target, &channel, &psm);
 	if (dest == NULL)
 		return g_dbus_create_error(message,
 				"org.openobex.Error.InvalidArguments", NULL);
@@ -322,7 +328,7 @@ static DBusMessage *pull_business_card(DBusConnection *connection,
 	data->sender = g_strdup(dbus_message_get_sender(message));
 	data->filename = g_strdup(name);

-	session = session_create(source, dest, "OPP", channel, data->sender,
+	session = session_create(source, dest, "OPP", channel, psm, data->sender,
 					pull_session_callback, data);
 	if (session != NULL) {
 		sessions = g_slist_append(sessions, session);
@@ -366,11 +372,12 @@ static DBusMessage *create_session(DBusConnection *connection,
 	struct send_data *data;
 	const char *source = NULL, *dest = NULL, *target = NULL;
 	uint8_t channel = 0;
+	uint16_t psm = 0;

 	dbus_message_iter_init(message, &iter);
 	dbus_message_iter_recurse(&iter, &dict);

-	parse_device_dict(&dict, &source, &dest, &target, &channel);
+	parse_device_dict(&dict, &source, &dest, &target, &channel, &psm);
 	if (dest == NULL || target == NULL)
 		return g_dbus_create_error(message,
 				"org.openobex.Error.InvalidArguments", NULL);
@@ -384,7 +391,7 @@ static DBusMessage *create_session(DBusConnection *connection,
 	data->message = dbus_message_ref(message);
 	data->sender = g_strdup(dbus_message_get_sender(message));

-	session = session_create(source, dest, target, channel, data->sender,
+	session = session_create(source, dest, target, channel, psm, data->sender,
 							create_callback, data);
 	if (session != NULL) {
 		sessions = g_slist_append(sessions, session);
@@ -493,11 +500,12 @@ static DBusMessage *get_capabilities(DBusConnection *connection,
 	struct send_data *data;
 	const char *source = NULL, *dest = NULL, *target = NULL;
 	uint8_t channel = 0;
+	uint16_t psm = 0;

 	dbus_message_iter_init(message, &iter);
 	dbus_message_iter_recurse(&iter, &dict);

-	parse_device_dict(&dict, &source, &dest, &target, &channel);
+	parse_device_dict(&dict, &source, &dest, &target, &channel, &psm);
 	if (dest == NULL)
 		return g_dbus_create_error(message,
 				"org.openobex.Error.InvalidArguments", NULL);
@@ -514,7 +522,7 @@ static DBusMessage *get_capabilities(DBusConnection *connection,
 	if (!target)
 		target = "OPP";

-	session = session_create(source, dest, target, channel, data->sender,
+	session = session_create(source, dest, target, channel, psm, data->sender,
 					capability_session_callback, data);
 	if (session != NULL) {
 		sessions = g_slist_append(sessions, session);
diff --git a/client/session.c b/client/session.c
index 266d00c..7529e84 100644
--- a/client/session.c
+++ b/client/session.c
@@ -39,6 +39,7 @@
 #include <bluetooth/rfcomm.h>
 #include <bluetooth/sdp.h>
 #include <bluetooth/sdp_lib.h>
+#include <bluetooth/l2cap.h>

 #include "log.h"
 #include "pbap.h"
@@ -246,7 +247,7 @@ static void rfcomm_callback(GIOChannel *io, GError *err, gpointer user_data)
 	fd = g_io_channel_unix_get_fd(io);

 	obex = gw_obex_setup_fd(fd, session->target,
-			session->target_len, NULL, NULL);
+			session->target_len, NULL, NULL, OBEX_MT_STREAM);

 	session->obex = obex;

@@ -283,6 +284,70 @@ static GIOChannel *rfcomm_connect(const bdaddr_t *src, const bdaddr_t *dst,
 	return NULL;
 }

+static void l2cap_callback(GIOChannel *io, GError *err, gpointer user_data)
+{
+	struct callback_data *callback = user_data;
+	struct session_data *session = callback->session;
+	GwObex *obex;
+	int fd;
+
+	DBG("");
+
+	if (err != NULL) {
+		error("%s", err->message);
+		goto done;
+	}
+
+	/* do not close when gw_obex is using the fd */
+	g_io_channel_set_close_on_unref(session->io, FALSE);
+	g_io_channel_unref(session->io);
+	session->io = NULL;
+
+	fd = g_io_channel_unix_get_fd(io);
+
+
+	obex = gw_obex_setup_fd(fd, session->target,
+			session->target_len, NULL, NULL,OBEX_MT_SEQPACKET);
+
+	session->obex = obex;
+
+	sessions = g_slist_prepend(sessions, session);
+
+done:
+	callback->func(callback->session, err, callback->data);
+
+	session_unref(callback->session);
+
+	g_free(callback);
+}
+
+
+
+
+static GIOChannel *l2cap_connect(const bdaddr_t *src, const bdaddr_t *dst,
+					uint16_t psm, BtIOConnect function,
+					gpointer user_data)
+{
+	GIOChannel *io;
+	GError *err = NULL;
+	DBG("");
+
+	io = bt_io_connect(BT_IO_L2CAP, function, user_data, NULL, &err,
+				BT_IO_OPT_SOURCE_BDADDR, src,
+				BT_IO_OPT_DEST_BDADDR, dst,
+				BT_IO_OPT_PSM, psm,
+				BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_LOW,
+				BT_IO_OPT_MTU, 32767,
+				BT_IO_OPT_MODE, L2CAP_MODE_ERTM,
+				BT_IO_OPT_INVALID);
+	if (io != NULL)
+		return io;
+
+	error("%s", err->message);
+	g_error_free(err);
+	return NULL;
+}
+
 static void search_callback(uint8_t type, uint16_t status,
 			uint8_t *rsp, size_t size, void *user_data)
 {
@@ -291,6 +356,7 @@ static void search_callback(uint8_t type, uint16_t status,
 	unsigned int scanned, bytesleft = size;
 	int seqlen = 0;
 	uint8_t dataType, channel = 0;
+	uint16_t l2capPsm = 0;
 	GError *gerr = NULL;

 	if (status || type != SDP_SVC_SEARCH_ATTR_RSP)
@@ -305,7 +371,9 @@ static void search_callback(uint8_t type, uint16_t status,
 	do {
 		sdp_record_t *rec;
 		sdp_list_t *protos;
+		sdp_data_t *data;
 		int recsize, ch = -1;
+		int l2psm = -1;

 		recsize = 0;
 		rec = sdp_extract_pdu(rsp, bytesleft, &recsize);
@@ -316,7 +384,11 @@ static void search_callback(uint8_t type, uint16_t status,
 			sdp_record_free(rec);
 			break;
 		}
-
+		data = sdp_data_get(rec, SDP_ATTR_GOEP_L2CAP_PSM);
+		if(data != NULL){
+			l2psm = data->val.uint16;
+			DBG("sdp l2psm is %d,",l2psm);
+		}
 		if (!sdp_get_access_protos(rec, &protos)) {
 			ch = sdp_get_proto_port(protos, RFCOMM_UUID);
 			sdp_list_foreach(protos,
@@ -326,6 +398,11 @@ static void search_callback(uint8_t type, uint16_t status,
 		}

 		sdp_record_free(rec);
+
+		if (l2psm > 0) {
+			l2capPsm = l2psm;
+			break;
+		}

 		if (ch > 0) {
 			channel = ch;
@@ -337,16 +414,28 @@ static void search_callback(uint8_t type, uint16_t status,
 		bytesleft -= recsize;
 	} while (scanned < size && bytesleft > 0);

-	if (channel == 0)
+	if ((l2capPsm == 0)&&(channel == 0))
 		goto failed;

-	session->channel = channel;
+	if(l2capPsm > 0){
+		session->psm = l2capPsm;

-	g_io_channel_set_close_on_unref(session->io, FALSE);
-	g_io_channel_unref(session->io);
+		g_io_channel_set_close_on_unref(session->io, FALSE);
+		g_io_channel_unref(session->io);
+
+		session->io = l2cap_connect(&session->src, &session->dst, l2capPsm,
+						l2cap_callback,	callback);
+	}else{
+
+		session->channel = channel;
+
+		g_io_channel_set_close_on_unref(session->io, FALSE);
+		g_io_channel_unref(session->io);
+
+		session->io = rfcomm_connect(&session->src, &session->dst, channel,
+						rfcomm_callback, callback);
+	}

-	session->io = rfcomm_connect(&session->src, &session->dst, channel,
-					rfcomm_callback, callback);
 	if (session->io != NULL) {
 		sdp_close(callback->sdp);
 		return;
@@ -498,6 +587,7 @@ static struct session_data *session_find(const char *source,
 						const char *destination,
 						const char *service,
 						uint8_t channel,
+						uint16_t psm,
 						const char *owner)
 {
 	GSList *l;
@@ -519,7 +609,8 @@ static struct session_data *session_find(const char *source,
 		if (g_strcmp0(service, session->service))
 			continue;

-		if (channel && session->channel != channel)
+		if ((channel && session->channel != channel)
+			&&(psm && session->psm != psm))
 			continue;

 		if (g_strcmp0(owner, session->owner))
@@ -535,6 +626,7 @@ struct session_data *session_create(const char *source,
 						const char *destination,
 						const char *service,
 						uint8_t channel,
+						uint16_t psm,
 						const char *owner,
 						session_callback_t function,
 						void *user_data)
@@ -546,7 +638,7 @@ struct session_data *session_create(const char *source,
 	if (destination == NULL)
 		return NULL;

-	session = session_find(source, destination, service, channel, owner);
+	session = session_find(source, destination, service, channel, psm, owner);
 	if (session) {
 		session_ref(session);
 		goto proceed;
@@ -558,6 +650,7 @@ struct session_data *session_create(const char *source,

 	session->refcount = 1;
 	session->channel = channel;
+	session->psm = psm;

 	session->conn = dbus_bus_get(DBUS_BUS_SESSION, NULL);
 	if (session->conn == NULL) {
@@ -607,6 +700,12 @@ proceed:
 	if (session->obex) {
 		g_idle_add(connection_complete, callback);
 		err = 0;
+	} else if (session->psm > 0) {
+		session->io = l2cap_connect(&session->src, &session->dst,
+							session->psm,
+							l2cap_callback,
+							callback);
+		err = (session->io == NULL) ? -EINVAL : 0;
 	} else if (session->channel > 0) {
 		session->io = rfcomm_connect(&session->src, &session->dst,
 							session->channel,
diff --git a/client/session.h b/client/session.h
index 6f8a434..24b1ec5 100644
--- a/client/session.h
+++ b/client/session.h
@@ -36,6 +36,7 @@ struct session_data {
 	bdaddr_t src;
 	bdaddr_t dst;
 	uint8_t channel;
+	uint16_t psm;  /* GOEP v2.0 and later supprot OBEX over L2CAP */
 	char *service;		/* Service friendly name */
 	const char *target;	/* OBEX Target UUID */
 	int target_len;
@@ -53,6 +54,10 @@ struct session_data {
 	void *priv;
 };

+#ifndef SDP_ATTR_GOEP_L2CAP_PSM
+#define SDP_ATTR_GOEP_L2CAP_PSM		0x0200
+#endif
+
 typedef void (*session_callback_t) (struct session_data *session,
 					GError *err, void *user_data);

@@ -60,6 +65,7 @@ struct session_data *session_create(const char *source,
 						const char *destination,
 						const char *service,
 						uint8_t channel,
+						uint16_t psm,
 						const char *owner,
 						session_callback_t function,
 						void *user_data);
diff --git a/gwobex/gw-obex.c b/gwobex/gw-obex.c
index 4481212..a566e30 100644
--- a/gwobex/gw-obex.c
+++ b/gwobex/gw-obex.c
@@ -322,11 +322,11 @@ void gw_obex_close(GwObex *ctx) {
 }

 GwObex *gw_obex_setup_fd(int fd, const gchar *uuid, gint uuid_len,
-                         GMainContext *context, gint *error) {
+                         GMainContext *context, gint *error, gint fmt) {
     obex_t *handle;
     GwObex *ctx;

-    if (!gw_obex_transport_setup(fd, &handle)) {
+    if (!gw_obex_transport_setup(fd, &handle, fmt)) {
         debug("gw_obex_open() failed\n");
         if (error)
             *error = GW_OBEX_ERROR_CONNECT_FAILED;
@@ -394,7 +394,7 @@ GwObex *gw_obex_setup_dev(const char *dev, const gchar *uuid, gint uuid_len,
         return NULL;
     }

-    ctx = gw_obex_setup_fd(fd, uuid, uuid_len, context, error);
+    ctx = gw_obex_setup_fd(fd, uuid, uuid_len, context, error, OBEX_MT_STREAM);
     if (ctx == NULL) {
         close(fd);
     }
diff --git a/gwobex/gw-obex.h b/gwobex/gw-obex.h
index c858341..985c85b 100644
--- a/gwobex/gw-obex.h
+++ b/gwobex/gw-obex.h
@@ -183,7 +183,8 @@ GwObex *gw_obex_setup_fd(int fd,
                          const gchar *uuid,
                          gint uuid_len,
                          GMainContext *context,
-                         gint *error);
+                         gint *error,
+                         gint fmt);


 /** Close GW OBEX connection and free all memory associated with it.
diff --git a/gwobex/obex-priv.c b/gwobex/obex-priv.c
index aba7dd7..ba24f8c 100644
--- a/gwobex/obex-priv.c
+++ b/gwobex/obex-priv.c
@@ -612,7 +612,7 @@ void obex_link_error(GwObex *ctx) {
     }
 }

-gboolean gw_obex_transport_setup(int fd, obex_t **handle) {
+gboolean gw_obex_transport_setup(int fd, obex_t **handle, int fmt) {
     *handle = OBEX_Init(OBEX_TRANS_FD, obex_event_handler, 0);
     if (*handle == NULL) {
         debug("OBEX_Init() failed\n");
@@ -621,7 +621,7 @@ gboolean gw_obex_transport_setup(int fd, obex_t **handle) {

     (void) OBEX_SetTransportMTU(*handle, GW_OBEX_RX_MTU, GW_OBEX_TX_MTU);

-    if (FdOBEX_TransportSetup(*handle, fd, fd, 0) < 0) {
+    if (FdOBEX_TransportSetup(*handle, fd, fd, 0, fmt) < 0) {
         debug("FdOBEX_TransportSetup() failed\n");
         OBEX_Cleanup(*handle);
         return FALSE;
diff --git a/gwobex/obex-priv.h b/gwobex/obex-priv.h
index f4e3e5b..66738a4 100644
--- a/gwobex/obex-priv.h
+++ b/gwobex/obex-priv.h
@@ -181,7 +181,7 @@ gboolean gw_obex_connect(GwObex *ctx, const char *target, size_t target_len);

 gboolean gw_obex_disconnect(GwObex *ctx);

-gboolean gw_obex_transport_setup(int fd, obex_t **handle);
+gboolean gw_obex_transport_setup(int fd, obex_t **handle, int fmt);

 gboolean gw_obex_action_op(GwObex *ctx, const gchar *src, const gchar *dst,
                            uint8_t action);
diff --git a/plugins/bluetooth.c b/plugins/bluetooth.c
index 851daa2..d5e1824 100644
--- a/plugins/bluetooth.c
+++ b/plugins/bluetooth.c
@@ -31,6 +31,8 @@

 #include <openobex/obex.h>
 #include <openobex/obex_const.h>
+#include <bluetooth/bluetooth.h>
+#include <bluetooth/l2cap.h>

 #include <glib.h>
 #include <gdbus.h>
@@ -146,6 +148,26 @@ static struct bluetooth_service *find_service(
 	return NULL;
 }

+static struct bluetooth_service *find_service_psm(
+					struct obex_service_driver *driver,
+					uint16_t psm)
+{
+	GSList *l;
+	DBG("");
+	for (l = any->services; l; l = l->next) {
+		struct bluetooth_service *service = l->data;
+
+		if (driver != NULL && service->driver != driver)
+			continue;
+
+		if (psm != 0 && service->driver->psm != psm)
+			continue;
+
+		return service;
+	}
+
+	return NULL;
+}
 static void register_record(struct obex_server *server)
 {
 	const GSList *l;
@@ -175,7 +197,7 @@ static void register_record(struct obex_server *server)
 			continue;

 		xml = g_markup_printf_escaped(driver->record, driver->channel,
-						driver->name);
+						driver->name, driver->psm);
 		add_record(any->path, xml, service);
 		g_free(xml);
 	}
@@ -207,7 +229,8 @@ static void find_adapter_any_reply(DBusPendingCall *call, void *user_data)

 		xml = g_markup_printf_escaped(service->driver->record,
 						service->driver->channel,
-						service->driver->name);
+						service->driver->name,
+						service->driver->psm);
 		add_record(any->path, xml, service);
 		g_free(xml);
 	}
@@ -433,10 +456,14 @@ static int request_service_authorization(struct bluetooth_service *service,

 	if (connection == NULL || any->path == NULL)
 		return -1;
-
-	bt_io_get(io, BT_IO_RFCOMM, &err,
-			BT_IO_OPT_SOURCE, source,
-			BT_IO_OPT_INVALID);
+	if(service->driver->protocol == RFCOMM_OBEX)
+		bt_io_get(io, BT_IO_RFCOMM, &err,
+				BT_IO_OPT_SOURCE, source,
+				BT_IO_OPT_INVALID);
+	else
+		bt_io_get(io, BT_IO_L2CAP, &err,
+				BT_IO_OPT_SOURCE, source,
+				BT_IO_OPT_INVALID);
 	if (err) {
 		error("%s", err->message);
 		g_error_free(err);
@@ -482,6 +509,7 @@ static void confirm_event(GIOChannel *io, void *user_data)
 		error("bluetooth: Unable to find service");
 		goto drop;
 	}
+	service->driver->protocol = RFCOMM_OBEX;

 	if (service->driver->service != OBEX_OPP) {
 		if (request_service_authorization(service, io, address) < 0)
@@ -502,6 +530,50 @@ drop:
 	g_io_channel_shutdown(io, TRUE, NULL);
 }

+static void l2cap_confirm_event(GIOChannel *io, void *user_data)
+{
+	struct bluetooth_service *service;
+	GError *err = NULL;
+	char address[18];
+	uint16_t psm;
+
+	bt_io_get(io, BT_IO_L2CAP, &err,
+			BT_IO_OPT_DEST, address,
+			BT_IO_OPT_PSM, &psm,
+			BT_IO_OPT_INVALID);
+	if (err) {
+		error("%s", err->message);
+		g_error_free(err);
+		goto drop;
+	}
+
+	info("bluetooth: New connection from: %s, psm 0x%x", address,
+			psm);
+
+	service = find_service_psm(NULL, psm);
+	if (service == NULL) {
+		error("bluetooth: Unable to find service");
+		goto drop;
+	}
+	service->driver->protocol = L2CAP_OBEX;
+	if (service->driver->service != OBEX_OPP) {
+		if (request_service_authorization(service, io, address) < 0)
+			goto drop;
+
+		return;
+	}
+
+	if (!bt_io_accept(io, connect_event, service, NULL, &err)) {
+		error("%s", err->message);
+		g_error_free(err);
+		goto drop;
+	}
+
+	return;
+
+drop:
+	g_io_channel_shutdown(io, TRUE, NULL);
+}
 static GIOChannel *start(struct obex_server *server,
 				struct obex_service_driver *service,
 				BtIOSecLevel sec_level)
@@ -524,6 +596,28 @@ static GIOChannel *start(struct obex_server *server,
 	return io;
 }

+static GIOChannel *start_l2cap(struct obex_server *server,
+				struct obex_service_driver *service,
+				BtIOSecLevel sec_level)
+{
+	GIOChannel *io;
+	GError *err = NULL;
+	io = bt_io_listen(BT_IO_L2CAP, NULL, l2cap_confirm_event,
+				server, NULL, &err,
+				BT_IO_OPT_PSM, service->psm,
+				BT_IO_OPT_SEC_LEVEL, sec_level,
+				BT_IO_OPT_MTU, 32767,
+				BT_IO_OPT_MODE, L2CAP_MODE_ERTM,
+				BT_IO_OPT_INVALID);
+	if (io == NULL) {
+		error("bluetooth: unable to listen in psm 0x%x: %s",
+				service->psm, err->message);
+		g_error_free(err);
+	} else
+		DBG("listening on psm 0x%x", service->psm);
+
+	return io;
+}
 static void *bluetooth_start(struct obex_server *server, int *err)
 {
 	BtIOSecLevel sec_level;
@@ -544,6 +638,12 @@ static void *bluetooth_start(struct obex_server *server, int *err)
 			continue;

 		ios = g_slist_prepend(ios, io);
+
+		io = start_l2cap(server, service, sec_level);
+		if (io == NULL)
+			continue;
+
+		ios = g_slist_prepend(ios, io);
 	}

 	register_record(server);
diff --git a/plugins/ftp.c b/plugins/ftp.c
index 79223bf..c057fae 100644
--- a/plugins/ftp.c
+++ b/plugins/ftp.c
@@ -56,6 +56,7 @@
 #define CAP_TYPE "x-obex/capability"

 #define FTP_CHANNEL 10
+#define FTP_PSM 	0x1015
 #define FTP_RECORD "<?xml version=\"1.0\" encoding=\"UTF-8\" ?>		\
 <record>								\
   <attribute id=\"0x0001\">						\
@@ -83,7 +84,7 @@
     <sequence>								\
       <sequence>							\
         <uuid value=\"0x1106\"/>					\
-        <uint16 value=\"0x0100\" name=\"version\"/>			\
+        <uint16 value=\"0x0102\" name=\"version\"/>			\
       </sequence>							\
     </sequence>								\
   </attribute>								\
@@ -91,6 +92,10 @@
   <attribute id=\"0x0100\">						\
     <text value=\"%s\" name=\"name\"/>					\
   </attribute>								\
+  	  	  	  	  	  	  	  	  	 \
+  <attribute id=\"0x0200\">						\
+ 	<uint16 value=\"%u\" name=\"psm\"/>         		\
+  </attribute>     							\
 </record>"

 #define PCSUITE_CHANNEL 24
@@ -419,6 +424,7 @@ static struct obex_service_driver ftp = {
 	.name = "File Transfer server",
 	.service = OBEX_FTP,
 	.channel = FTP_CHANNEL,
+	.psm = FTP_PSM,
 	.record = FTP_RECORD,
 	.target = FTP_TARGET,
 	.target_size = TARGET_SIZE,
diff --git a/plugins/opp.c b/plugins/opp.c
index 17c4356..6fa71c3 100644
--- a/plugins/opp.c
+++ b/plugins/opp.c
@@ -44,6 +44,7 @@
 #define VCARD_FILE CONFIGDIR "/vcard.vcf"

 #define OPP_CHANNEL	9
+#define OPP_PSM		0x1009
 #define OPP_RECORD "<?xml version=\"1.0\" encoding=\"UTF-8\" ?>	\
 <record>							\
   <attribute id=\"0x0001\">					\
@@ -71,7 +72,7 @@
     <sequence>							\
       <sequence>						\
         <uuid value=\"0x1105\"/>				\
-        <uint16 value=\"0x0100\" name=\"version\"/>		\
+        <uint16 value=\"0x0102\" name=\"version\"/>		\
       </sequence>						\
     </sequence>							\
   </attribute>							\
@@ -91,6 +92,10 @@
       <uint8 value=\"0xff\"/>					\
     </sequence>							\
   </attribute>							\
+    	  	  	  	  	  	  	  	  	 \
+  <attribute id=\"0x0200\">						\
+ 	<uint16 value=\"%u\" name=\"psm\"/>         		\
+  </attribute>							\
 </record>"

 static void *opp_connect(struct obex_session *os, int *err)
@@ -210,6 +215,7 @@ static struct obex_service_driver driver = {
 	.name = "Object Push server",
 	.service = OBEX_OPP,
 	.channel = OPP_CHANNEL,
+	.psm = OPP_PSM,
 	.record = OPP_RECORD,
 	.connect = opp_connect,
 	.progress = opp_progress,
diff --git a/src/obex.c b/src/obex.c
index caba2fb..5f6cf60 100644
--- a/src/obex.c
+++ b/src/obex.c
@@ -1283,11 +1283,13 @@ int obex_session_start(GIOChannel *io, uint16_t tx_mtu, uint16_t rx_mtu,
 	struct obex_session *os;
 	obex_t *obex;
 	int ret, fd;
+	int fmt = OBEX_MT_STREAM;

 	os = g_new0(struct obex_session, 1);

-	os->service = obex_service_driver_find(server->drivers, NULL,
-							0, NULL, 0);
+	//os->service = obex_service_driver_find(server->drivers, NULL,
+		//					0, NULL, 0);
+	os->service = server->drivers->data;
 	os->server = server;
 	os->rx_mtu = rx_mtu != 0 ? rx_mtu : DEFAULT_RX_MTU;
 	os->tx_mtu = tx_mtu != 0 ? tx_mtu : DEFAULT_TX_MTU;
@@ -1306,7 +1308,9 @@ int obex_session_start(GIOChannel *io, uint16_t tx_mtu, uint16_t rx_mtu,

 	fd = g_io_channel_unix_get_fd(io);

-	ret = FdOBEX_TransportSetup(obex, fd, fd, 0);
+	if(os->service->protocol == L2CAP_OBEX)
+		fmt = OBEX_MT_SEQPACKET;
+	ret = FdOBEX_TransportSetup(obex, fd, fd, 0, fmt);
 	if (ret < 0) {
 		obex_session_free(os);
 		OBEX_Cleanup(obex);
diff --git a/src/service.h b/src/service.h
index a844885..f45b573 100644
--- a/src/service.h
+++ b/src/service.h
@@ -20,11 +20,18 @@
  *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
  *
  */
+typedef enum Obex_Protocol {
+	RFCOMM_OBEX,
+	L2CAP_OBEX
+};
+

 struct obex_service_driver {
 	const char *name;
 	uint16_t service;
 	uint8_t channel;
+	uint16_t psm;
+	enum Obex_Protocol protocol;
 	const uint8_t *target;
 	unsigned int target_size;
 	const uint8_t *who;
diff --git a/test/main.c b/test/main.c
index 37b307c..b29ebf0 100644
--- a/test/main.c
+++ b/test/main.c
@@ -256,7 +256,7 @@ int main(int argc, char *argv[])
 		exit(1);
 	}

-	obex = gw_obex_setup_fd(sk, target, target_len, NULL, &error);
+	obex = gw_obex_setup_fd(sk, target, target_len, NULL, &error, OBEX_MT_STREAM);
 	if (obex == NULL) {
 		fprintf(stderr, "Failed to create OBEX session\n");
 		close(sk);
--
1.7.1

