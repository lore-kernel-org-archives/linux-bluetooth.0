Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [PATCH 2/6] android/hid: Add missing parameters in send data struct in HAL headers
Date: Wed,  6 Nov 2013 13:48:44 +0200
Message-Id: <1383738528-14550-3-git-send-email-ravikumar.veeramally@linux.intel.com>
In-Reply-To: <1383738528-14550-1-git-send-email-ravikumar.veeramally@linux.intel.com>
References: <1383738528-14550-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/hal-msg.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/android/hal-msg.h b/android/hal-msg.h
index f0cc800..eb145a5 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -298,7 +298,9 @@ struct hal_cmd_hid_set_report {
 
 #define HAL_OP_HID_SEND_DATA		0x09
 struct hal_cmd_hid_send_data {
-	uint8_t bdaddr[6];
+	uint8_t  bdaddr[6];
+	uint16_t len;
+	uint8_t  data[670];
 } __attribute__((packed));
 
 #define HAL_OP_AV_CONNECT	0x01
-- 
1.8.1.2

