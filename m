Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/2] android/tester: Enable bthost after device is enabled
Date: Mon, 16 Dec 2013 16:52:48 +0200
Message-Id: <1387205568-14461-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1387205568-14461-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1387205568-14461-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

This puts bthost to connectible mode allowing us to use powered setup
for connect to emulated device.
---
 android/android-tester.c | 43 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 42 insertions(+), 1 deletion(-)

diff --git a/android/android-tester.c b/android/android-tester.c
index 2a8c8d0..d0d3690 100644
--- a/android/android-tester.c
+++ b/android/android-tester.c
@@ -33,10 +33,15 @@
 #include "src/shared/mgmt.h"
 #include "src/shared/hciemu.h"
 
+#include "emulator/bthost.h"
+#include "monitor/bt.h"
+
 #include <hardware/hardware.h>
 #include <hardware/bluetooth.h>
 #include <hardware/bt_sock.h>
 
+#include "utils.h"
+
 #define adapter_props adapter_prop_bdaddr, adapter_prop_bdname, \
 			adapter_prop_uuids, adapter_prop_cod, \
 			adapter_prop_type, adapter_prop_scan_mode, \
@@ -463,6 +468,42 @@ failed:
 		close(fd);
 }
 
+static void client_connectable_complete(uint16_t opcode, uint8_t status,
+					const void *param, uint8_t len,
+					void *user_data)
+{
+	switch (opcode) {
+	case BT_HCI_CMD_WRITE_SCAN_ENABLE:
+	case BT_HCI_CMD_LE_SET_ADV_ENABLE:
+		break;
+	default:
+		return;
+	}
+
+	tester_print("Client set connectable status 0x%02x", status);
+
+	if (status)
+		tester_setup_failed();
+	else
+		tester_setup_complete();
+}
+
+static void setup_powered_client(void)
+{
+	struct test_data *data = tester_get_data();
+	struct bthost *bthost;
+
+	tester_print("Controller powered on");
+
+	bthost = hciemu_client_get_host(data->hciemu);
+	bthost_set_cmd_complete_cb(bthost, client_connectable_complete, data);
+
+	if (data->hciemu_type == HCIEMU_TYPE_LE)
+		bthost_set_adv_enable(bthost, 0x01);
+	else
+		bthost_write_scan_enable(bthost, 0x03);
+}
+
 static void adapter_state_changed_cb(bt_state_t state)
 {
 	enum hal_bluetooth_callbacks_id hal_cb;
@@ -484,7 +525,7 @@ static void adapter_state_changed_cb(bt_state_t state)
 		break;
 	case adapter_test_setup_mode:
 		if (state == BT_STATE_ON)
-			tester_setup_complete();
+			setup_powered_client();
 		else
 			tester_setup_failed();
 		break;
-- 
1.8.3.2

