Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [PATCH 04/11] android/health: Fix wrong boolean value for command handler
Date: Tue, 22 Apr 2014 15:06:03 +0300
Message-Id: <1398168371-29685-5-git-send-email-ravikumar.veeramally@linux.intel.com>
In-Reply-To: <1398168371-29685-1-git-send-email-ravikumar.veeramally@linux.intel.com>
References: <1398168371-29685-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

bt_health_register_app contains variable data.
---
 android/health.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/android/health.c b/android/health.c
index e4f8cbd..0cda91a 100644
--- a/android/health.c
+++ b/android/health.c
@@ -80,7 +80,7 @@ static void bt_health_destroy_channel(const void *buf, uint16_t len)
 
 static const struct ipc_handler cmd_handlers[] = {
 	/* HAL_OP_HEALTH_REG_APP */
-	{ bt_health_register_app, false,
+	{ bt_health_register_app, true,
 				sizeof(struct hal_cmd_health_reg_app) },
 	/* HAL_OP_HEALTH_UNREG_APP */
 	{ bt_health_unregister_app, false,
-- 
1.8.3.2

