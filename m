Return-Path: <cyrus@holtmann.org>
Message-ID: <4B4D780F.1080405@whitequark.ru>
Date: Wed, 13 Jan 2010 10:36:47 +0300
From: Peter Zotov <whitequark@whitequark.ru>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
Subject: Handset voice dial signalling patch
Content-Type: multipart/mixed;
 boundary="------------070202090509080606060903"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is a multi-part message in MIME format.
--------------070202090509080606060903
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello.

I wrote a patch (attached) that makes dummy telephony interface send a 
DBus signal (through org.bluez.TelephonyTest interface) every time a 
voice dialing is started. It may be useful when you have only this 
button on a handset (e.g. SonyEricsson HBH602 owned by me) and want to 
answer some VoIP client call with it.

Patch works both with BlueZ 4.60 and 4.57-1 built with dpkg-buildpackage.

I have an example Skype client that answers calls using this feature and 
Skype DBus API, and can post it if someone is interested in.

-- 
   WBR, Peter Zotov

--------------070202090509080606060903
Content-Type: text/x-patch;
 name="bluez-4.60-voice_dial.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="bluez-4.60-voice_dial.patch"

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

--------------070202090509080606060903--
