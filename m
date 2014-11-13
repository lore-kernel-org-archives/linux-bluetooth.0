Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH] android/hal-ipc-txt: Documentation update and cleanup
Date: Thu, 13 Nov 2014 09:01:21 +0100
Message-Id: <1415865681-30171-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch clarifies that 0x80 opcode is reserved and not used. This is
in case we need to introduce confirmations for notifications.

Error response definition is moved into common place and all HALs are
simply referring to it. This is to keep valid status values in single
place. Valis status is also updated with 'Authentication Rejected'
error added in Android 5.0 API.
---
 android/hal-ipc-api.txt | 168 ++++++------------------------------------------
 1 file changed, 21 insertions(+), 147 deletions(-)

diff --git a/android/hal-ipc-api.txt b/android/hal-ipc-api.txt
index 4f202c8..7c51728 100644
--- a/android/hal-ipc-api.txt
+++ b/android/hal-ipc-api.txt
@@ -55,7 +55,9 @@ The unique service ID is assigned by this specification for each HAL.
 As general rule of thumb, the opcode for command matches the opcode for a
 response. Or the opcode 0x00 for an error is returned.
 
-Notification opcodes start from 0x80.
+Notification opcodes start from 0x81.
+
+Opcode 0x80 is reserved and shall not be used.
 
 All command/response opcodes have the least significant bit not set. And all
 notifications have the least significant bit set.
@@ -115,14 +117,29 @@ specific service.
 	init()                  --> register module handsfree
 
 
-Core Service (ID 0)
-===================
+Error response is common for all services and has fixed structure:
 
 	Opcode 0x00 - Error response
 
 		Response parameters: Status (1 octet)
 
-		Valid status values: 0x01	Failed
+		Valid status values: 0x01 = Fail
+		                     0x02 = Not ready
+		                     0x03 = No memory
+		                     0x04 = Busy
+		                     0x05 = Done (already completed)
+		                     0x06 = Unsupported
+		                     0x07 = Parameter invalid
+		                     0x08 = Unhandled
+		                     0x09 = Authentication failure
+		                     0x0a = Remote device down
+		                     0x0b = Authentication rejected
+
+
+Core Service (ID 0)
+===================
+
+	Opcode 0x00 - Error response
 
 	Opcode 0x01 - Register module command/response
 
@@ -180,8 +197,6 @@ Commands and responses:
 
 	Opcode 0x00 - Error response
 
-		Response parameters: Status (1 octet)
-
 	Opcode 0x01 - Enable command/response
 
 		Command parameters: <none>
@@ -436,19 +451,6 @@ Commands and responses:
 
 	Opcode 0x00 - Error response
 
-		Response parameters: Status (1 octet)
-
-		Valid status values: 0x01 = Fail
-		                     0x02 = Not ready
-		                     0x03 = No memory
-		                     0x04 = Busy
-		                     0x05 = Done (already completed)
-		                     0x06 = Unsupported
-		                     0x07 = Parameter invalid
-		                     0x08 = Unhandled
-		                     0x09 = Authentication failure
-		                     0x0a = Remote device down
-
 	Opcode 0x01 - Listen command/response
 
 		Command parameters: Socket type (1 octet)
@@ -495,19 +497,6 @@ Commands and responses:
 
 	Opcode 0x00 - Error response
 
-		Response parameters: Status (1 octet)
-
-		Valid status values: 0x01 = Fail
-		                     0x02 = Not ready
-		                     0x03 = No memory
-		                     0x04 = Busy
-		                     0x05 = Done (already completed)
-		                     0x06 = Unsupported
-		                     0x07 = Parameter invalid
-		                     0x08 = Unhandled
-		                     0x09 = Authentication failure
-		                     0x0a = Remote device down
-
 	Opcode 0x01 - Connect command/response
 
 		Command parameters: Remote address (6 octets)
@@ -692,19 +681,6 @@ Commands and responses:
 
 	Opcode 0x00 - Error response
 
-		Response parameters: Status (1 octet)
-
-		Valid status values: 0x01 = Fail
-		                     0x02 = Not ready
-		                     0x03 = No memory
-		                     0x04 = Busy
-		                     0x05 = Done (already completed)
-		                     0x06 = Unsupported
-		                     0x07 = Parameter invalid
-		                     0x08 = Unhandled
-		                     0x09 = Authentication failure
-		                     0x0a = Remote device down
-
 	Opcode 0x01 - Enable command/response
 
 		Command parameters: Local role (1 octet)
@@ -792,19 +768,6 @@ Commands and responses:
 
 	Opcode 0x00 - Error response
 
-		Response parameters: Status (1 octet)
-
-		Valid status values: 0x01 = Fail
-		                     0x02 = Not ready
-		                     0x03 = No memory
-		                     0x04 = Busy
-		                     0x05 = Done (already completed)
-		                     0x06 = Unsupported
-		                     0x07 = Parameter invalid
-		                     0x08 = Unhandled
-		                     0x09 = Authentication failure
-		                     0x0a = Remote device down
-
 	Opcode 0x01 - Connect command/response
 
 		Command parameters: Remote address (6 octets)
@@ -1093,19 +1056,6 @@ Commands and responses:
 
 	Opcode 0x00 - Error response
 
-		Response parameters: Status (1 octet)
-
-		Valid status values: 0x01 = Fail
-		                     0x02 = Not ready
-		                     0x03 = No memory
-		                     0x04 = Busy
-		                     0x05 = Done (already completed)
-		                     0x06 = Unsupported
-		                     0x07 = Parameter invalid
-		                     0x08 = Unhandled
-		                     0x09 = Authentication failure
-		                     0x0a = Remote device down
-
 	Opcode 0x01 - Connect command/response
 
 		Command parameters: Remote address (6 octets)
@@ -1151,19 +1101,6 @@ Commands and responses:
 
 	Opcode 0x00 - Error response
 
-		Response parameters: Status (1 octet)
-
-		Valid status values: 0x01 = Fail
-		                     0x02 = Not ready
-		                     0x03 = No memory
-		                     0x04 = Busy
-		                     0x05 = Done (already completed)
-		                     0x06 = Unsupported
-		                     0x07 = Parameter invalid
-		                     0x08 = Unhandled
-		                     0x09 = Authentication failure
-		                     0x0a = Remote device down
-
 	Opcode 0x01 - Register Application command/response
 
 		Command parameters: Number of MDEP (1 octet)
@@ -1250,19 +1187,6 @@ Commands and responses:
 
 	Opcode 0x00 - Error response
 
-		Response parameters: Status (1 octet)
-
-		Valid status values: 0x01 = Fail
-		                     0x02 = Not ready
-		                     0x03 = No memory
-		                     0x04 = Busy
-		                     0x05 = Done (already completed)
-		                     0x06 = Unsupported
-		                     0x07 = Parameter invalid
-		                     0x08 = Unhandled
-		                     0x09 = Authentication failure
-		                     0x0a = Remote device down
-
 	Opcode 0x01 - Get Play Status Response command/response
 
 		Command parameters: Status (1 octet)
@@ -1495,19 +1419,6 @@ Commands and responses:
 
 	Opcode 0x00 - Error response
 
-		Response parameters: Status (1 octet)
-
-		Valid status values: 0x01 = Fail
-		                     0x02 = Not ready
-		                     0x03 = No memory
-		                     0x04 = Busy
-		                     0x05 = Done (already completed)
-		                     0x06 = Unsupported
-		                     0x07 = Parameter invalid
-		                     0x08 = Unhandled
-		                     0x09 = Authentication failure
-		                     0x0a = Remote device down
-
 	Opcode 0x01 - Register Client command/response
 
 		Command parameters: Service UUID (16 octets)
@@ -2127,17 +2038,6 @@ Commands and response:
 
 	Opcode 0x00 - Error response
 
-		Valid status values: 0x01 = Fail
-		                     0x02 = Not ready
-		                     0x03 = No memory
-		                     0x04 = Busy
-		                     0x05 = Done (already completed)
-		                     0x06 = Unsupported
-		                     0x07 = Parameter invalid
-		                     0x08 = Unhandled
-		                     0x09 = Authentication failure
-		                     0x0a = Remote device down
-
 	Opcode 0x01 - Connect command/respose
 
 		Command parameters: Remote address (6 octects)
@@ -2473,19 +2373,6 @@ Commands and responses:
 
 	Opcode 0x00 - Error response
 
-		Response parameters: Status (1 octet)
-
-		Valid status values: 0x01 = Fail
-		                     0x02 = Not ready
-		                     0x03 = No memory
-		                     0x04 = Busy
-		                     0x05 = Done (already completed)
-		                     0x06 = Unsupported
-		                     0x07 = Parameter invalid
-		                     0x08 = Unhandled
-		                     0x09 = Authentication failure
-		                     0x0a = Remote device down
-
 	Opcode 0x01 - Get Remote MAS Instances
 
 		Command parameters: Remote address (6 octets)
@@ -2514,19 +2401,6 @@ Commands and responses:
 
 	Opcode 0x00 - Error response
 
-		Response parameters: Status (1 octet)
-
-		Valid status values: 0x01 = Fail
-		                     0x02 = Not ready
-		                     0x03 = No memory
-		                     0x04 = Busy
-		                     0x05 = Done (already completed)
-		                     0x06 = Unsupported
-		                     0x07 = Parameter invalid
-		                     0x08 = Unhandled
-		                     0x09 = Authentication failure
-		                     0x0a = Remote device down
-
 	Opcode 0x01 - Send Pass Through command/response
 
 		Command parameters: Remote Address (6 octets)
-- 
1.9.1

