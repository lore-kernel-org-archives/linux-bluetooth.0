Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?=
	<frederic.danis@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/4] Audio: move at parsing code to telephony-builtin.[ch] files
Date: Thu, 20 Oct 2011 15:52:15 +0200
Message-Id: <1319118738-20131-2-git-send-email-frederic.danis@linux.intel.com>
In-Reply-To: <1319118738-20131-1-git-send-email-frederic.danis@linux.intel.com>
References: <1319118738-20131-1-git-send-email-frederic.danis@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 Makefile.am               |    7 +-
 acinclude.m4              |    1 +
 audio/headset.c           | 1306 +++------------------------------------------
 audio/headset.h           |    4 +
 audio/telephony-builtin.c | 1287 ++++++++++++++++++++++++++++++++++++++++++++
 audio/telephony-builtin.h |  218 ++++++++
 audio/telephony-dummy.c   |    1 +
 audio/telephony-maemo5.c  |    1 +
 audio/telephony-maemo6.c  |    1 +
 audio/telephony-ofono.c   |    1 +
 audio/telephony.h         |  207 +-------
 11 files changed, 1615 insertions(+), 1419 deletions(-)
 create mode 100644 audio/telephony-builtin.c
 create mode 100644 audio/telephony-builtin.h

diff --git a/Makefile.am b/Makefile.am
index 138ab32..d528c84 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -157,6 +157,10 @@ builtin_sources += audio/main.c \
 			audio/telephony.h audio/a2dp-codecs.h
 builtin_nodist += audio/telephony.c
 
+if TELEPHONYBUILTIN
+builtin_sources += audio/telephony-builtin.h audio/telephony-builtin.c
+endif
+
 noinst_LIBRARIES += audio/libtelephony.a
 
 audio_libtelephony_a_SOURCES = audio/telephony.h audio/telephony-dummy.c \
@@ -340,7 +344,8 @@ EXTRA_DIST += src/genbuiltin src/bluetooth.conf \
 			audio/audio.conf audio/telephony-dummy.c \
 			audio/telephony-maemo5.c audio/telephony-ofono.c \
 			audio/telephony-maemo6.c sap/sap-dummy.c sap/sap-u8500.c \
-			proximity/proximity.conf
+			proximity/proximity.conf audio/telephony-builtin.h \
+			audio/telephony-builtin.c
 
 if ALSA
 alsadir = $(libdir)/alsa-lib
diff --git a/acinclude.m4 b/acinclude.m4
index 2097d77..f3f5200 100644
--- a/acinclude.m4
+++ b/acinclude.m4
@@ -433,4 +433,5 @@ AC_DEFUN([AC_ARG_BLUEZ], [
 	AM_CONDITIONAL(DBUSOOBPLUGIN, test "${dbusoob_enable}" = "yes")
 	AM_CONDITIONAL(WIIMOTEPLUGIN, test "${wiimote_enable}" = "yes")
 	AM_CONDITIONAL(THERMOMETERPLUGIN, test "${thermometer_enable}" = "yes")
+	AM_CONDITIONAL(TELEPHONYBUILTIN, test "${telephony_driver}" = "dummy" || test "${telephony_driver}" = "maemo5" || test "${telephony_driver}" = "maemo6" || test "${telephony_driver}" = "ofono")
 ])
diff --git a/audio/headset.c b/audio/headset.c
index 6aef6a8..8bec0ed 100644
--- a/audio/headset.c
+++ b/audio/headset.c
@@ -59,42 +59,11 @@
 #include "dbus-common.h"
 #include "../src/adapter.h"
 #include "../src/device.h"
+#include "telephony-builtin.h"
 
 #define DC_TIMEOUT 3
 
-#define RING_INTERVAL 3
-
-#define BUF_SIZE 1024
-
-#define HEADSET_GAIN_SPEAKER 'S'
-#define HEADSET_GAIN_MICROPHONE 'M'
-
-static struct {
-	gboolean telephony_ready;	/* Telephony plugin initialized */
-	uint32_t features;		/* HFP AG features */
-	const struct indicator *indicators;	/* Available HFP indicators */
-	int er_mode;			/* Event reporting mode */
-	int er_ind;			/* Event reporting for indicators */
-	int rh;				/* Response and Hold state */
-	char *number;			/* Incoming phone number */
-	int number_type;		/* Incoming number type */
-	guint ring_timer;		/* For incoming call indication */
-	const char *chld;		/* Response to AT+CHLD=? */
-} ag = {
-	.telephony_ready = FALSE,
-	.features = 0,
-	.er_mode = 3,
-	.er_ind = 0,
-	.rh = BTRH_NOT_SUPPORTED,
-	.number = NULL,
-	.number_type = 0,
-	.ring_timer = 0,
-};
-
 static gboolean sco_hci = TRUE;
-static gboolean fast_connectable = FALSE;
-
-static GSList *active_devices = NULL;
 
 static char *str_state[] = {
 	"HEADSET_STATE_DISCONNECTED",
@@ -132,25 +101,6 @@ struct pending_connect {
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
@@ -174,15 +124,10 @@ struct headset {
 	struct pending_connect *pending;
 
 	headset_lock_t lock;
-	struct headset_slc *slc;
+	void *slc;
 	GSList *nrec_cbs;
 };
 
-struct event {
-	const char *cmd;
-	int (*callback) (struct audio_device *device, const char *buf);
-};
-
 static GSList *headset_callbacks = NULL;
 
 static void error_connect_failed(DBusConnection *conn, DBusMessage *msg,
@@ -198,78 +143,6 @@ static int rfcomm_connect(struct audio_device *device, headset_stream_cb_t cb,
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
@@ -287,143 +160,6 @@ static const char *state2str(headset_state_t state)
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
@@ -504,64 +240,11 @@ static unsigned int connect_cb_new(struct headset *hs,
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
@@ -603,13 +286,8 @@ static void sco_connect_cb(GIOChannel *chan, GError *err, gpointer user_data)
 
 	headset_set_state(dev, HEADSET_STATE_PLAYING);
 
-	if (slc->pending_ring) {
-		ring_timer_cb(NULL);
-		ag.ring_timer = g_timeout_add_seconds(RING_INTERVAL,
-						ring_timer_cb,
-						NULL);
-		slc->pending_ring = FALSE;
-	}
+	if (telephony_pending_ring(hs->slc))
+		telephony_start_ring(hs->slc);
 }
 
 static int sco_connect(struct audio_device *dev, headset_stream_cb_t cb,
@@ -648,15 +326,7 @@ static int sco_connect(struct audio_device *dev, headset_stream_cb_t cb,
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
-static void hfp_slc_complete(struct audio_device *dev)
+void headset_slc_complete(struct audio_device *dev)
 {
 	struct headset *hs = dev->headset;
 	struct pending_connect *p = hs->pending;
@@ -685,569 +355,6 @@ static void hfp_slc_complete(struct audio_device *dev)
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
@@ -1266,94 +373,6 @@ static void close_sco(struct audio_device *device)
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
-		error("Too much data to fit incomming buffer");
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
-			err = headset_send(hs, "\r\nERROR\r\n");
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
@@ -1381,7 +400,7 @@ void headset_connect_cb(GIOChannel *chan, GError *err, gpointer user_data)
 	}
 
 	/* For HFP telephony isn't ready just disconnect */
-	if (hs->hfp_active && !ag.telephony_ready) {
+	if (hs->hfp_active && !telephony_get_ready_state()) {
 		error("Unable to accept HFP connection since the telephony "
 				"subsystem isn't initialized");
 		goto failed;
@@ -1397,16 +416,10 @@ void headset_connect_cb(GIOChannel *chan, GError *err, gpointer user_data)
 	else
 		hs->auto_dc = FALSE;
 
-	g_io_add_watch(chan, G_IO_IN | G_IO_ERR | G_IO_HUP| G_IO_NVAL,
-			(GIOFunc) rfcomm_io_cb, dev);
+	hs->slc = telephony_device_connecting(chan, dev);
 
 	DBG("%s: Connected to %s", dev->path, hs_address);
 
-	hs->slc = g_new0(struct headset_slc, 1);
-	hs->slc->sp_gain = 15;
-	hs->slc->mic_gain = 15;
-	hs->slc->nrec = TRUE;
-
 	/* In HFP mode wait for Service Level Connection */
 	if (hs->hfp_active)
 		return;
@@ -1740,7 +753,7 @@ static DBusMessage *hs_connect(DBusConnection *conn, DBusMessage *msg,
 	else if (hs->state > HEADSET_STATE_CONNECTING)
 		return btd_error_already_connected(msg);
 
-	if (hs->hfp_handle && !ag.telephony_ready)
+	if (hs->hfp_handle && !telephony_get_ready_state())
 		return btd_error_not_ready(msg);
 
 	device->auto_connect = FALSE;
@@ -1762,7 +775,9 @@ static DBusMessage *hs_ring(DBusConnection *conn, DBusMessage *msg,
 	struct audio_device *device = data;
 	struct headset *hs = device->headset;
 	DBusMessage *reply = NULL;
+#if 0
 	int err;
+#endif
 
 	if (hs->state < HEADSET_STATE_CONNECTED)
 		return btd_error_not_connected(msg);
@@ -1771,20 +786,20 @@ static DBusMessage *hs_ring(DBusConnection *conn, DBusMessage *msg,
 	if (!reply)
 		return NULL;
 
-	if (ag.ring_timer) {
+	if (telephony_is_ringing()) {
 		DBG("IndicateCall received when already indicating");
 		return reply;
 	}
 
+#if 0
 	err = headset_send(hs, "\r\nRING\r\n");
 	if (err < 0) {
 		dbus_message_unref(reply);
 		return btd_error_failed(msg, strerror(-err));
 	}
+#endif
 
-	ring_timer_cb(NULL);
-	ag.ring_timer = g_timeout_add_seconds(RING_INTERVAL, ring_timer_cb,
-						NULL);
+	telephony_start_ring(hs->slc);
 
 	return reply;
 }
@@ -1804,10 +819,9 @@ static DBusMessage *hs_cancel_call(DBusConnection *conn,
 	if (!reply)
 		return NULL;
 
-	if (ag.ring_timer) {
-		g_source_remove(ag.ring_timer);
-		ag.ring_timer = 0;
-	} else
+	if (telephony_is_ringing())
+		telephony_stop_ring(hs->slc);
+	else
 		DBG("Got CancelCall method call but no call is active");
 
 	return reply;
@@ -1858,7 +872,6 @@ static DBusMessage *hs_get_speaker_gain(DBusConnection *conn,
 {
 	struct audio_device *device = data;
 	struct headset *hs = device->headset;
-	struct headset_slc *slc = hs->slc;
 	DBusMessage *reply;
 	dbus_uint16_t gain;
 
@@ -1869,7 +882,7 @@ static DBusMessage *hs_get_speaker_gain(DBusConnection *conn,
 	if (!reply)
 		return NULL;
 
-	gain = (dbus_uint16_t) slc->sp_gain;
+	gain = (dbus_uint16_t) telephony_get_speaker_gain(hs->slc);
 
 	dbus_message_append_args(reply, DBUS_TYPE_UINT16, &gain,
 					DBUS_TYPE_INVALID);
@@ -1883,18 +896,17 @@ static DBusMessage *hs_get_mic_gain(DBusConnection *conn,
 {
 	struct audio_device *device = data;
 	struct headset *hs = device->headset;
-	struct headset_slc *slc = hs->slc;
 	DBusMessage *reply;
 	dbus_uint16_t gain;
 
-	if (hs->state < HEADSET_STATE_CONNECTED || slc == NULL)
+	if (hs->state < HEADSET_STATE_CONNECTED || hs->slc == NULL)
 		return btd_error_not_available(msg);
 
 	reply = dbus_message_new_method_return(msg);
 	if (!reply)
 		return NULL;
 
-	gain = (dbus_uint16_t) slc->mic_gain;
+	gain = (dbus_uint16_t) telephony_get_mic_gain(hs->slc);
 
 	dbus_message_append_args(reply, DBUS_TYPE_UINT16, &gain,
 					DBUS_TYPE_INVALID);
@@ -1909,13 +921,14 @@ static DBusMessage *hs_set_gain(DBusConnection *conn,
 {
 	struct audio_device *device = data;
 	struct headset *hs = device->headset;
+	struct at_slc *slc = hs->slc;
 	DBusMessage *reply;
 	int err;
 
 	if (hs->state < HEADSET_STATE_CONNECTED)
 		return btd_error_not_connected(msg);
 
-	err = headset_set_gain(device, gain, type);
+	err = telephony_set_gain(slc, gain, type);
 	if (err < 0)
 		return btd_error_invalid_args(msg);
 
@@ -1924,7 +937,7 @@ static DBusMessage *hs_set_gain(DBusConnection *conn,
 		return NULL;
 
 	if (hs->state == HEADSET_STATE_PLAYING) {
-		err = headset_send(hs, "\r\n+VG%c=%u\r\n", type, gain);
+		err = telephony_send_gain(slc, type, gain);
 		if (err < 0) {
 			dbus_message_unref(reply);
 			return btd_error_failed(msg, strerror(-err));
@@ -1969,6 +982,7 @@ static DBusMessage *hs_get_properties(DBusConnection *conn,
 	DBusMessageIter dict;
 	gboolean value;
 	const char *state;
+	int gain;
 
 	reply = dbus_message_new_method_return(msg);
 	if (!reply)
@@ -1999,14 +1013,12 @@ static DBusMessage *hs_get_properties(DBusConnection *conn,
 		goto done;
 
 	/* SpeakerGain */
-	dict_append_entry(&dict, "SpeakerGain",
-				DBUS_TYPE_UINT16,
-				&device->headset->slc->sp_gain);
+	gain = telephony_get_speaker_gain(device->headset->slc);
+	dict_append_entry(&dict, "SpeakerGain", DBUS_TYPE_UINT16, &gain);
 
 	/* MicrophoneGain */
-	dict_append_entry(&dict, "MicrophoneGain",
-				DBUS_TYPE_UINT16,
-				&device->headset->slc->mic_gain);
+	gain = telephony_get_mic_gain(device->headset->slc);
+	dict_append_entry(&dict, "MicrophoneGain", DBUS_TYPE_UINT16, &gain);
 
 done:
 	dbus_message_iter_close_container(&iter, &dict);
@@ -2245,7 +1257,7 @@ uint32_t headset_config_init(GKeyFile *config)
 
 	/* Use the default values if there is no config file */
 	if (config == NULL)
-		return ag.features;
+		return telephony_get_ag_features();
 
 	str = g_key_file_get_string(config, "General", "SCORouting",
 					&err);
@@ -2269,13 +1281,14 @@ uint32_t headset_config_init(GKeyFile *config)
 		DBG("audio.conf: %s", err->message);
 		g_clear_error(&err);
 	} else {
-		fast_connectable = strcmp(str, "true") == 0;
-		if (fast_connectable)
+		if (strcmp(str, "true") == 0) {
+			telephony_set_fast_connectable(TRUE);
 			manager_set_fast_connectable(FALSE);
+		}
 		g_free(str);
 	}
 
-	return ag.features;
+	return telephony_get_ag_features();
 }
 
 static gboolean hs_dc_timeout(struct audio_device *dev)
@@ -2482,20 +1495,14 @@ int headset_connect_rfcomm(struct audio_device *dev, GIOChannel *io)
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
+	if (telephony_pending_ring(hs->slc))
+		telephony_start_ring(hs->slc);
 
 	return 0;
 }
@@ -2503,11 +1510,11 @@ int headset_connect_sco(struct audio_device *dev, GIOChannel *io)
 void headset_set_state(struct audio_device *dev, headset_state_t state)
 {
 	struct headset *hs = dev->headset;
-	struct headset_slc *slc = hs->slc;
 	gboolean value;
 	const char *state_str;
 	headset_state_t old_state = hs->state;
 	GSList *l;
+	int gain;
 
 	if (old_state == state)
 		return;
@@ -2518,6 +1525,10 @@ void headset_set_state(struct audio_device *dev, headset_state_t state)
 	case HEADSET_STATE_DISCONNECTED:
 		value = FALSE;
 		close_sco(dev);
+
+		if (dev->headset->slc)
+			telephony_device_disconnect(dev->headset->slc);
+
 		headset_close_rfcomm(dev);
 		emit_property_changed(dev->conn, dev->path,
 					AUDIO_HEADSET_INTERFACE, "State",
@@ -2532,7 +1543,7 @@ void headset_set_state(struct audio_device *dev, headset_state_t state)
 					DBUS_TYPE_BOOLEAN, &value);
 			telephony_device_disconnected(dev);
 		}
-		active_devices = g_slist_remove(active_devices, dev);
+		telephony_device_set_active(dev, FALSE);
 		break;
 	case HEADSET_STATE_CONNECTING:
 		emit_property_changed(dev->conn, dev->path,
@@ -2546,10 +1557,11 @@ void headset_set_state(struct audio_device *dev, headset_state_t state)
 					AUDIO_HEADSET_INTERFACE, "State",
 					DBUS_TYPE_STRING, &state_str);
 		if (hs->state < state) {
-			if (ag.features & AG_FEATURE_INBAND_RINGTONE)
-				slc->inband_ring = TRUE;
+			if (telephony_get_ag_features()
+						& AG_FEATURE_INBAND_RINGTONE)
+				telephony_set_inband_ringtone(hs->slc, TRUE);
 			else
-				slc->inband_ring = FALSE;
+				telephony_set_inband_ringtone(hs->slc, FALSE);
 			g_dbus_emit_signal(dev->conn, dev->path,
 						AUDIO_HEADSET_INTERFACE,
 						"Connected",
@@ -2559,7 +1571,7 @@ void headset_set_state(struct audio_device *dev, headset_state_t state)
 						AUDIO_HEADSET_INTERFACE,
 						"Connected",
 						DBUS_TYPE_BOOLEAN, &value);
-			active_devices = g_slist_append(active_devices, dev);
+			telephony_device_set_active(dev, TRUE);
 			telephony_device_connected(dev);
 		} else if (hs->state == HEADSET_STATE_PLAYING) {
 			value = FALSE;
@@ -2594,10 +1606,15 @@ void headset_set_state(struct audio_device *dev, headset_state_t state)
 					AUDIO_HEADSET_INTERFACE, "Playing",
 					DBUS_TYPE_BOOLEAN, &value);
 
-		if (slc->sp_gain >= 0)
-			headset_send(hs, "\r\n+VGS=%u\r\n", slc->sp_gain);
-		if (slc->mic_gain >= 0)
-			headset_send(hs, "\r\n+VGM=%u\r\n", slc->mic_gain);
+		gain = telephony_get_speaker_gain(hs->slc);
+		if (gain >= 0)
+			telephony_send_gain(hs->slc, HEADSET_GAIN_SPEAKER,
+						gain);
+
+		gain = telephony_get_mic_gain(hs->slc);
+		if (gain >= 0)
+			telephony_send_gain(hs->slc, HEADSET_GAIN_MICROPHONE,
+						gain);
 		break;
 	}
 
@@ -2709,7 +1726,7 @@ gboolean headset_get_nrec(struct audio_device *dev)
 	if (!hs->slc)
 		return TRUE;
 
-	return hs->slc->nrec;
+	return telephony_get_nrec(hs->slc);
 }
 
 unsigned int headset_add_nrec_cb(struct audio_device *dev,
@@ -2746,6 +1763,18 @@ gboolean headset_remove_nrec_cb(struct audio_device *dev, unsigned int id)
 	return FALSE;
 }
 
+void headset_set_nrec(struct audio_device *dev, gboolean state)
+{
+	struct headset *hs = dev->headset;
+	GSList *l;
+
+	for (l = hs->nrec_cbs; l; l = l->next) {
+		struct headset_nrec_callback *nrec_cb = l->data;
+
+		nrec_cb->cb(dev, state, nrec_cb->user_data);
+	}
+}
+
 gboolean headset_get_inband(struct audio_device *dev)
 {
 	struct headset *hs = dev->headset;
@@ -2753,7 +1782,7 @@ gboolean headset_get_inband(struct audio_device *dev)
 	if (!hs->slc)
 		return TRUE;
 
-	return hs->slc->inband_ring;
+	return telephony_get_inband_ringtone(hs->slc);
 }
 
 gboolean headset_get_sco_hci(struct audio_device *dev)
@@ -2772,195 +1801,6 @@ void headset_shutdown(struct audio_device *dev)
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
@@ -2991,3 +1831,11 @@ gboolean headset_remove_state_cb(unsigned int id)
 
 	return FALSE;
 }
+
+struct at_slc *headset_get_slc(struct audio_device *dev)
+{
+	if (!dev->headset)
+		return NULL;
+
+	return dev->headset->slc;
+}
diff --git a/audio/headset.h b/audio/headset.h
index 99eeca8..a26e6b7 100644
--- a/audio/headset.h
+++ b/audio/headset.h
@@ -100,6 +100,7 @@ gboolean headset_get_nrec(struct audio_device *dev);
 unsigned int headset_add_nrec_cb(struct audio_device *dev,
 					headset_nrec_cb cb, void *user_data);
 gboolean headset_remove_nrec_cb(struct audio_device *dev, unsigned int id);
+void headset_set_nrec(struct audio_device *dev, gboolean state);
 gboolean headset_get_inband(struct audio_device *dev);
 gboolean headset_get_sco_hci(struct audio_device *dev);
 
@@ -111,3 +112,6 @@ gboolean headset_unlock(struct audio_device *dev, headset_lock_t lock);
 gboolean headset_suspend(struct audio_device *dev, void *data);
 gboolean headset_play(struct audio_device *dev, void *data);
 void headset_shutdown(struct audio_device *dev);
+
+struct at_slc *headset_get_slc(struct audio_device *dev);
+void headset_slc_complete(struct audio_device *dev);
diff --git a/audio/telephony-builtin.c b/audio/telephony-builtin.c
new file mode 100644
index 0000000..84a34f2
--- /dev/null
+++ b/audio/telephony-builtin.c
@@ -0,0 +1,1287 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2011  Intel Corporation
+ *  Copyright (C) 2006-2010  Nokia Corporation
+ *  Copyright (C) 2004-2010  Marcel Holtmann <marcel@holtmann.org>
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
+#include <stdio.h>
+#include <errno.h>
+#include <unistd.h>
+#include <stdlib.h>
+#include <string.h>
+#include <assert.h>
+
+#include <bluetooth/bluetooth.h>
+
+#include <glib.h>
+#include <dbus/dbus.h>
+#include <gdbus.h>
+
+#include "log.h"
+#include "device.h"
+#include "manager.h"
+#include "telephony.h"
+#include "headset.h"
+#include "dbus-common.h"
+#include "telephony-builtin.h"
+
+#define RING_INTERVAL 3
+
+#define BUF_SIZE 1024
+
+static struct {
+	gboolean telephony_ready;	/* Telephony plugin initialized */
+	uint32_t features;		/* HFP AG features */
+	const struct indicator *indicators;	/* Available HFP indicators */
+	int er_mode;			/* Event reporting mode */
+	int er_ind;			/* Event reporting for indicators */
+	int rh;				/* Response and Hold state */
+	char *number;			/* Incoming phone number */
+	int number_type;		/* Incoming number type */
+	guint ring_timer;		/* For incoming call indication */
+	const char *chld;		/* Response to AT+CHLD=? */
+} ag = {
+	.telephony_ready = FALSE,
+	.features = 0,
+	.er_mode = 3,
+	.er_ind = 0,
+	.rh = BTRH_NOT_SUPPORTED,
+	.number = NULL,
+	.number_type = 0,
+	.ring_timer = 0,
+};
+
+static gboolean fast_connectable = FALSE;
+
+static GSList *active_devices = NULL;
+
+struct at_slc {
+	struct audio_device *device;
+	GIOChannel *rfcomm;
+
+	char buf[BUF_SIZE];
+	int data_start;
+	int data_length;
+
+	gboolean cli_active;
+	gboolean cme_enabled;
+	gboolean cwa_enabled;
+	gboolean pending_ring;
+	gboolean inband_ring;
+	gboolean nrec;
+	gboolean nrec_req;
+
+	int sp_gain;
+	int mic_gain;
+
+	unsigned int hf_features;
+};
+
+struct event {
+	const char *cmd;
+	int (*callback) (struct at_slc *slc, const char *buf);
+};
+
+static void print_ag_features(uint32_t features)
+{
+	GString *gstr;
+	char *str;
+
+	if (features == 0) {
+		DBG("HFP AG features: (none)");
+		return;
+	}
+
+	gstr = g_string_new("HFP AG features: ");
+
+	if (features & AG_FEATURE_THREE_WAY_CALLING)
+		g_string_append(gstr, "\"Three-way calling\" ");
+	if (features & AG_FEATURE_EC_ANDOR_NR)
+		g_string_append(gstr, "\"EC and/or NR function\" ");
+	if (features & AG_FEATURE_VOICE_RECOGNITION)
+		g_string_append(gstr, "\"Voice recognition function\" ");
+	if (features & AG_FEATURE_INBAND_RINGTONE)
+		g_string_append(gstr, "\"In-band ring tone capability\" ");
+	if (features & AG_FEATURE_ATTACH_NUMBER_TO_VOICETAG)
+		g_string_append(gstr, "\"Attach a number to a voice tag\" ");
+	if (features & AG_FEATURE_REJECT_A_CALL)
+		g_string_append(gstr, "\"Ability to reject a call\" ");
+	if (features & AG_FEATURE_ENHANCED_CALL_STATUS)
+		g_string_append(gstr, "\"Enhanced call status\" ");
+	if (features & AG_FEATURE_ENHANCED_CALL_CONTROL)
+		g_string_append(gstr, "\"Enhanced call control\" ");
+	if (features & AG_FEATURE_EXTENDED_ERROR_RESULT_CODES)
+		g_string_append(gstr, "\"Extended Error Result Codes\" ");
+
+	str = g_string_free(gstr, FALSE);
+
+	DBG("%s", str);
+
+	g_free(str);
+}
+
+static void print_hf_features(uint32_t features)
+{
+	GString *gstr;
+	char *str;
+
+	if (features == 0) {
+		DBG("HFP HF features: (none)");
+		return;
+	}
+
+	gstr = g_string_new("HFP HF features: ");
+
+	if (features & HF_FEATURE_EC_ANDOR_NR)
+		g_string_append(gstr, "\"EC and/or NR function\" ");
+	if (features & HF_FEATURE_CALL_WAITING_AND_3WAY)
+		g_string_append(gstr, "\"Call waiting and 3-way calling\" ");
+	if (features & HF_FEATURE_CLI_PRESENTATION)
+		g_string_append(gstr, "\"CLI presentation capability\" ");
+	if (features & HF_FEATURE_VOICE_RECOGNITION)
+		g_string_append(gstr, "\"Voice recognition activation\" ");
+	if (features & HF_FEATURE_REMOTE_VOLUME_CONTROL)
+		g_string_append(gstr, "\"Remote volume control\" ");
+	if (features & HF_FEATURE_ENHANCED_CALL_STATUS)
+		g_string_append(gstr, "\"Enhanced call status\" ");
+	if (features & HF_FEATURE_ENHANCED_CALL_CONTROL)
+		g_string_append(gstr, "\"Enhanced call control\" ");
+
+	str = g_string_free(gstr, FALSE);
+
+	DBG("%s", str);
+
+	g_free(str);
+}
+
+static int at_send_valist(struct at_slc *slc, char *format, va_list ap)
+{
+	char rsp[BUF_SIZE];
+	ssize_t total_written, count;
+	int fd;
+
+	count = vsnprintf(rsp, sizeof(rsp), format, ap);
+
+	if (count < 0)
+		return -EINVAL;
+
+	if (!slc->rfcomm) {
+		error("headset_send: the headset is not connected");
+		return -EIO;
+	}
+
+	total_written = 0;
+	fd = g_io_channel_unix_get_fd(slc->rfcomm);
+
+	while (total_written < count) {
+		ssize_t written;
+
+		written = write(fd, rsp + total_written,
+				count - total_written);
+		if (written < 0)
+			return -errno;
+
+		total_written += written;
+	}
+
+	return 0;
+}
+
+static int __attribute__((format(printf, 2, 3)))
+			at_send(struct at_slc *slc, char *format, ...)
+{
+	va_list ap;
+	int ret;
+
+	va_start(ap, format);
+	ret = at_send_valist(slc, format, ap);
+	va_end(ap);
+
+	return ret;
+}
+
+static int supported_features(struct at_slc *slc, const char *buf)
+{
+	int err;
+
+	if (strlen(buf) < 9)
+		return -EINVAL;
+
+	slc->hf_features = strtoul(&buf[8], NULL, 10);
+
+	print_hf_features(slc->hf_features);
+
+	err = at_send(slc, "\r\n+BRSF: %u\r\n", ag.features);
+	if (err < 0)
+		return err;
+
+	return at_send(slc, "\r\nOK\r\n");
+}
+
+static char *indicator_ranges(const struct indicator *indicators)
+{
+	int i;
+	GString *gstr;
+
+	gstr = g_string_new("\r\n+CIND: ");
+
+	for (i = 0; indicators[i].desc != NULL; i++) {
+		if (i == 0)
+			g_string_append_printf(gstr, "(\"%s\",(%s))",
+						indicators[i].desc,
+						indicators[i].range);
+		else
+			g_string_append_printf(gstr, ",(\"%s\",(%s))",
+						indicators[i].desc,
+						indicators[i].range);
+	}
+
+	g_string_append(gstr, "\r\n");
+
+	return g_string_free(gstr, FALSE);
+}
+
+static char *indicator_values(const struct indicator *indicators)
+{
+	int i;
+	GString *gstr;
+
+	gstr = g_string_new("\r\n+CIND: ");
+
+	for (i = 0; indicators[i].desc != NULL; i++) {
+		if (i == 0)
+			g_string_append_printf(gstr, "%d", indicators[i].val);
+		else
+			g_string_append_printf(gstr, ",%d", indicators[i].val);
+	}
+
+	g_string_append(gstr, "\r\n");
+
+	return g_string_free(gstr, FALSE);
+}
+
+static int report_indicators(struct at_slc *slc, const char *buf)
+{
+	int err;
+	char *str;
+
+	if (strlen(buf) < 8)
+		return -EINVAL;
+
+	if (ag.indicators == NULL) {
+		error("HFP AG indicators not initialized");
+		return at_send(slc, "\r\nERROR\r\n");
+	}
+
+	if (buf[7] == '=')
+		str = indicator_ranges(ag.indicators);
+	else
+		str = indicator_values(ag.indicators);
+
+	err = at_send(slc, "%s", str);
+
+	g_free(str);
+
+	if (err < 0)
+		return err;
+
+	return at_send(slc, "\r\nOK\r\n");
+}
+
+static void __attribute__((format(printf, 3, 4)))
+		send_foreach_headset(GSList *devices,
+					int (*cmp) (struct at_slc *slc),
+					char *format, ...)
+{
+	GSList *l;
+	va_list ap;
+
+	for (l = devices; l != NULL; l = l->next) {
+		struct at_slc *slc = l->data;
+		int ret;
+
+		assert(slc != NULL);
+
+		if (cmp && cmp(slc) != 0)
+			continue;
+
+		va_start(ap, format);
+		ret = at_send_valist(slc, format, ap);
+		if (ret < 0)
+			error("Failed to send to headset: %s (%d)",
+					strerror(-ret), -ret);
+		va_end(ap);
+	}
+}
+
+static int cli_cmp(struct at_slc *slc)
+{
+	if (!headset_get_hfp_active(slc->device))
+		return -1;
+
+	if (slc->cli_active)
+		return 0;
+	else
+		return -1;
+}
+
+static gboolean ring_timer_cb(gpointer data)
+{
+	send_foreach_headset(active_devices, NULL, "\r\nRING\r\n");
+
+	if (ag.number)
+		send_foreach_headset(active_devices, cli_cmp,
+					"\r\n+CLIP: \"%s\",%d\r\n",
+					ag.number, ag.number_type);
+
+	return TRUE;
+}
+
+static int hfp_cmp(struct at_slc *slc)
+{
+	if (headset_get_hfp_active(slc->device))
+		return 0;
+	else
+		return -1;
+}
+
+static int telephony_generic_rsp(struct at_slc *slc, cme_error_t err)
+{
+	if ((err != CME_ERROR_NONE) && slc->cme_enabled)
+		return at_send(slc, "\r\n+CME ERROR: %d\r\n", err);
+
+	switch (err) {
+	case CME_ERROR_NONE:
+		return at_send(slc, "\r\nOK\r\n");
+	case CME_ERROR_NO_NETWORK_SERVICE:
+		return at_send(slc, "\r\nNO CARRIER\r\n");
+	default:
+		return at_send(slc, "\r\nERROR\r\n");
+	}
+}
+
+int telephony_event_reporting_rsp(void *telephony_device, cme_error_t err)
+{
+	struct at_slc *slc = telephony_device;
+	int ret;
+
+	if (err != CME_ERROR_NONE)
+		return telephony_generic_rsp(telephony_device, err);
+
+	ret = at_send(slc, "\r\nOK\r\n");
+	if (ret < 0)
+		return ret;
+
+	if (headset_get_state(slc->device) != HEADSET_STATE_CONNECTING)
+		return 0;
+
+	if (slc->hf_features & HF_FEATURE_CALL_WAITING_AND_3WAY &&
+			ag.features & AG_FEATURE_THREE_WAY_CALLING)
+		return 0;
+
+	headset_slc_complete(slc->device);
+
+	return 0;
+}
+
+static int event_reporting(struct at_slc *slc, const char *buf)
+{
+	char **tokens; /* <mode>, <keyp>, <disp>, <ind>, <bfr> */
+
+	if (strlen(buf) < 13)
+		return -EINVAL;
+
+	tokens = g_strsplit(&buf[8], ",", 5);
+	if (g_strv_length(tokens) < 4) {
+		g_strfreev(tokens);
+		return -EINVAL;
+	}
+
+	ag.er_mode = atoi(tokens[0]);
+	ag.er_ind = atoi(tokens[3]);
+
+	g_strfreev(tokens);
+	tokens = NULL;
+
+	DBG("Event reporting (CMER): mode=%d, ind=%d",
+			ag.er_mode, ag.er_ind);
+
+	switch (ag.er_ind) {
+	case 0:
+	case 1:
+		telephony_event_reporting_req(slc, ag.er_ind);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int call_hold(struct at_slc *slc, const char *buf)
+{
+	int err;
+
+	if (strlen(buf) < 9)
+		return -EINVAL;
+
+	if (buf[8] != '?') {
+		telephony_call_hold_req(slc->device, &buf[8]);
+		return 0;
+	}
+
+	err = at_send(slc, "\r\n+CHLD: (%s)\r\n", ag.chld);
+	if (err < 0)
+		return err;
+
+	err = at_send(slc, "\r\nOK\r\n");
+	if (err < 0)
+		return err;
+
+	if (headset_get_state(slc->device) != HEADSET_STATE_CONNECTING)
+		return 0;
+
+	headset_slc_complete(slc->device);
+
+	return 0;
+}
+
+int telephony_key_press_rsp(void *telephony_device, cme_error_t err)
+{
+	return telephony_generic_rsp(telephony_device, err);
+}
+
+static int key_press(struct at_slc *slc, const char *buf)
+{
+	if (strlen(buf) < 9)
+		return -EINVAL;
+
+	g_dbus_emit_signal(slc->device->conn, slc->device->path,
+			AUDIO_HEADSET_INTERFACE, "AnswerRequested",
+			DBUS_TYPE_INVALID);
+
+	if (ag.ring_timer) {
+		g_source_remove(ag.ring_timer);
+		ag.ring_timer = 0;
+	}
+
+	telephony_key_press_req(slc, &buf[8]);
+
+	return 0;
+}
+
+int telephony_answer_call_rsp(void *telephony_device, cme_error_t err)
+{
+	return telephony_generic_rsp(telephony_device, err);
+}
+
+static int answer_call(struct at_slc *slc, const char *buf)
+{
+	if (ag.ring_timer) {
+		g_source_remove(ag.ring_timer);
+		ag.ring_timer = 0;
+	}
+
+	if (ag.number) {
+		g_free(ag.number);
+		ag.number = NULL;
+	}
+
+	telephony_answer_call_req(slc);
+
+	return 0;
+}
+
+int telephony_terminate_call_rsp(void *telephony_device, cme_error_t err)
+{
+	struct at_slc *slc = telephony_device;
+
+	if (err != CME_ERROR_NONE)
+		return telephony_generic_rsp(telephony_device, err);
+
+	g_dbus_emit_signal(slc->device->conn, slc->device->path,
+			AUDIO_HEADSET_INTERFACE, "CallTerminated",
+			DBUS_TYPE_INVALID);
+
+	return at_send(slc, "\r\nOK\r\n");
+}
+
+static int terminate_call(struct at_slc *slc, const char *buf)
+{
+	if (ag.number) {
+		g_free(ag.number);
+		ag.number = NULL;
+	}
+
+	if (ag.ring_timer) {
+		g_source_remove(ag.ring_timer);
+		ag.ring_timer = 0;
+	}
+
+	telephony_terminate_call_req(slc);
+
+	return 0;
+}
+
+static int cli_notification(struct at_slc *slc, const char *buf)
+{
+	if (strlen(buf) < 9)
+		return -EINVAL;
+
+	slc->cli_active = buf[8] == '1' ? TRUE : FALSE;
+
+	return at_send(slc, "\r\nOK\r\n");
+}
+
+int telephony_response_and_hold_rsp(void *telephony_device, cme_error_t err)
+{
+	return telephony_generic_rsp(telephony_device, err);
+}
+
+static int response_and_hold(struct at_slc *slc, const char *buf)
+{
+	if (strlen(buf) < 8)
+		return -EINVAL;
+
+	if (ag.rh == BTRH_NOT_SUPPORTED)
+		return telephony_generic_rsp(slc, CME_ERROR_NOT_SUPPORTED);
+
+	if (buf[7] == '=') {
+		telephony_response_and_hold_req(slc, atoi(&buf[8]) < 0);
+		return 0;
+	}
+
+	if (ag.rh >= 0)
+		at_send(slc, "\r\n+BTRH: %d\r\n", ag.rh);
+
+	return at_send(slc, "\r\nOK\r\n");
+}
+
+int telephony_last_dialed_number_rsp(void *telephony_device, cme_error_t err)
+{
+	return telephony_generic_rsp(telephony_device, err);
+}
+
+static int last_dialed_number(struct at_slc *slc, const char *buf)
+{
+	telephony_last_dialed_number_req(slc);
+
+	return 0;
+}
+
+int telephony_dial_number_rsp(void *telephony_device, cme_error_t err)
+{
+	return telephony_generic_rsp(telephony_device, err);
+}
+
+static int dial_number(struct at_slc *slc, const char *buf)
+{
+	char number[BUF_SIZE];
+	size_t buf_len;
+
+	buf_len = strlen(buf);
+
+	if (buf[buf_len - 1] != ';') {
+		DBG("Rejecting non-voice call dial request");
+		return -EINVAL;
+	}
+
+	memset(number, 0, sizeof(number));
+	strncpy(number, &buf[3], buf_len - 4);
+
+	telephony_dial_number_req(slc, number);
+
+	return 0;
+}
+
+int telephony_set_gain(void *slc, uint16_t gain, char type)
+{
+	struct at_slc *s = slc;
+	const char *name, *property;
+
+	if (gain > 15) {
+		error("Invalid gain value: %u", gain);
+		return -EINVAL;
+	}
+
+	switch (type) {
+	case HEADSET_GAIN_SPEAKER:
+		if (s->sp_gain == gain) {
+			DBG("Ignoring no-change in speaker gain");
+			return -EALREADY;
+		}
+		name = "SpeakerGainChanged";
+		property = "SpeakerGain";
+		s->sp_gain = gain;
+		break;
+	case HEADSET_GAIN_MICROPHONE:
+		if (s->mic_gain == gain) {
+			DBG("Ignoring no-change in microphone gain");
+			return -EALREADY;
+		}
+		name = "MicrophoneGainChanged";
+		property = "MicrophoneGain";
+		s->mic_gain = gain;
+		break;
+	default:
+		error("Unknown gain setting");
+		return -EINVAL;
+	}
+
+	g_dbus_emit_signal(s->device->conn, s->device->path,
+				AUDIO_HEADSET_INTERFACE, name,
+				DBUS_TYPE_UINT16, &gain,
+				DBUS_TYPE_INVALID);
+
+	emit_property_changed(s->device->conn, s->device->path,
+				AUDIO_HEADSET_INTERFACE, property,
+				DBUS_TYPE_UINT16, &gain);
+
+	return 0;
+}
+
+static int signal_gain_setting(struct at_slc *slc, const char *buf)
+{
+	dbus_uint16_t gain;
+	int err;
+
+	if (strlen(buf) < 8) {
+		error("Too short string for Gain setting");
+		return -EINVAL;
+	}
+
+	gain = (dbus_uint16_t) strtol(&buf[7], NULL, 10);
+
+	err = telephony_set_gain(slc, gain, buf[5]);
+	if (err < 0 && err != -EALREADY)
+		return err;
+
+	return at_send(slc, "\r\nOK\r\n");
+}
+
+int telephony_transmit_dtmf_rsp(void *telephony_device, cme_error_t err)
+{
+	return telephony_generic_rsp(telephony_device, err);
+}
+
+static int dtmf_tone(struct at_slc *slc, const char *buf)
+{
+	char tone;
+
+	if (strlen(buf) < 8) {
+		error("Too short string for DTMF tone");
+		return -EINVAL;
+	}
+
+	tone = buf[7];
+	if (tone >= '#' && tone <= 'D')
+		telephony_transmit_dtmf_req(slc, tone);
+	else
+		return -EINVAL;
+
+	return 0;
+}
+
+int telephony_subscriber_number_rsp(void *telephony_device, cme_error_t err)
+{
+	return telephony_generic_rsp(telephony_device, err);
+}
+
+static int subscriber_number(struct at_slc *slc, const char *buf)
+{
+	telephony_subscriber_number_req(slc);
+
+	return 0;
+}
+
+int telephony_list_current_calls_rsp(void *telephony_device, cme_error_t err)
+{
+	return telephony_generic_rsp(telephony_device, err);
+}
+
+static int list_current_calls(struct at_slc *slc, const char *buf)
+{
+	telephony_list_current_calls_req(slc);
+
+	return 0;
+}
+
+static int extended_errors(struct at_slc *slc, const char *buf)
+{
+	if (strlen(buf) < 9)
+		return -EINVAL;
+
+	if (buf[8] == '1') {
+		slc->cme_enabled = TRUE;
+		DBG("CME errors enabled for headset %p", slc->device->headset);
+	} else {
+		slc->cme_enabled = FALSE;
+		DBG("CME errors disabled for headset %p", slc->device->headset);
+	}
+
+	return at_send(slc, "\r\nOK\r\n");
+}
+
+static int call_waiting_notify(struct at_slc *slc, const char *buf)
+{
+	if (strlen(buf) < 9)
+		return -EINVAL;
+
+	if (buf[8] == '1') {
+		slc->cwa_enabled = TRUE;
+		DBG("Call waiting notification enabled for headset %p",
+							slc->device->headset);
+	} else {
+		slc->cwa_enabled = FALSE;
+		DBG("Call waiting notification disabled for headset %p",
+							slc->device->headset);
+	}
+
+	return at_send(slc, "\r\nOK\r\n");
+}
+
+int telephony_operator_selection_rsp(void *telephony_device, cme_error_t err)
+{
+	return telephony_generic_rsp(telephony_device, err);
+}
+
+int telephony_call_hold_rsp(void *telephony_device, cme_error_t err)
+{
+	return telephony_generic_rsp(telephony_device, err);
+}
+
+int telephony_nr_and_ec_rsp(void *telephony_device, cme_error_t err)
+{
+	struct at_slc *slc= telephony_device;
+
+	if (err == CME_ERROR_NONE) {
+		headset_set_nrec(slc->device, slc->nrec_req);
+		slc->nrec = slc->nrec_req;
+	}
+
+	return telephony_generic_rsp(telephony_device, err);
+}
+
+int telephony_voice_dial_rsp(void *telephony_device, cme_error_t err)
+{
+	return telephony_generic_rsp(telephony_device, err);
+}
+
+int telephony_operator_selection_ind(int mode, const char *oper)
+{
+	if (!active_devices)
+		return -ENODEV;
+
+	send_foreach_headset(active_devices, hfp_cmp,
+				"\r\n+COPS: %d,0,\"%s\"\r\n",
+				mode, oper);
+	return 0;
+}
+
+static int operator_selection(struct at_slc *slc, const char *buf)
+{
+	if (strlen(buf) < 8)
+		return -EINVAL;
+
+	switch (buf[7]) {
+	case '?':
+		telephony_operator_selection_req(slc);
+		break;
+	case '=':
+		return at_send(slc, "\r\nOK\r\n");
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int nr_and_ec(struct at_slc *slc, const char *buf)
+{
+	if (strlen(buf) < 9)
+		return -EINVAL;
+
+	if (buf[8] == '0')
+		slc->nrec_req = FALSE;
+	else
+		slc->nrec_req = TRUE;
+
+	telephony_nr_and_ec_req(slc, slc->nrec_req);
+
+	return 0;
+}
+
+static int voice_dial(struct at_slc *slc, const char *buf)
+{
+	gboolean enable;
+
+	if (strlen(buf) < 9)
+		return -EINVAL;
+
+	if (buf[8] == '0')
+		enable = FALSE;
+	else
+		enable = TRUE;
+
+	telephony_voice_dial_req(slc, enable);
+
+	return 0;
+}
+
+static int apple_command(struct at_slc *slc, const char *buf)
+{
+	DBG("Got Apple command: %s", buf);
+
+	return telephony_generic_rsp(slc, CME_ERROR_NONE);
+}
+
+static struct event event_callbacks[] = {
+	{ "ATA", answer_call },
+	{ "ATD", dial_number },
+	{ "AT+VG", signal_gain_setting },
+	{ "AT+BRSF", supported_features },
+	{ "AT+CIND", report_indicators },
+	{ "AT+CMER", event_reporting },
+	{ "AT+CHLD", call_hold },
+	{ "AT+CHUP", terminate_call },
+	{ "AT+CKPD", key_press },
+	{ "AT+CLIP", cli_notification },
+	{ "AT+BTRH", response_and_hold },
+	{ "AT+BLDN", last_dialed_number },
+	{ "AT+VTS", dtmf_tone },
+	{ "AT+CNUM", subscriber_number },
+	{ "AT+CLCC", list_current_calls },
+	{ "AT+CMEE", extended_errors },
+	{ "AT+CCWA", call_waiting_notify },
+	{ "AT+COPS", operator_selection },
+	{ "AT+NREC", nr_and_ec },
+	{ "AT+BVRA", voice_dial },
+	{ "AT+XAPL", apple_command },
+	{ "AT+IPHONEACCEV", apple_command },
+	{ 0 }
+};
+
+static int handle_event(struct at_slc *slc, const char *buf)
+{
+	struct event *ev;
+
+	DBG("Received %s", buf);
+
+	for (ev = event_callbacks; ev->cmd; ev++) {
+		if (!strncmp(buf, ev->cmd, strlen(ev->cmd)))
+			return ev->callback(slc, buf);
+	}
+
+	return -EINVAL;
+}
+
+static gboolean io_cb(GIOChannel *chan, GIOCondition cond, struct at_slc *slc)
+{
+	unsigned char buf[BUF_SIZE];
+	ssize_t bytes_read;
+	size_t free_space;
+	int fd;
+
+	if (cond & G_IO_NVAL)
+		return FALSE;
+
+	if (cond & (G_IO_ERR | G_IO_HUP)) {
+		DBG("ERR or HUP on RFCOMM socket");
+		goto failed;
+	}
+
+	fd = g_io_channel_unix_get_fd(chan);
+
+	bytes_read = read(fd, buf, sizeof(buf) - 1);
+	if (bytes_read < 0)
+		return TRUE;
+
+	free_space = sizeof(slc->buf) - slc->data_start -
+			slc->data_length - 1;
+
+	if (free_space < (size_t) bytes_read) {
+		/* Very likely that the HS is sending us garbage so
+		 * just ignore the data and disconnect */
+		error("Too much data to fit incomming buffer");
+		goto failed;
+	}
+
+	memcpy(&slc->buf[slc->data_start], buf, bytes_read);
+	slc->data_length += bytes_read;
+
+	/* Make sure the data is null terminated so we can use string
+	 * functions */
+	slc->buf[slc->data_start + slc->data_length] = '\0';
+
+	while (slc->data_length > 0) {
+		char *cr;
+		int err;
+		off_t cmd_len;
+
+		cr = strchr(&slc->buf[slc->data_start], '\r');
+		if (!cr)
+			break;
+
+		cmd_len = 1 + (off_t) cr - (off_t) &slc->buf[slc->data_start];
+		*cr = '\0';
+
+		if (cmd_len > 1)
+			err = handle_event(slc, &slc->buf[slc->data_start]);
+		else
+			/* Silently skip empty commands */
+			err = 0;
+
+		if (err == -EINVAL) {
+			error("Badly formated or unrecognized command: %s",
+					&slc->buf[slc->data_start]);
+			err = at_send(slc, "\r\nERROR\r\n");
+			if (err < 0)
+				goto failed;
+		} else if (err < 0)
+			error("Error handling command %s: %s (%d)",
+						&slc->buf[slc->data_start],
+						strerror(-err), -err);
+
+		slc->data_start += cmd_len;
+		slc->data_length -= cmd_len;
+
+		if (!slc->data_length)
+			slc->data_start = 0;
+	}
+
+	return TRUE;
+
+failed:
+	headset_set_state(slc->device, HEADSET_STATE_DISCONNECTED);
+
+	return FALSE;
+}
+
+int telephony_event_ind(int index)
+{
+	if (!active_devices)
+		return -ENODEV;
+
+	if (!ag.er_ind) {
+		DBG("telephony_report_event called but events are disabled");
+		return -EINVAL;
+	}
+
+	send_foreach_headset(active_devices, hfp_cmp,
+				"\r\n+CIEV: %d,%d\r\n", index + 1,
+				ag.indicators[index].val);
+
+	return 0;
+}
+
+int telephony_response_and_hold_ind(int rh)
+{
+	if (!active_devices)
+		return -ENODEV;
+
+	ag.rh = rh;
+
+	/* If we aren't in any response and hold state don't send anything */
+	if (ag.rh < 0)
+		return 0;
+
+	send_foreach_headset(active_devices, hfp_cmp, "\r\n+BTRH: %d\r\n",
+				ag.rh);
+
+	return 0;
+}
+
+int telephony_incoming_call_ind(const char *number, int type)
+{
+	struct audio_device *dev;
+	struct headset *hs;
+	struct at_slc *slc;
+
+	if (fast_connectable)
+		manager_set_fast_connectable(TRUE);
+
+	if (!active_devices)
+		return -ENODEV;
+
+	/* Get the latest connected device */
+	dev = active_devices->data;
+	hs = dev->headset;
+	slc = headset_get_slc(dev);
+
+	if (ag.ring_timer) {
+		DBG("telephony_incoming_call_ind: already calling");
+		return -EBUSY;
+	}
+
+	/* With HSP 1.2 the RING messages should *not* be sent if inband
+	 * ringtone is being used */
+	if (!headset_get_hfp_active(slc->device) && slc->inband_ring)
+		return 0;
+
+	g_free(ag.number);
+	ag.number = g_strdup(number);
+	ag.number_type = type;
+
+	if (slc->inband_ring && headset_get_hfp_active(dev) &&
+			headset_get_state(dev) != HEADSET_STATE_PLAYING) {
+		slc->pending_ring = TRUE;
+		return 0;
+	}
+
+	ring_timer_cb(NULL);
+	ag.ring_timer = g_timeout_add_seconds(RING_INTERVAL, ring_timer_cb,
+						NULL);
+
+	return 0;
+}
+
+int telephony_calling_stopped_ind(void)
+{
+	struct audio_device *dev;
+	struct at_slc *slc;
+
+	if (fast_connectable)
+		manager_set_fast_connectable(FALSE);
+
+	if (ag.ring_timer) {
+		g_source_remove(ag.ring_timer);
+		ag.ring_timer = 0;
+	}
+
+	if (!active_devices)
+		return 0;
+
+	/* In case SCO isn't fully up yet */
+	dev = active_devices->data;
+	slc = headset_get_slc(dev);
+
+	if (!slc->pending_ring && !ag.ring_timer)
+		return -EINVAL;
+
+	slc->pending_ring = FALSE;
+
+	return 0;
+}
+
+int telephony_ready_ind(uint32_t features,
+			const struct indicator *indicators, int rh,
+			const char *chld)
+{
+	ag.telephony_ready = TRUE;
+	ag.features = features;
+	ag.indicators = indicators;
+	ag.rh = rh;
+	ag.chld = chld;
+
+	DBG("Telephony plugin initialized");
+
+	print_ag_features(ag.features);
+
+	return 0;
+}
+
+int telephony_deinit(void)
+{
+	g_free(ag.number);
+
+	memset(&ag, 0, sizeof(ag));
+
+	ag.er_mode = 3;
+	ag.rh = BTRH_NOT_SUPPORTED;
+
+	DBG("Telephony deinitialized");
+
+	return 0;
+}
+
+int telephony_list_current_call_ind(int idx, int dir, int status, int mode,
+					int mprty, const char *number,
+					int type)
+{
+	if (!active_devices)
+		return -ENODEV;
+
+	if (number && strlen(number) > 0)
+		send_foreach_headset(active_devices, hfp_cmp,
+				"\r\n+CLCC: %d,%d,%d,%d,%d,\"%s\",%d\r\n",
+				idx, dir, status, mode, mprty, number, type);
+	else
+		send_foreach_headset(active_devices, hfp_cmp,
+					"\r\n+CLCC: %d,%d,%d,%d,%d\r\n",
+					idx, dir, status, mode, mprty);
+
+	return 0;
+}
+
+int telephony_subscriber_number_ind(const char *number, int type, int service)
+{
+	if (!active_devices)
+		return -ENODEV;
+
+	send_foreach_headset(active_devices, hfp_cmp,
+				"\r\n+CNUM: ,%s,%d,,%d\r\n",
+				number, type, service);
+
+	return 0;
+}
+
+static int cwa_cmp(struct at_slc *slc)
+{
+	if (!headset_get_hfp_active(slc->device))
+		return -1;
+
+	if (slc->cwa_enabled)
+		return 0;
+	else
+		return -1;
+}
+
+int telephony_call_waiting_ind(const char *number, int type)
+{
+	if (!active_devices)
+		return -ENODEV;
+
+	send_foreach_headset(active_devices, cwa_cmp,
+				"\r\n+CCWA: \"%s\",%d\r\n",
+				number, type);
+
+	return 0;
+}
+
+void *telephony_device_connecting(GIOChannel *io, void *telephony_device)
+{
+	struct at_slc *slc;
+
+	slc = g_new0(struct at_slc, 1);
+	slc->sp_gain = 15;
+	slc->mic_gain = 15;
+	slc->nrec = TRUE;
+	slc->device = telephony_device;
+	slc->rfcomm = io;
+
+	g_io_add_watch(io, G_IO_IN | G_IO_ERR | G_IO_HUP | G_IO_NVAL,
+			(GIOFunc) io_cb, slc);
+
+	return slc;
+}
+
+void telephony_device_disconnect(void *slc)
+{
+	return;
+}
+
+void telephony_device_set_active(void *telephony_device, gboolean active)
+{
+	if (active)
+		active_devices = g_slist_append(active_devices,
+						telephony_device);
+	else
+		active_devices = g_slist_remove(active_devices,
+						telephony_device);
+}
+
+gboolean telephony_get_inband_ringtone(void *slc)
+{
+	struct at_slc *s = slc;
+
+	return s->inband_ring;
+}
+
+void telephony_set_inband_ringtone(void *slc, gboolean state)
+{
+	struct at_slc *s = slc;
+
+	s->inband_ring = state;
+}
+
+void telephony_start_ring(void *slc)
+{
+	struct at_slc *s = slc;
+
+	ring_timer_cb(NULL);
+	ag.ring_timer = g_timeout_add_seconds(RING_INTERVAL, ring_timer_cb,
+						NULL);
+	s->pending_ring = FALSE;
+}
+
+gboolean telephony_pending_ring(void *slc)
+{
+	struct at_slc *s = slc;
+
+	return s->pending_ring;
+}
+
+void telephony_stop_ring(void *slc)
+{
+	g_source_remove(ag.ring_timer);
+	ag.ring_timer = 0;
+}
+
+int telephony_get_speaker_gain(void *slc)
+{
+	struct at_slc *s = slc;
+
+	return s->sp_gain;
+}
+
+int telephony_get_mic_gain(void *slc)
+{
+	struct at_slc *s = slc;
+
+	return s->mic_gain;
+}
+
+int telephony_send_gain(void *slc, char type, uint16_t gain)
+{
+	return at_send(slc, "\r\n+VG%c=%u\r\n", type, gain);
+}
+
+int telephony_get_nrec(void *slc)
+{
+	struct at_slc *s = slc;
+
+	return s->nrec;
+}
+
+gboolean telephony_get_ready_state(void)
+{
+	return ag.telephony_ready;
+}
+
+gboolean telephony_is_ringing(void)
+{
+	return ag.ring_timer ? TRUE : FALSE;
+}
+
+uint32_t telephony_get_ag_features(void)
+{
+	return ag.features;
+}
+
+void telephony_set_fast_connectable(gboolean state)
+{
+	fast_connectable = state;
+}
diff --git a/audio/telephony-builtin.h b/audio/telephony-builtin.h
new file mode 100644
index 0000000..f8b2019
--- /dev/null
+++ b/audio/telephony-builtin.h
@@ -0,0 +1,218 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2011  Intel Corporation
+ *  Copyright (C) 2006-2010  Nokia Corporation
+ *  Copyright (C) 2004-2010  Marcel Holtmann <marcel@holtmann.org>
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
+#include <errno.h>
+
+#define HEADSET_GAIN_SPEAKER 'S'
+#define HEADSET_GAIN_MICROPHONE 'M'
+
+/* Response and hold values */
+#define BTRH_NOT_SUPPORTED	-2
+#define BTRH_NONE		-1
+#define BTRH_HOLD		0
+#define BTRH_ACCEPT		1
+#define BTRH_REJECT		2
+
+/* Indicator event values */
+#define EV_SERVICE_NONE			0
+#define EV_SERVICE_PRESENT		1
+
+#define EV_CALL_INACTIVE		0
+#define EV_CALL_ACTIVE			1
+
+#define EV_CALLSETUP_INACTIVE		0
+#define EV_CALLSETUP_INCOMING		1
+#define EV_CALLSETUP_OUTGOING		2
+#define EV_CALLSETUP_ALERTING		3
+
+#define EV_CALLHELD_NONE		0
+#define EV_CALLHELD_MULTIPLE		1
+#define EV_CALLHELD_ON_HOLD		2
+
+#define EV_ROAM_INACTIVE		0
+#define EV_ROAM_ACTIVE			1
+
+/* Call parameters */
+#define CALL_DIR_OUTGOING		0
+#define CALL_DIR_INCOMING		1
+
+#define CALL_STATUS_ACTIVE		0
+#define CALL_STATUS_HELD		1
+#define CALL_STATUS_DIALING		2
+#define CALL_STATUS_ALERTING		3
+#define CALL_STATUS_INCOMING		4
+#define CALL_STATUS_WAITING		5
+
+#define CALL_MODE_VOICE			0
+#define CALL_MODE_DATA			1
+#define CALL_MODE_FAX			2
+
+#define CALL_MULTIPARTY_NO		0
+#define CALL_MULTIPARTY_YES		1
+
+/* Subscriber number parameters */
+#define SUBSCRIBER_SERVICE_VOICE	4
+#define SUBSCRIBER_SERVICE_FAX		5
+
+/* Operator selection mode values */
+#define OPERATOR_MODE_AUTO		0
+#define OPERATOR_MODE_MANUAL		1
+#define OPERATOR_MODE_DEREGISTER	2
+#define OPERATOR_MODE_MANUAL_AUTO	4
+
+/* Some common number types */
+#define NUMBER_TYPE_UNKNOWN		128
+#define NUMBER_TYPE_TELEPHONY		129
+#define NUMBER_TYPE_INTERNATIONAL	145
+#define NUMBER_TYPE_NATIONAL		161
+#define NUMBER_TYPE_VOIP		255
+
+/* Extended Audio Gateway Error Result Codes */
+typedef enum {
+	CME_ERROR_NONE			= -1,
+	CME_ERROR_AG_FAILURE		= 0,
+	CME_ERROR_NO_PHONE_CONNECTION	= 1,
+	CME_ERROR_NOT_ALLOWED		= 3,
+	CME_ERROR_NOT_SUPPORTED		= 4,
+	CME_ERROR_PH_SIM_PIN_REQUIRED	= 5,
+	CME_ERROR_SIM_NOT_INSERTED	= 10,
+	CME_ERROR_SIM_PIN_REQUIRED	= 11,
+	CME_ERROR_SIM_PUK_REQUIRED	= 12,
+	CME_ERROR_SIM_FAILURE		= 13,
+	CME_ERROR_SIM_BUSY		= 14,
+	CME_ERROR_INCORRECT_PASSWORD	= 16,
+	CME_ERROR_SIM_PIN2_REQUIRED	= 17,
+	CME_ERROR_SIM_PUK2_REQUIRED	= 18,
+	CME_ERROR_MEMORY_FULL		= 20,
+	CME_ERROR_INVALID_INDEX		= 21,
+	CME_ERROR_MEMORY_FAILURE	= 23,
+	CME_ERROR_TEXT_STRING_TOO_LONG	= 24,
+	CME_ERROR_INVALID_TEXT_STRING	= 25,
+	CME_ERROR_DIAL_STRING_TOO_LONG	= 26,
+	CME_ERROR_INVALID_DIAL_STRING	= 27,
+	CME_ERROR_NO_NETWORK_SERVICE	= 30,
+	CME_ERROR_NETWORK_TIMEOUT	= 31,
+	CME_ERROR_NETWORK_NOT_ALLOWED	= 32,
+} cme_error_t;
+
+struct indicator {
+	const char *desc;
+	const char *range;
+	int val;
+	gboolean ignore_redundant;
+};
+
+/* HF requests (sent by the handsfree device). These are implemented by
+ * telephony-*.c
+ */
+void telephony_event_reporting_req(void *telephony_device, int ind);
+void telephony_response_and_hold_req(void *telephony_device, int rh);
+void telephony_last_dialed_number_req(void *telephony_device);
+void telephony_terminate_call_req(void *telephony_device);
+void telephony_answer_call_req(void *telephony_device);
+void telephony_dial_number_req(void *telephony_device, const char *number);
+void telephony_transmit_dtmf_req(void *telephony_device, char tone);
+void telephony_subscriber_number_req(void *telephony_device);
+void telephony_list_current_calls_req(void *telephony_device);
+void telephony_operator_selection_req(void *telephony_device);
+void telephony_call_hold_req(void *telephony_device, const char *cmd);
+void telephony_nr_and_ec_req(void *telephony_device, gboolean enable);
+void telephony_voice_dial_req(void *telephony_device, gboolean enable);
+void telephony_key_press_req(void *telephony_device, const char *keys);
+
+/* AG responses to HF requests. These are implemented by telephony-builtin.c */
+int telephony_event_reporting_rsp(void *telephony_device, cme_error_t err);
+int telephony_response_and_hold_rsp(void *telephony_device, cme_error_t err);
+int telephony_last_dialed_number_rsp(void *telephony_device, cme_error_t err);
+int telephony_terminate_call_rsp(void *telephony_device, cme_error_t err);
+int telephony_answer_call_rsp(void *telephony_device, cme_error_t err);
+int telephony_dial_number_rsp(void *telephony_device, cme_error_t err);
+int telephony_transmit_dtmf_rsp(void *telephony_device, cme_error_t err);
+int telephony_subscriber_number_rsp(void *telephony_device, cme_error_t err);
+int telephony_list_current_calls_rsp(void *telephony_device, cme_error_t err);
+int telephony_operator_selection_rsp(void *telephony_device, cme_error_t err);
+int telephony_call_hold_rsp(void *telephony_device, cme_error_t err);
+int telephony_nr_and_ec_rsp(void *telephony_device, cme_error_t err);
+int telephony_voice_dial_rsp(void *telephony_device, cme_error_t err);
+int telephony_key_press_rsp(void *telephony_device, cme_error_t err);
+
+/* Event indications by AG. These are implemented by telephony-builtin */
+int telephony_event_ind(int index);
+int telephony_response_and_hold_ind(int rh);
+int telephony_incoming_call_ind(const char *number, int type);
+int telephony_calling_stopped_ind(void);
+int telephony_ready_ind(uint32_t features, const struct indicator *indicators,
+			int rh, const char *chld);
+int telephony_deinit(void);
+int telephony_list_current_call_ind(int idx, int dir, int status, int mode,
+					int mprty, const char *number,
+					int type);
+int telephony_subscriber_number_ind(const char *number, int type,
+					int service);
+int telephony_call_waiting_ind(const char *number, int type);
+int telephony_operator_selection_ind(int mode, const char *oper);
+
+/* Helper function for quick indicator updates */
+static inline int telephony_update_indicator(struct indicator *indicators,
+						const char *desc,
+						int new_val)
+{
+	int i;
+	struct indicator *ind = NULL;
+
+	for (i = 0; indicators[i].desc != NULL; i++) {
+		if (g_str_equal(indicators[i].desc, desc)) {
+			ind = &indicators[i];
+			break;
+		}
+	}
+
+	if (!ind)
+		return -ENOENT;
+
+	DBG("Telephony indicator \"%s\" %d->%d", desc, ind->val, new_val);
+
+	if (ind->ignore_redundant && ind->val == new_val) {
+		DBG("Ignoring no-change indication");
+		return 0;
+	}
+
+	ind->val = new_val;
+
+	return telephony_event_ind(i);
+}
+
+static inline int telephony_get_indicator(const struct indicator *indicators,
+						const char *desc)
+{
+	int i;
+
+	for (i = 0; indicators[i].desc != NULL; i++) {
+		if (g_str_equal(indicators[i].desc, desc))
+			return indicators[i].val;
+	}
+
+	return -ENOENT;
+}
diff --git a/audio/telephony-dummy.c b/audio/telephony-dummy.c
index 1f89079..657e2d3 100644
--- a/audio/telephony-dummy.c
+++ b/audio/telephony-dummy.c
@@ -35,6 +35,7 @@
 
 #include "log.h"
 #include "telephony.h"
+#include "telephony-builtin.h"
 #include "error.h"
 
 #define TELEPHONY_DUMMY_IFACE "org.bluez.TelephonyTest"
diff --git a/audio/telephony-maemo5.c b/audio/telephony-maemo5.c
index 23801c0..51c0985 100644
--- a/audio/telephony-maemo5.c
+++ b/audio/telephony-maemo5.c
@@ -38,6 +38,7 @@
 
 #include "log.h"
 #include "telephony.h"
+#include "telephony-builtin.h"
 #include "error.h"
 
 /* SSC D-Bus definitions */
diff --git a/audio/telephony-maemo6.c b/audio/telephony-maemo6.c
index 5df3235..cd6856d 100644
--- a/audio/telephony-maemo6.c
+++ b/audio/telephony-maemo6.c
@@ -41,6 +41,7 @@
 #include "glib-compat.h"
 #include "log.h"
 #include "telephony.h"
+#include "telephony-builtin.h"
 #include "error.h"
 
 /* SSC D-Bus definitions */
diff --git a/audio/telephony-ofono.c b/audio/telephony-ofono.c
index 3607d7f..4cb4aa5 100644
--- a/audio/telephony-ofono.c
+++ b/audio/telephony-ofono.c
@@ -40,6 +40,7 @@
 #include "glib-compat.h"
 #include "log.h"
 #include "telephony.h"
+#include "telephony-builtin.h"
 
 enum net_registration_status {
 	NETWORK_REG_STATUS_HOME = 0x00,
diff --git a/audio/telephony.h b/audio/telephony.h
index 73b390c..8043267 100644
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
@@ -52,193 +45,29 @@
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
 /* Notify telephony-*.c of connected/disconnected devices. Implemented by
  * telephony-*.c
  */
+void *telephony_device_connecting(GIOChannel *io, void *telephony_device);
 void telephony_device_connected(void *telephony_device);
+void telephony_device_disconnect(void *slc);
 void telephony_device_disconnected(void *telephony_device);
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
+void telephony_device_set_active(void *telephony_device, gboolean active);
+
+gboolean telephony_get_ready_state(void);
+gboolean telephony_pending_ring(void *slc);
+void telephony_start_ring(void *slc);
+void telephony_stop_ring(void *slc);
+gboolean telephony_is_ringing(void);
+uint32_t telephony_get_ag_features(void);
+void telephony_set_fast_connectable(gboolean state);
+gboolean telephony_get_nrec(void *slc);
+gboolean telephony_get_inband_ringtone(void *slc);
+void telephony_set_inband_ringtone(void *slc, gboolean state);
+int telephony_get_speaker_gain(void *slc);
+int telephony_get_mic_gain(void *slc);
+int telephony_send_gain(void *slc, char type, uint16_t gain);
+int telephony_set_gain(void *slc, uint16_t gain, char type);
 
 int telephony_init(void);
 void telephony_exit(void);
-- 
1.7.1

