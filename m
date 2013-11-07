Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [PATCH_v2 05/11] android/hid: Add missing parameters in send data struct in HAL headers
Date: Fri,  8 Nov 2013 00:10:14 +0200
Message-Id: <1383862220-29968-6-git-send-email-ravikumar.veeramally@linux.intel.com>
In-Reply-To: <1383862220-29968-1-git-send-email-ravikumar.veeramally@linux.intel.com>
References: <1383862220-29968-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/hal-msg.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/android/hal-msg.h b/android/hal-msg.h
index 08a159e..05c9de0 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -298,7 +298,9 @@ struct hal_cmd_hidhost_set_report {
 
 #define HAL_OP_HIDHOST_SEND_DATA		0x09
 struct hal_cmd_hidhost_send_data {
-	uint8_t bdaddr[6];
+	uint8_t  bdaddr[6];
+	uint16_t len;
+	uint8_t  data[0];
 } __attribute__((packed));
 
 /* a2dp HAL API */
-- 
1.8.3.2

