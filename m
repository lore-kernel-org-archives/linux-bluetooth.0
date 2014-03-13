Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [PATCH_v2 09/15] android/hal-health: Add HDP .cleanup method
Date: Thu, 13 Mar 2014 13:58:46 +0200
Message-Id: <1394711932-16560-10-git-send-email-ravikumar.veeramally@linux.intel.com>
In-Reply-To: <1394711932-16560-1-git-send-email-ravikumar.veeramally@linux.intel.com>
References: <1394711932-16560-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/hal-health.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/android/hal-health.c b/android/hal-health.c
index d099ae2..918fb69 100644
--- a/android/hal-health.c
+++ b/android/hal-health.c
@@ -67,6 +67,25 @@ static bt_status_t init(bthl_callbacks_t *callbacks)
 	return ret;
 }
 
+static void cleanup(void)
+{
+	struct hal_cmd_unregister_module cmd;
+
+	DBG("");
+
+	if (!interface_ready())
+		return;
+
+	cbacks = NULL;
+
+	cmd.service_id = HAL_SERVICE_ID_HEALTH;
+
+	hal_ipc_cmd(HAL_SERVICE_ID_CORE, HAL_OP_UNREGISTER_MODULE,
+					sizeof(cmd), &cmd, 0, NULL, NULL);
+
+	hal_ipc_unregister(HAL_SERVICE_ID_HEALTH);
+}
+
 static bthl_interface_t health_if = {
 	.size = sizeof(health_if),
 	.init = init,
@@ -74,7 +93,7 @@ static bthl_interface_t health_if = {
 	.unregister_application = NULL,
 	.connect_channel = NULL,
 	.destroy_channel = NULL,
-	.cleanup = NULL
+	.cleanup = cleanup
 };
 
 bthl_interface_t *bt_get_health_interface(void)
-- 
1.8.3.2

