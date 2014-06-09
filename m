Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [RFC 2/7] android/hal-msg: Add application id to mdep config cmd struct
Date: Mon,  9 Jun 2014 17:28:09 +0300
Message-Id: <1402324094-18004-3-git-send-email-ravikumar.veeramally@linux.intel.com>
In-Reply-To: <1402324094-18004-1-git-send-email-ravikumar.veeramally@linux.intel.com>
References: <1402324094-18004-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Register application cmd is fragmented into application and multiple
MDEP configurations data. Passing app id helps to find which mdep data
belongs to which registered application.
---
 android/hal-health.c | 1 +
 android/hal-msg.h    | 1 +
 2 files changed, 2 insertions(+)

diff --git a/android/hal-health.c b/android/hal-health.c
index 8e73905..ae327b8 100644
--- a/android/hal-health.c
+++ b/android/hal-health.c
@@ -100,6 +100,7 @@ static bt_status_t register_application(bthl_reg_param_t *reg, int *app_id)
 
 	for (i = 0; i < reg->number_of_mdeps; i++) {
 		memset(buf, 0, IPC_MTU);
+		mdep->app_id = rsp.app_id;
 		mdep->role = reg->mdep_cfg[i].mdep_role;
 		mdep->data_type = reg->mdep_cfg[i].data_type;
 		mdep->channel_type = reg->mdep_cfg[i].channel_type;
diff --git a/android/hal-msg.h b/android/hal-msg.h
index 5da62f3..65cf81f 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -405,6 +405,7 @@ struct hal_cmd_health_reg_app {
 
 #define HAL_OP_HEALTH_MDEP		0x02
 struct hal_cmd_health_mdep {
+	uint16_t app_id;
 	uint8_t  role;
 	uint8_t  data_type;
 	uint8_t  channel_type;
-- 
1.8.3.2

