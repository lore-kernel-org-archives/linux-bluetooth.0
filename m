Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH] android: Update Audio IPC documentation
Date: Fri, 24 Jan 2014 15:50:29 +0100
Message-ID: <1390575029-6800-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Open Stream commands now also returns outoging MTU for returned socket.
---
 android/audio-ipc-api.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/android/audio-ipc-api.txt b/android/audio-ipc-api.txt
index 4aff92c..f4a497d 100644
--- a/android/audio-ipc-api.txt
+++ b/android/audio-ipc-api.txt
@@ -66,7 +66,8 @@ Audio Service (ID 0)
 	Opcode 0x03 - Open Stream command
 
 		Command parameters: Endpoint ID (1 octet)
-		Response parameters: Codec configuration length (1 octet)
+		Response parameters: Outgoing MTU (2 octets)
+				     Codec configuration length (1 octet)
 				     Codec configuration (1 octet)
 				     File descriptor (inline)
 
-- 
1.8.5.2

