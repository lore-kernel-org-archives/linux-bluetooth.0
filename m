Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [PATCH 1/4] android/pan: Add PAN related defines and event struct to hsl-msg header
Date: Mon, 11 Nov 2013 16:53:38 +0200
Message-Id: <1384181621-8070-2-git-send-email-ravikumar.veeramally@linux.intel.com>
In-Reply-To: <1384181621-8070-1-git-send-email-ravikumar.veeramally@linux.intel.com>
References: <1384181621-8070-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/hal-msg.h | 44 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/android/hal-msg.h b/android/hal-msg.h
index 569c8ea..00d6e39 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -317,6 +317,33 @@ struct hal_cmd_a2dp_disconnect {
 
 /* PAN HAL API */
 
+/* PAN Roles */
+#define HAL_PAN_ROLE_NONE	0x00
+#define HAL_PAN_ROLE_NAP	0x01
+#define HAL_PAN_ROLE_PANU	0x02
+
+/* PAN Control states */
+#define HAL_PAN_CTRL_ENABLED	0x00
+#define HAL_PAN_CTRL_DISABLED	0x01
+
+/* PAN Connection states */
+#define HAL_PAN_STATE_CONNECTED		0x00
+#define HAL_PAN_STATE_CONNECTING	0x01
+#define HAL_PAN_STATE_DISCONNECTED	0x02
+#define HAL_PAN_STATE_DISCONNECTING	0x03
+
+/* PAN status values */
+#define HAL_PAN_STATUS_FAIL		0x01
+#define HAL_PAN_STATUS_NOT_READY	0x02
+#define HAL_PAN_STATUS_NO_MEMORY	0x03
+#define HAL_PAN_STATUS_BUSY		0x04
+#define HAL_PAN_STATUS_DONE		0x05
+#define HAL_PAN_STATUS_UNSUPORTED	0x06
+#define HAL_PAN_STATUS_INVAL		0x07
+#define HAL_PAN_STATUS_UNHANDLED	0x08
+#define HAL_PAN_STATUS_AUTH_FAILED	0x09
+#define HAL_PAN_STATUS_DEVICE_DOWN	0x0A
+
 #define HAL_OP_PAN_ENABLE	0x01
 struct hal_cmd_pan_enable {
 	uint8_t local_role;
@@ -486,6 +513,23 @@ struct hal_ev_hidhost_virtual_unplug {
 	uint8_t  status;
 } __attribute__((packed));
 
+#define HAL_EV_PAN_CONN_STATE			0x81
+struct hal_ev_pan_conn_state {
+	uint8_t  state;
+	uint8_t  status;
+	uint8_t  bdaddr[6];
+	uint8_t  local_role;
+	uint8_t  remote_role;
+} __attribute__((packed));
+
+#define HAL_EV_PAN_CTRL_STATE			0x82
+struct hal_ev_pan_ctrl_state {
+	uint8_t  state;
+	uint8_t  status;
+	uint8_t  local_role;
+	uint8_t  name[17];
+} __attribute__((packed));
+
 #define HAL_EV_A2DP_CONNECTION_STATE	0x81
 struct hal_ev_a2dp_connection_state {
 	uint8_t state;
-- 
1.8.3.2

