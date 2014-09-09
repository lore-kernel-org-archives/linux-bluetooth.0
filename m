Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH 03/39] android/hal-ipc-api: Add missing peer features parameter
Date: Tue,  9 Sep 2014 21:56:48 +0200
Message-Id: <1410292644-23497-4-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1410292644-23497-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1410292644-23497-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/hal-ipc-api.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/android/hal-ipc-api.txt b/android/hal-ipc-api.txt
index 326fa21..0948af2 100644
--- a/android/hal-ipc-api.txt
+++ b/android/hal-ipc-api.txt
@@ -2228,7 +2228,8 @@ Notifications:
 	Opcode 0x81 - Connection State Changed notification
 
 		Notification parameters: State (1 octet)
-		                         Peer Features (1 octet)
+		                         Peer Features (2 octets)
+		                         CHLD Features (2 octets)
 		                         Address (6 octets)
 
 		Valid State values: 0x00 = Disconnected
-- 
1.8.4

