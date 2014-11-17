Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCH 1/4] android/hal-ipc-api: Update HidHost with Android 5 API
Date: Mon, 17 Nov 2014 15:06:55 +0100
Message-Id: <1416233218-16456-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/hal-ipc-api.txt | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/android/hal-ipc-api.txt b/android/hal-ipc-api.txt
index 67a6205..a5ec44b 100644
--- a/android/hal-ipc-api.txt
+++ b/android/hal-ipc-api.txt
@@ -671,6 +671,13 @@ Notifications:
 		                     0x0c = Authentication failed
 		                     0x0d = HDL
 
+	Opcode 0x87 - Handshake notification
+
+		Notification parameters: Remote address (6 octets)
+		                         Status (1 octet)
+
+		Valid status values: Same as in Virtual Unplug notification
+
 
 Bluetooth PAN HAL (ID 4)
 ========================
-- 
1.9.1

