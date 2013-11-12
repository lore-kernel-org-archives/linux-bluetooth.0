Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [PATCH_v2 2/3] android/hidhost: Remove deprecated idle opcode from ipc document
Date: Tue, 12 Nov 2013 17:07:14 +0200
Message-Id: <1384268835-7570-2-git-send-email-ravikumar.veeramally@linux.intel.com>
In-Reply-To: <1384268835-7570-1-git-send-email-ravikumar.veeramally@linux.intel.com>
References: <1384268835-7570-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Idle time is deprecated in HID_SPEC1_1. So get and set idle time api's
are removed and not implemented. But callback is left out in Android
bt_hh.h. Generally this callback needs to be called when HAL requests
get and set idle time calls with status. So the method calls itself
removed, no point to implement this callback.
Also update GET_REPORT and VIRTUAL_UNPLUG opcode values.
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
index 4dfd555..847cc1f 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -499,7 +499,7 @@ struct hal_ev_hidhost_proto_mode {
 	uint8_t mode;
 } __attribute__((packed));
 
-#define HAL_EV_HIDHOST_GET_REPORT		0x85
+#define HAL_EV_HIDHOST_GET_REPORT		0x84
 struct hal_ev_hidhost_get_report {
 	uint8_t  bdaddr[6];
 	uint8_t  status;
@@ -507,7 +507,7 @@ struct hal_ev_hidhost_get_report {
 	uint8_t  data[0];
 } __attribute__((packed));
 
-#define HAL_EV_HIDHOST_VIRTUAL_UNPLUG		0x86
+#define HAL_EV_HIDHOST_VIRTUAL_UNPLUG		0x85
 struct hal_ev_hidhost_virtual_unplug {
 	uint8_t  bdaddr[6];
 	uint8_t  status;
-- 
1.8.3.2

