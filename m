Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?=
	<frederic.danis@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v16 03/14] audio: Simplify org.bluez.Headset
Date: Wed,  1 Aug 2012 11:08:39 +0200
Message-Id: <1343812131-19395-4-git-send-email-frederic.danis@linux.intel.com>
In-Reply-To: <1343812131-19395-1-git-send-email-frederic.danis@linux.intel.com>
References: <1343812131-19395-1-git-send-email-frederic.danis@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Simplify org.bluez.Headset interface by removing methods, signal and
properties which should be managed by external telephony program.
In audio/headset.[ch], remove functions no more used by telephony
drivers.

Move SpeakerGain and MicrophoneGain properties to Media Transport.
---
 Makefile.am       |    4 +-
 audio/audio.conf  |    7 -
 audio/headset.c   |  939 +----------------------------------------------------
 audio/headset.h   |    5 -
 audio/manager.c   |   19 --
 audio/manager.h   |    4 -
 audio/telephony.h |  171 ----------
 audio/transport.c |   90 +++--
 doc/audio-api.txt |  167 ++--------
 doc/media-api.txt |   19 +-
 10 files changed, 106 insertions(+), 1319 deletions(-)

diff --git a/Makefile.am b/Makefile.am
index 2a8b903..b18450c 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -315,9 +315,7 @@ endif
 EXTRA_DIST += src/genbuiltin src/bluetooth.conf src/org.bluez.service \
 			src/main.conf profiles/network/network.conf \
 			profiles/input/input.conf profiles/proximity/proximity.conf \
-			audio/audio.conf audio/telephony-dummy.c \
-			audio/telephony-maemo5.c audio/telephony-ofono.c \
-			audio/telephony-maemo6.c profiles/sap/sap-dummy.c \
+			audio/audio.conf profiles/sap/sap-dummy.c \
 			profiles/sap/sap-u8500.c
 
 if AUDIOPLUGIN
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
index 668e9f1..0070953 100644
--- a/audio/headset.c
+++ b/audio/headset.c
@@ -63,35 +63,7 @@
 
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
@@ -129,30 +101,12 @@ struct pending_connect {
 	uint16_t svclass;
 };
 
-struct headset_slc {
-	struct telephony_device *tel_dev;
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
 
 	int rfcomm_ch;
 
-	GIOChannel *rfcomm;
 	GIOChannel *tmp_rfcomm;
 	const char *connecting_uuid;
 	GIOChannel *sco;
@@ -170,15 +124,10 @@ struct headset {
 	struct pending_connect *pending;
 
 	headset_lock_t lock;
-	struct headset_slc *slc;
+	struct telephony_device *tel_dev;
 	GSList *nrec_cbs;
 };
 
-struct event {
-	const char *cmd;
-	int (*callback) (struct audio_device *device, const char *buf);
-};
-
 static GSList *headset_callbacks = NULL;
 
 static void error_connect_failed(DBusConnection *conn, DBusMessage *msg,
@@ -194,44 +143,6 @@ static int rfcomm_connect(struct audio_device *device, headset_stream_cb_t cb,
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
@@ -249,52 +160,6 @@ static const char *state2str(headset_state_t state)
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
@@ -375,64 +240,11 @@ static unsigned int connect_cb_new(struct headset *hs,
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
@@ -445,7 +257,7 @@ static void sco_connect_cb(GIOChannel *chan, GError *err, gpointer user_data)
 			pending_connect_finalize(dev);
 		}
 
-		if (hs->rfcomm)
+		if (hs->tel_dev)
 			headset_set_state(dev, HEADSET_STATE_CONNECTED);
 		else
 			headset_set_state(dev, HEADSET_STATE_DISCONNECTED);
@@ -473,14 +285,6 @@ static void sco_connect_cb(GIOChannel *chan, GError *err, gpointer user_data)
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
@@ -519,14 +323,6 @@ static int sco_connect(struct audio_device *dev, headset_stream_cb_t cb,
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
 void headset_profile_connection_complete(struct audio_device *dev)
 {
 	struct headset *hs = dev->headset;
@@ -556,202 +352,6 @@ void headset_profile_connection_complete(struct audio_device *dev)
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
-	uint32_t ag_features;
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
-	ag_features = telephony_get_ag_features();
-	if (slc->hf_features & HF_FEATURE_CALL_WAITING_AND_3WAY &&
-			ag_features & AG_FEATURE_THREE_WAY_CALLING)
-		return 0;
-
-	headset_profile_connection_complete(device);
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
@@ -792,7 +392,6 @@ void headset_connect_cb(GIOChannel *chan, GError *err, gpointer user_data)
 	struct btd_adapter *adapter;
 	struct pending_connect *p = hs->pending;
 	char hs_address[18];
-	struct telephony_device *tel_dev;
 
 	if (err) {
 		error("%s", err->message);
@@ -808,14 +407,14 @@ void headset_connect_cb(GIOChannel *chan, GError *err, gpointer user_data)
 		goto failed;
 	}
 
-	tel_dev = telephony_device_connecting(chan, btd_dev, dev,
+	hs->tel_dev = telephony_device_connecting(chan, btd_dev, dev,
 							hs->connecting_uuid);
-	if (tel_dev == NULL)
+	if (hs->tel_dev == NULL)
 		goto failed;
 
 	hs->connecting_uuid = NULL;
 
-	hs->rfcomm = hs->tmp_rfcomm;
+	g_io_channel_unref(hs->tmp_rfcomm);
 	hs->tmp_rfcomm = NULL;
 
 	ba2str(&dev->dst, hs_address);
@@ -827,12 +426,6 @@ void headset_connect_cb(GIOChannel *chan, GError *err, gpointer user_data)
 
 	DBG("%s: Connected to %s", dev->path, hs_address);
 
-	hs->slc = g_new0(struct headset_slc, 1);
-	hs->slc->tel_dev = tel_dev;
-	hs->slc->sp_gain = 15;
-	hs->slc->mic_gain = 15;
-	hs->slc->nrec = TRUE;
-
 	return;
 
 failed:
@@ -840,10 +433,7 @@ failed:
 		error_connect_failed(dev->conn, p->msg, p->err);
 	pending_connect_finalize(dev);
 
-	if (hs->rfcomm)
-		headset_set_state(dev, HEADSET_STATE_CONNECTED);
-	else
-		headset_set_state(dev, HEADSET_STATE_DISCONNECTED);
+	headset_set_state(dev, HEADSET_STATE_DISCONNECTED);
 }
 
 static int headset_set_channel(struct headset *headset,
@@ -1105,26 +695,6 @@ static DBusMessage *hs_disconnect(DBusConnection *conn, DBusMessage *msg,
 
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
@@ -1156,95 +726,6 @@ static DBusMessage *hs_connect(DBusConnection *conn, DBusMessage *msg,
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
@@ -1280,94 +761,22 @@ static DBusMessage *hs_get_properties(DBusConnection *conn,
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
@@ -1418,13 +827,11 @@ void headset_update(struct audio_device *dev, uint16_t svc,
 static int headset_close_rfcomm(struct audio_device *dev)
 {
 	struct headset *hs = dev->headset;
-	GIOChannel *rfcomm = hs->tmp_rfcomm ? hs->tmp_rfcomm : hs->rfcomm;
 
-	if (rfcomm) {
-		g_io_channel_shutdown(rfcomm, TRUE, NULL);
-		g_io_channel_unref(rfcomm);
+	if (hs->tmp_rfcomm) {
+		g_io_channel_shutdown(hs->tmp_rfcomm, TRUE, NULL);
+		g_io_channel_unref(hs->tmp_rfcomm);
 		hs->tmp_rfcomm = NULL;
-		hs->rfcomm = NULL;
 	}
 
 	return 0;
@@ -1539,19 +946,6 @@ uint32_t headset_config_init(GKeyFile *config)
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
 
@@ -1590,7 +984,7 @@ gboolean headset_cancel_stream(struct audio_device *dev, unsigned int id)
 		return TRUE;
 
 	if (hs->auto_dc) {
-		if (hs->rfcomm)
+		if (hs->tel_dev)
 			hs->dc_timer = g_timeout_add_seconds(DC_TIMEOUT,
 						(GSourceFunc) hs_dc_timeout,
 						dev);
@@ -1629,7 +1023,7 @@ unsigned int headset_request_stream(struct audio_device *dev,
 			hs->state == HEADSET_STATE_PLAY_IN_PROGRESS)
 		return connect_cb_new(hs, HEADSET_STATE_PLAYING, cb, user_data);
 
-	if (hs->rfcomm == NULL) {
+	if (hs->tel_dev == NULL) {
 		if (rfcomm_connect(dev, cb, user_data, &id) < 0)
 			return 0;
 		hs->auto_dc = TRUE;
@@ -1658,7 +1052,7 @@ unsigned int headset_config_stream(struct audio_device *dev,
 		return connect_cb_new(hs, HEADSET_STATE_CONNECTED, cb,
 					user_data);
 
-	if (hs->rfcomm)
+	if (hs->tel_dev)
 		goto done;
 
 	if (rfcomm_connect(dev, cb, user_data, &id) < 0)
@@ -1766,29 +1160,18 @@ int headset_connect_rfcomm(struct audio_device *dev, GIOChannel *io)
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
@@ -1800,12 +1183,11 @@ void headset_set_state(struct audio_device *dev, headset_state_t state)
 
 	switch (state) {
 	case HEADSET_STATE_DISCONNECTED:
-		value = FALSE;
 		close_sco(dev);
 
-		if (dev->headset->slc) {
-			telephony_device_disconnect(slc->tel_dev);
-			slc->tel_dev = NULL;
+		if (dev->headset->tel_dev) {
+			telephony_device_disconnect(dev->headset->tel_dev);
+			dev->headset->tel_dev = NULL;
 		}
 
 		dev->headset->connecting_uuid = NULL;
@@ -1814,16 +1196,6 @@ void headset_set_state(struct audio_device *dev, headset_state_t state)
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
-		}
-		active_devices = g_slist_remove(active_devices, dev);
 		break;
 	case HEADSET_STATE_CONNECTING:
 		emit_property_changed(dev->conn, dev->path,
@@ -1836,38 +1208,10 @@ void headset_set_state(struct audio_device *dev, headset_state_t state)
 			emit_property_changed(dev->conn, dev->path,
 					AUDIO_HEADSET_INTERFACE, "State",
 					DBUS_TYPE_STRING, &state_str);
-		if (hs->state < state) {
-			if (telephony_get_ag_features() &
-					AG_FEATURE_INBAND_RINGTONE)
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
@@ -1877,18 +1221,6 @@ void headset_set_state(struct audio_device *dev, headset_state_t state)
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
 
@@ -1993,60 +1325,6 @@ int headset_get_sco_fd(struct audio_device *dev)
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
@@ -2063,193 +1341,6 @@ void headset_shutdown(struct audio_device *dev)
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
index d877eef..61e63c8 100644
--- a/audio/headset.h
+++ b/audio/headset.h
@@ -95,11 +95,6 @@ void headset_set_state(struct audio_device *dev, headset_state_t state);
 int headset_get_channel(struct audio_device *dev);
 
 int headset_get_sco_fd(struct audio_device *dev);
-gboolean headset_get_nrec(struct audio_device *dev);
-unsigned int headset_add_nrec_cb(struct audio_device *dev,
-					headset_nrec_cb cb, void *user_data);
-gboolean headset_remove_nrec_cb(struct audio_device *dev, unsigned int id);
-gboolean headset_get_inband(struct audio_device *dev);
 gboolean headset_get_sco_hci(struct audio_device *dev);
 
 gboolean headset_is_active(struct audio_device *dev);
diff --git a/audio/manager.c b/audio/manager.c
index 67193da..2b125a0 100644
--- a/audio/manager.c
+++ b/audio/manager.c
@@ -1425,22 +1425,3 @@ gboolean manager_allow_headset_connection(struct audio_device *device)
 
 	return TRUE;
 }
-
-void manager_set_fast_connectable(gboolean enable)
-{
-	GSList *l;
-
-	if (enable && !manager_allow_headset_connection(NULL)) {
-		DBG("Refusing enabling fast connectable");
-		return;
-	}
-
-	for (l = adapters; l != NULL; l = l->next) {
-		struct audio_adapter *adapter = l->data;
-
-		if (btd_adapter_set_fast_connectable(adapter->btd_adapter,
-								enable))
-			error("Changing fast connectable for hci%d failed",
-				adapter_get_dev_id(adapter->btd_adapter));
-	}
-}
diff --git a/audio/manager.h b/audio/manager.h
index f1d3021..85e5065 100644
--- a/audio/manager.h
+++ b/audio/manager.h
@@ -57,7 +57,3 @@ struct audio_device *manager_get_device(const bdaddr_t *src,
 					gboolean create);
 
 gboolean manager_allow_headset_connection(struct audio_device *device);
-
-/* TRUE to enable fast connectable and FALSE to disable fast connectable for all
- * audio adapters. */
-void manager_set_fast_connectable(gboolean enable);
diff --git a/audio/telephony.h b/audio/telephony.h
index f835202..1a4ab06 100644
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
 struct telephony_device;
 
 struct telephony_device *telephony_device_connecting(GIOChannel *io,
@@ -154,81 +58,6 @@ uint32_t telephony_get_ag_features(void);
 gboolean telephony_is_uuid_supported(struct btd_adapter *adapter,
 						const char *uuid);
 
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
 int telephony_adapter_init(struct btd_adapter *adapter);
 void telephony_adapter_exit(struct btd_adapter *adapter);
 int telephony_init(void);
diff --git a/audio/transport.c b/audio/transport.c
index 832ad2a..6d4ad55 100644
--- a/audio/transport.c
+++ b/audio/transport.c
@@ -70,7 +70,10 @@ struct a2dp_transport {
 
 struct headset_transport {
 	struct audio_device	*device;
-	unsigned int		nrec_id;
+	gboolean		nrec;
+	gboolean		inband;
+	uint16_t		output_gain;
+	uint16_t		input_gain;
 };
 
 struct media_transport {
@@ -788,26 +791,62 @@ static int set_property_headset(struct media_transport *transport,
 						const char *property,
 						DBusMessageIter *value)
 {
-	if (g_strcmp0(property, "NREC") == 0) {
-		gboolean nrec;
+	struct headset_transport *headset = transport->data;
 
+	if (g_strcmp0(property, "NREC") == 0) {
 		if (dbus_message_iter_get_arg_type(value) != DBUS_TYPE_BOOLEAN)
 			return -EINVAL;
-		dbus_message_iter_get_basic(value, &nrec);
+		dbus_message_iter_get_basic(value, &headset->nrec);
 
-		/* FIXME: set new nrec */
+		emit_property_changed(transport->conn, transport->path,
+					MEDIA_TRANSPORT_INTERFACE, "NREC",
+					DBUS_TYPE_BOOLEAN, &headset->nrec);
 		return 0;
 	} else if (g_strcmp0(property, "InbandRingtone") == 0) {
-		gboolean inband;
-
 		if (dbus_message_iter_get_arg_type(value) != DBUS_TYPE_BOOLEAN)
 			return -EINVAL;
-		dbus_message_iter_get_basic(value, &inband);
+		dbus_message_iter_get_basic(value, &headset->inband);
+
+		emit_property_changed(transport->conn, transport->path,
+					MEDIA_TRANSPORT_INTERFACE,
+					"InbandRingtone",
+					DBUS_TYPE_BOOLEAN, &headset->inband);
+		return 0;
+	} else if (g_strcmp0(property, "OutputGain") == 0) {
+		uint16_t gain;
+
+		if (dbus_message_iter_get_arg_type(value) != DBUS_TYPE_UINT16)
+			return -EINVAL;
+		dbus_message_iter_get_basic(value, &gain);
+
+		if (gain > 15)
+			goto failed;
+
+		headset->output_gain = gain;
+		emit_property_changed(transport->conn, transport->path,
+					MEDIA_TRANSPORT_INTERFACE,
+					"OutputGain", DBUS_TYPE_UINT16,
+					&headset->output_gain);
+		return 0;
+	} else if (g_strcmp0(property, "InputGain") == 0) {
+		uint16_t gain;
+
+		if (dbus_message_iter_get_arg_type(value) != DBUS_TYPE_UINT16)
+			return -EINVAL;
+		dbus_message_iter_get_basic(value, &gain);
+
+		if (gain > 15)
+			goto failed;
 
-		/* FIXME: set new inband */
+		headset->input_gain = gain;
+		emit_property_changed(transport->conn, transport->path,
+					MEDIA_TRANSPORT_INTERFACE,
+					"InputGain", DBUS_TYPE_UINT16,
+					&headset->input_gain);
 		return 0;
 	}
 
+failed:
 	return -EINVAL;
 }
 
@@ -879,14 +918,16 @@ static void get_properties_a2dp(struct media_transport *transport,
 static void get_properties_headset(struct media_transport *transport,
 						DBusMessageIter *dict)
 {
-	gboolean nrec, inband;
+	struct headset_transport *headset = transport->data;
 	const char *routing;
 
-	nrec = headset_get_nrec(transport->device);
-	dict_append_entry(dict, "NREC", DBUS_TYPE_BOOLEAN, &nrec);
-
-	inband = headset_get_inband(transport->device);
-	dict_append_entry(dict, "InbandRingtone", DBUS_TYPE_BOOLEAN, &inband);
+	dict_append_entry(dict, "NREC", DBUS_TYPE_BOOLEAN, &headset->nrec);
+	dict_append_entry(dict, "InbandRingtone", DBUS_TYPE_BOOLEAN,
+						&headset->inband);
+	dict_append_entry(dict, "OutputGain", DBUS_TYPE_UINT16,
+						&headset->output_gain);
+	dict_append_entry(dict, "InputGain", DBUS_TYPE_UINT16,
+						&headset->input_gain);
 
 	routing = headset_get_sco_hci(transport->device) ? "HCI" : "PCM";
 	dict_append_entry(dict, "Routing", DBUS_TYPE_STRING, &routing);
@@ -985,9 +1026,6 @@ static void destroy_headset(void *data)
 {
 	struct headset_transport *headset = data;
 
-	if (headset->nrec_id > 0)
-		headset_remove_nrec_cb(headset->device, headset->nrec_id);
-
 	g_free(headset);
 }
 
@@ -1015,18 +1053,6 @@ static void media_transport_free(void *data)
 	g_free(transport);
 }
 
-static void headset_nrec_changed(struct audio_device *dev, gboolean nrec,
-							void *user_data)
-{
-	struct media_transport *transport = user_data;
-
-	DBG("");
-
-	emit_property_changed(transport->conn, transport->path,
-				MEDIA_TRANSPORT_INTERFACE, "NREC",
-				DBUS_TYPE_BOOLEAN, &nrec);
-}
-
 struct media_transport *media_transport_create(DBusConnection *conn,
 						struct media_endpoint *endpoint,
 						struct audio_device *device,
@@ -1068,9 +1094,7 @@ struct media_transport *media_transport_create(DBusConnection *conn,
 
 		headset = g_new0(struct headset_transport, 1);
 		headset->device = device;
-		headset->nrec_id = headset_add_nrec_cb(device,
-							headset_nrec_changed,
-							transport);
+		headset->nrec = TRUE;
 
 		transport->resume = resume_headset;
 		transport->suspend = suspend_headset;
diff --git a/doc/audio-api.txt b/doc/audio-api.txt
index c620a7d..e8bb210 100644
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
diff --git a/doc/media-api.txt b/doc/media-api.txt
index e5eeaa0..4a3afd2 100644
--- a/doc/media-api.txt
+++ b/doc/media-api.txt
@@ -326,15 +326,12 @@ Properties	object Device [readonly]
 		boolean NREC [readwrite]
 
 			Optional. Indicates if echo cancelling and noise
-			reduction functions are active in the transport, this
-			property is only writeable when the transport was
-			acquired by the sender.
+			reduction functions are active in the transport.
 
 		boolean InbandRingtone [readwrite]
 
 			Optional. Indicates if the transport support sending
-			ringtones, this property is only writeable when the
-			transport was acquired by the sender.
+			ringtones.
 
 		string Routing [readonly]
 
@@ -349,3 +346,15 @@ Properties	object Device [readonly]
 			acquired by the sender.
 
 			Possible Values: 0-127
+
+		uint16 OutputGain  [readwrite]
+
+			Optional. The speaker gain when available.
+
+			Possible values: 0-15
+
+		uint16 InputGain  [readwrite]
+
+			Optional. The microphone gain when available.
+
+			Possible values: 0-15
-- 
1.7.9.5

