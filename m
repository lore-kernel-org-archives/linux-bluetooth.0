Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Fix sending duplicate speaker/microphone gains to the headset
Date: Thu, 16 Dec 2010 16:13:21 +0200
Message-Id: <1292508801-15581-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1292508801-15581-1-git-send-email-luiz.dentz@gmail.com>
References: <1292508801-15581-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.dentz-von@nokia.com>

Current code only prevent duplicate D-Bus signals, so in case headset
changes the volume a client may set the same volume level again which
would be send as new volume level.

To fix this headset_set_gain now return -EALREADY if nothing has changed
so code using it can just ignore the change instead of sending to remote
device.
---
 audio/headset.c |   12 ++++++++----
 1 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/audio/headset.c b/audio/headset.c
index 97ae4fd..52d0ce8 100644
--- a/audio/headset.c
+++ b/audio/headset.c
@@ -958,7 +958,7 @@ static int headset_set_gain(struct audio_device *device, uint16_t gain, char typ
 	case HEADSET_GAIN_SPEAKER:
 		if (slc->sp_gain == gain) {
 			DBG("Ignoring no-change in speaker gain");
-			return 0;
+			return -EALREADY;
 		}
 		name = "SpeakerGainChanged";
 		property = "SpeakerGain";
@@ -967,7 +967,7 @@ static int headset_set_gain(struct audio_device *device, uint16_t gain, char typ
 	case HEADSET_GAIN_MICROPHONE:
 		if (slc->mic_gain == gain) {
 			DBG("Ignoring no-change in microphone gain");
-			return 0;
+			return -EALREADY;
 		}
 		name = "MicrophoneGainChanged";
 		property = "MicrophoneGain";
@@ -1004,7 +1004,7 @@ static int signal_gain_setting(struct audio_device *device, const char *buf)
 	gain = (dbus_uint16_t) strtol(&buf[7], NULL, 10);
 
 	err = headset_set_gain(device, gain, buf[5]);
-	if (err < 0)
+	if (err < 0 && err != -EALREADY)
 		return err;
 
 	return headset_send(hs, "\r\nOK\r\n");
@@ -1887,10 +1887,14 @@ static DBusMessage *hs_set_gain(DBusConnection *conn,
 		return btd_error_not_connected(msg);
 
 	err = headset_set_gain(device, gain, type);
-	if (err < 0)
+	if (err < 0) {
+		/* Ignore if nothing has changed */
+		if (err == -EALREADY)
+			return dbus_message_new_method_return(msg);
 		return g_dbus_create_error(msg, ERROR_INTERFACE
 						".InvalidArgument",
 						"Must be less than or equal to 15");
+	}
 
 	reply = dbus_message_new_method_return(msg);
 	if (!reply)
-- 
1.7.1

