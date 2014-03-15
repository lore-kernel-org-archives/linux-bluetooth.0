Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] android/handsfree: Connect audio when Android framemework expects it
Date: Sat, 15 Mar 2014 20:54:14 +0100
Message-Id: <1394913254-13737-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

There are few cases when framework doesn't call connect_audio method
from HAL but we should do it internally. Call connect_audio if
we started dialing or we accepted incoming call. Also if headset
connects during active call, start SCO connection. We don't have to
disconnect SCO internally, because Android always call disconect_audio
when call has finished.
---
 android/handsfree.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/android/handsfree.c b/android/handsfree.c
index d4dc596..61a9816 100644
--- a/android/handsfree.c
+++ b/android/handsfree.c
@@ -1653,6 +1653,9 @@ static bool disconnect_sco(void)
 
 static bool connect_audio(void)
 {
+	if (device.audio_state != HAL_EV_HANDSFREE_AUDIO_STATE_DISCONNECTED)
+		return false;
+
 	/* we haven't negotiated codec, start selection */
 	if ((device.features & HFP_HF_FEAT_CODEC) && !device.negotiated_codec) {
 		select_codec(0);
@@ -1989,6 +1992,8 @@ static void phone_state_dialing(int num_active, int num_held)
 
 	if (num_active == 0 && num_held > 0)
 		update_indicator(IND_CALLHELD, 2);
+
+	connect_audio();
 }
 
 static void phone_state_alerting(int num_active, int num_held)
@@ -2057,13 +2062,16 @@ static void phone_state_idle(int num_active, int num_held)
 
 	switch (device.setup_state) {
 	case HAL_HANDSFREE_CALL_STATE_INCOMING:
-		if (num_active > device.num_active)
+		if (num_active > device.num_active) {
 			update_indicator(IND_CALL, 1);
+			connect_audio();
+		}
 
 		if (num_held > device.num_held)
 			update_indicator(IND_CALLHELD, 1);
 
 		update_indicator(IND_CALLSETUP, 0);
+
 		break;
 	case HAL_HANDSFREE_CALL_STATE_DIALING:
 	case HAL_HANDSFREE_CALL_STATE_ALERTING:
@@ -2088,6 +2096,10 @@ static void phone_state_idle(int num_active, int num_held)
 		update_indicator(IND_CALLSETUP, 0);
 
 		break;
+	case HAL_HANDSFREE_CALL_STATE_ACTIVE:
+		connect_audio();
+
+		break;
 	default:
 		DBG("unhandled state %u", device.setup_state);
 		break;
-- 
1.8.3.1

