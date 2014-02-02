Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
Subject: [PATCH 09/11] android/tester: Add remove bond success test case
Date: Sun, 2 Feb 2014 12:16:39 +0100
Message-ID: <1391339801-587-10-git-send-email-andrzej.kaczmarek@tieto.com>
In-Reply-To: <1391339801-587-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1391339801-587-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>

This adds remove bond success test case. SSP as pairing mode.
---
 android/android-tester.c | 49 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/android/android-tester.c b/android/android-tester.c
index b7abc24..a6ec9a4 100644
--- a/android/android-tester.c
+++ b/android/android-tester.c
@@ -961,6 +961,29 @@ static void bond_test_state_changed_cb(bt_status_t status,
 	}
 }
 
+static void bond_remove_success_state_changed_cb(bt_status_t status,
+			bt_bdaddr_t *remote_bd_addr, bt_bond_state_t state)
+{
+	struct test_data *data = tester_get_data();
+	bt_status_t remove_status;
+	uint8_t *bdaddr = (uint8_t *)hciemu_get_client_bdaddr(data->hciemu);
+	bt_bdaddr_t remote_addr;
+
+	bdaddr2android((const bdaddr_t *)bdaddr, &remote_addr.address);
+
+	if (state == BT_BOND_STATE_BONDED) {
+		data->cb_count--;
+		remove_status = data->if_bluetooth->remove_bond(&remote_addr);
+		check_expected_status(remove_status);
+		return;
+	}
+
+	if (state == BT_BOND_STATE_NONE) {
+		data->cb_count--;
+		check_cb_count();
+	}
+}
+
 static void bond_state_changed_cb(bt_status_t status,
 			bt_bdaddr_t *remote_bd_addr, bt_bond_state_t state)
 {
@@ -2185,6 +2208,15 @@ static const struct generic_data bt_bond_cancel_success_test = {
 	.expected_adapter_status = BT_STATUS_SUCCESS,
 };
 
+static const struct generic_data bt_bond_remove_success_test = {
+	.expected_hal_cb.device_found_cb = bond_nostatus_device_found_cb,
+	.expected_hal_cb.bond_state_changed_cb =
+					bond_remove_success_state_changed_cb,
+	.expected_hal_cb.ssp_request_cb = bond_create_ssp_success_request_cb,
+	.expected_cb_count = 4,
+	.expected_adapter_status = BT_STATUS_SUCCESS,
+};
+
 static bt_callbacks_t bt_callbacks = {
 	.size = sizeof(bt_callbacks),
 	.adapter_state_changed_cb = adapter_state_changed_cb,
@@ -3043,6 +3075,18 @@ static void test_bond_cancel_success(const void *test_data)
 	data->if_bluetooth->start_discovery();
 }
 
+static void test_bond_remove_success(const void *test_data)
+{
+	struct test_data *data = tester_get_data();
+	struct bthost *bthost = hciemu_client_get_host(data->hciemu);
+
+	init_test_conditions(data);
+
+	bthost_write_ssp_mode(bthost, 0x01);
+
+	data->if_bluetooth->start_discovery();
+}
+
 /* Test Socket HAL */
 
 static void adapter_socket_state_changed_cb(bt_state_t state)
@@ -4310,6 +4354,11 @@ int main(int argc, char *argv[])
 					setup_enabled_adapter,
 					test_bond_cancel_success, teardown);
 
+	test_bredrle("Bluetooth Remove Bond - Success",
+					&bt_bond_remove_success_test,
+					setup_enabled_adapter,
+					test_bond_remove_success, teardown);
+
 	test_bredrle("Socket Init", NULL, setup_socket_interface,
 						test_dummy, teardown);
 
-- 
1.8.5.2

