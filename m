Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 3/5] android/hal-ipc-api: Add GATT Server MTU Changed notification
Date: Wed, 11 Mar 2015 15:41:21 +0100
Message-Id: <1426084883-10291-3-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1426084883-10291-1-git-send-email-szymon.janc@tieto.com>
References: <1426084883-10291-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Add definition of GATT server MTU changed notification.
---
 android/hal-ipc-api.txt | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/android/hal-ipc-api.txt b/android/hal-ipc-api.txt
index 77f2f57..503b47a 100644
--- a/android/hal-ipc-api.txt
+++ b/android/hal-ipc-api.txt
@@ -2329,6 +2329,11 @@ Notifications:
 		Notification parameters: Connection ID (4 octets)
 		                         Congested (1 octet)
 
+	Opcode 0xb0 - Server MTU Changed notification
+
+		Notification parameters: Connection ID (4 octets)
+		                         MTU (4 octets)
+
 
 Bluetooth Handsfree Client HAL (ID 10)
 ======================================
-- 
1.9.3

