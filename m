Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] android/hal-handsfree: trivial remove empty line
Date: Mon, 17 Nov 2014 23:36:06 +0200
Message-Id: <1416260166-15110-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

---
 android/hal-handsfree-client.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/android/hal-handsfree-client.c b/android/hal-handsfree-client.c
index a152cab..63a8f1d 100644
--- a/android/hal-handsfree-client.c
+++ b/android/hal-handsfree-client.c
@@ -357,7 +357,6 @@ static bt_status_t init(bthf_client_callbacks_t *callbacks)
 
 	ret = hal_ipc_cmd(HAL_SERVICE_ID_CORE, HAL_OP_REGISTER_MODULE,
 					sizeof(cmd), &cmd, NULL, NULL, NULL);
-
 	if (ret != BT_STATUS_SUCCESS) {
 		cbs = NULL;
 		hal_ipc_unregister(HAL_SERVICE_ID_HANDSFREE_CLIENT);
-- 
2.1.0

