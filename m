Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH 8/8] android/ipc: Add common definitions for GATT IPC structures
Date: Thu, 17 Apr 2014 01:10:33 +0200
Message-Id: <1397689833-17557-9-git-send-email-andrzej.kaczmarek@tieto.com>
In-Reply-To: <1397689833-17557-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1397689833-17557-1-git-send-email-andrzej.kaczmarek@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Since GATT IPC uses common structures for services, characteristics and
descriptors in many messages there's no need to describe each structure
in each call separately. They can be replaced with common definition.
---
 android/hal-ipc-api.txt | 157 ++++++++++--------------------------------------
 1 file changed, 32 insertions(+), 125 deletions(-)

diff --git a/android/hal-ipc-api.txt b/android/hal-ipc-api.txt
index fa6552e..1e519cd 100644
--- a/android/hal-ipc-api.txt
+++ b/android/hal-ipc-api.txt
@@ -1434,6 +1434,22 @@ Bluetooth GATT HAL (ID 9)
 
 Android HAL name: "gatt" (BT_PROFILE_GATT_ID)
 
+Structures:
+
+	GATT Service ID: UUID (16 octets)
+	                 Instance ID (1 octet)
+	                 Is Primary (1 octet)
+
+	GATT Included Service ID: UUID (16 octets)
+	                          Instance ID (1 octet)
+	                          Is Primary (1 octet)
+
+	GATT Characteristic ID: UUID (16 octets)
+	                        Instance ID (1 octet)
+
+	GATT Descriptor ID: UUID (16 octets)
+	                    Instance ID (1 octet)
+
 Commands and responses:
 
 	Opcode 0x00 - Error response
@@ -1527,14 +1543,6 @@ Commands and responses:
 		                    ...
 		Response parameters: <none>
 
-		Valid GATT Service ID: UUID (16 octets)
-		                       Instance ID (1 octet)
-		                       Is Primary (1 octet)
-
-		Valid GATT Included Service ID: UUID (16 octets)
-		                                Instance ID (1 octet)
-		                                Is Primary (1 octet)
-
 		GATT Included Service ID shall only be present when Continuation is non-zero.
 
 		In case of an error, the error response will be returned.
@@ -1548,13 +1556,6 @@ Commands and responses:
 		                    ...
 		Response parameters: <none>
 
-		Valid GATT Service ID: UUID (16 octets)
-		                       Instance ID (1 octet)
-		                       Is Primary (1 octet)
-
-		Valid GATT Characteristic ID: UUID (16 octets)
-		                              Instance ID (1 octet)
-
 		GATT Characteristic ID shall only be present when Continuation is non-zero.
 
 		In case of an error, the error response will be returned.
@@ -1569,16 +1570,6 @@ Commands and responses:
 		                    ...
 		Response parameters: <none>
 
-		Valid GATT Service ID: UUID (16 octets)
-		                       Instance ID (1 octet)
-		                       Is Primary (1 octet)
-
-		Valid GATT Characteristic ID: UUID (16 octets)
-		                              Instance ID (1 octet)
-
-		Valid GATT Descriptor ID: UUID (16 octets)
-		                          Instance ID (1 octet)
-
 		GATT Descriptor ID shall only be present when Continuation is non-zero.
 
 		In case of an error, the error response will be returned.
@@ -1587,37 +1578,23 @@ Commands and responses:
 
 		Command parameters: Connection ID (4 octets)
 		                    GATT Service ID (18 octets)
-		                    GATT ID (17 octets)
+		                    GATT Characteristic ID (17 octets)
 		                    Authorization (4 octets)
 		Response parameters: <none>
 
-		Valid GATT Service ID: UUID (16 octets)
-		                       Instance ID (1 octet)
-		                       Is Primary (1 octet)
-
-		Valid GATT ID: UUID (16 octets)
-		               Instance ID (1 octet)
-
 		In case of an error, the error response will be returned.
 
 	Opcode 0x0d - Write Characteristic command/response
 
 		Command parameters: Connection ID (4 octets)
 		                    GATT Service ID (18 octets)
-		                    GATT ID (17 octets)
+		                    GATT Characteristic ID (17 octets)
 		                    Write Type (4 octets)
 		                    Length (4 octets)
 		                    Authorization Req. (4 octets)
 		                    Value (variable)
 		Response parameters: <none>
 
-		Valid GATT Service ID: UUID (16 octets)
-		                       Instance ID (1 octet)
-		                       Is Primary (1 octet)
-
-		Valid GATT ID: UUID (16 octets)
-		               Instance ID (1 octet)
-
 		Valid Write Type: 0x01 = No response
 		                  0x02 = Default
 		                  0x03 = Prepare
@@ -1629,45 +1606,25 @@ Commands and responses:
 
 		Command parameters: Connection ID (4 octets)
 		                    GATT Service ID (18 octets)
-		                    GATT ID (17 octets)
-		                    Descr. GATT ID (17 octets)
+		                    GATT Characteristic ID (17 octets)
+		                    GATT Descriptor ID (17 octets)
 		                    Authorization Req. (4 octets)
 		Response parameters: <none>
 
-		Valid GATT Service ID: UUID (16 octets)
-		                       Instance ID (1 octet)
-		                       Is Primary (1 octet)
-
-		Valid GATT ID: UUID (16 octets)
-		               Instance ID (1 octet)
-
-		Valid Descr. GATT ID: UUID (16 octets)
-		                      Instance ID (1 octet)
-
 		In case of an error, the error response will be returned.
 
 	Opcode 0x0f - Write Descriptor command/response
 
 		Command parameters: Connection ID (4 octets)
 		                    GATT Service ID (18 octets)
-		                    GATT ID (17 octets)
-		                    Descr. GATT ID (17 octets)
+		                    GATT Characteristic ID (17 octets)
+		                    GATT Descriptor ID (17 octets)
 		                    Write Type (4 octets)
 		                    Length (4 octets)
 		                    Authorization Req. (4 octets)
 		                    Value (variable)
 		Response parameters: <none>
 
-		Valid GATT Service ID: UUID (16 octets)
-		                       Instance ID (1 octet)
-		                       Is Primary (1 octet)
-
-		Valid GATT ID: UUID (16 octets)
-		               Instance ID (1 octet)
-
-		Valid Descr. GATT ID: UUID (16 octets)
-		                      Instance ID (1 octet)
-
 		Valid Write Type: 0x01 = No response
 		                  0x02 = Default
 		                  0x03 = Prepare
@@ -1688,16 +1645,9 @@ Commands and responses:
 		Command parameters: Client Interface (4 octets)
 		                    Remote address (6 octets)
 		                    GATT Service ID (18 octets)
-		                    GATT ID (17 octets)
+		                    GATT Characteristic ID (17 octets)
 		Response parameters: <none>
 
-		Valid GATT Service ID: UUID (16 octets)
-		                       Instance ID (1 octet)
-		                       Is Primary (1 octet)
-
-		Valid GATT ID: UUID (16 octets)
-		               Instance ID (1 octet)
-
 		In case of an error, the error response will be returned.
 
 	Opcode 0x12 - Deregister For Notification command/response
@@ -1705,16 +1655,9 @@ Commands and responses:
 		Command parameters: Client Interface (4 octets)
 		                    Remote address (6 octets)
 		                    GATT Service ID (18 octets)
-		                    GATT ID (17 octets)
+		                    GATT Characteristic ID (17 octets)
 		Response parameters: <none>
 
-		Valid GATT Service ID: UUID (16 octets)
-		                       Instance ID (1 octet)
-		                       Is Primary (1 octet)
-
-		Valid GATT ID: UUID (16 octets)
-		               Instance ID (1 octet)
-
 		In case of an error, the error response will be returned.
 
 	Opcode 0x13 - Read Remote RSSI command/response
@@ -1935,44 +1878,28 @@ Notifications:
 		Notification parameters: Connection ID (4 octets)
 		                         GATT Service ID (18 octets)
 
-		Valid GATT Service ID: UUID (16 octets)
-		                       Instance ID (1 octets)
-		                       Is Primary (1 octet)
-
 	Opcode 0x87 - Get Characteristic notification
 
 		Notification parameters: Connection ID (4 octets)
 		                         Status (4 octets)
 		                         GATT Service ID (18 octets)
-		                         GATT Char. ID (17 octets)
+		                         GATT Characteristic ID (17 octets)
 		                         Char Prop. (4 octets)
 
-		Valid GATT Service: As described in Search Result
-
-		Valid GATT Char. ID: UUID (16 octets)
-		                     Instance ID (1 octet)
-
 	Opcode 0x88 - Get Descriptor notification
 
 		Notification parameters: Connection ID (4 octets)
 		                         Status (4 octets)
 		                         GATT Service ID (18 octets)
-		                         GATT Char. ID (17 octets)
-		                         GATT Descr. ID (17 octets)
-
-		Valid GATT Service & Char. ID: As described in Get Characteristic
-
-		Valid GATT Descr. ID: UUID (16 octets)
-		                      Instance ID (1 octet)
+		                         GATT Characteristic ID (17 octets)
+		                         GATT Descriptor ID (17 octets)
 
 	Opcode 0x89 - Get Included Service notification
 
 		Notification parameters: Connection ID (4 octets)
 		                         Status (4 octets)
 		                         GATT Service ID (18 octets)
-		                         GATT Incl. Service ID (18 octets)
-
-		Valid GATT Service & Incl. Service ID: As described in Search Result
+		                         GATT Included Service ID (18 octets)
 
 	Opcode 0x8a - Register For Notification notification
 
@@ -1980,26 +1907,18 @@ Notifications:
 		                         Registered (4 octets)
 		                         Status (4 octets)
 		                         GATT Service ID (18 octets)
-		                         GATT Char. ID (17 octets)
-
-		Valid GATT Service ID: As described in Get Characteristic
-
-		Valid GATT Char. ID: As described in Get Characteristic
+		                         GATT Characteristic ID (17 octets)
 
 	Opcode 0x8b - Notify notification
 
 		Notification parameters: Connection ID (4 octets)
 		                         Address (6 octets)
 		                         GATT Service ID (18 octets)
-		                         GATT Char. ID (17 octets)
+		                         GATT Characteristic ID (17 octets)
 		                         Is Notify (1 octet)
 		                         Length (2 octets)
 		                         Value (variable)
 
-		Valid GATT Service ID: As described in Get Characteristic
-
-		Valid GATT Char. ID: As described in Get Characteristic
-
 	Opcode 0x8c - Read Characteristic notification
 
 		Notification parameters: Connection ID (4 octets)
@@ -2007,17 +1926,13 @@ Notifications:
 		                         GATT Read Parameters (variable)
 
 		Valid GATT Read Parameters: GATT Service ID (18 octets)
-		                            GATT Char. ID (17 octets)
-		                            GATT Descr. ID (17 octets)
+		                            GATT Characteristic ID (17 octets)
+		                            GATT Descriptor ID (17 octets)
 		                            Value Type (4 octets)
 		                            Status (1 octet)
 		                            Length (2 octets)
 		                            Value (variable)
 
-		Valid GATT Service ID: As described in Get Characteristic
-
-		Valid GATT Char. & Decr. ID: As described in Get Descriptor
-
 	Opcode 0x8d - Write Characteristic notification
 
 		Notification parameters: Connection ID (4 octets)
@@ -2029,10 +1944,6 @@ Notifications:
 		                             GATT Description ID (17 octets)
 		                             Status (1 octet)
 
-		Valid GATT Service ID: As described in Get Descriptor
-
-		Valid GATT Char. & Decr. ID: As described in Get Descriptor
-
 	Opcode 0x8e - Read Descriptor notification
 
 		Notification parameters: Connection ID (4 octets)
@@ -2086,10 +1997,6 @@ Notifications:
 		                         GATT Service ID (18 octets)
 		                         Service Handle (4 octets)
 
-		Valid GATT Service ID: UUID (16 octets)
-		                       Instance ID (1 octet)
-		                       Is Primary (1 octet)
-
 	Opcode 0x96 - Included Service Added notification
 
 		Notification patemeters: Status (4 octets)
-- 
1.9.2

