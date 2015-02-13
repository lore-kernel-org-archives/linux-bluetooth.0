Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [RFC] android/handsfree: Fix no indicators after rejected incoming call
Date: Fri, 13 Feb 2015 14:19:19 +0100
Message-Id: <1423833559-18107-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On KitKat there were some bogus phone_state_change calls after
incoming call was rejected from the phone:
    active=0 hold=0 state=idle
    active=0 hold=0 state=incoming
    active=0 hold=0 state=idle
    active=0 hold=0 state=idle

On Lollipop this seems to be fixed and after call is rejected we
only get single call with state idle:
    active=0 hold=0 state=idle

So simply reverting workaround commit "Track if incoming call is
being rejected" would break KK.

Instead, add short timeout after incoming call was rejected. Durring
that period we ignore any phone state change to 'incoming' state.
If we get any other state change (ie. outgoing call) timer is cleared.
---
I know that timer sollution isn't best but I couldn't find any other
sollution that would fit both L and KK...

 android/handsfree.c | 38 ++++++++++++++++++++++++++++++++------
 1 file changed, 32 insertions(+), 6 deletions(-)

diff --git a/android/handsfree.c b/android/handsfree.c
index ba798ee..e760d1c 100644
--- a/android/handsfree.c
+++ b/android/handsfree.c
@@ -127,7 +127,7 @@ struct hf_device {
 	int num_active;
 	int num_held;
 	int setup_state;
-	bool call_hanging_up;
+	guint call_hanging_up;
 
 	uint8_t negotiated_codec;
 	uint8_t proposed_codec;
@@ -263,6 +263,9 @@ static void device_destroy(struct hf_device *dev)
 
 	g_free(dev->clip);
 
+	if (dev->call_hanging_up)
+		g_source_remove(dev->call_hanging_up);
+
 	set_audio_state(dev, HAL_EV_HANDSFREE_AUDIO_STATE_DISCONNECTED);
 	set_state(dev, HAL_EV_HANDSFREE_CONN_STATE_DISCONNECTED);
 
@@ -2251,6 +2254,11 @@ static gboolean ring_cb(gpointer user_data)
 static void phone_state_dialing(struct hf_device *dev, int num_active,
 								int num_held)
 {
+	if (dev->call_hanging_up) {
+		g_source_remove(dev->call_hanging_up);
+		dev->call_hanging_up = 0;
+	}
+
 	update_indicator(dev, IND_CALLSETUP, 2);
 
 	if (num_active == 0 && num_held > 0)
@@ -2263,6 +2271,11 @@ static void phone_state_dialing(struct hf_device *dev, int num_active,
 static void phone_state_alerting(struct hf_device *dev, int num_active,
 								int num_held)
 {
+	if (dev->call_hanging_up) {
+		g_source_remove(dev->call_hanging_up);
+		dev->call_hanging_up = 0;
+	}
+
 	update_indicator(dev, IND_CALLSETUP, 3);
 }
 
@@ -2337,6 +2350,17 @@ static void phone_state_incoming(struct hf_device *dev, int num_active,
 	}
 }
 
+static gboolean hang_up_cb(gpointer user_data)
+{
+	struct hf_device *dev = user_data;
+
+	DBG("");
+
+	dev->call_hanging_up = 0;
+
+	return FALSE;
+}
+
 static void phone_state_idle(struct hf_device *dev, int num_active,
 								int num_held)
 {
@@ -2364,9 +2388,11 @@ static void phone_state_idle(struct hf_device *dev, int num_active,
 
 		update_indicator(dev, IND_CALLSETUP, 0);
 
-		if (num_active == dev->num_active && num_held == dev->num_held)
-			dev->call_hanging_up = true;
-
+		if (num_active == 0 && num_held == 0 &&
+				num_active == dev->num_active &&
+				num_held == dev->num_held)
+			dev->call_hanging_up = g_timeout_add(800, hang_up_cb,
+									dev);
 		break;
 	case HAL_HANDSFREE_CALL_STATE_DIALING:
 	case HAL_HANDSFREE_CALL_STATE_ALERTING:
@@ -2379,9 +2405,9 @@ static void phone_state_idle(struct hf_device *dev, int num_active,
 		update_indicator(dev, IND_CALLSETUP, 0);
 		break;
 	case HAL_HANDSFREE_CALL_STATE_IDLE:
-
 		if (dev->call_hanging_up) {
-			dev->call_hanging_up = false;
+			g_source_remove(dev->call_hanging_up);
+			dev->call_hanging_up = 0;
 			return;
 		}
 
-- 
1.9.3

