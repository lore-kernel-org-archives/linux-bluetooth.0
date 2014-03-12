Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [PATCH 01/15] android/hal-msg: Add HDP app registration struct
Date: Wed, 12 Mar 2014 17:10:44 +0200
Message-Id: <1394637058-586-2-git-send-email-ravikumar.veeramally@linux.intel.com>
In-Reply-To: <1394637058-586-1-git-send-email-ravikumar.veeramally@linux.intel.com>
References: <1394637058-586-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/hal-msg.h | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/android/hal-msg.h b/android/hal-msg.h
index 0abbbe6..b1942de 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -383,6 +383,27 @@ struct hal_cmd_pan_disconnect {
 	uint8_t bdaddr[6];
 } __attribute__((packed));
 
+#define HAL_OP_HEALTH_REG_APP		0x01
+struct hal_cmd_health_reg_app {
+	uint8_t app_name[255];
+	uint8_t provider_name[255];
+	uint8_t service_name[255];
+	uint8_t service_descr[200];
+	uint8_t num_of_mdep;
+
+	struct {
+		uint8_t role;
+		uint8_t data_type;
+		uint8_t channel_type;
+		uint8_t descr[255];
+	} mdep_cfg[20];
+} __attribute__((packed));
+
+struct hal_rsp_health_reg_app {
+	uint16_t app_id;
+} __attribute__((packed));
+
+
 /* Handsfree HAL API */
 
 #define HAL_MODE_HANDSFREE_HSP_ONLY		0x01
-- 
1.8.3.2

