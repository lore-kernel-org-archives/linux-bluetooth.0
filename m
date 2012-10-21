Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Micha=C5=82=20Poczwardowski?= <dmp0x7c5@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Micha=C5=82=20Poczwardowski?= <dmp0x7c5@gmail.com>
Subject: [RFC v1 obexd 03/11] fuse: Add obexhlp_connect/disconnect functions with helpers
Date: Sun, 21 Oct 2012 19:05:23 +0200
Message-Id: <1350839131-12042-3-git-send-email-dmp0x7c5@gmail.com>
In-Reply-To: <1350839131-12042-1-git-send-email-dmp0x7c5@gmail.com>
References: <1350839131-12042-1-git-send-email-dmp0x7c5@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 fuse/helpers.c  |  220 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 fuse/helpers.h  |    5 +
 fuse/obexfuse.c |   40 ++++++++++
 3 files changed, 265 insertions(+), 0 deletions(-)

diff --git a/fuse/helpers.c b/fuse/helpers.c
index 53bba57..856e1d5 100644
--- a/fuse/helpers.c
+++ b/fuse/helpers.c
@@ -43,6 +43,9 @@
 
 #define OBEX_FTP_LS "x-obex/folder-listing"
 
+static GCond *gobexhlp_cond;
+static GMutex *gobexhlp_mutex;
+
 struct gobexhlp_request {
 	gchar *name;
 	gboolean complete;
@@ -53,3 +56,220 @@ struct gobexhlp_location {
 	gchar *file;
 };
 
+static uint16_t find_rfcomm_uuid(void *user_data)
+{
+	sdp_list_t *pds = (sdp_list_t*) user_data;
+	uint16_t channel = 0;
+
+	for (;pds;pds = pds->next) {
+		sdp_data_t *d = (sdp_data_t*)pds->data;
+		int proto = 0;
+		for (; d; d = d->next) {
+			switch(d->dtd) {
+			case SDP_UUID16:
+			case SDP_UUID32:
+			case SDP_UUID128:
+				proto = sdp_uuid_to_proto(&d->val.uuid);
+			break;
+			case SDP_UINT8:
+				if (proto == RFCOMM_UUID)
+					channel = d->val.int8;
+				break;
+			}
+		}
+	}
+	return channel;
+}
+
+static uint16_t get_ftp_channel(bdaddr_t *src, bdaddr_t *dst)
+{
+	sdp_session_t *sdp;
+	sdp_list_t *r, *search_list, *attrid_list;
+	sdp_list_t *response_list = NULL;
+	uuid_t uuid;
+
+	/* FTP_SDP_UUID "00001106-0000-1000-8000-00805f9b34fb" */
+	uint8_t uuid_int[] = {0, 0, 0x11, 0x06, 0, 0, 0x10, 0, 0x80,
+					0, 0, 0x80, 0x5f, 0x9b, 0x34, 0xfb};
+	uint32_t range = 0x0000ffff;
+	uint16_t channel = 0;
+
+	sdp = sdp_connect(src, dst, SDP_RETRY_IF_BUSY );
+	if (sdp == NULL)
+		return channel;
+
+	sdp_uuid128_create(&uuid, uuid_int);
+	search_list = sdp_list_append(NULL, &uuid);
+	attrid_list = sdp_list_append(NULL, &range);
+	sdp_service_search_attr_req(sdp, search_list, SDP_ATTR_REQ_RANGE,
+					attrid_list, &response_list);
+	r = response_list;
+
+	for (; r;r = r->next) {
+		sdp_record_t *rec = (sdp_record_t*) r->data;
+		sdp_list_t *proto_list;
+
+		if (sdp_get_access_protos(rec, &proto_list ) == 0) {
+			sdp_list_t *p = proto_list;
+			for (; p; p = p->next) {
+				sdp_list_t *pds = (sdp_list_t*) p->data;
+				channel = find_rfcomm_uuid(pds);
+				sdp_list_free((sdp_list_t*) p->data, 0);
+			}
+			sdp_list_free(proto_list, 0);
+		}
+		sdp_record_free(rec);
+	}
+	sdp_close(sdp);
+
+	g_free(search_list);
+	g_free(attrid_list);
+	g_free(response_list);
+
+	return channel;
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
+	if (!bt_io_get(io, BT_IO_L2CAP, NULL, BT_IO_OPT_OMTU, &omtu,
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
+		g_debug("Connect failed: %s\n", err->message);
+		g_error_free(err);
+	} else {
+		g_debug("Connect succeeded\n");
+	}
+}
+
+static void bt_io_callback(GIOChannel *io, GError *err, gpointer user_data)
+{
+	struct gobexhlp_session *session = user_data;
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
+	g_debug("Bluetooth socket connected\n");
+
+	g_io_channel_set_flags(session->io, G_IO_FLAG_NONBLOCK, NULL);
+	g_io_channel_set_close_on_unref(session->io, TRUE);
+
+	if (get_packet_opt(session->io, &tx_mtu, &rx_mtu) == 0) {
+		type = G_OBEX_TRANSPORT_PACKET;
+		g_debug("PACKET transport tx:%d rx:%d\n", tx_mtu, rx_mtu);
+	} else {
+		type = G_OBEX_TRANSPORT_STREAM;
+		g_debug("STREAM transport\n");
+	}
+
+	session->obex = g_obex_new(io, type, tx_mtu, rx_mtu);
+	g_obex_connect(session->obex, obex_callback, session, NULL,
+				G_OBEX_HDR_TARGET, OBEX_FTP_UUID,
+				OBEX_FTP_UUID_LEN, G_OBEX_HDR_INVALID);
+}
+
+struct gobexhlp_session* gobexhlp_connect(const char *srcstr,
+						const char *dststr)
+{
+	struct gobexhlp_session *session;
+	uint16_t channel;
+	bdaddr_t src, dst;
+
+	session = g_try_malloc0(sizeof(struct gobexhlp_session));
+	if (session == NULL)
+		return NULL;
+
+	if (srcstr == NULL)
+		bacpy(&src, BDADDR_ANY);
+	else
+		str2ba(srcstr, &src);
+
+	str2ba(dststr, &dst);
+	channel = get_ftp_channel(&src, &dst);
+
+	if (channel == 0)
+		return NULL;
+
+	if (channel > 31)
+		session->io = bt_io_connect(BT_IO_L2CAP, bt_io_callback,
+				session, NULL, &session->err,
+				BT_IO_OPT_SOURCE_BDADDR, &src,
+				BT_IO_OPT_DEST_BDADDR, &dst,
+				BT_IO_OPT_PSM, channel,
+				BT_IO_OPT_MODE, BT_IO_MODE_ERTM,
+				BT_IO_OPT_OMTU, BT_TX_MTU,
+				BT_IO_OPT_IMTU, BT_RX_MTU,
+				BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_LOW,
+				BT_IO_OPT_INVALID);
+	else
+		session->io = bt_io_connect(BT_IO_RFCOMM, bt_io_callback,
+				session, NULL, &session->err,
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
+	gobexhlp_mutex = g_mutex_new();
+	gobexhlp_cond = g_cond_new();
+
+	return session;
+}
+
+void gobexhlp_disconnect(struct gobexhlp_session* session)
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
+	g_mutex_free(gobexhlp_mutex);
+	g_cond_free(gobexhlp_cond);
+
+	g_free(session);
+}
diff --git a/fuse/helpers.h b/fuse/helpers.h
index 21972b2..f1d787b 100644
--- a/fuse/helpers.h
+++ b/fuse/helpers.h
@@ -47,3 +47,8 @@ struct gobexhlp_session {
 	GError *err;
 };
 
+struct gobexhlp_session* gobexhlp_connect(const char *srcstr,
+						const char *dstsrc);
+void gobexhlp_disconnect(struct gobexhlp_session* session);
+
+
diff --git a/fuse/obexfuse.c b/fuse/obexfuse.c
index fe4f4da..79eb990 100644
--- a/fuse/obexfuse.c
+++ b/fuse/obexfuse.c
@@ -33,6 +33,10 @@
 
 #include "helpers.h"
 
+struct gobexhlp_session* session = NULL;
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
+	gobexhlp_disconnect(session);
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
 
+	session = gobexhlp_connect(options.srcstr, options.dststr);
+	if (session == NULL || session->io == NULL) {
+		g_printerr("Connection to %s failed\n", options.dststr);
+		gobexhlp_disconnect(session);
+		return -EHOSTUNREACH;
+	} else {
+		g_print("Connected\nMounting %s\n", options.dststr);
+	}
+
 	fuse_opt_add_arg(&args, "-s"); /* force single threaded mode */
 	retfuse = fuse_main(args.argc, args.argv, &obexfuse_oper, NULL);
 
-- 
1.7.8.6

