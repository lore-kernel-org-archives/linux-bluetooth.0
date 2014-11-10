Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [PATCH_v2 1/5] android/hal-ipc-txt: Add support for new AVRCP CTRL interface
Date: Mon, 10 Nov 2014 16:05:05 +0200
Message-Id: <1415628309-7384-2-git-send-email-ravikumar.veeramally@linux.intel.com>
In-Reply-To: <1415628309-7384-1-git-send-email-ravikumar.veeramally@linux.intel.com>
References: <1415628309-7384-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/hal-ipc-api.txt | 45 +++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 43 insertions(+), 2 deletions(-)

diff --git a/android/hal-ipc-api.txt b/android/hal-ipc-api.txt
index 666e27f..4f202c8 100644
--- a/android/hal-ipc-api.txt
+++ b/android/hal-ipc-api.txt
@@ -1241,7 +1241,7 @@ Notifications:
 		                      0x04 = Destroyed
 
 
-Bluetooth Remote Control HAL (ID 8)
+Bluetooth Remote Control Target HAL (ID 8)
 ===================================
 
 Android HAL name: "avrcp" (BT_PROFILE_AV_RC_ID)
@@ -1470,7 +1470,6 @@ Notifications:
 		Notification parameters: ID (1 octet)
 		                         State (1 octet)
 
-
 Bluetooth GATT HAL (ID 9)
 =========================
 
@@ -2505,3 +2504,45 @@ Notifications:
 		                         Channel # (4 octets)
 		                         Message types (4 octets)
 		                         Name # (string)
+
+Bluetooth Remote Control Controller HAL (ID 12)
+===================================
+
+Android HAL name: "avrcp-ctrl" (BT_PROFILE_AV_RC_CTRL_ID)
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
+	Opcode 0x01 - Send Pass Through command/response
+
+		Command parameters: Remote Address (6 octets)
+		                    Key Code (1 octet)
+		                    Key State (1 octet)
+
+		In case of an error, the error response will be returned.
+
+Notifications:
+
+	Opcode 0x81 - Passthrough Response Notification
+
+		Notification parameters: ID (1 octet)
+		                         Key State (1 octet)
+
+	Opcode 0x82 - Connection State Notification
+
+		Notification parameters: State (1 octet)
+		                         Remote Address (6 octets)
-- 
2.1.0

