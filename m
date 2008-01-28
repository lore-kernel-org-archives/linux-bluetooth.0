Return-Path: <cyrus@holtmann.org>
Message-ID: <479E2588.2010403@access-company.com>
Date: Mon, 28 Jan 2008 19:57:12 +0100
From: =?ISO-8859-1?Q?Fr=E9d=E9ric_Dalleau?= <frederic.dalleau@access-company.com>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="------------020209040104010808070705"
Subject: [Bluez-devel] [patch] check connection before connecting
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
--------------020209040104010808070705
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit

For review only,

This patch checks that a device is already connected before trying to 
connect. If no device is connected, opening the alsa plugin will fail 
instead of forcing connection to default device (which is blocking).
This behavior can be enabled or disabled thanks to an option in .asoundrc.

pcm.bt {
    type bluetooth
    check_conn "yes"
}

It poorly tested now and mainly targeted for comments.

BR,
Frédéric




--------------020209040104010808070705
Content-Type: text/x-patch;
 name="check_conn.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="check_conn.patch"

diff --git a/audio/ipc.c b/audio/ipc.c
index 0592064..195f40f 100644
--- a/audio/ipc.c
+++ b/audio/ipc.c
@@ -38,6 +38,8 @@ static const char *strmsg[] = {
 	"BT_CONTROL_RSP",
 	"BT_CONTROL_IND",
 	"BT_STREAMFD_IND",
+	"BT_ISCONNECTED_REQ",
+	"BT_ISCONNECTED_RSP",
 };
 
 int bt_audio_service_open()
diff --git a/audio/ipc.h b/audio/ipc.h
index 3768dcf..1e83cbe 100644
--- a/audio/ipc.h
+++ b/audio/ipc.h
@@ -107,6 +107,9 @@ typedef struct {
 
 #define BT_STREAMFD_IND		       13
 
+#define BT_ISCONNECTED_REQ		14
+#define BT_ISCONNECTED_RSP		15
+
 /* BT_GETCAPABILITIES_REQ */
 
 #define BT_CAPABILITIES_TRANSPORT_A2DP	0
@@ -229,6 +232,16 @@ struct bt_streamfd_ind {
 	bt_audio_msg_header_t	h;
 } __attribute__ ((packed));
 
+/* BT_ISCONNECTED_REQ */
+struct bt_isconnected_req {
+	bt_audio_msg_header_t	h;
+} __attribute__ ((packed));
+
+/* BT_ISCONNECTED_RSP */
+struct bt_isconnected_rsp {
+	bt_audio_rsp_msg_header_t	rsp_h;
+} __attribute__ ((packed));
+
 /* BT_STREAMSTOP_REQ */
 struct bt_streamstop_req {
 	bt_audio_msg_header_t	h;
diff --git a/audio/manager.h b/audio/manager.h
index e740a52..ca23fad 100644
--- a/audio/manager.h
+++ b/audio/manager.h
@@ -42,6 +42,7 @@ void audio_exit(void);
 uint32_t add_service_record(DBusConnection *conn, sdp_buf_t *buf);
 int remove_service_record(DBusConnection *conn, uint32_t rec_id);
 gboolean server_is_enabled(uint16_t svc);
+struct device *manager_get_connected_device(void);
 
 struct device *manager_find_device(bdaddr_t *bda, const char *interface,
 					gboolean connected);
diff --git a/audio/pcm_bluetooth.c b/audio/pcm_bluetooth.c
index a04f18c..a1ed9a0 100644
--- a/audio/pcm_bluetooth.c
+++ b/audio/pcm_bluetooth.c
@@ -122,6 +122,7 @@ struct bluetooth_alsa_config {
 	int has_block_length;
 	uint8_t bitpool;		/* A2DP only */
 	int has_bitpool;
+	int check_conn;			/* A2DP only */
 };
 
 struct bluetooth_data {
@@ -1268,7 +1269,7 @@ static int bluetooth_parse_config(snd_config_t *conf,
 				struct bluetooth_alsa_config *bt_config)
 {
 	snd_config_iterator_t i, next;
-	const char *addr, *pref;
+	const char *addr, *pref, *check;
 	const char *mode, *allocation, *rate, *subbands, *blocks, *bitpool;
 
 	memset(bt_config, 0, sizeof(struct bluetooth_alsa_config));
@@ -1283,6 +1284,17 @@ static int bluetooth_parse_config(snd_config_t *conf,
 		if (strcmp(id, "comment") == 0 || strcmp(id, "type") == 0)
 			continue;
 
+		if (strcmp(id, "check_conn") == 0) {
+			if (snd_config_get_string(n, &check) < 0) {
+				SNDERR("Invalid type for %s", id);
+				return -EINVAL;
+			}
+
+			if (strcmp(check, "yes") == 0)
+				bt_config->check_conn = 1;
+			continue;
+		}
+
 		if (strcmp(id, "device") == 0 || strcmp(id, "bdaddr") == 0) {
 			if (snd_config_get_string(n, &addr) < 0) {
 				SNDERR("Invalid type for %s", id);
@@ -1477,6 +1489,7 @@ static int bluetooth_init(struct bluetooth_data *data, snd_pcm_stream_t stream,
 	bt_audio_rsp_msg_header_t *rsp_hdr = (void*) buf;
 	struct bt_getcapabilities_req *getcaps_req = (void*) buf;
 	struct bt_getcapabilities_rsp *getcaps_rsp = (void*) buf;
+	struct bt_isconnected_req *isconnected_req = (void*) buf;
 
 	memset(data, 0, sizeof(struct bluetooth_data));
 
@@ -1512,6 +1525,26 @@ static int bluetooth_init(struct bluetooth_data *data, snd_pcm_stream_t stream,
 		goto failed;
 	}
 
+	/* send isconnected */
+	if(alsa_conf->check_conn) {
+		memset(isconnected_req, 0, BT_AUDIO_IPC_PACKET_SIZE);
+		isconnected_req->h.msg_type = BT_ISCONNECTED_REQ;
+
+		err = audioservice_send(data->server.fd, &isconnected_req->h);
+		if (err < 0)
+			goto failed;
+	
+		err = audioservice_expect(data->server.fd, &rsp_hdr->msg_h,
+					BT_ISCONNECTED_RSP);
+		if (err < 0)
+			goto failed;
+	
+		if(rsp_hdr->posix_errno != 0) {
+			return -rsp_hdr->posix_errno;
+		}
+	}
+
+	/* send getcapabilities */
 	memset(getcaps_req, 0, BT_AUDIO_IPC_PACKET_SIZE);
 	getcaps_req->h.msg_type = BT_GETCAPABILITIES_REQ;
 	strncpy(getcaps_req->device, alsa_conf->device, 18);
diff --git a/audio/unix.c b/audio/unix.c
index d71c420..cf33618 100644
--- a/audio/unix.c
+++ b/audio/unix.c
@@ -909,6 +909,34 @@ failed:
 	unix_ipc_error(client, BT_STREAMSTART_REQ, EIO);
 }
 
+
+static void handle_isconnected_req(struct unix_client *client,
+				   struct bt_streamstart_req *req)
+{
+	/* FIXME: really implement that */
+	char buf[BT_AUDIO_IPC_PACKET_SIZE];
+	struct bt_setconfiguration_rsp *rsp = (void *) buf;
+
+	debug("%s", __FUNCTION__);
+
+	if (!manager_get_connected_device())
+		goto failed;
+
+	debug("%s connected", __FUNCTION__);
+	
+	memset(buf, 0, sizeof(buf));
+	rsp->rsp_h.msg_h.msg_type = BT_ISCONNECTED_RSP;
+	rsp->rsp_h.posix_errno = 0;
+
+	unix_ipc_sendmsg(client, &rsp->rsp_h.msg_h);
+
+	return;
+
+failed:
+	debug("%s not connected", __FUNCTION__);
+	unix_ipc_error(client, BT_ISCONNECTED_RSP, ENOTCONN);
+}
+
 static void handle_streamstop_req(struct unix_client *client,
 					struct bt_streamstop_req *req)
 {
@@ -997,6 +1025,10 @@ static gboolean client_cb(GIOChannel *chan, GIOCondition cond, gpointer data)
 		handle_streamstart_req(client,
 				(struct bt_streamstart_req *) msghdr);
 		break;
+	case BT_ISCONNECTED_REQ:
+		handle_isconnected_req(client,
+			       (struct bt_streamstart_req *) msghdr);
+		break;
 	case BT_STREAMSTOP_REQ:
 		handle_streamstop_req(client,
 				(struct bt_streamstop_req *) msghdr);

--------------020209040104010808070705
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
--------------020209040104010808070705
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--------------020209040104010808070705--
