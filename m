Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [PATCH_v4 12/12] android/hid: Align hal hid struct variables properly
Date: Tue,  5 Nov 2013 23:09:18 +0200
Message-Id: <1383685758-3900-13-git-send-email-ravikumar.veeramally@linux.intel.com>
In-Reply-To: <1383685758-3900-1-git-send-email-ravikumar.veeramally@linux.intel.com>
References: <1383685758-3900-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/hal-msg.h | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/android/hal-msg.h b/android/hal-msg.h
index 2c3067f..41ba649 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -282,9 +282,9 @@ struct hal_cmd_hid_set_protocol {
 
 #define HAL_OP_HID_GET_REPORT		0x07
 struct hal_cmd_hid_get_report {
-	uint8_t bdaddr[6];
-	uint8_t type;
-	uint8_t id;
+	uint8_t  bdaddr[6];
+	uint8_t  type;
+	uint8_t  id;
 	uint16_t buf;
 } __attribute__((packed));
 
@@ -448,16 +448,16 @@ struct hal_ev_hid_conn_state {
 
 #define HAL_EV_HID_INFO			0x82
 struct hal_ev_hid_info {
-	uint8_t bdaddr[6];
-	uint8_t attr;
-	uint8_t subclass;
-	uint8_t app_id;
+	uint8_t  bdaddr[6];
+	uint8_t  attr;
+	uint8_t  subclass;
+	uint8_t  app_id;
 	uint16_t vendor;
 	uint16_t product;
 	uint16_t version;
-	uint8_t country;
+	uint8_t  country;
 	uint16_t descr_len;
-	uint8_t descr[884];
+	uint8_t  descr[884];
 } __attribute__((packed));
 
 #define HAL_EV_HID_PROTO_MODE		0x83
-- 
1.8.1.2

