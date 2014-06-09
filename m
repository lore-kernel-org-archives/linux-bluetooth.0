Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [RFC 3/7] android/health: Cache health application data on app register call
Date: Mon,  9 Jun 2014 17:28:10 +0300
Message-Id: <1402324094-18004-4-git-send-email-ravikumar.veeramally@linux.intel.com>
In-Reply-To: <1402324094-18004-1-git-send-email-ravikumar.veeramally@linux.intel.com>
References: <1402324094-18004-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/health.c | 188 +++++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 182 insertions(+), 6 deletions(-)

diff --git a/android/health.c b/android/health.c
index 655d9f9..6b748e6 100644
--- a/android/health.c
+++ b/android/health.c
@@ -35,6 +35,8 @@
 #include "lib/sdp.h"
 #include "lib/sdp_lib.h"
 #include "src/log.h"
+#include "src/shared/util.h"
+#include "src/shared/queue.h"
 
 #include "hal-msg.h"
 #include "ipc-common.h"
@@ -45,21 +47,193 @@
 
 static bdaddr_t adapter_addr;
 static struct ipc *hal_ipc = NULL;
+static struct queue *apps = NULL;
 
-static void bt_health_register_app(const void *buf, uint16_t len)
+struct mdep_cfg {
+	uint8_t role;
+	uint8_t data_type;
+	uint8_t channel_type;
+	char *descr;
+
+	uint8_t id; /* mdep id */
+};
+
+struct health_app {
+	char *app_name;
+	char *provider_name;
+	char *service_name;
+	char *service_descr;
+	uint8_t num_of_mdep;
+	struct queue *mdeps;
+
+	uint8_t id; /* app id */
+};
+
+static void free_mdep_cfg(void *data)
 {
-	DBG("Not implemented");
+	struct mdep_cfg *cfg = data;
 
-	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_HEALTH, HAL_OP_HEALTH_REG_APP,
-							HAL_STATUS_UNSUPPORTED);
+	if (!cfg)
+		return;
+
+	free(cfg->descr);
+	free(cfg);
+}
+
+static void free_health_app(void *data)
+{
+	struct health_app *app = data;
+
+	if (!app)
+		return;
+
+	free(app->app_name);
+	free(app->provider_name);
+	free(app->service_name);
+	free(app->service_descr);
+	queue_destroy(app->mdeps, free_mdep_cfg);
+	free(app);
+}
+
+static bool app_by_app_id(const void *data, const void *user_data)
+{
+	const struct health_app *app = data;
+	uint16_t app_id = PTR_TO_INT(user_data);
+
+	return app->id == app_id;
+}
+
+static void bt_health_register_app(const void *buf, uint16_t buf_len)
+{
+	const struct hal_cmd_health_reg_app *cmd = buf;
+	struct hal_rsp_health_reg_app rsp;
+	struct health_app *app;
+	uint16_t off, len;
+
+	DBG("");
+
+	app = g_new0(struct health_app, 1);
+	app->id = queue_length(apps) + 1;
+	app->num_of_mdep = cmd->num_of_mdep;
+
+	off = 0;
+
+	if (cmd->provider_name_off)
+		len = cmd->provider_name_off;
+	else if (cmd->service_name_off)
+		len = cmd->service_name_off;
+	else if (cmd->service_descr_off)
+		len = cmd->service_descr_off;
+	else
+		len = cmd->len;
+
+	app->app_name = g_malloc0(len);
+	memcpy(app->app_name, cmd->data, len);
+	off += len;
+
+	if (cmd->provider_name_off) {
+		if (cmd->service_name_off)
+			len = cmd->service_name_off - cmd->provider_name_off;
+		else if (cmd->service_descr_off)
+			len = cmd->service_descr_off - cmd->provider_name_off;
+		else
+			len = cmd->len - cmd->provider_name_off;
+
+		app->provider_name = g_malloc0(len);
+		memcpy(app->provider_name, cmd->data + off, len);
+		off += len;
+	} else {
+		app->provider_name = NULL;
+	}
+
+	if (cmd->service_name_off) {
+		if (cmd->service_descr_off)
+			len = cmd->service_descr_off - cmd->service_name_off;
+		else
+			len = cmd->len - cmd->service_name_off;
+
+		app->service_name = g_malloc0(len);
+		memcpy(app->service_name, cmd->data + off, len);
+		off += len;
+	} else {
+		app->service_name = NULL;
+	}
+
+	if (cmd->service_descr_off) {
+		len = cmd->len - cmd->service_descr_off;
+
+		app->service_descr = g_malloc0(len);
+		memcpy(app->service_descr, cmd->data + off, len);
+		off += len;
+	} else {
+		app->service_descr = NULL;
+	}
+
+	if (app->num_of_mdep > 0)
+		app->mdeps = queue_new();
+
+	rsp.app_id = app->id;
+
+	if (!queue_push_tail(apps, app)) {
+		free_health_app(app);
+		ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_HEALTH,
+				HAL_OP_HEALTH_REG_APP, HAL_STATUS_FAILED);
+		return;
+	}
+
+	ipc_send_rsp_full(hal_ipc, HAL_SERVICE_ID_HEALTH, HAL_OP_HEALTH_REG_APP,
+							sizeof(rsp), &rsp, -1);
 }
 
 static void bt_health_mdep_cfg_data(const void *buf, uint16_t len)
 {
-	DBG("Not implemented");
+	const struct hal_cmd_health_mdep *cmd = buf;
+	struct health_app *app;
+	struct mdep_cfg *mdep;
+	uint8_t status;
+
+	DBG("");
+
+	app = queue_find(apps, app_by_app_id, INT_TO_PTR(cmd->app_id));
+	if (!app) {
+		status = HAL_STATUS_INVALID;
+		goto fail;
+	}
+
+	mdep = g_new0(struct mdep_cfg, 1);
+	mdep->role = cmd->role;
+	mdep->data_type = cmd->data_type;
+	mdep->channel_type = cmd->channel_type;
+	mdep->id = queue_length(app->mdeps) + 1;
 
+	if (cmd->descr_len > 0) {
+		mdep->descr = g_malloc0(cmd->descr_len);
+		memcpy(mdep->descr, cmd->descr, cmd->descr_len);
+	}
+
+	if (!queue_push_tail(app->mdeps, mdep)) {
+		free_mdep_cfg(mdep);
+		status = HAL_STATUS_FAILED;
+		goto fail;
+	}
+
+	if (app->num_of_mdep != queue_length(app->mdeps)) {
+		status = HAL_STATUS_SUCCESS;
+		goto end;
+	}
+
+	/* TODO: Create MCAP instance and prepare SDP profile */
+	status = HAL_STATUS_SUCCESS;
+
+fail:
+	if (status != HAL_STATUS_SUCCESS) {
+		queue_remove(apps, app);
+		free_health_app(app);
+	}
+
+end:
 	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_HEALTH, HAL_OP_HEALTH_MDEP,
-							HAL_STATUS_UNSUPPORTED);
+								status);
 }
 
 static void bt_health_unregister_app(const void *buf, uint16_t len)
@@ -111,6 +285,7 @@ bool bt_health_register(struct ipc *ipc, const bdaddr_t *addr, uint8_t mode)
 	bacpy(&adapter_addr, addr);
 
 	hal_ipc = ipc;
+	apps = queue_new();
 	ipc_register(hal_ipc, HAL_SERVICE_ID_HEALTH, cmd_handlers,
 						G_N_ELEMENTS(cmd_handlers));
 
@@ -121,6 +296,7 @@ void bt_health_unregister(void)
 {
 	DBG("");
 
+	queue_destroy(apps, free_health_app);
 	ipc_unregister(hal_ipc, HAL_SERVICE_ID_HEALTH);
 	hal_ipc = NULL;
 }
-- 
1.8.3.2

