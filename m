Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/7] android/hal-a2dp: Add implemention of .init
Date: Thu, 14 Nov 2013 12:18:16 +0200
Message-Id: <1384424301-31265-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1384424301-31265-1-git-send-email-luiz.dentz@gmail.com>
References: <1384424301-31265-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 android/hal-a2dp.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/android/hal-a2dp.c b/android/hal-a2dp.c
index cdb5229..50a36fb 100644
--- a/android/hal-a2dp.c
+++ b/android/hal-a2dp.c
@@ -99,13 +99,16 @@ static bt_status_t disconnect(bt_bdaddr_t *bd_addr)
 
 static bt_status_t init(btav_callbacks_t *callbacks)
 {
+	struct hal_cmd_register_module cmd;
+
 	DBG("");
 
 	cbs = callbacks;
 
-	/* TODO: enable service */
+	cmd.service_id = HAL_SERVICE_ID_A2DP;
 
-	return BT_STATUS_SUCCESS;
+	return hal_ipc_cmd(HAL_SERVICE_ID_CORE, HAL_OP_REGISTER_MODULE,
+					sizeof(cmd), &cmd, 0, NULL, NULL);
 }
 
 static void cleanup()
-- 
1.8.3.1

