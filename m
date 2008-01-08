Return-Path: <cyrus@holtmann.org>
From: Alok <develnewbie@gmail.com>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <d89ddf300801071547k792a5b9fqe6e7e72e597b0e5f@mail.gmail.com>
References: <20080107230910.GA5883@ps.ms.mff.cuni.cz>
	<d89ddf300801071547k792a5b9fqe6e7e72e597b0e5f@mail.gmail.com>
Content-Type: multipart/mixed; boundary="=-5xkvlCMssrQbVM0etzW0"
Date: Tue, 08 Jan 2008 20:53:27 +0530
Message-Id: <1199805807.20835.10.camel@greatbear>
Mime-Version: 1.0
Subject: [Bluez-devel] [PATCH] HFP method "SetupCall" + audio-api.txt update
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


--=-5xkvlCMssrQbVM0etzW0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi Johan/Fredric, 

Here is a patch for adding the SetupCall method , used for call setup on
hfp. Also adding a patch to update the audio-api.txt file for the same. 

Let me know if anything needs to be changed. 

-Alok.

--=-5xkvlCMssrQbVM0etzW0
Content-Disposition: attachment; filename=audio-api.patch
Content-Type: text/x-patch; name=audio-api.patch; charset=us-ascii
Content-Transfer-Encoding: 7bit

Index: audio/audio-api.txt
===================================================================
RCS file: /cvsroot/bluez/utils/audio/audio-api.txt,v
retrieving revision 1.25
diff -u -5 -p -r1.25 audio-api.txt
--- audio/audio-api.txt	29 Aug 2007 11:41:15 -0000	1.25
+++ audio/audio-api.txt	8 Jan 2008 15:01:51 -0000
@@ -181,10 +181,17 @@ Methods		void Connect()
 
 		void SetMicrophoneGain(uint16 gain)
 
 			Changes the current speaker gain if possible.
 
+                void SetupCall(string value)
+
+                        Sets up an call with the connected HFP.
+                        value can be incoming, outgoing
+                        or remote to indicate incoming call, outgoing
+                        call and remote party alerted respectively.                                                                   
+
 Signals		void AnswerRequested()
 
 			Sent when the answer button is pressed on the headset
 
 		void Connected()
@@ -209,10 +216,14 @@ Signals		void AnswerRequested()
 
 		void MicrophoneGainChanged(uint16 gain)
 
 			The microphone gain changed.
 
+                void TerminateCall()
+
+                        Sent when an ongoing call is terminated.                
+
 
 org.bluez.audio.Gateway interface
 =================================
 
 [not yet implemented]

--=-5xkvlCMssrQbVM0etzW0
Content-Disposition: attachment; filename=setupCall.patch
Content-Type: text/x-patch; name=setupCall.patch; charset=us-ascii
Content-Transfer-Encoding: 7bit

Index: audio/headset.c
===================================================================
RCS file: /cvsroot/bluez/utils/audio/headset.c,v
retrieving revision 1.153
diff -u -5 -p -r1.153 headset.c
--- audio/headset.c	8 Jan 2008 14:45:32 -0000	1.153
+++ audio/headset.c	8 Jan 2008 14:52:49 -0000
@@ -1395,10 +1395,60 @@ static DBusHandlerResult hs_set_mic_gain
 						void *data)
 {
 	return hs_set_gain(conn, msg, data, HEADSET_GAIN_MICROPHONE);
 }
 
+static DBusHandlerResult hf_setup_call(DBusConnection *conn,
+						DBusMessage *msg,
+						void *data)
+{
+	struct device *device = data;
+	struct headset *hs = device->headset;
+	DBusMessage *reply;
+	DBusError derr;
+	const char *value;
+	int err;
+
+	if (!hs->hfp_active)
+		return error_not_supported(device->conn, msg);
+
+	if (hs->state < HEADSET_STATE_CONNECTED)
+		return error_not_connected(conn, msg);
+
+	dbus_error_init(&derr);
+	dbus_message_get_args(msg, &derr, DBUS_TYPE_STRING, &value,
+				DBUS_TYPE_INVALID);
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
+	if (!strncmp(value, "incoming", 8))
+		err = headset_send(hs, "\r\n+CIEV:3, 1\r\n");
+	else if (!strncmp(value, "outgoing", 8))
+		err = headset_send(hs, "\r\n+CIEV:3, 2\r\n");
+	else if (!strncmp(value, "remote", 6))
+		err = headset_send(hs, "\r\n+CIEV:3, 3\r\n");
+	else
+		err = -EINVAL;
+
+	if (err < 0) {
+		dbus_message_unref(reply);
+		return error_failed_errno(conn, msg, -err);
+	}
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
@@ -1408,10 +1458,11 @@ static DBusMethodVTable headset_methods[
 	{ "IsPlaying",		hs_is_playing,		"",	"b"	},
 	{ "GetSpeakerGain",	hs_get_speaker_gain,	"",	"q"	},
 	{ "GetMicrophoneGain",	hs_get_mic_gain,	"",	"q"	},
 	{ "SetSpeakerGain",	hs_set_speaker_gain,	"q",	""	},
 	{ "SetMicrophoneGain",	hs_set_mic_gain,	"q",	""	},
+	{ "SetupCall",		hf_setup_call,		"s",	""	},
 	{ NULL, NULL, NULL, NULL }
 };
 
 static DBusSignalVTable headset_signals[] = {
 	{ "Connected",			""	},

--=-5xkvlCMssrQbVM0etzW0
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://ad.doubleclick.net/clk;164216239;13503038;w?http://sf.net/marketplace
--=-5xkvlCMssrQbVM0etzW0
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--=-5xkvlCMssrQbVM0etzW0--
