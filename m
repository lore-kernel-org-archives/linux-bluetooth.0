Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [PATCH 11/15] android/hal-health: Add HDP .unregister_application method
Date: Wed, 12 Mar 2014 17:10:54 +0200
Message-Id: <1394637058-586-12-git-send-email-ravikumar.veeramally@linux.intel.com>
In-Reply-To: <1394637058-586-1-git-send-email-ravikumar.veeramally@linux.intel.com>
References: <1394637058-586-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/hal-health.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/android/hal-health.c b/android/hal-health.c
index 8a610a2..007a37a 100644
--- a/android/hal-health.c
+++ b/android/hal-health.c
@@ -91,6 +91,21 @@ static bt_status_t register_application(bthl_reg_param_t *reg, int *app_id)
 	return status;
 }
 
+static bt_status_t unregister_application(int app_id)
+{
+	struct hal_cmd_health_unreg_app cmd;
+
+	DBG("");
+
+	if (!interface_ready())
+		return BT_STATUS_NOT_READY;
+
+	cmd.app_id = app_id;
+
+	return hal_ipc_cmd(HAL_SERVICE_ID_HEALTH, HAL_OP_HEALTH_UNREG_APP,
+					sizeof(cmd), &cmd, 0, NULL, NULL);
+}
+
 static bt_status_t init(bthl_callbacks_t *callbacks)
 {
 	struct hal_cmd_register_module cmd;
@@ -143,7 +158,7 @@ static bthl_interface_t health_if = {
 	.size = sizeof(health_if),
 	.init = init,
 	.register_application = register_application,
-	.unregister_application = NULL,
+	.unregister_application = unregister_application,
 	.connect_channel = NULL,
 	.destroy_channel = NULL,
 	.cleanup = cleanup
-- 
1.8.3.2

