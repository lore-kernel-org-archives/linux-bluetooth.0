Return-Path: <cyrus@holtmann.org>
From: Steve Grubb <sgrubb@redhat.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] init and extra checking fixups
Date: Sat, 26 Sep 2009 12:37:58 -0400
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Message-Id: <200909261237.58379.sgrubb@redhat.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello,

I was doing some code reviews of the 4.54 release and found a couple
things that should be fixed up. This patch is looking at things that may not
have been initialized or is doing value checks that are unnecessary.

In audio/avdtp.c, the avdtp_setconf_cmd function has an exit jump for failed.
There are several calls to the goto that do not set err to something, meaning
that the stack contents are what's used. I set err =0 in the beginning so that
we no longer use the stack contents, but it seems like there should be some
general error code that says we failed for an unspecified reason.

In audio/control.c, the function control_cb takes a variable cond and first
thing it or's G_IO_IN with it and uses the result for a test in an if
statement. I suspect it should be a '&' operator.

In audio/unix.c, the function a2dp_discovery_complete at line 659 has a
variable ca2dp. There is a check at line 661 to see that its not NULL. It can
never be NULL because its position in the unix_client structure will never
let it be NULL. So, this check should be dropped.

In compat/hidd.c, there is a function do_connect with a variable, name. It
could conceivably be uninitialized when used in a strcmp at line 473. 

In lib/sdp.c, the function sdp_get_lang_attr has a variable pCode that is
being checked for non-NULL at line 2029. It gets its value from curr_data which
has to be non-NULL to enter the loop. So, checking pCode does nothing. It
should be dropped.

Same file, in the function sdp_service_attr_req there is a variable
rsp_concat_buf. If the allocations for reqbuf or rspbuf fail, it goes to end
where it will attempt to free rsp_concat_buf.data which is whatever the stack
contents are. This same issue pops up again in the function,
sdp_service_search_attr_req a little farther down.

NOT FIXED - In src/sdpd-service.c, the function create_ext_inquiry_response
has a variable uuid that is used at line 223 in an equality test without
having been initialized. No idea what the right code for that is.

In tools/hcitool.c, around line 687, handle could conceivably be used without
being initialized. I set it to 0.

Signed-off-by: Steve Grubb <sgrubb@redhat.com>


diff -urp bluez-4.54.orig/audio/avdtp.c bluez-4.54/audio/avdtp.c
--- bluez-4.54.orig/audio/avdtp.c	2009-09-26 08:43:56.000000000 -0400
+++ bluez-4.54/audio/avdtp.c	2009-09-26 11:17:07.000000000 -0400
@@ -1248,7 +1248,7 @@ static gboolean avdtp_setconf_cmd(struct
 	struct conf_rej rej;
 	struct avdtp_local_sep *sep;
 	struct avdtp_stream *stream;
-	uint8_t err, category = 0x00;
+	uint8_t err = 0, category = 0x00;
 	struct audio_device *dev;
 	bdaddr_t src, dst;
 	GSList *l;
diff -urp bluez-4.54.orig/audio/control.c bluez-4.54/audio/control.c
--- bluez-4.54.orig/audio/control.c	2009-09-26 08:43:56.000000000 -0400
+++ bluez-4.54/audio/control.c	2009-09-26 11:24:04.000000000 -0400
@@ -472,7 +472,7 @@ static gboolean control_cb(GIOChannel *c
 	struct avrcp_header *avrcp;
 	int ret, packet_size, operand_count, sock;
 
-	if (!(cond | G_IO_IN))
+	if (!(cond & G_IO_IN))
 		goto failed;
 
 	sock = g_io_channel_unix_get_fd(control->io);
diff -urp bluez-4.54.orig/audio/gsta2dpsink.c bluez-4.54/audio/gsta2dpsink.c
--- bluez-4.54.orig/audio/gsta2dpsink.c	2009-09-26 08:43:56.000000000 -0400
+++ bluez-4.54/audio/gsta2dpsink.c	2009-09-26 11:47:40.000000000 -0400
@@ -143,8 +143,7 @@ remove_element_and_fail:
 	return NULL;
 
 cleanup_and_fail:
-	if (element != NULL)
-		g_object_unref(G_OBJECT(element));
+	g_object_unref(G_OBJECT(element));
 
 	return NULL;
 }
diff -urp bluez-4.54.orig/audio/unix.c bluez-4.54/audio/unix.c
--- bluez-4.54.orig/audio/unix.c	2009-09-26 08:43:56.000000000 -0400
+++ bluez-4.54/audio/unix.c	2009-09-26 12:03:47.000000000 -0400
@@ -658,8 +658,7 @@ static void a2dp_discovery_complete(stru
 			struct unix_client *c = cl->data;
 			struct a2dp_data *ca2dp = &c->d.a2dp;
 
-			if (ca2dp && ca2dp->session == session &&
-					c->seid == seid) {
+			if (ca2dp->session == session && c->seid == seid) {
 				lock = c->lock;
 				break;
 			}
diff -urp bluez-4.54.orig/compat/hidd.c bluez-4.54/compat/hidd.c
--- bluez-4.54.orig/compat/hidd.c	2009-09-26 08:43:56.000000000 -0400
+++ bluez-4.54/compat/hidd.c	2009-09-26 12:10:14.000000000 -0400
@@ -453,6 +453,7 @@ static void do_connect(int ctl, bdaddr_t
 	int csk, isk, err;
 
 	memset(&req, 0, sizeof(req));
+	name[0] = 0;
 
 	err = get_sdp_device_info(src, dst, &req);
 	if (err < 0 && fakehid)
diff -urp bluez-4.54.orig/lib/sdp.c bluez-4.54/lib/sdp.c
--- bluez-4.54.orig/lib/sdp.c	2009-09-26 08:43:56.000000000 -0400
+++ bluez-4.54/lib/sdp.c	2009-09-26 12:22:08.000000000 -0400
@@ -2026,7 +2026,7 @@ int sdp_get_lang_attr(const sdp_record_t
 		sdp_data_t *pCode = curr_data;
 		sdp_data_t *pEncoding = pCode->next;
 		sdp_data_t *pOffset = pEncoding->next;
-		if (pCode && pEncoding && pOffset) {
+		if (pEncoding && pOffset) {
 			lang = malloc(sizeof(sdp_lang_attr_t));
 			lang->code_ISO639 = pCode->val.uint16;
 			lang->encoding = pEncoding->val.uint16;
@@ -3473,6 +3473,7 @@ sdp_record_t *sdp_service_attr_req(sdp_s
 	rspbuf = malloc(SDP_RSP_BUFFER_SIZE);
 	if (!reqbuf || !rspbuf) {
 		errno = ENOMEM;
+		rsp_concat_buf.data = NULL;
 		goto end;
 	}
 	memset((char *) &rsp_concat_buf, 0, sizeof(sdp_buf_t));
@@ -4293,6 +4294,7 @@ int sdp_service_search_attr_req(sdp_sess
 	if (!reqbuf || !rspbuf) {
 		errno = ENOMEM;
 		status = -1;
+		rsp_concat_buf.data = NULL;
 		goto end;
 	}
 
diff -urp bluez-4.54.orig/tools/hcitool.c bluez-4.54/tools/hcitool.c
--- bluez-4.54.orig/tools/hcitool.c	2009-09-26 08:43:56.000000000 -0400
+++ bluez-4.54/tools/hcitool.c	2009-09-26 12:31:28.000000000 -0400
@@ -505,7 +505,7 @@ static void cmd_scan(int dev_id, int arg
 	uint8_t lap[3] = { 0x33, 0x8b, 0x9e };
 	int num_rsp, length, flags;
 	uint8_t cls[3], features[8];
-	uint16_t handle;
+	uint16_t handle = 0;
 	char addr[18], name[249], oui[9], *comp, *tmp;
 	struct hci_version version;
 	struct hci_dev_info di;
