Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCH 1/4] android/hal-ipc-api: Extend a2dp hal API with A2DP Sink role
Date: Fri, 21 Nov 2014 16:13:52 +0100
Message-Id: <1416582835-7712-2-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1416582835-7712-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1416582835-7712-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Android 5 adds audio configuration callback for the a2dp HAL. This
callback is used only by newly introduced a2dp sink role. A2dp Sink
uses the same HAL API as Source role does. Of course there is a
sepparate HAL instance for Sink and just the interface is common with
Source role.
---
 android/hal-ipc-api.txt | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/android/hal-ipc-api.txt b/android/hal-ipc-api.txt
index efcd3cf..01490fa 100644
--- a/android/hal-ipc-api.txt
+++ b/android/hal-ipc-api.txt
@@ -1058,9 +1058,11 @@ Notifications:
 
 
 Bluetooth Advanced Audio HAL (ID 6)
-===================================
+Bluetooth Advanced Audio Sink HAL (ID 13)
+=========================================
 
 Android HAL name: "a2dp" (BT_PROFILE_ADVANCED_AUDIO_ID)
+Android HAL name: "a2dp_sink" (BT_PROFILE_ADVANCED_AUDIO__SINK_ID)
 
 Commands and responses:
 
@@ -1101,6 +1103,14 @@ Notifications:
 		                         0x01 = Stopped
 		                         0x02 = Started
 
+	Opcode 0x83 - Audio Configuration notification
+
+		Notification parameters: Remote address (6 octets)
+					 Sample Rate in Hz (4 octets)
+					 Channel Count (1 octet)
+
+		Valid channel count: 0x01 = Mono
+		                     0x02 = Stereo
 
 Bluetooth Health HAL (ID 7)
 ===========================
-- 
1.9.1

