Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?=
	<frederic.danis@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v17 03/15] audio: Move telephony drivers to D-Bus interface
Date: Fri,  3 Aug 2012 14:07:08 +0200
Message-Id: <1343995640-19784-4-git-send-email-frederic.danis@linux.intel.com>
In-Reply-To: <1343995640-19784-1-git-send-email-frederic.danis@linux.intel.com>
References: <1343995640-19784-1-git-send-email-frederic.danis@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Add a D-Bus interface called org.bluez.Telephony to replace current
telephony drivers for HeadSet/HandsFree Profiles.

This will simplify BlueZ code by focusing on the Bluetooth
communication part and by letting the external application (i.e. oFono)
take charge of the Telephony tasks (AT parsing and modem specific code,
which can be removed from BlueZ code). So, it becomes simpler, easier
to maintain and debug.

Telephony application will have to register an agent using this new
interface.

Remove functions related to AT parsing from audio/headset.c.

Remove current telephony drivers (dummy, maemo 5, maemo 6 and oFono)
from the build as they have been replaced and are no longer needed.
---
 Makefile.am       |   13 +-
 audio/headset.c   |  694 +++++------------------------------------------------
 audio/headset.h   |    3 +
 audio/manager.c   |   13 +-
 audio/telephony.c |  633 ++++++++++++++++++++++++++++++++++++++++++++++++
 audio/telephony.h |   35 +--
 6 files changed, 719 insertions(+), 672 deletions(-)
 create mode 100644 audio/telephony.c

diff --git a/Makefile.am b/Makefile.am
index 1aa302c..2a8b903 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -148,14 +148,8 @@ builtin_sources += audio/main.c \
 			audio/avdtp.h audio/avdtp.c \
 			audio/media.h audio/media.c \
 			audio/transport.h audio/transport.c \
-			audio/telephony.h audio/a2dp-codecs.h
-builtin_nodist += audio/telephony.c
-
-noinst_LIBRARIES += audio/libtelephony.a
-
-audio_libtelephony_a_SOURCES = audio/telephony.h audio/telephony-dummy.c \
-				audio/telephony-maemo5.c audio/telephony-ofono.c \
-				audio/telephony-maemo6.c
+			audio/telephony.h audio/telephony.c \
+			audio/a2dp-codecs.h
 endif
 
 if SAPPLUGIN
@@ -428,9 +422,6 @@ MAINTAINERCLEANFILES = Makefile.in \
 src/builtin.h: src/genbuiltin $(builtin_sources)
 	$(AM_V_GEN)$(srcdir)/src/genbuiltin $(builtin_modules) > $@
 
-audio/telephony.c: audio/@TELEPHONY_DRIVER@
-	$(AM_V_GEN)$(LN_S) $(abs_top_builddir)/$< $@
-
 profiles/sap/sap.c: profiles/sap/@SAP_DRIVER@
 	$(AM_V_GEN)$(LN_S) $(abs_top_srcdir)/$< $@
 
diff --git a/audio/headset.c b/audio/headset.c
index 1014c59..668e9f1 100644
--- a/audio/headset.c
+++ b/audio/headset.c
@@ -42,11 +42,16 @@
 #include <bluetooth/bluetooth.h>
 #include <bluetooth/sdp.h>
 #include <bluetooth/sdp_lib.h>
+#include <bluetooth/uuid.h>
 
 #include <glib.h>
 #include <dbus/dbus.h>
 #include <gdbus.h>
 
+#include "btio.h"
+#include "../src/adapter.h"
+#include "../src/device.h"
+
 #include "log.h"
 #include "device.h"
 #include "manager.h"
@@ -54,10 +59,7 @@
 #include "telephony.h"
 #include "headset.h"
 #include "sdp-client.h"
-#include "btio.h"
 #include "dbus-common.h"
-#include "../src/adapter.h"
-#include "../src/device.h"
 
 #define DC_TIMEOUT 3
 
@@ -69,8 +71,6 @@
 #define HEADSET_GAIN_MICROPHONE 'M'
 
 static struct {
-	gboolean telephony_ready;	/* Telephony plugin initialized */
-	uint32_t features;		/* HFP AG features */
 	const struct indicator *indicators;	/* Available HFP indicators */
 	int er_mode;			/* Event reporting mode */
 	int er_ind;			/* Event reporting for indicators */
@@ -80,8 +80,6 @@ static struct {
 	guint ring_timer;		/* For incoming call indication */
 	const char *chld;		/* Response to AT+CHLD=? */
 } ag = {
-	.telephony_ready = FALSE,
-	.features = 0,
 	.er_mode = 3,
 	.er_ind = 0,
 	.rh = BTRH_NOT_SUPPORTED,
@@ -132,9 +130,7 @@ struct pending_connect {
 };
 
 struct headset_slc {
-	char buf[BUF_SIZE];
-	int data_start;
-	int data_length;
+	struct telephony_device *tel_dev;
 
 	gboolean cli_active;
 	gboolean cme_enabled;
@@ -158,6 +154,7 @@ struct headset {
 
 	GIOChannel *rfcomm;
 	GIOChannel *tmp_rfcomm;
+	const char *connecting_uuid;
 	GIOChannel *sco;
 	guint sco_id;
 
@@ -235,40 +232,6 @@ static void print_ag_features(uint32_t features)
 	g_free(str);
 }
 
-static void print_hf_features(uint32_t features)
-{
-	GString *gstr;
-	char *str;
-
-	if (features == 0) {
-		DBG("HFP HF features: (none)");
-		return;
-	}
-
-	gstr = g_string_new("HFP HF features: ");
-
-	if (features & HF_FEATURE_EC_ANDOR_NR)
-		g_string_append(gstr, "\"EC and/or NR function\" ");
-	if (features & HF_FEATURE_CALL_WAITING_AND_3WAY)
-		g_string_append(gstr, "\"Call waiting and 3-way calling\" ");
-	if (features & HF_FEATURE_CLI_PRESENTATION)
-		g_string_append(gstr, "\"CLI presentation capability\" ");
-	if (features & HF_FEATURE_VOICE_RECOGNITION)
-		g_string_append(gstr, "\"Voice recognition activation\" ");
-	if (features & HF_FEATURE_REMOTE_VOLUME_CONTROL)
-		g_string_append(gstr, "\"Remote volume control\" ");
-	if (features & HF_FEATURE_ENHANCED_CALL_STATUS)
-		g_string_append(gstr, "\"Enhanced call status\" ");
-	if (features & HF_FEATURE_ENHANCED_CALL_CONTROL)
-		g_string_append(gstr, "\"Enhanced call control\" ");
-
-	str = g_string_free(gstr, FALSE);
-
-	DBG("%s", str);
-
-	g_free(str);
-}
-
 static const char *state2str(headset_state_t state)
 {
 	switch (state) {
@@ -332,97 +295,6 @@ static int __attribute__((format(printf, 2, 3)))
 	return ret;
 }
 
-static int supported_features(struct audio_device *device, const char *buf)
-{
-	struct headset *hs = device->headset;
-	struct headset_slc *slc = hs->slc;
-	int err;
-
-	if (strlen(buf) < 9)
-		return -EINVAL;
-
-	slc->hf_features = strtoul(&buf[8], NULL, 10);
-
-	print_hf_features(slc->hf_features);
-
-	err = headset_send(hs, "\r\n+BRSF: %u\r\n", ag.features);
-	if (err < 0)
-		return err;
-
-	return headset_send(hs, "\r\nOK\r\n");
-}
-
-static char *indicator_ranges(const struct indicator *indicators)
-{
-	int i;
-	GString *gstr;
-
-	gstr = g_string_new("\r\n+CIND: ");
-
-	for (i = 0; indicators[i].desc != NULL; i++) {
-		if (i == 0)
-			g_string_append_printf(gstr, "(\"%s\",(%s))",
-						indicators[i].desc,
-						indicators[i].range);
-		else
-			g_string_append_printf(gstr, ",(\"%s\",(%s))",
-						indicators[i].desc,
-						indicators[i].range);
-	}
-
-	g_string_append(gstr, "\r\n");
-
-	return g_string_free(gstr, FALSE);
-}
-
-static char *indicator_values(const struct indicator *indicators)
-{
-	int i;
-	GString *gstr;
-
-	gstr = g_string_new("\r\n+CIND: ");
-
-	for (i = 0; indicators[i].desc != NULL; i++) {
-		if (i == 0)
-			g_string_append_printf(gstr, "%d", indicators[i].val);
-		else
-			g_string_append_printf(gstr, ",%d", indicators[i].val);
-	}
-
-	g_string_append(gstr, "\r\n");
-
-	return g_string_free(gstr, FALSE);
-}
-
-static int report_indicators(struct audio_device *device, const char *buf)
-{
-	struct headset *hs = device->headset;
-	int err;
-	char *str;
-
-	if (strlen(buf) < 8)
-		return -EINVAL;
-
-	if (ag.indicators == NULL) {
-		error("HFP AG indicators not initialized");
-		return headset_send(hs, "\r\nERROR\r\n");
-	}
-
-	if (buf[7] == '=')
-		str = indicator_ranges(ag.indicators);
-	else
-		str = indicator_values(ag.indicators);
-
-	err = headset_send(hs, "%s", str);
-
-	g_free(str);
-
-	if (err < 0)
-		return err;
-
-	return headset_send(hs, "\r\nOK\r\n");
-}
-
 static void pending_connect_complete(struct connect_cb *cb, struct audio_device *dev)
 {
 	struct headset *hs = dev->headset;
@@ -655,12 +527,12 @@ static int hfp_cmp(struct headset *hs)
 		return -1;
 }
 
-static void hfp_slc_complete(struct audio_device *dev)
+void headset_profile_connection_complete(struct audio_device *dev)
 {
 	struct headset *hs = dev->headset;
 	struct pending_connect *p = hs->pending;
 
-	DBG("HFP Service Level Connection established");
+	DBG("Profile connection established");
 
 	headset_set_state(dev, HEADSET_STATE_CONNECTED);
 
@@ -707,6 +579,7 @@ int telephony_event_reporting_rsp(void *telephony_device, cme_error_t err)
 	struct audio_device *device = telephony_device;
 	struct headset *hs = device->headset;
 	struct headset_slc *slc = hs->slc;
+	uint32_t ag_features;
 	int ret;
 
 	if (err != CME_ERROR_NONE)
@@ -719,74 +592,12 @@ int telephony_event_reporting_rsp(void *telephony_device, cme_error_t err)
 	if (hs->state != HEADSET_STATE_CONNECTING)
 		return 0;
 
+	ag_features = telephony_get_ag_features();
 	if (slc->hf_features & HF_FEATURE_CALL_WAITING_AND_3WAY &&
-			ag.features & AG_FEATURE_THREE_WAY_CALLING)
+			ag_features & AG_FEATURE_THREE_WAY_CALLING)
 		return 0;
 
-	hfp_slc_complete(device);
-
-	return 0;
-}
-
-static int event_reporting(struct audio_device *dev, const char *buf)
-{
-	char **tokens; /* <mode>, <keyp>, <disp>, <ind>, <bfr> */
-
-	if (strlen(buf) < 13)
-		return -EINVAL;
-
-	tokens = g_strsplit(&buf[8], ",", 5);
-	if (g_strv_length(tokens) < 4) {
-		g_strfreev(tokens);
-		return -EINVAL;
-	}
-
-	ag.er_mode = atoi(tokens[0]);
-	ag.er_ind = atoi(tokens[3]);
-
-	g_strfreev(tokens);
-	tokens = NULL;
-
-	DBG("Event reporting (CMER): mode=%d, ind=%d",
-			ag.er_mode, ag.er_ind);
-
-	switch (ag.er_ind) {
-	case 0:
-	case 1:
-		telephony_event_reporting_req(dev, ag.er_ind);
-		break;
-	default:
-		return -EINVAL;
-	}
-
-	return 0;
-}
-
-static int call_hold(struct audio_device *dev, const char *buf)
-{
-	struct headset *hs = dev->headset;
-	int err;
-
-	if (strlen(buf) < 9)
-		return -EINVAL;
-
-	if (buf[8] != '?') {
-		telephony_call_hold_req(dev, &buf[8]);
-		return 0;
-	}
-
-	err = headset_send(hs, "\r\n+CHLD: (%s)\r\n", ag.chld);
-	if (err < 0)
-		return err;
-
-	err = headset_send(hs, "\r\nOK\r\n");
-	if (err < 0)
-		return err;
-
-	if (hs->state != HEADSET_STATE_CONNECTING)
-		return 0;
-
-	hfp_slc_complete(dev);
+	headset_profile_connection_complete(device);
 
 	return 0;
 }
@@ -796,47 +607,11 @@ int telephony_key_press_rsp(void *telephony_device, cme_error_t err)
 	return telephony_generic_rsp(telephony_device, err);
 }
 
-static int key_press(struct audio_device *device, const char *buf)
-{
-	if (strlen(buf) < 9)
-		return -EINVAL;
-
-	g_dbus_emit_signal(device->conn, device->path,
-			AUDIO_HEADSET_INTERFACE, "AnswerRequested",
-			DBUS_TYPE_INVALID);
-
-	if (ag.ring_timer) {
-		g_source_remove(ag.ring_timer);
-		ag.ring_timer = 0;
-	}
-
-	telephony_key_press_req(device, &buf[8]);
-
-	return 0;
-}
-
 int telephony_answer_call_rsp(void *telephony_device, cme_error_t err)
 {
 	return telephony_generic_rsp(telephony_device, err);
 }
 
-static int answer_call(struct audio_device *device, const char *buf)
-{
-	if (ag.ring_timer) {
-		g_source_remove(ag.ring_timer);
-		ag.ring_timer = 0;
-	}
-
-	if (ag.number) {
-		g_free(ag.number);
-		ag.number = NULL;
-	}
-
-	telephony_answer_call_req(device);
-
-	return 0;
-}
-
 int telephony_terminate_call_rsp(void *telephony_device,
 					cme_error_t err)
 {
@@ -853,99 +628,21 @@ int telephony_terminate_call_rsp(void *telephony_device,
 	return headset_send(hs, "\r\nOK\r\n");
 }
 
-static int terminate_call(struct audio_device *device, const char *buf)
-{
-	if (ag.number) {
-		g_free(ag.number);
-		ag.number = NULL;
-	}
-
-	if (ag.ring_timer) {
-		g_source_remove(ag.ring_timer);
-		ag.ring_timer = 0;
-	}
-
-	telephony_terminate_call_req(device);
-
-	return 0;
-}
-
-static int cli_notification(struct audio_device *device, const char *buf)
-{
-	struct headset *hs = device->headset;
-	struct headset_slc *slc = hs->slc;
-
-	if (strlen(buf) < 9)
-		return -EINVAL;
-
-	slc->cli_active = buf[8] == '1' ? TRUE : FALSE;
-
-	return headset_send(hs, "\r\nOK\r\n");
-}
-
 int telephony_response_and_hold_rsp(void *telephony_device, cme_error_t err)
 {
 	return telephony_generic_rsp(telephony_device, err);
 }
 
-static int response_and_hold(struct audio_device *device, const char *buf)
-{
-	struct headset *hs = device->headset;
-
-	if (strlen(buf) < 8)
-		return -EINVAL;
-
-	if (ag.rh == BTRH_NOT_SUPPORTED)
-		return telephony_generic_rsp(device, CME_ERROR_NOT_SUPPORTED);
-
-	if (buf[7] == '=') {
-		telephony_response_and_hold_req(device, atoi(&buf[8]) < 0);
-		return 0;
-	}
-
-	if (ag.rh >= 0)
-		headset_send(hs, "\r\n+BTRH: %d\r\n", ag.rh);
-
-	return headset_send(hs, "\r\nOK\r\n");
-}
-
 int telephony_last_dialed_number_rsp(void *telephony_device, cme_error_t err)
 {
 	return telephony_generic_rsp(telephony_device, err);
 }
 
-static int last_dialed_number(struct audio_device *device, const char *buf)
-{
-	telephony_last_dialed_number_req(device);
-
-	return 0;
-}
-
 int telephony_dial_number_rsp(void *telephony_device, cme_error_t err)
 {
 	return telephony_generic_rsp(telephony_device, err);
 }
 
-static int dial_number(struct audio_device *device, const char *buf)
-{
-	char number[BUF_SIZE];
-	size_t buf_len;
-
-	buf_len = strlen(buf);
-
-	if (buf[buf_len - 1] != ';') {
-		DBG("Rejecting non-voice call dial request");
-		return -EINVAL;
-	}
-
-	memset(number, 0, sizeof(number));
-	strncpy(number, &buf[3], buf_len - 4);
-
-	telephony_dial_number_req(device, number);
-
-	return 0;
-}
-
 static int headset_set_gain(struct audio_device *device, uint16_t gain, char type)
 {
 	struct headset *hs = device->headset;
@@ -993,111 +690,21 @@ static int headset_set_gain(struct audio_device *device, uint16_t gain, char typ
 	return 0;
 }
 
-static int signal_gain_setting(struct audio_device *device, const char *buf)
-{
-	struct headset *hs = device->headset;
-	dbus_uint16_t gain;
-	int err;
-
-	if (strlen(buf) < 8) {
-		error("Too short string for Gain setting");
-		return -EINVAL;
-	}
-
-	gain = (dbus_uint16_t) strtol(&buf[7], NULL, 10);
-
-	err = headset_set_gain(device, gain, buf[5]);
-	if (err < 0 && err != -EALREADY)
-		return err;
-
-	return headset_send(hs, "\r\nOK\r\n");
-}
-
 int telephony_transmit_dtmf_rsp(void *telephony_device, cme_error_t err)
 {
 	return telephony_generic_rsp(telephony_device, err);
 }
 
-static int dtmf_tone(struct audio_device *device, const char *buf)
-{
-	char tone;
-
-	if (strlen(buf) < 8) {
-		error("Too short string for DTMF tone");
-		return -EINVAL;
-	}
-
-	tone = buf[7];
-	if (tone >= '#' && tone <= 'D')
-		telephony_transmit_dtmf_req(device, tone);
-	else
-		return -EINVAL;
-
-	return 0;
-}
-
 int telephony_subscriber_number_rsp(void *telephony_device, cme_error_t err)
 {
 	return telephony_generic_rsp(telephony_device, err);
 }
 
-static int subscriber_number(struct audio_device *device, const char *buf)
-{
-	telephony_subscriber_number_req(device);
-
-	return 0;
-}
-
 int telephony_list_current_calls_rsp(void *telephony_device, cme_error_t err)
 {
 	return telephony_generic_rsp(telephony_device, err);
 }
 
-static int list_current_calls(struct audio_device *device, const char *buf)
-{
-	telephony_list_current_calls_req(device);
-
-	return 0;
-}
-
-static int extended_errors(struct audio_device *device, const char *buf)
-{
-	struct headset *hs = device->headset;
-	struct headset_slc *slc = hs->slc;
-
-	if (strlen(buf) < 9)
-		return -EINVAL;
-
-	if (buf[8] == '1') {
-		slc->cme_enabled = TRUE;
-		DBG("CME errors enabled for headset %p", hs);
-	} else {
-		slc->cme_enabled = FALSE;
-		DBG("CME errors disabled for headset %p", hs);
-	}
-
-	return headset_send(hs, "\r\nOK\r\n");
-}
-
-static int call_waiting_notify(struct audio_device *device, const char *buf)
-{
-	struct headset *hs = device->headset;
-	struct headset_slc *slc = hs->slc;
-
-	if (strlen(buf) < 9)
-		return -EINVAL;
-
-	if (buf[8] == '1') {
-		slc->cwa_enabled = TRUE;
-		DBG("Call waiting notification enabled for headset %p", hs);
-	} else {
-		slc->cwa_enabled = FALSE;
-		DBG("Call waiting notification disabled for headset %p", hs);
-	}
-
-	return headset_send(hs, "\r\nOK\r\n");
-}
-
 int telephony_operator_selection_rsp(void *telephony_device, cme_error_t err)
 {
 	return telephony_generic_rsp(telephony_device, err);
@@ -1145,108 +752,6 @@ int telephony_operator_selection_ind(int mode, const char *oper)
 	return 0;
 }
 
-static int operator_selection(struct audio_device *device, const char *buf)
-{
-	struct headset *hs = device->headset;
-
-	if (strlen(buf) < 8)
-		return -EINVAL;
-
-	switch (buf[7]) {
-	case '?':
-		telephony_operator_selection_req(device);
-		break;
-	case '=':
-		return headset_send(hs, "\r\nOK\r\n");
-	default:
-		return -EINVAL;
-	}
-
-	return 0;
-}
-
-static int nr_and_ec(struct audio_device *device, const char *buf)
-{
-	struct headset *hs = device->headset;
-	struct headset_slc *slc = hs->slc;
-
-	if (strlen(buf) < 9)
-		return -EINVAL;
-
-	if (buf[8] == '0')
-		slc->nrec_req = FALSE;
-	else
-		slc->nrec_req = TRUE;
-
-	telephony_nr_and_ec_req(device, slc->nrec_req);
-
-	return 0;
-}
-
-static int voice_dial(struct audio_device *device, const char *buf)
-{
-	gboolean enable;
-
-	if (strlen(buf) < 9)
-		return -EINVAL;
-
-	if (buf[8] == '0')
-		enable = FALSE;
-	else
-		enable = TRUE;
-
-	telephony_voice_dial_req(device, enable);
-
-	return 0;
-}
-
-static int apple_command(struct audio_device *device, const char *buf)
-{
-	DBG("Got Apple command: %s", buf);
-
-	return telephony_generic_rsp(device, CME_ERROR_NONE);
-}
-
-static struct event event_callbacks[] = {
-	{ "ATA", answer_call },
-	{ "ATD", dial_number },
-	{ "AT+VG", signal_gain_setting },
-	{ "AT+BRSF", supported_features },
-	{ "AT+CIND", report_indicators },
-	{ "AT+CMER", event_reporting },
-	{ "AT+CHLD", call_hold },
-	{ "AT+CHUP", terminate_call },
-	{ "AT+CKPD", key_press },
-	{ "AT+CLIP", cli_notification },
-	{ "AT+BTRH", response_and_hold },
-	{ "AT+BLDN", last_dialed_number },
-	{ "AT+VTS", dtmf_tone },
-	{ "AT+CNUM", subscriber_number },
-	{ "AT+CLCC", list_current_calls },
-	{ "AT+CMEE", extended_errors },
-	{ "AT+CCWA", call_waiting_notify },
-	{ "AT+COPS", operator_selection },
-	{ "AT+NREC", nr_and_ec },
-	{ "AT+BVRA", voice_dial },
-	{ "AT+XAPL", apple_command },
-	{ "AT+IPHONEACCEV", apple_command },
-	{ 0 }
-};
-
-static int handle_event(struct audio_device *device, const char *buf)
-{
-	struct event *ev;
-
-	DBG("Received %s", buf);
-
-	for (ev = event_callbacks; ev->cmd; ev++) {
-		if (!strncmp(buf, ev->cmd, strlen(ev->cmd)))
-			return ev->callback(device, buf);
-	}
-
-	return -EINVAL;
-}
-
 static void close_sco(struct audio_device *device)
 {
 	struct headset *hs = device->headset;
@@ -1265,95 +770,6 @@ static void close_sco(struct audio_device *device)
 	}
 }
 
-static gboolean rfcomm_io_cb(GIOChannel *chan, GIOCondition cond,
-				struct audio_device *device)
-{
-	struct headset *hs;
-	struct headset_slc *slc;
-	unsigned char buf[BUF_SIZE];
-	ssize_t bytes_read;
-	size_t free_space;
-	int fd;
-
-	if (cond & G_IO_NVAL)
-		return FALSE;
-
-	hs = device->headset;
-	slc = hs->slc;
-
-	if (cond & (G_IO_ERR | G_IO_HUP)) {
-		DBG("ERR or HUP on RFCOMM socket");
-		goto failed;
-	}
-
-	fd = g_io_channel_unix_get_fd(chan);
-
-	bytes_read = read(fd, buf, sizeof(buf) - 1);
-	if (bytes_read < 0)
-		return TRUE;
-
-	free_space = sizeof(slc->buf) - slc->data_start -
-			slc->data_length - 1;
-
-	if (free_space < (size_t) bytes_read) {
-		/* Very likely that the HS is sending us garbage so
-		 * just ignore the data and disconnect */
-		error("Too much data to fit incoming buffer");
-		goto failed;
-	}
-
-	memcpy(&slc->buf[slc->data_start], buf, bytes_read);
-	slc->data_length += bytes_read;
-
-	/* Make sure the data is null terminated so we can use string
-	 * functions */
-	slc->buf[slc->data_start + slc->data_length] = '\0';
-
-	while (slc->data_length > 0) {
-		char *cr;
-		int err;
-		off_t cmd_len;
-
-		cr = strchr(&slc->buf[slc->data_start], '\r');
-		if (!cr)
-			break;
-
-		cmd_len = 1 + (off_t) cr - (off_t) &slc->buf[slc->data_start];
-		*cr = '\0';
-
-		if (cmd_len > 1)
-			err = handle_event(device, &slc->buf[slc->data_start]);
-		else
-			/* Silently skip empty commands */
-			err = 0;
-
-		if (err == -EINVAL) {
-			error("Badly formated or unrecognized command: %s",
-					&slc->buf[slc->data_start]);
-			err = telephony_generic_rsp(device,
-						CME_ERROR_NOT_SUPPORTED);
-			if (err < 0)
-				goto failed;
-		} else if (err < 0)
-			error("Error handling command %s: %s (%d)",
-						&slc->buf[slc->data_start],
-						strerror(-err), -err);
-
-		slc->data_start += cmd_len;
-		slc->data_length -= cmd_len;
-
-		if (!slc->data_length)
-			slc->data_start = 0;
-	}
-
-	return TRUE;
-
-failed:
-	headset_set_state(device, HEADSET_STATE_DISCONNECTED);
-
-	return FALSE;
-}
-
 static gboolean sco_cb(GIOChannel *chan, GIOCondition cond,
 			struct audio_device *device)
 {
@@ -1372,21 +788,33 @@ void headset_connect_cb(GIOChannel *chan, GError *err, gpointer user_data)
 {
 	struct audio_device *dev = user_data;
 	struct headset *hs = dev->headset;
+	struct btd_device *btd_dev = dev->btd_dev;
+	struct btd_adapter *adapter;
 	struct pending_connect *p = hs->pending;
 	char hs_address[18];
+	struct telephony_device *tel_dev;
 
 	if (err) {
 		error("%s", err->message);
 		goto failed;
 	}
 
+	adapter = device_get_adapter(btd_dev);
+
 	/* For HFP telephony isn't ready just disconnect */
-	if (hs->hfp_active && !ag.telephony_ready) {
+	if (hs->hfp_active && !telephony_is_ready(adapter)) {
 		error("Unable to accept HFP connection since the telephony "
 				"subsystem isn't initialized");
 		goto failed;
 	}
 
+	tel_dev = telephony_device_connecting(chan, btd_dev, dev,
+							hs->connecting_uuid);
+	if (tel_dev == NULL)
+		goto failed;
+
+	hs->connecting_uuid = NULL;
+
 	hs->rfcomm = hs->tmp_rfcomm;
 	hs->tmp_rfcomm = NULL;
 
@@ -1397,42 +825,21 @@ void headset_connect_cb(GIOChannel *chan, GError *err, gpointer user_data)
 	else
 		hs->auto_dc = FALSE;
 
-	g_io_add_watch(chan, G_IO_IN | G_IO_ERR | G_IO_HUP| G_IO_NVAL,
-			(GIOFunc) rfcomm_io_cb, dev);
-
 	DBG("%s: Connected to %s", dev->path, hs_address);
 
 	hs->slc = g_new0(struct headset_slc, 1);
+	hs->slc->tel_dev = tel_dev;
 	hs->slc->sp_gain = 15;
 	hs->slc->mic_gain = 15;
 	hs->slc->nrec = TRUE;
 
-	/* In HFP mode wait for Service Level Connection */
-	if (hs->hfp_active)
-		return;
-
-	headset_set_state(dev, HEADSET_STATE_CONNECTED);
-
-	if (p && p->target_state == HEADSET_STATE_PLAYING) {
-		p->err = sco_connect(dev, NULL, NULL, NULL);
-		if (p->err < 0)
-			goto failed;
-		return;
-	}
-
-	if (p && p->msg) {
-		DBusMessage *reply = dbus_message_new_method_return(p->msg);
-		g_dbus_send_message(dev->conn, reply);
-	}
-
-	pending_connect_finalize(dev);
-
 	return;
 
 failed:
 	if (p && p->msg)
 		error_connect_failed(dev->conn, p->msg, p->err);
 	pending_connect_finalize(dev);
+
 	if (hs->rfcomm)
 		headset_set_state(dev, HEADSET_STATE_CONNECTED);
 	else
@@ -1574,12 +981,19 @@ static int get_records(struct audio_device *device, headset_stream_cb_t cb,
 		svclass = hs->search_hfp ? HANDSFREE_SVCLASS_ID :
 							HEADSET_SVCLASS_ID;
 
+	if (svclass == HANDSFREE_SVCLASS_ID)
+		hs->connecting_uuid = HFP_AG_UUID;
+	else
+		hs->connecting_uuid = HSP_AG_UUID;
+
 	sdp_uuid16_create(&uuid, svclass);
 
 	err = bt_search_service(&device->src, &device->dst, &uuid,
 						get_record_cb, device, NULL);
-	if (err < 0)
+	if (err < 0) {
+		hs->connecting_uuid = NULL;
 		return err;
+	}
 
 	if (hs->pending) {
 		hs->pending->svclass = svclass;
@@ -1716,6 +1130,7 @@ static DBusMessage *hs_connect(DBusConnection *conn, DBusMessage *msg,
 {
 	struct audio_device *device = data;
 	struct headset *hs = device->headset;
+	struct btd_adapter *adapter;
 	int err;
 
 	if (hs->state == HEADSET_STATE_CONNECTING)
@@ -1723,7 +1138,9 @@ static DBusMessage *hs_connect(DBusConnection *conn, DBusMessage *msg,
 	else if (hs->state > HEADSET_STATE_CONNECTING)
 		return btd_error_already_connected(msg);
 
-	if (hs->hfp_handle && !ag.telephony_ready)
+	adapter = device_get_adapter(device->btd_dev);
+
+	if (hs->hfp_handle && !telephony_is_ready(adapter))
 		return btd_error_not_ready(msg);
 
 	device->auto_connect = FALSE;
@@ -2010,9 +1427,6 @@ static int headset_close_rfcomm(struct audio_device *dev)
 		hs->rfcomm = NULL;
 	}
 
-	g_free(hs->slc);
-	hs->slc = NULL;
-
 	return 0;
 }
 
@@ -2108,7 +1522,7 @@ uint32_t headset_config_init(GKeyFile *config)
 
 	/* Use the default values if there is no config file */
 	if (config == NULL)
-		return ag.features;
+		return telephony_get_ag_features();
 
 	str = g_key_file_get_string(config, "General", "SCORouting",
 					&err);
@@ -2138,7 +1552,7 @@ uint32_t headset_config_init(GKeyFile *config)
 		g_free(str);
 	}
 
-	return ag.features;
+	return telephony_get_ag_features();
 }
 
 static gboolean hs_dc_timeout(struct audio_device *dev)
@@ -2330,6 +1744,13 @@ GIOChannel *headset_get_rfcomm(struct audio_device *dev)
 	return hs->tmp_rfcomm;
 }
 
+void headset_set_connecting_uuid(struct audio_device *dev, const char *uuid)
+{
+	struct headset *hs = dev->headset;
+
+	hs->connecting_uuid = uuid;
+}
+
 int headset_connect_rfcomm(struct audio_device *dev, GIOChannel *io)
 {
 	struct headset *hs = dev->headset;
@@ -2381,6 +1802,14 @@ void headset_set_state(struct audio_device *dev, headset_state_t state)
 	case HEADSET_STATE_DISCONNECTED:
 		value = FALSE;
 		close_sco(dev);
+
+		if (dev->headset->slc) {
+			telephony_device_disconnect(slc->tel_dev);
+			slc->tel_dev = NULL;
+		}
+
+		dev->headset->connecting_uuid = NULL;
+
 		headset_close_rfcomm(dev);
 		emit_property_changed(dev->conn, dev->path,
 					AUDIO_HEADSET_INTERFACE, "State",
@@ -2393,7 +1822,6 @@ void headset_set_state(struct audio_device *dev, headset_state_t state)
 			emit_property_changed(dev->conn, dev->path,
 					AUDIO_HEADSET_INTERFACE, "Connected",
 					DBUS_TYPE_BOOLEAN, &value);
-			telephony_device_disconnected(dev);
 		}
 		active_devices = g_slist_remove(active_devices, dev);
 		break;
@@ -2409,7 +1837,8 @@ void headset_set_state(struct audio_device *dev, headset_state_t state)
 					AUDIO_HEADSET_INTERFACE, "State",
 					DBUS_TYPE_STRING, &state_str);
 		if (hs->state < state) {
-			if (ag.features & AG_FEATURE_INBAND_RINGTONE)
+			if (telephony_get_ag_features() &
+					AG_FEATURE_INBAND_RINGTONE)
 				slc->inband_ring = TRUE;
 			else
 				slc->inband_ring = FALSE;
@@ -2423,7 +1852,6 @@ void headset_set_state(struct audio_device *dev, headset_state_t state)
 						"Connected",
 						DBUS_TYPE_BOOLEAN, &value);
 			active_devices = g_slist_append(active_devices, dev);
-			telephony_device_connected(dev);
 		} else if (hs->state == HEADSET_STATE_PLAYING) {
 			value = FALSE;
 			g_dbus_emit_signal(dev->conn, dev->path,
@@ -2743,15 +2171,13 @@ int telephony_ready_ind(uint32_t features,
 			const struct indicator *indicators, int rh,
 			const char *chld)
 {
-	ag.telephony_ready = TRUE;
-	ag.features = features;
 	ag.indicators = indicators;
 	ag.rh = rh;
 	ag.chld = chld;
 
 	DBG("Telephony plugin initialized");
 
-	print_ag_features(ag.features);
+	print_ag_features(telephony_get_ag_features());
 
 	return 0;
 }
diff --git a/audio/headset.h b/audio/headset.h
index 465c2d6..d877eef 100644
--- a/audio/headset.h
+++ b/audio/headset.h
@@ -110,3 +110,6 @@ gboolean headset_unlock(struct audio_device *dev, headset_lock_t lock);
 gboolean headset_suspend(struct audio_device *dev, void *data);
 gboolean headset_play(struct audio_device *dev, void *data);
 void headset_shutdown(struct audio_device *dev);
+
+void headset_profile_connection_complete(struct audio_device *dev);
+void headset_set_connecting_uuid(struct audio_device *dev, const char *uuid);
diff --git a/audio/manager.c b/audio/manager.c
index 999124d..67193da 100644
--- a/audio/manager.c
+++ b/audio/manager.c
@@ -873,11 +873,12 @@ static void state_changed(struct btd_adapter *adapter, gboolean powered)
 	adp->powered = powered;
 
 	if (powered) {
-		/* telephony driver already initialized*/
-		if (telephony == TRUE)
-			return;
-		telephony_init();
-		telephony = TRUE;
+		if (telephony == FALSE) {
+			telephony_init();
+			telephony = TRUE;
+		}
+
+		telephony_adapter_init(adapter);
 		return;
 	}
 
@@ -885,6 +886,8 @@ static void state_changed(struct btd_adapter *adapter, gboolean powered)
 	if (telephony == FALSE)
 		return;
 
+	telephony_adapter_exit(adapter);
+
 	for (l = adapters; l; l = l->next) {
 		adp = l->data;
 
diff --git a/audio/telephony.c b/audio/telephony.c
new file mode 100644
index 0000000..49ccafd
--- /dev/null
+++ b/audio/telephony.c
@@ -0,0 +1,633 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2011  Intel Corporation
+ *  Copyright (C) 2004-2010  Marcel Holtmann <marcel@holtmann.org>
+ *  Copyright (C) 2011  Frederic Danis <frederic.danis@intel.com>
+ *
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ *
+ */
+
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#include <stdlib.h>
+
+#include <dbus/dbus.h>
+#include <gdbus.h>
+
+#include <bluetooth/bluetooth.h>
+#include <bluetooth/sdp.h>
+#include <bluetooth/sdp_lib.h>
+#include <bluetooth/uuid.h>
+
+#include "btio.h"
+#include "../src/adapter.h"
+#include "../src/device.h"
+
+#include "log.h"
+#include "device.h"
+#include "error.h"
+#include "glib-helper.h"
+#include "sdp-client.h"
+#include "headset.h"
+#include "telephony.h"
+#include "dbus-common.h"
+
+#define AUDIO_TELEPHONY_INTERFACE "org.bluez.Telephony"
+#define AUDIO_TELEPHONY_AGENT_INTERFACE "org.bluez.TelephonyAgent"
+
+#define DEFAULT_HS_HS_CHANNEL 6
+#define DEFAULT_HF_HS_CHANNEL 7
+
+/*
+ * Profile configuration
+ *
+ * It describes for each supported profile:
+ *  - UUID, RFCOMM channel and security level
+ *  - remote UUID, service class and profile descriptor if they exist
+ *  - profile connection complete callback called when agent replied to
+ *    NewConnection method call
+ */
+struct profile_config {
+	const char		*uuid;		/* agent property UUID */
+	uint8_t			channel;
+	const char		*r_uuid;
+	uint16_t		r_class;
+	uint16_t		r_profile;
+	DBusPendingCallNotifyFunction connection_reply;
+};
+
+/*
+ * Telephony agent
+ *
+ * It represents the telephony agent with provided version and features.
+ *
+ * This is done by adapter.
+ */
+struct telephony_agent {
+	struct btd_adapter	*btd_adapter;
+	struct profile_config	*config;	/* default configuration */
+	char			*name;		/* agent DBus bus id */
+	char			*path;		/* agent object path */
+	uint16_t		version;	/* agent profile version */
+	uint16_t		features;	/* agent supported features */
+	guint			watch;		/* agent disconnect watcher */
+};
+
+/*
+ * Telephony device
+ *
+ * It represents the connection between telephony agent (name, path and config)
+ * and remote device (with its profile version and supported features if they
+ * can be retrieved).
+ *
+ * This is used after authentication completion and remote SDP record retrieval
+ * (if supported by profile, i.e. HFP/HSP) until disconnection.
+ */
+struct telephony_device {
+	struct btd_device	*btd_dev;
+	struct profile_config	*config;	/* default configuration */
+	char			*name;		/* agent DBus bus id */
+	char			*path;		/* agent object path */
+	struct audio_device	*au_dev;	/* Audio device for HSP/HFP */
+	uint16_t		version;	/* remote profile version */
+	uint16_t		features;	/* remote supported features */
+	GIOChannel		*rfcomm;	/* connected RFCOMM channel */
+	gboolean		pending_sdp;	/* SDP request is pending */
+	DBusPendingCall		*call;		/* D-Bus pending call */
+};
+
+static DBusConnection *connection = NULL;
+
+static GSList *agents = NULL;	/* server list */
+
+static struct telephony_agent *find_agent(struct btd_adapter *adapter,
+					const char *sender, const char *path,
+					const char *uuid)
+{
+	GSList *l;
+
+	for (l = agents; l; l = l->next) {
+		struct telephony_agent *agent = l->data;
+
+		if (agent->btd_adapter != adapter)
+			continue;
+
+		if (sender && g_strcmp0(agent->name, sender) != 0)
+			continue;
+
+		if (path && g_strcmp0(agent->path, path) != 0)
+			continue;
+
+		if (uuid && g_strcmp0(agent->config->uuid, uuid) != 0)
+			continue;
+
+		return agent;
+	}
+
+	return NULL;
+}
+
+static void free_agent(struct telephony_agent *agent)
+{
+	DBusMessage *msg;
+
+	if (agent->watch) {
+		msg = dbus_message_new_method_call(agent->name, agent->path,
+				AUDIO_TELEPHONY_AGENT_INTERFACE, "Release");
+		dbus_message_set_no_reply(msg, TRUE);
+		g_dbus_send_message(connection, msg);
+
+		g_dbus_remove_watch(connection, agent->watch);
+		agent->watch = 0;
+	}
+
+	btd_adapter_unref(agent->btd_adapter);
+	g_free(agent->name);
+	g_free(agent->path);
+	g_free(agent);
+}
+
+gboolean telephony_is_uuid_supported(struct btd_adapter *adapter,
+						const char *uuid)
+{
+	return find_agent(adapter, NULL, NULL, uuid) != NULL;
+}
+
+static gboolean parse_properties(DBusMessageIter *props, const char **uuid,
+				uint16_t *version, uint16_t *features)
+{
+	gboolean has_uuid = FALSE;
+
+	while (dbus_message_iter_get_arg_type(props) == DBUS_TYPE_DICT_ENTRY) {
+		const char *key;
+		DBusMessageIter value, entry;
+		int var;
+
+		dbus_message_iter_recurse(props, &entry);
+		dbus_message_iter_get_basic(&entry, &key);
+
+		dbus_message_iter_next(&entry);
+		dbus_message_iter_recurse(&entry, &value);
+
+		var = dbus_message_iter_get_arg_type(&value);
+		if (strcasecmp(key, "UUID") == 0) {
+			if (var != DBUS_TYPE_STRING)
+				return FALSE;
+			dbus_message_iter_get_basic(&value, uuid);
+			has_uuid = TRUE;
+		} else if (strcasecmp(key, "Version") == 0) {
+			if (var != DBUS_TYPE_UINT16)
+				return FALSE;
+			dbus_message_iter_get_basic(&value, version);
+		} else if (strcasecmp(key, "Features") == 0) {
+			if (var != DBUS_TYPE_UINT16)
+				return FALSE;
+			dbus_message_iter_get_basic(&value, features);
+		}
+
+		dbus_message_iter_next(props);
+	}
+
+	return has_uuid;
+}
+
+static int dev_close(struct telephony_device *tel_dev)
+{
+	int sock;
+
+	if (tel_dev->rfcomm) {
+		sock = g_io_channel_unix_get_fd(tel_dev->rfcomm);
+		shutdown(sock, SHUT_RDWR);
+
+		g_io_channel_shutdown(tel_dev->rfcomm, TRUE, NULL);
+		g_io_channel_unref(tel_dev->rfcomm);
+
+		tel_dev->rfcomm = NULL;
+	}
+
+	return 0;
+}
+
+static gboolean agent_sendfd(struct telephony_device *tel_dev, int fd,
+				DBusPendingCallNotifyFunction notify)
+{
+	DBusMessage *msg;
+	DBusMessageIter iter, dict;
+	const char *path;
+
+	msg = dbus_message_new_method_call(tel_dev->name, tel_dev->path,
+			AUDIO_TELEPHONY_AGENT_INTERFACE, "NewConnection");
+
+	dbus_message_iter_init_append(msg, &iter);
+
+	dbus_message_iter_append_basic(&iter, DBUS_TYPE_UNIX_FD, &fd);
+
+	dbus_message_iter_open_container(&iter, DBUS_TYPE_ARRAY,
+			DBUS_DICT_ENTRY_BEGIN_CHAR_AS_STRING
+			DBUS_TYPE_STRING_AS_STRING DBUS_TYPE_VARIANT_AS_STRING
+			DBUS_DICT_ENTRY_END_CHAR_AS_STRING, &dict);
+
+	path = device_get_path(tel_dev->btd_dev);
+	dict_append_entry(&dict, "Device", DBUS_TYPE_OBJECT_PATH, &path);
+	dict_append_entry(&dict, "Version", DBUS_TYPE_UINT16,
+							&tel_dev->version);
+
+	if (tel_dev->features != 0xFFFF)
+		dict_append_entry(&dict, "Features", DBUS_TYPE_UINT16,
+							&tel_dev->features);
+
+	dbus_message_iter_close_container(&iter, &dict);
+
+	if (!dbus_connection_send_with_reply(connection, msg,
+							&tel_dev->call, -1)) {
+		dbus_message_unref(msg);
+		return FALSE;
+	}
+
+	dbus_pending_call_set_notify(tel_dev->call, notify, tel_dev, NULL);
+	dbus_message_unref(msg);
+
+	return TRUE;
+}
+
+static gboolean hs_dev_disconnect_cb(GIOChannel *chan, GIOCondition cond,
+					gpointer data)
+{
+	struct telephony_device *tel_dev = data;
+
+	if (cond & G_IO_NVAL)
+		return FALSE;
+
+	headset_set_state(tel_dev->au_dev, HEADSET_STATE_DISCONNECTED);
+
+	return FALSE;
+}
+
+static void hs_newconnection_reply(DBusPendingCall *call, void *user_data)
+{
+	struct telephony_device *tel_dev = user_data;
+	DBusMessage *reply = dbus_pending_call_steal_reply(call);
+	DBusError derr;
+
+	dbus_error_init(&derr);
+	if (dbus_set_error_from_message(&derr, reply)) {
+		DBG("Agent reply: %s", derr.message);
+		dbus_error_free(&derr);
+		headset_set_state(tel_dev->au_dev, HEADSET_STATE_DISCONNECTED);
+		goto done;
+	}
+
+	DBG("Agent reply: file descriptor passed successfully");
+	g_io_add_watch(tel_dev->rfcomm, G_IO_ERR | G_IO_HUP | G_IO_NVAL,
+			hs_dev_disconnect_cb, tel_dev);
+	headset_profile_connection_complete(tel_dev->au_dev);
+
+done:
+	dbus_pending_call_unref(tel_dev->call);
+	tel_dev->call = NULL;
+	dbus_message_unref(reply);
+}
+
+static void get_record_cb(sdp_list_t *recs, int err, gpointer user_data)
+{
+	struct telephony_device *tel_dev = user_data;
+	sdp_data_t *sdpdata;
+	uuid_t uuid;
+	sdp_list_t *profiles;
+	sdp_profile_desc_t *desc;
+	int sk;
+
+	tel_dev->pending_sdp = FALSE;
+
+	if (err < 0) {
+		error("Unable to get service record: %s (%d)", strerror(-err),
+					-err);
+		goto failed;
+	}
+
+	if (!recs || !recs->data) {
+		error("No records found");
+		goto failed;
+	}
+
+	if (!tel_dev->rfcomm) {
+		DBG("RFCOMM disconnected from server before sdp reply");
+		goto failed;
+	}
+
+	sdpdata = sdp_data_get(recs->data, SDP_ATTR_SUPPORTED_FEATURES);
+	if (sdpdata && sdpdata->dtd == SDP_UINT16)
+		tel_dev->features = sdpdata->val.uint16;
+
+	sdp_uuid16_create(&uuid, tel_dev->config->r_profile);
+
+	if (sdp_get_profile_descs(recs->data, &profiles) < 0)
+		goto failed;
+
+	desc = profiles->data;
+
+	if (sdp_uuid_cmp(&desc->uuid, &uuid) == 0)
+		tel_dev->version = desc->version;
+
+	sdp_list_free(profiles, free);
+
+	sk = g_io_channel_unix_get_fd(tel_dev->rfcomm);
+
+	if (agent_sendfd(tel_dev, sk, tel_dev->config->connection_reply) ==
+									FALSE) {
+		error("Failed to send RFCOMM socket to agent %s, path %s",
+						tel_dev->name, tel_dev->path);
+		goto failed;
+	}
+
+	return;
+
+failed:
+	headset_set_state(tel_dev->au_dev, HEADSET_STATE_DISCONNECTED);
+}
+
+struct telephony_device *telephony_device_connecting(GIOChannel *io,
+					struct btd_device *btd_dev,
+					struct audio_device *au_dev,
+					const char *uuid)
+{
+	struct btd_adapter *adapter;
+	struct telephony_agent *agent;
+	struct telephony_device *tel_dev;
+	uuid_t r_uuid;
+	int err;
+
+	adapter = device_get_adapter(btd_dev);
+	agent = find_agent(adapter, NULL, NULL, uuid);
+	if (agent == NULL)
+		return NULL;
+
+	tel_dev = g_new0(struct telephony_device, 1);
+	tel_dev->btd_dev = btd_device_ref(btd_dev);
+	tel_dev->name = g_strdup(agent->name);
+	tel_dev->path = g_strdup(agent->path);
+	tel_dev->config = agent->config;
+	tel_dev->au_dev = au_dev;
+	tel_dev->rfcomm = g_io_channel_ref(io);
+	tel_dev->features = 0xFFFF;
+
+	sdp_uuid16_create(&r_uuid, tel_dev->config->r_class);
+
+	err = bt_search_service(&au_dev->src, &au_dev->dst, &r_uuid,
+				get_record_cb, tel_dev, NULL);
+	if (err < 0) {
+		telephony_device_disconnect(tel_dev);
+		return NULL;
+	}
+
+	tel_dev->pending_sdp = TRUE;
+
+	return tel_dev;
+}
+
+void telephony_device_disconnect(struct telephony_device *device)
+{
+	dev_close(device);
+
+	if (device->pending_sdp) {
+		struct btd_adapter *adapter;
+		bdaddr_t src, dst;
+
+		adapter = device_get_adapter(device->btd_dev);
+		adapter_get_address(adapter, &src);
+		device_get_address(device->btd_dev, &dst, NULL);
+		bt_cancel_discovery(&src, &dst);
+	}
+
+	if (device->call) {
+		dbus_pending_call_cancel(device->call);
+		dbus_pending_call_unref(device->call);
+	}
+
+	btd_device_unref(device->btd_dev);
+	g_free(device->name);
+	g_free(device->path);
+	g_free(device);
+}
+
+gboolean telephony_is_ready(struct btd_adapter *adapter)
+{
+	return find_agent(adapter, NULL, NULL, HFP_AG_UUID) ? TRUE : FALSE;
+}
+
+uint32_t telephony_get_ag_features(void)
+{
+	return 0;
+}
+
+static struct profile_config default_configs[] = {
+	{ HSP_AG_UUID,
+		DEFAULT_HS_AG_CHANNEL,
+		HSP_HS_UUID,
+		HEADSET_SVCLASS_ID,
+		HEADSET_PROFILE_ID,
+		hs_newconnection_reply },
+	{ HFP_AG_UUID,
+		DEFAULT_HF_AG_CHANNEL,
+		HFP_HS_UUID,
+		HANDSFREE_SVCLASS_ID,
+		HANDSFREE_PROFILE_ID,
+		hs_newconnection_reply },
+};
+
+static void agent_disconnect_cb(DBusConnection *conn, void *user_data)
+{
+	struct telephony_agent *agent = user_data;
+
+	DBG("Agent exited without calling Unregister");
+
+	agent->watch = 0;
+	agents = g_slist_remove(agents, agent);
+	free_agent(agent);
+}
+
+static struct telephony_agent *agent_new(struct btd_adapter *adapter,
+					const char *sender, const char *path,
+					const char *uuid, uint16_t version,
+					uint16_t features)
+{
+	unsigned int i;
+
+	for (i = 0; i < G_N_ELEMENTS(default_configs) ; i++) {
+		if (strcasecmp(uuid, default_configs[i].uuid) == 0) {
+			struct telephony_agent *agent;
+
+			agent = g_new0(struct telephony_agent, 1);
+			agent->btd_adapter = btd_adapter_ref(adapter);
+			agent->config = &default_configs[i];
+			agent->name = g_strdup(sender);
+			agent->path = g_strdup(path);
+			agent->version = version;
+			agent->features = features;
+
+			return agent;
+		}
+	}
+
+	return NULL;
+}
+
+static DBusMessage *register_agent(DBusConnection *conn,
+					DBusMessage *msg, void *data)
+{
+	struct btd_adapter *adapter = data;
+	DBusMessageIter args, props;
+	const char *sender, *path, *uuid;
+	uint16_t version = 0;
+	uint16_t features = 0xFFFF;
+	struct telephony_agent *agent;
+
+	sender = dbus_message_get_sender(msg);
+
+	dbus_message_iter_init(msg, &args);
+
+	dbus_message_iter_get_basic(&args, &path);
+	dbus_message_iter_next(&args);
+
+	if (find_agent(adapter, sender, path, NULL) != NULL)
+		return btd_error_already_exists(msg);
+
+	dbus_message_iter_recurse(&args, &props);
+	if (dbus_message_iter_get_arg_type(&props) != DBUS_TYPE_DICT_ENTRY)
+		return btd_error_invalid_args(msg);
+
+	if (!parse_properties(&props, &uuid, &version, &features))
+		return btd_error_invalid_args(msg);
+
+	if (find_agent(adapter, NULL, NULL, uuid) != NULL)
+		return btd_error_already_exists(msg);
+
+	/* initialize agent properties */
+	agent = agent_new(adapter, sender, path, uuid, version, features);
+	if (agent == NULL)
+		return btd_error_invalid_args(msg);
+
+	agent->watch = g_dbus_add_disconnect_watch(conn, sender,
+							agent_disconnect_cb,
+							agent, NULL);
+
+	DBG("Register agent : %s%s for %s version 0x%04X with features 0x%02X",
+					sender, path, uuid, version, features);
+
+	agents = g_slist_append(agents, agent);
+
+	return g_dbus_create_reply(msg, DBUS_TYPE_INVALID);
+}
+
+static DBusMessage *unregister_agent(DBusConnection *conn,
+				DBusMessage *msg, void *data)
+{
+	struct btd_adapter *adapter = data;
+	const char *sender, *path;
+	struct telephony_agent *agent;
+
+	if (!dbus_message_get_args(msg, NULL,
+				DBUS_TYPE_OBJECT_PATH, &path,
+				DBUS_TYPE_INVALID))
+		return NULL;
+
+	sender = dbus_message_get_sender(msg);
+
+	agent = find_agent(adapter, sender, path, NULL);
+	if (agent == NULL)
+		return btd_error_does_not_exist(msg);
+
+	agents = g_slist_remove(agents, agent);
+
+	DBG("Unregister agent : %s%s", sender, path);
+
+	free_agent(agent);
+
+	return g_dbus_create_reply(msg, DBUS_TYPE_INVALID);
+}
+
+static const GDBusMethodTable telsrv_methods[] = {
+	{ GDBUS_METHOD("RegisterAgent",
+			GDBUS_ARGS({ "agent", "o" }, { "properties", "a{sv}" }),
+			NULL, register_agent) },
+	{ GDBUS_METHOD("UnregisterAgent",
+			GDBUS_ARGS({ "agent", "o" }), NULL, unregister_agent) },
+	{ }
+};
+
+static void path_unregister(void *data)
+{
+	DBG("Unregistered interface %s", AUDIO_TELEPHONY_INTERFACE);
+}
+
+int telephony_adapter_init(struct btd_adapter *adapter)
+{
+	const char *path;
+
+	DBG("adapter: %p", adapter);
+
+	path = adapter_get_path(adapter);
+
+	if (!g_dbus_register_interface(connection, path,
+					AUDIO_TELEPHONY_INTERFACE,
+					telsrv_methods, NULL,
+					NULL, adapter, path_unregister)) {
+		error("D-Bus failed to register %s interface",
+				AUDIO_TELEPHONY_INTERFACE);
+		return -1;
+	}
+
+	DBG("Registered interface %s", AUDIO_TELEPHONY_INTERFACE);
+
+	return 0;
+}
+
+void telephony_adapter_exit(struct btd_adapter *adapter)
+{
+	struct telephony_agent *agent;
+
+	DBG("adapter: %p", adapter);
+
+	g_dbus_unregister_interface(connection, adapter_get_path(adapter),
+			AUDIO_TELEPHONY_INTERFACE);
+
+	while ((agent = find_agent(adapter, NULL, NULL, NULL)) != NULL) {
+		agents = g_slist_remove(agents, agent);
+		free_agent(agent);
+	}
+}
+
+int telephony_init(void)
+{
+	DBG("");
+
+	connection = dbus_bus_get(DBUS_BUS_SYSTEM, NULL);
+
+	return 0;
+}
+
+void telephony_exit(void)
+{
+	DBG("");
+
+	dbus_connection_unref(connection);
+	connection = NULL;
+}
diff --git a/audio/telephony.h b/audio/telephony.h
index 73b390c..f835202 100644
--- a/audio/telephony.h
+++ b/audio/telephony.h
@@ -141,29 +141,18 @@ struct indicator {
 	gboolean ignore_redundant;
 };
 
-/* Notify telephony-*.c of connected/disconnected devices. Implemented by
- * telephony-*.c
- */
-void telephony_device_connected(void *telephony_device);
-void telephony_device_disconnected(void *telephony_device);
+struct telephony_device;
 
-/* HF requests (sent by the handsfree device). These are implemented by
- * telephony-*.c
- */
-void telephony_event_reporting_req(void *telephony_device, int ind);
-void telephony_response_and_hold_req(void *telephony_device, int rh);
-void telephony_last_dialed_number_req(void *telephony_device);
-void telephony_terminate_call_req(void *telephony_device);
-void telephony_answer_call_req(void *telephony_device);
-void telephony_dial_number_req(void *telephony_device, const char *number);
-void telephony_transmit_dtmf_req(void *telephony_device, char tone);
-void telephony_subscriber_number_req(void *telephony_device);
-void telephony_list_current_calls_req(void *telephony_device);
-void telephony_operator_selection_req(void *telephony_device);
-void telephony_call_hold_req(void *telephony_device, const char *cmd);
-void telephony_nr_and_ec_req(void *telephony_device, gboolean enable);
-void telephony_voice_dial_req(void *telephony_device, gboolean enable);
-void telephony_key_press_req(void *telephony_device, const char *keys);
+struct telephony_device *telephony_device_connecting(GIOChannel *io,
+					struct btd_device *btd_dev,
+					struct audio_device *au_dev,
+					const char *uuid);
+void telephony_device_disconnect(struct telephony_device *device);
+
+gboolean telephony_is_ready(struct btd_adapter *adapter);
+uint32_t telephony_get_ag_features(void);
+gboolean telephony_is_uuid_supported(struct btd_adapter *adapter,
+						const char *uuid);
 
 /* AG responses to HF requests. These are implemented by headset.c */
 int telephony_event_reporting_rsp(void *telephony_device, cme_error_t err);
@@ -240,5 +229,7 @@ static inline int telephony_get_indicator(const struct indicator *indicators,
 	return -ENOENT;
 }
 
+int telephony_adapter_init(struct btd_adapter *adapter);
+void telephony_adapter_exit(struct btd_adapter *adapter);
 int telephony_init(void);
 void telephony_exit(void);
-- 
1.7.9.5

