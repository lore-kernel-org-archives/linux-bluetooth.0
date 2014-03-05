Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCH 2/4] android/hal-ipc-api: Fix documentation structure and notation
Date: Wed,  5 Mar 2014 15:43:57 +0100
Message-Id: <1394030639-28134-2-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1394030639-28134-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1394030639-28134-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Clean up the documentation by using 'Element # ...' notation for
variable length arrays of structs, fixing whitespaces and reordering
some parts.
---
 android/hal-ipc-api.txt | 160 +++++++++++++++++++++++++++++++++++-------------
 1 file changed, 116 insertions(+), 44 deletions(-)

diff --git a/android/hal-ipc-api.txt b/android/hal-ipc-api.txt
index 4f1b74d..05bb4db 100644
--- a/android/hal-ipc-api.txt
+++ b/android/hal-ipc-api.txt
@@ -330,25 +330,28 @@ Notifications:
 
 		Notification parameters: Status (1 octect)
 		                         Num properties (1 octet)
-		                         Type[i] (1 octect)
-		                         Length[i] (2 octets)
-		                         Value[i] (variable)
+		                         Type # (1 octet)
+		                         Length # (2 octets)
+		                         Value # (variable)
+		                         ...
 
 	Opcode 0x83 - Remote Device Properties notification
 
 		Notification parameters: Status (1 octect)
 		                         Remote address (6 octets)
 		                         Num properties (1 octet)
-		                         Type[i] (1 octect)
-		                         Length[i] (2 octets)
-		                         Value[i] (variable)
+		                         Type # (1 octet)
+		                         Length # (2 octets)
+		                         Value # (variable)
+		                         ...
 
 	Opcode 0x84 - Device Found notification
 
 		Notification parameters: Num properties (1 octet)
-		                         Type[i] (1 octect)
-		                         Length[i] (2 octets)
-		                         Value[i] (variable)
+		                         Type # (1 octet)
+		                         Length # (2 octets)
+		                         Value # (variable)
+		                         ...
 
 	Opcode 0x85 - Discovery State Changed notification
 
@@ -1121,10 +1124,11 @@ Android HAL name: "health" (BT_PROFILE_HEALTH_ID)
 		                    Service name (string)
 		                    Service description (string)
 		                    Number of MDEP (1 octet)
-		                    MDEP Role[i] (1 octet)
-		                    Data type[i] (1 octet)
-		                    Channel type[i] (1 octet)
-		                    MDEP description (string)
+		                    MDEP Role # (1 octet)
+		                    Data type # (1 octet)
+		                    Channel type # (1 octet)
+		                    MDEP description # (string)
+		                    ...
 		Response parameters: Application ID (2 octets)
 
 		In case of an error, the error response will be returned.
@@ -1486,10 +1490,12 @@ Android HAL name: "gatt" (BT_PROFILE_GATT_ID)
 
 		Command parameters: Connection ID (4 octets)
 		                    Number of UUID Filters (1 octet)
-		                    UUID Filter (variable)
+		                    UUID Filter # (16 octets)
+		                    ...
+		Response parameters: <none>
+
 		Valid Number of UUID Filters: 0x00
 		                              0x01
-		Response parameters: <none>
 
 		In case of an error, the error response will be returned.
 
@@ -1497,14 +1503,15 @@ Android HAL name: "gatt" (BT_PROFILE_GATT_ID)
 
 		Command parameters: Connection ID (4 octets)
 		                    Number of GATT Service ID Elements (1 octet)
-		                    GATT Service ID Elements (variable)
-		Valid Number of Service ID Elements: 0x01
-		                                     0x02
-		Valid GATT Service ID Element: UUID (16 octets)
-		                               Instance ID (1 octet)
-		                               Is Primary (1 octet)
+		                    GATT Service ID # UUID (16 octets)
+		                    GATT Service ID # Instance ID (1 octet)
+		                    GATT Service ID # Is Primary (1 octet)
+		                    ...
 		Response parameters: <none>
 
+		Valid Number of GATT Service ID Elements: 0x01
+		                                          0x02
+
 		In case of an error, the error response will be returned.
 
 	Opcode 0x0a - Get Characteristic command/response
@@ -1512,12 +1519,17 @@ Android HAL name: "gatt" (BT_PROFILE_GATT_ID)
 		Command parameters: Connection ID (4 octets)
 		                    GATT Service ID (18 octets)
 		                    Number of GATT ID Elements (1 octet)
-		                    GATT ID Elements (variable)
-		Valid GATT Service ID: as described in Get Included Service
+		                    GATT ID # UUID (16 octets)
+		                    GATT ID # Instance ID (1 octet)
+		                    ...
+		Response parameters: <none>
+
+		Valid GATT Service ID: UUID (16 octets)
+		                       Instance ID (1 octet)
+		                       Is Primary (1 octet)
+
 		Valid Number of GATT ID Elements: 0x00
 		                                  0x01
-		Valid GATT ID Element: as described in Get Included Service
-		Response parameters: <none>
 
 		In case of an error, the error response will be returned.
 
@@ -1526,12 +1538,17 @@ Android HAL name: "gatt" (BT_PROFILE_GATT_ID)
 		Command parameters: Connection ID (4 octets)
 		                    GATT Service ID (18 octets)
 		                    Number of GATT ID Elements (1 octet)
-		                    GATT ID Elements (variable)
-		Valid GATT Service ID: as described in Get Included Service
+		                    GATT ID # UUID (16 octets)
+		                    GATT ID # Instance ID (1 octet)
+		                    ...
+		Response parameters: <none>
+
+		Valid GATT Service ID: UUID (16 octets)
+		                       Instance ID (1 octet)
+		                       Is Primary (1 octet)
+
 		Valid Number of GATT ID Elements: 0x01
 		                                  0x02
-		Valid GATT ID Element: as described in Get Included Service
-		Response parameters: <none>
 
 		In case of an error, the error response will be returned.
 
@@ -1541,10 +1558,15 @@ Android HAL name: "gatt" (BT_PROFILE_GATT_ID)
 		                    GATT Service ID (18 octets)
 		                    GATT ID (17 octets)
 		                    Authorization (4 octets)
-		Valid GATT Service ID: as described in Get Included Service
-		Valid GATT ID: as described in Get Included Service
 		Response parameters: <none>
 
+		Valid GATT Service ID: UUID (16 octets)
+		                       Instance ID (1 octet)
+		                       Is Primary (1 octet)
+
+		Valid GATT ID: UUID (16 octets)
+		               Instance ID (1 octet)
+
 		In case of an error, the error response will be returned.
 
 	Opcode 0x0d - Write Characteristic command/response
@@ -1556,10 +1578,15 @@ Android HAL name: "gatt" (BT_PROFILE_GATT_ID)
 		                    Length (4 octets)
 		                    Authorization Req. (4 octets)
 		                    Value (variable)
-		Valid GATT Service ID: as described in Get Included Service
-		Valid GATT ID: as described in Get Included Service
 		Response parameters: <none>
 
+		Valid GATT Service ID: UUID (16 octets)
+		                       Instance ID (1 octet)
+		                       Is Primary (1 octet)
+
+		Valid GATT ID: UUID (16 octets)
+		               Instance ID (1 octet)
+
 		In case of an error, the error response will be returned.
 
 	Opcode 0x0e - Read Descriptor command/response
@@ -1569,10 +1596,18 @@ Android HAL name: "gatt" (BT_PROFILE_GATT_ID)
 		                    GATT ID (17 octets)
 		                    Descr. GATT ID (17 octets)
 		                    Authorization Req. (4 octets)
-		Valid GATT Service ID: as described in Get Included Service
-		Valid GATT ID: as described in Get Included Service
 		Response parameters: <none>
 
+		Valid GATT Service ID: UUID (16 octets)
+		                       Instance ID (1 octet)
+		                       Is Primary (1 octet)
+
+		Valid GATT ID: UUID (16 octets)
+		               Instance ID (1 octet)
+
+		Valid Descr. GATT ID: UUID (16 octets)
+		                      Instance ID (1 octet)
+
 		In case of an error, the error response will be returned.
 
 	Opcode 0x0f - Write Descriptor command/response
@@ -1585,10 +1620,18 @@ Android HAL name: "gatt" (BT_PROFILE_GATT_ID)
 		                    Length (4 octets)
 		                    Authorization Req. (4 octets)
 		                    Value (variable)
-		Valid GATT Service ID: as described in Get Included Service
-		Valid GATT ID: as described in Get Included Service
 		Response parameters: <none>
 
+		Valid GATT Service ID: UUID (16 octets)
+		                       Instance ID (1 octet)
+		                       Is Primary (1 octet)
+
+		Valid GATT ID: UUID (16 octets)
+		               Instance ID (1 octet)
+
+		Valid Descr. GATT ID: UUID (16 octets)
+		                      Instance ID (1 octet)
+
 		In case of an error, the error response will be returned.
 
 	Opcode 0x10 - Execute Write command/response
@@ -1607,6 +1650,13 @@ Android HAL name: "gatt" (BT_PROFILE_GATT_ID)
 		                    GATT ID (17 octets)
 		Response parameters: <none>
 
+		Valid GATT Service ID: UUID (16 octets)
+		                       Instance ID (1 octet)
+		                       Is Primary (1 octet)
+
+		Valid GATT ID: UUID (16 octets)
+		               Instance ID (1 octet)
+
 		In case of an error, the error response will be returned.
 
 	Opcode 0x12 - Deregister For Notification command/response
@@ -1617,6 +1667,13 @@ Android HAL name: "gatt" (BT_PROFILE_GATT_ID)
 		                    GATT ID (17 octets)
 		Response parameters: <none>
 
+		Valid GATT Service ID: UUID (16 octets)
+		                       Instance ID (1 octet)
+		                       Is Primary (1 octet)
+
+		Valid GATT ID: UUID (16 octets)
+		               Instance ID (1 octet)
+
 		In case of an error, the error response will be returned.
 
 	Opcode 0x13 - Read Remote RSSI command/response
@@ -1704,15 +1761,12 @@ Android HAL name: "gatt" (BT_PROFILE_GATT_ID)
 		Command parameters: Server (4 octets)
 		                    GATT Service ID (18 octets)
 		                    Number of Handles (4 octet)
+		Response parameters: <none>
 
 		Valid GATT Service ID: UUID (16 octets)
-		                       Instance ID (1 octets)
+		                       Instance ID (1 octet)
 		                       Is Primary (1 octet)
 
-		Valid GATT ID: UUID (16 octets)
-		               Instance ID (1 octets)
-		Response parameters: <none>
-
 		In case of an error, the error response will be returned.
 
 	Opcode 0x1c - Add Included Service command/response
@@ -1788,6 +1842,7 @@ Android HAL name: "gatt" (BT_PROFILE_GATT_ID)
 		                    Transaction ID (4 octets)
 		                    Status (4 octets)
 		                    GATT Response (4 octets)
+		Response parameters: <none>
 
 		Valid GATT Response: GATT Value (607 octets)
 		                     Handle (2 octets)
@@ -1797,7 +1852,6 @@ Android HAL name: "gatt" (BT_PROFILE_GATT_ID)
 		                  Offset (2 octets)
 		                  Length (2 octets)
 		                  Authentication Request (1 octet)
-		Response parameters: <none>
 
 		In case of an error, the error response will be returned.
 
@@ -1837,6 +1891,7 @@ Android HAL name: "gatt" (BT_PROFILE_GATT_ID)
 
 		Notification parameters: Connection ID (4 octets)
 		                         GATT Service ID (18 octets)
+
 		Valid GATT Service ID: UUID (16 octets)
 		                       Instance ID (1 octets)
 		                       Is Primary (1 octet)
@@ -1848,7 +1903,9 @@ Android HAL name: "gatt" (BT_PROFILE_GATT_ID)
 		                         GATT Service ID (18 octets)
 		                         GATT Char. ID (17 octets)
 		                         Char Prop. (4 octets)
+
 		Valid GATT Service: As described in Search Result
+
 		Valid GATT Char. ID: UUID (16 octets)
 		                     Instance ID (1 octet)
 
@@ -1859,7 +1916,9 @@ Android HAL name: "gatt" (BT_PROFILE_GATT_ID)
 		                         GATT Service ID (18 octets)
 		                         GATT Char. ID (17 octets)
 		                         GATT Descr. ID (17 octets)
+
 		Valid GATT Service & Char. ID: As described in Get Characteristic
+
 		Valid GATT Descr. ID: UUID (16 octets)
 		                      Instance ID (1 octet)
 
@@ -1869,6 +1928,7 @@ Android HAL name: "gatt" (BT_PROFILE_GATT_ID)
 		                         Status (4 octets)
 		                         GATT Service ID (18 octets)
 		                         GATT Incl. Service ID (18 octets)
+
 		Valid GATT Service & Incl. Service ID: As described in Search Result
 
 	Opcode 0x8a - Register For Notification notification
@@ -1878,7 +1938,9 @@ Android HAL name: "gatt" (BT_PROFILE_GATT_ID)
 		                         Status (4 octets)
 		                         GATT Service ID (18 octets)
 		                         GATT Char. ID (17 octets)
+
 		Valid GATT Service ID: As described in Get Characteristic
+
 		Valid GATT Char. ID: As described in Get Characteristic
 
 	Opcode 0x8b - Notify notification
@@ -1890,7 +1952,9 @@ Android HAL name: "gatt" (BT_PROFILE_GATT_ID)
 		                         Is Notify (1 octet)
 		                         Length (2 octets)
 		                         Value (variable)
-		Valid Service ID: As described in Get Characteristic
+
+		Valid GATT Service ID: As described in Get Characteristic
+
 		Valid GATT Char. ID: As described in Get Characteristic
 
 	Opcode 0x8c - Read Characteristic notification
@@ -1898,6 +1962,7 @@ Android HAL name: "gatt" (BT_PROFILE_GATT_ID)
 		Notification parameters: Connection ID (4 octets)
 		                         Status (4 octets)
 		                         GATT Read Parameters (variable)
+
 		Valid GATT Read Parameters: GATT Service ID (18 octets)
 		                            GATT Char. ID (17 octets)
 		                            GATT Descr. ID (17 octets)
@@ -1905,7 +1970,9 @@ Android HAL name: "gatt" (BT_PROFILE_GATT_ID)
 		                            Status (1 octet)
 		                            Length (2 octets)
 		                            Value (variable)
+
 		Valid GATT Service ID: As described in Get Characteristic
+
 		Valid GATT Char. & Decr. ID: As described in Get Descriptor
 
 	Opcode 0x8d - Write Characteristic notification
@@ -1913,11 +1980,14 @@ Android HAL name: "gatt" (BT_PROFILE_GATT_ID)
 		Notification parameters: Connection ID (4 octets)
 		                         Status (4 octets)
 		                         GATT Write Parameters (53 octets)
+
 		Valid GATT Write Parameters: GATT Service ID (18 octets)
 		                             GATT Characteristic ID (17 octets)
 		                             GATT Description ID (17 octets)
 		                             Status (1 octet)
+
 		Valid GATT Service ID: As described in Get Descriptor
+
 		Valid GATT Char. & Decr. ID: As described in Get Descriptor
 
 	Opcode 0x8e - Read Descriptor notification
@@ -1925,6 +1995,7 @@ Android HAL name: "gatt" (BT_PROFILE_GATT_ID)
 		Notification parameters: Connection ID (4 octets)
 		                         Status (4 octets)
 		                         GATT Read Parameters (variable)
+
 		Valid GATT Read Parameters: As described in Read Characteristic
 
 	Opcode 0x8f - Write Descriptor notification
@@ -1932,6 +2003,7 @@ Android HAL name: "gatt" (BT_PROFILE_GATT_ID)
 		Notification parameters: Connection ID (4 octets)
 		                         Status (4 octets)
 		                         GATT Write Parameters (53 octets)
+
 		Valid GATT Write Parameters: As described in Write Characteristic
 
 	Opcode 0x90 - Execute Write notification
-- 
1.9.0

