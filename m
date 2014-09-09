Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH 01/39] android/hal-ipc-api: Use 2 bytes for location in dial memory
Date: Tue,  9 Sep 2014 21:56:46 +0200
Message-Id: <1410292644-23497-2-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1410292644-23497-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1410292644-23497-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/hal-ipc-api.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/android/hal-ipc-api.txt b/android/hal-ipc-api.txt
index ca41cff..26e777e 100644
--- a/android/hal-ipc-api.txt
+++ b/android/hal-ipc-api.txt
@@ -2162,7 +2162,7 @@ Commands and response:
 
 	Opcode 0x09 - Dial Memory command/response
 
-		Command parameters: Location (1 octet)
+		Command parameters: Location (2 octet)
 		Response parameters: <none>
 
 		In case of an error, the error response will be returned.
-- 
1.8.4

