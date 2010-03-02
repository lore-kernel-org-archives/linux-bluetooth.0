Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Tue, 2 Mar 2010 23:09:00 +0200
Message-ID: <2d5a2c101003021309o34b63249ub5940f67112eab6a@mail.gmail.com>
Subject: [PATCH] Fix using invalid data from previous headset connection
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Data notiated in a session should be reset once disconnected, to fix this
a new structure is introduced called headset_session is introduced to hold
the session data which is freed when disconnected.
---
 audio/headset.c |  187 +++++++++++++++++++++++++++++++------------------------
 1 files changed, 106 insertions(+), 81 deletions(-)

diff --git a/audio/headset.c b/audio/headset.c
index 7002a3a..4decc18 100644
--- a/audio/headset.c
+++ b/audio/headset.c
@@ -128,6 +128,25 @@ struct pending_connect {
 	uint16_t svclass;
 };

+struct headset_session {
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
 struct headset {
 	uint32_t hsp_handle;
 	uint32_t hfp_handle;
@@ -144,28 +163,14 @@ struct headset {

 	guint dc_timer;

-	char buf[BUF_SIZE];
-	int data_start;
-	int data_length;
-
 	gboolean hfp_active;
 	gboolean search_hfp;
-	gboolean cli_active;
-	gboolean cme_enabled;
-	gboolean cwa_enabled;
-	gboolean pending_ring;
-	gboolean inband_ring;
-	gboolean nrec;
-	gboolean nrec_req;

 	headset_state_t state;
 	struct pending_connect *pending;

-	int sp_gain;
-	int mic_gain;
-
-	unsigned int hf_features;
 	headset_lock_t lock;
+	struct headset_session *session;
 };

 struct event {
@@ -338,14 +343,15 @@ static int headset_send(struct headset *hs, char
*format, ...)
 static int supported_features(struct audio_device *device, const char *buf)
 {
 	struct headset *hs = device->headset;
+	struct headset_session *session = hs->session;
 	int err;

 	if (strlen(buf) < 9)
 		return -EINVAL;

-	hs->hf_features = strtoul(&buf[8], NULL, 10);
+	session->hf_features = strtoul(&buf[8], NULL, 10);

-	print_hf_features(hs->hf_features);
+	print_hf_features(session->hf_features);

 	err = headset_send(hs, "\r\n+BRSF: %u\r\n", ag.features);
 	if (err < 0)
@@ -534,10 +540,12 @@ static void send_foreach_headset(GSList *devices,

 static int cli_cmp(struct headset *hs)
 {
+	struct headset_session *session = hs->session;
+
 	if (!hs->hfp_active)
 		return -1;

-	if (hs->cli_active)
+	if (session->cli_active)
 		return 0;
 	else
 		return -1;
@@ -560,6 +568,7 @@ static void sco_connect_cb(GIOChannel *chan,
GError *err, gpointer user_data)
 	int sk;
 	struct audio_device *dev = user_data;
 	struct headset *hs = dev->headset;
+	struct headset_session *session = hs->session;
 	struct pending_connect *p = hs->pending;

 	if (err) {
@@ -599,12 +608,12 @@ static void sco_connect_cb(GIOChannel *chan,
GError *err, gpointer user_data)

 	headset_set_state(dev, HEADSET_STATE_PLAYING);

-	if (hs->pending_ring) {
+	if (session->pending_ring) {
 		ring_timer_cb(NULL);
 		ag.ring_timer = g_timeout_add_seconds(RING_INTERVAL,
 						ring_timer_cb,
 						NULL);
-		hs->pending_ring = FALSE;
+		session->pending_ring = FALSE;
 	}
 }

@@ -684,9 +693,10 @@ static void hfp_slc_complete(struct audio_device *dev)
 static int telephony_generic_rsp(struct audio_device *device, cme_error_t err)
 {
 	struct headset *hs = device->headset;
+	struct headset_session *session = hs->session;

 	if (err != CME_ERROR_NONE) {
-		if (hs->cme_enabled)
+		if (session->cme_enabled)
 			return headset_send(hs, "\r\n+CME ERROR: %d\r\n", err);
 		else
 			return headset_send(hs, "\r\nERROR\r\n");
@@ -699,6 +709,7 @@ int telephony_event_reporting_rsp(void
*telephony_device, cme_error_t err)
 {
 	struct audio_device *device = telephony_device;
 	struct headset *hs = device->headset;
+	struct headset_session *session = hs->session;
 	int ret;

 	if (err != CME_ERROR_NONE)
@@ -711,7 +722,7 @@ int telephony_event_reporting_rsp(void
*telephony_device, cme_error_t err)
 	if (hs->state != HEADSET_STATE_CONNECTING)
 		return 0;

-	if (hs->hf_features & HF_FEATURE_CALL_WAITING_AND_3WAY &&
+	if (session->hf_features & HF_FEATURE_CALL_WAITING_AND_3WAY &&
 			ag.features & AG_FEATURE_THREE_WAY_CALLING)
 		return 0;

@@ -865,11 +876,12 @@ static int terminate_call(struct audio_device
*device, const char *buf)
 static int cli_notification(struct audio_device *device, const char *buf)
 {
 	struct headset *hs = device->headset;
+	struct headset_session *session = hs->session;

 	if (strlen(buf) < 9)
 		return -EINVAL;

-	hs->cli_active = buf[8] == '1' ? TRUE : FALSE;
+	session->cli_active = buf[8] == '1' ? TRUE : FALSE;

 	return headset_send(hs, "\r\nOK\r\n");
 }
@@ -937,6 +949,7 @@ static int dial_number(struct audio_device
*device, const char *buf)
 static int signal_gain_setting(struct audio_device *device, const char *buf)
 {
 	struct headset *hs = device->headset;
+	struct headset_session *session = hs->session;
 	const char *property;
 	const char *name;
 	dbus_uint16_t gain;
@@ -955,18 +968,18 @@ static int signal_gain_setting(struct
audio_device *device, const char *buf)

 	switch (buf[5]) {
 	case HEADSET_GAIN_SPEAKER:
-		if (hs->sp_gain == gain)
+		if (session->sp_gain == gain)
 			goto ok;
 		name = "SpeakerGainChanged";
 		property = "SpeakerGain";
-		hs->sp_gain = gain;
+		session->sp_gain = gain;
 		break;
 	case HEADSET_GAIN_MICROPHONE:
-		if (hs->mic_gain == gain)
+		if (session->mic_gain == gain)
 			goto ok;
 		name = "MicrophoneGainChanged";
 		property = "MicrophoneGain";
-		hs->mic_gain = gain;
+		session->mic_gain = gain;
 		break;
 	default:
 		error("Unknown gain setting");
@@ -1030,15 +1043,16 @@ static int list_current_calls(struct
audio_device *device, const char *buf)
 static int extended_errors(struct audio_device *device, const char *buf)
 {
 	struct headset *hs = device->headset;
+	struct headset_session *session = hs->session;

 	if (strlen(buf) < 9)
 		return -EINVAL;

 	if (buf[8] == '1') {
-		hs->cme_enabled = TRUE;
+		session->cme_enabled = TRUE;
 		debug("CME errors enabled for headset %p", hs);
 	} else {
-		hs->cme_enabled = FALSE;
+		session->cme_enabled = FALSE;
 		debug("CME errors disabled for headset %p", hs);
 	}

@@ -1048,15 +1062,16 @@ static int extended_errors(struct audio_device
*device, const char *buf)
 static int call_waiting_notify(struct audio_device *device, const char *buf)
 {
 	struct headset *hs = device->headset;
+	struct headset_session *session = hs->session;

 	if (strlen(buf) < 9)
 		return -EINVAL;

 	if (buf[8] == '1') {
-		hs->cwa_enabled = TRUE;
+		session->cwa_enabled = TRUE;
 		debug("Call waiting notification enabled for headset %p", hs);
 	} else {
-		hs->cwa_enabled = FALSE;
+		session->cwa_enabled = FALSE;
 		debug("Call waiting notification disabled for headset %p", hs);
 	}

@@ -1077,9 +1092,10 @@ int telephony_nr_and_ec_rsp(void
*telephony_device, cme_error_t err)
 {
 	struct audio_device *device = telephony_device;
 	struct headset *hs = device->headset;
+	struct headset_session *session = hs->session;

 	if (err == CME_ERROR_NONE)
-		hs->nrec = hs->nrec_req;
+		session->nrec = hs->session->nrec_req;

 	return telephony_generic_rsp(telephony_device, err);
 }
@@ -1123,16 +1139,17 @@ static int operator_selection(struct
audio_device *device, const char *buf)
 static int nr_and_ec(struct audio_device *device, const char *buf)
 {
 	struct headset *hs = device->headset;
+	struct headset_session *session = hs->session;

 	if (strlen(buf) < 9)
 		return -EINVAL;

 	if (buf[8] == '0')
-		hs->nrec_req = FALSE;
+		session->nrec_req = FALSE;
 	else
-		hs->nrec_req = TRUE;
+		session->nrec_req = TRUE;

-	telephony_nr_and_ec_req(device, hs->nrec_req);
+	telephony_nr_and_ec_req(device, session->nrec_req);

 	return 0;
 }
@@ -1214,6 +1231,7 @@ static gboolean rfcomm_io_cb(GIOChannel *chan,
GIOCondition cond,
 				struct audio_device *device)
 {
 	struct headset *hs;
+	struct headset_session *session;
 	unsigned char buf[BUF_SIZE];
 	gsize bytes_read = 0;
 	gsize free_space;
@@ -1222,6 +1240,7 @@ static gboolean rfcomm_io_cb(GIOChannel *chan,
GIOCondition cond,
 		return FALSE;

 	hs = device->headset;
+	session = hs->session;

 	if (cond & (G_IO_ERR | G_IO_HUP)) {
 		debug("ERR or HUP on RFCOMM socket");
@@ -1232,7 +1251,8 @@ static gboolean rfcomm_io_cb(GIOChannel *chan,
GIOCondition cond,
 				&bytes_read) != G_IO_ERROR_NONE)
 		return TRUE;

-	free_space = sizeof(hs->buf) - hs->data_start - hs->data_length - 1;
+	free_space = sizeof(session->buf) - session->data_start -
+			session->data_length - 1;

 	if (free_space < bytes_read) {
 		/* Very likely that the HS is sending us garbage so
@@ -1241,45 +1261,45 @@ static gboolean rfcomm_io_cb(GIOChannel *chan,
GIOCondition cond,
 		goto failed;
 	}

-	memcpy(&hs->buf[hs->data_start], buf, bytes_read);
-	hs->data_length += bytes_read;
+	memcpy(&session->buf[session->data_start], buf, bytes_read);
+	session->data_length += bytes_read;

 	/* Make sure the data is null terminated so we can use string
 	 * functions */
-	hs->buf[hs->data_start + hs->data_length] = '\0';
+	session->buf[session->data_start + session->data_length] = '\0';

-	while (hs->data_length > 0) {
+	while (session->data_length > 0) {
 		char *cr;
 		int err;
 		off_t cmd_len;

-		cr = strchr(&hs->buf[hs->data_start], '\r');
+		cr = strchr(&session->buf[session->data_start], '\r');
 		if (!cr)
 			break;

-		cmd_len = 1 + (off_t) cr - (off_t) &hs->buf[hs->data_start];
+		cmd_len = 1 + (off_t) cr - (off_t) &session->buf[session->data_start];
 		*cr = '\0';

 		if (cmd_len > 1)
-			err = handle_event(device, &hs->buf[hs->data_start]);
+			err = handle_event(device, &session->buf[session->data_start]);
 		else
 			/* Silently skip empty commands */
 			err = 0;

 		if (err == -EINVAL) {
 			error("Badly formated or unrecognized command: %s",
-					&hs->buf[hs->data_start]);
+					&session->buf[session->data_start]);
 			err = headset_send(hs, "\r\nERROR\r\n");
 		} else if (err < 0)
 			error("Error handling command %s: %s (%d)",
-						&hs->buf[hs->data_start],
+						&session->buf[session->data_start],
 						strerror(-err), -err);

-		hs->data_start += cmd_len;
-		hs->data_length -= cmd_len;
+		session->data_start += cmd_len;
+		session->data_length -= cmd_len;

-		if (!hs->data_length)
-			hs->data_start = 0;
+		if (!session->data_length)
+			session->data_start = 0;
 	}

 	return TRUE;
@@ -1337,6 +1357,9 @@ void headset_connect_cb(GIOChannel *chan, GError
*err, gpointer user_data)

 	debug("%s: Connected to %s", dev->path, hs_address);

+	hs->session = g_new0(struct headset_session, 1);
+	hs->session->nrec = TRUE;
+
 	/* In HFP mode wait for Service Level Connection */
 	if (hs->hfp_active)
 		return;
@@ -1811,10 +1834,11 @@ static DBusMessage
*hs_get_speaker_gain(DBusConnection *conn,
 {
 	struct audio_device *device = data;
 	struct headset *hs = device->headset;
+	struct headset_session *session = hs->session;
 	DBusMessage *reply;
 	dbus_uint16_t gain;

-	if (hs->state < HEADSET_STATE_CONNECTED || hs->sp_gain < 0)
+	if (hs->state < HEADSET_STATE_CONNECTED || session == NULL)
 		return g_dbus_create_error(msg, ERROR_INTERFACE ".NotAvailable",
 						"Operation not Available");

@@ -1822,7 +1846,7 @@ static DBusMessage
*hs_get_speaker_gain(DBusConnection *conn,
 	if (!reply)
 		return NULL;

-	gain = (dbus_uint16_t) hs->sp_gain;
+	gain = (dbus_uint16_t) session->sp_gain;

 	dbus_message_append_args(reply, DBUS_TYPE_UINT16, &gain,
 					DBUS_TYPE_INVALID);
@@ -1836,10 +1860,11 @@ static DBusMessage
*hs_get_mic_gain(DBusConnection *conn,
 {
 	struct audio_device *device = data;
 	struct headset *hs = device->headset;
+	struct headset_session *session = hs->session;
 	DBusMessage *reply;
 	dbus_uint16_t gain;

-	if (hs->state < HEADSET_STATE_CONNECTED || hs->mic_gain < 0)
+	if (hs->state < HEADSET_STATE_CONNECTED || session == NULL)
 		return g_dbus_create_error(msg, ERROR_INTERFACE ".NotAvailable",
 						"Operation not Available");

@@ -1847,7 +1872,7 @@ static DBusMessage *hs_get_mic_gain(DBusConnection *conn,
 	if (!reply)
 		return NULL;

-	gain = (dbus_uint16_t) hs->mic_gain;
+	gain = (dbus_uint16_t) session->mic_gain;

 	dbus_message_append_args(reply, DBUS_TYPE_UINT16, &gain,
 					DBUS_TYPE_INVALID);
@@ -1862,6 +1887,7 @@ static DBusMessage *hs_set_gain(DBusConnection *conn,
 {
 	struct audio_device *device = data;
 	struct headset *hs = device->headset;
+	struct headset_session *session = hs->session;
 	DBusMessage *reply;
 	int err;

@@ -1891,14 +1917,14 @@ static DBusMessage *hs_set_gain(DBusConnection *conn,

 done:
 	if (type == HEADSET_GAIN_SPEAKER) {
-		hs->sp_gain = gain;
+		session->sp_gain = gain;
 		g_dbus_emit_signal(conn, device->path,
 					AUDIO_HEADSET_INTERFACE,
 					"SpeakerGainChanged",
 					DBUS_TYPE_UINT16, &gain,
 					DBUS_TYPE_INVALID);
 	} else {
-		hs->mic_gain = gain;
+		session->mic_gain = gain;
 		g_dbus_emit_signal(conn, device->path,
 					AUDIO_HEADSET_INTERFACE,
 					"MicrophoneGainChanged",
@@ -1975,11 +2001,13 @@ static DBusMessage
*hs_get_properties(DBusConnection *conn,

 	/* SpeakerGain */
 	dict_append_entry(&dict, "SpeakerGain",
-				DBUS_TYPE_UINT16, &device->headset->sp_gain);
+				DBUS_TYPE_UINT16,
+				&device->headset->session->sp_gain);

 	/* MicrophoneGain */
 	dict_append_entry(&dict, "MicrophoneGain",
-				DBUS_TYPE_UINT16, &device->headset->mic_gain);
+				DBUS_TYPE_UINT16,
+				&device->headset->session->mic_gain);

 done:
 	dbus_message_iter_close_container(&iter, &dict);
@@ -2118,10 +2146,8 @@ static int headset_close_rfcomm(struct audio_device *dev)
 		hs->rfcomm = NULL;
 	}

-	hs->data_start = 0;
-	hs->data_length = 0;
-
-	hs->nrec = TRUE;
+	g_free(hs->session);
+	hs->session = NULL;

 	return 0;
 }
@@ -2176,12 +2202,7 @@ struct headset *headset_init(struct
audio_device *dev, uint16_t svc,

 	hs = g_new0(struct headset, 1);
 	hs->rfcomm_ch = -1;
-	hs->sp_gain = -1;
-	hs->mic_gain = -1;
 	hs->search_hfp = server_is_enabled(&dev->src, HANDSFREE_SVCLASS_ID);
-	hs->hfp_active = FALSE;
-	hs->cli_active = FALSE;
-	hs->nrec = TRUE;

 	record = btd_device_get_record(dev->btd_dev, uuidstr);
 	if (!record)
@@ -2424,18 +2445,19 @@ int headset_connect_rfcomm(struct audio_device
*dev, GIOChannel *io)
 int headset_connect_sco(struct audio_device *dev, GIOChannel *io)
 {
 	struct headset *hs = dev->headset;
+	struct headset_session *session = hs->session;

 	if (hs->sco)
 		return -EISCONN;

 	hs->sco = g_io_channel_ref(io);

-	if (hs->pending_ring) {
+	if (session->pending_ring) {
 		ring_timer_cb(NULL);
 		ag.ring_timer = g_timeout_add_seconds(RING_INTERVAL,
 						ring_timer_cb,
 						NULL);
-		hs->pending_ring = FALSE;
+		session->pending_ring = FALSE;
 	}

 	return 0;
@@ -2454,6 +2476,7 @@ static void disconnect_cb(struct btd_device
*btd_dev, gboolean removal,
 void headset_set_state(struct audio_device *dev, headset_state_t state)
 {
 	struct headset *hs = dev->headset;
+	struct headset_session *session = hs->session;
 	gboolean value;
 	const char *state_str;
 	headset_state_t old_state = hs->state;
@@ -2499,9 +2522,9 @@ void headset_set_state(struct audio_device *dev,
headset_state_t state)
 					DBUS_TYPE_STRING, &state_str);
 		if (hs->state < state) {
 			if (ag.features & AG_FEATURE_INBAND_RINGTONE)
-				hs->inband_ring = TRUE;
+				session->inband_ring = TRUE;
 			else
-				hs->inband_ring = FALSE;
+				session->inband_ring = FALSE;
 			g_dbus_emit_signal(dev->conn, dev->path,
 						AUDIO_HEADSET_INTERFACE,
 						"Connected",
@@ -2546,10 +2569,10 @@ void headset_set_state(struct audio_device
*dev, headset_state_t state)
 					AUDIO_HEADSET_INTERFACE, "Playing",
 					DBUS_TYPE_BOOLEAN, &value);

-		if (hs->sp_gain >= 0)
-			headset_send(hs, "\r\n+VGS=%u\r\n", hs->sp_gain);
-		if (hs->mic_gain >= 0)
-			headset_send(hs, "\r\n+VGM=%u\r\n", hs->mic_gain);
+		if (session->sp_gain >= 0)
+			headset_send(hs, "\r\n+VGS=%u\r\n", session->sp_gain);
+		if (session->mic_gain >= 0)
+			headset_send(hs, "\r\n+VGM=%u\r\n", session->mic_gain);
 		break;
 	}

@@ -2658,7 +2681,7 @@ gboolean headset_get_nrec(struct audio_device *dev)
 {
 	struct headset *hs = dev->headset;

-	return hs->nrec;
+	return hs->session->nrec;
 }

 gboolean headset_get_sco_hci(struct audio_device *dev)
@@ -2715,6 +2738,7 @@ int telephony_incoming_call_ind(const char
*number, int type)
 {
 	struct audio_device *dev;
 	struct headset *hs;
+	struct headset_session *session;

 	if (!active_devices)
 		return -ENODEV;
@@ -2722,6 +2746,7 @@ int telephony_incoming_call_ind(const char
*number, int type)
 	/* Get the latest connected device */
 	dev = active_devices->data;
 	hs = dev->headset;
+	session = hs->session;

 	if (ag.ring_timer) {
 		debug("telephony_incoming_call_ind: already calling");
@@ -2730,16 +2755,16 @@ int telephony_incoming_call_ind(const char
*number, int type)

 	/* With HSP 1.2 the RING messages should *not* be sent if inband
 	 * ringtone is being used */
-	if (!hs->hfp_active && hs->inband_ring)
+	if (!hs->hfp_active && session->inband_ring)
 		return 0;

 	g_free(ag.number);
 	ag.number = g_strdup(number);
 	ag.number_type = type;

-	if (hs->inband_ring && hs->hfp_active &&
+	if (session->inband_ring && hs->hfp_active &&
 					hs->state != HEADSET_STATE_PLAYING) {
-		hs->pending_ring = TRUE;
+		session->pending_ring = TRUE;
 		return 0;
 	}

@@ -2765,10 +2790,10 @@ int telephony_calling_stopped_ind(void)
 	/* In case SCO isn't fully up yet */
 	dev = active_devices->data;

-	if (!dev->headset->pending_ring && !ag.ring_timer)
+	if (!dev->headset->session->pending_ring && !ag.ring_timer)
 		return -EINVAL;

-	dev->headset->pending_ring = FALSE;
+	dev->headset->session->pending_ring = FALSE;

 	return 0;
 }
@@ -2826,7 +2851,7 @@ static int cwa_cmp(struct headset *hs)
 	if (!hs->hfp_active)
 		return -1;

-	if (hs->cwa_enabled)
+	if (hs->session->cwa_enabled)
 		return 0;
 	else
 		return -1;
-- 
1.6.3.3

-- 
Luiz Augusto von Dentz
Computer Engineer
