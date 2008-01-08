Return-Path: <cyrus@holtmann.org>
From: Alok <develnewbie@gmail.com>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <000801c851e8$81d6a710$8583f530$@savary@kerlink.fr>
References: <000801c851e8$81d6a710$8583f530$@savary@kerlink.fr>
Content-Type: multipart/mixed; boundary="=-Zxh1V+QgCjnnyD+/xJRc"
Date: Tue, 08 Jan 2008 19:33:53 +0530
Message-Id: <1199801033.20835.4.camel@greatbear>
Mime-Version: 1.0
Subject: [Bluez-devel] [PATCH] more headset.c fixes
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


--=-Zxh1V+QgCjnnyD+/xJRc
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi Johan/Fredric,

Here is a patch which fixes the following :

1. Consistency with headset_send args. 
2. error checks for headset_send. 
3. Populating answer_call and terminate_call methods.
4. Adding "TerminateCall" signal.

let me know if anything needs to be changed.

-Alok.

--=-Zxh1V+QgCjnnyD+/xJRc
Content-Disposition: attachment; filename=patch
Content-Type: text/x-patch; name=patch; charset=us-ascii
Content-Transfer-Encoding: 7bit

Index: audio/headset.c
===================================================================
RCS file: /cvsroot/bluez/utils/audio/headset.c,v
retrieving revision 1.152
diff -u -5 -p -r1.152 headset.c
--- audio/headset.c	8 Jan 2008 08:58:14 -0000	1.152
+++ audio/headset.c	8 Jan 2008 14:02:41 -0000
@@ -173,11 +173,11 @@ static int supported_features(struct dev
 	hs->hfp_features = strtoul(&buf[8], NULL, 10);
 	err = headset_send(hs, "\r\n+BRSF=%u\r\n", ag_features);
 	if (err < 0)
 		return err;
 
-	return headset_send(device->headset, "\r\nOK\r\n");
+	return headset_send(hs, "\r\nOK\r\n");
 }
 
 static int report_indicators(struct device *device, const char *buf)
 {
 	struct headset *hs = device->headset;
@@ -190,16 +190,17 @@ static int report_indicators(struct devi
 		err = headset_send(hs, "\r\n+CIND:1, 0, 0\r\n");
 
 	if (err < 0)
 		return err;
 
-	return headset_send(device->headset, "\r\nOK\r\n");
+	return headset_send(hs, "\r\nOK\r\n");
 }
 
 static int event_reporting(struct device *device, const char *buf)
 {
-	return headset_send(device->headset, "\r\nOK\r\n");
+	struct headset *hs = device->headset;
+	return headset_send(hs, "\r\nOK\r\n");
 }
 
 static int call_hold(struct device *device, const char *buf)
 {
 	struct headset *hs = device->headset;
@@ -207,29 +208,68 @@ static int call_hold(struct device *devi
 
 	err = headset_send(hs, "\r\n+CHLD:(0,1,1x,2,2x,3,4)\r\n");
 	if (err < 0)
 		return err;
 
-	return headset_send(device->headset, "\r\nOK\r\n");
+	return headset_send(hs, "\r\nOK\r\n");
 }
 
 static int answer_call(struct device *device, const char *buf)
 {
+	struct headset *hs = device->headset;
+	int err;
+
 	dbus_connection_emit_signal(device->conn, device->path,
 			AUDIO_HEADSET_INTERFACE, "AnswerRequested",
 			DBUS_TYPE_INVALID);
 
-	return headset_send(device->headset, "\r\nOK\r\n");
+	if (hs->ring_timer) {
+		g_source_remove(hs->ring_timer);
+		hs->ring_timer = 0;
+	}
+
+	if (!hs->hfp_active)
+		return headset_send(hs, "\r\nOK\r\n");
+
+	err = headset_send(hs, "\r\nOK\r\n");
+	if (err < 0)
+		return err;
+
+	/*+CIEV: (call = 1)*/
+	err = headset_send(hs, "\r\n+CIEV:2, 1\r\n");
+	if (err < 0)
+		return err;
+
+	/*+CIEV: (callsetup = 0)*/
+	return headset_send(hs, "\r\n+CIEV:3, 0\r\n");
 }
 
 static int terminate_call(struct device *device, const char *buf)
 {
-	return headset_send(device->headset, "\r\nOK\r\n");
+	struct headset *hs = device->headset;
+	int err;
+
+	dbus_connection_emit_signal(device->conn, device->path,
+			AUDIO_HEADSET_INTERFACE, "TerminateCall",
+			DBUS_TYPE_INVALID);
+
+	if (hs->ring_timer) {
+		g_source_remove(hs->ring_timer);
+		hs->ring_timer = 0;
+	}
+
+	err = headset_send(hs, "\r\nOK\r\n");
+	if (err < 0)
+		return err;
+
+	/*+CIEV: (call = 0)*/
+	return headset_send(hs, "\r\n+CIEV:2, 0\r\n");
 }
 
 static int signal_gain_setting(struct device *device, const char *buf)
 {
+	struct headset *hs = device->headset;
 	const char *name;
 	dbus_uint16_t gain;
 
 	if (strlen(buf) < 8) {
 		error("Too short string for Gain setting");
@@ -243,20 +283,20 @@ static int signal_gain_setting(struct de
 		return -1;
 	}
 
 	switch (buf[5]) {
 	case HEADSET_GAIN_SPEAKER:
-		if (device->headset->sp_gain == gain)
+		if (hs->sp_gain == gain)
 			goto ok;
 		name = "SpeakerGainChanged";
-		device->headset->sp_gain = gain;
+		hs->sp_gain = gain;
 		break;
 	case HEADSET_GAIN_MICROPHONE:
-		if (device->headset->mic_gain == gain)
+		if (hs->mic_gain == gain)
 			goto ok;
 		name = "MicrophoneGainChanged";
-		device->headset->mic_gain = gain;
+		hs->mic_gain = gain;
 		break;
 	default:
 		error("Unknown gain setting");
 		return G_IO_ERROR_INVAL;
 	}
@@ -265,11 +305,11 @@ static int signal_gain_setting(struct de
 				    AUDIO_HEADSET_INTERFACE, name,
 				    DBUS_TYPE_UINT16, &gain,
 				    DBUS_TYPE_INVALID);
 
 ok:
-	return headset_send(device->headset, "\r\nOK\r\n");
+	return headset_send(hs, "\r\nOK\r\n");
 }
 
 static struct event event_callbacks[] = {
 	{"ATA", answer_call},
 	{"AT+VG", signal_gain_setting},
@@ -1123,15 +1163,16 @@ error:
 }
 
 static gboolean ring_timer_cb(gpointer data)
 {
 	struct device *device = data;
+	struct headset *hs = device->headset;
 	int err;
 
-	err = headset_send(device->headset, "\r\nRING\r\n");
+	err = headset_send(hs, "\r\nRING\r\n");
 
-	if (err)
+	if (err < 0)
 		error("Sending RING failed");
 
 	return TRUE;
 }
 
@@ -1153,12 +1194,12 @@ static DBusHandlerResult hs_ring(DBusCon
 	if (hs->ring_timer) {
 		debug("IndicateCall received when already indicating");
 		goto done;
 	}
 
-	err = headset_send(device->headset, "\r\nRING\r\n");
-	if (err) {
+	err = headset_send(hs, "\r\nRING\r\n");
+	if (err < 0) {
 		dbus_message_unref(reply);
 		return error_failed(conn, msg, "Failed");
 	}
 
 	hs->ring_timer = g_timeout_add(RING_INTERVAL, ring_timer_cb, device);
@@ -1311,12 +1352,12 @@ static DBusHandlerResult hs_set_gain(DBu
 	if (!reply)
 		return DBUS_HANDLER_RESULT_NEED_MEMORY;
 
 	if (hs->state != HEADSET_STATE_PLAYING)
 		goto done;
-	err = headset_send(device->headset, "\r\n+VG%c=%u\r\n", type, gain);
-	if (err) {
+	err = headset_send(hs, "\r\n+VG%c=%u\r\n", type, gain);
+	if (err < 0) {
 		dbus_message_unref(reply);
 		return error_failed(conn, msg, "Unable to send to headset");
 	}
 
 done:
@@ -1377,10 +1418,11 @@ static DBusSignalVTable headset_signals[
 	{ "AnswerRequested",		""	},
 	{ "Stopped",			""	},
 	{ "Playing",			""	},
 	{ "SpeakerGainChanged",		"q"	},
 	{ "MicrophoneGainChanged",	"q"	},
+	{ "TerminateCall",		""	},
 	{ NULL, NULL }
 };
 
 static void headset_set_channel(struct headset *headset, sdp_record_t *record)
 {

--=-Zxh1V+QgCjnnyD+/xJRc
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://ad.doubleclick.net/clk;164216239;13503038;w?http://sf.net/marketplace
--=-Zxh1V+QgCjnnyD+/xJRc
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--=-Zxh1V+QgCjnnyD+/xJRc--
