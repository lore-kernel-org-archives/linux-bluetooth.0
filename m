Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [PATCH 05/15] android/hal-msg: Add HDP app registration state event struct
Date: Wed, 12 Mar 2014 17:10:48 +0200
Message-Id: <1394637058-586-6-git-send-email-ravikumar.veeramally@linux.intel.com>
In-Reply-To: <1394637058-586-1-git-send-email-ravikumar.veeramally@linux.intel.com>
References: <1394637058-586-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/hal-msg.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/android/hal-msg.h b/android/hal-msg.h
index f4e513b..694529f 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -996,6 +996,17 @@ struct hal_ev_pan_conn_state {
 	uint8_t  remote_role;
 } __attribute__((packed));
 
+#define HAL_HEALTH_APP_REG_SUCCESS		0x00
+#define HAL_HEALTH_APP_REG_FAILED		0x01
+#define HAL_HEALTH_APP_DEREG_SUCCESS		0x02
+#define HAL_HEALTH_APP_DEREG_FAILED		0x03
+
+#define HAL_EV_HEALTH_APP_REG_STATE		0x81
+struct hal_ev_health_app_reg_state {
+	uint16_t id;
+	uint8_t  state;
+} __attribute__((packed));
+
 #define HAL_A2DP_STATE_DISCONNECTED		0x00
 #define HAL_A2DP_STATE_CONNECTING		0x01
 #define HAL_A2DP_STATE_CONNECTED		0x02
-- 
1.8.3.2

