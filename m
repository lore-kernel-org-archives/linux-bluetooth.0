Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [PATCH_v2 01/13] android/hid: Add hid event proto mode structure to hal msg headers
Date: Tue,  5 Nov 2013 13:38:03 +0200
Message-Id: <1383651495-12434-2-git-send-email-ravikumar.veeramally@linux.intel.com>
In-Reply-To: <1383651495-12434-1-git-send-email-ravikumar.veeramally@linux.intel.com>
References: <1383651495-12434-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/hal-msg.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/android/hal-msg.h b/android/hal-msg.h
index f381862..5faf852 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -442,6 +442,8 @@ struct hal_ev_hid_conn_state {
 	uint8_t state;
 } __attribute__((packed));
 
+#define HAL_HID_STATUS_OK		0x00
+
 #define HAL_EV_HID_INFO			0x82
 struct hal_ev_hid_info {
 	uint8_t bdaddr[6];
@@ -456,6 +458,13 @@ struct hal_ev_hid_info {
 	uint8_t descr[884];
 } __attribute__((packed));
 
+#define HAL_EV_HID_PROTO_MODE		0x83
+struct hal_ev_hid_proto_mode {
+	uint8_t bdaddr[6];
+	uint8_t status;
+	uint8_t mode;
+} __attribute__((packed));
+
 #define HAL_EV_AV_CONNECTION_STATE	0x81
 struct hal_ev_av_connection_state {
 	uint8_t state;
-- 
1.8.1.2

