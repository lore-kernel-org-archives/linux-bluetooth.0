Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [PATCH 5/6] android/health: Notify application registration status
Date: Thu, 12 Jun 2014 16:10:17 +0300
Message-Id: <1402578618-31484-6-git-send-email-ravikumar.veeramally@linux.intel.com>
In-Reply-To: <1402578618-31484-1-git-send-email-ravikumar.veeramally@linux.intel.com>
References: <1402578618-31484-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/health.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/android/health.c b/android/health.c
index 45255df..687dfee 100644
--- a/android/health.c
+++ b/android/health.c
@@ -105,6 +105,19 @@ static void free_health_app(void *data)
 	free(app);
 }
 
+static void send_app_reg_notify(struct health_app *app, uint8_t state)
+{
+	struct hal_ev_health_app_reg_state ev;
+
+	DBG("");
+
+	ev.id = app->id;
+	ev.state = state;
+
+	ipc_send_notif(hal_ipc, HAL_SERVICE_ID_HEALTH,
+				HAL_EV_HEALTH_APP_REG_STATE, sizeof(ev), &ev);
+}
+
 static bool mdep_by_mdep_role(const void *data, const void *user_data)
 {
 	const struct mdep_cfg *mdep = data;
@@ -660,6 +673,7 @@ static void bt_health_mdep_cfg_data(const void *buf, uint16_t len)
 	}
 
 	status = HAL_STATUS_SUCCESS;
+	send_app_reg_notify(app, HAL_HEALTH_APP_REG_SUCCESS);
 
 fail:
 	if (status != HAL_STATUS_SUCCESS) {
@@ -686,12 +700,15 @@ static void bt_health_unregister_app(const void *buf, uint16_t len)
 		return;
 	}
 
+	send_app_reg_notify(app, HAL_HEALTH_APP_DEREG_SUCCESS);
+
 	if (record_id > 0) {
 		bt_adapter_remove_record(record_id);
 		record_id = 0;
 	}
 
 	free_health_app(app);
+
 	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_HEALTH,
 				HAL_OP_HEALTH_UNREG_APP, HAL_STATUS_SUCCESS);
 }
-- 
1.9.1

