Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?=
	<frederic.danis@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC v3 2/6] audio: Remove tel drivers
Date: Thu,  1 Dec 2011 16:14:01 +0100
Message-Id: <1322752445-18771-3-git-send-email-frederic.danis@linux.intel.com>
In-Reply-To: <1322752445-18771-1-git-send-email-frederic.danis@linux.intel.com>
References: <1322752445-18771-1-git-send-email-frederic.danis@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 Makefile.am             |    4 +-
 audio/headset.c         |  913 +--------------------------
 audio/headset.h         |    5 -
 audio/telephony-dummy.c |  433 -------------
 audio/telephony-ofono.c | 1638 -----------------------------------------------
 audio/telephony.h       |  171 -----
 audio/transport.c       |   10 +
 audio/unix.c            |    2 +
 8 files changed, 16 insertions(+), 3160 deletions(-)
 delete mode 100644 audio/telephony-dummy.c
 delete mode 100644 audio/telephony-ofono.c

diff --git a/Makefile.am b/Makefile.am
index 31c1083..9a29eb1 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -335,9 +335,7 @@ endif
 EXTRA_DIST += src/genbuiltin src/bluetooth.conf \
 			src/main.conf network/network.conf \
 			input/input.conf serial/serial.conf \
-			audio/audio.conf audio/telephony-dummy.c \
-			audio/telephony-maemo5.c audio/telephony-ofono.c \
-			audio/telephony-maemo6.c sap/sap-dummy.c sap/sap-u8500.c \
+			audio/audio.conf sap/sap-dummy.c sap/sap-u8500.c \
 			proximity/proximity.conf
 
 if ALSA
diff --git a/audio/headset.c b/audio/headset.c
index 74eb7a4..028df16 100644
--- a/audio/headset.c
+++ b/audio/headset.c
@@ -62,35 +62,7 @@
 
 #define DC_TIMEOUT 3
 
-#define RING_INTERVAL 3
-
-#define BUF_SIZE 1024
-
-#define HEADSET_GAIN_SPEAKER 'S'
-#define HEADSET_GAIN_MICROPHONE 'M'
-
-static struct {
-	const struct indicator *indicators;	/* Available HFP indicators */
-	int er_mode;			/* Event reporting mode */
-	int er_ind;			/* Event reporting for indicators */
-	int rh;				/* Response and Hold state */
-	char *number;			/* Incoming phone number */
-	int number_type;		/* Incoming number type */
-	guint ring_timer;		/* For incoming call indication */
-	const char *chld;		/* Response to AT+CHLD=? */
-} ag = {
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
@@ -128,25 +100,6 @@ struct pending_connect {
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
@@ -170,15 +123,10 @@ struct headset {
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
@@ -194,44 +142,6 @@ static int rfcomm_connect(struct audio_device *device, headset_stream_cb_t cb,
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
 static const char *state2str(headset_state_t state)
 {
 	switch (state) {
@@ -249,52 +159,6 @@ static const char *state2str(headset_state_t state)
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
 static void pending_connect_complete(struct connect_cb *cb, struct audio_device *dev)
 {
 	struct headset *hs = dev->headset;
@@ -375,64 +239,11 @@ static unsigned int connect_cb_new(struct headset *hs,
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
@@ -473,14 +284,6 @@ static void sco_connect_cb(GIOChannel *chan, GError *err, gpointer user_data)
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
@@ -519,14 +322,6 @@ static int sco_connect(struct audio_device *dev, headset_stream_cb_t cb,
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
 void headset_slc_complete(struct audio_device *dev)
 {
 	struct headset *hs = dev->headset;
@@ -556,200 +351,6 @@ void headset_slc_complete(struct audio_device *dev)
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
-			telephony_get_ag_features() & AG_FEATURE_THREE_WAY_CALLING)
-		return 0;
-
-	headset_slc_complete(device);
-
-	return 0;
-}
-
-int telephony_key_press_rsp(void *telephony_device, cme_error_t err)
-{
-	return telephony_generic_rsp(telephony_device, err);
-}
-
-int telephony_answer_call_rsp(void *telephony_device, cme_error_t err)
-{
-	return telephony_generic_rsp(telephony_device, err);
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
-int telephony_response_and_hold_rsp(void *telephony_device, cme_error_t err)
-{
-	return telephony_generic_rsp(telephony_device, err);
-}
-
-int telephony_last_dialed_number_rsp(void *telephony_device, cme_error_t err)
-{
-	return telephony_generic_rsp(telephony_device, err);
-}
-
-int telephony_dial_number_rsp(void *telephony_device, cme_error_t err)
-{
-	return telephony_generic_rsp(telephony_device, err);
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
-int telephony_transmit_dtmf_rsp(void *telephony_device, cme_error_t err)
-{
-	return telephony_generic_rsp(telephony_device, err);
-}
-
-int telephony_subscriber_number_rsp(void *telephony_device, cme_error_t err)
-{
-	return telephony_generic_rsp(telephony_device, err);
-}
-
-int telephony_list_current_calls_rsp(void *telephony_device, cme_error_t err)
-{
-	return telephony_generic_rsp(telephony_device, err);
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
 static void close_sco(struct audio_device *device)
 {
 	struct headset *hs = device->headset;
@@ -815,11 +416,6 @@ void headset_connect_cb(GIOChannel *chan, GError *err, gpointer user_data)
 
 	DBG("%s: Connected to %s", dev->path, hs_address);
 
-	hs->slc = g_new0(struct headset_slc, 1);
-	hs->slc->sp_gain = 15;
-	hs->slc->mic_gain = 15;
-	hs->slc->nrec = TRUE;
-
 	/* In HFP mode wait for Service Level Connection */
 	if (hs->hfp_active)
 		return;
@@ -1169,63 +765,6 @@ static DBusMessage *hs_connect(DBusConnection *conn, DBusMessage *msg,
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
 static DBusMessage *hs_play(DBusConnection *conn, DBusMessage *msg,
 				void *data)
 {
@@ -1265,114 +804,6 @@ static DBusMessage *hs_play(DBusConnection *conn, DBusMessage *msg,
 	return NULL;
 }
 
-static DBusMessage *hs_get_speaker_gain(DBusConnection *conn,
-					DBusMessage *msg,
-					void *data)
-{
-	struct audio_device *device = data;
-	struct headset *hs = device->headset;
-	struct headset_slc *slc = hs->slc;
-	DBusMessage *reply;
-	dbus_uint16_t gain;
-
-	if (hs->state < HEADSET_STATE_CONNECTED)
-		return btd_error_not_available(msg);
-
-	reply = dbus_message_new_method_return(msg);
-	if (!reply)
-		return NULL;
-
-	gain = (dbus_uint16_t) slc->sp_gain;
-
-	dbus_message_append_args(reply, DBUS_TYPE_UINT16, &gain,
-					DBUS_TYPE_INVALID);
-
-	return reply;
-}
-
-static DBusMessage *hs_get_mic_gain(DBusConnection *conn,
-					DBusMessage *msg,
-					void *data)
-{
-	struct audio_device *device = data;
-	struct headset *hs = device->headset;
-	struct headset_slc *slc = hs->slc;
-	DBusMessage *reply;
-	dbus_uint16_t gain;
-
-	if (hs->state < HEADSET_STATE_CONNECTED || slc == NULL)
-		return btd_error_not_available(msg);
-
-	reply = dbus_message_new_method_return(msg);
-	if (!reply)
-		return NULL;
-
-	gain = (dbus_uint16_t) slc->mic_gain;
-
-	dbus_message_append_args(reply, DBUS_TYPE_UINT16, &gain,
-					DBUS_TYPE_INVALID);
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
-static DBusMessage *hs_set_speaker_gain(DBusConnection *conn,
-					DBusMessage *msg,
-					void *data)
-{
-	uint16_t gain;
-
-	if (!dbus_message_get_args(msg, NULL, DBUS_TYPE_UINT16, &gain,
-				DBUS_TYPE_INVALID))
-		return NULL;
-
-	return hs_set_gain(conn, msg, data, gain, HEADSET_GAIN_SPEAKER);
-}
-
-static DBusMessage *hs_set_mic_gain(DBusConnection *conn,
-					DBusMessage *msg,
-					void *data)
-{
-	uint16_t gain;
-
-	if (!dbus_message_get_args(msg, NULL, DBUS_TYPE_UINT16, &gain,
-				DBUS_TYPE_INVALID))
-		return NULL;
-
-	return hs_set_gain(conn, msg, data, gain, HEADSET_GAIN_MICROPHONE);
-}
-
 static DBusMessage *hs_get_properties(DBusConnection *conn,
 					DBusMessage *msg, void *data)
 {
@@ -1408,20 +839,6 @@ static DBusMessage *hs_get_properties(DBusConnection *conn,
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
@@ -1433,7 +850,8 @@ static DBusMessage *hs_set_property(DBusConnection *conn,
 	const char *property;
 	DBusMessageIter iter;
 	DBusMessageIter sub;
-	uint16_t gain;
+
+	//TODO: Should be removed ?
 
 	if (!dbus_message_iter_init(msg, &iter))
 		return btd_error_invalid_args(msg);
@@ -1448,22 +866,6 @@ static DBusMessage *hs_set_property(DBusConnection *conn,
 		return btd_error_invalid_args(msg);
 	dbus_message_iter_recurse(&iter, &sub);
 
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
 	return btd_error_invalid_args(msg);
 }
 
@@ -1472,36 +874,18 @@ static GDBusMethodTable headset_methods[] = {
 						G_DBUS_METHOD_FLAG_ASYNC },
 	{ "Disconnect",		"",	"",	hs_disconnect },
 	{ "IsConnected",	"",	"b",	hs_is_connected },
-	{ "IndicateCall",	"",	"",	hs_ring },
-	{ "CancelCall",		"",	"",	hs_cancel_call },
 	{ "Play",		"",	"",	hs_play,
 						G_DBUS_METHOD_FLAG_ASYNC |
 						G_DBUS_METHOD_FLAG_DEPRECATED },
 	{ "Stop",		"",	"",	hs_stop },
 	{ "IsPlaying",		"",	"b",	hs_is_playing,
 						G_DBUS_METHOD_FLAG_DEPRECATED },
-	{ "GetSpeakerGain",	"",	"q",	hs_get_speaker_gain,
-						G_DBUS_METHOD_FLAG_DEPRECATED },
-	{ "GetMicrophoneGain",	"",	"q",	hs_get_mic_gain,
-						G_DBUS_METHOD_FLAG_DEPRECATED },
-	{ "SetSpeakerGain",	"q",	"",	hs_set_speaker_gain,
-						G_DBUS_METHOD_FLAG_DEPRECATED },
-	{ "SetMicrophoneGain",	"q",	"",	hs_set_mic_gain,
-						G_DBUS_METHOD_FLAG_DEPRECATED },
 	{ "GetProperties",	"",	"a{sv}",hs_get_properties },
 	{ "SetProperty",	"sv",	"",	hs_set_property },
 	{ NULL, NULL, NULL, NULL }
 };
 
 static GDBusSignalTable headset_signals[] = {
-	{ "Connected",			"",	G_DBUS_SIGNAL_FLAG_DEPRECATED },
-	{ "Disconnected",		"",	G_DBUS_SIGNAL_FLAG_DEPRECATED },
-	{ "AnswerRequested",		""	},
-	{ "Stopped",			"",	G_DBUS_SIGNAL_FLAG_DEPRECATED },
-	{ "Playing",			"",	G_DBUS_SIGNAL_FLAG_DEPRECATED },
-	{ "SpeakerGainChanged",		"q",	G_DBUS_SIGNAL_FLAG_DEPRECATED },
-	{ "MicrophoneGainChanged",	"q",	G_DBUS_SIGNAL_FLAG_DEPRECATED },
-	{ "CallTerminated",		""	},
 	{ "PropertyChanged",		"sv"	},
 	{ NULL, NULL }
 };
@@ -1675,19 +1059,6 @@ uint32_t headset_config_init(GKeyFile *config)
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
 	return telephony_get_ag_features();
 }
 
@@ -1895,28 +1266,18 @@ int headset_connect_rfcomm(struct audio_device *dev, GIOChannel *io)
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
 	gboolean value;
 	const char *state_str;
 	headset_state_t old_state = hs->state;
@@ -1939,17 +1300,12 @@ void headset_set_state(struct audio_device *dev, headset_state_t state)
 		emit_property_changed(dev->conn, dev->path,
 					AUDIO_HEADSET_INTERFACE, "State",
 					DBUS_TYPE_STRING, &state_str);
-		g_dbus_emit_signal(dev->conn, dev->path,
-					AUDIO_HEADSET_INTERFACE,
-					"Disconnected",
-					DBUS_TYPE_INVALID);
 		if (hs->state > HEADSET_STATE_CONNECTING) {
 			emit_property_changed(dev->conn, dev->path,
 					AUDIO_HEADSET_INTERFACE, "Connected",
 					DBUS_TYPE_BOOLEAN, &value);
 			telephony_device_disconnected(dev);
 		}
-		active_devices = g_slist_remove(active_devices, dev);
 		break;
 	case HEADSET_STATE_CONNECTING:
 		emit_property_changed(dev->conn, dev->path,
@@ -1963,28 +1319,14 @@ void headset_set_state(struct audio_device *dev, headset_state_t state)
 					AUDIO_HEADSET_INTERFACE, "State",
 					DBUS_TYPE_STRING, &state_str);
 		if (hs->state < state) {
-			if (telephony_get_ag_features() &
-					AG_FEATURE_INBAND_RINGTONE)
-				slc->inband_ring = TRUE;
-			else
-				slc->inband_ring = FALSE;
-			g_dbus_emit_signal(dev->conn, dev->path,
-						AUDIO_HEADSET_INTERFACE,
-						"Connected",
-						DBUS_TYPE_INVALID);
 			value = TRUE;
 			emit_property_changed(dev->conn, dev->path,
 						AUDIO_HEADSET_INTERFACE,
 						"Connected",
 						DBUS_TYPE_BOOLEAN, &value);
-			active_devices = g_slist_append(active_devices, dev);
 			telephony_device_connected(dev);
 		} else if (hs->state == HEADSET_STATE_PLAYING) {
 			value = FALSE;
-			g_dbus_emit_signal(dev->conn, dev->path,
-						AUDIO_HEADSET_INTERFACE,
-						"Stopped",
-						DBUS_TYPE_INVALID);
 			emit_property_changed(dev->conn, dev->path,
 						AUDIO_HEADSET_INTERFACE,
 						"Playing",
@@ -2005,17 +1347,9 @@ void headset_set_state(struct audio_device *dev, headset_state_t state)
 					G_IO_ERR | G_IO_NVAL,
 					(GIOFunc) sco_cb, dev);
 
-		g_dbus_emit_signal(dev->conn, dev->path,
-					AUDIO_HEADSET_INTERFACE, "Playing",
-					DBUS_TYPE_INVALID);
 		emit_property_changed(dev->conn, dev->path,
 					AUDIO_HEADSET_INTERFACE, "Playing",
 					DBUS_TYPE_BOOLEAN, &value);
-
-		if (slc->sp_gain >= 0)
-			headset_send(hs, "\r\n+VGS=%u\r\n", slc->sp_gain);
-		if (slc->mic_gain >= 0)
-			headset_send(hs, "\r\n+VGM=%u\r\n", slc->mic_gain);
 		break;
 	}
 
@@ -2120,60 +1454,6 @@ int headset_get_sco_fd(struct audio_device *dev)
 	return g_io_channel_unix_get_fd(hs->sco);
 }
 
-gboolean headset_get_nrec(struct audio_device *dev)
-{
-	struct headset *hs = dev->headset;
-
-	if (!hs->slc)
-		return TRUE;
-
-	return hs->slc->nrec;
-}
-
-unsigned int headset_add_nrec_cb(struct audio_device *dev,
-					headset_nrec_cb cb, void *user_data)
-{
-	struct headset *hs = dev->headset;
-	struct headset_nrec_callback *nrec_cb;
-	static unsigned int id = 0;
-
-	nrec_cb = g_new(struct headset_nrec_callback, 1);
-	nrec_cb->cb = cb;
-	nrec_cb->user_data = user_data;
-	nrec_cb->id = ++id;
-
-	hs->nrec_cbs = g_slist_prepend(hs->nrec_cbs, nrec_cb);
-
-	return nrec_cb->id;
-}
-
-gboolean headset_remove_nrec_cb(struct audio_device *dev, unsigned int id)
-{
-	struct headset *hs = dev->headset;
-	GSList *l;
-
-	for (l = hs->nrec_cbs; l != NULL; l = l->next) {
-		struct headset_nrec_callback *cb = l->data;
-		if (cb && cb->id == id) {
-			hs->nrec_cbs = g_slist_remove(hs->nrec_cbs, cb);
-			g_free(cb);
-			return TRUE;
-		}
-	}
-
-	return FALSE;
-}
-
-gboolean headset_get_inband(struct audio_device *dev)
-{
-	struct headset *hs = dev->headset;
-
-	if (!hs->slc)
-		return TRUE;
-
-	return hs->slc->inband_ring;
-}
-
 gboolean headset_get_sco_hci(struct audio_device *dev)
 {
 	return sco_hci;
@@ -2190,193 +1470,6 @@ void headset_shutdown(struct audio_device *dev)
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
-	ag.indicators = indicators;
-	ag.rh = rh;
-	ag.chld = chld;
-
-	DBG("Telephony plugin initialized");
-
-	print_ag_features(telephony_get_ag_features());
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
diff --git a/audio/headset.h b/audio/headset.h
index d43952f..6bf352c 100644
--- a/audio/headset.h
+++ b/audio/headset.h
@@ -96,11 +96,6 @@ void headset_set_state(struct audio_device *dev, headset_state_t state);
 int headset_get_channel(struct audio_device *dev);
 
 int headset_get_sco_fd(struct audio_device *dev);
-gboolean headset_get_nrec(struct audio_device *dev);
-unsigned int headset_add_nrec_cb(struct audio_device *dev,
-					headset_nrec_cb cb, void *user_data);
-gboolean headset_remove_nrec_cb(struct audio_device *dev, unsigned int id);
-gboolean headset_get_inband(struct audio_device *dev);
 gboolean headset_get_sco_hci(struct audio_device *dev);
 
 gboolean headset_is_active(struct audio_device *dev);
diff --git a/audio/telephony-dummy.c b/audio/telephony-dummy.c
deleted file mode 100644
index 1f89079..0000000
--- a/audio/telephony-dummy.c
+++ /dev/null
@@ -1,433 +0,0 @@
-/*
- *
- *  BlueZ - Bluetooth protocol stack for Linux
- *
- *  Copyright (C) 2006-2010  Nokia Corporation
- *  Copyright (C) 2004-2010  Marcel Holtmann <marcel@holtmann.org>
- *
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, write to the Free Software
- *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
- *
- */
-
-#ifdef HAVE_CONFIG_H
-#include <config.h>
-#endif
-
-#include <stdlib.h>
-#include <stdio.h>
-#include <stdint.h>
-#include <glib.h>
-#include <dbus/dbus.h>
-#include <gdbus.h>
-
-#include "log.h"
-#include "telephony.h"
-#include "error.h"
-
-#define TELEPHONY_DUMMY_IFACE "org.bluez.TelephonyTest"
-#define TELEPHONY_DUMMY_PATH "/org/bluez/test"
-
-static DBusConnection *connection = NULL;
-
-static const char *chld_str = "0,1,1x,2,2x,3,4";
-static char *subscriber_number = NULL;
-static char *active_call_number = NULL;
-static int active_call_status = 0;
-static int active_call_dir = 0;
-
-static gboolean events_enabled = FALSE;
-
-static struct indicator dummy_indicators[] =
-{
-	{ "battchg",	"0-5",	5,	TRUE },
-	{ "signal",	"0-5",	5,	TRUE },
-	{ "service",	"0,1",	1,	TRUE },
-	{ "call",	"0,1",	0,	TRUE },
-	{ "callsetup",	"0-3",	0,	TRUE },
-	{ "callheld",	"0-2",	0,	FALSE },
-	{ "roam",	"0,1",	0,	TRUE },
-	{ NULL }
-};
-
-void telephony_device_connected(void *telephony_device)
-{
-	DBG("telephony-dummy: device %p connected", telephony_device);
-}
-
-void telephony_device_disconnected(void *telephony_device)
-{
-	DBG("telephony-dummy: device %p disconnected", telephony_device);
-	events_enabled = FALSE;
-}
-
-void telephony_event_reporting_req(void *telephony_device, int ind)
-{
-	events_enabled = ind == 1 ? TRUE : FALSE;
-
-	telephony_event_reporting_rsp(telephony_device, CME_ERROR_NONE);
-}
-
-void telephony_response_and_hold_req(void *telephony_device, int rh)
-{
-	telephony_response_and_hold_rsp(telephony_device,
-						CME_ERROR_NOT_SUPPORTED);
-}
-
-void telephony_last_dialed_number_req(void *telephony_device)
-{
-	telephony_last_dialed_number_rsp(telephony_device, CME_ERROR_NONE);
-
-	/* Notify outgoing call set-up successfully initiated */
-	telephony_update_indicator(dummy_indicators, "callsetup",
-					EV_CALLSETUP_OUTGOING);
-	telephony_update_indicator(dummy_indicators, "callsetup",
-					EV_CALLSETUP_ALERTING);
-
-	active_call_status = CALL_STATUS_ALERTING;
-	active_call_dir = CALL_DIR_OUTGOING;
-}
-
-void telephony_terminate_call_req(void *telephony_device)
-{
-	g_free(active_call_number);
-	active_call_number = NULL;
-
-	telephony_terminate_call_rsp(telephony_device, CME_ERROR_NONE);
-
-	if (telephony_get_indicator(dummy_indicators, "callsetup") > 0)
-		telephony_update_indicator(dummy_indicators, "callsetup",
-						EV_CALLSETUP_INACTIVE);
-	else
-		telephony_update_indicator(dummy_indicators, "call",
-						EV_CALL_INACTIVE);
-}
-
-void telephony_answer_call_req(void *telephony_device)
-{
-	telephony_answer_call_rsp(telephony_device, CME_ERROR_NONE);
-
-	telephony_update_indicator(dummy_indicators, "call", EV_CALL_ACTIVE);
-	telephony_update_indicator(dummy_indicators, "callsetup",
-					EV_CALLSETUP_INACTIVE);
-
-	active_call_status = CALL_STATUS_ACTIVE;
-}
-
-void telephony_dial_number_req(void *telephony_device, const char *number)
-{
-	g_free(active_call_number);
-	active_call_number = g_strdup(number);
-
-	DBG("telephony-dummy: dial request to %s", active_call_number);
-
-	telephony_dial_number_rsp(telephony_device, CME_ERROR_NONE);
-
-	/* Notify outgoing call set-up successfully initiated */
-	telephony_update_indicator(dummy_indicators, "callsetup",
-					EV_CALLSETUP_OUTGOING);
-	telephony_update_indicator(dummy_indicators, "callsetup",
-					EV_CALLSETUP_ALERTING);
-
-	active_call_status = CALL_STATUS_ALERTING;
-	active_call_dir = CALL_DIR_OUTGOING;
-}
-
-void telephony_transmit_dtmf_req(void *telephony_device, char tone)
-{
-	DBG("telephony-dummy: transmit dtmf: %c", tone);
-	telephony_transmit_dtmf_rsp(telephony_device, CME_ERROR_NONE);
-}
-
-void telephony_subscriber_number_req(void *telephony_device)
-{
-	DBG("telephony-dummy: subscriber number request");
-	if (subscriber_number)
-		telephony_subscriber_number_ind(subscriber_number,
-						NUMBER_TYPE_TELEPHONY,
-						SUBSCRIBER_SERVICE_VOICE);
-	telephony_subscriber_number_rsp(telephony_device, CME_ERROR_NONE);
-}
-
-void telephony_list_current_calls_req(void *telephony_device)
-{
-	DBG("telephony-dummy: list current calls request");
-	if (active_call_number)
-		telephony_list_current_call_ind(1, active_call_dir,
-						active_call_status,
-						CALL_MODE_VOICE,
-						CALL_MULTIPARTY_NO,
-						active_call_number,
-						NUMBER_TYPE_TELEPHONY);
-	telephony_list_current_calls_rsp(telephony_device, CME_ERROR_NONE);
-}
-
-void telephony_operator_selection_req(void *telephony_device)
-{
-	telephony_operator_selection_ind(OPERATOR_MODE_AUTO, "DummyOperator");
-	telephony_operator_selection_rsp(telephony_device, CME_ERROR_NONE);
-}
-
-void telephony_call_hold_req(void *telephony_device, const char *cmd)
-{
-	DBG("telephony-dymmy: got call hold request %s", cmd);
-	telephony_call_hold_rsp(telephony_device, CME_ERROR_NONE);
-}
-
-void telephony_nr_and_ec_req(void *telephony_device, gboolean enable)
-{
-	DBG("telephony-dummy: got %s NR and EC request",
-			enable ? "enable" : "disable");
-
-	telephony_nr_and_ec_rsp(telephony_device, CME_ERROR_NONE);
-}
-
-void telephony_voice_dial_req(void *telephony_device, gboolean enable)
-{
-	DBG("telephony-dummy: got %s voice dial request",
-			enable ? "enable" : "disable");
-
-	g_dbus_emit_signal(connection, TELEPHONY_DUMMY_PATH,
-			TELEPHONY_DUMMY_IFACE, "VoiceDial",
-			DBUS_TYPE_INVALID);
-
-	telephony_voice_dial_rsp(telephony_device, CME_ERROR_NONE);
-}
-
-void telephony_key_press_req(void *telephony_device, const char *keys)
-{
-	DBG("telephony-dummy: got key press request for %s", keys);
-	telephony_key_press_rsp(telephony_device, CME_ERROR_NONE);
-}
-
-/* D-Bus method handlers */
-static DBusMessage *outgoing_call(DBusConnection *conn, DBusMessage *msg,
-					void *data)
-{
-	const char *number;
-
-	if (!dbus_message_get_args(msg, NULL, DBUS_TYPE_STRING, &number,
-						DBUS_TYPE_INVALID))
-		return btd_error_invalid_args(msg);
-
-	DBG("telephony-dummy: outgoing call to %s", number);
-
-	g_free(active_call_number);
-	active_call_number = g_strdup(number);
-
-	telephony_update_indicator(dummy_indicators, "callsetup",
-					EV_CALLSETUP_OUTGOING);
-	telephony_update_indicator(dummy_indicators, "callsetup",
-					EV_CALLSETUP_ALERTING);
-
-	active_call_status = CALL_STATUS_ALERTING;
-	active_call_dir = CALL_DIR_OUTGOING;
-
-	return dbus_message_new_method_return(msg);
-}
-
-static DBusMessage *incoming_call(DBusConnection *conn, DBusMessage *msg,
-					void *data)
-{
-	const char *number;
-
-	if (!dbus_message_get_args(msg, NULL, DBUS_TYPE_STRING, &number,
-						DBUS_TYPE_INVALID))
-		return btd_error_invalid_args(msg);
-
-	DBG("telephony-dummy: incoming call to %s", number);
-
-	g_free(active_call_number);
-	active_call_number = g_strdup(number);
-
-	telephony_update_indicator(dummy_indicators, "callsetup",
-					EV_CALLSETUP_INCOMING);
-
-	active_call_status = CALL_STATUS_INCOMING;
-	active_call_dir = CALL_DIR_INCOMING;
-
-	telephony_incoming_call_ind(number, NUMBER_TYPE_TELEPHONY);
-
-	return dbus_message_new_method_return(msg);
-}
-
-static DBusMessage *cancel_call(DBusConnection *conn, DBusMessage *msg,
-					void *data)
-{
-	DBG("telephony-dummy: cancel call");
-
-	g_free(active_call_number);
-	active_call_number = NULL;
-
-	if (telephony_get_indicator(dummy_indicators, "callsetup") > 0) {
-		telephony_update_indicator(dummy_indicators, "callsetup",
-						EV_CALLSETUP_INACTIVE);
-		telephony_calling_stopped_ind();
-	}
-
-	if (telephony_get_indicator(dummy_indicators, "call") > 0)
-		telephony_update_indicator(dummy_indicators, "call",
-						EV_CALL_INACTIVE);
-
-	return dbus_message_new_method_return(msg);
-}
-
-static DBusMessage *signal_strength(DBusConnection *conn, DBusMessage *msg,
-					void *data)
-{
-	dbus_uint32_t strength;
-
-	if (!dbus_message_get_args(msg, NULL, DBUS_TYPE_UINT32, &strength,
-						DBUS_TYPE_INVALID))
-		return btd_error_invalid_args(msg);
-
-	if (strength > 5)
-		return btd_error_invalid_args(msg);
-
-	telephony_update_indicator(dummy_indicators, "signal", strength);
-
-	DBG("telephony-dummy: signal strength set to %u", strength);
-
-	return dbus_message_new_method_return(msg);
-}
-
-static DBusMessage *battery_level(DBusConnection *conn, DBusMessage *msg,
-					void *data)
-{
-	dbus_uint32_t level;
-
-	if (!dbus_message_get_args(msg, NULL, DBUS_TYPE_UINT32, &level,
-						DBUS_TYPE_INVALID))
-		return btd_error_invalid_args(msg);
-
-	if (level > 5)
-		return btd_error_invalid_args(msg);
-
-	telephony_update_indicator(dummy_indicators, "battchg", level);
-
-	DBG("telephony-dummy: battery level set to %u", level);
-
-	return dbus_message_new_method_return(msg);
-}
-
-static DBusMessage *roaming_status(DBusConnection *conn, DBusMessage *msg,
-					void *data)
-{
-	dbus_bool_t roaming;
-	int val;
-
-	if (!dbus_message_get_args(msg, NULL, DBUS_TYPE_BOOLEAN, &roaming,
-						DBUS_TYPE_INVALID))
-		return btd_error_invalid_args(msg);
-
-	val = roaming ? EV_ROAM_ACTIVE : EV_ROAM_INACTIVE;
-
-	telephony_update_indicator(dummy_indicators, "roam", val);
-
-	DBG("telephony-dummy: roaming status set to %d", val);
-
-	return dbus_message_new_method_return(msg);
-}
-
-static DBusMessage *registration_status(DBusConnection *conn, DBusMessage *msg,
-					void *data)
-{
-	dbus_bool_t registration;
-	int val;
-
-	if (!dbus_message_get_args(msg, NULL, DBUS_TYPE_BOOLEAN, &registration,
-						DBUS_TYPE_INVALID))
-		return btd_error_invalid_args(msg);
-
-	val = registration ? EV_SERVICE_PRESENT : EV_SERVICE_NONE;
-
-	telephony_update_indicator(dummy_indicators, "service", val);
-
-	DBG("telephony-dummy: registration status set to %d", val);
-
-	return dbus_message_new_method_return(msg);
-}
-
-static DBusMessage *set_subscriber_number(DBusConnection *conn,
-						DBusMessage *msg,
-						void *data)
-{
-	const char *number;
-
-	if (!dbus_message_get_args(msg, NULL, DBUS_TYPE_STRING, &number,
-						DBUS_TYPE_INVALID))
-		return btd_error_invalid_args(msg);
-
-	g_free(subscriber_number);
-	subscriber_number = g_strdup(number);
-
-	DBG("telephony-dummy: subscriber number set to %s", number);
-
-	return dbus_message_new_method_return(msg);
-}
-
-static GDBusMethodTable dummy_methods[] = {
-	{ "OutgoingCall",	"s",	"",	outgoing_call		},
-	{ "IncomingCall",	"s",	"",	incoming_call		},
-	{ "CancelCall",		"",	"",	cancel_call		},
-	{ "SignalStrength",	"u",	"",	signal_strength		},
-	{ "BatteryLevel",	"u",	"",	battery_level		},
-	{ "RoamingStatus",	"b",	"",	roaming_status		},
-	{ "RegistrationStatus",	"b",	"",	registration_status	},
-	{ "SetSubscriberNumber","s",	"",	set_subscriber_number	},
-	{ }
-};
-
-static GDBusSignalTable dummy_signals[] = {
-	{ "VoiceDial",	"" },
-	{ }
-};
-
-int telephony_init(void)
-{
-	uint32_t features = AG_FEATURE_REJECT_A_CALL |
-				AG_FEATURE_ENHANCED_CALL_STATUS |
-				AG_FEATURE_EXTENDED_ERROR_RESULT_CODES;
-
-	DBG("");
-
-	connection = dbus_bus_get(DBUS_BUS_SYSTEM, NULL);
-
-	if (g_dbus_register_interface(connection, TELEPHONY_DUMMY_PATH,
-					TELEPHONY_DUMMY_IFACE,
-					dummy_methods, dummy_signals,
-					NULL, NULL, NULL) == FALSE) {
-		error("telephony-dummy interface %s init failed on path %s",
-			TELEPHONY_DUMMY_IFACE, TELEPHONY_DUMMY_PATH);
-		return -1;
-	}
-
-	telephony_ready_ind(features, dummy_indicators, BTRH_NOT_SUPPORTED,
-								chld_str);
-
-	return 0;
-}
-
-void telephony_exit(void)
-{
-	DBG("");
-
-	g_dbus_unregister_interface(connection, TELEPHONY_DUMMY_PATH,
-						TELEPHONY_DUMMY_IFACE);
-	dbus_connection_unref(connection);
-	connection = NULL;
-
-	telephony_deinit();
-}
diff --git a/audio/telephony-ofono.c b/audio/telephony-ofono.c
deleted file mode 100644
index 3607d7f..0000000
--- a/audio/telephony-ofono.c
+++ /dev/null
@@ -1,1638 +0,0 @@
-/*
- *
- *  BlueZ - Bluetooth protocol stack for Linux
- *
- *  Copyright (C) 2009-2010  Intel Corporation
- *  Copyright (C) 2006-2009  Nokia Corporation
- *  Copyright (C) 2004-2010  Marcel Holtmann <marcel@holtmann.org>
- *
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, write to the Free Software
- *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
- *
- */
-
-#ifdef HAVE_CONFIG_H
-#include <config.h>
-#endif
-
-#include <stdlib.h>
-#include <stdio.h>
-#include <string.h>
-#include <stdint.h>
-#include <glib.h>
-#include <dbus/dbus.h>
-#include <gdbus.h>
-
-#include <bluetooth/sdp.h>
-
-#include "glib-compat.h"
-#include "log.h"
-#include "telephony.h"
-
-enum net_registration_status {
-	NETWORK_REG_STATUS_HOME = 0x00,
-	NETWORK_REG_STATUS_ROAM,
-	NETWORK_REG_STATUS_NOSERV
-};
-
-struct voice_call {
-	char *obj_path;
-	int status;
-	gboolean originating;
-	gboolean conference;
-	char *number;
-	guint watch;
-};
-
-static DBusConnection *connection = NULL;
-static char *modem_obj_path = NULL;
-static char *last_dialed_number = NULL;
-static GSList *calls = NULL;
-static GSList *watches = NULL;
-static GSList *pending = NULL;
-
-#define OFONO_BUS_NAME "org.ofono"
-#define OFONO_PATH "/"
-#define OFONO_MODEM_INTERFACE "org.ofono.Modem"
-#define OFONO_MANAGER_INTERFACE "org.ofono.Manager"
-#define OFONO_NETWORKREG_INTERFACE "org.ofono.NetworkRegistration"
-#define OFONO_VCMANAGER_INTERFACE "org.ofono.VoiceCallManager"
-#define OFONO_VC_INTERFACE "org.ofono.VoiceCall"
-
-/* HAL battery namespace key values */
-static int battchg_cur = -1;    /* "battery.charge_level.current" */
-static int battchg_last = -1;   /* "battery.charge_level.last_full" */
-static int battchg_design = -1; /* "battery.charge_level.design" */
-
-static struct {
-	uint8_t status;
-	uint32_t signals_bar;
-	char *operator_name;
-} net = {
-	.status = NETWORK_REG_STATUS_NOSERV,
-	.signals_bar = 0,
-	.operator_name = NULL,
-};
-
-static const char *chld_str = "0,1,1x,2,2x,3,4";
-static char *subscriber_number = NULL;
-
-static gboolean events_enabled = FALSE;
-
-static struct indicator ofono_indicators[] =
-{
-	{ "battchg",	"0-5",	5,	TRUE },
-	{ "signal",	"0-5",	5,	TRUE },
-	{ "service",	"0,1",	1,	TRUE },
-	{ "call",	"0,1",	0,	TRUE },
-	{ "callsetup",	"0-3",	0,	TRUE },
-	{ "callheld",	"0-2",	0,	FALSE },
-	{ "roam",	"0,1",	0,	TRUE },
-	{ NULL }
-};
-
-static struct voice_call *find_vc(const char *path)
-{
-	GSList *l;
-
-	for (l = calls; l != NULL; l = l->next) {
-		struct voice_call *vc = l->data;
-
-		if (g_str_equal(vc->obj_path, path))
-			return vc;
-	}
-
-	return NULL;
-}
-
-static struct voice_call *find_vc_with_status(int status)
-{
-	GSList *l;
-
-	for (l = calls; l != NULL; l = l->next) {
-		struct voice_call *vc = l->data;
-
-		if (vc->status == status)
-			return vc;
-	}
-
-	return NULL;
-}
-
-static struct voice_call *find_vc_without_status(int status)
-{
-	GSList *l;
-
-	for (l = calls; l != NULL; l = l->next) {
-		struct voice_call *call = l->data;
-
-		if (call->status != status)
-			return call;
-	}
-
-	return NULL;
-}
-
-static int number_type(const char *number)
-{
-	if (number == NULL)
-		return NUMBER_TYPE_TELEPHONY;
-
-	if (number[0] == '+' || strncmp(number, "00", 2) == 0)
-		return NUMBER_TYPE_INTERNATIONAL;
-
-	return NUMBER_TYPE_TELEPHONY;
-}
-
-void telephony_device_connected(void *telephony_device)
-{
-	struct voice_call *coming;
-
-	DBG("telephony-ofono: device %p connected", telephony_device);
-
-	coming = find_vc_with_status(CALL_STATUS_ALERTING);
-	if (coming) {
-		if (find_vc_with_status(CALL_STATUS_ACTIVE))
-			telephony_call_waiting_ind(coming->number,
-						number_type(coming->number));
-		else
-			telephony_incoming_call_ind(coming->number,
-						number_type(coming->number));
-	}
-}
-
-void telephony_device_disconnected(void *telephony_device)
-{
-	DBG("telephony-ofono: device %p disconnected", telephony_device);
-	events_enabled = FALSE;
-}
-
-void telephony_event_reporting_req(void *telephony_device, int ind)
-{
-	events_enabled = ind == 1 ? TRUE : FALSE;
-
-	telephony_event_reporting_rsp(telephony_device, CME_ERROR_NONE);
-}
-
-void telephony_response_and_hold_req(void *telephony_device, int rh)
-{
-	telephony_response_and_hold_rsp(telephony_device,
-						CME_ERROR_NOT_SUPPORTED);
-}
-
-void telephony_last_dialed_number_req(void *telephony_device)
-{
-	DBG("telephony-ofono: last dialed number request");
-
-	if (last_dialed_number)
-		telephony_dial_number_req(telephony_device, last_dialed_number);
-	else
-		telephony_last_dialed_number_rsp(telephony_device,
-				CME_ERROR_NOT_ALLOWED);
-}
-
-static int send_method_call(const char *dest, const char *path,
-                                const char *interface, const char *method,
-                                DBusPendingCallNotifyFunction cb,
-                                void *user_data, int type, ...)
-{
-	DBusMessage *msg;
-	DBusPendingCall *call;
-	va_list args;
-
-	msg = dbus_message_new_method_call(dest, path, interface, method);
-	if (!msg) {
-		error("Unable to allocate new D-Bus %s message", method);
-		return -ENOMEM;
-	}
-
-	va_start(args, type);
-
-	if (!dbus_message_append_args_valist(msg, type, args)) {
-		dbus_message_unref(msg);
-		va_end(args);
-		return -EIO;
-	}
-
-	va_end(args);
-
-	if (!cb) {
-		g_dbus_send_message(connection, msg);
-		return 0;
-	}
-
-	if (!dbus_connection_send_with_reply(connection, msg, &call, -1)) {
-		error("Sending %s failed", method);
-		dbus_message_unref(msg);
-		return -EIO;
-	}
-
-	dbus_pending_call_set_notify(call, cb, user_data, NULL);
-	pending = g_slist_prepend(pending, call);
-	dbus_message_unref(msg);
-
-	return 0;
-}
-
-static int answer_call(struct voice_call *vc)
-{
-	DBG("%s", vc->number);
-	return send_method_call(OFONO_BUS_NAME, vc->obj_path,
-						OFONO_VC_INTERFACE, "Answer",
-						NULL, NULL, DBUS_TYPE_INVALID);
-}
-
-static int release_call(struct voice_call *vc)
-{
-	DBG("%s", vc->number);
-	return send_method_call(OFONO_BUS_NAME, vc->obj_path,
-						OFONO_VC_INTERFACE, "Hangup",
-						NULL, NULL, DBUS_TYPE_INVALID);
-}
-
-static int release_answer_calls(void)
-{
-	DBG("");
-	return send_method_call(OFONO_BUS_NAME, modem_obj_path,
-						OFONO_VCMANAGER_INTERFACE,
-						"ReleaseAndAnswer",
-						NULL, NULL, DBUS_TYPE_INVALID);
-}
-
-static int split_call(struct voice_call *call)
-{
-	DBG("%s", call->number);
-	return send_method_call(OFONO_BUS_NAME, modem_obj_path,
-						OFONO_VCMANAGER_INTERFACE,
-						"PrivateChat",
-						NULL, NULL,
-						DBUS_TYPE_OBJECT_PATH,
-						call->obj_path,
-						DBUS_TYPE_INVALID);
-	return -1;
-}
-
-static int swap_calls(void)
-{
-	DBG("");
-	return send_method_call(OFONO_BUS_NAME, modem_obj_path,
-						OFONO_VCMANAGER_INTERFACE,
-						"SwapCalls",
-						NULL, NULL, DBUS_TYPE_INVALID);
-}
-
-static int create_conference(void)
-{
-	DBG("");
-	return send_method_call(OFONO_BUS_NAME, modem_obj_path,
-						OFONO_VCMANAGER_INTERFACE,
-						"CreateMultiparty",
-						NULL, NULL, DBUS_TYPE_INVALID);
-}
-
-static int release_conference(void)
-{
-	DBG("");
-	return send_method_call(OFONO_BUS_NAME, modem_obj_path,
-						OFONO_VCMANAGER_INTERFACE,
-						"HangupMultiparty",
-						NULL, NULL, DBUS_TYPE_INVALID);
-}
-
-static int call_transfer(void)
-{
-	DBG("");
-	return send_method_call(OFONO_BUS_NAME, modem_obj_path,
-						OFONO_VCMANAGER_INTERFACE,
-						"Transfer",
-						NULL, NULL, DBUS_TYPE_INVALID);
-}
-
-void telephony_terminate_call_req(void *telephony_device)
-{
-	struct voice_call *call;
-	struct voice_call *alerting;
-	int err;
-
-	call = find_vc_with_status(CALL_STATUS_ACTIVE);
-	if (!call)
-		call = calls->data;
-
-	if (!call) {
-		error("No active call");
-		telephony_terminate_call_rsp(telephony_device,
-						CME_ERROR_NOT_ALLOWED);
-		return;
-	}
-
-	alerting = find_vc_with_status(CALL_STATUS_ALERTING);
-	if (call->status == CALL_STATUS_HELD && alerting)
-		err = release_call(alerting);
-	else if (call->conference)
-		err = release_conference();
-	else
-		err = release_call(call);
-
-	if (err < 0)
-		telephony_terminate_call_rsp(telephony_device,
-						CME_ERROR_AG_FAILURE);
-	else
-		telephony_terminate_call_rsp(telephony_device, CME_ERROR_NONE);
-}
-
-void telephony_answer_call_req(void *telephony_device)
-{
-	struct voice_call *vc;
-	int ret;
-
-	vc = find_vc_with_status(CALL_STATUS_INCOMING);
-	if (!vc)
-		vc = find_vc_with_status(CALL_STATUS_ALERTING);
-
-	if (!vc)
-		vc = find_vc_with_status(CALL_STATUS_WAITING);
-
-	if (!vc) {
-		telephony_answer_call_rsp(telephony_device,
-					CME_ERROR_NOT_ALLOWED);
-		return;
-	}
-
-	ret = answer_call(vc);
-	if (ret < 0) {
-		telephony_answer_call_rsp(telephony_device,
-					CME_ERROR_AG_FAILURE);
-		return;
-	}
-
-	telephony_answer_call_rsp(telephony_device, CME_ERROR_NONE);
-}
-
-void telephony_dial_number_req(void *telephony_device, const char *number)
-{
-	const char *clir;
-	int ret;
-
-	DBG("telephony-ofono: dial request to %s", number);
-
-	if (!modem_obj_path) {
-		telephony_dial_number_rsp(telephony_device,
-					CME_ERROR_AG_FAILURE);
-		return;
-	}
-
-	if (!strncmp(number, "*31#", 4)) {
-		number += 4;
-		clir = "enabled";
-	} else if (!strncmp(number, "#31#", 4)) {
-		number += 4;
-		clir =  "disabled";
-	} else
-		clir = "default";
-
-	ret = send_method_call(OFONO_BUS_NAME, modem_obj_path,
-			OFONO_VCMANAGER_INTERFACE,
-                        "Dial", NULL, NULL,
-			DBUS_TYPE_STRING, &number,
-			DBUS_TYPE_STRING, &clir,
-			DBUS_TYPE_INVALID);
-
-	if (ret < 0)
-		telephony_dial_number_rsp(telephony_device,
-			CME_ERROR_AG_FAILURE);
-	else
-		telephony_dial_number_rsp(telephony_device, CME_ERROR_NONE);
-}
-
-void telephony_transmit_dtmf_req(void *telephony_device, char tone)
-{
-	char *tone_string;
-	int ret;
-
-	DBG("telephony-ofono: transmit dtmf: %c", tone);
-
-	if (!modem_obj_path) {
-		telephony_transmit_dtmf_rsp(telephony_device,
-					CME_ERROR_AG_FAILURE);
-		return;
-	}
-
-	tone_string = g_strdup_printf("%c", tone);
-	ret = send_method_call(OFONO_BUS_NAME, modem_obj_path,
-			OFONO_VCMANAGER_INTERFACE,
-			"SendTones", NULL, NULL,
-			DBUS_TYPE_STRING, &tone_string,
-			DBUS_TYPE_INVALID);
-	g_free(tone_string);
-
-	if (ret < 0)
-		telephony_transmit_dtmf_rsp(telephony_device,
-			CME_ERROR_AG_FAILURE);
-	else
-		telephony_transmit_dtmf_rsp(telephony_device, CME_ERROR_NONE);
-}
-
-void telephony_subscriber_number_req(void *telephony_device)
-{
-	DBG("telephony-ofono: subscriber number request");
-
-	if (subscriber_number)
-		telephony_subscriber_number_ind(subscriber_number,
-						NUMBER_TYPE_TELEPHONY,
-						SUBSCRIBER_SERVICE_VOICE);
-	telephony_subscriber_number_rsp(telephony_device, CME_ERROR_NONE);
-}
-
-void telephony_list_current_calls_req(void *telephony_device)
-{
-	GSList *l;
-	int i;
-
-	DBG("telephony-ofono: list current calls request");
-
-	for (l = calls, i = 1; l != NULL; l = l->next, i++) {
-		struct voice_call *vc = l->data;
-		int direction, multiparty;
-
-		direction = vc->originating ?
-				CALL_DIR_OUTGOING : CALL_DIR_INCOMING;
-
-		multiparty = vc->conference ?
-				CALL_MULTIPARTY_YES : CALL_MULTIPARTY_NO;
-
-		DBG("call %s direction %d multiparty %d", vc->number,
-							direction, multiparty);
-
-		telephony_list_current_call_ind(i, direction, vc->status,
-					CALL_MODE_VOICE, multiparty,
-					vc->number, number_type(vc->number));
-	}
-
-	telephony_list_current_calls_rsp(telephony_device, CME_ERROR_NONE);
-}
-
-void telephony_operator_selection_req(void *telephony_device)
-{
-	DBG("telephony-ofono: operator selection request");
-
-	telephony_operator_selection_ind(OPERATOR_MODE_AUTO,
-				net.operator_name ? net.operator_name : "");
-	telephony_operator_selection_rsp(telephony_device, CME_ERROR_NONE);
-}
-
-static void foreach_vc_with_status(int status,
-					int (*func)(struct voice_call *vc))
-{
-	GSList *l;
-
-	for (l = calls; l != NULL; l = l->next) {
-		struct voice_call *call = l->data;
-
-		if (call->status == status)
-			func(call);
-	}
-}
-
-void telephony_call_hold_req(void *telephony_device, const char *cmd)
-{
-	const char *idx;
-	struct voice_call *call;
-	int err = 0;
-
-	DBG("telephony-ofono: got call hold request %s", cmd);
-
-	if (strlen(cmd) > 1)
-		idx = &cmd[1];
-	else
-		idx = NULL;
-
-	if (idx)
-		call = g_slist_nth_data(calls, strtol(idx, NULL, 0) - 1);
-	else
-		call = NULL;
-
-	switch (cmd[0]) {
-	case '0':
-		if (find_vc_with_status(CALL_STATUS_WAITING))
-			foreach_vc_with_status(CALL_STATUS_WAITING,
-								release_call);
-		else
-			foreach_vc_with_status(CALL_STATUS_HELD, release_call);
-		break;
-	case '1':
-		if (idx) {
-			if (call)
-				err = release_call(call);
-			break;
-		}
-		err = release_answer_calls();
-		break;
-	case '2':
-		if (idx) {
-			if (call)
-				err = split_call(call);
-		} else {
-			call = find_vc_with_status(CALL_STATUS_WAITING);
-
-			if (call)
-				err = answer_call(call);
-			else
-				err = swap_calls();
-		}
-		break;
-	case '3':
-		if (find_vc_with_status(CALL_STATUS_HELD) ||
-				find_vc_with_status(CALL_STATUS_WAITING))
-			err = create_conference();
-		break;
-	case '4':
-		err = call_transfer();
-		break;
-	default:
-		DBG("Unknown call hold request");
-		break;
-	}
-
-	if (err)
-		telephony_call_hold_rsp(telephony_device,
-					CME_ERROR_AG_FAILURE);
-	else
-		telephony_call_hold_rsp(telephony_device, CME_ERROR_NONE);
-}
-
-void telephony_nr_and_ec_req(void *telephony_device, gboolean enable)
-{
-	DBG("telephony-ofono: got %s NR and EC request",
-			enable ? "enable" : "disable");
-
-	telephony_nr_and_ec_rsp(telephony_device, CME_ERROR_NONE);
-}
-
-void telephony_key_press_req(void *telephony_device, const char *keys)
-{
-	struct voice_call *active, *incoming;
-	int err;
-
-	DBG("telephony-ofono: got key press request for %s", keys);
-
-	incoming = find_vc_with_status(CALL_STATUS_INCOMING);
-
-	active = find_vc_with_status(CALL_STATUS_ACTIVE);
-
-	if (incoming)
-		err = answer_call(incoming);
-	else if (active)
-		err = release_call(active);
-	else
-		err = 0;
-
-	if (err < 0)
-		telephony_key_press_rsp(telephony_device,
-							CME_ERROR_AG_FAILURE);
-	else
-		telephony_key_press_rsp(telephony_device, CME_ERROR_NONE);
-}
-
-void telephony_voice_dial_req(void *telephony_device, gboolean enable)
-{
-	DBG("telephony-ofono: got %s voice dial request",
-			enable ? "enable" : "disable");
-
-	telephony_voice_dial_rsp(telephony_device, CME_ERROR_NOT_SUPPORTED);
-}
-
-static gboolean iter_get_basic_args(DBusMessageIter *iter,
-					int first_arg_type, ...)
-{
-	int type;
-	va_list ap;
-
-	va_start(ap, first_arg_type);
-
-	for (type = first_arg_type; type != DBUS_TYPE_INVALID;
-		type = va_arg(ap, int)) {
-		void *value = va_arg(ap, void *);
-		int real_type = dbus_message_iter_get_arg_type(iter);
-
-		if (real_type != type) {
-			error("iter_get_basic_args: expected %c but got %c",
-				(char) type, (char) real_type);
-			break;
-		}
-
-		dbus_message_iter_get_basic(iter, value);
-		dbus_message_iter_next(iter);
-	}
-
-	va_end(ap);
-
-	return type == DBUS_TYPE_INVALID ? TRUE : FALSE;
-}
-
-static void call_free(void *data)
-{
-	struct voice_call *vc = data;
-
-	DBG("%s", vc->obj_path);
-
-	if (vc->status == CALL_STATUS_ACTIVE)
-		telephony_update_indicator(ofono_indicators, "call",
-							EV_CALL_INACTIVE);
-	else
-		telephony_update_indicator(ofono_indicators, "callsetup",
-							EV_CALLSETUP_INACTIVE);
-
-	if (vc->status == CALL_STATUS_INCOMING)
-		telephony_calling_stopped_ind();
-
-	g_dbus_remove_watch(connection, vc->watch);
-	g_free(vc->obj_path);
-	g_free(vc->number);
-	g_free(vc);
-}
-
-static gboolean handle_vc_property_changed(DBusConnection *conn,
-					DBusMessage *msg, void *data)
-{
-	struct voice_call *vc = data;
-	const char *obj_path = dbus_message_get_path(msg);
-	DBusMessageIter iter, sub;
-	const char *property, *state;
-
-	DBG("path %s", obj_path);
-
-	dbus_message_iter_init(msg, &iter);
-
-	if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_STRING) {
-		error("Unexpected signature in vc PropertyChanged signal");
-		return TRUE;
-	}
-
-	dbus_message_iter_get_basic(&iter, &property);
-	DBG("property %s", property);
-
-	dbus_message_iter_next(&iter);
-	dbus_message_iter_recurse(&iter, &sub);
-	if (g_str_equal(property, "State")) {
-		dbus_message_iter_get_basic(&sub, &state);
-		DBG("State %s", state);
-		if (g_str_equal(state, "disconnected")) {
-			calls = g_slist_remove(calls, vc);
-			call_free(vc);
-		} else if (g_str_equal(state, "active")) {
-			telephony_update_indicator(ofono_indicators,
-							"call", EV_CALL_ACTIVE);
-			telephony_update_indicator(ofono_indicators,
-							"callsetup",
-							EV_CALLSETUP_INACTIVE);
-			if (vc->status == CALL_STATUS_INCOMING)
-				telephony_calling_stopped_ind();
-			vc->status = CALL_STATUS_ACTIVE;
-		} else if (g_str_equal(state, "alerting")) {
-			telephony_update_indicator(ofono_indicators,
-					"callsetup", EV_CALLSETUP_ALERTING);
-			vc->status = CALL_STATUS_ALERTING;
-			vc->originating = TRUE;
-		} else if (g_str_equal(state, "incoming")) {
-			/* state change from waiting to incoming */
-			telephony_update_indicator(ofono_indicators,
-					"callsetup", EV_CALLSETUP_INCOMING);
-			telephony_incoming_call_ind(vc->number,
-						NUMBER_TYPE_TELEPHONY);
-			vc->status = CALL_STATUS_INCOMING;
-			vc->originating = FALSE;
-		} else if (g_str_equal(state, "held")) {
-			vc->status = CALL_STATUS_HELD;
-			if (find_vc_without_status(CALL_STATUS_HELD))
-				telephony_update_indicator(ofono_indicators,
-							"callheld",
-							EV_CALLHELD_MULTIPLE);
-			else
-				telephony_update_indicator(ofono_indicators,
-							"callheld",
-							EV_CALLHELD_ON_HOLD);
-		}
-	} else if (g_str_equal(property, "Multiparty")) {
-		dbus_bool_t multiparty;
-
-		dbus_message_iter_get_basic(&sub, &multiparty);
-		DBG("Multiparty %s", multiparty ? "True" : "False");
-		vc->conference = multiparty;
-	}
-
-	return TRUE;
-}
-
-static struct voice_call *call_new(const char *path, DBusMessageIter *properties)
-{
-	struct voice_call *vc;
-
-	DBG("%s", path);
-
-	vc = g_new0(struct voice_call, 1);
-	vc->obj_path = g_strdup(path);
-	vc->watch = g_dbus_add_signal_watch(connection, NULL, path,
-					OFONO_VC_INTERFACE, "PropertyChanged",
-					handle_vc_property_changed, vc, NULL);
-
-	while (dbus_message_iter_get_arg_type(properties)
-						== DBUS_TYPE_DICT_ENTRY) {
-		DBusMessageIter entry, value;
-		const char *property, *cli, *state;
-		dbus_bool_t multiparty;
-
-		dbus_message_iter_recurse(properties, &entry);
-		dbus_message_iter_get_basic(&entry, &property);
-
-		dbus_message_iter_next(&entry);
-		dbus_message_iter_recurse(&entry, &value);
-
-		if (g_str_equal(property, "LineIdentification")) {
-			dbus_message_iter_get_basic(&value, &cli);
-			DBG("cli %s", cli);
-			vc->number = g_strdup(cli);
-		} else if (g_str_equal(property, "State")) {
-			dbus_message_iter_get_basic(&value, &state);
-			DBG("state %s", state);
-			if (g_str_equal(state, "incoming"))
-				vc->status = CALL_STATUS_INCOMING;
-			else if (g_str_equal(state, "dialing"))
-				vc->status = CALL_STATUS_DIALING;
-			else if (g_str_equal(state, "alerting"))
-				vc->status = CALL_STATUS_ALERTING;
-			else if (g_str_equal(state, "waiting"))
-				vc->status = CALL_STATUS_WAITING;
-			else if (g_str_equal(state, "held"))
-				vc->status = CALL_STATUS_HELD;
-		} else if (g_str_equal(property, "Multiparty")) {
-			dbus_message_iter_get_basic(&value, &multiparty);
-			DBG("Multipary %s", multiparty ? "True" : "False");
-			vc->conference = multiparty;
-		}
-
-		dbus_message_iter_next(properties);
-	}
-
-	switch (vc->status) {
-	case CALL_STATUS_INCOMING:
-		DBG("CALL_STATUS_INCOMING");
-		vc->originating = FALSE;
-		telephony_update_indicator(ofono_indicators, "callsetup",
-					EV_CALLSETUP_INCOMING);
-		telephony_incoming_call_ind(vc->number, NUMBER_TYPE_TELEPHONY);
-		break;
-	case CALL_STATUS_DIALING:
-		DBG("CALL_STATUS_DIALING");
-		vc->originating = TRUE;
-		g_free(last_dialed_number);
-		last_dialed_number = g_strdup(vc->number);
-		telephony_update_indicator(ofono_indicators, "callsetup",
-					EV_CALLSETUP_OUTGOING);
-		break;
-	case CALL_STATUS_ALERTING:
-		DBG("CALL_STATUS_ALERTING");
-		vc->originating = TRUE;
-		g_free(last_dialed_number);
-		last_dialed_number = g_strdup(vc->number);
-		telephony_update_indicator(ofono_indicators, "callsetup",
-					EV_CALLSETUP_ALERTING);
-		break;
-	case CALL_STATUS_WAITING:
-		DBG("CALL_STATUS_WAITING");
-		vc->originating = FALSE;
-		telephony_update_indicator(ofono_indicators, "callsetup",
-					EV_CALLSETUP_INCOMING);
-		telephony_call_waiting_ind(vc->number, NUMBER_TYPE_TELEPHONY);
-		break;
-	}
-
-	return vc;
-}
-
-static void remove_pending(DBusPendingCall *call)
-{
-	pending = g_slist_remove(pending, call);
-	dbus_pending_call_unref(call);
-}
-
-static void call_added(const char *path, DBusMessageIter *properties)
-{
-	struct voice_call *vc;
-
-	DBG("%s", path);
-
-	vc = find_vc(path);
-	if (vc)
-		return;
-
-	vc = call_new(path, properties);
-	calls = g_slist_prepend(calls, vc);
-}
-
-static void get_calls_reply(DBusPendingCall *call, void *user_data)
-{
-	DBusError err;
-	DBusMessage *reply;
-	DBusMessageIter iter, entry;
-
-	DBG("");
-	reply = dbus_pending_call_steal_reply(call);
-
-	dbus_error_init(&err);
-	if (dbus_set_error_from_message(&err, reply)) {
-		error("ofono replied with an error: %s, %s",
-				err.name, err.message);
-		dbus_error_free(&err);
-		goto done;
-	}
-
-	dbus_message_iter_init(reply, &iter);
-
-	if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_ARRAY) {
-		error("Unexpected signature");
-		goto done;
-	}
-
-	dbus_message_iter_recurse(&iter, &entry);
-
-	while (dbus_message_iter_get_arg_type(&entry)
-						== DBUS_TYPE_STRUCT) {
-		const char *path;
-		DBusMessageIter value, properties;
-
-		dbus_message_iter_recurse(&entry, &value);
-		dbus_message_iter_get_basic(&value, &path);
-
-		dbus_message_iter_next(&value);
-		dbus_message_iter_recurse(&value, &properties);
-
-		call_added(path, &properties);
-
-		dbus_message_iter_next(&entry);
-	}
-
-done:
-	dbus_message_unref(reply);
-	remove_pending(call);
-}
-
-static void handle_network_property(const char *property, DBusMessageIter *variant)
-{
-	const char *status, *operator;
-	unsigned int signals_bar;
-
-	if (g_str_equal(property, "Status")) {
-		dbus_message_iter_get_basic(variant, &status);
-		DBG("Status is %s", status);
-		if (g_str_equal(status, "registered")) {
-			net.status = NETWORK_REG_STATUS_HOME;
-			telephony_update_indicator(ofono_indicators,
-						"roam", EV_ROAM_INACTIVE);
-			telephony_update_indicator(ofono_indicators,
-						"service", EV_SERVICE_PRESENT);
-		} else if (g_str_equal(status, "roaming")) {
-			net.status = NETWORK_REG_STATUS_ROAM;
-			telephony_update_indicator(ofono_indicators,
-						"roam", EV_ROAM_ACTIVE);
-			telephony_update_indicator(ofono_indicators,
-						"service", EV_SERVICE_PRESENT);
-		} else {
-			net.status = NETWORK_REG_STATUS_NOSERV;
-			telephony_update_indicator(ofono_indicators,
-						"roam", EV_ROAM_INACTIVE);
-			telephony_update_indicator(ofono_indicators,
-						"service", EV_SERVICE_NONE);
-		}
-	} else if (g_str_equal(property, "Name")) {
-		dbus_message_iter_get_basic(variant, &operator);
-		DBG("Operator is %s", operator);
-		g_free(net.operator_name);
-		net.operator_name = g_strdup(operator);
-	} else if (g_str_equal(property, "SignalStrength")) {
-		dbus_message_iter_get_basic(variant, &signals_bar);
-		DBG("SignalStrength is %d", signals_bar);
-		net.signals_bar = signals_bar;
-		telephony_update_indicator(ofono_indicators, "signal",
-						(signals_bar + 20) / 21);
-	}
-}
-
-static int parse_network_properties(DBusMessageIter *properties)
-{
-	int i;
-
-	/* Reset indicators */
-	for (i = 0; ofono_indicators[i].desc != NULL; i++) {
-		if (g_str_equal(ofono_indicators[i].desc, "battchg"))
-			ofono_indicators[i].val = 5;
-		else
-			ofono_indicators[i].val = 0;
-	}
-
-	while (dbus_message_iter_get_arg_type(properties)
-						== DBUS_TYPE_DICT_ENTRY) {
-		const char *key;
-		DBusMessageIter value, entry;
-
-		dbus_message_iter_recurse(properties, &entry);
-		dbus_message_iter_get_basic(&entry, &key);
-
-		dbus_message_iter_next(&entry);
-		dbus_message_iter_recurse(&entry, &value);
-
-		handle_network_property(key, &value);
-
-		dbus_message_iter_next(properties);
-	}
-
-	return 0;
-}
-
-static void get_properties_reply(DBusPendingCall *call, void *user_data)
-{
-	DBusError err;
-	DBusMessage *reply;
-	DBusMessageIter iter, properties;
-	int ret = 0;
-
-	DBG("");
-	reply = dbus_pending_call_steal_reply(call);
-
-	dbus_error_init(&err);
-	if (dbus_set_error_from_message(&err, reply)) {
-		error("ofono replied with an error: %s, %s",
-				err.name, err.message);
-		dbus_error_free(&err);
-		goto done;
-	}
-
-	dbus_message_iter_init(reply, &iter);
-
-	if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_ARRAY) {
-		error("Unexpected signature");
-		goto done;
-	}
-
-	dbus_message_iter_recurse(&iter, &properties);
-
-	ret = parse_network_properties(&properties);
-	if (ret < 0) {
-		error("Unable to parse %s.GetProperty reply",
-						OFONO_NETWORKREG_INTERFACE);
-		goto done;
-	}
-
-	ret = send_method_call(OFONO_BUS_NAME, modem_obj_path,
-				OFONO_VCMANAGER_INTERFACE, "GetCalls",
-				get_calls_reply, NULL, DBUS_TYPE_INVALID);
-	if (ret < 0)
-		error("Unable to send %s.GetCalls",
-						OFONO_VCMANAGER_INTERFACE);
-
-done:
-	dbus_message_unref(reply);
-	remove_pending(call);
-}
-
-static void network_found(const char *path)
-{
-	int ret;
-
-	DBG("%s", path);
-
-	modem_obj_path = g_strdup(path);
-
-	ret = send_method_call(OFONO_BUS_NAME, path,
-				OFONO_NETWORKREG_INTERFACE, "GetProperties",
-				get_properties_reply, NULL, DBUS_TYPE_INVALID);
-	if (ret < 0)
-		error("Unable to send %s.GetProperties",
-						OFONO_NETWORKREG_INTERFACE);
-}
-
-static void modem_removed(const char *path)
-{
-	if (g_strcmp0(modem_obj_path, path) != 0)
-		return;
-
-	DBG("%s", path);
-
-	g_slist_free_full(calls, call_free);
-	calls = NULL;
-
-	g_free(net.operator_name);
-	net.operator_name = NULL;
-	net.status = NETWORK_REG_STATUS_NOSERV;
-	net.signals_bar = 0;
-
-	g_free(modem_obj_path);
-	modem_obj_path = NULL;
-}
-
-static void parse_modem_interfaces(const char *path, DBusMessageIter *ifaces)
-{
-	DBG("%s", path);
-
-	while (dbus_message_iter_get_arg_type(ifaces) == DBUS_TYPE_STRING) {
-		const char *iface;
-
-		dbus_message_iter_get_basic(ifaces, &iface);
-
-		if (g_str_equal(iface, OFONO_NETWORKREG_INTERFACE)) {
-			network_found(path);
-			return;
-		}
-
-		dbus_message_iter_next(ifaces);
-	}
-
-	modem_removed(path);
-}
-
-static void modem_added(const char *path, DBusMessageIter *properties)
-{
-	if (modem_obj_path != NULL) {
-		DBG("Ignoring, modem already exist");
-		return;
-	}
-
-	DBG("%s", path);
-
-	while (dbus_message_iter_get_arg_type(properties)
-						== DBUS_TYPE_DICT_ENTRY) {
-		const char *key;
-		DBusMessageIter interfaces, value, entry;
-
-		dbus_message_iter_recurse(properties, &entry);
-		dbus_message_iter_get_basic(&entry, &key);
-
-		dbus_message_iter_next(&entry);
-		dbus_message_iter_recurse(&entry, &value);
-
-		if (strcasecmp(key, "Interfaces") != 0)
-			goto next;
-
-		if (dbus_message_iter_get_arg_type(&value)
-							!= DBUS_TYPE_ARRAY) {
-			error("Invalid Signature");
-			return;
-		}
-
-		dbus_message_iter_recurse(&value, &interfaces);
-
-		parse_modem_interfaces(path, &interfaces);
-
-		if (modem_obj_path != NULL)
-			return;
-
-	next:
-		dbus_message_iter_next(properties);
-	}
-}
-
-static void get_modems_reply(DBusPendingCall *call, void *user_data)
-{
-	DBusError err;
-	DBusMessage *reply;
-	DBusMessageIter iter, entry;
-
-	DBG("");
-	reply = dbus_pending_call_steal_reply(call);
-
-	dbus_error_init(&err);
-	if (dbus_set_error_from_message(&err, reply)) {
-		error("ofono replied with an error: %s, %s",
-				err.name, err.message);
-		dbus_error_free(&err);
-		goto done;
-	}
-
-	/* Skip modem selection if a modem already exist */
-	if (modem_obj_path != NULL)
-		goto done;
-
-	dbus_message_iter_init(reply, &iter);
-
-	if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_ARRAY) {
-		error("Unexpected signature");
-		goto done;
-	}
-
-	dbus_message_iter_recurse(&iter, &entry);
-
-	while (dbus_message_iter_get_arg_type(&entry)
-						== DBUS_TYPE_STRUCT) {
-		const char *path;
-		DBusMessageIter item, properties;
-
-		dbus_message_iter_recurse(&entry, &item);
-		dbus_message_iter_get_basic(&item, &path);
-
-		dbus_message_iter_next(&item);
-		dbus_message_iter_recurse(&item, &properties);
-
-		modem_added(path, &properties);
-		if (modem_obj_path != NULL)
-			break;
-
-		dbus_message_iter_next(&entry);
-	}
-
-done:
-	dbus_message_unref(reply);
-	remove_pending(call);
-}
-
-static gboolean handle_network_property_changed(DBusConnection *conn,
-						DBusMessage *msg, void *data)
-{
-	DBusMessageIter iter, variant;
-	const char *property;
-
-	dbus_message_iter_init(msg, &iter);
-
-	if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_STRING) {
-		error("Unexpected signature in networkregistration"
-					" PropertyChanged signal");
-		return TRUE;
-	}
-	dbus_message_iter_get_basic(&iter, &property);
-	DBG("in handle_registration_property_changed(),"
-					" the property is %s", property);
-
-	dbus_message_iter_next(&iter);
-	dbus_message_iter_recurse(&iter, &variant);
-
-	handle_network_property(property, &variant);
-
-	return TRUE;
-}
-
-static void handle_modem_property(const char *path, const char *property,
-						DBusMessageIter *variant)
-{
-	DBG("%s", property);
-
-	if (g_str_equal(property, "Interfaces")) {
-		DBusMessageIter interfaces;
-
-		if (dbus_message_iter_get_arg_type(variant)
-							!= DBUS_TYPE_ARRAY) {
-			error("Invalid signature");
-			return;
-		}
-
-		dbus_message_iter_recurse(variant, &interfaces);
-		parse_modem_interfaces(path, &interfaces);
-	}
-}
-
-static gboolean handle_modem_property_changed(DBusConnection *conn,
-						DBusMessage *msg, void *data)
-{
-	DBusMessageIter iter, variant;
-	const char *property, *path;
-
-	path = dbus_message_get_path(msg);
-
-	/* Ignore if modem already exist and paths doesn't match */
-	if (modem_obj_path != NULL &&
-				g_str_equal(path, modem_obj_path) == FALSE)
-		return TRUE;
-
-	dbus_message_iter_init(msg, &iter);
-
-	if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_STRING) {
-		error("Unexpected signature in %s.%s PropertyChanged signal",
-					dbus_message_get_interface(msg),
-					dbus_message_get_member(msg));
-		return TRUE;
-	}
-
-	dbus_message_iter_get_basic(&iter, &property);
-
-	dbus_message_iter_next(&iter);
-	dbus_message_iter_recurse(&iter, &variant);
-
-	handle_modem_property(path, property, &variant);
-
-	return TRUE;
-}
-
-static gboolean handle_vcmanager_call_added(DBusConnection *conn,
-						DBusMessage *msg, void *data)
-{
-	DBusMessageIter iter, properties;
-	const char *path = dbus_message_get_path(msg);
-
-	/* Ignore call if modem path doesn't math */
-	if (g_strcmp0(modem_obj_path, path) != 0)
-		return TRUE;
-
-	dbus_message_iter_init(msg, &iter);
-
-	if (dbus_message_iter_get_arg_type(&iter)
-						!= DBUS_TYPE_OBJECT_PATH) {
-		error("Unexpected signature in %s.%s signal",
-					dbus_message_get_interface(msg),
-					dbus_message_get_member(msg));
-		return TRUE;
-	}
-
-	dbus_message_iter_get_basic(&iter, &path);
-	dbus_message_iter_next(&iter);
-	dbus_message_iter_recurse(&iter, &properties);
-
-	call_added(path, &properties);
-
-	return TRUE;
-}
-
-static void call_removed(const char *path)
-{
-	struct voice_call *vc;
-
-	DBG("%s", path);
-
-	vc = find_vc(path);
-	if (vc == NULL)
-		return;
-
-	calls = g_slist_remove(calls, vc);
-	call_free(vc);
-}
-
-static gboolean handle_vcmanager_call_removed(DBusConnection *conn,
-						DBusMessage *msg, void *data)
-{
-	const char *path = dbus_message_get_path(msg);
-
-	/* Ignore call if modem path doesn't math */
-	if (g_strcmp0(modem_obj_path, path) != 0)
-		return TRUE;
-
-	if (!dbus_message_get_args(msg, NULL,
-				DBUS_TYPE_OBJECT_PATH, &path,
-				DBUS_TYPE_INVALID)) {
-		error("Unexpected signature in %s.%s signal",
-					dbus_message_get_interface(msg),
-					dbus_message_get_member(msg));
-		return TRUE;
-	}
-
-	call_removed(path);
-
-	return TRUE;
-}
-
-static gboolean handle_manager_modem_added(DBusConnection *conn,
-						DBusMessage *msg, void *data)
-{
-	DBusMessageIter iter, properties;
-	const char *path;
-
-	if (modem_obj_path != NULL)
-		return TRUE;
-
-	dbus_message_iter_init(msg, &iter);
-
-	if (dbus_message_iter_get_arg_type(&iter)
-						!= DBUS_TYPE_OBJECT_PATH) {
-		error("Unexpected signature in %s.%s signal",
-					dbus_message_get_interface(msg),
-					dbus_message_get_member(msg));
-		return TRUE;
-	}
-
-	dbus_message_iter_get_basic(&iter, &path);
-	dbus_message_iter_next(&iter);
-	dbus_message_iter_recurse(&iter, &properties);
-
-	modem_added(path, &properties);
-
-	return TRUE;
-}
-
-static gboolean handle_manager_modem_removed(DBusConnection *conn,
-						DBusMessage *msg, void *data)
-{
-	const char *path;
-
-	if (!dbus_message_get_args(msg, NULL,
-				DBUS_TYPE_OBJECT_PATH, &path,
-				DBUS_TYPE_INVALID)) {
-		error("Unexpected signature in %s.%s signal",
-					dbus_message_get_interface(msg),
-					dbus_message_get_member(msg));
-		return TRUE;
-	}
-
-	modem_removed(path);
-
-	return TRUE;
-}
-
-static void hal_battery_level_reply(DBusPendingCall *call, void *user_data)
-{
-	DBusMessage *reply;
-	DBusError err;
-	dbus_int32_t level;
-	int *value = user_data;
-
-	reply = dbus_pending_call_steal_reply(call);
-
-	dbus_error_init(&err);
-	if (dbus_set_error_from_message(&err, reply)) {
-		error("hald replied with an error: %s, %s",
-				err.name, err.message);
-		dbus_error_free(&err);
-		goto done;
-	}
-
-	dbus_error_init(&err);
-	if (dbus_message_get_args(reply, &err,
-				DBUS_TYPE_INT32, &level,
-				DBUS_TYPE_INVALID) == FALSE) {
-		error("Unable to parse GetPropertyInteger reply: %s, %s",
-							err.name, err.message);
-		dbus_error_free(&err);
-		goto done;
-	}
-
-	*value = (int) level;
-
-	if (value == &battchg_last)
-		DBG("telephony-ofono: battery.charge_level.last_full"
-					" is %d", *value);
-	else if (value == &battchg_design)
-		DBG("telephony-ofono: battery.charge_level.design"
-					" is %d", *value);
-	else
-		DBG("telephony-ofono: battery.charge_level.current"
-					" is %d", *value);
-
-	if ((battchg_design > 0 || battchg_last > 0) && battchg_cur >= 0) {
-		int new, max;
-
-		if (battchg_last > 0)
-			max = battchg_last;
-		else
-			max = battchg_design;
-
-		new = battchg_cur * 5 / max;
-
-		telephony_update_indicator(ofono_indicators, "battchg", new);
-	}
-done:
-	dbus_message_unref(reply);
-	remove_pending(call);
-}
-
-static void hal_get_integer(const char *path, const char *key, void *user_data)
-{
-	send_method_call("org.freedesktop.Hal", path,
-			"org.freedesktop.Hal.Device",
-			"GetPropertyInteger",
-			hal_battery_level_reply, user_data,
-			DBUS_TYPE_STRING, &key,
-			DBUS_TYPE_INVALID);
-}
-
-static gboolean handle_hal_property_modified(DBusConnection *conn,
-						DBusMessage *msg, void *data)
-{
-	const char *path;
-	DBusMessageIter iter, array;
-	dbus_int32_t num_changes;
-
-	path = dbus_message_get_path(msg);
-
-	dbus_message_iter_init(msg, &iter);
-
-	if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_INT32) {
-		error("Unexpected signature in hal PropertyModified signal");
-		return TRUE;
-	}
-
-	dbus_message_iter_get_basic(&iter, &num_changes);
-	dbus_message_iter_next(&iter);
-
-	if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_ARRAY) {
-		error("Unexpected signature in hal PropertyModified signal");
-		return TRUE;
-	}
-
-	dbus_message_iter_recurse(&iter, &array);
-
-	while (dbus_message_iter_get_arg_type(&array) != DBUS_TYPE_INVALID) {
-		DBusMessageIter prop;
-		const char *name;
-		dbus_bool_t added, removed;
-
-		dbus_message_iter_recurse(&array, &prop);
-
-		if (!iter_get_basic_args(&prop,
-					DBUS_TYPE_STRING, &name,
-					DBUS_TYPE_BOOLEAN, &added,
-					DBUS_TYPE_BOOLEAN, &removed,
-					DBUS_TYPE_INVALID)) {
-			error("Invalid hal PropertyModified parameters");
-			break;
-		}
-
-		if (g_str_equal(name, "battery.charge_level.last_full"))
-			hal_get_integer(path, name, &battchg_last);
-		else if (g_str_equal(name, "battery.charge_level.current"))
-			hal_get_integer(path, name, &battchg_cur);
-		else if (g_str_equal(name, "battery.charge_level.design"))
-			hal_get_integer(path, name, &battchg_design);
-
-		dbus_message_iter_next(&array);
-	}
-
-	return TRUE;
-}
-
-static void add_watch(const char *sender, const char *path,
-				const char *interface, const char *member,
-				GDBusSignalFunction function)
-{
-	guint watch;
-
-	watch = g_dbus_add_signal_watch(connection, sender, path, interface,
-					member, function, NULL, NULL);
-
-	watches = g_slist_prepend(watches, GUINT_TO_POINTER(watch));
-}
-
-static void hal_find_device_reply(DBusPendingCall *call, void *user_data)
-{
-	DBusMessage *reply;
-	DBusError err;
-	DBusMessageIter iter, sub;
-	int type;
-	const char *path;
-
-	DBG("begin of hal_find_device_reply()");
-	reply = dbus_pending_call_steal_reply(call);
-
-	dbus_error_init(&err);
-
-	if (dbus_set_error_from_message(&err, reply)) {
-		error("hald replied with an error: %s, %s",
-				err.name, err.message);
-		dbus_error_free(&err);
-		goto done;
-	}
-
-	dbus_message_iter_init(reply, &iter);
-
-	if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_ARRAY) {
-		error("Unexpected signature in hal_find_device_reply()");
-		goto done;
-	}
-
-	dbus_message_iter_recurse(&iter, &sub);
-
-	type = dbus_message_iter_get_arg_type(&sub);
-
-	if (type != DBUS_TYPE_OBJECT_PATH && type != DBUS_TYPE_STRING) {
-		error("No hal device with battery capability found");
-		goto done;
-	}
-
-	dbus_message_iter_get_basic(&sub, &path);
-
-	DBG("telephony-ofono: found battery device at %s", path);
-
-	add_watch(NULL, path, "org.freedesktop.Hal.Device",
-			"PropertyModified", handle_hal_property_modified);
-
-	hal_get_integer(path, "battery.charge_level.last_full", &battchg_last);
-	hal_get_integer(path, "battery.charge_level.current", &battchg_cur);
-	hal_get_integer(path, "battery.charge_level.design", &battchg_design);
-done:
-	dbus_message_unref(reply);
-	remove_pending(call);
-}
-
-static void handle_service_connect(DBusConnection *conn, void *user_data)
-{
-	DBG("telephony-ofono: %s found", OFONO_BUS_NAME);
-
-	send_method_call(OFONO_BUS_NAME, OFONO_PATH,
-				OFONO_MANAGER_INTERFACE, "GetModems",
-				get_modems_reply, NULL, DBUS_TYPE_INVALID);
-}
-
-static void handle_service_disconnect(DBusConnection *conn, void *user_data)
-{
-	DBG("telephony-ofono: %s exitted", OFONO_BUS_NAME);
-
-	if (modem_obj_path)
-		modem_removed(modem_obj_path);
-}
-
-int telephony_init(void)
-{
-	uint32_t features = AG_FEATURE_EC_ANDOR_NR |
-				AG_FEATURE_INBAND_RINGTONE |
-				AG_FEATURE_REJECT_A_CALL |
-				AG_FEATURE_ENHANCED_CALL_STATUS |
-				AG_FEATURE_ENHANCED_CALL_CONTROL |
-				AG_FEATURE_EXTENDED_ERROR_RESULT_CODES |
-				AG_FEATURE_THREE_WAY_CALLING;
-	const char *battery_cap = "battery";
-	int ret;
-	guint watch;
-
-	connection = dbus_bus_get(DBUS_BUS_SYSTEM, NULL);
-
-	add_watch(OFONO_BUS_NAME, NULL, OFONO_MODEM_INTERFACE,
-			"PropertyChanged", handle_modem_property_changed);
-	add_watch(OFONO_BUS_NAME, NULL, OFONO_NETWORKREG_INTERFACE,
-			"PropertyChanged", handle_network_property_changed);
-	add_watch(OFONO_BUS_NAME, NULL, OFONO_MANAGER_INTERFACE,
-			"ModemAdded", handle_manager_modem_added);
-	add_watch(OFONO_BUS_NAME, NULL, OFONO_MANAGER_INTERFACE,
-			"ModemRemoved", handle_manager_modem_removed);
-	add_watch(OFONO_BUS_NAME, NULL, OFONO_VCMANAGER_INTERFACE,
-			"CallAdded", handle_vcmanager_call_added);
-	add_watch(OFONO_BUS_NAME, NULL, OFONO_VCMANAGER_INTERFACE,
-			"CallRemoved", handle_vcmanager_call_removed);
-
-	watch = g_dbus_add_service_watch(connection, OFONO_BUS_NAME,
-						handle_service_connect,
-						handle_service_disconnect,
-						NULL, NULL);
-	if (watch == 0)
-		return -ENOMEM;
-
-	watches = g_slist_prepend(watches, GUINT_TO_POINTER(watch));
-
-	ret = send_method_call("org.freedesktop.Hal",
-				"/org/freedesktop/Hal/Manager",
-				"org.freedesktop.Hal.Manager",
-				"FindDeviceByCapability",
-				hal_find_device_reply, NULL,
-				DBUS_TYPE_STRING, &battery_cap,
-				DBUS_TYPE_INVALID);
-	if (ret < 0)
-		return ret;
-
-	DBG("telephony_init() successfully");
-
-	telephony_ready_ind(features, ofono_indicators, BTRH_NOT_SUPPORTED,
-								chld_str);
-
-	return ret;
-}
-
-static void remove_watch(gpointer data)
-{
-	g_dbus_remove_watch(connection, GPOINTER_TO_UINT(data));
-}
-
-static void pending_free(void *data)
-{
-	DBusPendingCall *call = data;
-
-	if (!dbus_pending_call_get_completed(call))
-		dbus_pending_call_cancel(call);
-
-	dbus_pending_call_unref(call);
-}
-
-void telephony_exit(void)
-{
-	DBG("");
-
-	g_free(last_dialed_number);
-	last_dialed_number = NULL;
-
-	if (modem_obj_path)
-		modem_removed(modem_obj_path);
-
-	g_slist_free_full(watches, remove_watch);
-	watches = NULL;
-
-	g_slist_free_full(pending, pending_free);
-	pending = NULL;
-
-	dbus_connection_unref(connection);
-	connection = NULL;
-
-	telephony_deinit();
-}
diff --git a/audio/telephony.h b/audio/telephony.h
index 7d1d337..aa23bef 100644
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
@@ -52,95 +45,6 @@
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
@@ -152,80 +56,5 @@ void telephony_device_disconnected(void *telephony_device);
 gboolean telephony_get_ready_state(void);
 uint32_t telephony_get_ag_features(void);
 
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
-
 int telephony_init(void *adapter);
 void telephony_exit(void *adapter);
diff --git a/audio/transport.c b/audio/transport.c
index 7bde32d..3c7828d 100644
--- a/audio/transport.c
+++ b/audio/transport.c
@@ -845,14 +845,18 @@ static void get_properties_a2dp(struct media_transport *transport,
 static void get_properties_headset(struct media_transport *transport,
 						DBusMessageIter *dict)
 {
+#if 0
 	gboolean nrec, inband;
+#endif
 	const char *routing;
 
+#if 0
 	nrec = headset_get_nrec(transport->device);
 	dict_append_entry(dict, "NREC", DBUS_TYPE_BOOLEAN, &nrec);
 
 	inband = headset_get_inband(transport->device);
 	dict_append_entry(dict, "InbandRingtone", DBUS_TYPE_BOOLEAN, &inband);
+#endif
 
 	routing = headset_get_sco_hci(transport->device) ? "HCI" : "PCM";
 	dict_append_entry(dict, "Routing", DBUS_TYPE_STRING, &routing);
@@ -944,8 +948,10 @@ static void media_transport_free(void *data)
 	if (transport->session)
 		avdtp_unref(transport->session);
 
+#if 0
 	if (transport->nrec_id)
 		headset_remove_nrec_cb(transport->device, transport->nrec_id);
+#endif
 
 	if (transport->conn)
 		dbus_connection_unref(transport->conn);
@@ -955,6 +961,7 @@ static void media_transport_free(void *data)
 	g_free(transport);
 }
 
+#if 0
 static void headset_nrec_changed(struct audio_device *dev, gboolean nrec,
 							void *user_data)
 {
@@ -966,6 +973,7 @@ static void headset_nrec_changed(struct audio_device *dev, gboolean nrec,
 				MEDIA_TRANSPORT_INTERFACE, "NREC",
 				DBUS_TYPE_BOOLEAN, &nrec);
 }
+#endif
 
 struct media_transport *media_transport_create(DBusConnection *conn,
 						struct media_endpoint *endpoint,
@@ -1002,9 +1010,11 @@ struct media_transport *media_transport_create(DBusConnection *conn,
 		transport->cancel = cancel_headset;
 		transport->get_properties = get_properties_headset;
 		transport->set_property = set_property_headset;
+#if 0
 		transport->nrec_id = headset_add_nrec_cb(device,
 							headset_nrec_changed,
 							transport);
+#endif
 	} else if (strcasecmp(uuid, HFP_HS_UUID) == 0 ||
 			strcasecmp(uuid, HSP_HS_UUID) == 0) {
 		transport->resume = resume_gateway;
diff --git a/audio/unix.c b/audio/unix.c
index 5199831..24a6669 100644
--- a/audio/unix.c
+++ b/audio/unix.c
@@ -261,8 +261,10 @@ static uint8_t headset_generate_capability(struct audio_device *dev,
 	pcm = (void *) codec;
 	pcm->sampling_rate = 8000;
 	if (dev->headset) {
+#if 0
 		if (headset_get_nrec(dev))
 			pcm->flags |= BT_PCM_FLAG_NREC;
+#endif
 		if (!headset_get_sco_hci(dev))
 			pcm->flags |= BT_PCM_FLAG_PCM_ROUTING;
 		codec->configured = headset_is_active(dev);
-- 
1.7.1

