Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [PATCH 5/6] android/hid: Add hid event virtual unplug structure to HAL msg headers
Date: Wed,  6 Nov 2013 13:48:47 +0200
Message-Id: <1383738528-14550-6-git-send-email-ravikumar.veeramally@linux.intel.com>
In-Reply-To: <1383738528-14550-1-git-send-email-ravikumar.veeramally@linux.intel.com>
References: <1383738528-14550-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/hal-msg.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/android/hal-msg.h b/android/hal-msg.h
index 59e4f78..740f2ab 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -477,6 +477,12 @@ struct hal_ev_hid_get_report {
 	uint8_t  data[0];
 } __attribute__((packed));
 
+#define HAL_EV_HID_VIRTUAL_UNPLUG	0x86
+struct hal_ev_hid_virtual_unplug {
+	uint8_t  bdaddr[6];
+	uint8_t  status;
+} __attribute__((packed));
+
 #define HAL_EV_AV_CONNECTION_STATE	0x81
 struct hal_ev_av_connection_state {
 	uint8_t state;
-- 
1.8.1.2

