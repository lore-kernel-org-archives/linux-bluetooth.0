Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [PATCH 2/4] android/pan: Add PAN cleanup interface implementation
Date: Mon, 11 Nov 2013 16:53:39 +0200
Message-Id: <1384181621-8070-3-git-send-email-ravikumar.veeramally@linux.intel.com>
In-Reply-To: <1384181621-8070-1-git-send-email-ravikumar.veeramally@linux.intel.com>
References: <1384181621-8070-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/hal-pan.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/android/hal-pan.c b/android/hal-pan.c
index cacc6c0..a560055 100644
--- a/android/hal-pan.c
+++ b/android/hal-pan.c
@@ -114,16 +114,18 @@ static bt_status_t pan_init(const btpan_callbacks_t *callbacks)
 
 static void pan_cleanup()
 {
+	struct hal_cmd_register_module cmd;
+
 	DBG("");
 
 	if (!interface_ready())
 		return;
 
-	/* TODO: disable service */
-
-	/* TODO: stop PAN thread */
-
 	cbs = NULL;
+	cmd.service_id = HAL_SERVICE_ID_PAN;
+
+	hal_ipc_cmd(HAL_SERVICE_ID_PAN, HAL_OP_UNREGISTER_MODULE,
+					sizeof(cmd), &cmd, 0, NULL, NULL);
 }
 
 static btpan_interface_t pan_if = {
-- 
1.8.3.2

