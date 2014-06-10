Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [RFC_v2 4/6] android/health: Perform clean up on app unregister call
Date: Tue, 10 Jun 2014 16:22:01 +0300
Message-Id: <1402406523-2832-5-git-send-email-ravikumar.veeramally@linux.intel.com>
In-Reply-To: <1402406523-2832-1-git-send-email-ravikumar.veeramally@linux.intel.com>
References: <1402406523-2832-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/health.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/android/health.c b/android/health.c
index 5e4367b..4377436 100644
--- a/android/health.c
+++ b/android/health.c
@@ -238,10 +238,21 @@ end:
 
 static void bt_health_unregister_app(const void *buf, uint16_t len)
 {
-	DBG("Not implemented");
+	const struct hal_cmd_health_unreg_app *cmd = buf;
+	struct health_app *app;
+
+	DBG("");
+
+	app = queue_remove_if(apps, app_by_app_id, INT_TO_PTR(cmd->app_id));
+	if (!app) {
+		ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_HEALTH,
+				HAL_OP_HEALTH_UNREG_APP, HAL_STATUS_INVALID);
+		return;
+	}
 
-	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_HEALTH, HAL_OP_HEALTH_UNREG_APP,
-							HAL_STATUS_UNSUPPORTED);
+	free_health_app(app);
+	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_HEALTH,
+				HAL_OP_HEALTH_UNREG_APP, HAL_STATUS_SUCCESS);
 }
 
 static void bt_health_connect_channel(const void *buf, uint16_t len)
-- 
1.8.3.2

