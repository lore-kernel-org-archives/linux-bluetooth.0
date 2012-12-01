Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Micha=C5=82=20Poczwardowski?= <dmp0x7c5@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Micha=C5=82=20Poczwardowski?= <dmp0x7c5@gmail.com>
Subject: [RFC v3 obexd 03/10] fuse: Add obexhlp_connect/disconnect functions with helpers
Date: Sun,  2 Dec 2012 00:14:48 +0100
Message-Id: <1354403695-18985-3-git-send-email-dmp0x7c5@gmail.com>
In-Reply-To: <1354403695-18985-1-git-send-email-dmp0x7c5@gmail.com>
References: <1354403695-18985-1-git-send-email-dmp0x7c5@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 fuse/helpers.c  |  268 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 fuse/helpers.h  |    4 +
 fuse/obexfuse.c |   40 ++++++++
 3 files changed, 312 insertions(+), 0 deletions(-)

diff --git a/fuse/helpers.c b/fuse/helpers.c
index 2dc309a..82797d9 100644
--- a/fuse/helpers.c
+++ b/fuse/helpers.c
@@ -43,6 +43,9 @@
 
 #define OBEX_FTP_LS "x-obex/folder-listing"
 
+static GCond *obexhlp_cond;
+static GMutex *obexhlp_mutex;
+
 struct obexhlp_request {
 	gchar *name;
 	gboolean complete;
@@ -52,3 +55,268 @@ struct obexhlp_location {
 	gchar *dir;
 	gchar *file;
 };
+
+static volatile sig_atomic_t __sdp_io_finished = 0;
+
+/* adopted from client/bluetooth.c - search_callback() */
+static void search_callback(uint8_t type, uint16_t status,
+			uint8_t *rsp, size_t size, void *user_data)
+{
+	struct obexhlp_session *session = user_data;
+	unsigned int scanned, bytesleft = size;
+	int seqlen = 0;
+	uint8_t dataType;
+	uint16_t port = 0;
+
+	if (status || type != SDP_SVC_SEARCH_ATTR_RSP)
+		goto done;
+
+	scanned = sdp_extract_seqtype(rsp, bytesleft, &dataType, &seqlen);
+	if (!scanned || !seqlen)
+		goto done;
+
+	rsp += scanned;
+	bytesleft -= scanned;
+	do {
+		sdp_record_t *rec;
+		sdp_list_t *protos;
+		sdp_data_t *data;
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
+			port = sdp_get_proto_port(protos, RFCOMM_UUID);
+			sdp_list_foreach(protos,
+					(sdp_list_func_t) sdp_list_free, NULL);
+			sdp_list_free(protos, NULL);
+			protos = NULL;
+			goto done;
+		}
+
+		data = sdp_data_get(rec, 0x0200);
+		/* PSM must be odd and lsb of upper byte must be 0 */
+		if (data != NULL && (data->val.uint16 & 0x0101) == 0x0001)
+			ch = data->val.uint16;
+
+		sdp_record_free(rec);
+
+		if (ch > 0) {
+			port = ch;
+			break;
+		}
+
+		scanned += recsize;
+		rsp += recsize;
+		bytesleft -= recsize;
+	} while (scanned < size && bytesleft > 0);
+
+done:
+	session->channel = port;
+	__sdp_io_finished = 1;
+}
+
+static uint16_t get_ftp_channel(struct obexhlp_session* session,
+					bdaddr_t *src, bdaddr_t *dst)
+{
+	sdp_list_t *search, *attrid;
+	uint32_t range = 0x0000ffff;
+	sdp_session_t *sdp;
+	uuid_t uuid;
+
+	sdp = sdp_connect(src, dst, SDP_RETRY_IF_BUSY);
+	if (sdp == NULL)
+		return 0;
+
+	/* FTP_SDP_UUID "00001106-0000-1000-8000-00805f9b34fb" */
+	uint8_t uuid_int[] = {0, 0, 0x11, 0x06, 0, 0, 0x10, 0, 0x80,
+					0, 0, 0x80, 0x5f, 0x9b, 0x34, 0xfb};
+	sdp_uuid128_create(&uuid, uuid_int);
+
+	if (sdp_set_notify(sdp, search_callback, session) < 0)
+		goto done;
+
+	search = sdp_list_append(NULL, &uuid);
+	attrid = sdp_list_append(NULL, &range);
+
+	if (sdp_service_search_attr_async(sdp,
+				search, SDP_ATTR_REQ_RANGE, attrid) < 0) {
+		sdp_list_free(attrid, NULL);
+		sdp_list_free(search, NULL);
+		goto done;
+	}
+
+	sdp_list_free(attrid, NULL);
+	sdp_list_free(search, NULL);
+
+	while (!__sdp_io_finished)
+		sdp_process(sdp);
+
+done:
+	return session->channel;
+}
+
+/* taken from client/bluetooth.c - bluetooth_getpacketopt */
+static int get_packet_opt(GIOChannel *io, int *tx_mtu, int *rx_mtu)
+{
+	int sk = g_io_channel_unix_get_fd(io);
+	int type;
+	int omtu = -1;
+	int imtu = -1;
+	socklen_t len = sizeof(int);
+
+	if (getsockopt(sk, SOL_SOCKET, SO_TYPE, &type, &len) < 0)
+		return -errno;
+
+	if (type != SOCK_SEQPACKET)
+		return -EINVAL;
+
+	if (!bt_io_get(io, NULL, BT_IO_OPT_OMTU, &omtu,
+						BT_IO_OPT_IMTU, &imtu,
+						BT_IO_OPT_INVALID))
+		return -EINVAL;
+
+	if (tx_mtu)
+		*tx_mtu = omtu;
+
+	if (rx_mtu)
+		*rx_mtu = imtu;
+
+	return 0;
+}
+
+static void obex_callback(GObex *obex, GError *err, GObexPacket *rsp,
+							gpointer user_data)
+{
+	if (err != NULL) {
+		g_print("OBEX Connect failed: %s\n", err->message);
+		g_error_free(err);
+	} else {
+		g_print("OBEX Connect succeeded\n");
+	}
+}
+
+static void bt_io_callback(GIOChannel *io, GError *err, gpointer user_data)
+{
+	struct obexhlp_session *session = user_data;
+	GObexTransportType type;
+	int tx_mtu = -1;
+	int rx_mtu = -1;
+
+	if (err != NULL) {
+		g_printerr("%s\n", err->message);
+		g_error_free(err);
+		return;
+	}
+
+	g_print("Bluetooth socket connected\n");
+
+	g_io_channel_set_close_on_unref(io, FALSE);
+
+	if (get_packet_opt(io, &tx_mtu, &rx_mtu) == 0) {
+		type = G_OBEX_TRANSPORT_PACKET;
+		g_print("PACKET transport tx:%d rx:%d\n", tx_mtu, rx_mtu);
+	} else {
+		type = G_OBEX_TRANSPORT_STREAM;
+		g_print("STREAM transport\n");
+	}
+
+	session->obex = g_obex_new(io, type, tx_mtu, rx_mtu);
+	if (session->obex == NULL) {
+		g_print("ERROR: obex is NULL");
+		raise(SIGTERM);
+	}
+
+	g_io_channel_set_close_on_unref(io, TRUE);
+
+	g_obex_connect(session->obex, obex_callback, session, &err,
+				G_OBEX_HDR_TARGET, OBEX_FTP_UUID,
+				OBEX_FTP_UUID_LEN, G_OBEX_HDR_INVALID);
+
+	if (err != NULL) {
+		g_print("ERROR: %s\n", err->message);
+		g_obex_unref(session->obex);
+		raise(SIGTERM);
+	}
+}
+
+struct obexhlp_session* obexhlp_connect(const char *srcstr,
+						const char *dststr)
+{
+	struct obexhlp_session *session;
+	uint16_t channel;
+	bdaddr_t src, dst;
+
+	session = g_try_malloc0(sizeof(struct obexhlp_session));
+	if (session == NULL)
+		return NULL;
+
+	if (srcstr == NULL)
+		bacpy(&src, BDADDR_ANY);
+	else
+		str2ba(srcstr, &src);
+
+	str2ba(dststr, &dst);
+	channel = get_ftp_channel(session, &src, &dst);
+
+	if (channel == 0)
+		return NULL;
+
+	if (channel > 31)
+		session->io = bt_io_connect(bt_io_callback, session,
+				NULL, &session->err,
+				BT_IO_OPT_SOURCE_BDADDR, &src,
+				BT_IO_OPT_DEST_BDADDR, &dst,
+				BT_IO_OPT_PSM, channel,
+				BT_IO_OPT_MODE, BT_IO_MODE_ERTM,
+				BT_IO_OPT_OMTU, BT_TX_MTU,
+				BT_IO_OPT_IMTU, BT_RX_MTU,
+				BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_LOW,
+				BT_IO_OPT_INVALID);
+	else
+		session->io = bt_io_connect(bt_io_callback, session,
+				NULL, &session->err,
+				BT_IO_OPT_SOURCE_BDADDR, &src,
+				BT_IO_OPT_DEST_BDADDR, &dst,
+				BT_IO_OPT_CHANNEL, channel,
+				BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_LOW,
+				BT_IO_OPT_INVALID);
+
+	if (session->err != NULL)
+		return NULL;
+
+	session->file_stat = g_hash_table_new_full( g_str_hash, g_str_equal,
+					g_free, g_free);
+	session->setpath = g_strdup("/");
+
+	obexhlp_mutex = g_mutex_new();
+	obexhlp_cond = g_cond_new();
+
+	return session;
+}
+
+void obexhlp_disconnect(struct obexhlp_session* session)
+{
+	if (session == NULL)
+		return;
+
+	g_obex_unref(session->obex);
+	g_free(session->io);
+
+	g_hash_table_remove_all(session->file_stat);
+	g_list_free_full(session->lsfiles, g_free);
+	g_free(session->setpath);
+
+	g_mutex_free(obexhlp_mutex);
+	g_cond_free(obexhlp_cond);
+
+	g_free(session);
+}
diff --git a/fuse/helpers.h b/fuse/helpers.h
index abbdd70..3ef924e 100644
--- a/fuse/helpers.h
+++ b/fuse/helpers.h
@@ -47,3 +47,7 @@ struct obexhlp_session {
 	int status;
 	GError *err;
 };
+
+struct obexhlp_session* obexhlp_connect(const char *srcstr,
+						const char *dstsrc);
+void obexhlp_disconnect(struct obexhlp_session* session);
diff --git a/fuse/obexfuse.c b/fuse/obexfuse.c
index fe4f4da..d6a87f3 100644
--- a/fuse/obexfuse.c
+++ b/fuse/obexfuse.c
@@ -33,6 +33,10 @@
 
 #include "helpers.h"
 
+struct obexhlp_session* session = NULL;
+static GMainLoop *main_loop;
+static GThread *main_gthread;
+
 struct options {
 	char* dststr;
 	char* srcstr;
@@ -60,7 +64,34 @@ static struct fuse_opt obexfuse_opts[] =
 	FUSE_OPT_END
 };
 
+gpointer main_loop_func(gpointer user_data)
+{
+	main_loop = g_main_loop_new(NULL, FALSE);
+	g_main_loop_run(main_loop);
+
+	return 0;
+}
+
+void* obexfuse_init(struct fuse_conn_info *conn)
+{
+	main_gthread = g_thread_create(main_loop_func, NULL, TRUE, NULL);
+
+	conn->async_read = 0;
+	conn->want &= ~FUSE_CAP_ASYNC_READ;
+
+	return 0;
+}
+
+void obexfuse_destroy()
+{
+	obexhlp_disconnect(session);
+	g_main_loop_quit(main_loop);
+	g_thread_join(main_gthread);
+}
+
 static struct fuse_operations obexfuse_oper = {
+	.init = obexfuse_init,
+	.destroy = obexfuse_destroy,
 };
 
 static int obexfuse_opt_proc(void *data, const char *arg, int key,
@@ -111,6 +142,15 @@ int main(int argc, char *argv[])
 
 	g_thread_init(NULL);
 
+	session = obexhlp_connect(options.srcstr, options.dststr);
+	if (session == NULL || session->io == NULL) {
+		g_printerr("Connection to %s failed\n", options.dststr);
+		obexhlp_disconnect(session);
+		return -EHOSTUNREACH;
+	} else {
+		g_print("Connected\nMounting %s\n", options.dststr);
+	}
+
 	fuse_opt_add_arg(&args, "-s"); /* force single threaded mode */
 	retfuse = fuse_main(args.argc, args.argv, &obexfuse_oper, NULL);
 
-- 
1.7.8.6

