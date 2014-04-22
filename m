Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [PATCH 05/11] android/health: Add initial function for HAL_OP_HEALTH_MDEP command
Date: Tue, 22 Apr 2014 15:06:04 +0300
Message-Id: <1398168371-29685-6-git-send-email-ravikumar.veeramally@linux.intel.com>
In-Reply-To: <1398168371-29685-1-git-send-email-ravikumar.veeramally@linux.intel.com>
References: <1398168371-29685-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/health.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/android/health.c b/android/health.c
index 0cda91a..655d9f9 100644
--- a/android/health.c
+++ b/android/health.c
@@ -54,6 +54,14 @@ static void bt_health_register_app(const void *buf, uint16_t len)
 							HAL_STATUS_UNSUPPORTED);
 }
 
+static void bt_health_mdep_cfg_data(const void *buf, uint16_t len)
+{
+	DBG("Not implemented");
+
+	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_HEALTH, HAL_OP_HEALTH_MDEP,
+							HAL_STATUS_UNSUPPORTED);
+}
+
 static void bt_health_unregister_app(const void *buf, uint16_t len)
 {
 	DBG("Not implemented");
@@ -82,6 +90,9 @@ static const struct ipc_handler cmd_handlers[] = {
 	/* HAL_OP_HEALTH_REG_APP */
 	{ bt_health_register_app, true,
 				sizeof(struct hal_cmd_health_reg_app) },
+	/* HAL_OP_HEALTH_MDEP */
+	{ bt_health_mdep_cfg_data, true,
+				sizeof(struct hal_cmd_health_mdep) },
 	/* HAL_OP_HEALTH_UNREG_APP */
 	{ bt_health_unregister_app, false,
 				sizeof(struct hal_cmd_health_unreg_app) },
-- 
1.8.3.2

