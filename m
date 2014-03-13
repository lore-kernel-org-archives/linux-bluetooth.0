Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [PATCH_v2 06/15] android/hal-msg: Add HDP app channel state event struct
Date: Thu, 13 Mar 2014 13:58:43 +0200
Message-Id: <1394711932-16560-7-git-send-email-ravikumar.veeramally@linux.intel.com>
In-Reply-To: <1394711932-16560-1-git-send-email-ravikumar.veeramally@linux.intel.com>
References: <1394711932-16560-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/hal-msg.h | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/android/hal-msg.h b/android/hal-msg.h
index 3f119de..0b8924e 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -1001,12 +1001,28 @@ struct hal_ev_pan_conn_state {
 #define HAL_HEALTH_APP_DEREG_SUCCESS		0x02
 #define HAL_HEALTH_APP_DEREG_FAILED		0x03
 
+#define HAL_HEALTH_CHANNEL_CONNECTING		0x00
+#define HAL_HEALTH_CHANNEL_CONNECTED		0x01
+#define HAL_HEALTH_CHANNEL_DISCONNECTING	0x02
+#define HAL_HEALTH_CHANNEL_DISCONNECTED		0x03
+#define HAL_HEALTH_CHANNEL_DESTROYED		0x04
+
 #define HAL_EV_HEALTH_APP_REG_STATE		0x81
 struct hal_ev_health_app_reg_state {
 	uint16_t id;
 	uint8_t  state;
 } __attribute__((packed));
 
+#define HAL_EV_HEALTH_CHANNEL_STATE		0x82
+struct hal_ev_health_channel_state {
+	uint16_t app_id;
+	uint8_t  bdaddr[6];
+	uint8_t  mdep_index;
+	uint16_t channel_id;
+	uint8_t  channel_state;
+	uint32_t file_descr;
+} __attribute__((packed));
+
 #define HAL_A2DP_STATE_DISCONNECTED		0x00
 #define HAL_A2DP_STATE_CONNECTING		0x01
 #define HAL_A2DP_STATE_CONNECTED		0x02
-- 
1.8.3.2

