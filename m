Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <47597C35.3060507@access-company.com>
Date: Fri, 07 Dec 2007 18:00:37 +0100
From: =?ISO-8859-1?Q?Fr=E9d=E9ric_Dalleau?= <frederic.dalleau@access-company.com>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="------------080509070009080800010704"
Subject: [Bluez-devel] [Patch] basic hfp functionnality
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
--------------080509070009080800010704
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

With Alok, we started integrating hfp to audio service.
Here is the first patch.
SLC, call accept and call hangup are available.

However the previous patch must be applied.

Frederic


--------------080509070009080800010704
Content-Type: text/x-patch;
 name="handsfreeslc.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="handsfreeslc.patch"

diff --git a/audio/headset.c b/audio/headset.c
index 7bb1746..7d438e0 100644
--- a/audio/headset.c
+++ b/audio/headset.c
@@ -113,6 +113,9 @@ struct headset {
 
 static int rfcomm_connect(struct device *device, struct pending_connect *c);
 static int get_handles(struct device *device, struct pending_connect *c);
+unsigned int headset_request_stream(struct device *dev, headset_stream_cb_t cb,
+					void *user_data);
+static GIOError headset_send(struct headset *hs, const char *str);
 
 static void pending_connect_free(struct pending_connect *c)
 {
@@ -171,6 +174,48 @@ static void hs_signal_gain_setting(struct device *device, const char *buf)
 					DBUS_TYPE_INVALID);
 }
 
+
+static void hf_set_indicator(struct device *device, int call, int callsetup)
+{
+	char buf[128];
+
+	if(!device->headset->enable_hfp)
+		return;
+
+	sprintf(buf, "\r\n+CIEV: 2,%d\r\n"
+			"\r\n+CIEV: 3,%d\r\n", call, callsetup);
+
+	headset_send(device->headset, buf);
+}
+
+static void hf_call_accept(struct device *device)
+{
+	struct headset *hs = device->headset;
+
+	hf_set_indicator(device, 1, 0);
+
+	if (hs->ring_timer) {
+		g_source_remove(hs->ring_timer);
+		hs->ring_timer = 0;
+	}
+
+	headset_request_stream(device, NULL, NULL);
+}
+
+static void hf_call_hangup(struct device *device)
+{
+	struct headset *hs = device->headset;
+
+	hf_set_indicator(device, 0, 0);
+
+	if (hs->ring_timer) {
+		g_source_remove(hs->ring_timer);
+		hs->ring_timer = 0;
+	}
+
+	headset_set_state(device, HEADSET_STATE_CONNECTED);
+}
+
 static headset_event_t parse_headset_event(const char *buf, char *rsp,
 						int rsp_len)
 {
@@ -190,6 +235,33 @@ static headset_event_t parse_headset_event(const char *buf, char *rsp,
 	} else if (!strncmp(buf, "+VG", 3)) {
 		snprintf(rsp, rsp_len, "\r\nOK\r\n");
 		return HEADSET_EVENT_GAIN;
+	} else if (!strncmp(buf, "+BRSF", 5)) {
+		snprintf(rsp, rsp_len, 
+			 	"\r\n+BRSF=0\r\n"
+				"\r\nOK\r\n");
+		return HANDSFREE_EVENT_SUPPORTED_FEAT;
+	} else if (!strncmp(buf, "+CIND=?", 7)) {
+		snprintf(rsp, rsp_len,
+				"\r\n+CIND: (\"service\",(0-1)),"
+				"(\"call\",(0-1)),(\"callsetup\",(0-3)),"
+				"(\"callheld\",(0-2)),(\"signal\",(0-5)),"
+				"(\"roam\",(0-1)),(\"battchg\",(0-5))\r\n"
+				"\r\nOK\r\n");
+		return HANDSFREE_EVENT_SUPPORTED_IND;
+	} else if (!strncmp(buf, "+CIND?", 6)) {
+		snprintf(rsp, rsp_len,
+			 	"\r\n+CIND: 1,0,0,0,5,1,5\r\n"
+				"\r\nOK\r\n");
+		return HANDSFREE_EVENT_READ_IND;
+	} else if (!strncmp(buf, "+CMER", 5)) {
+		snprintf(rsp, rsp_len, "\r\nOK\r\n");
+		return HANDSFREE_EVENT_REPORTING;
+	} else if (!strncmp(buf, "+CHUP", 5)) {
+		snprintf(rsp, rsp_len, "\r\nOK\r\n");
+		return HANDSFREE_EVENT_CALL_HANGUP;
+	} else if (!strncmp(buf, "A", 1) && strchr("\r\n \t", buf[1])) {
+		snprintf(rsp, rsp_len, "\r\nOK\r\n");
+		return HANDSFREE_EVENT_CALL_ACCEPTED;
 	} else {
 		snprintf(rsp, rsp_len, "\r\nERROR\r\n");
 		return HEADSET_EVENT_UNKNOWN;
@@ -276,6 +348,23 @@ static gboolean rfcomm_io_cb(GIOChannel *chan, GIOCondition cond,
 						DBUS_TYPE_INVALID);
 		break;
 
+	case HANDSFREE_EVENT_SUPPORTED_FEAT:
+	case HANDSFREE_EVENT_SUPPORTED_IND:
+	case HANDSFREE_EVENT_READ_IND:
+	case HANDSFREE_EVENT_REPORTING:
+	case HANDSFREE_EVENT_SUPPORTED_CHLD:
+		break;
+
+	case HANDSFREE_EVENT_CALL_ACCEPTED:
+		debug("Call accept");
+		hf_call_accept(device);
+		break;
+
+	case HANDSFREE_EVENT_CALL_HANGUP:
+		debug("Call hangup");
+		hf_call_hangup(device);
+		break;
+
 	case HEADSET_EVENT_INVALID:
 	case HEADSET_EVENT_UNKNOWN:
 	default:
@@ -1102,6 +1191,8 @@ static DBusHandlerResult hs_ring(DBusConnection *conn, DBusMessage *msg,
 		goto done;
 	}
 
+	hf_set_indicator(device, 0, 1);
+
 	if (headset_send(device->headset, "\r\nRING\r\n") != G_IO_ERROR_NONE) {
 		dbus_message_unref(reply);
 		return error_failed(conn, msg, "Failed");
@@ -1130,6 +1221,8 @@ static DBusHandlerResult hs_cancel_ringing(DBusConnection *conn,
 	if (!reply)
 		return DBUS_HANDLER_RESULT_NEED_MEMORY;
 
+	hf_set_indicator(device, 0, 0);
+
 	if (!hs->ring_timer) {
 		debug("Got CancelRinging method call but ringing is not in progress");
 		goto done;
@@ -1436,6 +1529,11 @@ void headset_free(struct device *dev)
 {
 	struct headset *hs = dev->headset;
 
+	if (hs->ring_timer) {
+		g_source_remove(hs->ring_timer);
+		hs->ring_timer = 0;
+	}
+
 	if (hs->sco) {
 		g_io_channel_close(hs->sco);
 		g_io_channel_unref(hs->sco);
diff --git a/audio/headset.h b/audio/headset.h
index b151dbd..4bfd0ad 100644
--- a/audio/headset.h
+++ b/audio/headset.h
@@ -31,6 +31,13 @@ typedef enum {
 	HEADSET_EVENT_KEYPRESS,
 	HEADSET_EVENT_GAIN,
 	HEADSET_EVENT_UNKNOWN,
+	HANDSFREE_EVENT_SUPPORTED_FEAT,
+	HANDSFREE_EVENT_SUPPORTED_IND,
+	HANDSFREE_EVENT_READ_IND,
+	HANDSFREE_EVENT_REPORTING,
+	HANDSFREE_EVENT_SUPPORTED_CHLD,
+	HANDSFREE_EVENT_CALL_ACCEPTED,
+	HANDSFREE_EVENT_CALL_HANGUP,
 	HEADSET_EVENT_INVALID
 } headset_event_t;
 

--------------080509070009080800010704
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
SF.Net email is sponsored by:
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://sourceforge.net/services/buy/index.php
--------------080509070009080800010704
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--------------080509070009080800010704--
