Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH] android/hal-ipc-api: Update GATT service with Android 5 API
Date: Thu, 13 Nov 2014 16:17:48 +0100
Message-Id: <1415891868-18442-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This add definitions for commands and notifications introduced by
Android 5 API.
---
 android/hal-ipc-api.txt | 266 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 266 insertions(+)

diff --git a/android/hal-ipc-api.txt b/android/hal-ipc-api.txt
index cc2530c..67a6205 100644
--- a/android/hal-ipc-api.txt
+++ b/android/hal-ipc-api.txt
@@ -1449,6 +1449,10 @@ Commands and responses:
 		                    Transport (4 octets)
 		Response parameters: <none>
 
+		Valid transport value: 0x00 = Auto
+		                       0x01 = BR/EDR
+		                       0x02 = LE
+
 		In case of an error, the error response will be returned.
 
 	Opcode 0x05 - Client Disconnect Device command/response
@@ -1799,6 +1803,174 @@ Commands and responses:
 
 		In case of an error, the error response will be returned.
 
+	Opcode 0x24 - Client Scan Filter Params Setup command/response
+
+		Command parameters: Client Interface (4 octets)
+		                    Action (4 octets)
+		                    Filter Index (4 octets)
+		                    Features (4 octets)
+		                    List Type (4 octets)
+		                    Filter Type (4 octets)
+		                    RSSI High Threshold (4 octets)
+		                    RSSI Low Threshold (4 octets)
+		                    Delivery Mode (4 octets)
+		                    Found Timeout (4 octets)
+		                    Lost Timeout (4 octets)
+		                    Found Timeout Count (4 octets)
+		Response parameters: <none>
+
+		In case of an error, the error response will be returned.
+
+	Opcode 0x25 - Client Scan Filter Add Remove command/response
+
+		Command parameters: Client Interface (4 octets)
+		                    Action (4 octets)
+		                    Filter Type (4 octets)
+		                    Filter Index (4 octets)
+		                    Company ID (4 octets)
+		                    Company ID Mask (4 octets)
+		                    UUID (16 octets)
+		                    UUID Mask (16 octets)
+		                    Address (6 octets)
+		                    Address Type (1 octet)
+		                    Data Length (4 octets)
+		                    Data (variable)
+		                    Mask Length (4 octets)
+		                    Mask (variable)
+		Response parameters: <none>
+
+		In case of an error, the error response will be returned.
+
+	Opcode 0x26 - Client Scan Filter Clear command/response
+
+		Command parameters: Client Interface (4 octets)
+		                    Filter Index (4 octets)
+		Response parameters: <none>
+
+		In case of an error, the error response will be returned.
+
+	Opcode 0x27 - Client Scan Filter Enable command/response
+
+		Command parameters: Client Interface (4 octets)
+		                    Enable (1 octet)
+		Response parameters: <none>
+
+		In case of an error, the error response will be returned.
+
+	Opcode 0x28 - Client Configure MTU command/response
+
+		Command parameters: Connection ID (4 octets)
+		                    MTU (4 octets)
+		Response parameters: <none>
+
+		In case of an error, the error response will be returned.
+
+	Opcode 0x29 - Client Connection Parameter Update command/response
+
+		Command parameters: Address (6 octets)
+		                    Min Interval (4 octets)
+		                    Max Interval (4 octets)
+		                    Latency (4 octets)
+		                    Timeoutl (4 octets)
+		Response parameters: <none>
+
+		In case of an error, the error response will be returned.
+
+	Opcode 0x2a - Client Set Scan Parameters command/response
+
+		Command parameters: Scan Interval (4 octets)
+		                    Scan Window (4 octets)
+		Response parameters: <none>
+
+		In case of an error, the error response will be returned.
+
+	Opcode 0x2b - Client Setup Multi Advertising command/response
+
+		Command parameters: Client ID (4 octets)
+		                    Min Interval (4 octets)
+		                    Max Interval (4 octets)
+		                    ADV Type (4 octets)
+		                    Channel Map (4 octets)
+		                    TX Power (4 octets)
+		                    Timeout (4 octets)
+		Response parameters: <none>
+
+		In case of an error, the error response will be returned.
+
+	Opcode 0x2c - Client Update Multi Advertising command/response
+
+		Command parameters: Client ID (4 octets)
+		                    Min Interval (4 octets)
+		                    Max Interval (4 octets)
+		                    ADV Type (4 octets)
+		                    Channel Map (4 octets)
+		                    TX Power (4 octets)
+		                    Timeout (4 octets)
+		Response parameters: <none>
+
+		In case of an error, the error response will be returned.
+
+	Opcode 0x2d - Client Setup Multi Advertising Instance command/response
+
+		Command parameters: Client ID (4 octets)
+		                    Set Scan Response (1 octet)
+		                    Include Name (1 octet)
+		                    Include TX Power (1 octet)
+		                    Appearance (4 octets)
+		                    Manufacturer Data Length (4 octets)
+		                    Manufacturer Data (variable)
+		                    Service Data Length (4 octets)
+		                    Service Data (variable)
+		                    Service UUID Length (4 octets)
+		                    Service UUID (variable)
+		Response parameters: <none>
+
+		In case of an error, the error response will be returned.
+
+	Opcode 0x2e - Client Disable Multi Advertising Instance command/response
+
+		Command parameters: Client ID (4 octets)
+		Response parameters: <none>
+
+		In case of an error, the error response will be returned.
+
+	Opcode 0x2f - Client Configure Batchscan command/response
+
+		Command parameters: Client ID (4 octets)
+		                    Full Max (4 octets)
+		                    Trunc Max (4 octets)
+		                    Notify Threshold (4 octets)
+		Response parameters: <none>
+
+		In case of an error, the error response will be returned.
+
+	Opcode 0x30 - Client Enable Batchscan command/response
+
+		Command parameters: Client ID (4 octets)
+		                    Scan Mode (4 octets)
+		                    Scan Interval (4 octets)
+		                    Scan Window (4 octets)
+		                    Address Type (4 octets)
+		                    Discard Rule (4 octets)
+		Response parameters: <none>
+
+		In case of an error, the error response will be returned.
+
+	Opcode 0x31 - Client Disable Batchscan command/response
+
+		Command parameters: Client ID (4 octets)
+		Response parameters: <none>
+
+		In case of an error, the error response will be returned.
+
+	Opcode 0x32 - Client Read Batchscan Resports command/response
+
+		Command parameters: Client ID (4 octets)
+		                    Scan Mode (4 octets)
+		Response parameters: <none>
+
+		In case of an error, the error response will be returned.
+
 Notifications:
 
 	Opcode 0x81 - Client Register notification
@@ -2031,6 +2203,100 @@ Notifications:
 		Notification parameters: Status (4 octets)
 		                         Handle (4 octets)
 
+	Opcode 0xa0 - Client Configure MTU notification
+
+		Notification parameters: Connection ID (4 octets)
+		                         Status (4 octets)
+		                         MTU (4 octets)
+
+	Opcode 0xa1 - Client Filter Configuration notification
+
+		Notification parameters: Action (4 octets)
+		                         Client ID (4 octets)
+		                         Status (4 octets)
+		                         Filter Type (4 octets)
+		                         Available Space (4 octets)
+
+	Opcode 0xa2 - Client Filter Parameters notification
+
+		Notification parameters: Action (4 octets)
+		                         Client ID (4 octets)
+		                         Status (4 octets)
+		                         Available Space (4 octets)
+
+	Opcode 0xa3 - Client Filter Status notification
+
+		Notification parameters: Enable (4 octets)
+		                         Client ID (4 octets)
+		                         Status (4 octets)
+
+	Opcode 0xa4 - Client Multi Advertising Enable notification
+
+		Notification parameters: Client ID (4 octets)
+		                         Status (4 octets)
+
+	Opcode 0xa5 - Client Multi Advertising Update notification
+
+		Notification parameters: Client ID (4 octets)
+		                         Status (4 octets)
+
+	Opcode 0xa6 - Client Multi Advertising Data notification
+
+		Notification parameters: Client ID (4 octets)
+		                         Status (4 octets)
+
+	Opcode 0xa7 - Client Multi Advertising Disable notification
+
+		Notification parameters: Client ID (4 octets)
+		                         Status (4 octets)
+
+	Opcode 0xa8 - Client Congestion notification
+
+		Notification parameters: Connection ID (4 octets)
+		                         Congested (1 octet)
+
+	Opcode 0xa9 - Client Configure Batchscan notification
+
+		Notification parameters: Client ID (4 octets)
+		                         Status (4 octets)
+
+	Opcode 0xaa - Client Enable Batchscan notification
+
+		Notification parameters: Action (4 octets)
+		                         Client ID (4 octets)
+		                         Status (4 octets)
+
+	Opcode 0xab - Client Batchscan Reports notification
+
+		Notification parameters: Client ID (4 octets)
+		                         Status (4 octets)
+		                         Report Format (4 octets)
+		                         Num Reports (4 octets)
+		                         Data Length (4 octets)
+		                         Data (variable)
+
+	Opcode 0xac - Client Batchscan Threshold notification
+
+		Notification parameters: Client ID (4 octets)
+
+	Opcode 0xad - Client Track ADV notification
+
+		Notification parameters: Client ID (4 octets)
+		                         Filter Index (4 octets)
+		                         Address Type (4 octets)
+		                         Address (6 octets)
+		                         State (4 octets)
+
+	Opcode 0xae - Server Indication Sent notification
+
+		Notification parameters: Connection ID (4 octets)
+		                         Status (4 octets)
+
+	Opcode 0xaf - Server Congestion notification
+
+		Notification parameters: Connection ID (4 octets)
+		                         Congested (1 octet)
+
 
 Bluetooth Handsfree Client HAL (ID 10)
 ======================================
-- 
1.9.1

