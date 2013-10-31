Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/2] android/hidhost: Fix not unregistering HID
Date: Thu, 31 Oct 2013 16:45:04 +0200
Message-Id: <1383230705-18110-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

If HID is not unregistered it cannot be registered again and we get
following error:
...
E/BluetoothHidServiceJni( 2849): Failed to initialize Bluetooth HID, status: 1
...
---
 android/hal-hidhost.c |    7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/android/hal-hidhost.c b/android/hal-hidhost.c
index a72410b..e148dc2 100644
--- a/android/hal-hidhost.c
+++ b/android/hal-hidhost.c
@@ -301,12 +301,19 @@ static bt_status_t hh_init(bthh_callbacks_t *callbacks)
 
 static void hh_cleanup(void)
 {
+	struct hal_cmd_unregister_module cmd;
+
 	DBG("");
 
 	if (!interface_ready())
 		return;
 
 	bt_hh_cbacks = NULL;
+
+	cmd.service_id = HAL_SERVICE_ID_HIDHOST;
+
+	hal_ipc_cmd(HAL_SERVICE_ID_CORE, HAL_OP_UNREGISTER_MODULE,
+					sizeof(cmd), &cmd, 0, NULL, NULL);
 }
 
 static bthh_interface_t hh_if = {
-- 
1.7.10.4

