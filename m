Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [PATCH 13/15] android/hal-health: Add HDP .destroy_channel method
Date: Wed, 12 Mar 2014 17:10:56 +0200
Message-Id: <1394637058-586-14-git-send-email-ravikumar.veeramally@linux.intel.com>
In-Reply-To: <1394637058-586-1-git-send-email-ravikumar.veeramally@linux.intel.com>
References: <1394637058-586-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/hal-health.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/android/hal-health.c b/android/hal-health.c
index 0d10d98..479fd94 100644
--- a/android/hal-health.c
+++ b/android/hal-health.c
@@ -135,6 +135,21 @@ static bt_status_t connect_channel(int app_id, bt_bdaddr_t *bd_addr,
 	return status;
 }
 
+static bt_status_t destroy_channel(int channel_id)
+{
+	struct hal_cmd_health_destroy_channel cmd;
+
+	DBG("");
+
+	if (!interface_ready())
+		return BT_STATUS_NOT_READY;
+
+	cmd.channel_id = channel_id;
+
+	return hal_ipc_cmd(HAL_SERVICE_ID_HEALTH, HAL_OP_HEALTH_DESTROY_CHANNEL,
+					sizeof(cmd), &cmd, 0, NULL, NULL);
+}
+
 static bt_status_t init(bthl_callbacks_t *callbacks)
 {
 	struct hal_cmd_register_module cmd;
@@ -189,7 +204,7 @@ static bthl_interface_t health_if = {
 	.register_application = register_application,
 	.unregister_application = unregister_application,
 	.connect_channel = connect_channel,
-	.destroy_channel = NULL,
+	.destroy_channel = destroy_channel,
 	.cleanup = cleanup
 };
 
-- 
1.8.3.2

