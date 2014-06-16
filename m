Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [PATCH_v2 1/6] android/health: Cache health application data on app register call
Date: Mon, 16 Jun 2014 18:01:35 +0300
Message-Id: <1402930900-24209-2-git-send-email-ravikumar.veeramally@linux.intel.com>
In-Reply-To: <1402930900-24209-1-git-send-email-ravikumar.veeramally@linux.intel.com>
References: <1402930900-24209-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/health.c | 205 +++++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 200 insertions(+), 5 deletions(-)

diff --git a/android/health.c b/android/health.c
index 8279f87..4bad7c4 100644
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
@@ -45,10 +47,113 @@
 
 static bdaddr_t adapter_addr;
 static struct ipc *hal_ipc = NULL;
+static struct queue *apps = NULL;
+
+struct mdep_cfg {
+	uint8_t role;
+	uint16_t data_type;
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
+{
+	struct mdep_cfg *cfg = data;
+
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
+static struct health_app *create_health_app(const char *app_name,
+				const char *provider, const char *srv_name,
+				const char *srv_descr, uint8_t mdeps)
+{
+	struct health_app *app;
+
+	DBG("");
+
+	app = new0(struct health_app, 1);
+	if (!app)
+		return NULL;
+
+	app->id = queue_length(apps) + 1;
+	app->num_of_mdep = mdeps;
+	app->app_name = strdup(app_name);
+
+	if (provider) {
+		app->provider_name = strdup(provider);
+		if (!app->provider_name)
+			goto fail;
+	}
+
+	if (srv_name) {
+		app->service_name = strdup(srv_name);
+		if (!app->service_name)
+			goto fail;
+	}
+
+	if (srv_descr) {
+		app->service_descr = strdup(srv_descr);
+		if (!app->service_descr)
+			goto fail;
+	}
+
+	return app;
+
+fail:
+	free_health_app(app);
+	return NULL;
+}
 
 static void bt_health_register_app(const void *buf, uint16_t len)
 {
 	const struct hal_cmd_health_reg_app *cmd = buf;
+	struct hal_rsp_health_reg_app rsp;
+	struct health_app *app;
+	uint16_t off;
+	uint16_t app_name_len, provider_len, srv_name_len, srv_descr_len;
+	char *app_name, *provider = NULL, *srv_name = NULL, *srv_descr = NULL;
+
+	DBG("");
 
 	if (len != sizeof(*cmd) + cmd->len ||
 			cmd->app_name_off > cmd->provider_name_off ||
@@ -60,18 +165,103 @@ static void bt_health_register_app(const void *buf, uint16_t len)
 		return;
 	}
 
-	DBG("Not implemented");
+	app_name = (char *) cmd->data;
+	app_name_len = cmd->provider_name_off - cmd->app_name_off;
 
-	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_HEALTH, HAL_OP_HEALTH_REG_APP,
-							HAL_STATUS_UNSUPPORTED);
+	off = app_name_len;
+	provider_len = cmd->service_name_off - off;
+	if (provider_len > 0)
+		provider = (char *) cmd->data + off;
+
+	off += provider_len;
+	srv_name_len = cmd->service_descr_off - off;
+	if (srv_name_len > 0)
+		srv_name = (char *) cmd->data + off;
+
+	off += srv_name_len;
+	srv_descr_len = cmd->len - off;
+	if (srv_descr_len > 0)
+		srv_descr = (char *) cmd->data + off;
+
+	app = create_health_app(app_name, provider, srv_name, srv_descr,
+							cmd->num_of_mdep);
+
+	if (!queue_push_tail(apps, app))
+		goto fail;
+
+	rsp.app_id = app->id;
+	ipc_send_rsp_full(hal_ipc, HAL_SERVICE_ID_HEALTH, HAL_OP_HEALTH_REG_APP,
+							sizeof(rsp), &rsp, -1);
+	return;
+
+fail:
+	free_health_app(app);
+	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_HEALTH, HAL_OP_HEALTH_MDEP,
+							HAL_STATUS_FAILED);
 }
 
 static void bt_health_mdep_cfg_data(const void *buf, uint16_t len)
 {
-	DBG("Not implemented");
+	const struct hal_cmd_health_mdep *cmd = buf;
+	struct health_app *app;
+	struct mdep_cfg *mdep = NULL;
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
+	mdep = new0(struct mdep_cfg, 1);
+	if (!mdep) {
+		status = HAL_STATUS_INVALID;
+		goto fail;
+	}
 
+	mdep->role = cmd->role;
+	mdep->data_type = cmd->data_type;
+	mdep->channel_type = cmd->channel_type;
+	mdep->id = queue_length(app->mdeps) + 1;
+
+	if (cmd->descr_len > 0) {
+		mdep->descr = malloc0(cmd->descr_len);
+		memcpy(mdep->descr, cmd->descr, cmd->descr_len);
+	}
+
+	if (app->num_of_mdep > 0 && !app->mdeps) {
+		app->mdeps = queue_new();
+		if (!app->mdeps) {
+			status = HAL_STATUS_FAILED;
+			goto fail;
+		}
+	}
+
+	if (!queue_push_tail(app->mdeps, mdep)) {
+		status = HAL_STATUS_FAILED;
+		goto fail;
+	}
+
+	if (app->num_of_mdep != queue_length(app->mdeps))
+		goto send_rsp;
+
+	/* TODO: Create MCAP instance and prepare SDP profile */
+send_rsp:
 	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_HEALTH, HAL_OP_HEALTH_MDEP,
-							HAL_STATUS_UNSUPPORTED);
+							HAL_STATUS_SUCCESS);
+	return;
+
+fail:
+	if (status != HAL_STATUS_SUCCESS) {
+		free_mdep_cfg(mdep);
+		queue_remove(apps, app);
+		free_health_app(app);
+	}
+
+	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_HEALTH, HAL_OP_HEALTH_MDEP,
+								status);
 }
 
 static void bt_health_unregister_app(const void *buf, uint16_t len)
@@ -123,6 +313,10 @@ bool bt_health_register(struct ipc *ipc, const bdaddr_t *addr, uint8_t mode)
 	bacpy(&adapter_addr, addr);
 
 	hal_ipc = ipc;
+	apps = queue_new();
+	if (!apps)
+		return false;
+
 	ipc_register(hal_ipc, HAL_SERVICE_ID_HEALTH, cmd_handlers,
 						G_N_ELEMENTS(cmd_handlers));
 
@@ -133,6 +327,7 @@ void bt_health_unregister(void)
 {
 	DBG("");
 
+	queue_destroy(apps, free_health_app);
 	ipc_unregister(hal_ipc, HAL_SERVICE_ID_HEALTH);
 	hal_ipc = NULL;
 }
-- 
1.9.1

