Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [PATCH 06/15] android/hal-msg: Add HDP app channel state event struct
Date: Wed, 12 Mar 2014 17:10:49 +0200
Message-Id: <1394637058-586-7-git-send-email-ravikumar.veeramally@linux.intel.com>
In-Reply-To: <1394637058-586-1-git-send-email-ravikumar.veeramally@linux.intel.com>
References: <1394637058-586-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/hal-msg.h | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/android/hal-msg.h b/android/hal-msg.h
index 694529f..0139543 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -1001,12 +1001,28 @@ struct hal_ev_pan_conn_state {
 #define HAL_HEALTH_APP_DEREG_SUCCESS		0x02
 #define HAL_HEALTH_APP_DEREG_FAILED		0x03
 
+#define HAL_HEALTH_CHANL_STATE_CONNECTING	0x00
+#define HAL_HEALTH_CHANL_STATE_CONNECTED	0x01
+#define HAL_HEALTH_CHANL_STATE_DISCONNECTING	0x02
+#define HAL_HEALTH_CHANL_STATE_DISCONNECTED	0x03
+#define HAL_HEALTH_CHANL_STATE_DESTROYED	0x04
+
 #define HAL_EV_HEALTH_APP_REG_STATE		0x81
 struct hal_ev_health_app_reg_state {
 	uint16_t id;
 	uint8_t  state;
 } __attribute__((packed));
 
+#define HAL_EV_HEALTH_CHNL_STATE		0x82
+struct hal_ev_health_chnl_state {
+	uint16_t app_id;
+	uint8_t  bdaddr[6];
+	uint8_t  mdep_index;
+	uint16_t chnl_id;
+	uint8_t  chnl_state;
+	uint32_t file_descr;
+} __attribute__((packed));
+
 #define HAL_A2DP_STATE_DISCONNECTED		0x00
 #define HAL_A2DP_STATE_CONNECTING		0x01
 #define HAL_A2DP_STATE_CONNECTED		0x02
-- 
1.8.3.2

