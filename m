Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 4/4] android/doc: Add Audio SCO HAL documentation
Date: Wed, 23 Jul 2014 14:35:01 +0300
Message-Id: <1406115301-18812-4-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1406115301-18812-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1406115301-18812-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

---
 android/README | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/android/README b/android/README
index 72b157a..279530c 100644
--- a/android/README
+++ b/android/README
@@ -300,6 +300,34 @@ methods:
 client->set_adv_data               missing kernel support for vendor data
 client->connect                    is_direct parameter is ignored
 
+Audio SCO HAL
+=============
+
+When Bluetooth chip's audio is not wired directly to device audio, Audio SCO
+HAL is used to enable SCO support. It needs to be loaded by AudioFlinger
+following audio_policy.cong configuration. Example of configuration is shown
+below:
+
+...
+  sco {
+    outputs {
+      sco {
+        sampling_rates 8000|44100
+        channel_masks AUDIO_CHANNEL_OUT_STEREO
+        formats AUDIO_FORMAT_PCM_16_BIT
+        devices AUDIO_DEVICE_OUT_ALL_SCO
+      }
+    }
+    inputs {
+      sco {
+        sampling_rates 8000|44100
+        channel_masks AUDIO_CHANNEL_IN_MONO
+        formats AUDIO_FORMAT_PCM_16_BIT
+        devices AUDIO_DEVICE_IN_BLUETOOTH_SCO_HEADSET
+      }
+    }
+  }
+...
 
 Known Android issues
 ====================
-- 
1.9.1

