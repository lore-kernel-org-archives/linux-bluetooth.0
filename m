Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [PATCH 03/15] android/hal-msg: Add HDP connect channel struct
Date: Wed, 12 Mar 2014 17:10:46 +0200
Message-Id: <1394637058-586-4-git-send-email-ravikumar.veeramally@linux.intel.com>
In-Reply-To: <1394637058-586-1-git-send-email-ravikumar.veeramally@linux.intel.com>
References: <1394637058-586-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/hal-msg.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/android/hal-msg.h b/android/hal-msg.h
index cf2d353..4be4ae2 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -408,6 +408,17 @@ struct hal_cmd_health_unreg_app {
 	uint16_t app_id;
 } __attribute__((packed));
 
+#define HAL_OP_HEALTH_CONNECT_CHANNEL	0x03
+struct hal_cmd_health_connect_channel {
+	uint16_t app_id;
+	uint8_t  bdaddr[6];
+	uint8_t  mdep_index;
+} __attribute__((packed));
+
+struct hal_rsp_health_connect_channel {
+	uint16_t  channel_id;
+} __attribute__((packed));
+
 /* Handsfree HAL API */
 
 #define HAL_MODE_HANDSFREE_HSP_ONLY		0x01
-- 
1.8.3.2

