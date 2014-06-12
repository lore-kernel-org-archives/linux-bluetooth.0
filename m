Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [PATCH 1/6] android/hal-health: Add channel state event handler
Date: Thu, 12 Jun 2014 16:10:13 +0300
Message-Id: <1402578618-31484-2-git-send-email-ravikumar.veeramally@linux.intel.com>
In-Reply-To: <1402578618-31484-1-git-send-email-ravikumar.veeramally@linux.intel.com>
References: <1402578618-31484-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/hal-health.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/android/hal-health.c b/android/hal-health.c
index 0ef6afc..27e72dc 100644
--- a/android/hal-health.c
+++ b/android/hal-health.c
@@ -41,6 +41,17 @@ static void handle_app_registration_state(void *buf, uint16_t len, int fd)
 		cbacks->app_reg_state_cb(ev->id, ev->state);
 }
 
+static void handle_channel_state(void *buf, uint16_t len, int fd)
+{
+	struct hal_ev_health_channel_state *ev = buf;
+
+	if (cbacks->channel_state_cb)
+		cbacks->channel_state_cb(ev->app_id,
+					(bt_bdaddr_t *) ev->bdaddr,
+					ev->mdep_index, ev->channel_id,
+					ev->channel_state, fd);
+}
+
 /*
  * handlers will be called from notification thread context,
  * index in table equals to 'opcode - HAL_MINIMUM_EVENT'
@@ -49,6 +60,9 @@ static const struct hal_ipc_handler ev_handlers[] = {
 	/* HAL_EV_HEALTH_APP_REG_STATE */
 	{ handle_app_registration_state, false,
 				sizeof(struct hal_ev_health_app_reg_state) },
+	/* HAL_EV_HEALTH_CHANNEL_STATE */
+	{ handle_channel_state, false,
+				sizeof(struct hal_ev_health_channel_state) },
 };
 
 static bt_status_t register_application(bthl_reg_param_t *reg, int *app_id)
-- 
1.9.1

