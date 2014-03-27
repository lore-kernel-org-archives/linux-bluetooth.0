Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [PATCH_v3 3/7] android/tester: Add PAN Disconnect test case
Date: Thu, 27 Mar 2014 12:00:22 +0200
Message-Id: <1395914426-24249-4-git-send-email-ravikumar.veeramally@linux.intel.com>
In-Reply-To: <1395914426-24249-1-git-send-email-ravikumar.veeramally@linux.intel.com>
References: <1395914426-24249-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/android-tester.c | 79 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 79 insertions(+)

diff --git a/android/android-tester.c b/android/android-tester.c
index 4213793..82b0541 100644
--- a/android/android-tester.c
+++ b/android/android-tester.c
@@ -4932,6 +4932,81 @@ static void test_pan_connect(const void *test_data)
 	data->if_bluetooth->start_discovery();
 }
 
+static gboolean pan_disconnect_cb(gpointer user_data)
+{
+	struct test_data *data = tester_get_data();
+	const uint8_t *pan_addr = hciemu_get_client_bdaddr(data->hciemu);
+	bt_bdaddr_t bdaddr;
+	bt_status_t bt_status;
+
+	bdaddr2android((const bdaddr_t *) pan_addr, &bdaddr);
+	bt_status = data->if_pan->disconnect(&bdaddr);
+	if (bt_status != BT_STATUS_SUCCESS)
+		tester_test_failed();
+
+	g_atomic_int_dec_and_test(&scheduled_cbacks_num);
+	return FALSE;
+}
+
+static void pan_discon_connected_cb(btpan_connection_state_t state,
+				bt_status_t error, const bt_bdaddr_t *addr,
+				int local, int remote)
+{
+	struct test_data *data = tester_get_data();
+	const struct pan_generic_data *test = data->test_data;
+
+	switch (state) {
+	case BTPAN_STATE_CONNECTING:
+		data->cb_count++;
+		break;
+	case BTPAN_STATE_CONNECTED:
+		data->cb_count++;
+		if (data->cb_count == 6) {
+			g_atomic_int_inc(&scheduled_cbacks_num);
+			g_idle_add(pan_disconnect_cb, NULL);
+		}
+		break;
+	case BTPAN_STATE_DISCONNECTING:
+		data->cb_count++;
+		break;
+	case BTPAN_STATE_DISCONNECTED:
+		data->cb_count++;
+		if (data->cb_count == test->expected_cb_count &&
+				error == BT_STATUS_SUCCESS &&
+				local == BTPAN_ROLE_PANU &&
+				remote == BTPAN_ROLE_PANNAP)
+			tester_test_passed();
+		break;
+	}
+}
+
+static const struct pan_generic_data panu_test_disconnect = {
+	.expected_hal_cb.device_found_cb = pan_bond_device_found_cb,
+	.expected_hal_cb.bond_state_changed_cb =
+					pan_bond_state_bonded_changed_cb,
+	.expected_hal_cb.pin_request_cb = pan_bond_create_pin_request_cb,
+	.expected_cb_count = 7,
+	.expected_adapter_status = BT_STATUS_SUCCESS,
+	.expected_pan_hal_cb.connection_state_cb = pan_discon_connected_cb,
+};
+
+static void test_pan_disconnect(const void *test_data)
+{
+	struct test_data *data = tester_get_data();
+	struct bthost *bthost = hciemu_client_get_host(data->hciemu);
+	static uint8_t pair_device_pin[] = { 0x30, 0x30, 0x30, 0x30 };
+	const void *pin = pair_device_pin;
+	uint8_t pin_len = 4;
+
+	/* Emulate NAP (PSM = 15) */
+	bthost_add_l2cap_server(bthost, 15, pan_connect_request_cb, NULL);
+
+	data->test_checks_valid = true;
+	data->cb_count = 0;
+	bthost_set_pin_code(bthost, pin, pin_len);
+	data->if_bluetooth->start_discovery();
+}
+
 #define test_bredr(name, data, test_setup, test, test_teardown) \
 	do { \
 		struct test_data *user; \
@@ -5374,5 +5449,9 @@ int main(int argc, char *argv[])
 				&pan_test_connect, setup_pan,
 				test_pan_connect, teardown);
 
+	test_bredr("PAN Disconnect Success",
+				&panu_test_disconnect, setup_pan,
+				test_pan_disconnect, teardown);
+
 	return tester_run();
 }
-- 
1.8.3.2

