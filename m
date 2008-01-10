Return-Path: <cyrus@holtmann.org>
From: Alok <develnewbie@gmail.com>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <20080109002828.GB5883@ps.ms.mff.cuni.cz>
References: <20080109002828.GB5883@ps.ms.mff.cuni.cz>
Content-Type: multipart/mixed; boundary="=-AO+y2PU3gxf4t48EHMvY"
Date: Thu, 10 Jan 2008 21:06:48 +0530
Message-Id: <1199979409.23989.20.camel@greatbear>
Mime-Version: 1.0
Subject: [Bluez-devel] [PATCH][HFP] - Setting the inband Ringtone
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


--=-AO+y2PU3gxf4t48EHMvY
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi Johan, 

Here is a patch to change the In-BandRingtone setting through a D-Bus
method. 

Let me know if the Method/Signal names are fine with you. 

Ill send the patch for the audio-api.txt next.

Do you think we shud have a DBus method call to Identify the type of
headset i.e HSP/HFP? A method like "IsHFP" which returns the value of
hs->hfp_active will be useful. Otherwise there is no way to know (apart
for reading /etc/bluetooth/audio.conf) what profile is active. 


Let me know if anything in the patch needs to be changed. 
-Alok.  

--=-AO+y2PU3gxf4t48EHMvY
Content-Disposition: attachment; filename=patch1
Content-Type: text/x-patch; name=patch1; charset=us-ascii
Content-Transfer-Encoding: 7bit

Index: audio/headset.c
===================================================================
RCS file: /cvsroot/bluez/utils/audio/headset.c,v
retrieving revision 1.156
diff -u -5 -p -r1.156 headset.c
--- audio/headset.c	9 Jan 2008 12:36:58 -0000	1.156
+++ audio/headset.c	10 Jan 2008 15:04:17 -0000
@@ -1447,10 +1453,67 @@ static DBusHandlerResult hf_setup_call(D
 	send_message_and_unref(conn, reply);
 
 	return DBUS_HANDLER_RESULT_HANDLED;
 }
 
+static DBusHandlerResult hf_set_inband(DBusConnection *conn,
+						DBusMessage *msg,
+						void *data)
+{
+	struct device *device = data;
+	struct headset *hs = device->headset;
+	DBusMessage *reply;
+	DBusError derr;
+	gboolean *active;
+	int err;
+
+	if (!hs->hfp_active)
+		return error_not_supported(device->conn, msg);
+
+	if (hs->state < HEADSET_STATE_CONNECTED)
+		return error_not_connected(conn, msg);
+
+	dbus_error_init(&derr);
+	dbus_message_get_args(msg, &derr, DBUS_TYPE_BOOLEAN, &active,
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
+	if (active && !(ag_features & AG_FEATURE_INBAND_RINGTONE)) {
+		ag_features |= AG_FEATURE_INBAND_RINGTONE;
+		err = headset_send(hs, "\r\n+BSIR:1\r\n");
+	}
+
+	if (!active && (ag_features & AG_FEATURE_INBAND_RINGTONE)) {
+		ag_features &= ~AG_FEATURE_INBAND_RINGTONE;
+		err = headset_send(hs, "\r\n+BSIR:0\r\n");
+	}
+
+	if (err < 0) {
+		dbus_message_unref(reply);
+		return error_failed(conn, msg, "Unable to send to headset");
+	}
+
+	dbus_connection_emit_signal(conn, device->path,
+						AUDIO_HEADSET_INTERFACE,
+						"InBandSettingChanged",
+						DBUS_TYPE_BOOLEAN, &active,
+						DBUS_TYPE_INVALID);
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
@@ -1461,10 +1524,11 @@ static DBusMethodVTable headset_methods[
 	{ "GetSpeakerGain",	hs_get_speaker_gain,	"",	"q"	},
 	{ "GetMicrophoneGain",	hs_get_mic_gain,	"",	"q"	},
 	{ "SetSpeakerGain",	hs_set_speaker_gain,	"q",	""	},
 	{ "SetMicrophoneGain",	hs_set_mic_gain,	"q",	""	},
 	{ "SetupCall",		hf_setup_call,		"s",	""	},
+	{ "SetInbandRingtone",	hf_set_inband,		"b",	""	},
 	{ NULL, NULL, NULL, NULL }
 };
 
 static DBusSignalVTable headset_signals[] = {
 	{ "Connected",			""	},
@@ -1473,10 +1537,11 @@ static DBusSignalVTable headset_signals[
 	{ "Stopped",			""	},
 	{ "Playing",			""	},
 	{ "SpeakerGainChanged",		"q"	},
 	{ "MicrophoneGainChanged",	"q"	},
 	{ "CallTerminated",		""	},
+	{ "InBandSettingChanged",	"b"	},
 	{ NULL, NULL }
 };
 
 static void headset_set_channel(struct headset *headset, sdp_record_t *record)
 {

--=-AO+y2PU3gxf4t48EHMvY
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://ad.doubleclick.net/clk;164216239;13503038;w?http://sf.net/marketplace
--=-AO+y2PU3gxf4t48EHMvY
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--=-AO+y2PU3gxf4t48EHMvY--
