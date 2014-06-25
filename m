Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [PATCH_v2 3/3] android/hal-health: Return app_id and channel_id -1 in case of error
Date: Wed, 25 Jun 2014 14:45:17 +0300
Message-Id: <1403696717-32664-3-git-send-email-ravikumar.veeramally@linux.intel.com>
In-Reply-To: <1403696717-32664-1-git-send-email-ravikumar.veeramally@linux.intel.com>
References: <1403696717-32664-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Right now returning only status of request but java layer expecting
-1 for app_id and channel_id in failure case.
---
 android/hal-health.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/android/hal-health.c b/android/hal-health.c
index ac6e87f..35ac5c6 100644
--- a/android/hal-health.c
+++ b/android/hal-health.c
@@ -82,6 +82,7 @@ static bt_status_t register_application(bthl_reg_param_t *reg, int *app_id)
 	if (!reg || !app_id || !reg->application_name)
 		return BT_STATUS_PARM_INVALID;
 
+	*app_id = -1;
 	memset(buf, 0, IPC_MTU);
 
 	cmd->num_of_mdep = reg->number_of_mdeps;
@@ -181,6 +182,7 @@ static bt_status_t connect_channel(int app_id, bt_bdaddr_t *bd_addr,
 	if (!bd_addr || !channel_id)
 		return BT_STATUS_PARM_INVALID;
 
+	*channel_id = -1;
 	cmd.app_id = app_id;
 	cmd.mdep_index = mdep_cfg_index;
 	memcpy(cmd.bdaddr, bd_addr, sizeof(cmd.bdaddr));
-- 
1.9.1

