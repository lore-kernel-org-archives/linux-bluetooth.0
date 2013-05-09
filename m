Return-Path: <cyrus@holtmann.org>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH BlueZ 06/26] obexd: Get rid of guint* types
Date: Thu,  9 May 2013 01:16:36 -0300
Message-Id: <1368073016-28434-6-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1368073016-28434-1-git-send-email-lucas.demarchi@profusion.mobi>
References: <1368073016-28434-1-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

guint -> unsigned int
guint8 -> uint8_t
guint16 -> uint16_t
guint32 -> uint32_t
guint64 -> uint64_t

Add "#include <inttypes.h>" where appropriate.
---
 obexd/client/bluetooth.c        | 15 ++++++++-------
 obexd/client/ftp.c              |  3 ++-
 obexd/client/map.c              | 21 +++++++++++----------
 obexd/client/pbap.c             | 25 +++++++++++++------------
 obexd/client/session.c          | 31 ++++++++++++++++---------------
 obexd/client/session.h          | 15 ++++++++-------
 obexd/client/transfer.c         | 16 ++++++++--------
 obexd/client/transfer.h         |  2 +-
 obexd/client/transport.h        |  8 +++++---
 obexd/plugins/irmc.c            |  2 +-
 obexd/plugins/phonebook-dummy.c |  7 ++++---
 obexd/src/main.c                |  7 ++++---
 obexd/src/obex-priv.h           |  4 +++-
 obexd/src/obex.c                | 18 +++++++++---------
 14 files changed, 93 insertions(+), 81 deletions(-)

diff --git a/obexd/client/bluetooth.c b/obexd/client/bluetooth.c
index 1f407d1..6e6e3ec 100644
--- a/obexd/client/bluetooth.c
+++ b/obexd/client/bluetooth.c
@@ -47,7 +47,7 @@
 #define OBC_BT_ERROR obc_bt_error_quark()
 
 struct bluetooth_session {
-	guint id;
+	unsigned int id;
 	bdaddr_t src;
 	bdaddr_t dst;
 	uint16_t port;
@@ -385,12 +385,13 @@ static int session_connect(struct bluetooth_session *session)
 	return err;
 }
 
-static guint bluetooth_connect(const char *source, const char *destination,
-				const char *service, uint16_t port,
-				obc_transport_func func, void *user_data)
+static unsigned int bluetooth_connect(const char *source,
+				const char *destination, const char *service,
+				uint16_t port, obc_transport_func func,
+				void *user_data)
 {
 	struct bluetooth_session *session;
-	static guint id = 0;
+	static unsigned int id = 0;
 
 	DBG("src %s dest %s service %s port %u",
 				source, destination, service, port);
@@ -421,7 +422,7 @@ static guint bluetooth_connect(const char *source, const char *destination,
 	return session->id;
 }
 
-static void bluetooth_disconnect(guint id)
+static void bluetooth_disconnect(unsigned int id)
 {
 	GSList *l;
 
@@ -467,7 +468,7 @@ static int bluetooth_getpacketopt(GIOChannel *io, int *tx_mtu, int *rx_mtu)
 	return 0;
 }
 
-static const void *bluetooth_getattribute(guint id, int attribute_id)
+static const void *bluetooth_getattribute(unsigned int id, int attribute_id)
 {
 	GSList *l;
 	sdp_data_t *data;
diff --git a/obexd/client/ftp.c b/obexd/client/ftp.c
index fa85708..af39653 100644
--- a/obexd/client/ftp.c
+++ b/obexd/client/ftp.c
@@ -25,6 +25,7 @@
 #include <config.h>
 #endif
 
+#include <inttypes.h>
 #include <errno.h>
 #include <string.h>
 
@@ -124,7 +125,7 @@ static void xml_element(GMarkupParseContext *ctxt,
 	for (key = (char *) names[i]; key; key = (char *) names[++i]) {
 		key[0] = g_ascii_toupper(key[0]);
 		if (g_str_equal("Size", key) == TRUE) {
-			guint64 size;
+			uint64_t size;
 			size = g_ascii_strtoll(values[i], NULL, 10);
 			obex_dbus_dict_append(&dict, key, DBUS_TYPE_UINT64,
 								&size);
diff --git a/obexd/client/map.c b/obexd/client/map.c
index 0285286..ae65bb3 100644
--- a/obexd/client/map.c
+++ b/obexd/client/map.c
@@ -24,6 +24,7 @@
 #include <config.h>
 #endif
 
+#include <inttypes.h>
 #include <errno.h>
 #include <string.h>
 #include <stdio.h>
@@ -291,7 +292,7 @@ fail:
 
 static GObexApparam *parse_offset(GObexApparam *apparam, DBusMessageIter *iter)
 {
-	guint16 num;
+	uint16_t num;
 
 	if (dbus_message_iter_get_arg_type(iter) != DBUS_TYPE_UINT16)
 		return NULL;
@@ -304,7 +305,7 @@ static GObexApparam *parse_offset(GObexApparam *apparam, DBusMessageIter *iter)
 static GObexApparam *parse_max_count(GObexApparam *apparam,
 							DBusMessageIter *iter)
 {
-	guint16 num;
+	uint16_t num;
 
 	if (dbus_message_iter_get_arg_type(iter) != DBUS_TYPE_UINT16)
 		return NULL;
@@ -1123,7 +1124,7 @@ fail:
 static GObexApparam *parse_subject_length(GObexApparam *apparam,
 							DBusMessageIter *iter)
 {
-	guint8 num;
+	uint8_t num;
 
 	if (dbus_message_iter_get_arg_type(iter) != DBUS_TYPE_BYTE)
 		return NULL;
@@ -1150,9 +1151,9 @@ static uint64_t get_filter_mask(const char *filterstr)
 	return 0;
 }
 
-static int set_field(guint32 *filter, const char *filterstr)
+static int set_field(uint32_t *filter, const char *filterstr)
 {
-	guint64 mask;
+	uint64_t mask;
 
 	mask = get_filter_mask(filterstr);
 
@@ -1166,7 +1167,7 @@ static int set_field(guint32 *filter, const char *filterstr)
 static GObexApparam *parse_fields(GObexApparam *apparam, DBusMessageIter *iter)
 {
 	DBusMessageIter array;
-	guint32 filter = 0;
+	uint32_t filter = 0;
 
 	if (dbus_message_iter_get_arg_type(iter) != DBUS_TYPE_ARRAY)
 		return NULL;
@@ -1192,7 +1193,7 @@ static GObexApparam *parse_filter_type(GObexApparam *apparam,
 							DBusMessageIter *iter)
 {
 	DBusMessageIter array;
-	guint8 types = 0;
+	uint8_t types = 0;
 
 	if (dbus_message_iter_get_arg_type(iter) != DBUS_TYPE_ARRAY)
 		return NULL;
@@ -1251,7 +1252,7 @@ static GObexApparam *parse_period_end(GObexApparam *apparam,
 static GObexApparam *parse_filter_read(GObexApparam *apparam,
 							DBusMessageIter *iter)
 {
-	guint8 status = FILTER_READ_STATUS_NONE;
+	uint8_t status = FILTER_READ_STATUS_NONE;
 	dbus_bool_t dbus_status = FALSE;
 
 	if (dbus_message_iter_get_arg_type(iter) != DBUS_TYPE_BOOLEAN)
@@ -1299,7 +1300,7 @@ static GObexApparam *parse_filter_sender(GObexApparam *apparam,
 static GObexApparam *parse_filter_priority(GObexApparam *apparam,
 							DBusMessageIter *iter)
 {
-	guint8 priority = FILTER_PRIORITY_NONE;
+	uint8_t priority = FILTER_PRIORITY_NONE;
 	dbus_bool_t dbus_priority = FALSE;
 
 	if (dbus_message_iter_get_arg_type(iter) != DBUS_TYPE_BOOLEAN)
@@ -1560,7 +1561,7 @@ static GObexApparam *parse_retry(GObexApparam *apparam, DBusMessageIter *iter)
 
 static GObexApparam *parse_charset(GObexApparam *apparam, DBusMessageIter *iter)
 {
-	guint8 charset = 0;
+	uint8_t charset = 0;
 	const char *string;
 
 	if (dbus_message_iter_get_arg_type(iter) != DBUS_TYPE_STRING)
diff --git a/obexd/client/pbap.c b/obexd/client/pbap.c
index 2089860..5aa8da9 100644
--- a/obexd/client/pbap.c
+++ b/obexd/client/pbap.c
@@ -26,6 +26,7 @@
 #include <config.h>
 #endif
 
+#include <inttypes.h>
 #include <errno.h>
 #include <string.h>
 #include <stdio.h>
@@ -247,7 +248,7 @@ static void pbap_setpath_cb(struct obc_session *session,
 }
 
 static void read_return_apparam(struct obc_transfer *transfer,
-				guint16 *phone_book_size, guint8 *new_missed_calls)
+			uint16_t *phone_book_size, uint8_t *new_missed_calls)
 {
 	GObexApparam *apparam;
 
@@ -270,8 +271,8 @@ static void phonebook_size_callback(struct obc_session *session,
 {
 	struct pending_request *request = user_data;
 	DBusMessage *reply;
-	guint16 phone_book_size;
-	guint8 new_missed_calls;
+	uint16_t phone_book_size;
+	uint8_t new_missed_calls;
 
 	if (err) {
 		reply = g_dbus_create_error(request->msg,
@@ -342,7 +343,7 @@ send:
 static GObexApparam *parse_format(GObexApparam *apparam, DBusMessageIter *iter)
 {
 	const char *string;
-	guint8 format;
+	uint8_t format;
 
 	if (dbus_message_iter_get_arg_type(iter) != DBUS_TYPE_STRING)
 		return NULL;
@@ -364,7 +365,7 @@ static GObexApparam *parse_format(GObexApparam *apparam, DBusMessageIter *iter)
 static GObexApparam *parse_order(GObexApparam *apparam, DBusMessageIter *iter)
 {
 	const char *string;
-	guint8 order;
+	uint8_t order;
 
 	if (dbus_message_iter_get_arg_type(iter) != DBUS_TYPE_STRING)
 		return NULL;
@@ -387,7 +388,7 @@ static GObexApparam *parse_order(GObexApparam *apparam, DBusMessageIter *iter)
 
 static GObexApparam *parse_offset(GObexApparam *apparam, DBusMessageIter *iter)
 {
-	guint16 num;
+	uint16_t num;
 
 	if (dbus_message_iter_get_arg_type(iter) != DBUS_TYPE_UINT16)
 		return NULL;
@@ -400,7 +401,7 @@ static GObexApparam *parse_offset(GObexApparam *apparam, DBusMessageIter *iter)
 static GObexApparam *parse_max_count(GObexApparam *apparam,
 							DBusMessageIter *iter)
 {
-	guint16 num;
+	uint16_t num;
 
 	if (dbus_message_iter_get_arg_type(iter) != DBUS_TYPE_UINT16)
 		return NULL;
@@ -435,9 +436,9 @@ static uint64_t get_filter_mask(const char *filterstr)
 		return 0;
 }
 
-static int set_field(guint64 *filter, const char *filterstr)
+static int set_field(uint64_t *filter, const char *filterstr)
 {
-	guint64 mask;
+	uint64_t mask;
 
 	mask = get_filter_mask(filterstr);
 
@@ -451,7 +452,7 @@ static int set_field(guint64 *filter, const char *filterstr)
 static GObexApparam *parse_fields(GObexApparam *apparam, DBusMessageIter *iter)
 {
 	DBusMessageIter array;
-	guint64 filter = 0;
+	uint64_t filter = 0;
 
 	if (dbus_message_iter_get_arg_type(iter) != DBUS_TYPE_ARRAY)
 		return NULL;
@@ -517,7 +518,7 @@ static GObexApparam *parse_filters(GObexApparam *apparam,
 
 static DBusMessage *pull_phonebook(struct pbap_data *pbap,
 						DBusMessage *message,
-						guint8 type,
+						uint8_t type,
 						const char *targetfile,
 						GObexApparam *apparam)
 {
@@ -790,7 +791,7 @@ static DBusMessage *pbap_list(DBusConnection *connection,
 
 static GObexApparam *parse_attribute(GObexApparam *apparam, const char *field)
 {
-	guint8 attrib;
+	uint8_t attrib;
 
 	if (!field || g_str_equal(field, ""))
 		attrib = ATTRIB_NAME;
diff --git a/obexd/client/session.c b/obexd/client/session.c
index 0fbfe41..daa49db 100644
--- a/obexd/client/session.c
+++ b/obexd/client/session.c
@@ -26,6 +26,7 @@
 #include <config.h>
 #endif
 
+#include <inttypes.h>
 #include <stdlib.h>
 #include <stdio.h>
 #include <errno.h>
@@ -57,7 +58,7 @@ enum {
 	OBEX_IO_BUSY,
 };
 
-static guint64 counter = 0;
+static uint64_t counter = 0;
 
 struct callback_data {
 	struct obc_session *session;
@@ -66,8 +67,8 @@ struct callback_data {
 };
 
 struct pending_request {
-	guint id;
-	guint req_id;
+	unsigned int id;
+	unsigned int req_id;
 	struct obc_session *session;
 	struct obc_transfer *transfer;
 	session_callback_t func;
@@ -82,7 +83,7 @@ struct setpath_data {
 };
 
 struct obc_session {
-	guint id;
+	unsigned int id;
 	int refcount;
 	char *source;
 	char *destination;
@@ -94,9 +95,9 @@ struct obc_session {
 	GObex *obex;
 	struct pending_request *p;
 	char *owner;		/* Session owner */
-	guint watch;
+	unsigned int watch;
 	GQueue *queue;
-	guint queue_complete_id;
+	unsigned int queue_complete_id;
 };
 
 static GSList *sessions = NULL;
@@ -145,7 +146,7 @@ static struct pending_request *pending_request_new(struct obc_session *session,
 						void *data)
 {
 	struct pending_request *p;
-	static guint id = 0;
+	static unsigned int id = 0;
 
 	p = g_new0(struct pending_request, 1);
 	p->id = ++id;
@@ -656,7 +657,7 @@ static gboolean session_queue_complete(gpointer data)
 	return FALSE;
 }
 
-guint obc_session_queue(struct obc_session *session,
+unsigned int obc_session_queue(struct obc_session *session,
 				struct obc_transfer *transfer,
 				session_callback_t func, void *user_data,
 				GError **err)
@@ -881,7 +882,7 @@ static void setpath_cb(GObex *obex, GError *err, GObexPacket *rsp,
 	struct pending_request *p = user_data;
 	struct setpath_data *data = p->data;
 	char *next;
-	guint8 code;
+	uint8_t code;
 
 	p->req_id = 0;
 
@@ -918,7 +919,7 @@ static void setpath_cb(GObex *obex, GError *err, GObexPacket *rsp,
 	}
 }
 
-guint obc_session_setpath(struct obc_session *session, const char *path,
+unsigned int obc_session_setpath(struct obc_session *session, const char *path,
 				session_callback_t func, void *user_data,
 				GError **err)
 {
@@ -1000,7 +1001,7 @@ done:
 	session_process_queue(session);
 }
 
-guint obc_session_mkdir(struct obc_session *session, const char *folder,
+unsigned int obc_session_mkdir(struct obc_session *session, const char *folder,
 				session_callback_t func, void *user_data,
 				GError **err)
 {
@@ -1030,7 +1031,7 @@ guint obc_session_mkdir(struct obc_session *session, const char *folder,
 	return p->id;
 }
 
-guint obc_session_copy(struct obc_session *session, const char *srcname,
+unsigned int obc_session_copy(struct obc_session *session, const char *srcname,
 				const char *destname, session_callback_t func,
 				void *user_data, GError **err)
 {
@@ -1060,7 +1061,7 @@ guint obc_session_copy(struct obc_session *session, const char *srcname,
 	return p->id;
 }
 
-guint obc_session_move(struct obc_session *session, const char *srcname,
+unsigned int obc_session_move(struct obc_session *session, const char *srcname,
 				const char *destname, session_callback_t func,
 				void *user_data, GError **err)
 {
@@ -1090,7 +1091,7 @@ guint obc_session_move(struct obc_session *session, const char *srcname,
 	return p->id;
 }
 
-guint obc_session_delete(struct obc_session *session, const char *file,
+unsigned int obc_session_delete(struct obc_session *session, const char *file,
 				session_callback_t func, void *user_data,
 				GError **err)
 {
@@ -1119,7 +1120,7 @@ guint obc_session_delete(struct obc_session *session, const char *file,
 	return p->id;
 }
 
-void obc_session_cancel(struct obc_session *session, guint id,
+void obc_session_cancel(struct obc_session *session, unsigned int id,
 							gboolean remove)
 {
 	struct pending_request *p = session->p;
diff --git a/obexd/client/session.h b/obexd/client/session.h
index b0b3655..22a4987 100644
--- a/obexd/client/session.h
+++ b/obexd/client/session.h
@@ -22,6 +22,7 @@
  *
  */
 
+#include <inttypes.h>
 #include <stdint.h>
 #include <glib.h>
 #include <gdbus/gdbus.h>
@@ -57,24 +58,24 @@ const char *obc_session_register(struct obc_session *session,
 const void *obc_session_get_attribute(struct obc_session *session,
 							int attribute_id);
 
-guint obc_session_queue(struct obc_session *session,
+unsigned int obc_session_queue(struct obc_session *session,
 				struct obc_transfer *transfer,
 				session_callback_t func, void *user_data,
 				GError **err);
-guint obc_session_setpath(struct obc_session *session, const char *path,
+unsigned int obc_session_setpath(struct obc_session *session, const char *path,
 				session_callback_t func, void *user_data,
 				GError **err);
-guint obc_session_mkdir(struct obc_session *session, const char *folder,
+unsigned int obc_session_mkdir(struct obc_session *session, const char *folder,
 				session_callback_t func, void *user_data,
 				GError **err);
-guint obc_session_copy(struct obc_session *session, const char *srcname,
+unsigned int obc_session_copy(struct obc_session *session, const char *srcname,
 				const char *destname, session_callback_t func,
 				void *user_data, GError **err);
-guint obc_session_move(struct obc_session *session, const char *srcname,
+unsigned int obc_session_move(struct obc_session *session, const char *srcname,
 				const char *destname, session_callback_t func,
 				void *user_data, GError **err);
-guint obc_session_delete(struct obc_session *session, const char *file,
+unsigned int obc_session_delete(struct obc_session *session, const char *file,
 				session_callback_t func, void *user_data,
 				GError **err);
-void obc_session_cancel(struct obc_session *session, guint id,
+void obc_session_cancel(struct obc_session *session, unsigned int id,
 							gboolean remove);
diff --git a/obexd/client/transfer.c b/obexd/client/transfer.c
index ac0909d..7ab3473 100644
--- a/obexd/client/transfer.c
+++ b/obexd/client/transfer.c
@@ -50,7 +50,7 @@
 
 #define FIRST_PACKET_TIMEOUT 60
 
-static guint64 counter = 0;
+static uint64_t counter = 0;
 
 struct transfer_callback {
 	transfer_callback_t func;
@@ -68,7 +68,7 @@ struct obc_transfer {
 	GObex *obex;
 	uint8_t status;
 	GObexApparam *apparam;
-	guint8 op;
+	uint8_t op;
 	struct transfer_callback *callback;
 	DBusConnection *conn;
 	DBusMessage *msg;
@@ -79,11 +79,11 @@ struct obc_transfer {
 	char *name;		/* Transfer object name */
 	char *type;		/* Transfer object type */
 	int fd;
-	guint xfer;
+	unsigned int xfer;
 	int64_t size;
 	int64_t transferred;
 	int64_t progress;
-	guint progress_id;
+	unsigned int progress_id;
 };
 
 static GQuark obc_transfer_error_quark(void)
@@ -356,7 +356,7 @@ static void obc_transfer_free(struct obc_transfer *transfer)
 	g_free(transfer);
 }
 
-static struct obc_transfer *obc_transfer_create(guint8 op,
+static struct obc_transfer *obc_transfer_create(uint8_t op,
 						const char *filename,
 						const char *name,
 						const char *type)
@@ -584,9 +584,9 @@ static void get_xfer_progress_first(GObex *obex, GError *err, GObexPacket *rsp,
 	GObexPacket *req;
 	GObexHeader *hdr;
 	GObexApparam *apparam;
-	const guint8 *buf;
+	const uint8_t *buf;
 	gsize len;
-	guint8 rspcode;
+	uint8_t rspcode;
 	gboolean final;
 
 	if (err != NULL) {
@@ -788,7 +788,7 @@ gboolean obc_transfer_start(struct obc_transfer *transfer, void *obex,
 	return FALSE;
 }
 
-guint8 obc_transfer_get_operation(struct obc_transfer *transfer)
+uint8_t obc_transfer_get_operation(struct obc_transfer *transfer)
 {
 	return transfer->op;
 }
diff --git a/obexd/client/transfer.h b/obexd/client/transfer.h
index 474900b..fb9e6dc 100644
--- a/obexd/client/transfer.h
+++ b/obexd/client/transfer.h
@@ -53,7 +53,7 @@ gboolean obc_transfer_set_callback(struct obc_transfer *transfer,
 
 gboolean obc_transfer_start(struct obc_transfer *transfer, void *obex,
 								GError **err);
-guint8 obc_transfer_get_operation(struct obc_transfer *transfer);
+uint8_t obc_transfer_get_operation(struct obc_transfer *transfer);
 
 void obc_transfer_set_apparam(struct obc_transfer *transfer, void *data);
 void *obc_transfer_get_apparam(struct obc_transfer *transfer);
diff --git a/obexd/client/transport.h b/obexd/client/transport.h
index b035cfc..becb0fe 100644
--- a/obexd/client/transport.h
+++ b/obexd/client/transport.h
@@ -21,17 +21,19 @@
  *
  */
 
+#include <inttypes.h>
+
 typedef void (*obc_transport_func)(GIOChannel *io, GError *err,
 							gpointer user_data);
 
 struct obc_transport {
 	const char *name;
-	guint (*connect) (const char *source, const char *destination,
+	unsigned int (*connect) (const char *source, const char *destination,
 				const char *service, uint16_t port,
 				obc_transport_func func, void *user_data);
 	int (*getpacketopt) (GIOChannel *io, int *tx_mtu, int *rx_mtu);
-	void (*disconnect) (guint id);
-	const void *(*getattribute) (guint id, int attribute_id);
+	void (*disconnect) (unsigned int id);
+	const void *(*getattribute) (unsigned int id, int attribute_id);
 };
 
 int obc_transport_register(struct obc_transport *transport);
diff --git a/obexd/plugins/irmc.c b/obexd/plugins/irmc.c
index d343977..6407de2 100644
--- a/obexd/plugins/irmc.c
+++ b/obexd/plugins/irmc.c
@@ -68,7 +68,7 @@ struct irmc_session {
 
 #define IRMC_TARGET_SIZE 9
 
-static const guint8 IRMC_TARGET[IRMC_TARGET_SIZE] = {
+static const uint8_t IRMC_TARGET[IRMC_TARGET_SIZE] = {
 			0x49, 0x52, 0x4d, 0x43,  0x2d, 0x53, 0x59, 0x4e, 0x43 };
 
 /* FIXME:
diff --git a/obexd/plugins/phonebook-dummy.c b/obexd/plugins/phonebook-dummy.c
index 6b9d040..aa9ba18 100644
--- a/obexd/plugins/phonebook-dummy.c
+++ b/obexd/plugins/phonebook-dummy.c
@@ -26,6 +26,7 @@
 #include <config.h>
 #endif
 
+#include <inttypes.h>
 #include <dirent.h>
 #include <errno.h>
 #include <stdio.h>
@@ -52,7 +53,7 @@ struct dummy_data {
 	const struct apparam_field *apparams;
 	char *folder;
 	int fd;
-	guint id;
+	unsigned int id;
 };
 
 struct cache_query {
@@ -520,7 +521,7 @@ void *phonebook_get_entry(const char *folder, const char *id,
 	struct dummy_data *dummy;
 	char *filename;
 	int fd;
-	guint ret;
+	unsigned int ret;
 
 	filename = g_build_filename(root_folder, folder, id, NULL);
 
@@ -553,7 +554,7 @@ void *phonebook_create_cache(const char *name, phonebook_entry_cb entry_cb,
 	struct cache_query *query;
 	char *foldername;
 	DIR *dp;
-	guint ret;
+	unsigned int ret;
 
 	foldername = g_build_filename(root_folder, name, NULL);
 	dp = opendir(foldername);
diff --git a/obexd/src/main.c b/obexd/src/main.c
index 61a06b2..ae7c73c 100644
--- a/obexd/src/main.c
+++ b/obexd/src/main.c
@@ -25,6 +25,7 @@
 #include <config.h>
 #endif
 
+#include <inttypes.h>
 #include <stdio.h>
 #include <errno.h>
 #include <unistd.h>
@@ -91,10 +92,10 @@ static gboolean signal_handler(GIOChannel *channel, GIOCondition cond,
 	return TRUE;
 }
 
-static guint setup_signalfd(void)
+static unsigned int setup_signalfd(void)
 {
 	GIOChannel *channel;
-	guint source;
+	unsigned int source;
 	sigset_t mask;
 	int fd;
 
@@ -244,7 +245,7 @@ int main(int argc, char *argv[])
 {
 	GOptionContext *context;
 	GError *err = NULL;
-	guint signal;
+	unsigned int signal;
 
 #ifdef NEED_THREADS
 	if (g_thread_supported() == FALSE)
diff --git a/obexd/src/obex-priv.h b/obexd/src/obex-priv.h
index 41854bc..aba3564 100644
--- a/obexd/src/obex-priv.h
+++ b/obexd/src/obex-priv.h
@@ -22,6 +22,8 @@
  *
  */
 
+#include <inttypes.h>
+
 struct obex_session {
 	GIOChannel *io;
 	uint32_t id;
@@ -36,7 +38,7 @@ struct obex_session {
 	size_t apparam_len;
 	const void *nonhdr;
 	size_t nonhdr_len;
-	guint get_rsp;
+	unsigned int get_rsp;
 	uint8_t *buf;
 	int64_t pending;
 	int64_t offset;
diff --git a/obexd/src/obex.c b/obexd/src/obex.c
index a3e7b0e..ec91733 100644
--- a/obexd/src/obex.c
+++ b/obexd/src/obex.c
@@ -352,7 +352,7 @@ static uint8_t *challenge_response(const uint8_t *nonce)
 static void parse_service(struct obex_session *os, GObexPacket *req)
 {
 	GObexHeader *hdr;
-	const guint8 *target = NULL, *who = NULL;
+	const uint8_t *target = NULL, *who = NULL;
 	gsize target_size = 0, who_size = 0;
 
 	hdr = g_obex_packet_get_header(req, G_OBEX_HDR_WHO);
@@ -378,7 +378,7 @@ static void parse_authchal(struct obex_session *session, GObexPacket *req,
 							GObexPacket *rsp)
 {
 	GObexHeader *hdr;
-	const guint8 *data, *nonce = NULL;
+	const uint8_t *data, *nonce = NULL;
 	gsize len;
 	uint8_t challenge[18];
 	struct auth_header *auth = (struct auth_header *) challenge;
@@ -561,8 +561,8 @@ static int driver_get_headers(struct obex_session *os)
 {
 	GObexPacket *rsp;
 	gssize len;
-	guint8 data[255];
-	guint8 id;
+	uint8_t data[255];
+	uint8_t id;
 	GObexHeader *hdr;
 
 	DBG("name=%s type=%s object=%p", os->name, os->type, os->object);
@@ -687,7 +687,7 @@ static gboolean recv_data(const void *buf, gsize size, gpointer user_data)
 static void parse_type(struct obex_session *os, GObexPacket *req)
 {
 	GObexHeader *hdr;
-	const guint8 *type;
+	const uint8_t *type;
 	gsize len;
 
 	g_free(os->type);
@@ -737,7 +737,7 @@ static void parse_name(struct obex_session *os, GObexPacket *req)
 static void parse_apparam(struct obex_session *os, GObexPacket *req)
 {
 	GObexHeader *hdr;
-	const guint8 *apparam;
+	const uint8_t *apparam;
 	gsize len;
 
 	hdr = g_obex_packet_get_header(req, G_OBEX_HDR_APPARAM);
@@ -876,7 +876,7 @@ int obex_put_stream_start(struct obex_session *os, const char *filename)
 static void parse_length(struct obex_session *os, GObexPacket *req)
 {
 	GObexHeader *hdr;
-	guint32 size;
+	uint32_t size;
 
 	hdr = g_obex_packet_get_header(req, G_OBEX_HDR_LENGTH);
 	if (hdr == NULL)
@@ -892,7 +892,7 @@ static void parse_length(struct obex_session *os, GObexPacket *req)
 static void parse_time(struct obex_session *os, GObexPacket *req)
 {
 	GObexHeader *hdr;
-	const guint8 *time;
+	const uint8_t *time;
 	gsize len;
 
 	hdr = g_obex_packet_get_header(req, G_OBEX_HDR_TIME);
@@ -1009,7 +1009,7 @@ static void parse_destname(struct obex_session *os, GObexPacket *req)
 static void parse_action(struct obex_session *os, GObexPacket *req)
 {
 	GObexHeader *hdr;
-	guint8 id;
+	uint8_t id;
 
 	hdr = g_obex_packet_get_header(req, G_OBEX_HDR_ACTION);
 	if (hdr == NULL)
-- 
1.8.2.2

