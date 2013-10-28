Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/5] android/hal-pan: Add implementation of .init
Date: Mon, 28 Oct 2013 14:09:02 +0200
Message-Id: <1382962146-19587-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 android/hal-pan.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/android/hal-pan.c b/android/hal-pan.c
index 609bc1c..62fec00 100644
--- a/android/hal-pan.c
+++ b/android/hal-pan.c
@@ -20,6 +20,8 @@
 
 #include "hal-log.h"
 #include "hal.h"
+#include "hal-msg.h"
+#include "hal-ipc.h"
 
 static const btpan_callbacks_t *cbs = NULL;
 
@@ -77,15 +79,16 @@ static bt_status_t pan_disconnect(const bt_bdaddr_t *bd_addr)
 
 static bt_status_t pan_init(const btpan_callbacks_t *callbacks)
 {
+	struct hal_cmd_register_module cmd;
+
 	DBG("");
 
 	cbs = callbacks;
 
-	/* TODO: start HID Host thread */
-
-	/* TODO: enable service */
+	cmd.service_id = HAL_SERVICE_ID_PAN;
 
-	return BT_STATUS_SUCCESS;
+	return hal_ipc_cmd(HAL_SERVICE_ID_CORE, HAL_OP_REGISTER_MODULE,
+					sizeof(cmd), &cmd, 0, NULL, NULL);
 }
 
 static void pan_cleanup()
-- 
1.8.3.1

