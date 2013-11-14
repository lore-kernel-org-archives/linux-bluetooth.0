Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 3/7] android/hal-a2dp: Add implemention of .cleanup
Date: Thu, 14 Nov 2013 12:18:17 +0200
Message-Id: <1384424301-31265-3-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1384424301-31265-1-git-send-email-luiz.dentz@gmail.com>
References: <1384424301-31265-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 android/hal-a2dp.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/android/hal-a2dp.c b/android/hal-a2dp.c
index 50a36fb..e9fadb7 100644
--- a/android/hal-a2dp.c
+++ b/android/hal-a2dp.c
@@ -113,14 +113,19 @@ static bt_status_t init(btav_callbacks_t *callbacks)
 
 static void cleanup()
 {
+	struct hal_cmd_unregister_module cmd;
+
 	DBG("");
 
 	if (!interface_ready())
 		return;
 
-	/* TODO: disable service */
-
 	cbs = NULL;
+
+	cmd.service_id = HAL_SERVICE_ID_A2DP;
+
+	hal_ipc_cmd(HAL_SERVICE_ID_CORE, HAL_OP_UNREGISTER_MODULE,
+					sizeof(cmd), &cmd, 0, NULL, NULL);
 }
 
 static btav_interface_t iface = {
-- 
1.8.3.1

