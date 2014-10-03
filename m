Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 1/6] android/hal-ipc-api: Add MAP client HAL
Date: Fri,  3 Oct 2014 16:03:59 +0200
Message-Id: <1412345044-30259-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/hal-ipc-api.txt | 42 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/android/hal-ipc-api.txt b/android/hal-ipc-api.txt
index 739fdbf..1a617c0 100644
--- a/android/hal-ipc-api.txt
+++ b/android/hal-ipc-api.txt
@@ -2446,3 +2446,45 @@ Notifications:
 	Opcode 0x95 - Ring Indication notification
 
 		Notification parameters: <none>
+
+
+Bluetooth Map Client HAL (ID 11)
+=========================
+
+Android HAL name: "map_client" (BT_PROFILE_MAP_CLIENT_ID)
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
+		                         Number of instances (4 octet)
+		                         Instance ID # (4 octet)
+		                         Channel # (4 octet)
+		                         Message type (4 octet)
+		                         Name # (string)
-- 
1.9.3

