Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [PATCH 12/15] android/hal-health: Add HDP .connect_channel method
Date: Wed, 12 Mar 2014 17:10:55 +0200
Message-Id: <1394637058-586-13-git-send-email-ravikumar.veeramally@linux.intel.com>
In-Reply-To: <1394637058-586-1-git-send-email-ravikumar.veeramally@linux.intel.com>
References: <1394637058-586-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/hal-health.c | 31 ++++++++++++++++++++++++++++++-
 1 file changed, 30 insertions(+), 1 deletion(-)

diff --git a/android/hal-health.c b/android/hal-health.c
index 007a37a..0d10d98 100644
--- a/android/hal-health.c
+++ b/android/hal-health.c
@@ -106,6 +106,35 @@ static bt_status_t unregister_application(int app_id)
 					sizeof(cmd), &cmd, 0, NULL, NULL);
 }
 
+static bt_status_t connect_channel(int app_id, bt_bdaddr_t *bd_addr,
+					int mdep_cfg_index, int *channel_id)
+{
+	struct hal_cmd_health_connect_channel cmd;
+	struct hal_rsp_health_connect_channel rsp;
+	size_t len = sizeof(rsp);
+	bt_status_t status;
+
+	DBG("");
+
+	if (!interface_ready())
+		return BT_STATUS_NOT_READY;
+
+	if (!bd_addr)
+		return BT_STATUS_PARM_INVALID;
+
+	cmd.app_id = app_id;
+	cmd.mdep_index = mdep_cfg_index;
+	memcpy(cmd.bdaddr, bd_addr, sizeof(cmd.bdaddr));
+
+	status = hal_ipc_cmd(HAL_SERVICE_ID_HEALTH,
+					HAL_OP_HEALTH_CONNECT_CHANNEL,
+					sizeof(cmd), &cmd, &len, &rsp, NULL);
+
+	*channel_id = rsp.channel_id;
+
+	return status;
+}
+
 static bt_status_t init(bthl_callbacks_t *callbacks)
 {
 	struct hal_cmd_register_module cmd;
@@ -159,7 +188,7 @@ static bthl_interface_t health_if = {
 	.init = init,
 	.register_application = register_application,
 	.unregister_application = unregister_application,
-	.connect_channel = NULL,
+	.connect_channel = connect_channel,
 	.destroy_channel = NULL,
 	.cleanup = cleanup
 };
-- 
1.8.3.2

