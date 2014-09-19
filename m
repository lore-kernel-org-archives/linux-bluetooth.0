Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH 1/6] android/hal-ipc-api: Fix location size and add missing feature list
Date: Fri, 19 Sep 2014 16:30:46 +0200
Message-Id: <1411137051-28904-2-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1411137051-28904-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1411137051-28904-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch changes location size of Dial Memory command to 4 bytes in
order to be consistent with HAL API

It also adds missing peer and chld features values. Size of those
features also has been changed to be consisten with HAL API.
---
 android/hal-ipc-api.txt | 36 ++++++++++++++++++++++++++++++++----
 1 file changed, 32 insertions(+), 4 deletions(-)

diff --git a/android/hal-ipc-api.txt b/android/hal-ipc-api.txt
index f6e1680..853d27f 100644
--- a/android/hal-ipc-api.txt
+++ b/android/hal-ipc-api.txt
@@ -2162,7 +2162,7 @@ Commands and response:
 
 	Opcode 0x09 - Dial Memory command/response
 
-		Command parameters: Location (2 octet)
+		Command parameters: Location (4 octet)
 		Response parameters: <none>
 
 		In case of an error, the error response will be returned.
@@ -2228,8 +2228,8 @@ Notifications:
 	Opcode 0x81 - Connection State Changed notification
 
 		Notification parameters: State (1 octet)
-		                         Peer Features (2 octets)
-		                         CHLD Features (2 octets)
+		                         Peer Features (4 octets)
+		                         CHLD Features (4 octets)
 		                         Address (6 octets)
 
 		Valid State values: 0x00 = Disconnected
@@ -2237,7 +2237,35 @@ Notifications:
 		                    0x02 = SLC Connected
 		                    0x03 = Disconnecting
 
-		Note: Peer Features is valid only in SCL Connected state
+		Peer Features is a bitmask of the supported features. Currently
+		available bits:
+
+			0	Three way calling
+			1	Echo cancellation and/or noise reduction
+			2	Voice recognition
+			3	In band ring tone
+			4	Attach a number to a voice tag
+			5	Ability to reject a call
+			6	Enhanced call status
+			7	Enhanced call control
+			8	Extended Error Result Codes
+			9	Codec negotiations
+			10-31	Reserved for future use
+
+		CHLD Features is a bitmask of the supported features. Currently
+		available bits:
+
+			0	Release waiting call or held calls
+			1	Release active calls and accept other call
+			2	Release specified active call only
+			3	Place all active calls on hold and accept other call
+			4	Request private mode with secified call
+			5	Add a held call to the multiparty
+			6	Connect two calls and leave multiparty
+			7-31	Reserved for future use
+
+		Note: Peer and CHLD Features are valid only in SCL Connected state
+
 
 	Opcode 0x82 - Audio State Changed notification
 
-- 
1.8.4

