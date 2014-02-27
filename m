Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 6/9] android/tester: Add create bond with no discovery test case
Date: Thu, 27 Feb 2014 16:04:47 +0100
Message-Id: <1393513490-18674-6-git-send-email-grzegorz.kolodziejczyk@tieto.com>
In-Reply-To: <1393513490-18674-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1393513490-18674-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This adds create bond with no discovery before create bond as NFC does.
SSP with confirm as authentication mode.
---
 android/android-tester.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/android/android-tester.c b/android/android-tester.c
index f82025e..e27c212 100644
--- a/android/android-tester.c
+++ b/android/android-tester.c
@@ -2415,6 +2415,13 @@ static const struct generic_data bt_bond_create_ssp_fail_test = {
 	.expected_adapter_status = MGMT_STATUS_AUTH_FAILED,
 };
 
+static const struct generic_data bt_bond_create_no_disc_success_test = {
+	.expected_hal_cb.bond_state_changed_cb = bond_test_state_changed_cb,
+	.expected_hal_cb.ssp_request_cb = bond_create_ssp_success_request_cb,
+	.expected_cb_count = 3,
+	.expected_adapter_status = BT_STATUS_SUCCESS,
+};
+
 static bt_callbacks_t bt_callbacks = {
 	.size = sizeof(bt_callbacks),
 	.adapter_state_changed_cb = adapter_state_changed_cb,
@@ -3227,6 +3234,25 @@ static void test_bond_create_ssp_fail(const void *test_data)
 	data->if_bluetooth->start_discovery();
 }
 
+static void test_bond_create_no_disc_success(const void *test_data)
+{
+	struct test_data *data = tester_get_data();
+	struct bthost *bthost = hciemu_client_get_host(data->hciemu);
+
+	uint8_t *bdaddr = (uint8_t *)hciemu_get_client_bdaddr(data->hciemu);
+	bt_bdaddr_t remote_addr;
+	bt_status_t status;
+
+	init_test_conditions(data);
+
+	bdaddr2android((const bdaddr_t *)bdaddr, &remote_addr.address);
+
+	bthost_write_ssp_mode(bthost, 0x01);
+
+	status = data->if_bluetooth->create_bond(&remote_addr);
+	check_expected_status(status);
+}
+
 /* Test Socket HAL */
 
 static gboolean adapter_socket_state_changed(gpointer user_data)
@@ -4585,6 +4611,11 @@ int main(int argc, char *argv[])
 					setup_enabled_adapter,
 					test_bond_create_ssp_fail, teardown);
 
+	test_bredrle("Bluetooth Create Bond - No Discovery",
+				&bt_bond_create_no_disc_success_test,
+				setup_enabled_adapter,
+				test_bond_create_no_disc_success, teardown);
+
 	test_bredrle("Socket Init", NULL, setup_socket_interface,
 						test_dummy, teardown);
 
-- 
1.8.5.2

