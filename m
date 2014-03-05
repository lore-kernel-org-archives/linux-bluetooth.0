Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCH 3/4] android/hal-ipc-api: Add missing sections in doc
Date: Wed,  5 Mar 2014 15:43:58 +0100
Message-Id: <1394030639-28134-3-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1394030639-28134-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1394030639-28134-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/hal-ipc-api.txt | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/android/hal-ipc-api.txt b/android/hal-ipc-api.txt
index 05bb4db..cd6bc92 100644
--- a/android/hal-ipc-api.txt
+++ b/android/hal-ipc-api.txt
@@ -758,6 +758,8 @@ Android HAL name: "handsfree" (BT_PROFILE_HANDSFREE_ID)
 
 	Service modes:               0x01 = Headset Profile only mode
 
+Commands and responses:
+
 	Opcode 0x00 - Error response
 
 		Response parameters: Status (1 octet)
@@ -1102,6 +1104,8 @@ Bluetooth Health HAL (ID 7)
 
 Android HAL name: "health" (BT_PROFILE_HEALTH_ID)
 
+Commands and responses:
+
 	Opcode 0x00 - Error response
 
 		Response parameters: Status (1 octet)
@@ -1189,6 +1193,8 @@ Bluetooth Remote Control HAL (ID 8)
 
 Android HAL name: "avrcp" (BT_PROFILE_AV_RC_ID)
 
+Commands and responses:
+
 	Opcode 0x00 - Error response
 
 		Response parameters: Status (1 octet)
@@ -1324,6 +1330,8 @@ Android HAL name: "avrcp" (BT_PROFILE_AV_RC_ID)
 
 		In case of an error, the error response will be returned.
 
+Notifications:
+
 	Opcode 0x81 - Remote Features notification
 
 		Notification parameters: Remote address (6 octets)
@@ -1415,6 +1423,8 @@ Bluetooth GATT HAL (ID 9)
 
 Android HAL name: "gatt" (BT_PROFILE_GATT_ID)
 
+Commands and responses:
+
 	Opcode 0x00 - Error response
 
 		Response parameters: Status (1 octet)
@@ -1855,6 +1865,8 @@ Android HAL name: "gatt" (BT_PROFILE_GATT_ID)
 
 		In case of an error, the error response will be returned.
 
+Notifications:
+
 	Opcode 0x81 - Register Client notification
 
 		Notification parameters: Status (4 octets)
-- 
1.9.0

