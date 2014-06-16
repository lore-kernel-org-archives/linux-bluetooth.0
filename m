Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [PATCH 2/4] anrdoid/hal-health: Fix wrong channel type defines
Date: Mon, 16 Jun 2014 20:51:12 +0300
Message-Id: <1402941074-14407-3-git-send-email-ravikumar.veeramally@linux.intel.com>
In-Reply-To: <1402941074-14407-1-git-send-email-ravikumar.veeramally@linux.intel.com>
References: <1402941074-14407-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Enums in bt_hl.h are defined in this order BTHL_CHANNEL_TYPE_RELIABLE,
BTHL_CHANNEL_TYPE_STREAMING, BTHL_CHANNEL_TYPE_ANY. But HDP_SPEC_V11(3.4)
has no-preference(any)-0, reliable-1, stream-2, reserved(0x03-0xff).
---
 android/hal-health.c | 13 ++++++++++++-
 android/hal-msg.h    |  6 +++---
 2 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/android/hal-health.c b/android/hal-health.c
index ab06658..32c1b39 100644
--- a/android/hal-health.c
+++ b/android/hal-health.c
@@ -127,7 +127,18 @@ static bt_status_t register_application(bthl_reg_param_t *reg, int *app_id)
 		mdep->app_id = rsp.app_id;
 		mdep->role = reg->mdep_cfg[i].mdep_role;
 		mdep->data_type = reg->mdep_cfg[i].data_type;
-		mdep->channel_type = reg->mdep_cfg[i].channel_type;
+
+		switch (reg->mdep_cfg[i].channel_type) {
+		case BTHL_CHANNEL_TYPE_ANY:
+			mdep->channel_type = HAL_HEALTH_CHANNEL_TYPE_ANY;
+			break;
+		case BTHL_CHANNEL_TYPE_RELIABLE:
+			mdep->channel_type = HAL_HEALTH_CHANNEL_TYPE_RELIABLE;
+			break;
+		case BTHL_CHANNEL_TYPE_STREAMING:
+			mdep->channel_type = HAL_HEALTH_CHANNEL_TYPE_STREAMING;
+			break;
+		}
 
 		if (reg->mdep_cfg[i].mdep_description) {
 			mdep->descr_len =
diff --git a/android/hal-msg.h b/android/hal-msg.h
index 2c21a85..c95ac0f 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -388,9 +388,9 @@ struct hal_cmd_pan_disconnect {
 #define HAL_HEALTH_MDEP_ROLE_SOURCE	0x00
 #define HAL_HEALTH_MDEP_ROLE_SINK	0x01
 
-#define HAL_HEALTH_CHANNEL_TYPE_RELIABLE	0x00
-#define HAL_HEALTH_CHANNEL_TYPE_STREAMING	0x01
-#define HAL_HEALTH_CHANNEL_TYPE_ANY		0x02
+#define HAL_HEALTH_CHANNEL_TYPE_ANY		0x00
+#define HAL_HEALTH_CHANNEL_TYPE_RELIABLE	0x01
+#define HAL_HEALTH_CHANNEL_TYPE_STREAMING	0x02
 
 #define HAL_OP_HEALTH_REG_APP		0x01
 struct hal_cmd_health_reg_app {
-- 
1.9.1

