Return-Path: <cyrus@holtmann.org>
From: Dmitriy Paliy <dmitriy.paliy@nokia.com>
To: linux-bluetooth@vger.kernel.org
Cc: Dmitriy Paliy <dmitriy.paliy@nokia.com>
Subject: [PATCH BlueZ 2/4] Add playback of tones to handsfree
Date: Mon, 19 Sep 2011 13:54:37 +0300
Message-Id: <1316429679-18651-2-git-send-email-dmitriy.paliy@nokia.com>
In-Reply-To: <1316429679-18651-1-git-send-email-dmitriy.paliy@nokia.com>
References: <1316429679-18651-1-git-send-email-dmitriy.paliy@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

StartEventTone and StopTone method calls to tone generator are added
to maemo6 telephony driver. Such implements playback of DTMF tones
in handsfree to notify user.
---
 audio/telephony-maemo6.c |  100 ++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 100 insertions(+), 0 deletions(-)

diff --git a/audio/telephony-maemo6.c b/audio/telephony-maemo6.c
index 1f3cdef..85bb478 100644
--- a/audio/telephony-maemo6.c
+++ b/audio/telephony-maemo6.c
@@ -118,6 +118,13 @@ enum net_registration_status {
 #define OHM_INTERFACE		"com.nokia.NonGraphicFeedback1"
 #define OHM_PATH		"/com/nokia/NonGraphicFeedback1"
 
+/* tone genenerator D-Bus definitions */
+#define TONEGEN_BUS_NAME	"com.Nokia.Telephony.Tones"
+#define TONEGEN_INTERFACE	"com.Nokia.Telephony.Tones"
+#define TONEGEN_PATH		"/com/Nokia/Telephony/Tones"
+
+#define FEEDBACK_TONE_DURATION			200
+
 struct csd_call {
 	char *object_path;
 	int status;
@@ -158,6 +165,10 @@ static GSList *pending = NULL;
 /* Reference count for determining the call indicator status */
 static GSList *active_calls = NULL;
 
+/* Queue of DTMF tones to play */
+static GSList *tones = NULL;
+static guint create_tones_timer = 0;
+
 static char *msisdn = NULL;	/* Subscriber number */
 static char *vmbx = NULL;	/* Voice mailbox number */
 
@@ -777,11 +788,100 @@ static void start_dtmf(void *telephony_device, char tone)
 	telephony_transmit_dtmf_rsp(telephony_device, CME_ERROR_NONE);
 }
 
+static int tonegen_startevent(char tone)
+{
+	int ret;
+	dbus_uint32_t event_tone;
+	dbus_int32_t dbm0 = -15;
+	dbus_uint32_t duration = 150;
+
+	switch (tone) {
+	case '*':
+		event_tone = 10;
+		break;
+	case '#':
+		event_tone = 11;
+		break;
+	default:
+		/* A-D tones are not supported, therefore played as 0 */
+		event_tone = atoi(&tone);
+	}
+
+	ret = send_method_call(TONEGEN_BUS_NAME, TONEGEN_PATH,
+				TONEGEN_INTERFACE, "StartEventTone",
+				NULL, NULL,
+				DBUS_TYPE_UINT32, &event_tone,
+				DBUS_TYPE_INT32, &dbm0,
+				DBUS_TYPE_UINT32, &duration,
+				DBUS_TYPE_INVALID);
+	return ret;
+}
+
+static gboolean stop_feedback_tone(gpointer user_data)
+{
+	if (g_slist_length(tones) > 0) {
+		gpointer ptone;
+		int ret;
+
+		send_method_call(TONEGEN_BUS_NAME, TONEGEN_PATH,
+				TONEGEN_INTERFACE, "StopTone",
+				NULL, NULL,
+				DBUS_TYPE_INVALID);
+
+		ptone = g_slist_nth_data(tones, 0);
+		tones = g_slist_remove(tones, ptone);
+
+		ret = tonegen_startevent(GPOINTER_TO_UINT(ptone));
+		if (ret < 0)
+			goto done;
+
+		return TRUE;
+	}
+done:
+	return FALSE;
+}
+
+void tones_timer_notify(gpointer data)
+{
+	send_method_call(TONEGEN_BUS_NAME, TONEGEN_PATH,
+				TONEGEN_INTERFACE, "StopTone",
+				NULL, NULL,
+				DBUS_TYPE_INVALID);
+	g_slist_free(tones);
+	tones = NULL;
+
+	create_tones_timer = 0;
+}
+
+static void start_feedback_tone(char tone)
+{
+	if (!create_tones_timer) {
+		int ret;
+
+		ret = tonegen_startevent(tone);
+		if (ret < 0)
+			return;
+
+		create_tones_timer = g_timeout_add_full(G_PRIORITY_DEFAULT,
+						FEEDBACK_TONE_DURATION,
+						stop_feedback_tone,
+						NULL,
+						tones_timer_notify);
+	} else {
+		glong dtmf_tone = tone;
+
+		DBG("add %c to queue", tone);
+		tones = g_slist_append(tones, GUINT_TO_POINTER(dtmf_tone));
+	}
+}
+
 void telephony_transmit_dtmf_req(void *telephony_device, char tone)
 {
 	DBG("telephony-maemo6: transmit dtmf: %c", tone);
 
 	start_dtmf(telephony_device, tone);
+
+	start_feedback_tone(tone);
 }
 
 void telephony_subscriber_number_req(void *telephony_device)
-- 
1.7.4.1

