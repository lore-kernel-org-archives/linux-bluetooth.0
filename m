Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [RFC 1/7] android/hal-health: Fix passing buf not cmd for passing data
Date: Mon,  9 Jun 2014 17:28:08 +0300
Message-Id: <1402324094-18004-2-git-send-email-ravikumar.veeramally@linux.intel.com>
In-Reply-To: <1402324094-18004-1-git-send-email-ravikumar.veeramally@linux.intel.com>
References: <1402324094-18004-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/hal-health.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/android/hal-health.c b/android/hal-health.c
index 427d4c9..8e73905 100644
--- a/android/hal-health.c
+++ b/android/hal-health.c
@@ -92,7 +92,7 @@ static bt_status_t register_application(bthl_reg_param_t *reg, int *app_id)
 
 	cmd->len = off;
 	status = hal_ipc_cmd(HAL_SERVICE_ID_HEALTH, HAL_OP_HEALTH_REG_APP,
-						sizeof(*cmd) + cmd->len, &cmd,
+						sizeof(*cmd) + cmd->len, buf,
 							&rsp_len, &rsp, NULL);
 
 	if (status != BT_STATUS_SUCCESS)
-- 
1.8.3.2

