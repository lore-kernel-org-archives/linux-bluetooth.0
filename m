Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/3] android/tester: Enable bthost after device is enabled
Date: Wed, 18 Dec 2013 10:55:13 +0200
Message-Id: <1387356913-32666-3-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1387356913-32666-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1387356913-32666-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

This puts bthost to connectible mode allowing us to use powered setup
for connect to emulated device.
---
 android/android-tester.c | 43 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 42 insertions(+), 1 deletion(-)

diff --git a/android/android-tester.c b/android/android-tester.c
index 423dd6a..736cd70 100644
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
 #define ADAPTER_PROPS ADAPTER_PROP_BDADDR, ADAPTER_PROP_BDNAME, \
 			ADAPTER_PROP_UUIDS, ADAPTER_PROP_COD, \
 			ADAPTER_PROP_TYPE, ADAPTER_PROP_SCAN_MODE, \
@@ -466,12 +471,48 @@ failed:
 		close(fd);
 }
 
+static void emu_connectable_complete(uint16_t opcode, uint8_t status,
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
+	tester_print("Emulated remote set connectable status 0x%02x", status);
+
+	if (status)
+		tester_setup_failed();
+	else
+		tester_setup_complete();
+}
+
+static void setup_powered_emulated_remote(void)
+{
+	struct test_data *data = tester_get_data();
+	struct bthost *bthost;
+
+	tester_print("Controller powered on");
+
+	bthost = hciemu_client_get_host(data->hciemu);
+	bthost_set_cmd_complete_cb(bthost, emu_connectable_complete, data);
+
+	if (data->hciemu_type == HCIEMU_TYPE_LE)
+		bthost_set_adv_enable(bthost, 0x01);
+	else
+		bthost_write_scan_enable(bthost, 0x03);
+}
+
 static void adapter_state_changed_cb(bt_state_t state)
 {
 	switch (state) {
 	case BT_STATE_ON:
 		if (is_empty_halcb_list())
-			tester_setup_complete();
+			setup_powered_emulated_remote();
 		update_hal_cb_list(ADAPTER_STATE_CHANGED_ON);
 		break;
 	case BT_STATE_OFF:
-- 
1.8.3.2

