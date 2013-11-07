Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [PATCH_v2 08/11] android/hid: Add hid event virtual unplug structure to HAL msg headers
Date: Fri,  8 Nov 2013 00:10:17 +0200
Message-Id: <1383862220-29968-9-git-send-email-ravikumar.veeramally@linux.intel.com>
In-Reply-To: <1383862220-29968-1-git-send-email-ravikumar.veeramally@linux.intel.com>
References: <1383862220-29968-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/hal-msg.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/android/hal-msg.h b/android/hal-msg.h
index 3ad9af6..4c7d344 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -479,6 +479,12 @@ struct hal_ev_hidhost_get_report {
 	uint8_t  data[0];
 } __attribute__((packed));
 
+#define HAL_EV_HIDHOST_VIRTUAL_UNPLUG		0x86
+struct hal_ev_hidhost_virtual_unplug {
+	uint8_t  bdaddr[6];
+	uint8_t  status;
+} __attribute__((packed));
+
 #define HAL_EV_A2DP_CONNECTION_STATE	0x81
 struct hal_ev_a2dp_connection_state {
 	uint8_t state;
-- 
1.8.3.2

