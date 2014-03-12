Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [PATCH 02/15] android/hal-msg: Add HDP app unregistration struct
Date: Wed, 12 Mar 2014 17:10:45 +0200
Message-Id: <1394637058-586-3-git-send-email-ravikumar.veeramally@linux.intel.com>
In-Reply-To: <1394637058-586-1-git-send-email-ravikumar.veeramally@linux.intel.com>
References: <1394637058-586-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/hal-msg.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/android/hal-msg.h b/android/hal-msg.h
index b1942de..cf2d353 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -403,6 +403,10 @@ struct hal_rsp_health_reg_app {
 	uint16_t app_id;
 } __attribute__((packed));
 
+#define HAL_OP_HEALTH_UNREG_APP		0x02
+struct hal_cmd_health_unreg_app {
+	uint16_t app_id;
+} __attribute__((packed));
 
 /* Handsfree HAL API */
 
-- 
1.8.3.2

