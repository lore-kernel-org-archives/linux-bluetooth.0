Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] android/hidhost: Fix not unregistering HID
Date: Thu, 31 Oct 2013 15:51:54 +0200
Message-Id: <1383227514-22944-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

If HID is not unregistered it cannot be registered again and we get
following error:
...
E/BluetoothHidServiceJni( 2849): Failed to initialize Bluetooth HID, status: 1
...
---
 android/hal-hidhost.c |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/android/hal-hidhost.c b/android/hal-hidhost.c
index a72410b..a81fea5 100644
--- a/android/hal-hidhost.c
+++ b/android/hal-hidhost.c
@@ -301,12 +301,17 @@ static bt_status_t hh_init(bthh_callbacks_t *callbacks)
 
 static void hh_cleanup(void)
 {
+	struct hal_cmd_unregister_module cmd;
+
 	DBG("");
 
 	if (!interface_ready())
 		return;
 
 	bt_hh_cbacks = NULL;
+
+	hal_ipc_cmd(HAL_SERVICE_ID_CORE, HAL_OP_UNREGISTER_MODULE,
+					sizeof(cmd), &cmd, 0, NULL, NULL);
 }
 
 static bthh_interface_t hh_if = {
-- 
1.7.10.4

