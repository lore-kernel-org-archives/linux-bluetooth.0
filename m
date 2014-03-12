Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [PATCH 10/15] android/hal-health: Add HDP .register_application method
Date: Wed, 12 Mar 2014 17:10:53 +0200
Message-Id: <1394637058-586-11-git-send-email-ravikumar.veeramally@linux.intel.com>
In-Reply-To: <1394637058-586-1-git-send-email-ravikumar.veeramally@linux.intel.com>
References: <1394637058-586-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/hal-health.c | 55 +++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 54 insertions(+), 1 deletion(-)

diff --git a/android/hal-health.c b/android/hal-health.c
index 50adcc9..8a610a2 100644
--- a/android/hal-health.c
+++ b/android/hal-health.c
@@ -38,6 +38,59 @@ static bool interface_ready(void)
 static const struct hal_ipc_handler ev_handlers[] = {
 };
 
+static bt_status_t register_application(bthl_reg_param_t *reg, int *app_id)
+{
+	struct hal_cmd_health_reg_app cmd;
+	struct hal_rsp_health_reg_app rsp;
+	size_t len = sizeof(rsp);
+	bt_status_t status;
+	uint8_t i;
+
+	DBG("");
+
+	if (!interface_ready())
+		return BT_STATUS_NOT_READY;
+
+	memset(&cmd, 0, sizeof(cmd));
+
+	if (reg->application_name)
+		memcpy(cmd.app_name, reg->application_name,
+						strlen(reg->application_name));
+
+	if (reg->provider_name)
+		memcpy(cmd.provider_name, reg->provider_name,
+						strlen(reg->provider_name));
+
+	if (reg->srv_name)
+		memcpy(cmd.service_name, reg->srv_name,
+						strlen(reg->srv_name));
+
+	if (reg->srv_desp)
+		memcpy(cmd.service_descr, reg->srv_desp,
+						strlen(reg->srv_desp));
+
+	cmd.num_of_mdep = reg->number_of_mdeps;
+
+	if (reg->mdep_cfg && reg->number_of_mdeps > 0) {
+		for (i = 0; i < reg->number_of_mdeps; i++) {
+			cmd.mdep_cfg[i].role = reg->mdep_cfg[i].mdep_role;
+			cmd.mdep_cfg[i].data_type = reg->mdep_cfg[i].data_type;
+			cmd.mdep_cfg[i].channel_type =
+						reg->mdep_cfg[i].channel_type;
+			memcpy(cmd.mdep_cfg[i].descr,
+				reg->mdep_cfg[i].mdep_description,
+				strlen(reg->mdep_cfg[i].mdep_description));
+		}
+	}
+
+	status = hal_ipc_cmd(HAL_SERVICE_ID_HEALTH, HAL_OP_HEALTH_REG_APP,
+					sizeof(cmd), &cmd, &len, &rsp, NULL);
+
+	*app_id = rsp.app_id;
+
+	return status;
+}
+
 static bt_status_t init(bthl_callbacks_t *callbacks)
 {
 	struct hal_cmd_register_module cmd;
@@ -89,7 +142,7 @@ static void cleanup(void)
 static bthl_interface_t health_if = {
 	.size = sizeof(health_if),
 	.init = init,
-	.register_application = NULL,
+	.register_application = register_application,
 	.unregister_application = NULL,
 	.connect_channel = NULL,
 	.destroy_channel = NULL,
-- 
1.8.3.2

