Return-Path: <cyrus@holtmann.org>
From: Alok <develnewbie@gmail.com>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1200991632.7006.20.camel@localhost>
References: <1200991632.7006.20.camel@localhost>
Content-Type: multipart/mixed; boundary="=-2Q9zk6X3uy3THZe6pj8i"
Date: Tue, 22 Jan 2008 17:07:50 +0530
Message-Id: <1201001871.6065.2.camel@greatbear>
Mime-Version: 1.0
Subject: [Bluez-devel] [PATCH][HFP] Support for CLIP
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


--=-2Q9zk6X3uy3THZe6pj8i
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi Johan/Fredric, 

Here is the patch for IdentifyCall() method as discussed. 

Let me know if anything needs to be changed.

Thanks, 
Alok. 

--=-2Q9zk6X3uy3THZe6pj8i
Content-Disposition: attachment; filename=patch
Content-Type: text/x-patch; name=patch; charset=us-ascii
Content-Transfer-Encoding: 7bit

Index: audio/headset.c
===================================================================
RCS file: /cvsroot/bluez/utils/audio/headset.c,v
retrieving revision 1.158
diff -u -5 -p -r1.158 headset.c
--- audio/headset.c	16 Jan 2008 09:08:26 -0000	1.158
+++ audio/headset.c	22 Jan 2008 11:23:10 -0000
@@ -113,10 +113,13 @@ struct headset {
 	int data_start;
 	int data_length;
 
 	gboolean hfp_active;
 	gboolean search_hfp;
+	gboolean cli_active;
+	char *ph_number;
+	int type;
 
 	headset_state_t state;
 	GSList *pending;
 
 	int sp_gain;
@@ -230,10 +233,15 @@ static int answer_call(struct device *de
 	}
 
 	if (!hs->hfp_active)
 		return headset_send(hs, "\r\nOK\r\n");
 
+	if (hs->ph_number) {
+		g_free(hs->ph_number);
+		hs->ph_number = NULL;
+	}
+
 	err = headset_send(hs, "\r\nOK\r\n");
 	if (err < 0)
 		return err;
 
 	/*+CIEV: (call = 1)*/
@@ -256,10 +264,15 @@ static int terminate_call(struct device 
 
 	err = headset_send(hs, "\r\nOK\r\n");
 	if (err < 0)
 		return err;
 
+	if (hs->ph_number) {
+		g_free(hs->ph_number);
+		hs->ph_number = NULL;
+	}
+
 	if (hs->ring_timer) {
 		g_source_remove(hs->ring_timer);
 		hs->ring_timer = 0;
 		/*+CIEV: (callsetup = 0)*/
 		return headset_send(hs, "\r\n+CIEV:3, 0\r\n");
@@ -267,10 +280,22 @@ static int terminate_call(struct device 
 
 	/*+CIEV: (call = 0)*/
 	return headset_send(hs, "\r\n+CIEV:2, 0\r\n");
 }
 
+static int cli_notification(struct device *device, const char *buf)
+{
+	struct headset *hs = device->headset;
+
+	if (buf[8] == '1')
+		hs->cli_active = TRUE;
+	else
+		hs->cli_active = FALSE;
+
+	return headset_send(hs, "\r\nOK\r\n");
+}
+
 static int signal_gain_setting(struct device *device, const char *buf)
 {
 	struct headset *hs = device->headset;
 	const char *name;
 	dbus_uint16_t gain;
@@ -321,10 +346,11 @@ static struct event event_callbacks[] = 
 	{"AT+CIND", report_indicators},
 	{"AT+CMER", event_reporting},
 	{"AT+CHLD", call_hold},
 	{"AT+CHUP", terminate_call},
 	{"AT+CKPD", answer_call},
+	{"AT+CLIP", cli_notification},
 	{0}
 };
 
 static GIOError handle_event(struct device *device, const char *buf)
 {
@@ -1178,11 +1204,19 @@ static gboolean ring_timer_cb(gpointer d
 	int err;
 
 	err = headset_send(hs, "\r\nRING\r\n");
 
 	if (err < 0)
-		error("Sending RING failed");
+		error("Error while sending RING: %s (%d)", strerror(-err), -err);
+
+	if (hs->cli_active && hs->ph_number) {
+		err = headset_send(hs, "\r\n+CLIP:\"%s\", %d\r\n",
+					hs->ph_number, hs->type);
+
+		if (err < 0)
+			error("Error while sending CLIP: %s (%d)", strerror(-err), -err);
+	}
 
 	return TRUE;
 }
 
 static DBusHandlerResult hs_ring(DBusConnection *conn, DBusMessage *msg,
@@ -1209,10 +1243,19 @@ static DBusHandlerResult hs_ring(DBusCon
 	if (err < 0) {
 		dbus_message_unref(reply);
 		return error_failed(conn, msg, "Failed");
 	}
 
+	if (hs->cli_active && hs->ph_number) {
+		err = headset_send(hs, "\r\n+CLIP:\"%s\", %d\r\n",
+					hs->ph_number, hs->type);
+		if (err < 0) {
+			dbus_message_unref(reply);
+			return error_failed(conn, msg, "Failed");
+		}
+	}
+
 	hs->ring_timer = g_timeout_add(RING_INTERVAL, ring_timer_cb, device);
 
 done:
 	send_message_and_unref(conn, reply);
 
@@ -1454,10 +1497,54 @@ static DBusHandlerResult hf_setup_call(D
 	send_message_and_unref(conn, reply);
 
 	return DBUS_HANDLER_RESULT_HANDLED;
 }
 
+static DBusHandlerResult hf_identify_call(DBusConnection *conn,
+						DBusMessage *msg,
+						void *data)
+{
+	struct device *device = data;
+	struct headset *hs = device->headset;
+	DBusMessage *reply;
+	DBusError derr;
+	const char *number;
+	dbus_int32_t type;
+
+	if (!hs->hfp_active && !hs->cli_active)
+		return error_not_supported(device->conn, msg);
+
+	if (hs->state < HEADSET_STATE_CONNECTED)
+		return error_not_connected(conn, msg);
+
+	dbus_error_init(&derr);
+	dbus_message_get_args(msg, &derr, DBUS_TYPE_STRING, &number,
+			      DBUS_TYPE_INT32, &type, DBUS_TYPE_INVALID);
+
+	if (dbus_error_is_set(&derr)) {
+		error_invalid_arguments(conn, msg, derr.message);
+		dbus_error_free(&derr);
+		return DBUS_HANDLER_RESULT_HANDLED;
+	}
+
+	reply = dbus_message_new_method_return(msg);
+	if (!reply)
+		return DBUS_HANDLER_RESULT_NEED_MEMORY;
+
+	if (hs->ph_number) {
+		g_free(hs->ph_number);
+		hs->ph_number = NULL;
+	}
+
+	hs->ph_number = g_strdup(number);
+	hs->type = type;
+
+	send_message_and_unref(conn, reply);
+
+	return DBUS_HANDLER_RESULT_HANDLED;
+}
+
 static DBusMethodVTable headset_methods[] = {
 	{ "Connect",		hs_connect,		"",	""	},
 	{ "Disconnect",		hs_disconnect,		"",	""	},
 	{ "IsConnected",	hs_is_connected,	"",	"b"	},
 	{ "IndicateCall",	hs_ring,		"",	""	},
@@ -1468,10 +1555,11 @@ static DBusMethodVTable headset_methods[
 	{ "GetSpeakerGain",	hs_get_speaker_gain,	"",	"q"	},
 	{ "GetMicrophoneGain",	hs_get_mic_gain,	"",	"q"	},
 	{ "SetSpeakerGain",	hs_set_speaker_gain,	"q",	""	},
 	{ "SetMicrophoneGain",	hs_set_mic_gain,	"q",	""	},
 	{ "SetupCall",		hf_setup_call,		"s",	""	},
+	{ "IdentifyCall",	hf_identify_call,	"si",	""	},
 	{ NULL, NULL, NULL, NULL }
 };
 
 static DBusSignalVTable headset_signals[] = {
 	{ "Connected",			""	},
@@ -1554,10 +1642,12 @@ struct headset *headset_init(struct devi
 	hs->rfcomm_ch = -1;
 	hs->sp_gain = -1;
 	hs->mic_gain = -1;
 	hs->search_hfp = server_is_enabled(HANDSFREE_SVCLASS_ID);
 	hs->hfp_active = FALSE;
+	hs->cli_active = FALSE;
+	hs->ph_number = NULL;
 
 	if (!record)
 		goto register_iface;
 
 	switch (svc) {
Index: audio/audio-api.txt
===================================================================
RCS file: /cvsroot/bluez/utils/audio/audio-api.txt,v
retrieving revision 1.27
diff -u -5 -p -r1.27 audio-api.txt
--- audio/audio-api.txt	9 Jan 2008 03:00:22 -0000	1.27
+++ audio/audio-api.txt	22 Jan 2008 11:23:13 -0000
@@ -181,17 +181,24 @@ Methods		void Connect()
 
 		void SetMicrophoneGain(uint16 gain)
 
 			Changes the current speaker gain if possible.
 
-                void SetupCall(string value)
+                void SetupCall(string value) [experimental]
 
 			Sets up an call with the connected HFP. The value can
 			be "incoming", "outgoing" or "remote" to indicate
 			incoming call, outgoing call and remote party alerted
 			respectively.
 
+                void IdentifyCall(string phone_number, int32 type) [experimental]
+                         
+                        Enables a called subscriber to get the calling
+                        line identity (CLI) of the calling party when
+                        receiving a call. The value of type shud be
+                        the same as provided by the GSM stack.                       
+
 Signals		void AnswerRequested()
 
 			Sent when the answer button is pressed on the headset
 
 		void Connected()

--=-2Q9zk6X3uy3THZe6pj8i
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
--=-2Q9zk6X3uy3THZe6pj8i
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--=-2Q9zk6X3uy3THZe6pj8i--
