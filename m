Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?=
	<frederic.danis@linux.intel.com>
To: linux-bluetooth@vger.kernel.org, frederic.danis@linux.intel.com
Subject: [RFC v2 1/4] audio: Move tel drivers to DBus interface
Date: Thu,  1 Dec 2011 15:16:27 +0100
Message-Id: <1322748990-14347-2-git-send-email-frederic.danis@linux.intel.com>
In-Reply-To: <1322748990-14347-1-git-send-email-frederic.danis@linux.intel.com>
References: <1322748990-14347-1-git-send-email-frederic.danis@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 Makefile.am              |   13 +-
 audio/headset.c          |  614 ++--------------------------------------------
 audio/headset.h          |    2 +
 audio/manager.c          |    4 +-
 audio/telephony.c        |  529 +++++++++++++++++++++++++++++++++++++++
 audio/telephony.h        |   25 +--
 doc/assigned-numbers.txt |    1 +
 doc/audio-api.txt        |   91 +++++++
 8 files changed, 648 insertions(+), 631 deletions(-)
 create mode 100644 audio/telephony.c

diff --git a/Makefile.am b/Makefile.am
index 07b8626..31c1083 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -154,14 +154,8 @@ builtin_sources += audio/main.c \
 			audio/unix.h audio/unix.c \
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
@@ -476,9 +470,6 @@ MAINTAINERCLEANFILES = Makefile.in \
 src/builtin.h: src/genbuiltin $(builtin_sources)
 	$(AM_V_GEN)$(srcdir)/src/genbuiltin $(builtin_modules) > $@
 
-audio/telephony.c: audio/@TELEPHONY_DRIVER@
-	$(AM_V_GEN)$(LN_S) $(abs_top_srcdir)/$< $@
-
 sap/sap.c: sap/@SAP_DRIVER@
 	$(AM_V_GEN)$(LN_S) $(abs_top_srcdir)/$< $@
 
diff --git a/audio/headset.c b/audio/headset.c
index 6aef6a8..74eb7a4 100644
--- a/audio/headset.c
+++ b/audio/headset.c
@@ -70,8 +70,6 @@
 #define HEADSET_GAIN_MICROPHONE 'M'
 
 static struct {
-	gboolean telephony_ready;	/* Telephony plugin initialized */
-	uint32_t features;		/* HFP AG features */
 	const struct indicator *indicators;	/* Available HFP indicators */
 	int er_mode;			/* Event reporting mode */
 	int er_ind;			/* Event reporting for indicators */
@@ -81,8 +79,6 @@ static struct {
 	guint ring_timer;		/* For incoming call indication */
 	const char *chld;		/* Response to AT+CHLD=? */
 } ag = {
-	.telephony_ready = FALSE,
-	.features = 0,
 	.er_mode = 3,
 	.er_ind = 0,
 	.rh = BTRH_NOT_SUPPORTED,
@@ -236,40 +232,6 @@ static void print_ag_features(uint32_t features)
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
@@ -333,97 +295,6 @@ static int __attribute__((format(printf, 2, 3)))
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
@@ -656,7 +527,7 @@ static int hfp_cmp(struct headset *hs)
 		return -1;
 }
 
-static void hfp_slc_complete(struct audio_device *dev)
+void headset_slc_complete(struct audio_device *dev)
 {
 	struct headset *hs = dev->headset;
 	struct pending_connect *p = hs->pending;
@@ -721,73 +592,10 @@ int telephony_event_reporting_rsp(void *telephony_device, cme_error_t err)
 		return 0;
 
 	if (slc->hf_features & HF_FEATURE_CALL_WAITING_AND_3WAY &&
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
+			telephony_get_ag_features() & AG_FEATURE_THREE_WAY_CALLING)
 		return 0;
-	}
 
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
+	headset_slc_complete(device);
 
 	return 0;
 }
@@ -797,47 +605,11 @@ int telephony_key_press_rsp(void *telephony_device, cme_error_t err)
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
@@ -854,99 +626,21 @@ int telephony_terminate_call_rsp(void *telephony_device,
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
@@ -994,111 +688,21 @@ static int headset_set_gain(struct audio_device *device, uint16_t gain, char typ
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
@@ -1146,108 +750,6 @@ int telephony_operator_selection_ind(int mode, const char *oper)
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
@@ -1266,94 +768,6 @@ static void close_sco(struct audio_device *device)
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
@@ -1381,7 +795,7 @@ void headset_connect_cb(GIOChannel *chan, GError *err, gpointer user_data)
 	}
 
 	/* For HFP telephony isn't ready just disconnect */
-	if (hs->hfp_active && !ag.telephony_ready) {
+	if (hs->hfp_active && !telephony_get_ready_state()) {
 		error("Unable to accept HFP connection since the telephony "
 				"subsystem isn't initialized");
 		goto failed;
@@ -1397,8 +811,7 @@ void headset_connect_cb(GIOChannel *chan, GError *err, gpointer user_data)
 	else
 		hs->auto_dc = FALSE;
 
-	g_io_add_watch(chan, G_IO_IN | G_IO_ERR | G_IO_HUP| G_IO_NVAL,
-			(GIOFunc) rfcomm_io_cb, dev);
+	hs->slc = telephony_device_connecting(chan, dev);
 
 	DBG("%s: Connected to %s", dev->path, hs_address);
 
@@ -1740,7 +1153,7 @@ static DBusMessage *hs_connect(DBusConnection *conn, DBusMessage *msg,
 	else if (hs->state > HEADSET_STATE_CONNECTING)
 		return btd_error_already_connected(msg);
 
-	if (hs->hfp_handle && !ag.telephony_ready)
+	if (hs->hfp_handle && !telephony_get_ready_state())
 		return btd_error_not_ready(msg);
 
 	device->auto_connect = FALSE;
@@ -2245,7 +1658,7 @@ uint32_t headset_config_init(GKeyFile *config)
 
 	/* Use the default values if there is no config file */
 	if (config == NULL)
-		return ag.features;
+		return telephony_get_ag_features();
 
 	str = g_key_file_get_string(config, "General", "SCORouting",
 					&err);
@@ -2275,7 +1688,7 @@ uint32_t headset_config_init(GKeyFile *config)
 		g_free(str);
 	}
 
-	return ag.features;
+	return telephony_get_ag_features();
 }
 
 static gboolean hs_dc_timeout(struct audio_device *dev)
@@ -2518,6 +1931,10 @@ void headset_set_state(struct audio_device *dev, headset_state_t state)
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
@@ -2546,7 +1963,8 @@ void headset_set_state(struct audio_device *dev, headset_state_t state)
 					AUDIO_HEADSET_INTERFACE, "State",
 					DBUS_TYPE_STRING, &state_str);
 		if (hs->state < state) {
-			if (ag.features & AG_FEATURE_INBAND_RINGTONE)
+			if (telephony_get_ag_features() &
+					AG_FEATURE_INBAND_RINGTONE)
 				slc->inband_ring = TRUE;
 			else
 				slc->inband_ring = FALSE;
@@ -2880,15 +2298,13 @@ int telephony_ready_ind(uint32_t features,
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
index 99eeca8..d43952f 100644
--- a/audio/headset.h
+++ b/audio/headset.h
@@ -111,3 +111,5 @@ gboolean headset_unlock(struct audio_device *dev, headset_lock_t lock);
 gboolean headset_suspend(struct audio_device *dev, void *data);
 gboolean headset_play(struct audio_device *dev, void *data);
 void headset_shutdown(struct audio_device *dev);
+
+void headset_slc_complete(struct audio_device *dev);
diff --git a/audio/manager.c b/audio/manager.c
index 8de5515..4624552 100644
--- a/audio/manager.c
+++ b/audio/manager.c
@@ -880,7 +880,7 @@ static void state_changed(struct btd_adapter *adapter, gboolean powered)
 		/* telephony driver already initialized*/
 		if (telephony == TRUE)
 			return;
-		telephony_init();
+		telephony_init(adapter);
 		telephony = TRUE;
 		return;
 	}
@@ -896,7 +896,7 @@ static void state_changed(struct btd_adapter *adapter, gboolean powered)
 			return;
 	}
 
-	telephony_exit();
+	telephony_exit(adapter);
 	telephony = FALSE;
 }
 
diff --git a/audio/telephony.c b/audio/telephony.c
new file mode 100644
index 0000000..4aa3892
--- /dev/null
+++ b/audio/telephony.c
@@ -0,0 +1,529 @@
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
+
+#include "btio.h"
+#include "log.h"
+#include "device.h"
+#include "error.h"
+#include "glib-helper.h"
+#include "sdp-client.h"
+#include "headset.h"
+#include "telephony.h"
+#include "dbus-common.h"
+#include "../src/adapter.h"
+#include "../src/device.h"
+
+#define AUDIO_TELEPHONY_INTERFACE "org.bluez.Telephony"
+
+#define DEFAULT_HS_HS_CHANNEL 6
+#define DEFAULT_HF_HS_CHANNEL 7
+
+struct telsrv {
+	GSList *servers;	/* server list */
+};
+
+struct tel_device {
+	struct tel_agent	*agent;
+	struct audio_device	*au_dev;
+	GIOChannel		*rfcomm;
+	uint16_t		version;
+	uint16_t		features;
+};
+
+struct default_agent {
+	char			*uuid;		/* agent property UUID */
+	uint8_t			channel;
+	const char		*r_uuid;
+	uint16_t		r_class;
+	uint16_t		r_profile;
+};
+
+struct tel_agent {
+	char			*name;		/* agent DBus bus id */
+	char			*path;		/* agent object path */
+	uint16_t		version;
+	uint16_t		features;
+	struct default_agent	*properties;
+};
+
+static DBusConnection *connection = NULL;
+
+struct telsrv telsrv;
+
+static void free_agent(struct tel_agent *agent)
+{
+	if (agent->name)
+		g_free(agent->name);
+
+	if (agent->path)
+		g_free(agent->path);
+
+	g_free(agent);
+}
+
+static struct tel_agent *find_agent(const char *sender, const char *path,
+						const char *uuid)
+{
+	GSList *l;
+
+	for (l = telsrv.servers; l; l = l->next) {
+		struct tel_agent *agent = l->data;
+
+		if (sender && g_strcmp0(agent->name, sender) != 0)
+			continue;
+
+		if (path && g_strcmp0(agent->path, path) != 0)
+			continue;
+
+		if (uuid && g_strcmp0(agent->properties->uuid, uuid) != 0)
+			continue;
+
+		return agent;
+	}
+
+	return NULL;
+}
+
+static int parse_properties(DBusMessageIter *props, const char **uuid,
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
+				return -EINVAL;
+			dbus_message_iter_get_basic(&value, uuid);
+			has_uuid = TRUE;
+		} else if (strcasecmp(key, "Version") == 0) {
+			if (var != DBUS_TYPE_UINT16)
+				return -EINVAL;
+			dbus_message_iter_get_basic(&value, version);
+		} else if (strcasecmp(key, "Features") == 0) {
+			if (var != DBUS_TYPE_UINT16)
+				return -EINVAL;
+			dbus_message_iter_get_basic(&value, features);
+		}
+
+		dbus_message_iter_next(props);
+	}
+
+	return (has_uuid) ? 0 : -EINVAL;
+}
+
+static int dev_close(struct tel_device *dev)
+{
+	int sock;
+
+	if (dev->rfcomm) {
+		sock = g_io_channel_unix_get_fd(dev->rfcomm);
+		shutdown(sock, SHUT_RDWR);
+	}
+
+	return 0;
+}
+
+static gboolean agent_sendfd(struct tel_device *dev, int fd,
+				DBusPendingCallNotifyFunction notify)
+{
+	struct tel_agent *agent = dev->agent;
+	DBusMessage *msg;
+	DBusMessageIter iter, dict;
+	char *str;
+	DBusPendingCall *call;
+
+	msg = dbus_message_new_method_call(agent->name, agent->path,
+			"org.bluez.TelephonyAgent", "NewConnection");
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
+	str = g_strdup(agent->properties->uuid);
+	dict_append_entry(&dict, "UUID", DBUS_TYPE_STRING, &str);
+	g_free(str);
+
+	dict_append_entry(&dict, "Version", DBUS_TYPE_UINT16, &dev->version);
+
+	if (dev->features != 0xFFFF)
+		dict_append_entry(&dict, "Features", DBUS_TYPE_UINT16,
+							&dev->features);
+
+	dbus_message_iter_close_container(&iter, &dict);
+
+	if (dbus_connection_send_with_reply(connection, msg, &call, -1) == FALSE)
+		return FALSE;
+
+	dbus_pending_call_set_notify(call, notify, dev, NULL);
+	dbus_pending_call_unref(call);
+	dbus_message_unref(msg);
+
+	return TRUE;
+}
+
+static gboolean agent_disconnect_cb(GIOChannel *chan, GIOCondition cond,
+						struct tel_device *dev)
+{
+	if (cond & G_IO_NVAL)
+		return FALSE;
+
+	headset_set_state(dev->au_dev, HEADSET_STATE_DISCONNECTED);
+
+	return FALSE;
+}
+
+static void newconnection_reply(DBusPendingCall *call, void *user_data)
+{
+	struct tel_device *dev = user_data;
+	DBusMessage *reply = dbus_pending_call_steal_reply(call);
+	DBusError derr;
+
+	if (!dev->rfcomm) {
+		DBG("RFCOMM disconnected from server before agent reply");
+		goto done;
+	}
+
+	dbus_error_init(&derr);
+	if (!dbus_set_error_from_message(&derr, reply)) {
+		DBG("Agent reply: file descriptor passed successfully");
+		g_io_add_watch(dev->rfcomm, G_IO_ERR | G_IO_HUP | G_IO_NVAL,
+					(GIOFunc) agent_disconnect_cb, dev);
+		headset_slc_complete(dev->au_dev);
+		goto done;
+	}
+
+	DBG("Agent reply: %s", derr.message);
+
+	dbus_error_free(&derr);
+	dev_close(dev);
+	headset_set_state(dev->au_dev, HEADSET_STATE_DISCONNECTED);
+
+done:
+	dbus_message_unref(reply);
+}
+
+static void get_record_cb(sdp_list_t *recs, int err, gpointer user_data)
+{
+	struct tel_device *dev = user_data;
+	sdp_data_t *sdpdata;
+	uuid_t uuid;
+	sdp_list_t *profiles;
+	sdp_profile_desc_t *desc;
+	int sk, ret;
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
+	sdpdata = sdp_data_get(recs->data, SDP_ATTR_SUPPORTED_FEATURES);
+	if (sdpdata && sdpdata->dtd == SDP_UINT16)
+		dev->features = sdpdata->val.uint16;
+
+	sdp_uuid16_create(&uuid, dev->agent->properties->r_profile);
+
+	sdp_get_profile_descs(recs->data, &profiles);
+	if (profiles == NULL)
+		goto failed;
+
+	desc = profiles->data;
+
+	if (sdp_uuid16_cmp(&desc->uuid, &uuid) == 0)
+		dev->version = desc->version;
+
+	sdp_list_free(profiles, free);
+
+	sk = g_io_channel_unix_get_fd(dev->rfcomm);
+
+	ret = agent_sendfd(dev, sk, newconnection_reply);
+
+	return;
+
+failed:
+	headset_set_state(dev->au_dev, HEADSET_STATE_DISCONNECTED);
+}
+
+void *telephony_device_connecting(GIOChannel *io, void *telephony_device)
+{
+	struct audio_device *device = telephony_device;
+	struct tel_device *dev;
+	const char *agent_uuid;
+	struct tel_agent *agent;
+	uuid_t uuid;
+	int err;
+
+	/*TODO: check for HS roles */
+	if (headset_get_hfp_active(device))
+		agent_uuid = HFP_AG_UUID;
+	else
+		agent_uuid = HSP_AG_UUID;
+
+	agent = find_agent(NULL, NULL, agent_uuid);
+	if (agent == NULL) {
+		error("No agent registered for %s", agent_uuid);
+		return NULL;
+	}
+
+	dev = g_new0(struct tel_device, 1);
+	dev->agent = agent;
+	dev->au_dev = telephony_device;
+	dev->rfcomm = io;
+	dev->features = 0xFFFF;
+
+	sdp_uuid16_create(&uuid, agent->properties->r_class);
+
+	err = bt_search_service(&device->src, &device->dst, &uuid,
+						get_record_cb, dev, NULL);
+	if (err < 0) {
+		g_free(dev);
+		return NULL;
+	}
+
+	return dev;
+}
+
+void telephony_device_connected(void *telephony_device)
+{
+	DBG("telephony-dbus: device %p connected", telephony_device);
+}
+
+void telephony_device_disconnect(void *slc)
+{
+	struct tel_device *dev = slc;
+
+	dev_close(dev);
+}
+
+void telephony_device_disconnected(void *telephony_device)
+{
+	DBG("telephony-dbus: device %p disconnected", telephony_device);
+}
+
+gboolean telephony_get_ready_state(void)
+{
+	return find_agent(NULL, NULL, HFP_AG_UUID) ? TRUE : FALSE;
+}
+
+uint32_t telephony_get_ag_features(void)
+{
+	return 0;
+}
+
+static struct default_agent default_properties[] = {
+	{HSP_HS_UUID,
+		DEFAULT_HS_HS_CHANNEL,
+		HSP_AG_UUID,
+		HEADSET_AGW_SVCLASS_ID,
+		HEADSET_PROFILE_ID},
+	{HSP_AG_UUID,
+		DEFAULT_HS_AG_CHANNEL,
+		HSP_HS_UUID,
+		HEADSET_SVCLASS_ID,
+		HEADSET_PROFILE_ID},
+	{HFP_HS_UUID,
+		DEFAULT_HF_HS_CHANNEL,
+		HFP_AG_UUID,
+		HANDSFREE_AGW_SVCLASS_ID,
+		HANDSFREE_PROFILE_ID},
+	{HFP_AG_UUID,
+		DEFAULT_HF_AG_CHANNEL,
+		HFP_HS_UUID,
+		HANDSFREE_SVCLASS_ID,
+		HANDSFREE_PROFILE_ID}
+};
+
+static DBusMessage *register_agent(DBusConnection *conn,
+					DBusMessage *msg, void *data)
+{
+	DBusMessageIter args, props;
+	const char *sender, *path, *uuid;
+	uint16_t version = 0;
+	uint16_t features = 0xFFFF;
+	struct tel_agent *agent;
+	int i;
+
+	sender = dbus_message_get_sender(msg);
+
+	dbus_message_iter_init(msg, &args);
+
+	dbus_message_iter_get_basic(&args, &path);
+	dbus_message_iter_next(&args);
+
+	if (find_agent(sender, path, NULL) != NULL)
+		return btd_error_already_exists(msg);
+
+	dbus_message_iter_recurse(&args, &props);
+	if (dbus_message_iter_get_arg_type(&props) != DBUS_TYPE_DICT_ENTRY)
+		return btd_error_invalid_args(msg);
+
+	if (parse_properties(&props, &uuid, &version, &features) < 0)
+		return btd_error_invalid_args(msg);
+
+	if (find_agent(NULL, NULL, uuid) != NULL)
+		return btd_error_already_exists(msg);
+
+	/* initialize agent properties */
+	for (i=0 ; i<4; i++) {
+		if (strcasecmp(uuid, default_properties[i].uuid) == 0) {
+			agent = g_new0(struct tel_agent, 1);
+			agent->properties = &default_properties[i];
+			agent->name = g_strdup(sender);
+			agent->path = g_strdup(path);
+			agent->version = version;
+			agent->features = features;
+			break;
+		}
+	}
+
+	if (i == 4)
+		return btd_error_invalid_args(msg);
+
+	DBG("Register agent : %s%s for %s version 0x%04X with features 0x%02X",
+					sender, path, uuid, version, features);
+
+	telsrv.servers = g_slist_append(telsrv.servers, agent);
+
+	return g_dbus_create_reply(msg, DBUS_TYPE_INVALID);
+}
+
+static DBusMessage *unregister_agent(DBusConnection *conn,
+				DBusMessage *msg, void *data)
+{
+	const char *sender, *path;
+	struct tel_agent *agent;
+
+	if (!dbus_message_get_args(msg, NULL,
+				DBUS_TYPE_OBJECT_PATH, &path,
+				DBUS_TYPE_INVALID))
+		return NULL;
+
+	sender = dbus_message_get_sender(msg);
+
+	agent = find_agent(sender, path, NULL);
+	if (agent == NULL)
+		return btd_error_does_not_exist(msg);
+
+	telsrv.servers = g_slist_remove(telsrv.servers, agent);
+
+	DBG("Unregister agent : %s%s", sender, path);
+
+	free_agent(agent);
+
+	return g_dbus_create_reply(msg, DBUS_TYPE_INVALID);
+}
+
+static GDBusMethodTable telsrv_methods[] = {
+	{ "RegisterAgent", "oa{sv}", "", register_agent },
+	{ "UnregisterAgent", "o", "", unregister_agent },
+	{ NULL, NULL, NULL, NULL }
+};
+
+static void path_unregister(void *data)
+{
+	DBG("Unregistered interface %s", AUDIO_TELEPHONY_INTERFACE);
+}
+
+static int register_interface(void *adapter)
+{
+	const char *path;
+
+	if (DBUS_TYPE_UNIX_FD < 0)
+		return -1;
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
+static void unregister_interface(void *adapter)
+{
+	g_dbus_unregister_interface(connection, adapter_get_path(adapter),
+			AUDIO_TELEPHONY_INTERFACE);
+}
+
+int telephony_init(void *adapter)
+{
+	DBG("");
+
+	connection = dbus_bus_get(DBUS_BUS_SYSTEM, NULL);
+
+	return register_interface(adapter);
+}
+
+void telephony_exit(void *adapter)
+{
+	DBG("");
+
+	unregister_interface(adapter);
+
+	dbus_connection_unref(connection);
+	connection = NULL;
+}
diff --git a/audio/telephony.h b/audio/telephony.h
index 73b390c..7d1d337 100644
--- a/audio/telephony.h
+++ b/audio/telephony.h
@@ -144,26 +144,13 @@ struct indicator {
 /* Notify telephony-*.c of connected/disconnected devices. Implemented by
  * telephony-*.c
  */
+void *telephony_device_connecting(GIOChannel *io, void *telephony_device);
 void telephony_device_connected(void *telephony_device);
+void telephony_device_disconnect(void *slc);
 void telephony_device_disconnected(void *telephony_device);
 
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
+gboolean telephony_get_ready_state(void);
+uint32_t telephony_get_ag_features(void);
 
 /* AG responses to HF requests. These are implemented by headset.c */
 int telephony_event_reporting_rsp(void *telephony_device, cme_error_t err);
@@ -240,5 +227,5 @@ static inline int telephony_get_indicator(const struct indicator *indicators,
 	return -ENOENT;
 }
 
-int telephony_init(void);
-void telephony_exit(void);
+int telephony_init(void *adapter);
+void telephony_exit(void *adapter);
diff --git a/doc/assigned-numbers.txt b/doc/assigned-numbers.txt
index cda934c..120d7ea 100644
--- a/doc/assigned-numbers.txt
+++ b/doc/assigned-numbers.txt
@@ -8,6 +8,7 @@ avoid conflicts.
 Profile		Channel
 -----------------------
 DUN		1
+HSP HS		6
 HFP HF		7
 OPP		9
 FTP		10
diff --git a/doc/audio-api.txt b/doc/audio-api.txt
index b85400b..73d87cc 100644
--- a/doc/audio-api.txt
+++ b/doc/audio-api.txt
@@ -456,3 +456,94 @@ properties	boolean Connected [readonly]
 		uint16 MicrophoneGain  [readonly]
 
 			The speaker gain when available.
+
+
+Telephony hierarchy [experiemental]
+===================
+
+Service		org.bluez
+Interface	org.bluez.Telephony
+Object path	[variable prefix]/{hci0,hci1,...}
+
+Methods		void RegisterAgent(object path, dict properties)
+
+			Register a TelephonyAgent to sender, the sender can
+			register as many agents as it likes.
+
+			Note: If the sender disconnects its agents are
+			automatically unregistered.
+
+			possible properties:
+
+				string UUID:
+
+					UUID of the profile which the agent is
+					for.
+
+				uint16 Version:
+
+					Version of the profile which the agent
+					implements.
+
+				uint16 Features:
+
+					Agent supported features as defined in
+					profile spec e.g. HFP.
+
+			Possible Errors: org.bluez.Error.InvalidArguments
+
+
+		void UnregisterAgent(object path)
+
+			Unregister sender agent.
+
+TelephonyAgent hierarchy
+========================
+
+Service		unique name
+Interface	org.bluez.TelephonyAgent
+Object path	freely definable
+
+Methods		void NewConnection(filedescriptor fd, dict properties)
+
+			This method gets called whenever a new connection
+			has been established. This method assumes that DBus
+			daemon with file descriptor passing capability is
+			being used.
+
+			The agent should only return successfully once the
+			establishment of the service level connection (SLC)
+			has been completed.  In the case of Handsfree this
+			means that BRSF exchange has been performed and
+			necessary initialization has been done.
+
+			possible properties:
+
+				strict Device:
+
+					BlueZ remote device object.
+
+				string UUID:
+
+					Profile UUID of the connection.
+
+				uint16 Version:
+
+					Remote profile version.
+
+				uint16 Features:
+
+					Remote profile features.
+
+				string MediaTransportPath:
+
+					Optional. MediaTransport object path.
+
+			Possible Errors: org.bluez.Error.InvalidArguments
+					 org.bluez.Error.Failed
+
+		void Release()
+
+			This method gets called whenever the service daemon
+			unregisters the agent or whenever the Adapter where
+			the TelephonyAgent registers itself is removed.
-- 
1.7.1

