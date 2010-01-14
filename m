Return-Path: <cyrus@holtmann.org>
Message-ID: <4B4F8C1E.209@whitequark.ru>
Date: Fri, 15 Jan 2010 00:26:54 +0300
From: Peter Zotov <whitequark@whitequark.ru>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
Subject: Re: Handset voice dial signalling patch
References: <4B4D780F.1080405@whitequark.ru> <20100113083247.GA18980@jh-x301> <4B4D8C5A.8070006@whitequark.ru> <20100113092620.GA20024@jh-x301> <4B4E3A98.8000605@whitequark.ru> <20100114144123.GA31691@jh-x301>
In-Reply-To: <20100114144123.GA31691@jh-x301>
Content-Type: multipart/mixed;
 boundary="------------010306000101050902060907"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is a multi-part message in MIME format.
--------------010306000101050902060907
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Johan Hedberg wrote:
> Thanks, however there are still a couple of things that I noticed (sorry
> for not spotting them earlier). Once the issues in the code are fixed,
> please create a patch that's appliable using git am, i.e. commit to your
> own tree (with an appropriate commit message) and prepare a patch file
> with git format-patch.
I fixed everything and created a patch with git format-patch. Probably 
the resulting file is intended to send as a email directly, but I don't 
know how to do this with Thunderbird, so it is attached.

-- 
   WBR, Peter Zotov

--------------010306000101050902060907
Content-Type: text/x-patch;
 name="0001-Add-preliminary-voice-dialling-support-for-HSP.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename*0="0001-Add-preliminary-voice-dialling-support-for-HSP.patch"

>From 08379e8dc72650452f62a5c112c0d32afe9db1e6 Mon Sep 17 00:00:00 2001
From: Peter Zotov <whitequark@whitequark.ru>
Date: Thu, 14 Jan 2010 23:29:59 +0300
Subject: [PATCH] Add preliminary voice dialling support for HSP

---
 audio/headset.c         |   23 +++++++++++++++++++++++
 audio/telephony-dummy.c |   21 +++++++++++++++++++--
 audio/telephony-maemo.c |    8 ++++++++
 audio/telephony-ofono.c |    8 ++++++++
 audio/telephony.h       |    2 ++
 5 files changed, 60 insertions(+), 2 deletions(-)

diff --git a/audio/headset.c b/audio/headset.c
index 765ddb0..bdd26e6 100644
--- a/audio/headset.c
+++ b/audio/headset.c
@@ -1084,6 +1084,11 @@ int telephony_nr_and_ec_rsp(void *telephony_device, cme_error_t err)
 	return telephony_generic_rsp(telephony_device, err);
 }
 
+int telephony_voice_dial_rsp(void *telephony_device, cme_error_t err)
+{
+	return telephony_generic_rsp(telephony_device, err);
+}
+
 int telephony_operator_selection_ind(int mode, const char *oper)
 {
 	if (!active_devices)
@@ -1132,6 +1137,23 @@ static int nr_and_ec(struct audio_device *device, const char *buf)
 	return 0;
 }
 
+static int voice_dial(struct audio_device *device, const char *buf)
+{
+	gboolean start_dialing;
+
+	if (strlen(buf) < 9)
+		return -EINVAL;
+
+	if (buf[8] == '0')
+		start_dialing = FALSE;
+	else
+		start_dialing = TRUE;
+
+	telephony_voice_dial_req(device, start_dialing);
+
+	return 0;
+}
+
 static struct event event_callbacks[] = {
 	{ "ATA", answer_call },
 	{ "ATD", dial_number },
@@ -1152,6 +1174,7 @@ static struct event event_callbacks[] = {
 	{ "AT+CCWA", call_waiting_notify },
 	{ "AT+COPS", operator_selection },
 	{ "AT+NREC", nr_and_ec },
+	{ "AT+BVRA", voice_dial },
 	{ 0 }
 };
 
diff --git a/audio/telephony-dummy.c b/audio/telephony-dummy.c
index 5478d03..2409a49 100644
--- a/audio/telephony-dummy.c
+++ b/audio/telephony-dummy.c
@@ -36,6 +36,8 @@
 #include "logging.h"
 #include "telephony.h"
 
+static DBusConnection *connection = NULL;
+
 static const char *chld_str = "0,1,1x,2,2x,3,4";
 static char *subscriber_number = NULL;
 static char *active_call_number = NULL;
@@ -205,6 +207,18 @@ void telephony_nr_and_ec_req(void *telephony_device, gboolean enable)
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
+	telephony_voice_dial_rsp(telephony_device, CME_ERROR_NONE);
+}
+
 void telephony_key_press_req(void *telephony_device, const char *keys)
 {
 	debug("telephony-dummy: got key press request for %s", keys);
@@ -389,7 +403,10 @@ static GDBusMethodTable dummy_methods[] = {
 	{ }
 };
 
-static DBusConnection *connection = NULL;
+static GDBusSignalTable dummy_signals[] = {
+	{ "VoiceDial",	"" },
+	{ }
+};
 
 int telephony_init(void)
 {
@@ -401,7 +418,7 @@ int telephony_init(void)
 
 	g_dbus_register_interface(connection, "/org/bluez/test",
 					"org.bluez.TelephonyTest",
-					dummy_methods, NULL,
+					dummy_methods, dummy_signals,
 					NULL, NULL, NULL);
 
 	telephony_ready_ind(features, dummy_indicators, response_and_hold,
diff --git a/audio/telephony-maemo.c b/audio/telephony-maemo.c
index f8da349..98f4409 100644
--- a/audio/telephony-maemo.c
+++ b/audio/telephony-maemo.c
@@ -887,6 +887,14 @@ void telephony_key_press_req(void *telephony_device, const char *keys)
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
diff --git a/audio/telephony-ofono.c b/audio/telephony-ofono.c
index 2778cfc..3df76c3 100644
--- a/audio/telephony-ofono.c
+++ b/audio/telephony-ofono.c
@@ -387,6 +387,14 @@ void telephony_key_press_req(void *telephony_device, const char *keys)
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
diff --git a/audio/telephony.h b/audio/telephony.h
index da39751..0bc4769 100644
--- a/audio/telephony.h
+++ b/audio/telephony.h
@@ -155,6 +155,7 @@ void telephony_list_current_calls_req(void *telephony_device);
 void telephony_operator_selection_req(void *telephony_device);
 void telephony_call_hold_req(void *telephony_device, const char *cmd);
 void telephony_nr_and_ec_req(void *telephony_device, gboolean enable);
+void telephony_voice_dial_req(void *telephony_device, gboolean enable);
 void telephony_key_press_req(void *telephony_device, const char *keys);
 
 /* AG responses to HF requests. These are implemented by headset.c */
@@ -170,6 +171,7 @@ int telephony_list_current_calls_rsp(void *telephony_device, cme_error_t err);
 int telephony_operator_selection_rsp(void *telephony_device, cme_error_t err);
 int telephony_call_hold_rsp(void *telephony_device, cme_error_t err);
 int telephony_nr_and_ec_rsp(void *telephony_device, cme_error_t err);
+int telephony_voice_dial_rsp(void *telephony_device, cme_error_t err);
 int telephony_key_press_rsp(void *telephony_device, cme_error_t err);
 
 /* Event indications by AG. These are implemented by headset.c */
-- 
1.6.3.3


--------------010306000101050902060907--
