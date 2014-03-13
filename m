Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [PATCH_v2 01/15] android/hal-msg: Add HDP app registration struct
Date: Thu, 13 Mar 2014 13:58:38 +0200
Message-Id: <1394711932-16560-2-git-send-email-ravikumar.veeramally@linux.intel.com>
In-Reply-To: <1394711932-16560-1-git-send-email-ravikumar.veeramally@linux.intel.com>
References: <1394711932-16560-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/hal-msg.h | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/android/hal-msg.h b/android/hal-msg.h
index 0abbbe6..0c63216 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -383,6 +383,31 @@ struct hal_cmd_pan_disconnect {
 	uint8_t bdaddr[6];
 } __attribute__((packed));
 
+struct hal_string {
+	uint8_t len;
+	uint8_t data[0];
+};
+
+#define HAL_OP_HEALTH_REG_APP		0x01
+struct hal_cmd_health_reg_app {
+	struct hal_string app_name;
+	struct hal_string provider_name;
+	struct hal_string service_name;
+	struct hal_string service_descr;
+	uint8_t num_of_mdep;
+
+	struct {
+		uint8_t role;
+		uint8_t data_type;
+		uint8_t channel_type;
+		struct  hal_string descr;
+	} mdep_cfg[0];
+} __attribute__((packed));
+
+struct hal_rsp_health_reg_app {
+	uint16_t app_id;
+} __attribute__((packed));
+
 /* Handsfree HAL API */
 
 #define HAL_MODE_HANDSFREE_HSP_ONLY		0x01
-- 
1.8.3.2

