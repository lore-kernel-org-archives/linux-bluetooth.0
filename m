Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [PATCH_v2] android: Add hidhost defines and structures to header file
Date: Tue, 22 Oct 2013 02:07:02 -0700
Message-Id: <1382432822-22888-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

	v2: Changed 2 byte arrays to uint16_t as per Luiz comments
---
 android/hal-msg.h |   67 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 67 insertions(+)

diff --git a/android/hal-msg.h b/android/hal-msg.h
index 6266903..9dcfbf6 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -179,6 +179,73 @@ struct hal_msg_cmd_bt_le_test_mode {
 	uint8_t  data[0];
 } __attribute__((packed));
 
+#define HAL_MSG_OP_BT_HID_CONNECT	0x01
+struct hal_msg_cmd_bt_hid_connect {
+	uint8_t bdaddr[6];
+} __attribute__((packed));
+
+#define HAL_MSG_OP_BT_HID_DISCONNECT	0x02
+struct hal_msg_cmd_bt_hid_disconnect {
+	uint8_t bdaddr[6];
+} __attribute__((packed));
+
+#define HAL_MSG_OP_BT_HID_VP		0x03
+struct hal_msg_cmd_bt_hid_vp {
+	uint8_t bdaddr[6];
+} __attribute__((packed));
+
+#define HAL_MSG_OP_BT_HID_SET_INFO	0x04
+struct hal_msg_cmd_bt_hid_set_info {
+	uint8_t bdaddr[6];
+	uint8_t attr;
+	uint8_t subclass;
+	uint8_t app_id;
+	uint16_t vendor;
+	uint16_t product;
+	uint16_t country;
+	uint16_t descr_len;
+	uint8_t descr[0];
+} __attribute__((packed));
+
+#define HAL_MSG_BT_HID_REPORT_PROTOCOL		0x00
+#define HAL_MSG_BT_HID_BOOT_PROTOCOL		0x01
+#define HAL_MSG_BT_HID_UNSUPPORTED_PROTOCOL	0xff
+
+#define HAL_MSG_OP_BT_HID_GET_PROTOCOL	0x05
+struct hal_msg_cmd_bt_hid_get_protocol {
+	uint8_t bdaddr[6];
+	uint8_t mode;
+} __attribute__((packed));
+
+#define HAL_MSG_OP_BT_HID_SET_PROTOCOL	0x06
+struct hal_msg_cmd_bt_hid_set_protocol {
+	uint8_t bdaddr[6];
+	uint8_t mode;
+} __attribute__((packed));
+
+#define HAL_MSG_BT_HID_INPUT_REPORT	0x01
+#define HAL_MSG_BT_HID_OUTPUT_REPORT	0x02
+#define HAL_MSG_BT_HID_FEATURE_REPORT	0x03
+
+#define HAL_MSG_OP_BT_HID_GET_REPORT	0x07
+struct hal_msg_cmd_bt_hid_get_report {
+	uint8_t bdaddr[6];
+	uint8_t type;
+	uint8_t id;
+	uint16_t buf;
+} __attribute__((packed));
+
+#define HAL_MSG_OP_BT_HID_SET_REPORT	0x08
+struct hal_msg_cmd_bt_hid_set_report {
+	uint8_t bdaddr[6];
+	uint8_t type;
+} __attribute__((packed));
+
+#define HAL_MSG_OP_BT_HID_SEND_DATA	0x09
+struct hal_msg_cmd_bt_hid_send_data {
+	uint8_t bdaddr[6];
+} __attribute__((packed));
+
 /* Notifications and confirmations */
 
 #define HAL_MSG_EV_BT_ERROR			0x80
-- 
1.7.9.5

