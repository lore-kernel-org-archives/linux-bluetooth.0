Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH 02/39] android/hal-ipc-api: Use Tone instead of Code DTMF
Date: Tue,  9 Sep 2014 21:56:47 +0200
Message-Id: <1410292644-23497-3-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1410292644-23497-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1410292644-23497-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

To be consistent with existing code for handsfree
---
 android/hal-ipc-api.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/android/hal-ipc-api.txt b/android/hal-ipc-api.txt
index 26e777e..326fa21 100644
--- a/android/hal-ipc-api.txt
+++ b/android/hal-ipc-api.txt
@@ -2209,9 +2209,9 @@ Commands and response:
 
 		In case of an error, the error response will be returned.
 
-	Opcode 0x14 - Send DTMF Code command/response
+	Opcode 0x14 - Send DTMF Tone command/response
 
-		Command parameters: Code (1 octet)
+		Command parameters: Tone (1 octet)
 		Response parameters: <none>
 
 		In case of an error, the error response will be returned.
-- 
1.8.4

