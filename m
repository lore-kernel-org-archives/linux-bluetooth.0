Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [PATCH_v2 04/15] android/hal-msg: Add HDP destroy channel struct
Date: Thu, 13 Mar 2014 13:58:41 +0200
Message-Id: <1394711932-16560-5-git-send-email-ravikumar.veeramally@linux.intel.com>
In-Reply-To: <1394711932-16560-1-git-send-email-ravikumar.veeramally@linux.intel.com>
References: <1394711932-16560-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/hal-msg.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/android/hal-msg.h b/android/hal-msg.h
index 2db87ac..57069b3 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -419,6 +419,11 @@ struct hal_rsp_health_connect_channel {
 	uint16_t  channel_id;
 } __attribute__((packed));
 
+#define HAL_OP_HEALTH_DESTROY_CHANNEL	0x04
+struct hal_cmd_health_destroy_channel {
+	uint16_t channel_id;
+} __attribute__((packed));
+
 /* Handsfree HAL API */
 
 #define HAL_MODE_HANDSFREE_HSP_ONLY		0x01
-- 
1.8.3.2

