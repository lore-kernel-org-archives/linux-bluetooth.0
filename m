Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [PATCH 03/11] android/hal-msg: Add mdep role and channel type defines
Date: Tue, 22 Apr 2014 15:06:02 +0300
Message-Id: <1398168371-29685-4-git-send-email-ravikumar.veeramally@linux.intel.com>
In-Reply-To: <1398168371-29685-1-git-send-email-ravikumar.veeramally@linux.intel.com>
References: <1398168371-29685-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/hal-msg.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/android/hal-msg.h b/android/hal-msg.h
index ed0a67a..abcdf0e 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -383,6 +383,13 @@ struct hal_cmd_pan_disconnect {
 	uint8_t bdaddr[6];
 } __attribute__((packed));
 
+#define HAL_HEALTH_MDEP_ROLE_SOURCE	0x00
+#define HAL_HEALTH_MDEP_ROLE_SINK	0x01
+
+#define HAL_HEALTH_CHANNEL_TYPE_RELIABLE	0x00
+#define HAL_HEALTH_CHANNEL_TYPE_STREAMING	0x01
+#define HAL_HEALTH_CHANNEL_TYPE_ANY		0x02
+
 #define HAL_OP_HEALTH_REG_APP		0x01
 struct hal_cmd_health_reg_app {
 	uint8_t  num_of_mdep;
-- 
1.8.3.2

