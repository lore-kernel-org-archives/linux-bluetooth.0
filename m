Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv3 07/11] android: Use kernel style to initialize struct fields
Date: Wed, 16 Oct 2013 17:08:44 +0300
Message-Id: <1381932528-31584-8-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1381932528-31584-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1381833423-862-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1381932528-31584-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

---
 android/hal_bluetooth.c |   46 +++++++++++++++++++++++-----------------------
 1 file changed, 23 insertions(+), 23 deletions(-)

diff --git a/android/hal_bluetooth.c b/android/hal_bluetooth.c
index 9bb9dcf..89b8ebb 100644
--- a/android/hal_bluetooth.c
+++ b/android/hal_bluetooth.c
@@ -309,29 +309,29 @@ static int dut_mode_send(uint16_t opcode, uint8_t *buf, uint8_t len)
 }
 
 static const bt_interface_t bluetooth_if = {
-	sizeof(bt_interface_t),
-	init,
-	enable,
-	disable,
-	cleanup,
-	get_adapter_properties,
-	get_adapter_property,
-	set_adapter_property,
-	get_remote_device_properties,
-	get_remote_device_property,
-	set_remote_device_property,
-	get_remote_service_record,
-	get_remote_services,
-	start_discovery,
-	cancel_discovery,
-	create_bond,
-	remove_bond,
-	cancel_bond,
-	pin_reply,
-	ssp_reply,
-	get_profile_interface,
-	dut_mode_configure,
-	dut_mode_send
+	.size = sizeof(bt_interface_t),
+	.init = init,
+	.enable = enable,
+	.disable = disable,
+	.cleanup = cleanup,
+	.get_adapter_properties = get_adapter_properties,
+	.get_adapter_property = get_adapter_property,
+	.set_adapter_property = set_adapter_property,
+	.get_remote_device_properties = get_remote_device_properties,
+	.get_remote_device_property = get_remote_device_property,
+	.set_remote_device_property = set_remote_device_property,
+	.get_remote_service_record = get_remote_service_record,
+	.get_remote_services = get_remote_services,
+	.start_discovery = start_discovery,
+	.cancel_discovery = cancel_discovery,
+	.create_bond = create_bond,
+	.remove_bond = remove_bond,
+	.cancel_bond = cancel_bond,
+	.pin_reply = pin_reply,
+	.ssp_reply = ssp_reply,
+	.get_profile_interface = get_profile_interface,
+	.dut_mode_configure = dut_mode_configure,
+	.dut_mode_send = dut_mode_send
 };
 
 static const bt_interface_t *get_bluetooth_interface(void)
-- 
1.7.10.4

