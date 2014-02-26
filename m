Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCHv2 01/23] android/hal-gatt-api: Add missing opcodes in GATT Service
Date: Wed, 26 Feb 2014 09:40:59 +0100
Message-Id: <1393404081-1401-2-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1393404081-1401-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1393404081-1401-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Add missing Listen and Set Advertising Data opcodes and reorder them as
they appear in HAL's headers.
---
 android/hal-ipc-api.txt | 107 ++++++++++++++++++++++++++++--------------------
 1 file changed, 63 insertions(+), 44 deletions(-)

diff --git a/android/hal-ipc-api.txt b/android/hal-ipc-api.txt
index 5c3933a..49d704e 100644
--- a/android/hal-ipc-api.txt
+++ b/android/hal-ipc-api.txt
@@ -1406,39 +1406,56 @@ Bluetooth GATT HAL (ID 9)
 Android HAL name: "gatt" (BT_PROFILE_GATT_ID)
 
 	Opcode 0x00 - Error response
+
+		Response parameters: Status (1 octet)
+
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
+
 	Opcode 0x01 - Register Client command/response
 	Opcode 0x02 - Unregister Client command/response
 	Opcode 0x03 - Scan command/response
 	Opcode 0x04 - Connect Device command/response
 	Opcode 0x05 - Disconnect Device command/response
-	Opcode 0x06 - Refresh command/response
-	Opcode 0x07 - Search Service command/response
-	Opcode 0x08 - Get Included Service command/response
-	Opcode 0x09 - Get Characteristic command/response
-	Opcode 0x0a - Get Descriptor command/response
-	Opcode 0x0b - Read Characteristic command/response
-	Opcode 0x0c - Write Characteristic command/response
-	Opcode 0x0d - Read Descriptor command/response
-	Opcode 0x0e - Write Descriptor command/response
-	Opcode 0x0f - Execute Write command/response
-	Opcode 0x10 - Register For Notification command/response
-	Opcode 0x11 - Deregister For Notification command/response
-	Opcode 0x12 - Read Remote RSSI command/response
-	Opcode 0x13 - Get Device Type command/response
-	Opcode 0x14 - Test Command command/response
-	Opcode 0x15 - Register Server command/response
-	Opcode 0x16 - Unregister Server command/response
-	Opcode 0x17 - Connect Peripheral command/response
-	Opcode 0x18 - Disconnect Peripheral command/response
-	Opcode 0x19 - Add Service command/response
-	Opcode 0x1a - Add Included Service command/response
-	Opcode 0x1b - Add Characteristic command/response
-	Opcode 0x1c - Add Descriptor command/response
-	Opcode 0x1d - Start Service command/response
-	Opcode 0x1e - Stop Service command/response
-	Opcode 0x1f - Delete Service command/response
-	Opcode 0x20 - Send Indication command/response
-	Opcode 0x21 - Send Response command/response
+	Opcode 0x06 - Listen command/response
+	Opcode 0x07 - Refresh command/response
+	Opcode 0x08 - Search Service command/response
+	Opcode 0x09 - Get Included Service command/response
+	Opcode 0x0a - Get Characteristic command/response
+	Opcode 0x0b - Get Descriptor command/response
+	Opcode 0x0c - Read Characteristic command/response
+	Opcode 0x0d - Write Characteristic command/response
+	Opcode 0x0e - Read Descriptor command/response
+	Opcode 0x0f - Write Descriptor command/response
+	Opcode 0x10 - Execute Write command/response
+	Opcode 0x11 - Register For Notification command/response
+	Opcode 0x12 - Deregister For Notification command/response
+	Opcode 0x13 - Read Remote RSSI command/response
+	Opcode 0x14 - Get Device Type command/response
+	Opcode 0x15 - Set Advertising data command/response
+	Opcode 0x16 - Test Command command/response
+
+	Opcode 0x17 - Register Server command/response
+	Opcode 0x18 - Unregister Server command/response
+	Opcode 0x19 - Connect Peripheral command/response
+	Opcode 0x1a - Disconnect Peripheral command/response
+	Opcode 0x1b - Add Service command/response
+	Opcode 0x1c - Add Included Service command/response
+	Opcode 0x1d - Add Characteristic command/response
+	Opcode 0x1e - Add Descriptor command/response
+	Opcode 0x1f - Start Service command/response
+	Opcode 0x20 - Stop Service command/response
+	Opcode 0x21 - Delete Service command/response
+	Opcode 0x22 - Send Indication command/response
+	Opcode 0x23 - Send Response command/response
 
 	Opcode 0x81 - Register Client notification
 	Opcode 0x82 - Scan Result notification
@@ -1453,20 +1470,22 @@ Android HAL name: "gatt" (BT_PROFILE_GATT_ID)
 	Opcode 0x8b - Notify notification
 	Opcode 0x8c - Read Characteristic notification
 	Opcode 0x8d - Write Characteristic notification
-	Opcode 0x8e - Execute Write notification
-	Opcode 0x8f - Read Descriptor notification
-	Opcode 0x90 - Write Descriptor notification
+	Opcode 0x8e - Read Descriptor notification
+	Opcode 0x8f - Write Descriptor notification
+	Opcode 0x90 - Execute Write notification
 	Opcode 0x91 - Read Remote RSSI notification
-	Opcode 0x92 - Register Server notification
-	Opcode 0x93 - Connection notification
-	Opcode 0x94 - Service Added notification
-	Opcode 0x95 - Included Service Added notification
-	Opcode 0x96 - Characteristic Added notification
-	Opcode 0x97 - Descriptor Added notification
-	Opcode 0x98 - Service Started notification
-	Opcode 0x99 - Service Stopped notification
-	Opcode 0x9a - Service Deleted notification
-	Opcode 0x9b - Request Read notification
-	Opcode 0x9c - Request Write notification
-	Opcode 0x9d - Request Execute Write notification
-	Opcode 0x9e - Response Confirmation notification
+	Opcode 0x92 - Listen notification
+
+	Opcode 0x93 - Register Server notification
+	Opcode 0x94 - Connection notification
+	Opcode 0x95 - Service Added notification
+	Opcode 0x96 - Included Service Added notification
+	Opcode 0x97 - Characteristic Added notification
+	Opcode 0x98 - Descriptor Added notification
+	Opcode 0x99 - Service Started notification
+	Opcode 0x9a - Service Stopped notification
+	Opcode 0x9b - Service Deleted notification
+	Opcode 0x9c - Request Read notification
+	Opcode 0x9d - Request Write notification
+	Opcode 0x9e - Request Execute Write notification
+	Opcode 0x9f - Response Confirmation notification
-- 
1.9.0

