Return-Path: <cyrus@holtmann.org>
Subject: Re: Warning fixes for GCC 4.6
From: Bastien Nocera <hadess@hadess.net>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Date: Fri, 06 May 2011 15:56:28 +0100
In-Reply-To: <BANLkTinBw-qXODF03rtcW+M3GEjK7yC3NQ@mail.gmail.com>
References: <1304620983.16101.16.camel@novo.hadess.net>
	 <BANLkTinBw-qXODF03rtcW+M3GEjK7yC3NQ@mail.gmail.com>
Content-Type: multipart/mixed; boundary="=-OTTJnJeub8FspCXVlshA"
Message-ID: <1304693789.16101.35.camel@novo.hadess.net>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


--=-OTTJnJeub8FspCXVlshA
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit

On Fri, 2011-05-06 at 10:52 +0300, Luiz Augusto von Dentz wrote:
> Hi Bastien,
> 
> On Thu, May 5, 2011 at 9:43 PM, Bastien Nocera <hadess@hadess.net> wrote:
> > So that bluez compiles with -Werror.
> >
> > Cheers
> >

Updated patch attached. Only comment left is the "unused" attribute.

--=-OTTJnJeub8FspCXVlshA
Content-Disposition: attachment;
	filename="0001-Fix-set-but-not-unused-variable-GCC-4.6-warnings.patch"
Content-Type: text/x-patch;
	name="0001-Fix-set-but-not-unused-variable-GCC-4.6-warnings.patch";
	charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit

>From 1816c686e1e411ec574c6f168dac43e0ff4d6bd1 Mon Sep 17 00:00:00 2001
From: Bastien Nocera <hadess@hadess.net>
Date: Thu, 5 May 2011 19:41:38 +0100
Subject: [PATCH] Fix "set but not unused variable" GCC 4.6 warnings

---
 attrib/gatt.c         |    4 ----
 audio/a2dp.c          |    3 ---
 audio/manager.c       |    2 --
 audio/pcm_bluetooth.c |    4 ++--
 btio/btio.c           |    5 +++++
 compat/fakehid.c      |    6 ++++--
 cups/hcrp.c           |   12 ++++++++++++
 gdbus/object.c        |    3 +--
 input/device.c        |    2 +-
 input/server.c        |    3 ++-
 lib/sdp.c             |    2 +-
 network/common.c      |    2 +-
 plugins/hciops.c      |    4 +---
 plugins/mgmtops.c     |    4 +---
 sbc/sbcinfo.c         |    2 +-
 src/adapter.c         |    6 ------
 src/sdp-xml.c         |    4 ----
 src/sdpd-request.c    |    2 +-
 src/textfile.c        |    8 ++++++++
 test/hciemu.c         |    6 ++++++
 test/hstest.c         |    7 ++++++-
 test/rctest.c         |    2 --
 test/scotest.c        |    2 --
 test/test-textfile.c  |    2 ++
 tools/hciattach.c     |    6 +++---
 tools/hcitool.c       |    2 --
 26 files changed, 58 insertions(+), 47 deletions(-)

diff --git a/attrib/gatt.c b/attrib/gatt.c
index 360218b..095b157 100644
--- a/attrib/gatt.c
+++ b/attrib/gatt.c
@@ -71,13 +71,11 @@ static guint16 encode_discover_primary(uint16_t start, uint16_t end,
 {
 	bt_uuid_t prim;
 	guint16 plen;
-	uint8_t op;
 
 	bt_uuid16_create(&prim, GATT_PRIM_SVC_UUID);
 
 	if (uuid == NULL) {
 		/* Discover all primary services */
-		op = ATT_OP_READ_BY_GROUP_REQ;
 		plen = enc_read_by_grp_req(start, end, &prim, pdu, len);
 	} else {
 		uint16_t u16;
@@ -86,8 +84,6 @@ static guint16 encode_discover_primary(uint16_t start, uint16_t end,
 		int vlen;
 
 		/* Discover primary service by service UUID */
-		op = ATT_OP_FIND_BY_TYPE_REQ;
-
 		if (uuid->type == BT_UUID16) {
 			u16 = htobs(uuid->value.u16);
 			value = &u16;
diff --git a/audio/a2dp.c b/audio/a2dp.c
index 9cd7207..52acdfa 100644
--- a/audio/a2dp.c
+++ b/audio/a2dp.c
@@ -2038,7 +2038,6 @@ unsigned int a2dp_config(struct avdtp *session, struct a2dp_sep *sep,
 	struct avdtp_media_codec_capability *codec_cap = NULL;
 	int posix_err;
 	bdaddr_t src;
-	uint8_t remote_type;
 
 	avdtp_get_peers(session, &src, NULL);
 	server = find_server(servers, &src);
@@ -2085,9 +2084,7 @@ unsigned int a2dp_config(struct avdtp *session, struct a2dp_sep *sep,
 	case AVDTP_STATE_IDLE:
 		if (sep->type == AVDTP_SEP_TYPE_SOURCE) {
 			l = server->sources;
-			remote_type = AVDTP_SEP_TYPE_SINK;
 		} else {
-			remote_type = AVDTP_SEP_TYPE_SOURCE;
 			l = server->sinks;
 		}
 
diff --git a/audio/manager.c b/audio/manager.c
index 7e206be..d4ff906 100644
--- a/audio/manager.c
+++ b/audio/manager.c
@@ -562,7 +562,6 @@ static void hf_io_cb(GIOChannel *chan, gpointer data)
 	GError *err = NULL;
 	uint8_t ch;
 	const char *server_uuid, *remote_uuid;
-	uint16_t svclass;
 	struct audio_device *device;
 	int perr;
 
@@ -580,7 +579,6 @@ static void hf_io_cb(GIOChannel *chan, gpointer data)
 
 	server_uuid = HFP_AG_UUID;
 	remote_uuid = HFP_HS_UUID;
-	svclass = HANDSFREE_AGW_SVCLASS_ID;
 
 	device = manager_get_device(&src, &dst, TRUE);
 	if (!device)
diff --git a/audio/pcm_bluetooth.c b/audio/pcm_bluetooth.c
index 799f17f..2d9f178 100644
--- a/audio/pcm_bluetooth.c
+++ b/audio/pcm_bluetooth.c
@@ -820,7 +820,7 @@ static int bluetooth_playback_poll_revents(snd_pcm_ioplug_t *io,
 					unsigned short *revents)
 {
 	static char buf[1];
-	int ret;
+	int ret = 0;
 
 	DBG("");
 
@@ -838,7 +838,7 @@ static int bluetooth_playback_poll_revents(snd_pcm_ioplug_t *io,
 
 	*revents = (pfds[0].revents & POLLIN) ? POLLOUT : 0;
 
-	return 0;
+	return ret;
 }
 
 
diff --git a/btio/btio.c b/btio/btio.c
index 6d71b90..64cd8c6 100644
--- a/btio/btio.c
+++ b/btio/btio.c
@@ -884,6 +884,7 @@ static gboolean l2cap_get(int sock, GError **err, BtIOOption opt1,
 			*(va_arg(args, uint8_t *)) = l2o.mode;
 			break;
 		case BT_IO_OPT_FLUSHABLE:
+			flushable = TRUE;
 			if (l2cap_get_flushable(sock, &flushable) < 0) {
 				ERROR_FAILED(err, "get_flushable", errno);
 				return FALSE;
@@ -1135,6 +1136,10 @@ gboolean bt_io_accept(GIOChannel *io, BtIOConnect connect, gpointer user_data,
 	if (!(pfd.revents & POLLOUT)) {
 		int ret;
 		ret = read(sock, &c, 1);
+		if (ret < 0) {
+			ERROR_FAILED(err, "read", errno);
+			return FALSE;
+		}
 	}
 
 	accept_add(io, connect, user_data, destroy);
diff --git a/compat/fakehid.c b/compat/fakehid.c
index b996d10..0974d0a 100644
--- a/compat/fakehid.c
+++ b/compat/fakehid.c
@@ -60,13 +60,13 @@ static void sig_term(int sig)
 	__io_canceled = 1;
 }
 
-static void send_event(int fd, uint16_t type, uint16_t code, int32_t value)
+static int send_event(int fd, uint16_t type, uint16_t code, int32_t value)
 {
 	struct uinput_event event;
 	int len;
 
 	if (fd <= fileno(stderr))
-		return;
+		return -1;
 
 	memset(&event, 0, sizeof(event));
 	event.type = type;
@@ -74,6 +74,8 @@ static void send_event(int fd, uint16_t type, uint16_t code, int32_t value)
 	event.value = value;
 
 	len = write(fd, &event, sizeof(event));
+
+	return len;
 }
 
 static int uinput_create(char *name, int keyboard, int mouse)
diff --git a/cups/hcrp.c b/cups/hcrp.c
index 7aafcdc..ad88ff6 100644
--- a/cups/hcrp.c
+++ b/cups/hcrp.c
@@ -94,8 +94,12 @@ static int hcrp_credit_grant(int sk, uint16_t tid, uint32_t credit)
 	memcpy(buf, &hdr, HCRP_PDU_HDR_SIZE);
 	memcpy(buf + HCRP_PDU_HDR_SIZE, &cp, HCRP_CREDIT_GRANT_CP_SIZE);
 	len = write(sk, buf, HCRP_PDU_HDR_SIZE + HCRP_CREDIT_GRANT_CP_SIZE);
+	if (len < 0)
+		return -1;
 
 	len = read(sk, buf, sizeof(buf));
+	if (len < 0)
+		return -1;
 	memcpy(&hdr, buf, HCRP_PDU_HDR_SIZE);
 	memcpy(&rp, buf + HCRP_PDU_HDR_SIZE, HCRP_CREDIT_GRANT_RP_SIZE);
 
@@ -119,8 +123,12 @@ static int hcrp_credit_request(int sk, uint16_t tid, uint32_t *credit)
 	hdr.plen = htons(0);
 	memcpy(buf, &hdr, HCRP_PDU_HDR_SIZE);
 	len = write(sk, buf, HCRP_PDU_HDR_SIZE);
+	if (len < 0)
+		return -1;
 
 	len = read(sk, buf, sizeof(buf));
+	if (len < 0)
+		return -1;
 	memcpy(&hdr, buf, HCRP_PDU_HDR_SIZE);
 	memcpy(&rp, buf + HCRP_PDU_HDR_SIZE, HCRP_CREDIT_REQUEST_RP_SIZE);
 
@@ -147,8 +155,12 @@ static int hcrp_get_lpt_status(int sk, uint16_t tid, uint8_t *lpt_status)
 	hdr.plen = htons(0);
 	memcpy(buf, &hdr, HCRP_PDU_HDR_SIZE);
 	len = write(sk, buf, HCRP_PDU_HDR_SIZE);
+	if (len < 0)
+		return -1;
 
 	len = read(sk, buf, sizeof(buf));
+	if (len < 0)
+		return -1;
 	memcpy(&hdr, buf, HCRP_PDU_HDR_SIZE);
 	memcpy(&rp, buf + HCRP_PDU_HDR_SIZE, HCRP_GET_LPT_STATUS_RP_SIZE);
 
diff --git a/gdbus/object.c b/gdbus/object.c
index eaa2e1a..d17a101 100644
--- a/gdbus/object.c
+++ b/gdbus/object.c
@@ -255,14 +255,13 @@ void g_dbus_pending_success(DBusConnection *connection,
 
         for (list = pending_security; list; list = list->next) {
 		struct security_data *secdata = list->data;
-		DBusHandlerResult result;
 
 		if (secdata->pending != pending)
 			continue;
 
 		pending_security = g_slist_remove(pending_security, secdata);
 
-		result = process_message(connection, secdata->message,
+		process_message(connection, secdata->message,
 				secdata->method, secdata->iface_user_data);
 
 		dbus_message_unref(secdata->message);
diff --git a/input/device.c b/input/device.c
index 554f5ac..550e1c7 100644
--- a/input/device.c
+++ b/input/device.c
@@ -250,7 +250,7 @@ static int decode_key(const char *str)
 static void send_event(int fd, uint16_t type, uint16_t code, int32_t value)
 {
 	struct uinput_event event;
-	int err;
+	int __attribute__((__unused__)) err;
 
 	memset(&event, 0, sizeof(event));
 	event.type	= type;
diff --git a/input/server.c b/input/server.c
index d98018b..15bf5b3 100644
--- a/input/server.c
+++ b/input/server.c
@@ -91,7 +91,8 @@ static void connect_event_cb(GIOChannel *chan, GError *err, gpointer data)
 	/* Send unplug virtual cable to unknown devices */
 	if (ret == -ENOENT && psm == L2CAP_PSM_HIDP_CTRL) {
 		unsigned char unplug = 0x15;
-		int err, sk = g_io_channel_unix_get_fd(chan);
+		int __attribute__((__unused__)) err;
+		int sk = g_io_channel_unix_get_fd(chan);
 		err = write(sk, &unplug, sizeof(unplug));
 	}
 
diff --git a/lib/sdp.c b/lib/sdp.c
index d24d1e2..d852587 100644
--- a/lib/sdp.c
+++ b/lib/sdp.c
@@ -3319,7 +3319,7 @@ int sdp_service_search_req(sdp_session_t *session, const sdp_list_t *search,
 	uint32_t reqsize = 0, _reqsize;
 	uint32_t rspsize = 0, rsplen;
 	int seqlen = 0;
-	int total_rec_count, rec_count;
+	int __attribute__((__unused__)) total_rec_count, rec_count;
 	unsigned scanned, pdata_len;
 	uint8_t *pdata, *_pdata;
 	uint8_t *reqbuf, *rspbuf;
diff --git a/network/common.c b/network/common.c
index ef72679..38d2c49 100644
--- a/network/common.c
+++ b/network/common.c
@@ -215,7 +215,7 @@ int bnep_if_up(const char *devname)
 int bnep_if_down(const char *devname)
 {
 	struct ifreq ifr;
-	int sk, err;
+	int sk, __attribute__((__unused__)) err;
 
 	sk = socket(AF_INET, SOCK_DGRAM, 0);
 
diff --git a/plugins/hciops.c b/plugins/hciops.c
index 2c49e35..49dd48d 100644
--- a/plugins/hciops.c
+++ b/plugins/hciops.c
@@ -2754,7 +2754,7 @@ static void init_conn_list(int index)
 	struct dev_info *dev = &devs[index];
 	struct hci_conn_list_req *cl;
 	struct hci_conn_info *ci;
-	int err, i;
+	int i;
 
 	DBG("hci%d", index);
 
@@ -2780,8 +2780,6 @@ static void init_conn_list(int index)
 		conn->handle = ci->handle;
 	}
 
-	err = 0;
-
 failed:
 	g_free(cl);
 }
diff --git a/plugins/mgmtops.c b/plugins/mgmtops.c
index 9e1cfac..b831044 100644
--- a/plugins/mgmtops.c
+++ b/plugins/mgmtops.c
@@ -207,7 +207,7 @@ static int mgmt_update_powered(int index, uint8_t powered)
 {
 	struct controller_info *info;
 	struct btd_adapter *adapter;
-	gboolean pairable, discoverable;
+	gboolean pairable;
 	uint8_t on_mode;
 
 	if (index > max_index) {
@@ -238,8 +238,6 @@ static int mgmt_update_powered(int index, uint8_t powered)
 
 	btd_adapter_get_mode(adapter, NULL, &on_mode, &pairable);
 
-	discoverable = (on_mode == MODE_DISCOVERABLE);
-
 	if (on_mode == MODE_DISCOVERABLE && !info->discoverable)
 		mgmt_set_discoverable(index, TRUE);
 	else if (on_mode == MODE_CONNECTABLE && !info->connectable)
diff --git a/sbc/sbcinfo.c b/sbc/sbcinfo.c
index 6d92679..63f05aa 100644
--- a/sbc/sbcinfo.c
+++ b/sbc/sbcinfo.c
@@ -281,7 +281,7 @@ static int analyze_file(char *filename)
 	printf("Subbands\t\t%d\n", subbands);
 	printf("Block length\t\t%d\n", blocks);
 	printf("Sampling frequency\t%s\n", freq2str(freq));
-	printf("Channel mode\t\t%s\n", mode2str(hdr.channel_mode));
+	printf("Channel mode\t\t%s\n", mode2str(mode));
 	printf("Allocation method\t%s\n", method ? "SNR" : "Loudness");
 	printf("Bitpool\t\t\t%d", bitpool[0]);
 	for (n = 1; n < SIZE; n++)
diff --git a/src/adapter.c b/src/adapter.c
index f068335..76fc01b 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -476,13 +476,10 @@ static int set_mode(struct btd_adapter *adapter, uint8_t new_mode,
 {
 	int err;
 	const char *modestr;
-	gboolean discoverable;
 
 	if (adapter->pending_mode != NULL)
 		return -EALREADY;
 
-	discoverable = new_mode == MODE_DISCOVERABLE;
-
 	if (!adapter->up && new_mode != MODE_OFF) {
 		err = adapter_ops->set_powered(adapter->dev_id, TRUE);
 		if (err < 0)
@@ -3405,7 +3402,6 @@ gboolean adapter_powering_down(struct btd_adapter *adapter)
 int btd_adapter_restore_powered(struct btd_adapter *adapter)
 {
 	char mode[14], address[18];
-	gboolean discoverable;
 
 	if (!adapter_ops)
 		return -EINVAL;
@@ -3421,8 +3417,6 @@ int btd_adapter_restore_powered(struct btd_adapter *adapter)
 						g_str_equal(mode, "off"))
 		return 0;
 
-	discoverable = get_mode(&adapter->bdaddr, mode) == MODE_DISCOVERABLE;
-
 	return adapter_ops->set_powered(adapter->dev_id, TRUE);
 }
 
diff --git a/src/sdp-xml.c b/src/sdp-xml.c
index 3aa9df0..62226cc 100644
--- a/src/sdp-xml.c
+++ b/src/sdp-xml.c
@@ -47,7 +47,6 @@ static void convert_raw_data_to_xml(sdp_data_t *value, int indent_level,
 	int i, hex;
 	char buf[STRBUFSIZE];
 	char indent[MAXINDENT];
-	char next_indent[MAXINDENT];
 
 	if (!value)
 		return;
@@ -57,12 +56,9 @@ static void convert_raw_data_to_xml(sdp_data_t *value, int indent_level,
 
 	for (i = 0; i < indent_level; i++) {
 		indent[i] = '\t';
-		next_indent[i] = '\t';
 	}
 
 	indent[i] = '\0';
-	next_indent[i] = '\t';
-	next_indent[i + 1] = '\0';
 
 	buf[STRBUFSIZE - 1] = '\0';
 
diff --git a/src/sdpd-request.c b/src/sdpd-request.c
index 1722f78..287acc2 100644
--- a/src/sdpd-request.c
+++ b/src/sdpd-request.c
@@ -962,7 +962,7 @@ static void process_request(sdp_req_t *req)
 	sdp_pdu_hdr_t *rsphdr;
 	sdp_buf_t rsp;
 	uint8_t *buf = malloc(USHRT_MAX);
-	int sent = 0;
+	int __attribute__((__unused__)) sent = 0;
 	int status = SDP_INVALID_SYNTAX;
 
 	memset(buf, 0, USHRT_MAX);
diff --git a/src/textfile.c b/src/textfile.c
index d115ff6..2645f9a 100644
--- a/src/textfile.c
+++ b/src/textfile.c
@@ -204,6 +204,10 @@ static int write_key(const char *pathname, const char *key, const char *value, i
 	if (!size) {
 		if (value) {
 			pos = lseek(fd, size, SEEK_SET);
+			if (pos == (off_t) -1) {
+				err = errno;
+				goto unlock;
+			}
 			err = write_key_value(fd, key, value);
 		}
 		goto unlock;
@@ -222,6 +226,10 @@ static int write_key(const char *pathname, const char *key, const char *value, i
 		if (value) {
 			munmap(map, size);
 			pos = lseek(fd, size, SEEK_SET);
+			if (pos == (off_t) -1) {
+				err = errno;
+				goto unlock;
+			}
 			err = write_key_value(fd, key, value);
 		}
 		goto unlock;
diff --git a/test/hciemu.c b/test/hciemu.c
index 66f99a9..27e8275 100644
--- a/test/hciemu.c
+++ b/test/hciemu.c
@@ -222,7 +222,11 @@ static int write_snoop(int fd, int type, int incoming, unsigned char *buf, int l
 		pkt.flags |= ntohl(0x02);
 
 	err = write(fd, &pkt, BTSNOOP_PKT_SIZE);
+	if (err < 0)
+		return -1;
 	err = write(fd, buf, size);
+	if (err < 0)
+		return -1;
 
 	return 0;
 }
@@ -899,6 +903,8 @@ static gboolean io_acl_data(GIOChannel *chan, GIOCondition cond, gpointer data)
 	write_snoop(vdev.dd, HCI_ACLDATA_PKT, 1, buf, len);
 
 	err = write(vdev.fd, buf, len);
+	if (err < 0)
+		return FALSE;
 
 	return TRUE;
 }
diff --git a/test/hstest.c b/test/hstest.c
index 08f2257..07124c1 100644
--- a/test/hstest.c
+++ b/test/hstest.c
@@ -244,8 +244,13 @@ int main(int argc, char *argv[])
 
 	fprintf(stderr, "SCO audio channel connected (handle %d, mtu %d)\n", sco_handle, sco_mtu);
 
-	if (mode == RECORD)
+	if (mode == RECORD) {
 		err = write(rd, "RING\r\n", 6);
+		if (err < 0) {
+			perror("Can't write \"RING\"");
+			return -1;
+		}
+	}
 
 	maxfd = (rd > sd) ? rd : sd;
 
diff --git a/test/rctest.c b/test/rctest.c
index b3804f5..9754f52 100644
--- a/test/rctest.c
+++ b/test/rctest.c
@@ -417,13 +417,11 @@ static void recv_mode(int sk)
 	struct timeval tv_beg, tv_end, tv_diff;
 	char ts[30];
 	long total;
-	uint32_t seq;
 
 	syslog(LOG_INFO, "Receiving ...");
 
 	memset(ts, 0, sizeof(ts));
 
-	seq = 0;
 	while (1) {
 		gettimeofday(&tv_beg,NULL);
 		total = 0;
diff --git a/test/scotest.c b/test/scotest.c
index 50b622a..17bd8a6 100644
--- a/test/scotest.c
+++ b/test/scotest.c
@@ -216,11 +216,9 @@ static void recv_mode(int sk)
 {
 	struct timeval tv_beg,tv_end,tv_diff;
 	long total;
-	uint32_t seq;
 
 	syslog(LOG_INFO, "Receiving ...");
 
-	seq = 0;
 	while (1) {
 		gettimeofday(&tv_beg, NULL);
 		total = 0;
diff --git a/test/test-textfile.c b/test/test-textfile.c
index 970e9e7..0786022 100644
--- a/test/test-textfile.c
+++ b/test/test-textfile.c
@@ -51,6 +51,8 @@ int main(int argc, char *argv[])
 
 	fd = creat(filename, 0644);
 	err = ftruncate(fd, 0);
+	if (err < 0)
+		fprintf(stderr, "%s (%d)\n", strerror(errno), errno);
 
 	memset(value, 0, sizeof(value));
 	for (i = 0; i < (size / sizeof(value)); i++)
diff --git a/tools/hciattach.c b/tools/hciattach.c
index e4d5aa1..bc56f31 100644
--- a/tools/hciattach.c
+++ b/tools/hciattach.c
@@ -351,7 +351,7 @@ static int bcsp_max_retries = 10;
 static void bcsp_tshy_sig_alarm(int sig)
 {
 	unsigned char bcsp_sync_pkt[10] = {0xc0,0x00,0x41,0x00,0xbe,0xda,0xdc,0xed,0xed,0xc0};
-	int len;
+	int __attribute__((__unused__)) len;
 	static int retries = 0;
 
 	if (retries < bcsp_max_retries) {
@@ -369,7 +369,7 @@ static void bcsp_tshy_sig_alarm(int sig)
 static void bcsp_tconf_sig_alarm(int sig)
 {
 	unsigned char bcsp_conf_pkt[10] = {0xc0,0x00,0x41,0x00,0xbe,0xad,0xef,0xac,0xed,0xc0};
-	int len;
+	int __attribute__((__unused__)) len;
 	static int retries = 0;
 
 	if (retries < bcsp_max_retries){
@@ -394,7 +394,7 @@ static int bcsp(int fd, struct uart_t *u, struct termios *ti)
 		bcspconf[4]     = {0xad,0xef,0xac,0xed},
 		bcspconfresp[4] = {0xde,0xad,0xd0,0xd0};
 	struct sigaction sa;
-	int len;
+	int __attribute__((__unused__)) len;
 
 	if (set_speed(fd, ti, u->speed) < 0) {
 		perror("Can't set default baud rate");
diff --git a/tools/hcitool.c b/tools/hcitool.c
index a117449..ece187c 100644
--- a/tools/hcitool.c
+++ b/tools/hcitool.c
@@ -2351,7 +2351,6 @@ static int print_advertising_devices(int dd, uint8_t filter_type)
 	unsigned char buf[HCI_MAX_EVENT_SIZE], *ptr;
 	struct hci_filter nf, of;
 	socklen_t olen;
-	hci_event_hdr *hdr;
 	int num, len;
 
 	olen = sizeof(of);
@@ -2382,7 +2381,6 @@ static int print_advertising_devices(int dd, uint8_t filter_type)
 			goto done;
 		}
 
-		hdr = (void *) (buf + 1);
 		ptr = buf + (1 + HCI_EVENT_HDR_SIZE);
 		len -= (1 + HCI_EVENT_HDR_SIZE);
 
-- 
1.7.5


--=-OTTJnJeub8FspCXVlshA--

