Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 02/20] android/AVDTP: Strip dependencies
Date: Mon, 25 Nov 2013 16:54:25 +0200
Message-Id: <1385391283-10962-3-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1385391283-10962-1-git-send-email-luiz.dentz@gmail.com>
References: <1385391283-10962-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This strips AVDTP code of any dependency of core and btio to make it
transport agnostic.
---
 android/Android.mk  |   1 +
 android/Makefile.am |   1 +
 android/a2dp.c      |  23 ++
 android/avdtp.c     | 757 +++++-----------------------------------------------
 android/avdtp.h     |  28 +-
 5 files changed, 102 insertions(+), 708 deletions(-)

diff --git a/android/Android.mk b/android/Android.mk
index 616a338..c4d722d 100644
--- a/android/Android.mk
+++ b/android/Android.mk
@@ -25,6 +25,7 @@ LOCAL_SRC_FILES := \
 	hidhost.c \
 	socket.c \
 	ipc.c ipc.h \
+	avdtp.c \
 	a2dp.c \
 	pan.c \
 	../src/log.c \
diff --git a/android/Makefile.am b/android/Makefile.am
index 5f6b1a3..94d231f 100644
--- a/android/Makefile.am
+++ b/android/Makefile.am
@@ -19,6 +19,7 @@ android_bluetoothd_SOURCES = android/main.c \
 				android/bluetooth.h android/bluetooth.c \
 				android/hidhost.h android/hidhost.c \
 				android/ipc.h android/ipc.c \
+				android/avdtp.h android/avdtp.c \
 				android/a2dp.h android/a2dp.c \
 				android/socket.h android/socket.c \
 				android/pan.h android/pan.c \
diff --git a/android/a2dp.c b/android/a2dp.c
index 55a433e..2251001 100644
--- a/android/a2dp.c
+++ b/android/a2dp.c
@@ -43,6 +43,7 @@
 #include "ipc.h"
 #include "utils.h"
 #include "bluetooth.h"
+#include "avdtp.h"
 
 #define L2CAP_PSM_AVDTP 0x19
 #define SVC_HINT_CAPTURING 0x08
@@ -58,6 +59,7 @@ struct a2dp_device {
 	uint8_t		state;
 	GIOChannel	*io;
 	guint		watch;
+	struct avdtp	*session;
 };
 
 static int device_cmp(gconstpointer s, gconstpointer user_data)
@@ -70,6 +72,9 @@ static int device_cmp(gconstpointer s, gconstpointer user_data)
 
 static void a2dp_device_free(struct a2dp_device *dev)
 {
+	if (dev->session)
+		avdtp_unref(dev->session);
+
 	if (dev->watch > 0)
 		g_source_remove(dev->watch);
 
@@ -129,6 +134,9 @@ static void signaling_connect_cb(GIOChannel *chan, GError *err,
 							gpointer user_data)
 {
 	struct a2dp_device *dev = user_data;
+	uint16_t imtu, omtu;
+	GError *gerr = NULL;
+	int fd;
 
 	if (err) {
 		bt_a2dp_notify_state(dev, HAL_A2DP_STATE_DISCONNECTED);
@@ -136,6 +144,21 @@ static void signaling_connect_cb(GIOChannel *chan, GError *err,
 		return;
 	}
 
+	bt_io_get(chan, &gerr,
+			BT_IO_OPT_IMTU, &imtu,
+			BT_IO_OPT_OMTU, &omtu,
+			BT_IO_OPT_INVALID);
+	if (gerr) {
+		bt_a2dp_notify_state(dev, HAL_A2DP_STATE_DISCONNECTED);
+		error("%s", gerr->message);
+		g_error_free(gerr);
+		return;
+	}
+
+	/* FIXME: Add proper version */
+	fd = g_io_channel_unix_get_fd(chan);
+	dev->session = avdtp_new(fd, imtu, omtu, 0x0100);
+
 	dev->watch = g_io_add_watch(dev->io, G_IO_HUP | G_IO_ERR | G_IO_NVAL,
 								watch_cb, dev);
 
diff --git a/android/avdtp.c b/android/avdtp.c
index b7a7d9c..ac08acd 100644
--- a/android/avdtp.c
+++ b/android/avdtp.c
@@ -33,23 +33,14 @@
 #include <errno.h>
 #include <unistd.h>
 #include <assert.h>
-
-#include <bluetooth/bluetooth.h>
-#include <bluetooth/sdp.h>
-#include <bluetooth/sdp_lib.h>
+#include <string.h>
+#include <sys/socket.h>
+#include <netinet/in.h>
 
 #include <glib.h>
-#include <btio/btio.h>
 
 #include "log.h"
-
-#include "lib/uuid.h"
-#include "src/adapter.h"
-#include "src/device.h"
-
 #include "avdtp.h"
-#include "sink.h"
-#include "source.h"
 
 #define AVDTP_PSM 25
 
@@ -321,13 +312,6 @@ struct avdtp_remote_sep {
 	struct avdtp_stream *stream;
 };
 
-struct avdtp_server {
-	struct btd_adapter *adapter;
-	GIOChannel *io;
-	GSList *seps;
-	GSList *sessions;
-};
-
 struct avdtp_local_sep {
 	avdtp_state_t state;
 	struct avdtp_stream *stream;
@@ -338,7 +322,6 @@ struct avdtp_local_sep {
 	struct avdtp_sep_ind *ind;
 	struct avdtp_sep_cfm *cfm;
 	void *user_data;
-	struct avdtp_server *server;
 };
 
 struct stream_callback {
@@ -347,13 +330,6 @@ struct stream_callback {
 	unsigned int id;
 };
 
-struct avdtp_state_callback {
-	avdtp_session_state_cb cb;
-	struct btd_device *dev;
-	unsigned int id;
-	void *user_data;
-};
-
 struct discover_callback {
 	unsigned int id;
 	avdtp_discover_cb_t cb;
@@ -390,9 +366,6 @@ struct avdtp {
 	uint16_t version;
 
 	struct avdtp_server *server;
-	struct btd_device *device;
-
-	avdtp_session_state_t state;
 
 	guint auth_id;
 
@@ -417,16 +390,9 @@ struct avdtp {
 
 	struct discover_callback *discover;
 	struct pending_req *req;
-
-	guint dc_timer;
-
-	/* Attempt stream setup instead of disconnecting */
-	gboolean stream_setup;
 };
 
-static GSList *servers = NULL;
-
-static GSList *state_callbacks = NULL;
+static GSList *lseps = NULL;
 
 static int send_request(struct avdtp *session, gboolean priority,
 			struct avdtp_stream *stream, uint8_t signal_id,
@@ -444,18 +410,6 @@ static void avdtp_sep_set_state(struct avdtp *session,
 				struct avdtp_local_sep *sep,
 				avdtp_state_t state);
 
-static struct avdtp_server *find_server(GSList *list, struct btd_adapter *a)
-{
-	for (; list; list = list->next) {
-		struct avdtp_server *server = list->data;
-
-		if (server->adapter == a)
-			return server;
-	}
-
-	return NULL;
-}
-
 static const char *avdtp_statestr(avdtp_state_t state)
 {
 	switch (state) {
@@ -701,24 +655,6 @@ static struct avdtp_remote_sep *find_remote_sep(GSList *seps, uint8_t seid)
 	return NULL;
 }
 
-static void avdtp_set_state(struct avdtp *session,
-					avdtp_session_state_t new_state)
-{
-	GSList *l;
-	avdtp_session_state_t old_state = session->state;
-
-	session->state = new_state;
-
-	for (l = state_callbacks; l != NULL; l = l->next) {
-		struct avdtp_state_callback *cb = l->data;
-
-		if (session->device != cb->dev)
-			continue;
-
-		cb->cb(cb->dev, session, old_state, new_state, cb->user_data);
-	}
-}
-
 static void stream_free(void *data)
 {
 	struct avdtp_stream *stream = data;
@@ -767,47 +703,11 @@ static gboolean transport_cb(GIOChannel *chan, GIOCondition cond,
 	return FALSE;
 }
 
-static int get_send_buffer_size(int sk)
-{
-	int size;
-	socklen_t optlen = sizeof(size);
-
-	if (getsockopt(sk, SOL_SOCKET, SO_SNDBUF, &size, &optlen) < 0) {
-		int err = -errno;
-		error("getsockopt(SO_SNDBUF) failed: %s (%d)", strerror(-err),
-									-err);
-		return err;
-	}
-
-	/*
-	 * Doubled value is returned by getsockopt since kernel uses that
-	 * space for its own purposes (see man 7 socket, bookkeeping overhead
-	 * for SO_SNDBUF).
-	 */
-	return size / 2;
-}
-
-static int set_send_buffer_size(int sk, int size)
-{
-	socklen_t optlen = sizeof(size);
-
-	if (setsockopt(sk, SOL_SOCKET, SO_SNDBUF, &size, optlen) < 0) {
-		int err = -errno;
-		error("setsockopt(SO_SNDBUF) failed: %s (%d)", strerror(-err),
-									-err);
-		return err;
-	}
-
-	return 0;
-}
-
 static void handle_transport_connect(struct avdtp *session, GIOChannel *io,
 					uint16_t imtu, uint16_t omtu)
 {
 	struct avdtp_stream *stream = session->pending_open;
 	struct avdtp_local_sep *sep = stream->lsep;
-	int sk, buf_size, min_buf_size;
-	GError *err = NULL;
 
 	session->pending_open = NULL;
 
@@ -816,15 +716,8 @@ static void handle_transport_connect(struct avdtp *session, GIOChannel *io,
 		stream->timer = 0;
 	}
 
-	if (io == NULL) {
-		if (!stream->open_acp && sep->cfm && sep->cfm->open) {
-			struct avdtp_error err;
-			avdtp_error_init(&err, AVDTP_ERRNO, EIO);
-			sep->cfm->open(session, sep, NULL, &err,
-					sep->user_data);
-		}
+	if (io == NULL)
 		return;
-	}
 
 	if (stream->io == NULL)
 		stream->io = g_io_channel_ref(io);
@@ -832,35 +725,6 @@ static void handle_transport_connect(struct avdtp *session, GIOChannel *io,
 	stream->omtu = omtu;
 	stream->imtu = imtu;
 
-	/* Apply special settings only if local SEP is of type SRC */
-	if (sep->info.type != AVDTP_SEP_TYPE_SOURCE)
-		goto proceed;
-
-	bt_io_set(stream->io, &err, BT_IO_OPT_FLUSHABLE, TRUE,
-							BT_IO_OPT_INVALID);
-	if (err != NULL) {
-		error("Enabling flushable packets failed: %s", err->message);
-		g_error_free(err);
-	} else
-		DBG("Flushable packets enabled");
-
-	sk = g_io_channel_unix_get_fd(stream->io);
-	buf_size = get_send_buffer_size(sk);
-	if (buf_size < 0)
-		goto proceed;
-
-	DBG("sk %d, omtu %d, send buffer size %d", sk, omtu, buf_size);
-	min_buf_size = omtu * 2;
-	if (buf_size < min_buf_size) {
-		DBG("send buffer size to be increassed to %d",
-				min_buf_size);
-		set_send_buffer_size(sk, min_buf_size);
-	}
-
-proceed:
-	if (!stream->open_acp && sep->cfm && sep->cfm->open)
-		sep->cfm->open(session, sep, stream, NULL, sep->user_data);
-
 	avdtp_sep_set_state(session, sep, AVDTP_STATE_OPEN);
 
 	stream->io_id = g_io_add_watch(io, G_IO_ERR | G_IO_HUP | G_IO_NVAL,
@@ -1071,25 +935,6 @@ static void release_stream(struct avdtp_stream *stream, struct avdtp *session)
 	avdtp_sep_set_state(session, sep, AVDTP_STATE_IDLE);
 }
 
-static int avdtp_cancel_authorization(struct avdtp *session)
-{
-	int err;
-
-	if (session->state != AVDTP_SESSION_STATE_CONNECTING)
-		return 0;
-
-	if (session->auth_id == 0)
-		return 0;
-
-	err = btd_cancel_authorization(session->auth_id);
-	if (err < 0)
-		return err;
-
-	session->auth_id = 0;
-
-	return 0;
-}
-
 static void sep_free(gpointer data)
 {
 	struct avdtp_remote_sep *sep = data;
@@ -1098,13 +943,6 @@ static void sep_free(gpointer data)
 	g_free(sep);
 }
 
-static void remove_disconnect_timer(struct avdtp *session)
-{
-	g_source_remove(session->dc_timer);
-	session->dc_timer = 0;
-	session->stream_setup = FALSE;
-}
-
 static void avdtp_free(void *data)
 {
 	struct avdtp *session = data;
@@ -1123,9 +961,6 @@ static void avdtp_free(void *data)
 		session->io_id = 0;
 	}
 
-	if (session->dc_timer)
-		remove_disconnect_timer(session);
-
 	if (session->req)
 		pending_req_free(session->req);
 
@@ -1140,68 +975,19 @@ static void avdtp_free(void *data)
 
 static void connection_lost(struct avdtp *session, int err)
 {
-	struct avdtp_server *server = session->server;
-	char address[18];
-
-	ba2str(device_get_address(session->device), address);
-	DBG("Disconnected from %s", address);
-
-	if (err != EACCES)
-		avdtp_cancel_authorization(session);
+	DBG("Disconnected: %s (%d)", strerror(err), err);
 
 	g_slist_foreach(session->streams, (GFunc) release_stream, session);
 	session->streams = NULL;
 
 	finalize_discovery(session, err);
 
-	avdtp_set_state(session, AVDTP_SESSION_STATE_DISCONNECTED);
-
 	if (session->ref > 0)
 		return;
 
-	server->sessions = g_slist_remove(server->sessions, session);
-	btd_device_unref(session->device);
 	avdtp_free(session);
 }
 
-static gboolean disconnect_timeout(gpointer user_data)
-{
-	struct avdtp *session = user_data;
-	struct btd_service *service;
-	gboolean stream_setup;
-
-	session->dc_timer = 0;
-
-	stream_setup = session->stream_setup;
-	session->stream_setup = FALSE;
-
-	service = btd_device_get_service(session->device, A2DP_SINK_UUID);
-	if (service && stream_setup) {
-		sink_setup_stream(service, session);
-		return FALSE;
-	}
-
-	service = btd_device_get_service(session->device, A2DP_SOURCE_UUID);
-	if (service && stream_setup) {
-		source_setup_stream(service, session);
-		return FALSE;
-	}
-
-	connection_lost(session, ETIMEDOUT);
-
-	return FALSE;
-}
-
-static void set_disconnect_timer(struct avdtp *session)
-{
-	if (session->dc_timer)
-		remove_disconnect_timer(session);
-
-	session->dc_timer = g_timeout_add_seconds(DISCONNECT_TIMEOUT,
-						disconnect_timeout,
-						session);
-}
-
 void avdtp_unref(struct avdtp *session)
 {
 	if (!session)
@@ -1214,24 +1000,25 @@ void avdtp_unref(struct avdtp *session)
 	if (session->ref > 0)
 		return;
 
-	set_disconnect_timer(session);
+	finalize_discovery(session, ECONNABORTED);
+
+	avdtp_free(session);
 }
 
 struct avdtp *avdtp_ref(struct avdtp *session)
 {
 	session->ref++;
+
 	DBG("%p: ref=%d", session, session->ref);
-	if (session->dc_timer)
-		remove_disconnect_timer(session);
+
 	return session;
 }
 
-static struct avdtp_local_sep *find_local_sep_by_seid(struct avdtp_server *server,
-							uint8_t seid)
+static struct avdtp_local_sep *find_local_sep_by_seid(uint8_t seid)
 {
 	GSList *l;
 
-	for (l = server->seps; l != NULL; l = g_slist_next(l)) {
+	for (l = lseps; l != NULL; l = g_slist_next(l)) {
 		struct avdtp_local_sep *sep = l->data;
 
 		if (sep->info.seid == seid)
@@ -1334,7 +1121,7 @@ static gboolean avdtp_discover_cmd(struct avdtp *session, uint8_t transaction,
 	struct seid_info *seps;
 	gboolean ret;
 
-	sep_count = g_slist_length(session->server->seps);
+	sep_count = g_slist_length(lseps);
 
 	if (sep_count == 0) {
 		uint8_t err = AVDTP_NOT_SUPPORTED_COMMAND;
@@ -1346,7 +1133,7 @@ static gboolean avdtp_discover_cmd(struct avdtp *session, uint8_t transaction,
 
 	seps = g_new0(struct seid_info, sep_count);
 
-	for (l = session->server->seps, i = 0; l != NULL; l = l->next, i++) {
+	for (l = lseps, i = 0; l != NULL; l = l->next, i++) {
 		struct avdtp_local_sep *sep = l->data;
 
 		memcpy(&seps[i], &sep->info, sizeof(struct seid_info));
@@ -1376,7 +1163,7 @@ static gboolean avdtp_getcap_cmd(struct avdtp *session, uint8_t transaction,
 		goto failed;
 	}
 
-	sep = find_local_sep_by_seid(session->server, req->acp_seid);
+	sep = find_local_sep_by_seid(req->acp_seid);
 	if (!sep) {
 		err = AVDTP_BAD_ACP_SEID;
 		goto failed;
@@ -1445,7 +1232,6 @@ static gboolean avdtp_setconf_cmd(struct avdtp *session, uint8_t transaction,
 	struct avdtp_local_sep *sep;
 	struct avdtp_stream *stream;
 	uint8_t err, category = 0x00;
-	struct btd_service *service;
 	GSList *l;
 
 	if (size < sizeof(struct setconf_req)) {
@@ -1453,7 +1239,7 @@ static gboolean avdtp_setconf_cmd(struct avdtp *session, uint8_t transaction,
 		return FALSE;
 	}
 
-	sep = find_local_sep_by_seid(session->server, req->acp_seid);
+	sep = find_local_sep_by_seid(req->acp_seid);
 	if (!sep) {
 		err = AVDTP_BAD_ACP_SEID;
 		goto failed;
@@ -1464,37 +1250,6 @@ static gboolean avdtp_setconf_cmd(struct avdtp *session, uint8_t transaction,
 		goto failed;
 	}
 
-	switch (sep->info.type) {
-	case AVDTP_SEP_TYPE_SOURCE:
-		service = btd_device_get_service(session->device,
-							A2DP_SINK_UUID);
-		if (service == NULL) {
-			btd_device_add_uuid(session->device, A2DP_SINK_UUID);
-			service = btd_device_get_service(session->device,
-							A2DP_SINK_UUID);
-			if (service == NULL) {
-				error("Unable to get a audio sink object");
-				err = AVDTP_BAD_STATE;
-				goto failed;
-			}
-		}
-		break;
-	case AVDTP_SEP_TYPE_SINK:
-		service = btd_device_get_service(session->device,
-							A2DP_SOURCE_UUID);
-		if (service == NULL) {
-			btd_device_add_uuid(session->device, A2DP_SOURCE_UUID);
-			service = btd_device_get_service(session->device,
-							A2DP_SOURCE_UUID);
-			if (service == NULL) {
-				error("Unable to get a audio source object");
-				err = AVDTP_BAD_STATE;
-				goto failed;
-			}
-		}
-		break;
-	}
-
 	stream = g_new0(struct avdtp_stream, 1);
 	stream->session = session;
 	stream->lsep = sep;
@@ -1568,7 +1323,7 @@ static gboolean avdtp_getconf_cmd(struct avdtp *session, uint8_t transaction,
 
 	memset(buf, 0, sizeof(buf));
 
-	sep = find_local_sep_by_seid(session->server, req->acp_seid);
+	sep = find_local_sep_by_seid(req->acp_seid);
 	if (!sep) {
 		err = AVDTP_BAD_ACP_SEID;
 		goto failed;
@@ -1684,7 +1439,7 @@ static gboolean avdtp_open_cmd(struct avdtp *session, uint8_t transaction,
 		return FALSE;
 	}
 
-	sep = find_local_sep_by_seid(session->server, req->acp_seid);
+	sep = find_local_sep_by_seid(req->acp_seid);
 	if (!sep) {
 		err = AVDTP_BAD_ACP_SEID;
 		goto failed;
@@ -1744,8 +1499,7 @@ static gboolean avdtp_start_cmd(struct avdtp *session, uint8_t transaction,
 	for (i = 0; i < seid_count; i++, seid++) {
 		failed_seid = seid->seid;
 
-		sep = find_local_sep_by_seid(session->server,
-					req->first_seid.seid);
+		sep = find_local_sep_by_seid(req->first_seid.seid);
 		if (!sep || !sep->stream) {
 			err = AVDTP_BAD_ACP_SEID;
 			goto failed;
@@ -1795,7 +1549,7 @@ static gboolean avdtp_close_cmd(struct avdtp *session, uint8_t transaction,
 		return FALSE;
 	}
 
-	sep = find_local_sep_by_seid(session->server, req->acp_seid);
+	sep = find_local_sep_by_seid(req->acp_seid);
 	if (!sep || !sep->stream) {
 		err = AVDTP_BAD_ACP_SEID;
 		goto failed;
@@ -1856,8 +1610,7 @@ static gboolean avdtp_suspend_cmd(struct avdtp *session, uint8_t transaction,
 	for (i = 0; i < seid_count; i++, seid++) {
 		failed_seid = seid->seid;
 
-		sep = find_local_sep_by_seid(session->server,
-					req->first_seid.seid);
+		sep = find_local_sep_by_seid(req->first_seid.seid);
 		if (!sep || !sep->stream) {
 			err = AVDTP_BAD_ACP_SEID;
 			goto failed;
@@ -1904,7 +1657,7 @@ static gboolean avdtp_abort_cmd(struct avdtp *session, uint8_t transaction,
 		return FALSE;
 	}
 
-	sep = find_local_sep_by_seid(session->server, req->acp_seid);
+	sep = find_local_sep_by_seid(req->acp_seid);
 	if (!sep || !sep->stream)
 		return TRUE;
 
@@ -1942,7 +1695,7 @@ static gboolean avdtp_delayreport_cmd(struct avdtp *session,
 		return FALSE;
 	}
 
-	sep = find_local_sep_by_seid(session->server, req->acp_seid);
+	sep = find_local_sep_by_seid(req->acp_seid);
 	if (!sep || !sep->stream) {
 		err = AVDTP_BAD_ACP_SEID;
 		goto failed;
@@ -2265,281 +2018,30 @@ failed:
 	return FALSE;
 }
 
-static struct avdtp *find_session(GSList *list, struct btd_device *device)
-{
-	for (; list != NULL; list = g_slist_next(list)) {
-		struct avdtp *s = list->data;
-
-		if (s->device == device)
-			return s;
-	}
-
-	return NULL;
-}
-
-static uint16_t get_version(struct avdtp *session)
+struct avdtp *avdtp_new(int fd, size_t imtu, size_t omtu, uint16_t version)
 {
-	const sdp_record_t *rec;
-	sdp_list_t *protos;
-	sdp_data_t *proto_desc;
-	uint16_t ver = 0x0100;
-
-	rec = btd_device_get_record(session->device, A2DP_SINK_UUID);
-	if (!rec)
-		rec = btd_device_get_record(session->device, A2DP_SOURCE_UUID);
-
-	if (!rec)
-		return ver;
-
-	if (sdp_get_access_protos(rec, &protos) < 0)
-		return ver;
-
-	proto_desc = sdp_get_proto_desc(protos, AVDTP_UUID);
-	if (proto_desc && proto_desc->dtd == SDP_UINT16)
-		ver = proto_desc->val.uint16;
-
-	sdp_list_foreach(protos, (sdp_list_func_t) sdp_list_free, NULL);
-	sdp_list_free(protos, NULL);
-
-	return ver;
-}
-
-static struct avdtp *avdtp_get_internal(struct btd_device *device)
-{
-	struct avdtp_server *server;
 	struct avdtp *session;
-
-	server = find_server(servers, device_get_adapter(device));
-	if (server == NULL)
-		return NULL;
-
-	session = find_session(server->sessions, device);
-	if (session)
-		return session;
+	GIOCondition cond = G_IO_IN | G_IO_ERR | G_IO_HUP | G_IO_NVAL;
 
 	session = g_new0(struct avdtp, 1);
-
-	session->server = server;
-	session->device = btd_device_ref(device);
-	/* We don't use avdtp_set_state() here since this isn't a state change
-	 * but just setting of the initial state */
-	session->state = AVDTP_SESSION_STATE_DISCONNECTED;
-
-	session->version = get_version(session);
-
-	server->sessions = g_slist_append(server->sessions, session);
-
-	return session;
-}
-
-struct avdtp *avdtp_get(struct btd_device *device)
-{
-	struct avdtp *session;
-
-	session = avdtp_get_internal(device);
-
-	if (!session)
-		return NULL;
-
-	return avdtp_ref(session);
-}
-
-static void avdtp_connect_cb(GIOChannel *chan, GError *err, gpointer user_data)
-{
-	struct avdtp *session = user_data;
-	char address[18];
-	int err_no = EIO;
-
-	if (err) {
-		err_no = err->code;
-		error("%s", err->message);
-		goto failed;
-	}
-
-	if (!session->io)
-		session->io = g_io_channel_ref(chan);
-
-	bt_io_get(chan, &err,
-			BT_IO_OPT_OMTU, &session->omtu,
-			BT_IO_OPT_IMTU, &session->imtu,
-			BT_IO_OPT_INVALID);
-	if (err) {
-		err_no = err->code;
-		error("%s", err->message);
-		goto failed;
-	}
-
-	ba2str(device_get_address(session->device), address);
-	DBG("AVDTP: connected %s channel to %s",
-			session->pending_open ? "transport" : "signaling",
-			address);
-
-	if (session->state == AVDTP_SESSION_STATE_CONNECTING) {
-		DBG("AVDTP imtu=%u, omtu=%u", session->imtu, session->omtu);
-
-		session->buf = g_malloc0(MAX(session->imtu, session->omtu));
-		avdtp_set_state(session, AVDTP_SESSION_STATE_CONNECTED);
-
-		if (session->io_id)
-			g_source_remove(session->io_id);
-
-		/* This watch should be low priority since otherwise the
-		 * connect callback might be dispatched before the session
-		 * callback if the kernel wakes us up at the same time for
-		 * them. This could happen if a headset is very quick in
-		 * sending the Start command after connecting the stream
-		 * transport channel.
-		 */
-		session->io_id = g_io_add_watch_full(chan,
-						G_PRIORITY_LOW,
-						G_IO_IN | G_IO_ERR | G_IO_HUP
-						| G_IO_NVAL,
+	session->io = g_io_channel_unix_new(fd);
+	session->version = version;
+	session->imtu = imtu;
+	session->omtu = omtu;
+	session->buf = g_malloc0(MAX(session->imtu, session->omtu));
+
+	/* This watch should be low priority since otherwise the
+	 * connect callback might be dispatched before the session
+	 * callback if the kernel wakes us up at the same time for
+	 * them. This could happen if a headset is very quick in
+	 * sending the Start command after connecting the stream
+	 * transport channel.
+	 */
+	session->io_id = g_io_add_watch_full(session->io, G_PRIORITY_LOW, cond,
 						(GIOFunc) session_cb, session,
 						NULL);
 
-		if (session->stream_setup)
-			set_disconnect_timer(session);
-	} else if (session->pending_open)
-		handle_transport_connect(session, chan, session->imtu,
-								session->omtu);
-	else
-		goto failed;
-
-	process_queue(session);
-
-	return;
-
-failed:
-	if (session->pending_open) {
-		struct avdtp_stream *stream = session->pending_open;
-
-		handle_transport_connect(session, NULL, 0, 0);
-
-		if (avdtp_abort(session, stream) < 0)
-			avdtp_sep_set_state(session, stream->lsep,
-						AVDTP_STATE_IDLE);
-	} else
-		connection_lost(session, err_no);
-}
-
-static void auth_cb(DBusError *derr, void *user_data)
-{
-	struct avdtp *session = user_data;
-	GError *err = NULL;
-
-	if (derr && dbus_error_is_set(derr)) {
-		error("Access denied: %s", derr->message);
-		connection_lost(session, EACCES);
-		return;
-	}
-
-	if (!bt_io_accept(session->io, avdtp_connect_cb, session, NULL,
-								&err)) {
-		error("bt_io_accept: %s", err->message);
-		connection_lost(session, EACCES);
-		g_error_free(err);
-		return;
-	}
-
-	/* This is so that avdtp_connect_cb will know to do the right thing
-	 * with respect to the disconnect timer */
-	session->stream_setup = TRUE;
-}
-
-static void avdtp_confirm_cb(GIOChannel *chan, gpointer data)
-{
-	struct avdtp *session;
-	char address[18];
-	bdaddr_t src, dst;
-	GError *err = NULL;
-	struct btd_device *device;
-
-	bt_io_get(chan, &err,
-			BT_IO_OPT_SOURCE_BDADDR, &src,
-			BT_IO_OPT_DEST_BDADDR, &dst,
-			BT_IO_OPT_DEST, address,
-			BT_IO_OPT_INVALID);
-	if (err) {
-		error("%s", err->message);
-		g_error_free(err);
-		goto drop;
-	}
-
-	DBG("AVDTP: incoming connect from %s", address);
-
-	device = adapter_find_device(adapter_find(&src), &dst);
-	if (!device)
-		goto drop;
-
-	session = avdtp_get_internal(device);
-	if (!session)
-		goto drop;
-
-	/* This state (ie, session is already *connecting*) happens when the
-	 * device initiates a connect (really a config'd L2CAP channel) even
-	 * though there is a connect we initiated in progress. In sink.c &
-	 * source.c, this state is referred to as XCASE connect:connect.
-	 * Abort the device's channel in favor of our own.
-	 */
-	if (session->state == AVDTP_SESSION_STATE_CONNECTING) {
-		DBG("connect already in progress (XCASE connect:connect)");
-		goto drop;
-	}
-
-	if (session->pending_open && session->pending_open->open_acp) {
-		if (!bt_io_accept(chan, avdtp_connect_cb, session, NULL, NULL))
-			goto drop;
-		return;
-	}
-
-	if (session->io) {
-		error("Refusing unexpected connect from %s", address);
-		goto drop;
-	}
-
-	btd_device_add_uuid(device, ADVANCED_AUDIO_UUID);
-
-	session->io = g_io_channel_ref(chan);
-	avdtp_set_state(session, AVDTP_SESSION_STATE_CONNECTING);
-
-	session->io_id = g_io_add_watch(chan, G_IO_ERR | G_IO_HUP | G_IO_NVAL,
-					(GIOFunc) session_cb, session);
-
-	session->auth_id = btd_request_authorization(&src, &dst,
-							ADVANCED_AUDIO_UUID,
-							auth_cb, session);
-	if (session->auth_id == 0) {
-		avdtp_set_state(session, AVDTP_SESSION_STATE_DISCONNECTED);
-		goto drop;
-	}
-
-	return;
-
-drop:
-	g_io_channel_shutdown(chan, TRUE, NULL);
-}
-
-static GIOChannel *l2cap_connect(struct avdtp *session)
-{
-	GError *err = NULL;
-	GIOChannel *io;
-
-	io = bt_io_connect(avdtp_connect_cb, session,
-				NULL, &err,
-				BT_IO_OPT_SOURCE_BDADDR,
-				adapter_get_address(session->server->adapter),
-				BT_IO_OPT_DEST_BDADDR,
-				device_get_address(session->device),
-				BT_IO_OPT_PSM, AVDTP_PSM,
-				BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_MEDIUM,
-				BT_IO_OPT_INVALID);
-	if (!io) {
-		error("%s", err->message);
-		g_error_free(err);
-		return NULL;
-	}
-
-	return io;
+	return avdtp_ref(session);
 }
 
 static void queue_request(struct avdtp *session, struct pending_req *req,
@@ -2676,17 +2178,7 @@ static int send_req(struct avdtp *session, gboolean priority,
 	static int transaction = 0;
 	int err;
 
-	if (session->state == AVDTP_SESSION_STATE_DISCONNECTED) {
-		session->io = l2cap_connect(session);
-		if (!session->io) {
-			err = -EIO;
-			goto failed;
-		}
-		avdtp_set_state(session, AVDTP_SESSION_STATE_CONNECTING);
-	}
-
-	if (session->state < AVDTP_SESSION_STATE_CONNECTED ||
-			session->req != NULL) {
+	if (session->req != NULL) {
 		queue_request(session, req, priority);
 		return 0;
 	}
@@ -2859,14 +2351,11 @@ static gboolean avdtp_open_resp(struct avdtp *session, struct avdtp_stream *stre
 {
 	struct avdtp_local_sep *sep = stream->lsep;
 
-	stream->io = l2cap_connect(session);
-	if (!stream->io) {
-		avdtp_sep_set_state(session, sep, AVDTP_STATE_IDLE);
-		return FALSE;
-	}
-
 	session->pending_open = stream;
 
+	if (!stream->open_acp && sep->cfm && sep->cfm->open)
+		sep->cfm->open(session, sep, stream, NULL, sep->user_data);
+
 	return TRUE;
 }
 
@@ -2876,14 +2365,14 @@ static gboolean avdtp_start_resp(struct avdtp *session,
 {
 	struct avdtp_local_sep *sep = stream->lsep;
 
-	if (sep->cfm && sep->cfm->start)
-		sep->cfm->start(session, sep, stream, NULL, sep->user_data);
-
 	/* We might be in STREAMING already if both sides send START_CMD at the
 	 * same time and the one in SNK role doesn't reject it as it should */
 	if (sep->state != AVDTP_STATE_STREAMING)
 		avdtp_sep_set_state(session, sep, AVDTP_STATE_STREAMING);
 
+	if (sep->cfm && sep->cfm->start)
+		sep->cfm->start(session, sep, stream, NULL, sep->user_data);
+
 	return TRUE;
 }
 
@@ -3223,6 +2712,24 @@ struct avdtp_remote_sep *avdtp_stream_get_remote_sep(
 	return NULL;
 }
 
+gboolean avdtp_stream_set_transport(struct avdtp_stream *stream, int fd,
+						size_t imtu, size_t omtu)
+{
+	GIOChannel *io;
+
+	if (stream != stream->session->pending_open)
+		return FALSE;
+
+	io = g_io_channel_unix_new(fd);
+
+	handle_transport_connect(stream->session, io, imtu, omtu);
+
+	g_io_channel_unref(io);
+
+	return TRUE;
+
+}
+
 gboolean avdtp_stream_get_transport(struct avdtp_stream *stream, int *sock,
 					uint16_t *imtu, uint16_t *omtu,
 					GSList **caps)
@@ -3375,9 +2882,6 @@ int avdtp_get_configuration(struct avdtp *session, struct avdtp_stream *stream)
 {
 	struct seid_req req;
 
-	if (session->state < AVDTP_SESSION_STATE_CONNECTED)
-		return -EINVAL;
-
 	memset(&req, 0, sizeof(req));
 	req.acp_seid = stream->rseid;
 
@@ -3410,9 +2914,6 @@ int avdtp_set_configuration(struct avdtp *session,
 	struct avdtp_service_capability *cap;
 	GSList *l;
 
-	if (session->state != AVDTP_SESSION_STATE_CONNECTED)
-		return -ENOTCONN;
-
 	if (!(lsep && rsep))
 		return -EINVAL;
 
@@ -3610,7 +3111,8 @@ int avdtp_abort(struct avdtp *session, struct avdtp_stream *stream)
 	if (stream->lsep->state == AVDTP_STATE_ABORTING)
 		return -EINVAL;
 
-	if (session->req && stream == session->req->stream)
+	if (session->req && session->req->timeout > 0 &&
+						stream == session->req->stream)
 		return cancel_request(session, ECANCELED);
 
 	memset(&req, 0, sizeof(req));
@@ -3649,108 +3151,43 @@ int avdtp_delay_report(struct avdtp *session, struct avdtp_stream *stream,
 							&req, sizeof(req));
 }
 
-static GIOChannel *avdtp_server_socket(const bdaddr_t *src, gboolean master)
-{
-	GError *err = NULL;
-	GIOChannel *io;
-
-	io = bt_io_listen(NULL, avdtp_confirm_cb,
-				NULL, NULL, &err,
-				BT_IO_OPT_SOURCE_BDADDR, src,
-				BT_IO_OPT_PSM, AVDTP_PSM,
-				BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_MEDIUM,
-				BT_IO_OPT_MASTER, master,
-				BT_IO_OPT_INVALID);
-	if (!io) {
-		error("%s", err->message);
-		g_error_free(err);
-	}
-
-	return io;
-}
-
-static struct avdtp_server *avdtp_server_init(struct btd_adapter *adapter)
-{
-	struct avdtp_server *server;
-
-	server = g_new0(struct avdtp_server, 1);
-
-	server->io = avdtp_server_socket(adapter_get_address(adapter), TRUE);
-	if (!server->io) {
-		g_free(server);
-		return NULL;
-	}
-
-	server->adapter = btd_adapter_ref(adapter);
-
-	servers = g_slist_append(servers, server);
-
-	return server;
-}
-
-struct avdtp_local_sep *avdtp_register_sep(struct btd_adapter *adapter,
-						uint8_t type,
-						uint8_t media_type,
+struct avdtp_local_sep *avdtp_register_sep(uint8_t type, uint8_t media_type,
 						uint8_t codec_type,
 						gboolean delay_reporting,
 						struct avdtp_sep_ind *ind,
 						struct avdtp_sep_cfm *cfm,
 						void *user_data)
 {
-	struct avdtp_server *server;
 	struct avdtp_local_sep *sep;
 
-	server = find_server(servers, adapter);
-	if (!server) {
-		server = avdtp_server_init(adapter);
-		if (!server)
-			return NULL;
-	}
-
-	if (g_slist_length(server->seps) > MAX_SEID)
+	if (g_slist_length(lseps) > MAX_SEID)
 		return NULL;
 
 	sep = g_new0(struct avdtp_local_sep, 1);
 
 	sep->state = AVDTP_STATE_IDLE;
-	sep->info.seid = g_slist_length(server->seps) + 1;
+	sep->info.seid = g_slist_length(lseps) + 1;
 	sep->info.type = type;
 	sep->info.media_type = media_type;
 	sep->codec = codec_type;
 	sep->ind = ind;
 	sep->cfm = cfm;
 	sep->user_data = user_data;
-	sep->server = server;
 	sep->delay_reporting = TRUE;
 
 	DBG("SEP %p registered: type:%d codec:%d seid:%d", sep,
 			sep->info.type, sep->codec, sep->info.seid);
-	server->seps = g_slist_append(server->seps, sep);
+	lseps = g_slist_append(lseps, sep);
 
 	return sep;
 }
 
-static void avdtp_server_destroy(struct avdtp_server *server)
-{
-	g_slist_free_full(server->sessions, avdtp_free);
-
-	servers = g_slist_remove(servers, server);
-
-	g_io_channel_shutdown(server->io, TRUE, NULL);
-	g_io_channel_unref(server->io);
-	btd_adapter_unref(server->adapter);
-	g_free(server);
-}
-
 int avdtp_unregister_sep(struct avdtp_local_sep *sep)
 {
-	struct avdtp_server *server;
-
 	if (!sep)
 		return -EINVAL;
 
-	server = sep->server;
-	server->seps = g_slist_remove(server->seps, sep);
+	lseps = g_slist_remove(lseps, sep);
 
 	if (sep->stream)
 		release_stream(sep->stream, sep->stream->session);
@@ -3760,11 +3197,6 @@ int avdtp_unregister_sep(struct avdtp_local_sep *sep)
 
 	g_free(sep);
 
-	if (server->seps)
-		return 0;
-
-	avdtp_server_destroy(server);
-
 	return 0;
 }
 
@@ -3818,50 +3250,7 @@ avdtp_state_t avdtp_sep_get_state(struct avdtp_local_sep *sep)
 	return sep->state;
 }
 
-struct btd_adapter *avdtp_get_adapter(struct avdtp *session)
-{
-	return session->server->adapter;
-}
-
-struct btd_device *avdtp_get_device(struct avdtp *session)
-{
-	return session->device;
-}
-
 gboolean avdtp_has_stream(struct avdtp *session, struct avdtp_stream *stream)
 {
 	return g_slist_find(session->streams, stream) ? TRUE : FALSE;
 }
-
-unsigned int avdtp_add_state_cb(struct btd_device *dev,
-				avdtp_session_state_cb cb, void *user_data)
-{
-	struct avdtp_state_callback *state_cb;
-	static unsigned int id = 0;
-
-	state_cb = g_new(struct avdtp_state_callback, 1);
-	state_cb->cb = cb;
-	state_cb->dev = dev;
-	state_cb->id = ++id;
-	state_cb->user_data = user_data;
-
-	state_callbacks = g_slist_append(state_callbacks, state_cb);
-
-	return state_cb->id;
-}
-
-gboolean avdtp_remove_state_cb(unsigned int id)
-{
-	GSList *l;
-
-	for (l = state_callbacks; l != NULL; l = l->next) {
-		struct avdtp_state_callback *cb = l->data;
-		if (cb && cb->id == id) {
-			state_callbacks = g_slist_remove(state_callbacks, cb);
-			g_free(cb);
-			return TRUE;
-		}
-	}
-
-	return FALSE;
-}
diff --git a/android/avdtp.h b/android/avdtp.h
index 390c154..9760875 100644
--- a/android/avdtp.h
+++ b/android/avdtp.h
@@ -22,12 +22,6 @@
  *
  */
 
-typedef enum {
-	AVDTP_SESSION_STATE_DISCONNECTED,
-	AVDTP_SESSION_STATE_CONNECTING,
-	AVDTP_SESSION_STATE_CONNECTED
-} avdtp_session_state_t;
-
 struct avdtp;
 struct avdtp_stream;
 struct avdtp_local_sep;
@@ -116,12 +110,6 @@ struct avdtp_media_codec_capability {
 #error "Unknown byte order"
 #endif
 
-typedef void (*avdtp_session_state_cb) (struct btd_device *dev,
-					struct avdtp *session,
-					avdtp_session_state_t old_state,
-					avdtp_session_state_t new_state,
-					void *user_data);
-
 typedef void (*avdtp_stream_state_cb) (struct avdtp_stream *stream,
 					avdtp_state_t old_state,
 					avdtp_state_t new_state,
@@ -213,7 +201,7 @@ struct avdtp_sep_ind {
 typedef void (*avdtp_discover_cb_t) (struct avdtp *session, GSList *seps,
 					struct avdtp_error *err, void *user_data);
 
-struct avdtp *avdtp_get(struct btd_device *device);
+struct avdtp *avdtp_new(int fd, size_t imtu, size_t omtu, uint16_t version);
 
 void avdtp_unref(struct avdtp *session);
 struct avdtp *avdtp_ref(struct avdtp *session);
@@ -235,6 +223,8 @@ gboolean avdtp_stream_remove_cb(struct avdtp *session,
 				struct avdtp_stream *stream,
 				unsigned int id);
 
+gboolean avdtp_stream_set_transport(struct avdtp_stream *stream, int fd,
+						size_t imtu, size_t omtu);
 gboolean avdtp_stream_get_transport(struct avdtp_stream *stream, int *sock,
 					uint16_t *imtu, uint16_t *omtu,
 					GSList **caps);
@@ -245,11 +235,6 @@ gboolean avdtp_stream_has_capabilities(struct avdtp_stream *stream,
 struct avdtp_remote_sep *avdtp_stream_get_remote_sep(
 						struct avdtp_stream *stream);
 
-unsigned int avdtp_add_state_cb(struct btd_device *dev,
-				avdtp_session_state_cb cb, void *user_data);
-
-gboolean avdtp_remove_state_cb(unsigned int id);
-
 int avdtp_set_configuration(struct avdtp *session,
 				struct avdtp_remote_sep *rsep,
 				struct avdtp_local_sep *lsep,
@@ -268,9 +253,7 @@ int avdtp_abort(struct avdtp *session, struct avdtp_stream *stream);
 int avdtp_delay_report(struct avdtp *session, struct avdtp_stream *stream,
 							uint16_t delay);
 
-struct avdtp_local_sep *avdtp_register_sep(struct btd_adapter *adapter,
-						uint8_t type,
-						uint8_t media_type,
+struct avdtp_local_sep *avdtp_register_sep(uint8_t type, uint8_t media_type,
 						uint8_t codec_type,
 						gboolean delay_reporting,
 						struct avdtp_sep_ind *ind,
@@ -290,6 +273,3 @@ const char *avdtp_strerror(struct avdtp_error *err);
 uint8_t avdtp_error_category(struct avdtp_error *err);
 int avdtp_error_error_code(struct avdtp_error *err);
 int avdtp_error_posix_errno(struct avdtp_error *err);
-
-struct btd_adapter *avdtp_get_adapter(struct avdtp *session);
-struct btd_device *avdtp_get_device(struct avdtp *session);
-- 
1.8.3.1

