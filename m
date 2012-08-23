Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?=
	<frederic.danis@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v18 04/16] audio: Remove telephony driver from headset.c
Date: Thu, 23 Aug 2012 16:38:53 +0200
Message-Id: <1345732745-28706-5-git-send-email-frederic.danis@linux.intel.com>
In-Reply-To: <1345732745-28706-1-git-send-email-frederic.danis@linux.intel.com>
References: <1345732745-28706-1-git-send-email-frederic.danis@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 .gitignore        |    1 -
 Makefile.am       |   14 +-
 audio/audio.conf  |    7 -
 audio/headset.c   | 1511 +----------------------------------------------------
 audio/telephony.h |  196 +------
 doc/audio-api.txt |  167 +-----
 6 files changed, 51 insertions(+), 1845 deletions(-)

diff --git a/.gitignore b/.gitignore
index c9f293a..4d9e63a 100644
--- a/.gitignore
+++ b/.gitignore
@@ -30,7 +30,6 @@ bluez.pc
 lib/bluetooth
 src/builtin.h
 src/bluetoothd
-audio/telephony.c
 scripts/bluetooth.rules
 scripts/97-bluetooth.rules
 scripts/97-bluetooth-hid2hci.rules
diff --git a/Makefile.am b/Makefile.am
index aae19f9..7054910 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -149,13 +149,6 @@ builtin_sources += audio/main.c \
 			audio/media.h audio/media.c \
 			audio/transport.h audio/transport.c \
 			audio/telephony.h audio/a2dp-codecs.h
-builtin_nodist += audio/telephony.c
-
-noinst_LIBRARIES += audio/libtelephony.a
-
-audio_libtelephony_a_SOURCES = audio/telephony.h audio/telephony-dummy.c \
-				audio/telephony-maemo5.c audio/telephony-ofono.c \
-				audio/telephony-maemo6.c
 endif
 
 if SAPPLUGIN
@@ -325,9 +318,7 @@ endif
 EXTRA_DIST += src/genbuiltin src/bluetooth.conf src/org.bluez.service \
 			src/main.conf profiles/network/network.conf \
 			profiles/input/input.conf profiles/proximity/proximity.conf \
-			audio/audio.conf audio/telephony-dummy.c \
-			audio/telephony-maemo5.c audio/telephony-ofono.c \
-			audio/telephony-maemo6.c profiles/sap/sap-dummy.c \
+			audio/audio.conf profiles/sap/sap-dummy.c \
 			profiles/sap/sap-u8500.c
 
 if AUDIOPLUGIN
@@ -432,9 +423,6 @@ MAINTAINERCLEANFILES = Makefile.in \
 src/builtin.h: src/genbuiltin $(builtin_sources)
 	$(AM_V_GEN)$(srcdir)/src/genbuiltin $(builtin_modules) > $@
 
-audio/telephony.c: audio/@TELEPHONY_DRIVER@
-	$(AM_V_GEN)$(LN_S) $(abs_top_builddir)/$< $@
-
 profiles/sap/sap.c: profiles/sap/@SAP_DRIVER@
 	$(AM_V_GEN)$(LN_S) $(abs_top_srcdir)/$< $@
 
diff --git a/audio/audio.conf b/audio/audio.conf
index 662647c..9e9e664 100644
--- a/audio/audio.conf
+++ b/audio/audio.conf
@@ -31,10 +31,3 @@ HFP=true
 
 # Maximum number of connected HSP/HFP devices per adapter. Defaults to 1
 MaxConnected=1
-
-# Set to true to enable use of fast connectable mode (faster page scanning)
-# for HFP when incoming call starts. Default settings are restored after
-# call is answered or rejected. Page scan interval is much shorter and page
-# scan type changed to interlaced. Such allows faster connection initiated
-# by a headset.
-FastConnectable=false
diff --git a/audio/headset.c b/audio/headset.c
index 1014c59..ded13ca 100644
--- a/audio/headset.c
+++ b/audio/headset.c
@@ -47,6 +47,10 @@
 #include <dbus/dbus.h>
 #include <gdbus.h>
 
+#include "btio.h"
+#include "../src/adapter.h"
+#include "../src/device.h"
+
 #include "log.h"
 #include "device.h"
 #include "manager.h"
@@ -54,46 +58,19 @@
 #include "telephony.h"
 #include "headset.h"
 #include "sdp-client.h"
-#include "btio.h"
 #include "dbus-common.h"
-#include "../src/adapter.h"
-#include "../src/device.h"
 
 #define DC_TIMEOUT 3
 
-#define RING_INTERVAL 3
-
-#define BUF_SIZE 1024
-
-#define HEADSET_GAIN_SPEAKER 'S'
-#define HEADSET_GAIN_MICROPHONE 'M'
-
 static struct {
 	gboolean telephony_ready;	/* Telephony plugin initialized */
 	uint32_t features;		/* HFP AG features */
-	const struct indicator *indicators;	/* Available HFP indicators */
-	int er_mode;			/* Event reporting mode */
-	int er_ind;			/* Event reporting for indicators */
-	int rh;				/* Response and Hold state */
-	char *number;			/* Incoming phone number */
-	int number_type;		/* Incoming number type */
-	guint ring_timer;		/* For incoming call indication */
-	const char *chld;		/* Response to AT+CHLD=? */
 } ag = {
 	.telephony_ready = FALSE,
 	.features = 0,
-	.er_mode = 3,
-	.er_ind = 0,
-	.rh = BTRH_NOT_SUPPORTED,
-	.number = NULL,
-	.number_type = 0,
-	.ring_timer = 0,
 };
 
 static gboolean sco_hci = TRUE;
-static gboolean fast_connectable = FALSE;
-
-static GSList *active_devices = NULL;
 
 static char *str_state[] = {
 	"HEADSET_STATE_DISCONNECTED",
@@ -131,25 +108,6 @@ struct pending_connect {
 	uint16_t svclass;
 };
 
-struct headset_slc {
-	char buf[BUF_SIZE];
-	int data_start;
-	int data_length;
-
-	gboolean cli_active;
-	gboolean cme_enabled;
-	gboolean cwa_enabled;
-	gboolean pending_ring;
-	gboolean inband_ring;
-	gboolean nrec;
-	gboolean nrec_req;
-
-	int sp_gain;
-	int mic_gain;
-
-	unsigned int hf_features;
-};
-
 struct headset {
 	uint32_t hsp_handle;
 	uint32_t hfp_handle;
@@ -173,15 +131,9 @@ struct headset {
 	struct pending_connect *pending;
 
 	headset_lock_t lock;
-	struct headset_slc *slc;
 	GSList *nrec_cbs;
 };
 
-struct event {
-	const char *cmd;
-	int (*callback) (struct audio_device *device, const char *buf);
-};
-
 static GSList *headset_callbacks = NULL;
 
 static void error_connect_failed(DBusConnection *conn, DBusMessage *msg,
@@ -197,78 +149,6 @@ static int rfcomm_connect(struct audio_device *device, headset_stream_cb_t cb,
 static int get_records(struct audio_device *device, headset_stream_cb_t cb,
 			void *user_data, unsigned int *cb_id);
 
-static void print_ag_features(uint32_t features)
-{
-	GString *gstr;
-	char *str;
-
-	if (features == 0) {
-		DBG("HFP AG features: (none)");
-		return;
-	}
-
-	gstr = g_string_new("HFP AG features: ");
-
-	if (features & AG_FEATURE_THREE_WAY_CALLING)
-		g_string_append(gstr, "\"Three-way calling\" ");
-	if (features & AG_FEATURE_EC_ANDOR_NR)
-		g_string_append(gstr, "\"EC and/or NR function\" ");
-	if (features & AG_FEATURE_VOICE_RECOGNITION)
-		g_string_append(gstr, "\"Voice recognition function\" ");
-	if (features & AG_FEATURE_INBAND_RINGTONE)
-		g_string_append(gstr, "\"In-band ring tone capability\" ");
-	if (features & AG_FEATURE_ATTACH_NUMBER_TO_VOICETAG)
-		g_string_append(gstr, "\"Attach a number to a voice tag\" ");
-	if (features & AG_FEATURE_REJECT_A_CALL)
-		g_string_append(gstr, "\"Ability to reject a call\" ");
-	if (features & AG_FEATURE_ENHANCED_CALL_STATUS)
-		g_string_append(gstr, "\"Enhanced call status\" ");
-	if (features & AG_FEATURE_ENHANCED_CALL_CONTROL)
-		g_string_append(gstr, "\"Enhanced call control\" ");
-	if (features & AG_FEATURE_EXTENDED_ERROR_RESULT_CODES)
-		g_string_append(gstr, "\"Extended Error Result Codes\" ");
-
-	str = g_string_free(gstr, FALSE);
-
-	DBG("%s", str);
-
-	g_free(str);
-}
-
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
@@ -286,143 +166,6 @@ static const char *state2str(headset_state_t state)
 	return NULL;
 }
 
-static int headset_send_valist(struct headset *hs, char *format, va_list ap)
-{
-	char rsp[BUF_SIZE];
-	ssize_t total_written, count;
-	int fd;
-
-	count = vsnprintf(rsp, sizeof(rsp), format, ap);
-
-	if (count < 0)
-		return -EINVAL;
-
-	if (!hs->rfcomm) {
-		error("headset_send: the headset is not connected");
-		return -EIO;
-	}
-
-	total_written = 0;
-	fd = g_io_channel_unix_get_fd(hs->rfcomm);
-
-	while (total_written < count) {
-		ssize_t written;
-
-		written = write(fd, rsp + total_written,
-				count - total_written);
-		if (written < 0)
-			return -errno;
-
-		total_written += written;
-	}
-
-	return 0;
-}
-
-static int __attribute__((format(printf, 2, 3)))
-			headset_send(struct headset *hs, char *format, ...)
-{
-	va_list ap;
-	int ret;
-
-	va_start(ap, format);
-	ret = headset_send_valist(hs, format, ap);
-	va_end(ap);
-
-	return ret;
-}
-
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
@@ -503,64 +246,11 @@ static unsigned int connect_cb_new(struct headset *hs,
 	return cb->id;
 }
 
-static void __attribute__((format(printf, 3, 4)))
-		send_foreach_headset(GSList *devices,
-					int (*cmp) (struct headset *hs),
-					char *format, ...)
-{
-	GSList *l;
-	va_list ap;
-
-	for (l = devices; l != NULL; l = l->next) {
-		struct audio_device *device = l->data;
-		struct headset *hs = device->headset;
-		int ret;
-
-		assert(hs != NULL);
-
-		if (cmp && cmp(hs) != 0)
-			continue;
-
-		va_start(ap, format);
-		ret = headset_send_valist(hs, format, ap);
-		if (ret < 0)
-			error("Failed to send to headset: %s (%d)",
-					strerror(-ret), -ret);
-		va_end(ap);
-	}
-}
-
-static int cli_cmp(struct headset *hs)
-{
-	struct headset_slc *slc = hs->slc;
-
-	if (!hs->hfp_active)
-		return -1;
-
-	if (slc->cli_active)
-		return 0;
-	else
-		return -1;
-}
-
-static gboolean ring_timer_cb(gpointer data)
-{
-	send_foreach_headset(active_devices, NULL, "\r\nRING\r\n");
-
-	if (ag.number)
-		send_foreach_headset(active_devices, cli_cmp,
-					"\r\n+CLIP: \"%s\",%d\r\n",
-					ag.number, ag.number_type);
-
-	return TRUE;
-}
-
 static void sco_connect_cb(GIOChannel *chan, GError *err, gpointer user_data)
 {
 	int sk;
 	struct audio_device *dev = user_data;
 	struct headset *hs = dev->headset;
-	struct headset_slc *slc = hs->slc;
 	struct pending_connect *p = hs->pending;
 
 	if (err) {
@@ -601,14 +291,6 @@ static void sco_connect_cb(GIOChannel *chan, GError *err, gpointer user_data)
 	fcntl(sk, F_SETFL, 0);
 
 	headset_set_state(dev, HEADSET_STATE_PLAYING);
-
-	if (slc->pending_ring) {
-		ring_timer_cb(NULL);
-		ag.ring_timer = g_timeout_add_seconds(RING_INTERVAL,
-						ring_timer_cb,
-						NULL);
-		slc->pending_ring = FALSE;
-	}
 }
 
 static int sco_connect(struct audio_device *dev, headset_stream_cb_t cb,
@@ -647,14 +329,6 @@ static int sco_connect(struct audio_device *dev, headset_stream_cb_t cb,
 	return 0;
 }
 
-static int hfp_cmp(struct headset *hs)
-{
-	if (hs->hfp_active)
-		return 0;
-	else
-		return -1;
-}
-
 static void hfp_slc_complete(struct audio_device *dev)
 {
 	struct headset *hs = dev->headset;
@@ -684,569 +358,6 @@ static void hfp_slc_complete(struct audio_device *dev)
 	}
 }
 
-static int telephony_generic_rsp(struct audio_device *device, cme_error_t err)
-{
-	struct headset *hs = device->headset;
-	struct headset_slc *slc = hs->slc;
-
-	if ((err != CME_ERROR_NONE) && slc->cme_enabled)
-		return headset_send(hs, "\r\n+CME ERROR: %d\r\n", err);
-
-	switch (err) {
-	case CME_ERROR_NONE:
-		return headset_send(hs, "\r\nOK\r\n");
-	case CME_ERROR_NO_NETWORK_SERVICE:
-		return headset_send(hs, "\r\nNO CARRIER\r\n");
-	default:
-		return headset_send(hs, "\r\nERROR\r\n");
-	}
-}
-
-int telephony_event_reporting_rsp(void *telephony_device, cme_error_t err)
-{
-	struct audio_device *device = telephony_device;
-	struct headset *hs = device->headset;
-	struct headset_slc *slc = hs->slc;
-	int ret;
-
-	if (err != CME_ERROR_NONE)
-		return telephony_generic_rsp(telephony_device, err);
-
-	ret = headset_send(hs, "\r\nOK\r\n");
-	if (ret < 0)
-		return ret;
-
-	if (hs->state != HEADSET_STATE_CONNECTING)
-		return 0;
-
-	if (slc->hf_features & HF_FEATURE_CALL_WAITING_AND_3WAY &&
-			ag.features & AG_FEATURE_THREE_WAY_CALLING)
-		return 0;
-
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
-
-	return 0;
-}
-
-int telephony_key_press_rsp(void *telephony_device, cme_error_t err)
-{
-	return telephony_generic_rsp(telephony_device, err);
-}
-
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
-int telephony_answer_call_rsp(void *telephony_device, cme_error_t err)
-{
-	return telephony_generic_rsp(telephony_device, err);
-}
-
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
-int telephony_terminate_call_rsp(void *telephony_device,
-					cme_error_t err)
-{
-	struct audio_device *device = telephony_device;
-	struct headset *hs = device->headset;
-
-	if (err != CME_ERROR_NONE)
-		return telephony_generic_rsp(telephony_device, err);
-
-	g_dbus_emit_signal(device->conn, device->path,
-			AUDIO_HEADSET_INTERFACE, "CallTerminated",
-			DBUS_TYPE_INVALID);
-
-	return headset_send(hs, "\r\nOK\r\n");
-}
-
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
-int telephony_response_and_hold_rsp(void *telephony_device, cme_error_t err)
-{
-	return telephony_generic_rsp(telephony_device, err);
-}
-
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
-int telephony_last_dialed_number_rsp(void *telephony_device, cme_error_t err)
-{
-	return telephony_generic_rsp(telephony_device, err);
-}
-
-static int last_dialed_number(struct audio_device *device, const char *buf)
-{
-	telephony_last_dialed_number_req(device);
-
-	return 0;
-}
-
-int telephony_dial_number_rsp(void *telephony_device, cme_error_t err)
-{
-	return telephony_generic_rsp(telephony_device, err);
-}
-
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
-static int headset_set_gain(struct audio_device *device, uint16_t gain, char type)
-{
-	struct headset *hs = device->headset;
-	struct headset_slc *slc = hs->slc;
-	const char *name, *property;
-
-	if (gain > 15) {
-		error("Invalid gain value: %u", gain);
-		return -EINVAL;
-	}
-
-	switch (type) {
-	case HEADSET_GAIN_SPEAKER:
-		if (slc->sp_gain == gain) {
-			DBG("Ignoring no-change in speaker gain");
-			return -EALREADY;
-		}
-		name = "SpeakerGainChanged";
-		property = "SpeakerGain";
-		slc->sp_gain = gain;
-		break;
-	case HEADSET_GAIN_MICROPHONE:
-		if (slc->mic_gain == gain) {
-			DBG("Ignoring no-change in microphone gain");
-			return -EALREADY;
-		}
-		name = "MicrophoneGainChanged";
-		property = "MicrophoneGain";
-		slc->mic_gain = gain;
-		break;
-	default:
-		error("Unknown gain setting");
-		return -EINVAL;
-	}
-
-	g_dbus_emit_signal(device->conn, device->path,
-				AUDIO_HEADSET_INTERFACE, name,
-				DBUS_TYPE_UINT16, &gain,
-				DBUS_TYPE_INVALID);
-
-	emit_property_changed(device->conn, device->path,
-				AUDIO_HEADSET_INTERFACE, property,
-				DBUS_TYPE_UINT16, &gain);
-
-	return 0;
-}
-
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
-int telephony_transmit_dtmf_rsp(void *telephony_device, cme_error_t err)
-{
-	return telephony_generic_rsp(telephony_device, err);
-}
-
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
-int telephony_subscriber_number_rsp(void *telephony_device, cme_error_t err)
-{
-	return telephony_generic_rsp(telephony_device, err);
-}
-
-static int subscriber_number(struct audio_device *device, const char *buf)
-{
-	telephony_subscriber_number_req(device);
-
-	return 0;
-}
-
-int telephony_list_current_calls_rsp(void *telephony_device, cme_error_t err)
-{
-	return telephony_generic_rsp(telephony_device, err);
-}
-
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
-int telephony_operator_selection_rsp(void *telephony_device, cme_error_t err)
-{
-	return telephony_generic_rsp(telephony_device, err);
-}
-
-int telephony_call_hold_rsp(void *telephony_device, cme_error_t err)
-{
-	return telephony_generic_rsp(telephony_device, err);
-}
-
-int telephony_nr_and_ec_rsp(void *telephony_device, cme_error_t err)
-{
-	struct audio_device *device = telephony_device;
-	struct headset *hs = device->headset;
-	struct headset_slc *slc = hs->slc;
-
-	if (err == CME_ERROR_NONE) {
-		GSList *l;
-
-		for (l = hs->nrec_cbs; l; l = l->next) {
-			struct headset_nrec_callback *nrec_cb = l->data;
-
-			nrec_cb->cb(device, slc->nrec_req, nrec_cb->user_data);
-		}
-
-		slc->nrec = hs->slc->nrec_req;
-	}
-
-	return telephony_generic_rsp(telephony_device, err);
-}
-
-int telephony_voice_dial_rsp(void *telephony_device, cme_error_t err)
-{
-	return telephony_generic_rsp(telephony_device, err);
-}
-
-int telephony_operator_selection_ind(int mode, const char *oper)
-{
-	if (!active_devices)
-		return -ENODEV;
-
-	send_foreach_headset(active_devices, hfp_cmp,
-				"\r\n+COPS: %d,0,\"%s\"\r\n",
-				mode, oper);
-	return 0;
-}
-
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
@@ -1254,104 +365,15 @@ static void close_sco(struct audio_device *device)
 	if (hs->sco) {
 		int sock = g_io_channel_unix_get_fd(hs->sco);
 		shutdown(sock, SHUT_RDWR);
-		g_io_channel_shutdown(hs->sco, TRUE, NULL);
-		g_io_channel_unref(hs->sco);
-		hs->sco = NULL;
-	}
-
-	if (hs->sco_id) {
-		g_source_remove(hs->sco_id);
-		hs->sco_id = 0;
-	}
-}
-
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
+		g_io_channel_shutdown(hs->sco, TRUE, NULL);
+		g_io_channel_unref(hs->sco);
+		hs->sco = NULL;
 	}
 
-	return TRUE;
-
-failed:
-	headset_set_state(device, HEADSET_STATE_DISCONNECTED);
-
-	return FALSE;
+	if (hs->sco_id) {
+		g_source_remove(hs->sco_id);
+		hs->sco_id = 0;
+	}
 }
 
 static gboolean sco_cb(GIOChannel *chan, GIOCondition cond,
@@ -1387,6 +409,8 @@ void headset_connect_cb(GIOChannel *chan, GError *err, gpointer user_data)
 		goto failed;
 	}
 
+	hfp_slc_complete(dev);
+
 	hs->rfcomm = hs->tmp_rfcomm;
 	hs->tmp_rfcomm = NULL;
 
@@ -1397,46 +421,16 @@ void headset_connect_cb(GIOChannel *chan, GError *err, gpointer user_data)
 	else
 		hs->auto_dc = FALSE;
 
-	g_io_add_watch(chan, G_IO_IN | G_IO_ERR | G_IO_HUP| G_IO_NVAL,
-			(GIOFunc) rfcomm_io_cb, dev);
-
 	DBG("%s: Connected to %s", dev->path, hs_address);
 
-	hs->slc = g_new0(struct headset_slc, 1);
-	hs->slc->sp_gain = 15;
-	hs->slc->mic_gain = 15;
-	hs->slc->nrec = TRUE;
-
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
-	if (hs->rfcomm)
-		headset_set_state(dev, HEADSET_STATE_CONNECTED);
-	else
-		headset_set_state(dev, HEADSET_STATE_DISCONNECTED);
+
+	headset_set_state(dev, HEADSET_STATE_DISCONNECTED);
 }
 
 static int headset_set_channel(struct headset *headset,
@@ -1691,26 +685,6 @@ static DBusMessage *hs_disconnect(DBusConnection *conn, DBusMessage *msg,
 
 }
 
-static DBusMessage *hs_is_connected(DBusConnection *conn,
-						DBusMessage *msg,
-						void *data)
-{
-	struct audio_device *device = data;
-	DBusMessage *reply;
-	dbus_bool_t connected;
-
-	reply = dbus_message_new_method_return(msg);
-	if (!reply)
-		return NULL;
-
-	connected = (device->headset->state >= HEADSET_STATE_CONNECTED);
-
-	dbus_message_append_args(reply, DBUS_TYPE_BOOLEAN, &connected,
-					DBUS_TYPE_INVALID);
-
-	return reply;
-}
-
 static DBusMessage *hs_connect(DBusConnection *conn, DBusMessage *msg,
 					void *data)
 {
@@ -1739,95 +713,6 @@ static DBusMessage *hs_connect(DBusConnection *conn, DBusMessage *msg,
 	return NULL;
 }
 
-static DBusMessage *hs_ring(DBusConnection *conn, DBusMessage *msg,
-					void *data)
-{
-	struct audio_device *device = data;
-	struct headset *hs = device->headset;
-	DBusMessage *reply = NULL;
-	int err;
-
-	if (hs->state < HEADSET_STATE_CONNECTED)
-		return btd_error_not_connected(msg);
-
-	reply = dbus_message_new_method_return(msg);
-	if (!reply)
-		return NULL;
-
-	if (ag.ring_timer) {
-		DBG("IndicateCall received when already indicating");
-		return reply;
-	}
-
-	err = headset_send(hs, "\r\nRING\r\n");
-	if (err < 0) {
-		dbus_message_unref(reply);
-		return btd_error_failed(msg, strerror(-err));
-	}
-
-	ring_timer_cb(NULL);
-	ag.ring_timer = g_timeout_add_seconds(RING_INTERVAL, ring_timer_cb,
-						NULL);
-
-	return reply;
-}
-
-static DBusMessage *hs_cancel_call(DBusConnection *conn,
-					DBusMessage *msg,
-					void *data)
-{
-	struct audio_device *device = data;
-	struct headset *hs = device->headset;
-	DBusMessage *reply = NULL;
-
-	if (hs->state < HEADSET_STATE_CONNECTED)
-		return btd_error_not_connected(msg);
-
-	reply = dbus_message_new_method_return(msg);
-	if (!reply)
-		return NULL;
-
-	if (ag.ring_timer) {
-		g_source_remove(ag.ring_timer);
-		ag.ring_timer = 0;
-	} else
-		DBG("Got CancelCall method call but no call is active");
-
-	return reply;
-}
-
-static DBusMessage *hs_set_gain(DBusConnection *conn,
-				DBusMessage *msg,
-				void *data, uint16_t gain,
-				char type)
-{
-	struct audio_device *device = data;
-	struct headset *hs = device->headset;
-	DBusMessage *reply;
-	int err;
-
-	if (hs->state < HEADSET_STATE_CONNECTED)
-		return btd_error_not_connected(msg);
-
-	err = headset_set_gain(device, gain, type);
-	if (err < 0)
-		return btd_error_invalid_args(msg);
-
-	reply = dbus_message_new_method_return(msg);
-	if (!reply)
-		return NULL;
-
-	if (hs->state == HEADSET_STATE_PLAYING) {
-		err = headset_send(hs, "\r\n+VG%c=%u\r\n", type, gain);
-		if (err < 0) {
-			dbus_message_unref(reply);
-			return btd_error_failed(msg, strerror(-err));
-		}
-	}
-
-	return reply;
-}
-
 static DBusMessage *hs_get_properties(DBusConnection *conn,
 					DBusMessage *msg, void *data)
 {
@@ -1863,94 +748,22 @@ static DBusMessage *hs_get_properties(DBusConnection *conn,
 	value = (device->headset->state >= HEADSET_STATE_CONNECTED);
 	dict_append_entry(&dict, "Connected", DBUS_TYPE_BOOLEAN, &value);
 
-	if (!value)
-		goto done;
-
-	/* SpeakerGain */
-	dict_append_entry(&dict, "SpeakerGain",
-				DBUS_TYPE_UINT16,
-				&device->headset->slc->sp_gain);
-
-	/* MicrophoneGain */
-	dict_append_entry(&dict, "MicrophoneGain",
-				DBUS_TYPE_UINT16,
-				&device->headset->slc->mic_gain);
-
-done:
 	dbus_message_iter_close_container(&iter, &dict);
 
 	return reply;
 }
 
-static DBusMessage *hs_set_property(DBusConnection *conn,
-					DBusMessage *msg, void *data)
-{
-	const char *property;
-	DBusMessageIter iter;
-	DBusMessageIter sub;
-	uint16_t gain;
-
-	if (!dbus_message_iter_init(msg, &iter))
-		return btd_error_invalid_args(msg);
-
-	if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_STRING)
-		return btd_error_invalid_args(msg);
-
-	dbus_message_iter_get_basic(&iter, &property);
-	dbus_message_iter_next(&iter);
-
-	if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_VARIANT)
-		return btd_error_invalid_args(msg);
-	dbus_message_iter_recurse(&iter, &sub);
-
-	if (g_str_equal("SpeakerGain", property)) {
-		if (dbus_message_iter_get_arg_type(&sub) != DBUS_TYPE_UINT16)
-			return btd_error_invalid_args(msg);
-
-		dbus_message_iter_get_basic(&sub, &gain);
-		return hs_set_gain(conn, msg, data, gain,
-					HEADSET_GAIN_SPEAKER);
-	} else if (g_str_equal("MicrophoneGain", property)) {
-		if (dbus_message_iter_get_arg_type(&sub) != DBUS_TYPE_UINT16)
-			return btd_error_invalid_args(msg);
-
-		dbus_message_iter_get_basic(&sub, &gain);
-		return hs_set_gain(conn, msg, data, gain,
-					HEADSET_GAIN_MICROPHONE);
-	}
-
-	return btd_error_invalid_args(msg);
-}
-
 static const GDBusMethodTable headset_methods[] = {
 	{ GDBUS_ASYNC_METHOD("Connect", NULL, NULL, hs_connect) },
 	{ GDBUS_METHOD("Disconnect", NULL, NULL, hs_disconnect) },
-	{ GDBUS_METHOD("IsConnected",
-			NULL, GDBUS_ARGS({ "connected", "b" }),
-			hs_is_connected) },
-	{ GDBUS_METHOD("IndicateCall", NULL, NULL, hs_ring) },
-	{ GDBUS_METHOD("CancelCall", NULL, NULL, hs_cancel_call) },
 	{ GDBUS_METHOD("Stop", NULL, NULL, hs_stop) },
 	{ GDBUS_METHOD("GetProperties",
 			NULL, GDBUS_ARGS({ "properties", "a{sv}" }),
 			hs_get_properties) },
-	{ GDBUS_METHOD("SetProperty",
-			GDBUS_ARGS({ "name", "s" }, { "value", "v" }), NULL,
-			hs_set_property) },
 	{ }
 };
 
 static const GDBusSignalTable headset_signals[] = {
-	{ GDBUS_DEPRECATED_SIGNAL("Connected", NULL) },
-	{ GDBUS_DEPRECATED_SIGNAL("Disconnected", NULL) },
-	{ GDBUS_SIGNAL("AnswerRequested", NULL) },
-	{ GDBUS_DEPRECATED_SIGNAL("Stopped", NULL) },
-	{ GDBUS_DEPRECATED_SIGNAL("Playing", NULL) },
-	{ GDBUS_DEPRECATED_SIGNAL("SpeakerGainChanged",
-						GDBUS_ARGS({ "gain", "q" })) },
-	{ GDBUS_DEPRECATED_SIGNAL("MicrophoneGainChanged",
-						GDBUS_ARGS({ "gain", "q" })) },
-	{ GDBUS_SIGNAL("CallTerminated", NULL) },
 	{ GDBUS_SIGNAL("PropertyChanged",
 			GDBUS_ARGS({ "name", "s" }, { "value", "v" })) },
 	{ }
@@ -2010,9 +823,6 @@ static int headset_close_rfcomm(struct audio_device *dev)
 		hs->rfcomm = NULL;
 	}
 
-	g_free(hs->slc);
-	hs->slc = NULL;
-
 	return 0;
 }
 
@@ -2125,19 +935,6 @@ uint32_t headset_config_init(GKeyFile *config)
 		g_free(str);
 	}
 
-	/* Init fast connectable option */
-	str = g_key_file_get_string(config, "Headset", "FastConnectable",
-					&err);
-	if (err) {
-		DBG("audio.conf: %s", err->message);
-		g_clear_error(&err);
-	} else {
-		fast_connectable = strcmp(str, "true") == 0;
-		if (fast_connectable)
-			manager_set_fast_connectable(FALSE);
-		g_free(str);
-	}
-
 	return ag.features;
 }
 
@@ -2345,29 +1142,18 @@ int headset_connect_rfcomm(struct audio_device *dev, GIOChannel *io)
 int headset_connect_sco(struct audio_device *dev, GIOChannel *io)
 {
 	struct headset *hs = dev->headset;
-	struct headset_slc *slc = hs->slc;
 
 	if (hs->sco)
 		return -EISCONN;
 
 	hs->sco = g_io_channel_ref(io);
 
-	if (slc->pending_ring) {
-		ring_timer_cb(NULL);
-		ag.ring_timer = g_timeout_add_seconds(RING_INTERVAL,
-						ring_timer_cb,
-						NULL);
-		slc->pending_ring = FALSE;
-	}
-
 	return 0;
 }
 
 void headset_set_state(struct audio_device *dev, headset_state_t state)
 {
 	struct headset *hs = dev->headset;
-	struct headset_slc *slc = hs->slc;
-	gboolean value;
 	const char *state_str;
 	headset_state_t old_state = hs->state;
 	GSList *l;
@@ -2379,23 +1165,11 @@ void headset_set_state(struct audio_device *dev, headset_state_t state)
 
 	switch (state) {
 	case HEADSET_STATE_DISCONNECTED:
-		value = FALSE;
 		close_sco(dev);
 		headset_close_rfcomm(dev);
 		emit_property_changed(dev->conn, dev->path,
 					AUDIO_HEADSET_INTERFACE, "State",
 					DBUS_TYPE_STRING, &state_str);
-		g_dbus_emit_signal(dev->conn, dev->path,
-					AUDIO_HEADSET_INTERFACE,
-					"Disconnected",
-					DBUS_TYPE_INVALID);
-		if (hs->state > HEADSET_STATE_CONNECTING) {
-			emit_property_changed(dev->conn, dev->path,
-					AUDIO_HEADSET_INTERFACE, "Connected",
-					DBUS_TYPE_BOOLEAN, &value);
-			telephony_device_disconnected(dev);
-		}
-		active_devices = g_slist_remove(active_devices, dev);
 		break;
 	case HEADSET_STATE_CONNECTING:
 		emit_property_changed(dev->conn, dev->path,
@@ -2408,38 +1182,10 @@ void headset_set_state(struct audio_device *dev, headset_state_t state)
 			emit_property_changed(dev->conn, dev->path,
 					AUDIO_HEADSET_INTERFACE, "State",
 					DBUS_TYPE_STRING, &state_str);
-		if (hs->state < state) {
-			if (ag.features & AG_FEATURE_INBAND_RINGTONE)
-				slc->inband_ring = TRUE;
-			else
-				slc->inband_ring = FALSE;
-			g_dbus_emit_signal(dev->conn, dev->path,
-						AUDIO_HEADSET_INTERFACE,
-						"Connected",
-						DBUS_TYPE_INVALID);
-			value = TRUE;
-			emit_property_changed(dev->conn, dev->path,
-						AUDIO_HEADSET_INTERFACE,
-						"Connected",
-						DBUS_TYPE_BOOLEAN, &value);
-			active_devices = g_slist_append(active_devices, dev);
-			telephony_device_connected(dev);
-		} else if (hs->state == HEADSET_STATE_PLAYING) {
-			value = FALSE;
-			g_dbus_emit_signal(dev->conn, dev->path,
-						AUDIO_HEADSET_INTERFACE,
-						"Stopped",
-						DBUS_TYPE_INVALID);
-			emit_property_changed(dev->conn, dev->path,
-						AUDIO_HEADSET_INTERFACE,
-						"Playing",
-						DBUS_TYPE_BOOLEAN, &value);
-		}
 		break;
 	case HEADSET_STATE_PLAY_IN_PROGRESS:
 		break;
 	case HEADSET_STATE_PLAYING:
-		value = TRUE;
 		emit_property_changed(dev->conn, dev->path,
 					AUDIO_HEADSET_INTERFACE, "State",
 					DBUS_TYPE_STRING, &state_str);
@@ -2449,18 +1195,6 @@ void headset_set_state(struct audio_device *dev, headset_state_t state)
 		hs->sco_id = g_io_add_watch(hs->sco,
 					G_IO_ERR | G_IO_NVAL,
 					(GIOFunc) sco_cb, dev);
-
-		g_dbus_emit_signal(dev->conn, dev->path,
-					AUDIO_HEADSET_INTERFACE, "Playing",
-					DBUS_TYPE_INVALID);
-		emit_property_changed(dev->conn, dev->path,
-					AUDIO_HEADSET_INTERFACE, "Playing",
-					DBUS_TYPE_BOOLEAN, &value);
-
-		if (slc->sp_gain >= 0)
-			headset_send(hs, "\r\n+VGS=%u\r\n", slc->sp_gain);
-		if (slc->mic_gain >= 0)
-			headset_send(hs, "\r\n+VGM=%u\r\n", slc->mic_gain);
 		break;
 	}
 
@@ -2567,12 +1301,7 @@ int headset_get_sco_fd(struct audio_device *dev)
 
 gboolean headset_get_nrec(struct audio_device *dev)
 {
-	struct headset *hs = dev->headset;
-
-	if (!hs->slc)
-		return TRUE;
-
-	return hs->slc->nrec;
+	return TRUE;
 }
 
 unsigned int headset_add_nrec_cb(struct audio_device *dev,
@@ -2611,12 +1340,7 @@ gboolean headset_remove_nrec_cb(struct audio_device *dev, unsigned int id)
 
 gboolean headset_get_inband(struct audio_device *dev)
 {
-	struct headset *hs = dev->headset;
-
-	if (!hs->slc)
-		return TRUE;
-
-	return hs->slc->inband_ring;
+	return TRUE;
 }
 
 gboolean headset_get_sco_hci(struct audio_device *dev)
@@ -2635,195 +1359,6 @@ void headset_shutdown(struct audio_device *dev)
 	headset_set_state(dev, HEADSET_STATE_DISCONNECTED);
 }
 
-int telephony_event_ind(int index)
-{
-	if (!active_devices)
-		return -ENODEV;
-
-	if (!ag.er_ind) {
-		DBG("telephony_report_event called but events are disabled");
-		return -EINVAL;
-	}
-
-	send_foreach_headset(active_devices, hfp_cmp,
-				"\r\n+CIEV: %d,%d\r\n", index + 1,
-				ag.indicators[index].val);
-
-	return 0;
-}
-
-int telephony_response_and_hold_ind(int rh)
-{
-	if (!active_devices)
-		return -ENODEV;
-
-	ag.rh = rh;
-
-	/* If we aren't in any response and hold state don't send anything */
-	if (ag.rh < 0)
-		return 0;
-
-	send_foreach_headset(active_devices, hfp_cmp, "\r\n+BTRH: %d\r\n",
-				ag.rh);
-
-	return 0;
-}
-
-int telephony_incoming_call_ind(const char *number, int type)
-{
-	struct audio_device *dev;
-	struct headset *hs;
-	struct headset_slc *slc;
-
-	if (fast_connectable)
-		manager_set_fast_connectable(TRUE);
-
-	if (!active_devices)
-		return -ENODEV;
-
-	/* Get the latest connected device */
-	dev = active_devices->data;
-	hs = dev->headset;
-	slc = hs->slc;
-
-	if (ag.ring_timer) {
-		DBG("telephony_incoming_call_ind: already calling");
-		return -EBUSY;
-	}
-
-	/* With HSP 1.2 the RING messages should *not* be sent if inband
-	 * ringtone is being used */
-	if (!hs->hfp_active && slc->inband_ring)
-		return 0;
-
-	g_free(ag.number);
-	ag.number = g_strdup(number);
-	ag.number_type = type;
-
-	if (slc->inband_ring && hs->hfp_active &&
-					hs->state != HEADSET_STATE_PLAYING) {
-		slc->pending_ring = TRUE;
-		return 0;
-	}
-
-	ring_timer_cb(NULL);
-	ag.ring_timer = g_timeout_add_seconds(RING_INTERVAL, ring_timer_cb,
-						NULL);
-
-	return 0;
-}
-
-int telephony_calling_stopped_ind(void)
-{
-	struct audio_device *dev;
-
-	if (fast_connectable)
-		manager_set_fast_connectable(FALSE);
-
-	if (ag.ring_timer) {
-		g_source_remove(ag.ring_timer);
-		ag.ring_timer = 0;
-	}
-
-	if (!active_devices)
-		return 0;
-
-	/* In case SCO isn't fully up yet */
-	dev = active_devices->data;
-
-	if (!dev->headset->slc->pending_ring && !ag.ring_timer)
-		return -EINVAL;
-
-	dev->headset->slc->pending_ring = FALSE;
-
-	return 0;
-}
-
-int telephony_ready_ind(uint32_t features,
-			const struct indicator *indicators, int rh,
-			const char *chld)
-{
-	ag.telephony_ready = TRUE;
-	ag.features = features;
-	ag.indicators = indicators;
-	ag.rh = rh;
-	ag.chld = chld;
-
-	DBG("Telephony plugin initialized");
-
-	print_ag_features(ag.features);
-
-	return 0;
-}
-
-int telephony_deinit(void)
-{
-	g_free(ag.number);
-
-	memset(&ag, 0, sizeof(ag));
-
-	ag.er_mode = 3;
-	ag.rh = BTRH_NOT_SUPPORTED;
-
-	DBG("Telephony deinitialized");
-
-	return 0;
-}
-
-int telephony_list_current_call_ind(int idx, int dir, int status, int mode,
-					int mprty, const char *number,
-					int type)
-{
-	if (!active_devices)
-		return -ENODEV;
-
-	if (number && strlen(number) > 0)
-		send_foreach_headset(active_devices, hfp_cmp,
-				"\r\n+CLCC: %d,%d,%d,%d,%d,\"%s\",%d\r\n",
-				idx, dir, status, mode, mprty, number, type);
-	else
-		send_foreach_headset(active_devices, hfp_cmp,
-					"\r\n+CLCC: %d,%d,%d,%d,%d\r\n",
-					idx, dir, status, mode, mprty);
-
-	return 0;
-}
-
-int telephony_subscriber_number_ind(const char *number, int type, int service)
-{
-	if (!active_devices)
-		return -ENODEV;
-
-	send_foreach_headset(active_devices, hfp_cmp,
-				"\r\n+CNUM: ,%s,%d,,%d\r\n",
-				number, type, service);
-
-	return 0;
-}
-
-static int cwa_cmp(struct headset *hs)
-{
-	if (!hs->hfp_active)
-		return -1;
-
-	if (hs->slc->cwa_enabled)
-		return 0;
-	else
-		return -1;
-}
-
-int telephony_call_waiting_ind(const char *number, int type)
-{
-	if (!active_devices)
-		return -ENODEV;
-
-	send_foreach_headset(active_devices, cwa_cmp,
-				"\r\n+CCWA: \"%s\",%d\r\n",
-				number, type);
-
-	return 0;
-}
-
 unsigned int headset_add_state_cb(headset_state_cb cb, void *user_data)
 {
 	struct headset_state_callback *state_cb;
@@ -2854,3 +1389,15 @@ gboolean headset_remove_state_cb(unsigned int id)
 
 	return FALSE;
 }
+
+int telephony_init(void)
+{
+	DBG("");
+
+	return 0;
+}
+
+void telephony_exit(void)
+{
+	DBG("");
+}
diff --git a/audio/telephony.h b/audio/telephony.h
index 73b390c..e9cd2fc 100644
--- a/audio/telephony.h
+++ b/audio/telephony.h
@@ -26,13 +26,6 @@
 #include <errno.h>
 #include <glib.h>
 
-/* Response and hold values */
-#define BTRH_NOT_SUPPORTED	-2
-#define BTRH_NONE		-1
-#define BTRH_HOLD		0
-#define BTRH_ACCEPT		1
-#define BTRH_REJECT		2
-
 /* HFP feature bits */
 #define AG_FEATURE_THREE_WAY_CALLING		0x0001
 #define AG_FEATURE_EC_ANDOR_NR			0x0002
@@ -52,193 +45,8 @@
 #define HF_FEATURE_ENHANCED_CALL_STATUS		0x0020
 #define HF_FEATURE_ENHANCED_CALL_CONTROL	0x0040
 
-/* Indicator event values */
-#define EV_SERVICE_NONE			0
-#define EV_SERVICE_PRESENT		1
-
-#define EV_CALL_INACTIVE		0
-#define EV_CALL_ACTIVE			1
-
-#define EV_CALLSETUP_INACTIVE		0
-#define EV_CALLSETUP_INCOMING		1
-#define EV_CALLSETUP_OUTGOING		2
-#define EV_CALLSETUP_ALERTING		3
-
-#define EV_CALLHELD_NONE		0
-#define EV_CALLHELD_MULTIPLE		1
-#define EV_CALLHELD_ON_HOLD		2
-
-#define EV_ROAM_INACTIVE		0
-#define EV_ROAM_ACTIVE			1
-
-/* Call parameters */
-#define CALL_DIR_OUTGOING		0
-#define CALL_DIR_INCOMING		1
-
-#define CALL_STATUS_ACTIVE		0
-#define CALL_STATUS_HELD		1
-#define CALL_STATUS_DIALING		2
-#define CALL_STATUS_ALERTING		3
-#define CALL_STATUS_INCOMING		4
-#define CALL_STATUS_WAITING		5
-
-#define CALL_MODE_VOICE			0
-#define CALL_MODE_DATA			1
-#define CALL_MODE_FAX			2
-
-#define CALL_MULTIPARTY_NO		0
-#define CALL_MULTIPARTY_YES		1
-
-/* Subscriber number parameters */
-#define SUBSCRIBER_SERVICE_VOICE	4
-#define SUBSCRIBER_SERVICE_FAX		5
-
-/* Operator selection mode values */
-#define OPERATOR_MODE_AUTO		0
-#define OPERATOR_MODE_MANUAL		1
-#define OPERATOR_MODE_DEREGISTER	2
-#define OPERATOR_MODE_MANUAL_AUTO	4
-
-/* Some common number types */
-#define NUMBER_TYPE_UNKNOWN		128
-#define NUMBER_TYPE_TELEPHONY		129
-#define NUMBER_TYPE_INTERNATIONAL	145
-#define NUMBER_TYPE_NATIONAL		161
-#define NUMBER_TYPE_VOIP		255
-
-/* Extended Audio Gateway Error Result Codes */
-typedef enum {
-	CME_ERROR_NONE			= -1,
-	CME_ERROR_AG_FAILURE		= 0,
-	CME_ERROR_NO_PHONE_CONNECTION	= 1,
-	CME_ERROR_NOT_ALLOWED		= 3,
-	CME_ERROR_NOT_SUPPORTED		= 4,
-	CME_ERROR_PH_SIM_PIN_REQUIRED	= 5,
-	CME_ERROR_SIM_NOT_INSERTED	= 10,
-	CME_ERROR_SIM_PIN_REQUIRED	= 11,
-	CME_ERROR_SIM_PUK_REQUIRED	= 12,
-	CME_ERROR_SIM_FAILURE		= 13,
-	CME_ERROR_SIM_BUSY		= 14,
-	CME_ERROR_INCORRECT_PASSWORD	= 16,
-	CME_ERROR_SIM_PIN2_REQUIRED	= 17,
-	CME_ERROR_SIM_PUK2_REQUIRED	= 18,
-	CME_ERROR_MEMORY_FULL		= 20,
-	CME_ERROR_INVALID_INDEX		= 21,
-	CME_ERROR_MEMORY_FAILURE	= 23,
-	CME_ERROR_TEXT_STRING_TOO_LONG	= 24,
-	CME_ERROR_INVALID_TEXT_STRING	= 25,
-	CME_ERROR_DIAL_STRING_TOO_LONG	= 26,
-	CME_ERROR_INVALID_DIAL_STRING	= 27,
-	CME_ERROR_NO_NETWORK_SERVICE	= 30,
-	CME_ERROR_NETWORK_TIMEOUT	= 31,
-	CME_ERROR_NETWORK_NOT_ALLOWED	= 32,
-} cme_error_t;
-
-struct indicator {
-	const char *desc;
-	const char *range;
-	int val;
-	gboolean ignore_redundant;
-};
-
-/* Notify telephony-*.c of connected/disconnected devices. Implemented by
- * telephony-*.c
- */
-void telephony_device_connected(void *telephony_device);
-void telephony_device_disconnected(void *telephony_device);
-
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
-
-/* AG responses to HF requests. These are implemented by headset.c */
-int telephony_event_reporting_rsp(void *telephony_device, cme_error_t err);
-int telephony_response_and_hold_rsp(void *telephony_device, cme_error_t err);
-int telephony_last_dialed_number_rsp(void *telephony_device, cme_error_t err);
-int telephony_terminate_call_rsp(void *telephony_device, cme_error_t err);
-int telephony_answer_call_rsp(void *telephony_device, cme_error_t err);
-int telephony_dial_number_rsp(void *telephony_device, cme_error_t err);
-int telephony_transmit_dtmf_rsp(void *telephony_device, cme_error_t err);
-int telephony_subscriber_number_rsp(void *telephony_device, cme_error_t err);
-int telephony_list_current_calls_rsp(void *telephony_device, cme_error_t err);
-int telephony_operator_selection_rsp(void *telephony_device, cme_error_t err);
-int telephony_call_hold_rsp(void *telephony_device, cme_error_t err);
-int telephony_nr_and_ec_rsp(void *telephony_device, cme_error_t err);
-int telephony_voice_dial_rsp(void *telephony_device, cme_error_t err);
-int telephony_key_press_rsp(void *telephony_device, cme_error_t err);
-
-/* Event indications by AG. These are implemented by headset.c */
-int telephony_event_ind(int index);
-int telephony_response_and_hold_ind(int rh);
-int telephony_incoming_call_ind(const char *number, int type);
-int telephony_calling_stopped_ind(void);
-int telephony_ready_ind(uint32_t features, const struct indicator *indicators,
-			int rh, const char *chld);
-int telephony_deinit(void);
-int telephony_list_current_call_ind(int idx, int dir, int status, int mode,
-					int mprty, const char *number,
-					int type);
-int telephony_subscriber_number_ind(const char *number, int type,
-					int service);
-int telephony_call_waiting_ind(const char *number, int type);
-int telephony_operator_selection_ind(int mode, const char *oper);
-
-/* Helper function for quick indicator updates */
-static inline int telephony_update_indicator(struct indicator *indicators,
-						const char *desc,
-						int new_val)
-{
-	int i;
-	struct indicator *ind = NULL;
-
-	for (i = 0; indicators[i].desc != NULL; i++) {
-		if (g_str_equal(indicators[i].desc, desc)) {
-			ind = &indicators[i];
-			break;
-		}
-	}
-
-	if (!ind)
-		return -ENOENT;
-
-	DBG("Telephony indicator \"%s\" %d->%d", desc, ind->val, new_val);
-
-	if (ind->ignore_redundant && ind->val == new_val) {
-		DBG("Ignoring no-change indication");
-		return 0;
-	}
-
-	ind->val = new_val;
-
-	return telephony_event_ind(i);
-}
-
-static inline int telephony_get_indicator(const struct indicator *indicators,
-						const char *desc)
-{
-	int i;
-
-	for (i = 0; indicators[i].desc != NULL; i++) {
-		if (g_str_equal(indicators[i].desc, desc))
-			return indicators[i].val;
-	}
-
-	return -ENOENT;
-}
+gboolean telephony_is_ready(struct btd_adapter *adapter);
+uint32_t telephony_get_ag_features(void);
 
 int telephony_init(void);
 void telephony_exit(void);
diff --git a/doc/audio-api.txt b/doc/audio-api.txt
index 7aa07a4..edcdfd8 100644
--- a/doc/audio-api.txt
+++ b/doc/audio-api.txt
@@ -66,20 +66,6 @@ Methods		void Connect()
 			Disconnect from the HSP/HFP service on the remote
 			device.
 
-		void IndicateCall()
-
-			Indicate an incoming call on the headset
-			connected to the stream. Will continue to
-			ring the headset about every 3 seconds.
-
-		void CancelCall()
-
-			Cancel the incoming call indication.
-
-		void Play() {deprecated}
-
-			Open the audio connection to the headset.
-
 		void Stop()
 
 			Close the audio connection.
@@ -91,44 +77,7 @@ Methods		void Connect()
 
 			Possible Errors: org.bluez.Error.InvalidArguments
 
-		void SetProperty(string name, variant value)
-
-			Changes the value of the specified property. Only
-			properties that are listed as read-write are changeable.
-			On success this will emit a PropertyChanged signal.
-
-			Possible Errors: org.bluez.Error.DoesNotExist
-					 org.bluez.Error.InvalidArguments
-
-Signals		void AnswerRequested()
-
-			Sent when the answer button is pressed on the headset
-
-		void Connected() {deprecated}
-
-			Sent when the device has been connected to.
-
-		void Disconnected() {deprecated}
-
-			Sent when the device has been disconnected from.
-
-		void Stopped() {deprecated}
-
-			Sent when the audio connection is closed
-
-		void Playing() {deprecated}
-
-			Sent when the audio connection is opened
-
-		void SpeakerGainChanged(uint16 gain) {deprecated}
-
-			The speaker gain changed.
-
-		void MicrophoneGainChanged(uint16 gain) {deprecated}
-
-			The microphone gain changed.
-
-		PropertyChanged(string name, variant value)
+Signals		PropertyChanged(string name, variant value)
 
 			This signal indicates a changed value of the given
 			property.
@@ -158,24 +107,6 @@ properties	string State [readonly]
 			"playing" -> "disconnected"
 				Disconnected from the remote device
 
-		boolean Connected [readonly]
-
-			Indicates if there is a active connection to the
-			HSP/HFP connection on the remote device.
-
-		boolean Playing  [readonly]
-
-			Indicates if an audio connection to the headset
-			is active.
-
-		uint16 SpeakerGain  [readwrite]
-
-			The speaker gain when available.
-
-		uint16 MicrophoneGain  [readwrite]
-
-			The speaker gain when available.
-
 
 AudioSink hierarchy
 ===================
@@ -329,100 +260,40 @@ Methods		void Connect()
 
 			Disconnect from the AG service on the remote device
 
-		void AnswerCall()
-
-			It has to called only after Ring signal received.
-
-		void TerminateCall()
-
-			Terminate call which is running or reject an incoming
-			call. This has nothing with any 3-way situation incl.
-			RaH. Just plain old PDH.
-
-		void Call(string number)
-
-			Dial a number 'number'. No number processing is done
-			thus if AG would reject to dial it don't blame me :)
-
-		string GetOperatorName()
-
-			Find out the name of the currently selected network
-			operator by AG.
-
-		void SendDTMF(string digits)
-
-			Will send each digit in the 'digits' sequentially. Would
-			send nothing if there is non-dtmf digit.
-
-		string GetSubscriberNumber()
-
-			Get the voicecall subscriber number of AG
-
 		dict GetProperties()
 
 			Returns all properties for the interface. See the
 			properties section for available properties.
 
-Signals		void Ring(string number)
-
-			Someone's calling from 'number'.
-			Caller number is provided as received from AG.
-
-		void CallTerminated()
-
-			Call failed to set up. It means that we tried to call
-			someone or someone tried to call us but call was not
-			accepted.
-
-		void CallStarted()
-
-			Call set up successfully.
-
-		void CallEnded()
-
-			Call was started and now ended. In contrast with
-			CallTerminated where call didn't started
-
-		PropertyChanged(string name, variant value)
+Signals		PropertyChanged(string name, variant value)
 
 			This signal indicates a changed value of the given
 			property.
 
-properties	boolean Connected [readonly]
-
-			Indicates if there is an active connection to the
-			AG service on the remote device.
-
-		uint16 RegistrationStatus [readonly]
-
-			Service availability indicator of AG, where:
-			0 implies no service. No Home/Roam network available.
-			1 implies presence of service. Home/Roam network
-			available.
-
-		uint16 SignalStrength [readonly]
-
-			Signal strength indicator of AG, the value ranges from
-			0 to 5.
-
-		uint16 RoamingStatus [readonly]
+properties	string State [readonly]
 
-			Roaming status indicator of AG, where:
-			0 means roaming is not active
-			1 means a roaming is active
+			Possible values: "disconnected", "connecting",
+			"connected", "playing"
 
-		uint16 BatteryCharge [readonly]
+			"disconnected" -> "connecting"
+				Either an incoming or outgoing connection
+				attempt ongoing.
 
-			Battery Charge indicator of AG, the value ranges from
-			0 to 5.
+			"connecting" -> "disconnected"
+				Connection attempt failed
 
-		uint16 SpeakerGain  [readonly]
+			"connecting" -> "connected"
+				Successfully connected
 
-			The speaker gain when available.
+			"connected" -> "playing"
+				SCO audio connection successfully opened
 
-		uint16 MicrophoneGain  [readonly]
+			"playing" -> "connected"
+				SCO audio connection closed
 
-			The speaker gain when available.
+			"connected" -> "disconnected"
+			"playing" -> "disconnected"
+				Disconnected from the remote device
 
 
 Telephony hierarchy
-- 
1.7.9.5

