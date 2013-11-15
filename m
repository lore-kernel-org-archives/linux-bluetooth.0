Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/3] android/hal: Unregister Bluetooth on cleanup
Date: Fri, 15 Nov 2013 12:13:55 +0200
Message-Id: <1384510435-17497-3-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1384510435-17497-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1384510435-17497-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

---
 This is more like RFC. Shall we send this event or this will be cleaned up itself.

 android/hal-bluetooth.c |    7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/android/hal-bluetooth.c b/android/hal-bluetooth.c
index 8cd4327..4bf1183 100644
--- a/android/hal-bluetooth.c
+++ b/android/hal-bluetooth.c
@@ -379,11 +379,18 @@ static int disable(void)
 
 static void cleanup(void)
 {
+	struct hal_cmd_register_module cmd;
+
 	DBG("");
 
 	if (!interface_ready())
 		return;
 
+	cmd.service_id = HAL_SERVICE_ID_BLUETOOTH;
+
+	hal_ipc_cmd(HAL_SERVICE_ID_CORE, HAL_OP_UNREGISTER_MODULE,
+					sizeof(cmd), &cmd, NULL, NULL, NULL);
+
 	hal_ipc_cleanup();
 
 	bt_hal_cbacks = NULL;
-- 
1.7.10.4

