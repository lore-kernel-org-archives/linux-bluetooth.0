Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCH 1/4] android/hal-gatt-api: Rename Service ID to GATT Service ID
Date: Wed,  5 Mar 2014 15:43:56 +0100
Message-Id: <1394030639-28134-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Use "GATT Service ID" instead "Service ID" inside ipc documentation
which is used to describe Core services like HAL_SERVICE_ID_GATT
himself.
---
 android/hal-ipc-api.txt | 46 ++++++++++++++++++++++------------------------
 1 file changed, 22 insertions(+), 24 deletions(-)

diff --git a/android/hal-ipc-api.txt b/android/hal-ipc-api.txt
index 43b79ec..4f1b74d 100644
--- a/android/hal-ipc-api.txt
+++ b/android/hal-ipc-api.txt
@@ -1496,15 +1496,13 @@ Android HAL name: "gatt" (BT_PROFILE_GATT_ID)
 	Opcode 0x09 - Get Included Service command/response
 
 		Command parameters: Connection ID (4 octets)
-		                    Number of Service ID Elements (1 octet)
-		                    Service ID Elements (variable)
+		                    Number of GATT Service ID Elements (1 octet)
+		                    GATT Service ID Elements (variable)
 		Valid Number of Service ID Elements: 0x01
 		                                     0x02
-		Valid Service ID Element: UUID (16 octets)
-		                          Instance ID (1 octet)
-		                          Is Primary (1 octet)
-		Valid GATT ID: UUID (16 octets)
-		               Instance ID (1 octet)
+		Valid GATT Service ID Element: UUID (16 octets)
+		                               Instance ID (1 octet)
+		                               Is Primary (1 octet)
 		Response parameters: <none>
 
 		In case of an error, the error response will be returned.
@@ -1512,10 +1510,10 @@ Android HAL name: "gatt" (BT_PROFILE_GATT_ID)
 	Opcode 0x0a - Get Characteristic command/response
 
 		Command parameters: Connection ID (4 octets)
-		                    Service ID (18 octets)
+		                    GATT Service ID (18 octets)
 		                    Number of GATT ID Elements (1 octet)
 		                    GATT ID Elements (variable)
-		Valid Service ID: as described in Get Included Service
+		Valid GATT Service ID: as described in Get Included Service
 		Valid Number of GATT ID Elements: 0x00
 		                                  0x01
 		Valid GATT ID Element: as described in Get Included Service
@@ -1526,10 +1524,10 @@ Android HAL name: "gatt" (BT_PROFILE_GATT_ID)
 	Opcode 0x0b - Get Descriptor command/response
 
 		Command parameters: Connection ID (4 octets)
-		                    Service ID (18 octets)
+		                    GATT Service ID (18 octets)
 		                    Number of GATT ID Elements (1 octet)
 		                    GATT ID Elements (variable)
-		Valid Service ID: as described in Get Included Service
+		Valid GATT Service ID: as described in Get Included Service
 		Valid Number of GATT ID Elements: 0x01
 		                                  0x02
 		Valid GATT ID Element: as described in Get Included Service
@@ -1540,10 +1538,10 @@ Android HAL name: "gatt" (BT_PROFILE_GATT_ID)
 	Opcode 0x0c - Read Characteristic command/response
 
 		Command parameters: Connection ID (4 octets)
-		                    Service ID (18 octets)
+		                    GATT Service ID (18 octets)
 		                    GATT ID (17 octets)
 		                    Authorization (4 octets)
-		Valid Service ID: as described in Get Included Service
+		Valid GATT Service ID: as described in Get Included Service
 		Valid GATT ID: as described in Get Included Service
 		Response parameters: <none>
 
@@ -1552,13 +1550,13 @@ Android HAL name: "gatt" (BT_PROFILE_GATT_ID)
 	Opcode 0x0d - Write Characteristic command/response
 
 		Command parameters: Connection ID (4 octets)
-		                    Service ID (18 octets)
+		                    GATT Service ID (18 octets)
 		                    GATT ID (17 octets)
 		                    Write Type (4 octets)
 		                    Length (4 octets)
 		                    Authorization Req. (4 octets)
 		                    Value (variable)
-		Valid Service ID: as described in Get Included Service
+		Valid GATT Service ID: as described in Get Included Service
 		Valid GATT ID: as described in Get Included Service
 		Response parameters: <none>
 
@@ -1567,11 +1565,11 @@ Android HAL name: "gatt" (BT_PROFILE_GATT_ID)
 	Opcode 0x0e - Read Descriptor command/response
 
 		Command parameters: Connection ID (4 octets)
-		                    Service ID (18 octets)
+		                    GATT Service ID (18 octets)
 		                    GATT ID (17 octets)
 		                    Descr. GATT ID (17 octets)
 		                    Authorization Req. (4 octets)
-		Valid Service ID: as described in Get Included Service
+		Valid GATT Service ID: as described in Get Included Service
 		Valid GATT ID: as described in Get Included Service
 		Response parameters: <none>
 
@@ -1580,14 +1578,14 @@ Android HAL name: "gatt" (BT_PROFILE_GATT_ID)
 	Opcode 0x0f - Write Descriptor command/response
 
 		Command parameters: Connection ID (4 octets)
-		                    Service ID (18 octets)
+		                    GATT Service ID (18 octets)
 		                    GATT ID (17 octets)
 		                    Descr. GATT ID (17 octets)
 		                    Write Type (4 octets)
 		                    Length (4 octets)
 		                    Authorization Req. (4 octets)
 		                    Value (variable)
-		Valid Service ID: as described in Get Included Service
+		Valid GATT Service ID: as described in Get Included Service
 		Valid GATT ID: as described in Get Included Service
 		Response parameters: <none>
 
@@ -1605,7 +1603,7 @@ Android HAL name: "gatt" (BT_PROFILE_GATT_ID)
 
 		Command parameters: Client Interface (4 octets)
 		                    Remote address (6 octets)
-		                    Service ID (18 octets)
+		                    GATT Service ID (18 octets)
 		                    GATT ID (17 octets)
 		Response parameters: <none>
 
@@ -1615,7 +1613,7 @@ Android HAL name: "gatt" (BT_PROFILE_GATT_ID)
 
 		Command parameters: Client Interface (4 octets)
 		                    Remote address (6 octets)
-		                    Service ID (18 octets)
+		                    GATT Service ID (18 octets)
 		                    GATT ID (17 octets)
 		Response parameters: <none>
 
@@ -1973,9 +1971,9 @@ Android HAL name: "gatt" (BT_PROFILE_GATT_ID)
 		                         GATT Service ID (18 octets)
 		                         Service Handle (4 octets)
 
-		Valid Service ID: UUID (16 octets)
-		                  Instance ID (1 octet)
-		                  Is Primary (1 octet)
+		Valid GATT Service ID: UUID (16 octets)
+		                       Instance ID (1 octet)
+		                       Is Primary (1 octet)
 
 	Opcode 0x96 - Included Service Added notification
 
-- 
1.9.0

