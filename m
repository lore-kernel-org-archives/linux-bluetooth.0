Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH v3 1/5] android: Define class of device as four bytes in IPC doc
Date: Tue, 29 Oct 2013 12:52:38 +0100
Message-ID: <1383047562-4799-2-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1383047562-4799-1-git-send-email-szymon.janc@tieto.com>
References: <1383047562-4799-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

For PIN and SSP requests callback define CoD as 4 bytes. This will
allow HAL library to pass CoD direclty to callback. Will also match
how CoD is passed as property.
---
 android/hal-ipc-api.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/android/hal-ipc-api.txt b/android/hal-ipc-api.txt
index dc0d067..e7af8a3 100644
--- a/android/hal-ipc-api.txt
+++ b/android/hal-ipc-api.txt
@@ -354,13 +354,13 @@ Notifications:
 
 		Notification parameters: Remote address (6 octets)
 		                         Remote name (249 octets)
-		                         Class of device (3 octets)
+		                         Class of device (4 octets)
 
 	Opcode 0x87 - SSP Request notification
 
 		Notification parameters: Remote address (6 octets)
 		                         Remote name (249 octets)
-		                         Class of device (3 octets)
+		                         Class of device (4 octets)
 		                         Pairing variant (1 octet)
 		                         Passkey (4 octets)
 
-- 
1.8.4.1

