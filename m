Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <4755A3D5.6030101@silicom.fr>
Date: Tue, 04 Dec 2007 20:00:37 +0100
From: Fabien Chevalier <fchevalier@silicom.fr>
MIME-Version: 1.0
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Content-Type: multipart/mixed; boundary="------------020208010909010008090608"
Cc: BlueZ development <bluez-devel@lists.sourceforge.net>
Subject: [Bluez-devel] [PATCH] Change BT_XXXXXX_RSP messages structure
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------020208010909010008090608
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


Hi Luiz,

The attached patch groups the error field in a specific header for all 
the BT_XXXXXX_RSP messages.
It makes sending such BT_XXXXXX_RSP messages much simpler, by being able 
to send a simple bt_audio_rsp_msg_header_t structure in the error path, 
when all the other fields are left to NULL.

As usual, comments are welcomed !!

Cheers,

Fabien

--------------020208010909010008090608
Content-Type: text/x-patch;
 name="rsp_error_cleanup.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline;
 filename="rsp_error_cleanup.patch"

Index: pcm_bluetooth.c
===================================================================
--- pcm_bluetooth.c	(révision 360)
+++ pcm_bluetooth.c	(copie de travail)
@@ -332,8 +332,8 @@
 	char c = 'w';
 	char buf[BT_AUDIO_IPC_PACKET_SIZE];
 	struct bt_streamstart_req *start_req = (void*) buf;
-	struct bt_streamstart_rsp *start_rsp = (void*) buf;
-	struct bt_datafd_ind *datafd_ind = (void*) buf;
+	bt_audio_rsp_msg_header_t *rsp_hdr = (void*) buf;
+	struct bt_streamfd_ind *streamfd_ind = (void*) buf;
 	uint32_t period_count = io->buffer_size / io->period_size;
 	int opt_name, err;
 	struct timeval t = { 0, period_count };
@@ -368,19 +368,19 @@
 	if (err < 0)
 		return err;
 
-	err = audioservice_expect(data->server.fd, &start_rsp->h,
+	err = audioservice_expect(data->server.fd, &rsp_hdr->msg_h,
 					BT_STREAMSTART_RSP);
 	if (err < 0)
 		return err;
 
-	if (start_rsp->posix_errno != 0) {
+	if (rsp_hdr->posix_errno != 0) {
 		SNDERR("BT_START failed : %s(%d)",
-					strerror(start_rsp->posix_errno),
-					start_rsp->posix_errno);
-		return -start_rsp->posix_errno;
+					strerror(rsp_hdr->posix_errno),
+					rsp_hdr->posix_errno);
+		return -rsp_hdr->posix_errno;
 	}
 
-	err = audioservice_expect(data->server.fd, &datafd_ind->h,
+	err = audioservice_expect(data->server.fd, &streamfd_ind->h,
 					BT_STREAMFD_IND);
 	if (err < 0)
 		return err;
@@ -542,6 +542,7 @@
 	struct bluetooth_data *data = io->private_data;
 	struct bluetooth_a2dp *a2dp = &data->a2dp;
 	char buf[BT_AUDIO_IPC_PACKET_SIZE];
+	bt_audio_rsp_msg_header_t *rsp_hdr = (void*) buf;
 	struct bt_setconfiguration_req *setconf_req = (void*) buf;
 	struct bt_setconfiguration_rsp *setconf_rsp = (void*) buf;
 	unsigned int rate, channels;
@@ -573,16 +574,16 @@
 	if (err < 0)
 		return err;
 
-	err = audioservice_expect(data->server.fd, &setconf_rsp->h,
+	err = audioservice_expect(data->server.fd, &rsp_hdr->msg_h,
 					BT_SETCONFIGURATION_RSP);
 	if (err < 0)
 		return err;
 
-	if (setconf_rsp->posix_errno != 0) {
+	if (rsp_hdr->posix_errno != 0) {
 		SNDERR("BT_SETCONFIGURATION failed : %s(%d)",
-					strerror(setconf_rsp->posix_errno),
-					setconf_rsp->posix_errno);
-		return -setconf_rsp->posix_errno;
+					strerror(rsp_hdr->posix_errno),
+					rsp_hdr->posix_errno);
+		return -rsp_hdr->posix_errno;
 	}
 
 	data->transport = setconf_rsp->transport;
@@ -1399,16 +1400,16 @@
 	return err;
 }
 
-static int audioservice_expect(int sk, bt_audio_msg_header_t *outmsg,
+static int audioservice_expect(int sk, bt_audio_msg_header_t *rsp_hdr,
 				int expected_type)
 {
-	int err = audioservice_recv(sk, outmsg);
+	int err = audioservice_recv(sk, rsp_hdr);
 	if (err == 0) {
-		if (outmsg->msg_type != expected_type) {
+		if (rsp_hdr->msg_type != expected_type) {
 			err = -EINVAL;
 			SNDERR("Bogus message %s received while "
 					"%s was expected",
-					bt_audio_strmsg(outmsg->msg_type),
+					bt_audio_strmsg(rsp_hdr->msg_type),
 					bt_audio_strmsg(expected_type));
 		}
 	}
@@ -1421,6 +1422,7 @@
 	int sk, err;
 	struct bluetooth_alsa_config *alsa_conf = &data->alsa_config;
 	char buf[BT_AUDIO_IPC_PACKET_SIZE];
+	bt_audio_rsp_msg_header_t *rsp_hdr = (void*) buf;
 	struct bt_getcapabilities_req *getcaps_req = (void*) buf;
 	struct bt_getcapabilities_rsp *getcaps_rsp = (void*) buf;
 
@@ -1474,15 +1476,15 @@
 	if (err < 0)
 		goto failed;
 
-	err = audioservice_expect(data->server.fd, &getcaps_rsp->h, BT_GETCAPABILITIES_RSP);
+	err = audioservice_expect(data->server.fd, &rsp_hdr->msg_h, BT_GETCAPABILITIES_RSP);
 	if (err < 0)
 		goto failed;
 
-	if (getcaps_rsp->posix_errno != 0) {
+	if (rsp_hdr->posix_errno != 0) {
 		SNDERR("BT_GETCAPABILITIES failed : %s(%d)",
-					strerror(getcaps_rsp->posix_errno),
-					getcaps_rsp->posix_errno);
-		return -getcaps_rsp->posix_errno;
+					strerror(rsp_hdr->posix_errno),
+					rsp_hdr->posix_errno);
+		return -rsp_hdr->posix_errno;
 	}
 
 	data->transport = getcaps_rsp->transport;
Index: ipc.h
===================================================================
--- ipc.h	(révision 360)
+++ ipc.h	(copie de travail)
@@ -74,11 +74,17 @@
 #define BT_AUDIO_IPC_PACKET_SIZE   128
 #define BT_IPC_SOCKET_NAME "\0/org/bluez/audio"
 
-/* Generic message header definition */
+/* Generic message header definition, except for RSP messages */
 typedef struct {
 	uint8_t msg_type;
 } __attribute__ ((packed)) bt_audio_msg_header_t;
 
+/* Generic message header definition, for all RSP messages */
+typedef struct {
+	bt_audio_msg_header_t 	msg_h;
+	uint8_t			posix_errno;
+} __attribute__ ((packed)) bt_audio_rsp_msg_header_t;
+
 /* Messages list */
 #define BT_GETCAPABILITIES_REQ		0
 #define BT_GETCAPABILITIES_RSP		1
@@ -161,12 +167,11 @@
 } __attribute__ ((packed)) mpeg_capabilities_t;
 
 struct bt_getcapabilities_rsp {
-	bt_audio_msg_header_t	h;
-	uint8_t			posix_errno;
-	uint8_t			transport;		/* Granted transport */
-	sbc_capabilities_t	sbc_capabilities;	/* A2DP only */
-	mpeg_capabilities_t	mpeg_capabilities;	/* A2DP only */
-	uint16_t		sampling_rate;		/* SCO only */
+	bt_audio_rsp_msg_header_t	rsp_h;
+	uint8_t				transport;	   /* Granted transport */
+	sbc_capabilities_t		sbc_capabilities;  /* A2DP only */
+	mpeg_capabilities_t		mpeg_capabilities; /* A2DP only */
+	uint16_t			sampling_rate;	   /* SCO only */
 } __attribute__ ((packed));
 
 /* BT_SETCONFIGURATION_REQ */
@@ -182,11 +187,10 @@
 
 /* BT_SETCONFIGURATION_RSP */
 struct bt_setconfiguration_rsp {
-	bt_audio_msg_header_t	h;
-	uint8_t			transport;		/* Granted transport */
-	uint8_t			access_mode;		/* Granted access mode */
-	uint16_t		link_mtu;		/* Max length that transport supports */
-	uint8_t			posix_errno;
+	bt_audio_rsp_msg_header_t	rsp_h;
+	uint8_t				transport;	/* Granted transport */
+	uint8_t				access_mode;	/* Granted access mode */
+	uint16_t			link_mtu;	/* Max length that transport supports */
 } __attribute__ ((packed));
 
 /* BT_STREAMSTART_REQ */
@@ -199,14 +203,13 @@
 
 /* BT_STREAMSTART_RSP */
 struct bt_streamstart_rsp {
-	bt_audio_msg_header_t	h;
-	uint8_t			posix_errno;
+	bt_audio_rsp_msg_header_t	rsp_h;
 } __attribute__ ((packed));
 
 /* BT_STREAMFD_IND */
 /* This message is followed by one byte of data containing the stream data fd
    as ancilliary data */
-struct bt_datafd_ind {
+struct bt_streamfd_ind {
 	bt_audio_msg_header_t	h;
 } __attribute__ ((packed));
 
@@ -217,8 +220,7 @@
 
 /* BT_STREAMSTOP_RSP */
 struct bt_streamstop_rsp {
-	bt_audio_msg_header_t	h;
-	uint8_t			posix_errno;
+	bt_audio_rsp_msg_header_t	rsp_h;
 } __attribute__ ((packed));
 
 /* BT_STREAMSUSPEND_IND */
@@ -255,10 +257,9 @@
 
 /* BT_CONTROL_RSP */
 struct bt_control_rsp {
-	bt_audio_msg_header_t	h;
-	uint8_t			posix_errno;
-	uint8_t			mode;		/* Control Mode */
-	uint8_t			key;		/* Control Key */
+	bt_audio_rsp_msg_header_t	rsp_h;
+	uint8_t				mode;	/* Control Mode */
+	uint8_t				key;	/* Control Key */
 } __attribute__ ((packed));
 
 /* BT_CONTROL_IND */
Index: unix.c
===================================================================
--- unix.c	(révision 360)
+++ unix.c	(copie de travail)
@@ -161,13 +161,13 @@
 static void unix_ipc_error(struct unix_client *client, int type, int err)
 {
 	char buf[BT_AUDIO_IPC_PACKET_SIZE];
-	struct bt_getcapabilities_rsp *rsp = (void *) buf;
+	bt_audio_rsp_msg_header_t *rsp_hdr = (void *) buf;
 
 	memset(buf, 0, sizeof(buf));
-	rsp->h.msg_type = type;
-	rsp->posix_errno = err;
+	rsp_hdr->msg_h.msg_type = type;
+	rsp_hdr->posix_errno = err;
 
-	unix_ipc_sendmsg(client, &rsp->h);
+	unix_ipc_sendmsg(client, &rsp_hdr->msg_h);
 }
 
 static service_type_t select_service(struct device *dev, const char *interface)
@@ -304,13 +304,13 @@
 
 	memset(buf, 0, sizeof(buf));
 
-	rsp->h.msg_type = BT_SETCONFIGURATION_RSP;
+	rsp->rsp_h.msg_h.msg_type = BT_SETCONFIGURATION_RSP;
 	rsp->transport  = BT_CAPABILITIES_TRANSPORT_SCO;
 	rsp->access_mode = client->access_mode;
 
 	client->data_fd = headset_get_sco_fd(dev);
 
-	unix_ipc_sendmsg(client, &rsp->h);
+	unix_ipc_sendmsg(client, &rsp->rsp_h.msg_h);
 }
 
 static void a2dp_discovery_complete(struct avdtp *session, GSList *seps,
@@ -330,7 +330,7 @@
 	memset(buf, 0, sizeof(buf));
 	client->req_id = 0;
 
-	rsp->h.msg_type = BT_GETCAPABILITIES_RSP;
+	rsp->rsp_h.msg_h.msg_type = BT_GETCAPABILITIES_RSP;
 	rsp->transport = BT_CAPABILITIES_TRANSPORT_A2DP;
 
 	for (l = seps; l; l = g_slist_next(l)) {
@@ -361,7 +361,7 @@
 		rsp->sbc_capabilities.max_bitpool = sbc_cap->max_bitpool;
 	}
 
-	unix_ipc_sendmsg(client, &rsp->h);
+	unix_ipc_sendmsg(client, &rsp->rsp_h.msg_h);
 
 	return;
 
@@ -406,14 +406,14 @@
 		goto failed;
 	}
 
-	rsp->h.msg_type = BT_SETCONFIGURATION_RSP;
+	rsp->rsp_h.msg_h.msg_type = BT_SETCONFIGURATION_RSP;
 	rsp->transport = BT_CAPABILITIES_TRANSPORT_A2DP;
 	client->access_mode = BT_CAPABILITIES_ACCESS_MODE_WRITE;
 	rsp->access_mode = client->access_mode;
 	/* FIXME: Use imtu when fd_opt is CFG_FD_OPT_READ */
 	rsp->link_mtu = omtu;
 
-	unix_ipc_sendmsg(client, &rsp->h);
+	unix_ipc_sendmsg(client, &rsp->rsp_h.msg_h);
 
 	client->cb_id = avdtp_stream_add_cb(session, stream,
 						stream_state_changed, client);
@@ -441,13 +441,13 @@
 	struct unix_client *client = user_data;
 	char buf[BT_AUDIO_IPC_PACKET_SIZE];
 	struct bt_streamstart_rsp *rsp = (void *) buf;
-	struct bt_datafd_ind *ind = (void *) buf;
+	struct bt_streamfd_ind *ind = (void *) buf;
 	struct a2dp_data *a2dp = &client->d.a2dp;
 
 	memset(buf, 0, sizeof(buf));
-	rsp->h.msg_type = BT_STREAMSTART_RSP;
-	rsp->posix_errno = 0;
-	unix_ipc_sendmsg(client, &rsp->h);
+	rsp->rsp_h.msg_h.msg_type = BT_STREAMSTART_RSP;
+	rsp->rsp_h.posix_errno = 0;
+	unix_ipc_sendmsg(client, &rsp->rsp_h.msg_h);
 
 	memset(buf, 0, sizeof(buf));
 	ind->h.msg_type = BT_STREAMFD_IND;
@@ -487,9 +487,9 @@
 		goto failed;
 
 	memset(buf, 0, sizeof(buf));
-	rsp->h.msg_type = BT_STREAMSTOP_RSP;
-	rsp->posix_errno = 0;
-	unix_ipc_sendmsg(client, &rsp->h);
+	rsp->rsp_h.msg_h.msg_type = BT_STREAMSTOP_RSP;
+	rsp->rsp_h.posix_errno = 0;
+	unix_ipc_sendmsg(client, &rsp->rsp_h.msg_h);
 
 	return;
 
@@ -863,10 +863,10 @@
 	struct bt_setconfiguration_rsp *rsp = (void *) buf;
 
 	memset(buf, 0, sizeof(buf));
-	rsp->h.msg_type = BT_CONTROL_RSP;
-	rsp->posix_errno = 0;
+	rsp->rsp_h.msg_h.msg_type = BT_CONTROL_RSP;
+	rsp->rsp_h.posix_errno = 0;
 
-	unix_ipc_sendmsg(client, &rsp->h);
+	unix_ipc_sendmsg(client, &rsp->rsp_h.msg_h);
 }
 
 static gboolean client_cb(GIOChannel *chan, GIOCondition cond, gpointer data)
Index: gsta2dpsink.c
===================================================================
--- gsta2dpsink.c	(révision 360)
+++ gsta2dpsink.c	(copie de travail)
@@ -582,6 +582,7 @@
 {
 	gchar *buf[BT_AUDIO_IPC_PACKET_SIZE];
 	struct bt_getcapabilities_req *req = (void *) buf;
+	bt_audio_rsp_msg_header_t *rsp_hdr = (void *) buf;
 	struct bt_getcapabilities_rsp *rsp = (void *) buf;
 	GIOError io_error;
 
@@ -595,17 +596,17 @@
 		GST_ERROR_OBJECT(self, "Error while asking device caps");
 	}
 
-	io_error = gst_a2dp_sink_audioservice_expect(self, &rsp->h,
+	io_error = gst_a2dp_sink_audioservice_expect(self, &rsp_hdr->msg_h,
 			BT_GETCAPABILITIES_RSP);
 	if (io_error != G_IO_ERROR_NONE) {
 		GST_ERROR_OBJECT(self, "Error while getting device caps");
 		return FALSE;
 	}
 
-	if (rsp->posix_errno != 0) {
+	if (rsp_hdr->posix_errno != 0) {
 		GST_ERROR_OBJECT(self, "BT_GETCAPABILITIES failed : %s(%d)",
-					strerror(rsp->posix_errno),
-					rsp->posix_errno);
+					strerror(rsp_hdr->posix_errno),
+					rsp_hdr->posix_errno);
 		return FALSE;
 	}
 
@@ -660,8 +661,8 @@
 {
 	gchar buf[BT_AUDIO_IPC_PACKET_SIZE];
 	struct bt_streamstart_req *req = (void *) buf;
-	struct bt_streamstart_rsp *rsp = (void *) buf;
-	struct bt_datafd_ind *ind = (void*) buf;
+	bt_audio_rsp_msg_header_t *rsp_hdr = (void *) buf;
+	struct bt_streamfd_ind *ind = (void*) buf;
 	GIOError io_error;
 
 	GST_DEBUG_OBJECT(self, "stream start");
@@ -678,17 +679,17 @@
 
 	GST_DEBUG_OBJECT(self, "stream start packet sent");
 
-	io_error = gst_a2dp_sink_audioservice_expect(self, &rsp->h,
+	io_error = gst_a2dp_sink_audioservice_expect(self, &rsp_hdr->msg_h,
 			BT_STREAMSTART_RSP);
 	if (io_error != G_IO_ERROR_NONE) {
 		GST_ERROR_OBJECT(self, "Error while stream start confirmation");
 		return FALSE;
 	}
 
-	if (rsp->posix_errno != 0) {
+	if (rsp_hdr->posix_errno != 0) {
 		GST_ERROR_OBJECT(self, "BT_STREAMSTART_RSP failed : %s(%d)",
-					strerror(rsp->posix_errno),
-					rsp->posix_errno);
+					strerror(rsp_hdr->posix_errno),
+					rsp_hdr->posix_errno);
 		return FALSE;
 	}
 
@@ -711,6 +712,7 @@
 {
 	gchar buf[BT_AUDIO_IPC_PACKET_SIZE];
 	struct bt_setconfiguration_req *req = (void *) buf;
+	bt_audio_rsp_msg_header_t *rsp_hdr  = (void *) buf;
 	struct bt_setconfiguration_rsp *rsp = (void *) buf;
 	gboolean ret;
 	GIOError io_error;
@@ -737,17 +739,17 @@
 
 	GST_DEBUG_OBJECT(self, "configuration packet sent");
 
-	io_error = gst_a2dp_sink_audioservice_expect(self, &rsp->h,
+	io_error = gst_a2dp_sink_audioservice_expect(self, &rsp_hdr->msg_h,
 			BT_SETCONFIGURATION_RSP);
 	if (io_error != G_IO_ERROR_NONE) {
 		GST_ERROR_OBJECT(self, "Error while receiving device confirmation");
 		return FALSE;
 	}
 
-	if (rsp->posix_errno != 0) {
+	if (rsp_hdr->posix_errno != 0) {
 		GST_ERROR_OBJECT(self, "BT_SETCONFIGURATION_RSP failed : %s(%d)",
-					strerror(rsp->posix_errno),
-					rsp->posix_errno);
+					strerror(rsp_hdr->posix_errno),
+					rsp_hdr->posix_errno);
 		return FALSE;
 	}
 
Index: ctl_bluetooth.c
===================================================================
--- ctl_bluetooth.c	(révision 304)
+++ ctl_bluetooth.c	(copie de travail)
@@ -164,24 +164,24 @@
 		return  -errno;
 	}
 
-	type = bt_audio_strmsg(ctl_rsp->h.msg_type);
+	type = bt_audio_strmsg(ctl_rsp->rsp_h.msg_h.msg_type);
 	if (!type) {
 		SNDERR("Bogus message type %d "
 				"received from audio service",
-				ctl_rsp->h.msg_type);
+				ctl_rsp->rsp_h.msg_h.msg_type);
 		return -EINVAL;
 	}
 
-	if (ctl_rsp->h.msg_type != BT_CONTROL_RSP) {
+	if (ctl_rsp->rsp_h.msg_h.msg_type != BT_CONTROL_RSP) {
 		SNDERR("Unexpected message %s received", type);
 		return -EINVAL;
 	}
 
-	if (ctl_rsp->posix_errno != 0) {
+	if (ctl_rsp->rsp_h.posix_errno != 0) {
 		SNDERR("BT_CONTROL failed : %s (%d)",
-					strerror(ctl_rsp->posix_errno),
-					ctl_rsp->posix_errno);
-		return -ctl_rsp->posix_errno;
+					strerror(ctl_rsp->rsp_h.posix_errno),
+					ctl_rsp->rsp_h.posix_errno);
+		return -ctl_rsp->rsp_h.posix_errno;
 	}
 
 	return 0;

--------------020208010909010008090608
Content-Type: text/x-vcard; charset=utf-8;
 name="fchevalier.vcf"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="fchevalier.vcf"

YmVnaW46dmNhcmQNCmZuOkZhYmllbiBDSEVWQUxJRVINCm46Q0hFVkFMSUVSO0ZhYmllbg0K
b3JnOlNJTElDT00NCmFkcjo7OzQgcnVlIGRlIEpvdWFuZXQ7IFJFTk5FUyBBVEFMQU5URTs7
MzU3MDA7RlJBTkNFDQplbWFpbDtpbnRlcm5ldDpmY2hldmFsaWVyQHNpbGljb20uZnINCnRp
dGxlOlNvZnR3YXJlICYgU3R1ZGllcyBFbmdpbmVlcg0KdGVsO3dvcms6KzMzICgwKSAyIDk5
IDg0IDE3IDE3DQp2ZXJzaW9uOjIuMQ0KZW5kOnZjYXJkDQoNCg==
--------------020208010909010008090608
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
SF.Net email is sponsored by: The Future of Linux Business White Paper
from Novell.  From the desktop to the data center, Linux is going
mainstream.  Let it simplify your IT future.
http://altfarm.mediaplex.com/ad/ck/8857-50307-18918-4
--------------020208010909010008090608
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--------------020208010909010008090608--
