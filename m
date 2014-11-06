Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] android/doc: Fix typos
Date: Thu,  6 Nov 2014 10:09:42 +0200
Message-Id: <1415261382-5355-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

---
 android/hal-ipc-api.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/android/hal-ipc-api.txt b/android/hal-ipc-api.txt
index c7d5c59..666e27f 100644
--- a/android/hal-ipc-api.txt
+++ b/android/hal-ipc-api.txt
@@ -1768,7 +1768,7 @@ Commands and responses:
 	Opcode 0x19 - Connect Peripheral command/response
 
 		Command parameters: Server (4 octets)
-		                    Remote address (6 octes)
+		                    Remote address (6 octets)
 		                    Is Direct (1 octet)
 		                    Transport (4 octets)
 		Response parameters: <none>
@@ -1778,7 +1778,7 @@ Commands and responses:
 	Opcode 0x1a - Disconnect Peripheral command/response
 
 		Command parameters: Server (4 octets)
-		                    Remote address (6 octes)
+		                    Remote address (6 octets)
 		                    Connection ID (1 octet)
 		Response parameters: <none>
 
-- 
1.9.1

