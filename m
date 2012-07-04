Return-Path: <cyrus@holtmann.org>
From: Gustavo Padovan <gustavo@padovan.org>
To: linux-bluetooth@vger.kernel.org
Cc: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
Subject: [PATCH -v3 01/19] headset: remove deprecated D-Bus methods
Date: Wed,  4 Jul 2012 14:51:17 +0200
Message-Id: <1341406295-7669-1-git-send-email-gustavo@padovan.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Gustavo Padovan <gustavo.padovan@collabora.co.uk>

---
 audio/headset.c     |  151 ---------------------------------------------------
 doc/audio-api.txt   |   28 ----------
 test/test-telephony |   12 ----
 3 files changed, 191 deletions(-)

diff --git a/audio/headset.c b/audio/headset.c
index b9c6265..1014c59 100644
--- a/audio/headset.c
+++ b/audio/headset.c
@@ -1673,26 +1673,6 @@ static DBusMessage *hs_stop(DBusConnection *conn, DBusMessage *msg,
 	return reply;
 }
 
-static DBusMessage *hs_is_playing(DBusConnection *conn, DBusMessage *msg,
-					void *data)
-{
-	struct audio_device *device = data;
-	struct headset *hs = device->headset;
-	DBusMessage *reply;
-	dbus_bool_t playing;
-
-	reply = dbus_message_new_method_return(msg);
-	if (!reply)
-		return NULL;
-
-	playing = (hs->state == HEADSET_STATE_PLAYING);
-
-	dbus_message_append_args(reply, DBUS_TYPE_BOOLEAN, &playing,
-					DBUS_TYPE_INVALID);
-
-	return reply;
-}
-
 static DBusMessage *hs_disconnect(DBusConnection *conn, DBusMessage *msg,
 					void *data)
 {
@@ -1816,95 +1796,6 @@ static DBusMessage *hs_cancel_call(DBusConnection *conn,
 	return reply;
 }
 
-static DBusMessage *hs_play(DBusConnection *conn, DBusMessage *msg,
-				void *data)
-{
-	struct audio_device *device = data;
-	struct headset *hs = device->headset;
-	int err;
-
-	if (sco_hci) {
-		error("Refusing Headset.Play() because SCO HCI routing "
-				"is enabled");
-		return btd_error_not_available(msg);
-	}
-
-	switch (hs->state) {
-	case HEADSET_STATE_DISCONNECTED:
-	case HEADSET_STATE_CONNECTING:
-		return btd_error_not_connected(msg);
-	case HEADSET_STATE_PLAY_IN_PROGRESS:
-		if (hs->pending && hs->pending->msg == NULL) {
-			hs->pending->msg = dbus_message_ref(msg);
-			return NULL;
-		}
-		return btd_error_busy(msg);
-	case HEADSET_STATE_PLAYING:
-		return btd_error_already_connected(msg);
-	case HEADSET_STATE_CONNECTED:
-	default:
-		break;
-	}
-
-	err = sco_connect(device, NULL, NULL, NULL);
-	if (err < 0)
-		return btd_error_failed(msg, strerror(-err));
-
-	hs->pending->msg = dbus_message_ref(msg);
-
-	return NULL;
-}
-
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
 static DBusMessage *hs_set_gain(DBusConnection *conn,
 				DBusMessage *msg,
 				void *data, uint16_t gain,
@@ -1937,32 +1828,6 @@ static DBusMessage *hs_set_gain(DBusConnection *conn,
 	return reply;
 }
 
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
@@ -2065,23 +1930,7 @@ static const GDBusMethodTable headset_methods[] = {
 			hs_is_connected) },
 	{ GDBUS_METHOD("IndicateCall", NULL, NULL, hs_ring) },
 	{ GDBUS_METHOD("CancelCall", NULL, NULL, hs_cancel_call) },
-	{ GDBUS_DEPRECATED_ASYNC_METHOD("Play", NULL, NULL, hs_play) },
 	{ GDBUS_METHOD("Stop", NULL, NULL, hs_stop) },
-	{ GDBUS_DEPRECATED_METHOD("IsPlaying",
-					NULL, GDBUS_ARGS({ "playing", "b" }),
-					hs_is_playing) },
-	{ GDBUS_DEPRECATED_METHOD("GetSpeakerGain",
-					NULL, GDBUS_ARGS({ "gain", "q" }),
-					hs_get_speaker_gain) },
-	{ GDBUS_DEPRECATED_METHOD("GetMicrophoneGain",
-					NULL, GDBUS_ARGS({ "gain", "q" }),
-					hs_get_mic_gain) },
-	{ GDBUS_DEPRECATED_METHOD("SetSpeakerGain",
-					GDBUS_ARGS({ "gain", "q" }), NULL,
-					hs_set_speaker_gain) },
-	{ GDBUS_DEPRECATED_METHOD("SetMicrophoneGain",
-					GDBUS_ARGS({ "gain", "q" }), NULL,
-					hs_set_mic_gain) },
 	{ GDBUS_METHOD("GetProperties",
 			NULL, GDBUS_ARGS({ "properties", "a{sv}" }),
 			hs_get_properties) },
diff --git a/doc/audio-api.txt b/doc/audio-api.txt
index 9b1737d..2419531 100644
--- a/doc/audio-api.txt
+++ b/doc/audio-api.txt
@@ -66,11 +66,6 @@ Methods		void Connect()
 			Disconnect from the HSP/HFP service on the remote
 			device.
 
-		boolean IsConnected() {deprecated}
-
-			Returns TRUE if there is a active connection to the
-			HSP/HFP connection on the remote device.
-
 		void IndicateCall()
 
 			Indicate an incoming call on the headset
@@ -89,29 +84,6 @@ Methods		void Connect()
 
 			Close the audio connection.
 
-		boolean IsPlaying() {deprecated}
-
-			Returns true if an audio connection to the headset
-			is active.
-
-		uint16 GetSpeakerGain() {deprecated}
-
-			Returns the current speaker gain if available,
-			otherwise returns the error NotAvailable.
-
-		uint16 GetMicrophoneGain() {deprecated}
-
-			Returns the current microphone gain if available,
-			otherwise returns the error NotAvailable.
-
-		void SetSpeakerGain(uint16 gain) {deprecated}
-
-			Changes the current speaker gain if possible.
-
-		void SetMicrophoneGain(uint16 gain) {deprecated}
-
-			Changes the current speaker gain if possible.
-
 		dict GetProperties()
 
 			Returns all properties for the interface. See the
diff --git a/test/test-telephony b/test/test-telephony
index bd7d3b2..57ac7f0 100755
--- a/test/test-telephony
+++ b/test/test-telephony
@@ -44,7 +44,6 @@ if len(args) < 1:
 	subscriber <number>
 	speakergain <bdaddr> [level]
 	microphonegain <bdaddr> [level]
-	play <bdaddr>
 	stop <bdaddr>
 	""" % sys.argv[0])
 	sys.exit(1)
@@ -99,17 +98,6 @@ if args[0] == "microphonegain":
 
 	sys.exit(0)
 
-if args[0] == "play":
-	if len(args) < 2:
-		print("Need device address parameter")
-		sys.exit(1)
-	device = adapter.FindDevice(args[1])
-	headset = dbus.Interface(bus.get_object("org.bluez", device),
-					"org.bluez.Headset")
-	headset.Play()
-
-	sys.exit(0)
-
 if args[0] == "stop":
 	if len(args) < 2:
 		print("Need device address parameter")
-- 
1.7.10.2

