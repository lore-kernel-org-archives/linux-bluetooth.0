Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 1/6] android: Add missing adapter state values to IPC documentation
Date: Wed, 23 Oct 2013 15:46:21 +0200
Message-ID: <1382535986-30684-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/hal-ipc-api.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/android/hal-ipc-api.txt b/android/hal-ipc-api.txt
index dcd1553..a5437c1 100644
--- a/android/hal-ipc-api.txt
+++ b/android/hal-ipc-api.txt
@@ -314,6 +314,9 @@ Notifications:
 
 		Notifications parameters: State (1 octect)
 
+		Valid state values: 0x00 = Off
+		                    0x01 = On
+
 	Opcode 0x82 - Adapter Properties Changed notification
 
 		Notification parameters: Status (1 octect)
-- 
1.8.4

