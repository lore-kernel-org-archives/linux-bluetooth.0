Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [PATCH 02/11] android/hal-health: Fix copying empty string
Date: Tue, 22 Apr 2014 15:06:01 +0300
Message-Id: <1398168371-29685-3-git-send-email-ravikumar.veeramally@linux.intel.com>
In-Reply-To: <1398168371-29685-1-git-send-email-ravikumar.veeramally@linux.intel.com>
References: <1398168371-29685-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

MDEP desciption is optional. So check before copying.
---
 android/hal-health.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/android/hal-health.c b/android/hal-health.c
index 4ba6fe7..b92c881 100644
--- a/android/hal-health.c
+++ b/android/hal-health.c
@@ -101,9 +101,13 @@ static bt_status_t register_application(bthl_reg_param_t *reg, int *app_id)
 		mdep->role = reg->mdep_cfg[i].mdep_role;
 		mdep->data_type = reg->mdep_cfg[i].data_type;
 		mdep->channel_type = reg->mdep_cfg[i].channel_type;
-		mdep->descr_len = strlen(reg->mdep_cfg[i].mdep_description) + 1;
-		memcpy(mdep->descr, reg->mdep_cfg[i].mdep_description,
+
+		if (reg->mdep_cfg[i].mdep_description) {
+			mdep->descr_len =
+				strlen(reg->mdep_cfg[i].mdep_description) + 1;
+			memcpy(mdep->descr, reg->mdep_cfg[i].mdep_description,
 							mdep->descr_len);
+		}
 
 		status = hal_ipc_cmd(HAL_SERVICE_ID_HEALTH, HAL_OP_HEALTH_MDEP,
 						sizeof(*mdep) + mdep->descr_len,
-- 
1.8.3.2

