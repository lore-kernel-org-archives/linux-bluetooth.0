Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [PATCH_v2 4/6] android/health: Notify application registration status
Date: Mon, 16 Jun 2014 18:01:38 +0300
Message-Id: <1402930900-24209-5-git-send-email-ravikumar.veeramally@linux.intel.com>
In-Reply-To: <1402930900-24209-1-git-send-email-ravikumar.veeramally@linux.intel.com>
References: <1402930900-24209-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/health.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/android/health.c b/android/health.c
index 3029439..4862b76 100644
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
@@ -686,6 +699,8 @@ static void bt_health_mdep_cfg_data(const void *buf, uint16_t len)
 		goto fail;
 	}
 
+	send_app_reg_notify(app, HAL_HEALTH_APP_REG_SUCCESS);
+
 send_rsp:
 	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_HEALTH, HAL_OP_HEALTH_MDEP,
 							HAL_STATUS_SUCCESS);
-- 
1.9.1

