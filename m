Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCHv2 1/4] android/hal-ipc-api: Update HidHost with Android 5 API
Date: Thu, 20 Nov 2014 12:18:48 +0100
Message-Id: <1416482331-3766-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/hal-ipc-api.txt | 38 ++++++++++++++++++++++++--------------
 1 file changed, 24 insertions(+), 14 deletions(-)

diff --git a/android/hal-ipc-api.txt b/android/hal-ipc-api.txt
index 67a6205..efcd3cf 100644
--- a/android/hal-ipc-api.txt
+++ b/android/hal-ipc-api.txt
@@ -599,6 +599,23 @@ Commands and responses:
 
 Notifications:
 
+	Status is common for many notifications and has fixed value range:
+
+		Status values: 0x00 = Ok
+		               0x01 = Handshake - Device not ready
+		               0x02 = Handshake - Invalid report ID
+		               0x03 = Handshake - Transaction not SPT
+		               0x04 = Handshake - Invalid parameter
+		               0x05 = Handshake - Generic error
+		               0x06 = General error
+		               0x07 = SDP error
+		               0x08 = Set protocol error
+		               0x09 = Device database full
+		               0x0a = Device type not supported
+		               0x0b = No resources
+		               0x0c = Authentication failed
+		               0x0d = HDL
+
 	Opcode 0x81 - Connection State notification
 
 		Notification parameters: Remote address (6 octets)
@@ -656,20 +673,13 @@ Notifications:
 		Notification parameters: Remote address (6 octets)
 		                         Status (1 octet)
 
-		Valid status values: 0x00 = Ok
-		                     0x01 = Handshake - Device not ready
-		                     0x02 = Handshake - Invalid report ID
-		                     0x03 = Handshake - Transaction not SPT
-		                     0x04 = Handshake - Invalid parameter
-		                     0x05 = Handshake - Generic error
-		                     0x06 = General error
-		                     0x07 = SDP error
-		                     0x08 = Set protocol error
-		                     0x09 = Device database full
-		                     0x0a = Device type not supported
-		                     0x0b = No resources
-		                     0x0c = Authentication failed
-		                     0x0d = HDL
+	Opcode 0x87 - Handshake notification
+
+		Notification parameters: Remote address (6 octets)
+		                         Status (1 octet)
+
+		Only status values from 0x00 to 0x05 are valid as handshake
+		status.
 
 
 Bluetooth PAN HAL (ID 4)
-- 
1.9.1

