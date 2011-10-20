Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?=
	<frederic.danis@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/4] Audio: move dbus callbacks to telephony-builtin.c
Date: Thu, 20 Oct 2011 15:52:16 +0200
Message-Id: <1319118738-20131-3-git-send-email-frederic.danis@linux.intel.com>
In-Reply-To: <1319118738-20131-1-git-send-email-frederic.danis@linux.intel.com>
References: <1319118738-20131-1-git-send-email-frederic.danis@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 audio/headset.c           |  231 ++++++------------------------------
 audio/telephony-builtin.c |  291 ++++++++++++++++++++++++++++++++++++++++++++-
 audio/telephony.h         |   24 +++-
 3 files changed, 344 insertions(+), 202 deletions(-)

diff --git a/audio/headset.c b/audio/headset.c
index 8bec0ed..25e7bf8 100644
--- a/audio/headset.c
+++ b/audio/headset.c
@@ -59,7 +59,6 @@
 #include "dbus-common.h"
 #include "../src/adapter.h"
 #include "../src/device.h"
-#include "telephony-builtin.h"
 
 #define DC_TIMEOUT 3
 
@@ -126,6 +125,7 @@ struct headset {
 	headset_lock_t lock;
 	void *slc;
 	GSList *nrec_cbs;
+	struct TelephonyDBusTable *dbus_cb;
 };
 
 static GSList *headset_callbacks = NULL;
@@ -774,34 +774,11 @@ static DBusMessage *hs_ring(DBusConnection *conn, DBusMessage *msg,
 {
 	struct audio_device *device = data;
 	struct headset *hs = device->headset;
-	DBusMessage *reply = NULL;
-#if 0
-	int err;
-#endif
-
-	if (hs->state < HEADSET_STATE_CONNECTED)
-		return btd_error_not_connected(msg);
-
-	reply = dbus_message_new_method_return(msg);
-	if (!reply)
-		return NULL;
-
-	if (telephony_is_ringing()) {
-		DBG("IndicateCall received when already indicating");
-		return reply;
-	}
-
-#if 0
-	err = headset_send(hs, "\r\nRING\r\n");
-	if (err < 0) {
-		dbus_message_unref(reply);
-		return btd_error_failed(msg, strerror(-err));
-	}
-#endif
 
-	telephony_start_ring(hs->slc);
+	if (hs->dbus_cb == NULL || hs->dbus_cb->indicate_call == NULL)
+		return btd_error_not_supported(msg);
 
-	return reply;
+	return hs->dbus_cb->indicate_call(conn, msg, hs->slc, hs->state);
 }
 
 static DBusMessage *hs_cancel_call(DBusConnection *conn,
@@ -810,21 +787,11 @@ static DBusMessage *hs_cancel_call(DBusConnection *conn,
 {
 	struct audio_device *device = data;
 	struct headset *hs = device->headset;
-	DBusMessage *reply = NULL;
 
-	if (hs->state < HEADSET_STATE_CONNECTED)
-		return btd_error_not_connected(msg);
+	if (hs->dbus_cb == NULL || hs->dbus_cb->cancel_call == NULL)
+		return btd_error_not_supported(msg);
 
-	reply = dbus_message_new_method_return(msg);
-	if (!reply)
-		return NULL;
-
-	if (telephony_is_ringing())
-		telephony_stop_ring(hs->slc);
-	else
-		DBG("Got CancelCall method call but no call is active");
-
-	return reply;
+	return hs->dbus_cb->cancel_call(conn, msg, hs->slc, hs->state);
 }
 
 static DBusMessage *hs_play(DBusConnection *conn, DBusMessage *msg,
@@ -872,22 +839,11 @@ static DBusMessage *hs_get_speaker_gain(DBusConnection *conn,
 {
 	struct audio_device *device = data;
 	struct headset *hs = device->headset;
-	DBusMessage *reply;
-	dbus_uint16_t gain;
-
-	if (hs->state < HEADSET_STATE_CONNECTED)
-		return btd_error_not_available(msg);
-
-	reply = dbus_message_new_method_return(msg);
-	if (!reply)
-		return NULL;
 
-	gain = (dbus_uint16_t) telephony_get_speaker_gain(hs->slc);
+	if (hs->dbus_cb == NULL || hs->dbus_cb->get_speaker_gain == NULL)
+		return btd_error_not_supported(msg);
 
-	dbus_message_append_args(reply, DBUS_TYPE_UINT16, &gain,
-					DBUS_TYPE_INVALID);
-
-	return reply;
+	return hs->dbus_cb->get_speaker_gain(conn, msg, hs->slc, hs->state);
 }
 
 static DBusMessage *hs_get_mic_gain(DBusConnection *conn,
@@ -896,174 +852,61 @@ static DBusMessage *hs_get_mic_gain(DBusConnection *conn,
 {
 	struct audio_device *device = data;
 	struct headset *hs = device->headset;
-	DBusMessage *reply;
-	dbus_uint16_t gain;
-
-	if (hs->state < HEADSET_STATE_CONNECTED || hs->slc == NULL)
-		return btd_error_not_available(msg);
 
-	reply = dbus_message_new_method_return(msg);
-	if (!reply)
-		return NULL;
-
-	gain = (dbus_uint16_t) telephony_get_mic_gain(hs->slc);
+	if (hs->dbus_cb == NULL || hs->dbus_cb->get_mic_gain == NULL)
+		return btd_error_not_supported(msg);
 
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
-	struct at_slc *slc = hs->slc;
-	DBusMessage *reply;
-	int err;
-
-	if (hs->state < HEADSET_STATE_CONNECTED)
-		return btd_error_not_connected(msg);
-
-	err = telephony_set_gain(slc, gain, type);
-	if (err < 0)
-		return btd_error_invalid_args(msg);
-
-	reply = dbus_message_new_method_return(msg);
-	if (!reply)
-		return NULL;
-
-	if (hs->state == HEADSET_STATE_PLAYING) {
-		err = telephony_send_gain(slc, type, gain);
-		if (err < 0) {
-			dbus_message_unref(reply);
-			return btd_error_failed(msg, strerror(-err));
-		}
-	}
-
-	return reply;
+	return hs->dbus_cb->get_mic_gain(conn, msg, hs->slc, hs->state);
 }
 
 static DBusMessage *hs_set_speaker_gain(DBusConnection *conn,
 					DBusMessage *msg,
 					void *data)
 {
-	uint16_t gain;
+	struct audio_device *device = data;
+	struct headset *hs = device->headset;
 
-	if (!dbus_message_get_args(msg, NULL, DBUS_TYPE_UINT16, &gain,
-				DBUS_TYPE_INVALID))
-		return NULL;
+	if (hs->dbus_cb == NULL || hs->dbus_cb->set_speaker_gain == NULL)
+		return btd_error_not_supported(msg);
 
-	return hs_set_gain(conn, msg, data, gain, HEADSET_GAIN_SPEAKER);
+	return hs->dbus_cb->set_speaker_gain(conn, msg, hs->slc, hs->state);
 }
 
 static DBusMessage *hs_set_mic_gain(DBusConnection *conn,
 					DBusMessage *msg,
 					void *data)
 {
-	uint16_t gain;
+	struct audio_device *device = data;
+	struct headset *hs = device->headset;
 
-	if (!dbus_message_get_args(msg, NULL, DBUS_TYPE_UINT16, &gain,
-				DBUS_TYPE_INVALID))
-		return NULL;
+	if (hs->dbus_cb == NULL || hs->dbus_cb->set_mic_gain == NULL)
+		return btd_error_not_supported(msg);
 
-	return hs_set_gain(conn, msg, data, gain, HEADSET_GAIN_MICROPHONE);
+	return hs->dbus_cb->set_mic_gain(conn, msg, hs->slc, hs->state);
 }
 
 static DBusMessage *hs_get_properties(DBusConnection *conn,
 					DBusMessage *msg, void *data)
 {
 	struct audio_device *device = data;
-	DBusMessage *reply;
-	DBusMessageIter iter;
-	DBusMessageIter dict;
-	gboolean value;
-	const char *state;
-	int gain;
-
-	reply = dbus_message_new_method_return(msg);
-	if (!reply)
-		return NULL;
-
-	dbus_message_iter_init_append(reply, &iter);
-
-	dbus_message_iter_open_container(&iter, DBUS_TYPE_ARRAY,
-			DBUS_DICT_ENTRY_BEGIN_CHAR_AS_STRING
-			DBUS_TYPE_STRING_AS_STRING DBUS_TYPE_VARIANT_AS_STRING
-			DBUS_DICT_ENTRY_END_CHAR_AS_STRING, &dict);
-
-
-	/* Playing */
-	value = (device->headset->state == HEADSET_STATE_PLAYING);
-	dict_append_entry(&dict, "Playing", DBUS_TYPE_BOOLEAN, &value);
-
-	/* State */
-	state = state2str(device->headset->state);
-	if (state)
-		dict_append_entry(&dict, "State", DBUS_TYPE_STRING, &state);
-
-	/* Connected */
-	value = (device->headset->state >= HEADSET_STATE_CONNECTED);
-	dict_append_entry(&dict, "Connected", DBUS_TYPE_BOOLEAN, &value);
-
-	if (!value)
-		goto done;
-
-	/* SpeakerGain */
-	gain = telephony_get_speaker_gain(device->headset->slc);
-	dict_append_entry(&dict, "SpeakerGain", DBUS_TYPE_UINT16, &gain);
+	struct headset *hs = device->headset;
 
-	/* MicrophoneGain */
-	gain = telephony_get_mic_gain(device->headset->slc);
-	dict_append_entry(&dict, "MicrophoneGain", DBUS_TYPE_UINT16, &gain);
+	if (hs->dbus_cb == NULL || hs->dbus_cb->get_properties == NULL)
+		return btd_error_not_supported(msg);
 
-done:
-	dbus_message_iter_close_container(&iter, &dict);
-
-	return reply;
+	return hs->dbus_cb->get_properties(conn, msg, hs->slc, hs->state);
 }
 
 static DBusMessage *hs_set_property(DBusConnection *conn,
 					DBusMessage *msg, void *data)
 {
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
+	struct audio_device *device = data;
+	struct headset *hs = device->headset;
 
-		dbus_message_iter_get_basic(&sub, &gain);
-		return hs_set_gain(conn, msg, data, gain,
-					HEADSET_GAIN_MICROPHONE);
-	}
+	if (hs->dbus_cb == NULL || hs->dbus_cb->set_property == NULL)
+		return btd_error_not_supported(msg);
 
-	return btd_error_invalid_args(msg);
+	return hs->dbus_cb->set_property(conn, msg, hs->slc, hs->state);
 }
 
 static GDBusMethodTable headset_methods[] = {
@@ -1236,6 +1079,8 @@ struct headset *headset_init(struct audio_device *dev, uint16_t svc,
 	}
 
 register_iface:
+	hs->dbus_cb = telephony_dbus_table();
+
 	if (!g_dbus_register_interface(dev->conn, dev->path,
 					AUDIO_HEADSET_INTERFACE,
 					headset_methods, headset_signals, NULL,
@@ -1608,13 +1453,11 @@ void headset_set_state(struct audio_device *dev, headset_state_t state)
 
 		gain = telephony_get_speaker_gain(hs->slc);
 		if (gain >= 0)
-			telephony_send_gain(hs->slc, HEADSET_GAIN_SPEAKER,
-						gain);
+			telephony_send_speaker_gain(hs->slc, gain);
 
 		gain = telephony_get_mic_gain(hs->slc);
 		if (gain >= 0)
-			telephony_send_gain(hs->slc, HEADSET_GAIN_MICROPHONE,
-						gain);
+			telephony_send_mic_gain(hs->slc, gain);
 		break;
 	}
 
diff --git a/audio/telephony-builtin.c b/audio/telephony-builtin.c
index 84a34f2..1ec0328 100644
--- a/audio/telephony-builtin.c
+++ b/audio/telephony-builtin.c
@@ -42,6 +42,7 @@
 
 #include "log.h"
 #include "device.h"
+#include "error.h"
 #include "manager.h"
 #include "telephony.h"
 #include "headset.h"
@@ -617,7 +618,7 @@ static int dial_number(struct at_slc *slc, const char *buf)
 	return 0;
 }
 
-int telephony_set_gain(void *slc, uint16_t gain, char type)
+static int telephony_set_gain(void *slc, uint16_t gain, char type)
 {
 	struct at_slc *s = slc;
 	const char *name, *property;
@@ -1234,7 +1235,7 @@ gboolean telephony_pending_ring(void *slc)
 	return s->pending_ring;
 }
 
-void telephony_stop_ring(void *slc)
+static void telephony_stop_ring(void *slc)
 {
 	g_source_remove(ag.ring_timer);
 	ag.ring_timer = 0;
@@ -1254,11 +1255,21 @@ int telephony_get_mic_gain(void *slc)
 	return s->mic_gain;
 }
 
-int telephony_send_gain(void *slc, char type, uint16_t gain)
+static int telephony_send_gain(void *slc, char type, uint16_t gain)
 {
 	return at_send(slc, "\r\n+VG%c=%u\r\n", type, gain);
 }
 
+int telephony_send_speaker_gain(void *slc, uint16_t gain)
+{
+	return telephony_send_gain(slc, HEADSET_GAIN_SPEAKER, gain);
+}
+
+int telephony_send_mic_gain(void *slc, uint16_t gain)
+{
+	return telephony_send_gain(slc, HEADSET_GAIN_MICROPHONE, gain);
+}
+
 int telephony_get_nrec(void *slc)
 {
 	struct at_slc *s = slc;
@@ -1271,7 +1282,7 @@ gboolean telephony_get_ready_state(void)
 	return ag.telephony_ready;
 }
 
-gboolean telephony_is_ringing(void)
+static gboolean telephony_is_ringing(void)
 {
 	return ag.ring_timer ? TRUE : FALSE;
 }
@@ -1285,3 +1296,275 @@ void telephony_set_fast_connectable(gboolean state)
 {
 	fast_connectable = state;
 }
+
+static const char *state2str(headset_state_t state)
+{
+	switch (state) {
+	case HEADSET_STATE_DISCONNECTED:
+		return "disconnected";
+	case HEADSET_STATE_CONNECTING:
+		return "connecting";
+	case HEADSET_STATE_CONNECTED:
+	case HEADSET_STATE_PLAY_IN_PROGRESS:
+		return "connected";
+	case HEADSET_STATE_PLAYING:
+		return "playing";
+	}
+
+	return NULL;
+}
+
+static DBusMessage *builtin_ring(DBusConnection *conn, DBusMessage *msg,
+				void *slc, /*headset_state_t*/ int state)
+{
+	DBusMessage *reply = NULL;
+	int err;
+
+	if (state < HEADSET_STATE_CONNECTED)
+		return btd_error_not_connected(msg);
+
+	reply = dbus_message_new_method_return(msg);
+	if (!reply)
+		return NULL;
+
+	if (telephony_is_ringing()) {
+		DBG("IndicateCall received when already indicating");
+		return reply;
+	}
+
+	err = at_send(slc, "\r\nRING\r\n");
+	if (err < 0) {
+		dbus_message_unref(reply);
+		return btd_error_failed(msg, strerror(-err));
+	}
+
+	telephony_start_ring(slc);
+
+	return reply;
+}
+
+static DBusMessage *builtin_cancel_call(DBusConnection *conn, DBusMessage *msg,
+				void *slc, /*headset_state_t*/ int state)
+{
+	DBusMessage *reply = NULL;
+
+	if (state < HEADSET_STATE_CONNECTED)
+		return btd_error_not_connected(msg);
+
+	reply = dbus_message_new_method_return(msg);
+	if (!reply)
+		return NULL;
+
+	if (telephony_is_ringing())
+		telephony_stop_ring(slc);
+	else
+		DBG("Got CancelCall method call but no call is active");
+
+	return reply;
+}
+
+static DBusMessage *builtin_get_speaker_gain(DBusConnection *conn,
+					DBusMessage *msg,
+					void *slc, /*headset_state_t*/ int state)
+{
+	DBusMessage *reply;
+	dbus_uint16_t gain;
+
+	if (state < HEADSET_STATE_CONNECTED)
+		return btd_error_not_available(msg);
+
+	reply = dbus_message_new_method_return(msg);
+	if (!reply)
+		return NULL;
+
+	gain = (dbus_uint16_t) telephony_get_speaker_gain(slc);
+
+	dbus_message_append_args(reply, DBUS_TYPE_UINT16, &gain,
+					DBUS_TYPE_INVALID);
+
+	return reply;
+}
+
+static DBusMessage *builtin_get_mic_gain(DBusConnection *conn, DBusMessage *msg,
+					void *slc, /*headset_state_t*/ int state)
+{
+	DBusMessage *reply;
+	dbus_uint16_t gain;
+
+	if (state < HEADSET_STATE_CONNECTED || slc == NULL)
+		return btd_error_not_available(msg);
+
+	reply = dbus_message_new_method_return(msg);
+	if (!reply)
+		return NULL;
+
+	gain = (dbus_uint16_t) telephony_get_mic_gain(slc);
+
+	dbus_message_append_args(reply, DBUS_TYPE_UINT16, &gain,
+					DBUS_TYPE_INVALID);
+
+	return reply;
+}
+
+static DBusMessage *builtin_set_gain(DBusConnection *conn, DBusMessage *msg,
+				void *slc, /*headset_state_t*/ int state,
+				uint16_t gain, char type)
+{
+	DBusMessage *reply;
+	int err;
+
+	if (state < HEADSET_STATE_CONNECTED)
+		return btd_error_not_connected(msg);
+
+	err = telephony_set_gain(slc, gain, type);
+	if (err < 0)
+		return btd_error_invalid_args(msg);
+
+	reply = dbus_message_new_method_return(msg);
+	if (!reply)
+		return NULL;
+
+	if (state == HEADSET_STATE_PLAYING) {
+		err = telephony_send_gain(slc, type, gain);
+		if (err < 0) {
+			dbus_message_unref(reply);
+			return btd_error_failed(msg, strerror(-err));
+		}
+	}
+
+	return reply;
+}
+
+static DBusMessage *builtin_set_speaker_gain(DBusConnection *conn,
+					DBusMessage *msg,
+					void *slc, /*headset_state_t*/ int state)
+{
+	uint16_t gain;
+
+	if (!dbus_message_get_args(msg, NULL, DBUS_TYPE_UINT16, &gain,
+				DBUS_TYPE_INVALID))
+		return NULL;
+
+	return builtin_set_gain(conn, msg, slc, state, gain,
+				HEADSET_GAIN_SPEAKER);
+}
+
+static DBusMessage *builtin_set_mic_gain(DBusConnection *conn, DBusMessage *msg,
+					void *slc, /*headset_state_t*/ int state)
+{
+	uint16_t gain;
+
+	if (!dbus_message_get_args(msg, NULL, DBUS_TYPE_UINT16, &gain,
+				DBUS_TYPE_INVALID))
+		return NULL;
+
+	return builtin_set_gain(conn, msg, slc, state, gain,
+				HEADSET_GAIN_MICROPHONE);
+}
+
+static DBusMessage *builtin_get_properties(DBusConnection *conn, DBusMessage *msg,
+					void *slc, /*headset_state_t*/ int state)
+{
+	DBusMessage *reply;
+	DBusMessageIter iter;
+	DBusMessageIter dict;
+	gboolean value;
+	const char *str;
+	int gain;
+
+	reply = dbus_message_new_method_return(msg);
+	if (!reply)
+		return NULL;
+
+	dbus_message_iter_init_append(reply, &iter);
+
+	dbus_message_iter_open_container(&iter, DBUS_TYPE_ARRAY,
+			DBUS_DICT_ENTRY_BEGIN_CHAR_AS_STRING
+			DBUS_TYPE_STRING_AS_STRING DBUS_TYPE_VARIANT_AS_STRING
+			DBUS_DICT_ENTRY_END_CHAR_AS_STRING, &dict);
+
+	/* Playing */
+	value = (state == HEADSET_STATE_PLAYING);
+	dict_append_entry(&dict, "Playing", DBUS_TYPE_BOOLEAN, &value);
+
+	/* State */
+	str = state2str(state);
+	if (str)
+		dict_append_entry(&dict, "State", DBUS_TYPE_STRING, &str);
+
+	/* Connected */
+	value = (state >= HEADSET_STATE_CONNECTED);
+	dict_append_entry(&dict, "Connected", DBUS_TYPE_BOOLEAN, &value);
+
+	if (!value)
+		goto done;
+
+	/* SpeakerGain */
+	gain = telephony_get_speaker_gain(slc);
+	dict_append_entry(&dict, "SpeakerGain", DBUS_TYPE_UINT16, &gain);
+
+	/* MicrophoneGain */
+	gain = telephony_get_mic_gain(slc);
+	dict_append_entry(&dict, "MicrophoneGain", DBUS_TYPE_UINT16, &gain);
+
+done:
+	dbus_message_iter_close_container(&iter, &dict);
+
+	return reply;
+}
+
+static DBusMessage *builtin_set_property(DBusConnection *conn, DBusMessage *msg,
+					void *slc, /*headset_state_t*/ int state)
+{
+	const char *property;
+	DBusMessageIter iter;
+	DBusMessageIter sub;
+	uint16_t gain;
+
+	if (!dbus_message_iter_init(msg, &iter))
+		return btd_error_invalid_args(msg);
+
+	if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_STRING)
+		return btd_error_invalid_args(msg);
+
+	dbus_message_iter_get_basic(&iter, &property);
+	dbus_message_iter_next(&iter);
+
+	if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_VARIANT)
+		return btd_error_invalid_args(msg);
+	dbus_message_iter_recurse(&iter, &sub);
+
+	if (g_str_equal("SpeakerGain", property)) {
+		if (dbus_message_iter_get_arg_type(&sub) != DBUS_TYPE_UINT16)
+			return btd_error_invalid_args(msg);
+
+		dbus_message_iter_get_basic(&sub, &gain);
+		return builtin_set_gain(conn, msg, slc, state, gain,
+					HEADSET_GAIN_SPEAKER);
+	} else if (g_str_equal("MicrophoneGain", property)) {
+		if (dbus_message_iter_get_arg_type(&sub) != DBUS_TYPE_UINT16)
+			return btd_error_invalid_args(msg);
+
+		dbus_message_iter_get_basic(&sub, &gain);
+		return builtin_set_gain(conn, msg, slc, state, gain,
+					HEADSET_GAIN_MICROPHONE);
+	}
+
+	return btd_error_invalid_args(msg);
+}
+
+static struct TelephonyDBusTable dbus_callbacks = {
+	.indicate_call = builtin_ring,
+	.cancel_call = builtin_cancel_call,
+	.get_speaker_gain = builtin_get_speaker_gain,
+	.set_speaker_gain = builtin_set_speaker_gain,
+	.get_mic_gain = builtin_get_mic_gain,
+	.set_mic_gain = builtin_set_mic_gain,
+	.get_properties = builtin_get_properties,
+	.set_property = builtin_set_property
+};
+
+struct TelephonyDBusTable *telephony_dbus_table(void)
+{
+	return &dbus_callbacks;
+}
diff --git a/audio/telephony.h b/audio/telephony.h
index 8043267..ecd6d09 100644
--- a/audio/telephony.h
+++ b/audio/telephony.h
@@ -57,8 +57,6 @@ void telephony_device_set_active(void *telephony_device, gboolean active);
 gboolean telephony_get_ready_state(void);
 gboolean telephony_pending_ring(void *slc);
 void telephony_start_ring(void *slc);
-void telephony_stop_ring(void *slc);
-gboolean telephony_is_ringing(void);
 uint32_t telephony_get_ag_features(void);
 void telephony_set_fast_connectable(gboolean state);
 gboolean telephony_get_nrec(void *slc);
@@ -66,8 +64,26 @@ gboolean telephony_get_inband_ringtone(void *slc);
 void telephony_set_inband_ringtone(void *slc, gboolean state);
 int telephony_get_speaker_gain(void *slc);
 int telephony_get_mic_gain(void *slc);
-int telephony_send_gain(void *slc, char type, uint16_t gain);
-int telephony_set_gain(void *slc, uint16_t gain, char type);
+int telephony_send_speaker_gain(void *slc, uint16_t gain);
+int telephony_send_mic_gain(void *slc, uint16_t gain);
+
+/* DBus interface functions. Implemented by telephony-*.c */
+typedef DBusMessage * (* telephony_dbus_cb)(DBusConnection *conn,
+						DBusMessage *msg,
+						void *slc, int state);
+
+struct TelephonyDBusTable {
+	telephony_dbus_cb indicate_call;
+	telephony_dbus_cb cancel_call;
+	telephony_dbus_cb get_speaker_gain;
+	telephony_dbus_cb set_speaker_gain;
+	telephony_dbus_cb get_mic_gain;
+	telephony_dbus_cb set_mic_gain;
+	telephony_dbus_cb get_properties;
+	telephony_dbus_cb set_property;
+};
+
+struct TelephonyDBusTable *telephony_dbus_table(void);
 
 int telephony_init(void);
 void telephony_exit(void);
-- 
1.7.1

