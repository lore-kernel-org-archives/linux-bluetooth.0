Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv1 03/47] android/hal-bluetooth: Add missing functions
Date: Tue,  4 Nov 2014 10:18:26 +0200
Message-Id: <1415089150-18798-4-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1415089150-18798-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1415089150-18798-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Add missing HAL functions for new Android version
---
 android/hal-bluetooth.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/android/hal-bluetooth.c b/android/hal-bluetooth.c
index 5b6e99d..bbbdc37 100644
--- a/android/hal-bluetooth.c
+++ b/android/hal-bluetooth.c
@@ -948,6 +948,35 @@ static int config_hci_snoop_log(uint8_t enable)
 	return BT_STATUS_SUCCESS;
 }
 
+#if ANDROID_VERSION > PLATFORM_VER(4, 4, 4)
+static int get_connection_state(const bt_bdaddr_t *bd_addr)
+{
+	DBG("bdaddr: %s", bdaddr2str(bd_addr));
+
+	/* TODO: implement */
+
+	return BT_STATUS_UNSUPPORTED;
+}
+
+static int set_os_callouts(bt_os_callouts_t *callouts)
+{
+	DBG("callouts: %p", callouts);
+
+	/* TODO: implement */
+
+	return BT_STATUS_SUCCESS;
+}
+
+static int read_energy_info(void)
+{
+	DBG("");
+
+	/* TODO: implement */
+
+	return BT_STATUS_UNSUPPORTED;
+}
+#endif
+
 static const bt_interface_t bluetooth_if = {
 	.size = sizeof(bt_interface_t),
 	.init = init,
@@ -974,6 +1003,11 @@ static const bt_interface_t bluetooth_if = {
 	.dut_mode_send = dut_mode_send,
 	.le_test_mode = le_test_mode,
 	.config_hci_snoop_log = config_hci_snoop_log,
+#if ANDROID_VERSION > PLATFORM_VER(4, 4, 4)
+	.get_connection_state = get_connection_state,
+	.set_os_callouts = set_os_callouts,
+	.read_energy_info = read_energy_info,
+#endif
 };
 
 static const bt_interface_t *get_bluetooth_interface(void)
-- 
1.9.1

