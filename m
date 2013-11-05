Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [PATCH_v4 04/12] android/hid: Add hid event get report structure to HAL msg headers
Date: Tue,  5 Nov 2013 23:09:10 +0200
Message-Id: <1383685758-3900-5-git-send-email-ravikumar.veeramally@linux.intel.com>
In-Reply-To: <1383685758-3900-1-git-send-email-ravikumar.veeramally@linux.intel.com>
References: <1383685758-3900-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/hal-msg.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/android/hal-msg.h b/android/hal-msg.h
index 5faf852..bc7df6b 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -465,6 +465,14 @@ struct hal_ev_hid_proto_mode {
 	uint8_t mode;
 } __attribute__((packed));
 
+#define HAL_EV_HID_GET_REPORT		0x85
+struct hal_ev_hid_get_report {
+	uint8_t  bdaddr[6];
+	uint8_t  status;
+	uint16_t len;
+	uint8_t  data[0];
+} __attribute__((packed));
+
 #define HAL_EV_AV_CONNECTION_STATE	0x81
 struct hal_ev_av_connection_state {
 	uint8_t state;
-- 
1.8.1.2

