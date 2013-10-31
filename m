Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 01/14] android: Add missing bonding state definitions to IPC specification
Date: Thu, 31 Oct 2013 02:55:41 +0000
Message-Id: <1383188154-22905-2-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1383188154-22905-1-git-send-email-szymon.janc@tieto.com>
References: <1383188154-22905-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/hal-ipc-api.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/android/hal-ipc-api.txt b/android/hal-ipc-api.txt
index e7af8a3..a5d1980 100644
--- a/android/hal-ipc-api.txt
+++ b/android/hal-ipc-api.txt
@@ -370,6 +370,10 @@ Notifications:
 		                         Remote address (6 octets)
 		                         Bond state (1 octet)
 
+		Valid bond state values: 0x00 = None
+		                         0x01 = Bonding
+		                         0x02 = Bonded
+
 	Opcode 0x89 - ACL State Changed notification
 
 		Notification parameters: Status (1 octect)
-- 
1.8.4.rc3

