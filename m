Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC 12/15] android/hardware: Update bt_av.h header
Date: Thu,  6 Nov 2014 17:05:57 +0200
Message-Id: <1415286360-26268-13-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1415286360-26268-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1415286360-26268-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

---
 android/hardware/bt_av.h | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/android/hardware/bt_av.h b/android/hardware/bt_av.h
index 2ec00c3..5252a17 100644
--- a/android/hardware/bt_av.h
+++ b/android/hardware/bt_av.h
@@ -47,12 +47,23 @@ typedef void (* btav_connection_state_callback)(btav_connection_state_t state,
 typedef void (* btav_audio_state_callback)(btav_audio_state_t state, 
                                                bt_bdaddr_t *bd_addr);
 
+/** Callback for audio configuration change.
+ *  Used only for the A2DP sink interface.
+ *  state will have one of the values from btav_audio_state_t
+ *  sample_rate: sample rate in Hz
+ *  channel_count: number of channels (1 for mono, 2 for stereo)
+ */
+typedef void (* btav_audio_config_callback)(bt_bdaddr_t *bd_addr,
+                                                uint32_t sample_rate,
+                                                uint8_t channel_count);
+
 /** BT-AV callback structure. */
 typedef struct {
     /** set to sizeof(btav_callbacks_t) */
     size_t      size;
     btav_connection_state_callback  connection_state_cb;
     btav_audio_state_callback audio_state_cb;
+    btav_audio_config_callback audio_config_cb;
 } btav_callbacks_t;
 
 /** 
@@ -65,7 +76,9 @@ typedef struct {
  *    android_audio_hw library and the Bluetooth stack.
  * 
  */
-/** Represents the standard BT-AV interface. */
+/** Represents the standard BT-AV interface.
+ *  Used for both the A2DP source and sink interfaces.
+ */
 typedef struct {
 
     /** set to sizeof(btav_interface_t) */
-- 
1.9.1

