Return-Path: <cyrus@holtmann.org>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH 2/2] Fix common misspelled words
Date: Sat,  2 Jul 2011 12:32:40 -0300
Message-Id: <1309620760-17968-2-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1309620760-17968-1-git-send-email-lucas.demarchi@profusion.mobi>
References: <1309620760-17968-1-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Accounting of misspelled words, as detected by codespell:

acording      2
ancilliary    1
appropiate    1
atribute      1
cant          1
comming       2
gracefull     1
lenght        1
mispelled     1
occured       1
occurences    1
ocurred       3
prefered      1
presense      1
reponse       1
seperate      1
succesful     1
successully   1
sucessfull    1
sucessfully   1
---
 attrib/att.c         |    2 +-
 attrib/gatttool.c    |    2 +-
 audio/avdtp.c        |    4 ++--
 audio/gstavdtpsink.c |    6 +++---
 audio/gstsbcutil.c   |    2 +-
 audio/ipc.h          |    2 +-
 doc/adapter-api.txt  |    2 +-
 doc/audio-api.txt    |    2 +-
 health/mcap.c        |    2 +-
 serial/proxy.c       |    2 +-
 src/sdpd-request.c   |    4 ++--
 test/apitest         |    2 +-
 test/bdaddr.c        |    2 +-
 test/sap-client      |    2 +-
 test/test-health     |    2 +-
 tools/hciattach.c    |    4 ++--
 tools/rfcomm.1       |    2 +-
 tools/ubcsp.c        |    4 ++--
 18 files changed, 24 insertions(+), 24 deletions(-)

diff --git a/attrib/att.c b/attrib/att.c
index 972f8bf..1ce0f7b 100644
--- a/attrib/att.c
+++ b/attrib/att.c
@@ -39,7 +39,7 @@ const char *att_ecode2str(uint8_t status)
 	case ATT_ECODE_INVALID_HANDLE:
 		return "Invalid handle";
 	case ATT_ECODE_READ_NOT_PERM:
-		return "Atribute can't be read";
+		return "Attribute can't be read";
 	case ATT_ECODE_WRITE_NOT_PERM:
 		return "Attribute can't be written";
 	case ATT_ECODE_INVALID_PDU:
diff --git a/attrib/gatttool.c b/attrib/gatttool.c
index cf052db..17ee913 100644
--- a/attrib/gatttool.c
+++ b/attrib/gatttool.c
@@ -370,7 +370,7 @@ static void char_write_req_cb(guint8 status, const guint8 *pdu, guint16 plen,
 		goto done;
 	}
 
-	g_print("Characteristic value was written sucessfully\n");
+	g_print("Characteristic value was written successfully\n");
 
 done:
 	if (opt_listen == FALSE)
diff --git a/audio/avdtp.c b/audio/avdtp.c
index e8a4007..c7e5f87 100644
--- a/audio/avdtp.c
+++ b/audio/avdtp.c
@@ -2168,7 +2168,7 @@ static gboolean session_cb(GIOChannel *chan, GIOCondition cond,
 	}
 
 	if (session->in.signal_id != session->req->signal_id) {
-		error("Reponse signal doesn't match");
+		error("Response signal doesn't match");
 		return TRUE;
 	}
 
@@ -3753,7 +3753,7 @@ const char *avdtp_strerror(struct avdtp_error *err)
 	case AVDTP_BAD_HEADER_FORMAT:
 		return "Bad Header Format";
 	case AVDTP_BAD_LENGTH:
-		return "Bad Packet Lenght";
+		return "Bad Packet Length";
 	case AVDTP_BAD_ACP_SEID:
 		return "Bad Acceptor SEID";
 	case AVDTP_SEP_IN_USE:
diff --git a/audio/gstavdtpsink.c b/audio/gstavdtpsink.c
index cab366b..0f3abf3 100644
--- a/audio/gstavdtpsink.c
+++ b/audio/gstavdtpsink.c
@@ -1491,7 +1491,7 @@ static gboolean gst_avdtp_sink_stream_start(GstAvdtpSink *self)
 
 	err = gst_avdtp_sink_audioservice_send(self, &req->h);
 	if (err < 0) {
-		GST_ERROR_OBJECT(self, "Error ocurred while sending "
+		GST_ERROR_OBJECT(self, "Error occurred while sending "
 					"start packet");
 		return FALSE;
 	}
@@ -1643,7 +1643,7 @@ static gboolean gst_avdtp_sink_configure(GstAvdtpSink *self,
 
 	err = gst_avdtp_sink_audioservice_send(self, &open_req->h);
 	if (err < 0) {
-		GST_ERROR_OBJECT(self, "Error ocurred while sending "
+		GST_ERROR_OBJECT(self, "Error occurred while sending "
 					"open packet");
 		return FALSE;
 	}
@@ -1679,7 +1679,7 @@ static gboolean gst_avdtp_sink_configure(GstAvdtpSink *self,
 	req->h.length += req->codec.length - sizeof(req->codec);
 	err = gst_avdtp_sink_audioservice_send(self, &req->h);
 	if (err < 0) {
-		GST_ERROR_OBJECT(self, "Error ocurred while sending "
+		GST_ERROR_OBJECT(self, "Error occurred while sending "
 					"configurarion packet");
 		return FALSE;
 	}
diff --git a/audio/gstsbcutil.c b/audio/gstsbcutil.c
index 63c90c2..ac5fcbf 100644
--- a/audio/gstsbcutil.c
+++ b/audio/gstsbcutil.c
@@ -311,7 +311,7 @@ GstCaps *gst_sbc_parse_caps_from_sbc(sbc_t *sbc)
 }
 
 /*
- * Given a GstCaps, this will return a fixed GstCaps on sucessfull conversion.
+ * Given a GstCaps, this will return a fixed GstCaps on successful conversion.
  * If an error occurs, it will return NULL and error_message will contain the
  * error message.
  *
diff --git a/audio/ipc.h b/audio/ipc.h
index d69b97e..f595775 100644
--- a/audio/ipc.h
+++ b/audio/ipc.h
@@ -264,7 +264,7 @@ struct bt_start_stream_rsp {
 } __attribute__ ((packed));
 
 /* This message is followed by one byte of data containing the stream data fd
-   as ancilliary data */
+   as ancillary data */
 struct bt_new_stream_ind {
 	bt_audio_msg_header_t	h;
 } __attribute__ ((packed));
diff --git a/doc/adapter-api.txt b/doc/adapter-api.txt
index f34d58f..3a29295 100644
--- a/doc/adapter-api.txt
+++ b/doc/adapter-api.txt
@@ -228,7 +228,7 @@ Properties	string Address [readonly]
 		boolean Powered [readwrite]
 
 			Switch an adapter on or off. This will also set the
-			appropiate connectable state.
+			appropriate connectable state.
 
 		boolean Discoverable [readwrite]
 
diff --git a/doc/audio-api.txt b/doc/audio-api.txt
index 0f320d9..b85400b 100644
--- a/doc/audio-api.txt
+++ b/doc/audio-api.txt
@@ -430,7 +430,7 @@ properties	boolean Connected [readonly]
 
 			Service availability indicatior of AG, where:
 			0 implies no service. No Home/Roam network available.
-			1 implies presense of service. Home/Roam network
+			1 implies presence of service. Home/Roam network
 			available.
 
 		uint16 SignalStrength [readonly]
diff --git a/health/mcap.c b/health/mcap.c
index 793c32d..7bfc0dc 100644
--- a/health/mcap.c
+++ b/health/mcap.c
@@ -791,7 +791,7 @@ static void mcap_cache_mcl(struct mcap_mcl *mcl)
 		last->ctrl &= ~MCAP_CTRL_CACHED;
 		if (last->ctrl & MCAP_CTRL_CONN) {
 			/* We have to release this MCL if */
-			/* connection is not succesful    */
+			/* connection is not successful    */
 			last->ctrl |= MCAP_CTRL_FREE;
 		} else {
 			mcap_mcl_release(last);
diff --git a/serial/proxy.c b/serial/proxy.c
index 457959c..f9aa41b 100644
--- a/serial/proxy.c
+++ b/serial/proxy.c
@@ -810,7 +810,7 @@ static int proxy_tty_register(struct serial_adapter *adapter,
 
 	sk = open(address, O_RDONLY | O_NOCTTY);
 	if (sk < 0) {
-		error("Cant open TTY: %s(%d)", strerror(errno), errno);
+		error("Can't open TTY: %s(%d)", strerror(errno), errno);
 		return -EINVAL;
 	}
 
diff --git a/src/sdpd-request.c b/src/sdpd-request.c
index 9920e9b..ff00df7 100644
--- a/src/sdpd-request.c
+++ b/src/sdpd-request.c
@@ -698,7 +698,7 @@ static int service_attr_req(sdp_req_t *req, sdp_buf_t *buf)
 	}
 
 	/*
-	 * Calculate Attribute size acording to MTU
+	 * Calculate Attribute size according to MTU
 	 * We can send only (MTU - sizeof(sdp_pdu_hdr_t) - sizeof(sdp_cont_state_t))
 	 */
 	max_rsp_size = MIN(max_rsp_size, req->mtu - sizeof(sdp_pdu_hdr_t) -
@@ -853,7 +853,7 @@ static int service_search_attr_req(sdp_req_t *req, sdp_buf_t *buf)
 	memset(tmpbuf.data, 0, USHRT_MAX);
 
 	/*
-	 * Calculate Attribute size acording to MTU
+	 * Calculate Attribute size according to MTU
 	 * We can send only (MTU - sizeof(sdp_pdu_hdr_t) - sizeof(sdp_cont_state_t))
 	 */
 	max = MIN(max, req->mtu - sizeof(sdp_pdu_hdr_t) - SDP_CONT_STATE_SIZE - sizeof(uint16_t));
diff --git a/test/apitest b/test/apitest
index b1c3f10..f1d51f1 100755
--- a/test/apitest
+++ b/test/apitest
@@ -403,7 +403,7 @@ class Tester:
                    print 'Usage: %s -i <dev> ListRecentRemoteDevices date' % self.name
            else:
                 # FIXME: remove at future version
-                print 'Script Error: Method %s not found. Maybe a mispelled word.' % (self.cmd_args)
+                print 'Script Error: Method %s not found. Maybe a misspelled word.' % (self.cmd_args)
        except dbus.DBusException, e:
            print '%s failed: %s' % (self.cmd, e)
            sys.exit(1)
diff --git a/test/bdaddr.c b/test/bdaddr.c
index 683b3b9..f87fa38 100644
--- a/test/bdaddr.c
+++ b/test/bdaddr.c
@@ -437,7 +437,7 @@ int main(int argc, char *argv[])
 					printf("Reset device manually\n");
 				} else {
 					ioctl(dd, HCIDEVRESET, dev);
-					printf("Device reset successully\n");
+					printf("Device reset successfully\n");
 				}
 			} else {
 				printf("Reset device now\n");
diff --git a/test/sap-client b/test/sap-client
index b12d455..413424c 100644
--- a/test/sap-client
+++ b/test/sap-client
@@ -829,7 +829,7 @@ class SAPClient:
         try:
             params = self.__rcvMsg(SAPMessage_DISCONNECT_IND()).getParams()
 
-            """gracefull"""
+            """graceful"""
             if params[0].getValue() == 0x00:
                 if not self.proc_transferAPDU():
                     return False
diff --git a/test/test-health b/test/test-health
index 28cc894..16a5a2b 100755
--- a/test/test-health
+++ b/test/test-health
@@ -83,7 +83,7 @@ pref = None
 if role == "Source":
 	while pref == None:
 		try:
-			print "Select a prefered data channel type 1.",
+			print "Select a preferred data channel type 1.",
 			print "reliable 2. streaming: ",
 			sel = int(sys.stdin.readline())
 			if sel == 1:
diff --git a/tools/hciattach.c b/tools/hciattach.c
index 93bdaac..1b577ec 100644
--- a/tools/hciattach.c
+++ b/tools/hciattach.c
@@ -780,12 +780,12 @@ static int swave(int fd, struct uart_t *u, struct termios *ti)
 	nanosleep(&tm, NULL);
 
 	// now the uart baud rate on the silicon wave module is set and effective.
-	// change our own baud rate as well. Then there is a reset event comming in
+	// change our own baud rate as well. Then there is a reset event coming in
  	// on the *new* baud rate. This is *undocumented*! The packet looks like this:
 	// 04 FF 01 0B (which would make that a confirmation of 0x0B = "Param
 	// subcommand class". So: change to new baud rate, read with timeout, parse
 	// data, error handling. BTW: all param access in Silicon Wave is done this way.
-	// Maybe this code would belong in a seperate file, or at least code reuse...
+	// Maybe this code would belong in a separate file, or at least code reuse...
 
 	return 0;
 }
diff --git a/tools/rfcomm.1 b/tools/rfcomm.1
index 06252e5..06303cd 100644
--- a/tools/rfcomm.1
+++ b/tools/rfcomm.1
@@ -99,7 +99,7 @@ If no channel is specified, it will use the channel number 1, but
 a channel must be specified before cmd. If cmd is given, it will be
 executed as soon as a client connects. When the child process
 terminates or the client disconnect, the command will terminate.
-Occurences of {} in cmd will be replaced by the name of the device
+Occurrences of {} in cmd will be replaced by the name of the device
 used by the connection. This command can be terminated with the key
 sequence CTRL-C.
 .TP
diff --git a/tools/ubcsp.c b/tools/ubcsp.c
index 3d4cd99..a4edd9c 100644
--- a/tools/ubcsp.c
+++ b/tools/ubcsp.c
@@ -723,7 +723,7 @@ static uint8 ubcsp_recevied_packet (void)
 		}
 	}
 
-	/* Just return any activity that occured */
+	/* Just return any activity that occurred */
 
 	return activity;
 }
@@ -1146,7 +1146,7 @@ uint8 ubcsp_poll (uint8 *activity)
 		else if (ubcsp_config.receive_index < ubcsp_config.receive_packet->length)
 		{
 			/* We are receiving the payload */
-			/* We might stop comming here if we are receiving a
+			/* We might stop coming here if we are receiving a
 			   packet which is longer than the receive_packet->length
 			   given by the host */
 
-- 
1.7.6

