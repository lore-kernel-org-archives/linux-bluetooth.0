Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [PATCH_v3 1/4] android/hal-health: Add HDP .register_application method
Date: Fri, 14 Mar 2014 15:30:55 +0200
Message-Id: <1394803858-10052-2-git-send-email-ravikumar.veeramally@linux.intel.com>
In-Reply-To: <1394803858-10052-1-git-send-email-ravikumar.veeramally@linux.intel.com>
References: <1394803858-10052-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/hal-health.c | 109 ++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 108 insertions(+), 1 deletion(-)

diff --git a/android/hal-health.c b/android/hal-health.c
index 918fb69..6e0f731 100644
--- a/android/hal-health.c
+++ b/android/hal-health.c
@@ -38,6 +38,113 @@ static bool interface_ready(void)
 static const struct hal_ipc_handler ev_handlers[] = {
 };
 
+static bt_status_t register_application(bthl_reg_param_t *reg, int *app_id)
+{
+	char buf[IPC_MTU];
+	struct hal_cmd_health_reg_app *cmd = (void *) buf;
+	struct hal_rsp_health_reg_app rsp;
+	size_t len = sizeof(rsp);
+	bt_status_t status;
+	ssize_t cmd_len;
+	uint8_t i;
+
+	DBG("");
+
+	if (!interface_ready())
+		return BT_STATUS_NOT_READY;
+
+	if (!reg || !app_id)
+		return BT_STATUS_PARM_INVALID;
+
+
+	cmd_len = sizeof(*cmd);
+
+	if (reg->application_name)
+		cmd_len += strlen(reg->application_name) + 1;
+
+	if (reg->provider_name)
+		cmd_len += strlen(reg->provider_name) + 1;
+
+	if (reg->srv_name)
+		cmd_len += strlen(reg->srv_name) + 1;
+
+	if (reg->srv_desp)
+		cmd_len += strlen(reg->srv_desp) + 1;
+
+	if (reg->number_of_mdeps > 0 && reg->mdep_cfg[0].mdep_description)
+		cmd_len += strlen(reg->mdep_cfg[0].mdep_description) + 1;
+
+	for (i = 1; i < reg->number_of_mdeps; i++)
+		cmd_len += sizeof(cmd->mdep_cfg) +
+				strlen(reg->mdep_cfg[i].mdep_description) + 1;
+
+	if (cmd_len > IPC_MTU) {
+		error("HDP app registration data length is more than IPC_MTU");
+		return BT_STATUS_PARM_INVALID;
+	}
+
+	if (reg->application_name) {
+		cmd->app_name.len = strlen(reg->application_name);
+		memcpy(cmd->app_name.data, reg->application_name,
+						cmd->app_name.len);
+	} else {
+		cmd->app_name.len = 0;
+	}
+
+	if (reg->provider_name) {
+		cmd->provider_name.len = strlen(reg->provider_name);
+		memcpy(cmd->provider_name.data, reg->provider_name,
+						cmd->provider_name.len);
+	} else {
+		cmd->provider_name.len = 0;
+	}
+
+	if (reg->srv_name) {
+		cmd->service_name.len = strlen(reg->srv_name);
+		memcpy(cmd->service_name.data, reg->srv_name,
+						cmd->service_name.len);
+	} else {
+		cmd->service_name.len = 0;
+	}
+
+	if (reg->srv_desp) {
+		cmd->service_descr.len = strlen(reg->srv_desp);
+		memcpy(cmd->service_descr.data, reg->srv_desp,
+						cmd->service_descr.len);
+	} else {
+		cmd->service_descr.len = 0;
+	}
+
+	cmd->num_of_mdep = reg->number_of_mdeps;
+
+	if (reg->mdep_cfg && reg->number_of_mdeps > 0) {
+		for (i = 0; i < reg->number_of_mdeps; i++) {
+			cmd->mdep_cfg[i].role = reg->mdep_cfg[i].mdep_role;
+			cmd->mdep_cfg[i].data_type = reg->mdep_cfg[i].data_type;
+			cmd->mdep_cfg[i].channel_type =
+						reg->mdep_cfg[i].channel_type;
+
+			if (cmd->mdep_cfg[i].descr.data) {
+				cmd->mdep_cfg[i].descr.len =
+				strlen(reg->mdep_cfg[i].mdep_description);
+				memcpy(cmd->mdep_cfg[i].descr.data,
+					reg->mdep_cfg[i].mdep_description,
+						cmd->mdep_cfg[i].descr.len);
+			} else {
+				cmd->mdep_cfg[i].descr.len = 0;
+			}
+		}
+	}
+
+	status = hal_ipc_cmd(HAL_SERVICE_ID_HEALTH, HAL_OP_HEALTH_REG_APP,
+						cmd_len, cmd, &len, &rsp, NULL);
+
+	if (status == HAL_STATUS_SUCCESS)
+		*app_id = rsp.app_id;
+
+	return status;
+}
+
 static bt_status_t init(bthl_callbacks_t *callbacks)
 {
 	struct hal_cmd_register_module cmd;
@@ -89,7 +196,7 @@ static void cleanup(void)
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

