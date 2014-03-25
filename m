Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [RFC 3/3] android/hal-health: Add HDP .register_application method
Date: Tue, 25 Mar 2014 16:34:41 +0200
Message-Id: <1395758081-22005-4-git-send-email-ravikumar.veeramally@linux.intel.com>
In-Reply-To: <1395758081-22005-1-git-send-email-ravikumar.veeramally@linux.intel.com>
References: <1395758081-22005-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Implementation of register_application is different compared
to other apis. Due to limited IPC_MTU and variable length of
fields from 'bthl_reg_param_t *', it is difficult to put them
in single command and send though IPC. So we split this command
multiple calls. First command will be called with opcode of
HAL_OP_HEALTH_REG_APP with 'struct hal_cmd_health_reg_app' data.
Later command will be called with opcode of
HAL_OP_HEALTH_MDEP with 'struct hal_cmd_health_mdep' data for
number_of_mdeps times. Daemon (android/health) side it will
process after it received all data and response will be sent
along with last call of HAL_OP_HEALTH_MDEP.

This avoids increasing value of IPC_MTU and mainly because of
optional parameters in 'bthl_reg_param_t'. Incase of unfilled
optional parameters, fixed size arrays in hal commands will be
empty.
---
 android/hal-health.c | 88 +++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 87 insertions(+), 1 deletion(-)

diff --git a/android/hal-health.c b/android/hal-health.c
index e6fe65a..bfd5779 100644
--- a/android/hal-health.c
+++ b/android/hal-health.c
@@ -38,6 +38,92 @@ static bool interface_ready(void)
 static const struct hal_ipc_handler ev_handlers[] = {
 };
 
+static bt_status_t register_application(bthl_reg_param_t *reg, int *app_id)
+{
+	uint8_t buf[IPC_MTU];
+	struct hal_cmd_health_reg_app *cmd = (void *) buf;
+	struct hal_cmd_health_mdep *mdep = (void *) buf;
+	struct hal_rsp_health_reg_app rsp;
+	size_t rsp_len = sizeof(rsp);
+	bt_status_t status;
+	uint16_t off, len;
+	int i;
+
+	DBG("");
+
+	if (!interface_ready())
+		return BT_STATUS_NOT_READY;
+
+	if (!reg || !app_id || !reg->application_name)
+		return BT_STATUS_PARM_INVALID;
+
+	memset(buf, 0, IPC_MTU);
+
+	cmd->num_of_mdep = reg->number_of_mdeps;
+
+	off = 0;
+	cmd->app_name_off = off;
+	len = strlen(reg->application_name);
+	memcpy(cmd->data, reg->application_name, len);
+	off += len;
+
+	if (reg->provider_name) {
+		len = strlen(reg->provider_name);
+		cmd->provider_name_off = off;
+		memcpy(cmd->data + off, reg->provider_name, len);
+		off += len;
+	} else {
+		cmd->provider_name_off = 0;
+	}
+
+	if (reg->srv_name) {
+		len = strlen(reg->srv_name);
+		cmd->service_name_off = off;
+		memcpy(cmd->data + off, reg->srv_name, len);
+		off += len;
+	} else {
+		cmd->service_name_off = 0;
+	}
+
+	if (reg->srv_desp) {
+		len = strlen(reg->srv_desp);
+		cmd->service_descr_off = off;
+		memcpy(cmd->data + off, reg->srv_desp, len);
+		off += len;
+	} else {
+		cmd->service_descr_off = 0;
+	}
+
+	cmd->len = off;
+	status = hal_ipc_cmd(HAL_SERVICE_ID_HEALTH, HAL_OP_HEALTH_REG_APP,
+				sizeof(*cmd) + cmd->len, &cmd, 0, NULL, NULL);
+
+	if (status != HAL_STATUS_SUCCESS)
+		return status;
+
+	for (i = 0; i < reg->number_of_mdeps; i++) {
+		memset(buf, 0, IPC_MTU);
+		mdep->role = reg->mdep_cfg[i].mdep_role;
+		mdep->data_type = reg->mdep_cfg[i].data_type;
+		mdep->channel_type = reg->mdep_cfg[i].channel_type;
+		mdep->descr_len = strlen(reg->mdep_cfg[i].mdep_description);
+		memcpy(mdep->descr, reg->mdep_cfg[i].mdep_description,
+							mdep->descr_len);
+
+		status = hal_ipc_cmd(HAL_SERVICE_ID_HEALTH, HAL_OP_HEALTH_MDEP,
+						sizeof(*mdep) + mdep->descr_len,
+						buf, &rsp_len, &rsp, NULL);
+
+		if (status != HAL_STATUS_SUCCESS)
+			return status;
+
+	}
+
+	*app_id = rsp.app_id;
+
+	return status;
+}
+
 static bt_status_t unregister_application(int app_id)
 {
 	struct hal_cmd_health_unreg_app cmd;
@@ -149,7 +235,7 @@ static void cleanup(void)
 static bthl_interface_t health_if = {
 	.size = sizeof(health_if),
 	.init = init,
-	.register_application = NULL,
+	.register_application = register_application,
 	.unregister_application = unregister_application,
 	.connect_channel = connect_channel,
 	.destroy_channel = destroy_channel,
-- 
1.8.3.2

