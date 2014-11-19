Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCH 1/3] android/hal-ipc-api: Add av callbacks for Android 5
Date: Wed, 19 Nov 2014 14:10:04 +0100
Message-Id: <1416402606-31762-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Android 5 adds audio configuration callback.
---
 android/hal-ipc-api.txt | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/android/hal-ipc-api.txt b/android/hal-ipc-api.txt
index a5ec44b..9502a15 100644
--- a/android/hal-ipc-api.txt
+++ b/android/hal-ipc-api.txt
@@ -1098,6 +1098,15 @@ Notifications:
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
+
 
 Bluetooth Health HAL (ID 7)
 ===========================
-- 
1.9.1

