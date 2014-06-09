Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [RFC 6/7] android/hal-health: Add app state event handler
Date: Mon,  9 Jun 2014 17:28:13 +0300
Message-Id: <1402324094-18004-7-git-send-email-ravikumar.veeramally@linux.intel.com>
In-Reply-To: <1402324094-18004-1-git-send-email-ravikumar.veeramally@linux.intel.com>
References: <1402324094-18004-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/hal-health.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/android/hal-health.c b/android/hal-health.c
index ae327b8..01d8758 100644
--- a/android/hal-health.c
+++ b/android/hal-health.c
@@ -33,11 +33,24 @@ static bool interface_ready(void)
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
 /*
  * handlers will be called from notification thread context,
  * index in table equals to 'opcode - HAL_MINIMUM_EVENT'
  */
 static const struct hal_ipc_handler ev_handlers[] = {
+	{ /* HAL_EV_HEALTH_APP_REG_STATE */
+		.handler = handle_app_registration_state,
+		.var_len = false,
+		.data_len = sizeof(struct hal_ev_health_app_reg_state)
+	},
 };
 
 static bt_status_t register_application(bthl_reg_param_t *reg, int *app_id)
-- 
1.8.3.2

