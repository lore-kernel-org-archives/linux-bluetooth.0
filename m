Return-Path: <cyrus@holtmann.org>
Message-ID: <4B4D8C5A.8070006@whitequark.ru>
Date: Wed, 13 Jan 2010 12:03:22 +0300
From: Peter Zotov <whitequark@whitequark.ru>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
Subject: Re: Handset voice dial signalling patch
References: <4B4D780F.1080405@whitequark.ru> <20100113083247.GA18980@jh-x301>
In-Reply-To: <20100113083247.GA18980@jh-x301>
Content-Type: multipart/mixed;
 boundary="------------000407040206010606020508"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is a multi-part message in MIME format.
--------------000407040206010606020508
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Johan Hedberg wrote:
> It sounds to me like you're working around another problem. I suspect
> the issue you're facing is that you don't have a telephony driver that'd
> keep the headset up-to-date with the current call state, so when you
> want to answer a call the headset doesn't generate the right AT command
> (ATA) since it doesn't know that there's an incoming call (instead, the
> only command it manages to generate is the voice recognition one since
> that's the default behaviour when the headset thinks that there are no
> active or pending calls).
Not exactly. All the code I included to BlueZ is implementing voice 
dialing, perhaps partially; but the interface it exports to outside 
world is misused by VoIP answering emulator because it would be probably 
too hard to emulate all the conversation that is usually occuring 
between HS and AG when there is a real call just to make it reply ATA to 
VoIP proxy. Maybe it's the wrong approach, but it is good enough for task.

> From the perspective of adding voice recognition support the patch is a
> step in the right direction, but it seems that's not the right way to
> solve your issue (of answering incoming calls). You'd also need to add
> the new telephony functions to the other drivers since they would fail
> to build right now with the patch.
Fixed, new variant is attached.

-- 
   WBR, Peter Zotov

--------------000407040206010606020508
Content-Type: text/x-patch;
 name="bluez-4.60-voice_dial-v2.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="bluez-4.60-voice_dial-v2.patch"

diff -ur bluez-4.60.old/audio/headset.c bluez-4.60.new/audio/headset.c
--- bluez-4.60.old/audio/headset.c	2010-01-09 23:52:17.000000000 +0300
+++ bluez-4.60.new/audio/headset.c	2010-01-13 06:22:15.000000000 +0300
@@ -157,6 +157,8 @@
 	gboolean inband_ring;
 	gboolean nrec;
 	gboolean nrec_req;
+	gboolean voice_dial;
+	gboolean voice_dial_req;
 
 	headset_state_t state;
 	struct pending_connect *pending;
@@ -1084,6 +1086,17 @@
 	return telephony_generic_rsp(telephony_device, err);
 }
 
+int telephony_voice_dial_rsp(void *telephony_device, cme_error_t err)
+{
+	struct audio_device *device = telephony_device;
+	struct headset *hs = device->headset;
+
+	if (err == CME_ERROR_NONE)
+		hs->voice_dial = hs->voice_dial_req;
+
+	return telephony_generic_rsp(telephony_device, err);
+}
+
 int telephony_operator_selection_ind(int mode, const char *oper)
 {
 	if (!active_devices)
@@ -1132,6 +1145,23 @@
 	return 0;
 }
 
+static int voice_dial(struct audio_device *device, const char *buf)
+{
+	struct headset* hs = device->headset;
+
+	if (strlen(buf) < 9)
+		return -EINVAL;
+
+	if (buf[8] == '0')
+		hs->voice_dial_req = FALSE;
+	else
+		hs->voice_dial_req = TRUE;
+
+	telephony_voice_dial_req(device, hs->voice_dial_req);
+
+	return 0;
+}
+
 static struct event event_callbacks[] = {
 	{ "ATA", answer_call },
 	{ "ATD", dial_number },
@@ -1152,6 +1182,7 @@
 	{ "AT+CCWA", call_waiting_notify },
 	{ "AT+COPS", operator_selection },
 	{ "AT+NREC", nr_and_ec },
+	{ "AT+BVRA", voice_dial },
 	{ 0 }
 };
 
diff -ur bluez-4.60.old/audio/telephony-dummy.c bluez-4.60.new/audio/telephony-dummy.c
--- bluez-4.60.old/audio/telephony-dummy.c	2010-01-09 23:52:17.000000000 +0300
+++ bluez-4.60.new/audio/telephony-dummy.c	2010-01-13 06:17:44.000000000 +0300
@@ -36,6 +36,8 @@
 #include "logging.h"
 #include "telephony.h"
 
+static DBusConnection *connection = NULL;
+
 static const char *chld_str = "0,1,1x,2,2x,3,4";
 static char *subscriber_number = NULL;
 static char *active_call_number = NULL;
@@ -205,6 +207,18 @@
 	telephony_nr_and_ec_rsp(telephony_device, CME_ERROR_NONE);
 }
 
+void telephony_voice_dial_req(void *telephony_device, gboolean enable)
+{
+	debug("telephony-dummy: got %s voice dial request",
+			enable ? "enable" : "disable");
+
+	g_dbus_emit_signal(connection, "/org/bluez/test",
+			"org.bluez.TelephonyTest", "VoiceDial",
+			DBUS_TYPE_INVALID);
+
+	telephony_voice_dial_rsp(telephony_device, CME_ERROR_NOT_SUPPORTED);
+}
+
 void telephony_key_press_req(void *telephony_device, const char *keys)
 {
 	debug("telephony-dummy: got key press request for %s", keys);
@@ -389,7 +403,10 @@
 	{ }
 };
 
-static DBusConnection *connection = NULL;
+static GDBusSignalTable dummy_signals[] = {
+	{ "VoiceDial",	"" },
+	{ }
+};
 
 int telephony_init(void)
 {
@@ -401,7 +418,7 @@
 
 	g_dbus_register_interface(connection, "/org/bluez/test",
 					"org.bluez.TelephonyTest",
-					dummy_methods, NULL,
+					dummy_methods, dummy_signals,
 					NULL, NULL, NULL);
 
 	telephony_ready_ind(features, dummy_indicators, response_and_hold,
diff -ur bluez-4.60.old/audio/telephony.h bluez-4.60.new/audio/telephony.h
--- bluez-4.60.old/audio/telephony.h	2010-01-09 23:52:17.000000000 +0300
+++ bluez-4.60.new/audio/telephony.h	2010-01-13 05:48:54.000000000 +0300
@@ -155,6 +155,7 @@
 void telephony_operator_selection_req(void *telephony_device);
 void telephony_call_hold_req(void *telephony_device, const char *cmd);
 void telephony_nr_and_ec_req(void *telephony_device, gboolean enable);
+void telephony_voice_dial_req(void *telephony_device, gboolean enable);
 void telephony_key_press_req(void *telephony_device, const char *keys);
 
 /* AG responses to HF requests. These are implemented by headset.c */
@@ -170,6 +171,7 @@
 int telephony_operator_selection_rsp(void *telephony_device, cme_error_t err);
 int telephony_call_hold_rsp(void *telephony_device, cme_error_t err);
 int telephony_nr_and_ec_rsp(void *telephony_device, cme_error_t err);
+int telephony_voice_dial_rsp(void *telephony_device, cme_error_t err);
 int telephony_key_press_rsp(void *telephony_device, cme_error_t err);
 
 /* Event indications by AG. These are implemented by headset.c */
diff -ur bluez-4.60.old/audio/telephony-maemo.c bluez-4.60.new/audio/telephony-maemo.c
--- bluez-4.60.old/audio/telephony-maemo.c	2010-01-09 23:52:17.000000000 +0300
+++ bluez-4.60.new/audio/telephony-maemo.c	2010-01-13 11:59:52.000000000 +0300
@@ -887,6 +887,14 @@
 		telephony_key_press_rsp(telephony_device, CME_ERROR_NONE);
 }
 
+void telephony_voice_dial_req(void *telephony_device, gboolean enable)
+{
+	debug("telephony-maemo: got %s voice dial request",
+			enable ? "enable" : "disable");
+
+	telephony_voice_dial_rsp(telephony_device, CME_ERROR_NOT_SUPPORTED);
+}
+
 static void handle_incoming_call(DBusMessage *msg)
 {
 	const char *number, *call_path;
diff -ur bluez-4.60.old/audio/telephony-ofono.c bluez-4.60.new/audio/telephony-ofono.c
--- bluez-4.60.old/audio/telephony-ofono.c	2010-01-09 23:52:17.000000000 +0300
+++ bluez-4.60.new/audio/telephony-ofono.c	2010-01-13 12:00:21.000000000 +0300
@@ -387,6 +387,14 @@
 	telephony_key_press_rsp(telephony_device, CME_ERROR_NONE);
 }
 
+void telephony_voice_dial_req(void *telephony_device, gboolean enable)
+{
+	debug("telephony-ofono: got %s voice dial request",
+			enable ? "enable" : "disable");
+
+	telephony_voice_dial_rsp(telephony_device, CME_ERROR_NOT_SUPPORTED);
+}
+
 static gboolean iter_get_basic_args(DBusMessageIter *iter,
 					int first_arg_type, ...)
 {

--------------000407040206010606020508--
