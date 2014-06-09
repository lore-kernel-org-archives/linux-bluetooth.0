Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [RFC 7/7] android/health: Notify application registration status
Date: Mon,  9 Jun 2014 17:28:14 +0300
Message-Id: <1402324094-18004-8-git-send-email-ravikumar.veeramally@linux.intel.com>
In-Reply-To: <1402324094-18004-1-git-send-email-ravikumar.veeramally@linux.intel.com>
References: <1402324094-18004-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/health.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/android/health.c b/android/health.c
index 3d9a553..7be1d20 100644
--- a/android/health.c
+++ b/android/health.c
@@ -104,6 +104,19 @@ static void free_health_app(void *data)
 	free(app);
 }
 
+static void bt_health_notify_app_reg_state(struct health_app *app, uint8_t state)
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
@@ -674,7 +687,7 @@ static void bt_health_mdep_cfg_data(const void *buf, uint16_t len)
 	}
 
 	status = HAL_STATUS_SUCCESS;
-
+	bt_health_notify_app_reg_state(app, HAL_HEALTH_APP_REG_SUCCESS);
 fail:
 	if (status != HAL_STATUS_SUCCESS) {
 		queue_remove(apps, app);
@@ -706,6 +719,7 @@ static void bt_health_unregister_app(const void *buf, uint16_t len)
 	}
 
 	free_health_app(app);
+	bt_health_notify_app_reg_state(app, HAL_HEALTH_APP_DEREG_SUCCESS);
 	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_HEALTH,
 				HAL_OP_HEALTH_UNREG_APP, HAL_STATUS_SUCCESS);
 }
-- 
1.8.3.2

