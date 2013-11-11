Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [PATCH 2/3] android/hidhost: Remove deprecated idle opcode from ipc document
Date: Mon, 11 Nov 2013 14:15:29 +0200
Message-Id: <1384172130-29837-2-git-send-email-ravikumar.veeramally@linux.intel.com>
In-Reply-To: <1384172130-29837-1-git-send-email-ravikumar.veeramally@linux.intel.com>
References: <1384172130-29837-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Idle time is deprecated in HID 1_1. So remove it from ipc document
and update GET_REPORT and VIRTUAL_UNPLUG opcode values.
---
 android/hal-ipc-api.txt | 10 ++--------
 android/hal-msg.h       |  4 ++--
 2 files changed, 4 insertions(+), 10 deletions(-)

diff --git a/android/hal-ipc-api.txt b/android/hal-ipc-api.txt
index 91ea280..57f4c13 100644
--- a/android/hal-ipc-api.txt
+++ b/android/hal-ipc-api.txt
@@ -614,20 +614,14 @@ Notifications:
 		                      0x01 = Boot
 		                      0xff = Unsupported
 
-	Opcode 0x84 - Idle Time notification
-
-		Notification parameters: Remote address (6 octets)
-		                         Status (1 octet)
-		                         Idle time (2 octets)
-
-	Opcode 0x85 - Get Report notification
+	Opcode 0x84 - Get Report notification
 
 		Notification parameters: Remote address (6 octets)
 		                         Status (1 octet)
 		                         Report length (2 octets)
 		                         Report data (variable)
 
-	Opcode 0x86 - Virtual Unplug notification
+	Opcode 0x85 - Virtual Unplug notification
 
 		Notification parameters: Remote address (6 octets)
 		                         Status (1 octet)
diff --git a/android/hal-msg.h b/android/hal-msg.h
index 569c8ea..1d20afd 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -472,7 +472,7 @@ struct hal_ev_hidhost_proto_mode {
 	uint8_t mode;
 } __attribute__((packed));
 
-#define HAL_EV_HIDHOST_GET_REPORT		0x85
+#define HAL_EV_HIDHOST_GET_REPORT		0x84
 struct hal_ev_hidhost_get_report {
 	uint8_t  bdaddr[6];
 	uint8_t  status;
@@ -480,7 +480,7 @@ struct hal_ev_hidhost_get_report {
 	uint8_t  data[0];
 } __attribute__((packed));
 
-#define HAL_EV_HIDHOST_VIRTUAL_UNPLUG		0x86
+#define HAL_EV_HIDHOST_VIRTUAL_UNPLUG		0x85
 struct hal_ev_hidhost_virtual_unplug {
 	uint8_t  bdaddr[6];
 	uint8_t  status;
-- 
1.8.3.2

