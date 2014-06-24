Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 01/11] android/hal-health: trivial: Correct coding style
Date: Tue, 24 Jun 2014 15:11:52 +0300
Message-Id: <1403611922-26901-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

---
 android/hal-health.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/android/hal-health.c b/android/hal-health.c
index ac6e87f..0d9136d 100644
--- a/android/hal-health.c
+++ b/android/hal-health.c
@@ -116,8 +116,7 @@ static bt_status_t register_application(bthl_reg_param_t *reg, int *app_id)
 	cmd->len = off;
 	status = hal_ipc_cmd(HAL_SERVICE_ID_HEALTH, HAL_OP_HEALTH_REG_APP,
 						sizeof(*cmd) + cmd->len, buf,
-							&rsp_len, &rsp, NULL);
-
+						&rsp_len, &rsp, NULL);
 	if (status != BT_STATUS_SUCCESS)
 		return status;
 
-- 
1.8.3.2

