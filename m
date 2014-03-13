Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [PATCH_v2 02/15] android/hal-msg: Add HDP app unregistration struct
Date: Thu, 13 Mar 2014 13:58:39 +0200
Message-Id: <1394711932-16560-3-git-send-email-ravikumar.veeramally@linux.intel.com>
In-Reply-To: <1394711932-16560-1-git-send-email-ravikumar.veeramally@linux.intel.com>
References: <1394711932-16560-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/hal-msg.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/android/hal-msg.h b/android/hal-msg.h
index 0c63216..77c2757 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -1071,6 +1071,10 @@ struct hal_ev_handsfree_chld {
 	uint8_t chld;
 } __attribute__((packed));
 
+#define HAL_OP_HEALTH_UNREG_APP		0x02
+struct hal_cmd_health_unreg_app {
+	uint16_t app_id;
+} __attribute__((packed));
 
 #define HAL_EV_HANDSFREE_CNUM		0x8B
 
-- 
1.8.3.2

