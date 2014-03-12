Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [PATCH 14/15] android/hal-health: Add app state and channel state event handlers
Date: Wed, 12 Mar 2014 17:10:57 +0200
Message-Id: <1394637058-586-15-git-send-email-ravikumar.veeramally@linux.intel.com>
In-Reply-To: <1394637058-586-1-git-send-email-ravikumar.veeramally@linux.intel.com>
References: <1394637058-586-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/hal-health.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/android/hal-health.c b/android/hal-health.c
index 479fd94..a9ea8cb 100644
--- a/android/hal-health.c
+++ b/android/hal-health.c
@@ -33,9 +33,38 @@ static bool interface_ready(void)
 	return cbacks != NULL;
 }
 
+static void handle_app_registration_state(void *buf, uint16_t len)
+{
+	struct hal_ev_health_app_reg_state *ev = buf;
+
+	if (cbacks->app_reg_state_cb)
+		cbacks->app_reg_state_cb(ev->id, ev->state);
+}
+
+static void handle_channel_state(void *buf, uint16_t len)
+{
+	struct hal_ev_health_chnl_state *ev = buf;
+
+	if (cbacks->channel_state_cb)
+		cbacks->channel_state_cb(ev->app_id,
+					(bt_bdaddr_t *) ev->bdaddr,
+					ev->mdep_index, ev->chnl_id,
+					ev->chnl_state, ev->file_descr);
+}
+
 /* handlers will be called from notification thread context,
  * index in table equals to 'opcode - HAL_MINIMUM_EVENT' */
 static const struct hal_ipc_handler ev_handlers[] = {
+	{ /* HAL_EV_HEALTH_APP_REG_STATE */
+		.handler = handle_app_registration_state,
+		.var_len = false,
+		.data_len = sizeof(struct hal_ev_health_app_reg_state)
+	},
+	{ /* HAL_EV_HEALTH_CHNL_STATE */
+		.handler = handle_channel_state,
+		.var_len = false,
+		.data_len = sizeof(struct hal_ev_health_chnl_state)
+	},
 };
 
 static bt_status_t register_application(bthl_reg_param_t *reg, int *app_id)
-- 
1.8.3.2

