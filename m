Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH] android/hal-ipc-txt: Prefix GATT HAL with Client or Server
Date: Thu, 13 Nov 2014 09:43:08 +0100
Message-Id: <1415868188-31794-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

GATT HAL implements both client and server. All commands and
notifications are prefixed with proper role.

Android 5 enhanced both client and server API with new commands and
events so codes will no longer be continuous. This will make tracking
client and server commands/notifications easier.
---
 android/hal-ipc-api.txt | 141 ++++++++++++++++++++++++------------------------
 1 file changed, 72 insertions(+), 69 deletions(-)

diff --git a/android/hal-ipc-api.txt b/android/hal-ipc-api.txt
index 7c51728..cc2530c 100644
--- a/android/hal-ipc-api.txt
+++ b/android/hal-ipc-api.txt
@@ -1419,21 +1419,21 @@ Commands and responses:
 
 	Opcode 0x00 - Error response
 
-	Opcode 0x01 - Register Client command/response
+	Opcode 0x01 - Client Register command/response
 
 		Command parameters: Service UUID (16 octets)
 		Response parameters: <none>
 
 		In case of an error, the error response will be returned.
 
-	Opcode 0x02 - Unregister Client command/response
+	Opcode 0x02 - Client Unregister command/response
 
 		Command parameters: Client Interface (4 octets)
 		Response parameters: <none>
 
 		In case of an error, the error response will be returned.
 
-	Opcode 0x03 - Scan command/response
+	Opcode 0x03 - Client Scan command/response
 
 		Command parameters: Client Interface (4 octets)
 		                    Start (1 octet)
@@ -1441,7 +1441,7 @@ Commands and responses:
 
 		In case of an error, the error response will be returned.
 
-	Opcode 0x04 - Connect Device command/response
+	Opcode 0x04 - Client Connect Device command/response
 
 		Command parameters: Client Interface (4 octets)
 		                    Remote address (6 octets)
@@ -1451,7 +1451,7 @@ Commands and responses:
 
 		In case of an error, the error response will be returned.
 
-	Opcode 0x05 - Disconnect Device command/response
+	Opcode 0x05 - Client Disconnect Device command/response
 
 		Command parameters: Client Interface (4 octets)
 		                    Remote address (6 octets)
@@ -1460,7 +1460,7 @@ Commands and responses:
 
 		In case of an error, the error response will be returned.
 
-	Opcode 0x06 - Listen command/response
+	Opcode 0x06 - Client Listen command/response
 
 		Command parameters: Client Interface (4 octets)
 		                    Start (1 octet)
@@ -1468,7 +1468,7 @@ Commands and responses:
 
 		In case of an error, the error response will be returned.
 
-	Opcode 0x07 - Refresh command/response
+	Opcode 0x07 - Client Refresh command/response
 
 		Command parameters: Client Interface (4 octets)
 		                    Remote address (6 octets)
@@ -1476,7 +1476,7 @@ Commands and responses:
 
 		In case of an error, the error response will be returned.
 
-	Opcode 0x08 - Search Service command/response
+	Opcode 0x08 - Client Search Service command/response
 
 		Command parameters: Connection ID (4 octets)
 		                    Filtered (1 octet)
@@ -1487,7 +1487,7 @@ Commands and responses:
 
 		In case of an error, the error response will be returned.
 
-	Opcode 0x09 - Get Included Service command/response
+	Opcode 0x09 - Client Get Included Service command/response
 
 		Command parameters: Connection ID (4 octets)
 		                    GATT Service ID (18 octets)
@@ -1496,11 +1496,12 @@ Commands and responses:
 		                    ...
 		Response parameters: <none>
 
-		GATT Included Service ID shall only be present when Continuation is non-zero.
+		GATT Included Service ID shall only be present when Continuation
+		is non-zero.
 
 		In case of an error, the error response will be returned.
 
-	Opcode 0x0a - Get Characteristic command/response
+	Opcode 0x0a - Client Get Characteristic command/response
 
 		Command parameters: Connection ID (4 octets)
 		                    GATT Service ID (18 octets)
@@ -1509,11 +1510,12 @@ Commands and responses:
 		                    ...
 		Response parameters: <none>
 
-		GATT Characteristic ID shall only be present when Continuation is non-zero.
+		GATT Characteristic ID shall only be present when Continuation
+		is non-zero.
 
 		In case of an error, the error response will be returned.
 
-	Opcode 0x0b - Get Descriptor command/response
+	Opcode 0x0b - Client Get Descriptor command/response
 
 		Command parameters: Connection ID (4 octets)
 		                    GATT Service ID (18 octets)
@@ -1523,11 +1525,12 @@ Commands and responses:
 		                    ...
 		Response parameters: <none>
 
-		GATT Descriptor ID shall only be present when Continuation is non-zero.
+		GATT Descriptor ID shall only be present when Continuation is
+		non-zero.
 
 		In case of an error, the error response will be returned.
 
-	Opcode 0x0c - Read Characteristic command/response
+	Opcode 0x0c - Client Read Characteristic command/response
 
 		Command parameters: Connection ID (4 octets)
 		                    GATT Service ID (18 octets)
@@ -1537,7 +1540,7 @@ Commands and responses:
 
 		In case of an error, the error response will be returned.
 
-	Opcode 0x0d - Write Characteristic command/response
+	Opcode 0x0d - Client Write Characteristic command/response
 
 		Command parameters: Connection ID (4 octets)
 		                    GATT Service ID (18 octets)
@@ -1555,7 +1558,7 @@ Commands and responses:
 
 		In case of an error, the error response will be returned.
 
-	Opcode 0x0e - Read Descriptor command/response
+	Opcode 0x0e - Client Read Descriptor command/response
 
 		Command parameters: Connection ID (4 octets)
 		                    GATT Service ID (18 octets)
@@ -1566,7 +1569,7 @@ Commands and responses:
 
 		In case of an error, the error response will be returned.
 
-	Opcode 0x0f - Write Descriptor command/response
+	Opcode 0x0f - Client Write Descriptor command/response
 
 		Command parameters: Connection ID (4 octets)
 		                    GATT Service ID (18 octets)
@@ -1585,7 +1588,7 @@ Commands and responses:
 
 		In case of an error, the error response will be returned.
 
-	Opcode 0x10 - Execute Write command/response
+	Opcode 0x10 - Client Execute Write command/response
 
 		Command parameters: Connection ID (4 octets)
 		                    Execute (4 octets)
@@ -1593,7 +1596,7 @@ Commands and responses:
 
 		In case of an error, the error response will be returned.
 
-	Opcode 0x11 - Register For Notification command/response
+	Opcode 0x11 - Client Register For Notification command/response
 
 		Command parameters: Client Interface (4 octets)
 		                    Remote address (6 octets)
@@ -1603,7 +1606,7 @@ Commands and responses:
 
 		In case of an error, the error response will be returned.
 
-	Opcode 0x12 - Deregister For Notification command/response
+	Opcode 0x12 - Client Deregister For Notification command/response
 
 		Command parameters: Client Interface (4 octets)
 		                    Remote address (6 octets)
@@ -1613,7 +1616,7 @@ Commands and responses:
 
 		In case of an error, the error response will be returned.
 
-	Opcode 0x13 - Read Remote RSSI command/response
+	Opcode 0x13 - Client Read Remote RSSI command/response
 
 		Command parameters: Client Interface (4 octets)
 		                    Remote address (6 octets)
@@ -1621,7 +1624,7 @@ Commands and responses:
 
 		In case of an error, the error response will be returned.
 
-	Opcode 0x14 - Get Device Type command/response
+	Opcode 0x14 - Client Get Device Type command/response
 
 		Command parameters: Remote address (6 octets)
 		Response parameters: Device Type
@@ -1632,7 +1635,7 @@ Commands and responses:
 
 		In case of an error, the error response will be returned.
 
-	Opcode 0x15 - Set Advertising data command/response
+	Opcode 0x15 - Client Set Advertising data command/response
 
 		Command parameters: Server Interface (4 octets)
 		                    Set Scan Resp. (1 octet)
@@ -1647,7 +1650,7 @@ Commands and responses:
 
 		In case of an error, the error response will be returned.
 
-	Opcode 0x16 - Test Command command/response
+	Opcode 0x16 - Client Test Command command/response
 
 		Command parameters: Command (4 octets)
 		                    Address (6 octets)
@@ -1661,21 +1664,21 @@ Commands and responses:
 
 		In case of an error, the error response will be returned.
 
-	Opcode 0x17 - Register Server command/response
+	Opcode 0x17 - Server Register command/response
 
 		Command parameters: UUID (16 octets)
 		Response parameters: <none>
 
 		In case of an error, the error response will be returned.
 
-	Opcode 0x18 - Unregister Server command/response
+	Opcode 0x18 - Server Unregister command/response
 
 		Command parameters: Server (4 octets)
 		Response parameters: <none>
 
 		In case of an error, the error response will be returned.
 
-	Opcode 0x19 - Connect Peripheral command/response
+	Opcode 0x19 - Server Connect Peripheral command/response
 
 		Command parameters: Server (4 octets)
 		                    Remote address (6 octets)
@@ -1685,7 +1688,7 @@ Commands and responses:
 
 		In case of an error, the error response will be returned.
 
-	Opcode 0x1a - Disconnect Peripheral command/response
+	Opcode 0x1a - Server Disconnect Peripheral command/response
 
 		Command parameters: Server (4 octets)
 		                    Remote address (6 octets)
@@ -1694,7 +1697,7 @@ Commands and responses:
 
 		In case of an error, the error response will be returned.
 
-	Opcode 0x1b - Add Service command/response
+	Opcode 0x1b - Server Add Service command/response
 
 		Command parameters: Server (4 octets)
 		                    GATT Service ID (18 octets)
@@ -1707,7 +1710,7 @@ Commands and responses:
 
 		In case of an error, the error response will be returned.
 
-	Opcode 0x1c - Add Included Service command/response
+	Opcode 0x1c - Server Add Included Service command/response
 
 		Command parameters: Server (4 octets)
 		                    Service handle (4 octets)
@@ -1716,7 +1719,7 @@ Commands and responses:
 
 		In case of an error, the error response will be returned.
 
-	Opcode 0x1d - Add Characteristic command/response
+	Opcode 0x1d - Server Add Characteristic command/response
 
 		Command parameters: Server (4 octets)
 		                    Service handle (4 octets)
@@ -1727,7 +1730,7 @@ Commands and responses:
 
 		In case of an error, the error response will be returned.
 
-	Opcode 0x1e - Add Descriptor command/response
+	Opcode 0x1e - Server Add Descriptor command/response
 
 		Command parameters: Server (4 octets)
 		                    Service handle (4 octets)
@@ -1737,7 +1740,7 @@ Commands and responses:
 
 		In case of an error, the error response will be returned.
 
-	Opcode 0x1f - Start Service command/response
+	Opcode 0x1f - Server Start Service command/response
 
 		Command parameters: Server (4 octets)
 		                    Service handle (4 octets)
@@ -1746,7 +1749,7 @@ Commands and responses:
 
 		In case of an error, the error response will be returned.
 
-	Opcode 0x20 - Stop Service command/response
+	Opcode 0x20 - Server Stop Service command/response
 
 		Command parameters: Server (4 octets)
 		                    Service handle (4 octets)
@@ -1754,7 +1757,7 @@ Commands and responses:
 
 		In case of an error, the error response will be returned.
 
-	Opcode 0x21 - Delete Service command/response
+	Opcode 0x21 - Server Delete Service command/response
 
 		Command parameters: Server (4 octets)
 		                    Service handle (4 octets)
@@ -1762,7 +1765,7 @@ Commands and responses:
 
 		In case of an error, the error response will be returned.
 
-	Opcode 0x22 - Send Indication command/response
+	Opcode 0x22 - Server Send Indication command/response
 
 		Command parameters: Server (4 octets)
 		                    Attribute handle (4 octets)
@@ -1774,7 +1777,7 @@ Commands and responses:
 
 		In case of an error, the error response will be returned.
 
-	Opcode 0x23 - Send Response command/response
+	Opcode 0x23 - Server Send Response command/response
 
 		Command parameters: Connection ID (4 octets)
 		                    Transaction ID (4 octets)
@@ -1798,44 +1801,44 @@ Commands and responses:
 
 Notifications:
 
-	Opcode 0x81 - Register Client notification
+	Opcode 0x81 - Client Register notification
 
 		Notification parameters: Status (4 octets)
 		                         Client Interface (4 octets)
 		                         UUID (16 octets)
 
-	Opcode 0x82 - Scan Result notification
+	Opcode 0x82 - Client Scan Result notification
 
 		Notification parameters: Address (6 octets)
 		                         RSSI (4 octets)
 		                         Length (2 octets)
 		                         Data (variable)
 
-	Opcode 0x83 - Connect Device notification
+	Opcode 0x83 - Client Connect Device notification
 
 		Notification parameters: Connection ID (4 octets)
 		                         Status (4 octets)
 		                         Client Interface (4 octets)
 		                         Address (6 octets)
 
-	Opcode 0x84 - Disconnect Device notification
+	Opcode 0x84 - Client Disconnect Device notification
 
 		Notification parameters: Connection ID (4 octets)
 		                         Status (4 octets)
 		                         Client Interface (4 octets)
 		                         Address (6 octets)
 
-	Opcode 0x85 - Search Complete notification
+	Opcode 0x85 - Client Search Complete notification
 
 		Notification parameters: Connection ID (4 octets)
 		                         Status (4 octets)
 
-	Opcode 0x86 - Search Result notification
+	Opcode 0x86 - Client Search Result notification
 
 		Notification parameters: Connection ID (4 octets)
 		                         GATT Service ID (18 octets)
 
-	Opcode 0x87 - Get Characteristic notification
+	Opcode 0x87 - Client Get Characteristic notification
 
 		Notification parameters: Connection ID (4 octets)
 		                         Status (4 octets)
@@ -1843,7 +1846,7 @@ Notifications:
 		                         GATT Characteristic ID (17 octets)
 		                         Char Prop. (4 octets)
 
-	Opcode 0x88 - Get Descriptor notification
+	Opcode 0x88 - Client Get Descriptor notification
 
 		Notification parameters: Connection ID (4 octets)
 		                         Status (4 octets)
@@ -1851,14 +1854,14 @@ Notifications:
 		                         GATT Characteristic ID (17 octets)
 		                         GATT Descriptor ID (17 octets)
 
-	Opcode 0x89 - Get Included Service notification
+	Opcode 0x89 - Client Get Included Service notification
 
 		Notification parameters: Connection ID (4 octets)
 		                         Status (4 octets)
 		                         GATT Service ID (18 octets)
 		                         GATT Included Service ID (18 octets)
 
-	Opcode 0x8a - Register For Notification notification
+	Opcode 0x8a - Client Register For Notification notification
 
 		Notification parameters: Connection ID (4 octets)
 		                         Registered (4 octets)
@@ -1866,7 +1869,7 @@ Notifications:
 		                         GATT Service ID (18 octets)
 		                         GATT Characteristic ID (17 octets)
 
-	Opcode 0x8b - Notify notification
+	Opcode 0x8b - Client Notify notification
 
 		Notification parameters: Connection ID (4 octets)
 		                         Address (6 octets)
@@ -1876,7 +1879,7 @@ Notifications:
 		                         Length (2 octets)
 		                         Value (variable)
 
-	Opcode 0x8c - Read Characteristic notification
+	Opcode 0x8c - Client Read Characteristic notification
 
 		Notification parameters: Connection ID (4 octets)
 		                         Status (4 octets)
@@ -1890,7 +1893,7 @@ Notifications:
 		                            Length (2 octets)
 		                            Value (variable)
 
-	Opcode 0x8d - Write Characteristic notification
+	Opcode 0x8d - Client Write Characteristic notification
 
 		Notification parameters: Connection ID (4 octets)
 		                         Status (4 octets)
@@ -1901,7 +1904,7 @@ Notifications:
 		                             GATT Description ID (17 octets)
 		                             Status (1 octet)
 
-	Opcode 0x8e - Read Descriptor notification
+	Opcode 0x8e - Client Read Descriptor notification
 
 		Notification parameters: Connection ID (4 octets)
 		                         Status (4 octets)
@@ -1909,7 +1912,7 @@ Notifications:
 
 		Valid GATT Read Parameters: As described in Read Characteristic
 
-	Opcode 0x8f - Write Descriptor notification
+	Opcode 0x8f - Client Write Descriptor notification
 
 		Notification parameters: Connection ID (4 octets)
 		                         Status (4 octets)
@@ -1917,51 +1920,51 @@ Notifications:
 
 		Valid GATT Write Parameters: As described in Write Characteristic
 
-	Opcode 0x90 - Execute Write notification
+	Opcode 0x90 - Client Execute Write notification
 
 		Notification parameters: Connection ID (4 octets)
 		                         Status (4 octets)
 
-	Opcode 0x91 - Read Remote RSSI notification
+	Opcode 0x91 - Client Read Remote RSSI notification
 
 		Notification parameters: Client (4 octets)
 		                         Address (6 octets)
 		                         RSSI (4 octets)
 		                         Status (4 octets)
 
-	Opcode 0x92 - Listen notification
+	Opcode 0x92 - Client Listen notification
 
 		Notification parameters: Status (4 octets)
 		                         Server Interface (4 octets)
 
-	Opcode 0x93 - Register Server notification
+	Opcode 0x93 - Server Register notification
 
 		Notification parameters: Status (4 octets)
 		                         Server (4 octets)
 		                         UUID (16 octets)
 
-	Opcode 0x94 - Connection notification
+	Opcode 0x94 - Server Connection notification
 
 		Notification parameters: Connection ID (4 octets)
 		                         Server (4 octets)
 		                         Connected (4 octets)
 		                         Address (6 octets)
 
-	Opcode 0x95 - Service Added notification
+	Opcode 0x95 - Server Service Added notification
 
 		Notification parameters: Status (4 octets)
 		                         Server (4 octets)
 		                         GATT Service ID (18 octets)
 		                         Service Handle (4 octets)
 
-	Opcode 0x96 - Included Service Added notification
+	Opcode 0x96 - Server Included Service Added notification
 
 		Notification patemeters: Status (4 octets)
 		                         Server (4 octets)
 		                         Service Handle (4 octets)
 		                         Included Service Handle (4 octets)
 
-	Opcode 0x97 - Characteristic Added notification
+	Opcode 0x97 - Server Characteristic Added notification
 
 		Notification parameters: Status (4 octets)
 		                         Server (4 octets)
@@ -1969,7 +1972,7 @@ Notifications:
 		                         Service Handle (4 octets)
 		                         Characteristic Handle (4 octets)
 
-	Opcode 0x98 - Descriptor Added notification
+	Opcode 0x98 - Server Descriptor Added notification
 
 		Notification parameters: Status (4 octets)
 		                         Server (4 octets)
@@ -1977,25 +1980,25 @@ Notifications:
 		                         Service Handle (4 octets)
 		                         Descriptor Handle (4 octets)
 
-	Opcode 0x99 - Service Started notification
+	Opcode 0x99 - Server Service Started notification
 
 		Notification parameters: Status (4 octets)
 		                         Server (4 octets)
 		                         Service Handle (4 octets)
 
-	Opcode 0x9a - Service Stopped notification
+	Opcode 0x9a - Server Service Stopped notification
 
 		Notification parameters: Status (4 octets)
 		                         Server (4 octets)
 		                         Service Handle (4 octets)
 
-	Opcode 0x9b - Service Deleted notification
+	Opcode 0x9b - Server Service Deleted notification
 
 		Notification parameters: Status (4 octets)
 		                         Server (4 octets)
 		                         Service Handle (4 octets)
 
-	Opcode 0x9c - Request Read notification
+	Opcode 0x9c - Server Request Read notification
 
 		Notification parameters: Connection ID (4 octets)
 		                         Trans ID (4 octets)
@@ -2004,7 +2007,7 @@ Notifications:
 		                         Offset (4 octets)
 		                         Is Long (1 octet)
 
-	Opcode 0x9d - Request Write notification
+	Opcode 0x9d - Server Request Write notification
 
 		Notification parameters: Connection ID (4 octets)
 		                         Trans ID (4 octets)
@@ -2016,14 +2019,14 @@ Notifications:
 		                         Is Prepare (1 octet)
 		                         Value (variable)
 
-	Opcode 0x9e - Request Execute Write notification
+	Opcode 0x9e - Server Request Execute Write notification
 
 		Notification parameters: Connection ID (4 octets)
 		                         Trans ID (4 octets)
 		                         Address (6 octets)
 		                         Execute Write (4 octets)
 
-	Opcode 0x9f - Response Confirmation notification
+	Opcode 0x9f - Server Response Confirmation notification
 
 		Notification parameters: Status (4 octets)
 		                         Handle (4 octets)
-- 
1.9.1

