Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/6] android/hal-ipc-api: Add MCE HAL
Date: Mon, 22 Sep 2014 13:01:43 +0200
Message-Id: <1411383708-28621-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/hal-ipc-api.txt | 51 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/android/hal-ipc-api.txt b/android/hal-ipc-api.txt
index f6e1680..38f75e6 100644
--- a/android/hal-ipc-api.txt
+++ b/android/hal-ipc-api.txt
@@ -2396,3 +2396,54 @@ Notifications:
 	Opcode 0x95 - Ring Indication notification
 
 		Notification parameters: <none>
+
+
+Bluetooth MCE HAL (ID 11)
+=========================
+
+Android HAL name: "map_client" (BT_PROFILE_MAP_CLIENT_ID)
+
+Structures:
+
+	MAS instance: Instance ID (1 octet)
+	              Channel (1 octet)
+	              Message type (1 octet)
+	              Name (string)
+
+	Valid Message type: 0x01 = EMAIL
+	                    0x02 = SMS_GSM
+	                    0x04 = SMS_CDMA
+	                    0x08 = MMS
+
+Commands and responses:
+
+	Opcode 0x00 - Error response
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
+	Opcode 0x01 - Get Remote MAS Instances
+
+		Command parameters: Remote address (6 octets)
+		Response parameters: <none>
+
+		In case of an error, the error response will be returned.
+
+Notifications:
+
+	Opcode 0x81 - Remote MAS Instances notification
+
+		Notification parameters: Status (1 octet)
+		                         Remote address (6 octets)
+		                         Number of instances (1 octet)
+		                         MAS instance (variable)
-- 
1.9.3

