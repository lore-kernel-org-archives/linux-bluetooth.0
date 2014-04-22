Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [PATCH 01/11] android/hal-health: Use correct enums
Date: Tue, 22 Apr 2014 15:06:00 +0300
Message-Id: <1398168371-29685-2-git-send-email-ravikumar.veeramally@linux.intel.com>
In-Reply-To: <1398168371-29685-1-git-send-email-ravikumar.veeramally@linux.intel.com>
References: <1398168371-29685-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/hal-health.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/android/hal-health.c b/android/hal-health.c
index 8d12107..4ba6fe7 100644
--- a/android/hal-health.c
+++ b/android/hal-health.c
@@ -93,7 +93,7 @@ static bt_status_t register_application(bthl_reg_param_t *reg, int *app_id)
 						sizeof(*cmd) + cmd->len, &cmd,
 							&rsp_len, &rsp, NULL);
 
-	if (status != HAL_STATUS_SUCCESS)
+	if (status != BT_STATUS_SUCCESS)
 		return status;
 
 	for (i = 0; i < reg->number_of_mdeps; i++) {
@@ -109,7 +109,7 @@ static bt_status_t register_application(bthl_reg_param_t *reg, int *app_id)
 						sizeof(*mdep) + mdep->descr_len,
 						buf, 0, NULL, NULL);
 
-		if (status != HAL_STATUS_SUCCESS)
+		if (status != BT_STATUS_SUCCESS)
 			return status;
 
 	}
@@ -158,7 +158,7 @@ static bt_status_t connect_channel(int app_id, bt_bdaddr_t *bd_addr,
 					HAL_OP_HEALTH_CONNECT_CHANNEL,
 					sizeof(cmd), &cmd, &len, &rsp, NULL);
 
-	if (status == HAL_STATUS_SUCCESS)
+	if (status == BT_STATUS_SUCCESS)
 		*channel_id = rsp.channel_id;
 
 	return status;
-- 
1.8.3.2

