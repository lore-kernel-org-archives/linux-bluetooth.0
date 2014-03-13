Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [PATCH 3/7] android/tester: Add PAN Disconnect test case
Date: Thu, 13 Mar 2014 23:50:39 +0200
Message-Id: <1394747443-23220-4-git-send-email-ravikumar.veeramally@linux.intel.com>
In-Reply-To: <1394747443-23220-1-git-send-email-ravikumar.veeramally@linux.intel.com>
References: <1394747443-23220-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/android-tester.c | 69 ++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 67 insertions(+), 2 deletions(-)

diff --git a/android/android-tester.c b/android/android-tester.c
index d56cb0b..4506482 100644
--- a/android/android-tester.c
+++ b/android/android-tester.c
@@ -4914,7 +4914,68 @@ static const struct pan_generic_data pan_test_connect = {
 	.expected_pan_hal_cb.connection_state_cb = pan_connected_cb,
 };
 
-static void test_panu_connect(const void *test_data)
+static void test_pan_connect(const void *test_data)
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
+	data->test_init_done = true;
+	data->cb_count = 0;
+	bthost_set_pin_code(bthost, pin, pin_len);
+	data->if_bluetooth->start_discovery();
+}
+
+static void pan_disconnected_cb(btpan_connection_state_t state,
+				bt_status_t error, const bt_bdaddr_t *addr,
+				int local, int remote)
+{
+	struct test_data *data = tester_get_data();
+	const struct pan_generic_data *test = data->test_data;
+	const uint8_t *pan_addr = hciemu_get_client_bdaddr(data->hciemu);
+	bt_bdaddr_t bdaddr;
+	bt_status_t bt_status;
+
+	switch (state) {
+	case BTPAN_STATE_CONNECTING:
+		data->cb_count++;
+		break;
+	case BTPAN_STATE_CONNECTED:
+		data->cb_count++;
+		if (data->cb_count == 6) {
+			bdaddr2android((const bdaddr_t *) pan_addr, &bdaddr);
+			bt_status = data->if_pan->disconnect(&bdaddr);
+			if (bt_status != BT_STATUS_SUCCESS)
+				tester_test_failed();
+		}
+		break;
+	case BTPAN_STATE_DISCONNECTING:
+		data->cb_count++;
+		break;
+	case BTPAN_STATE_DISCONNECTED:
+		data->cb_count++;
+		if (data->cb_count == test->expected_cb_count)
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
+	.expected_pan_hal_cb.connection_state_cb = pan_disconnected_cb,
+};
+
+static void test_pan_disconnect(const void *test_data)
 {
 	struct test_data *data = tester_get_data();
 	struct bthost *bthost = hciemu_client_get_host(data->hciemu);
@@ -5371,7 +5432,11 @@ int main(int argc, char *argv[])
 
 	test_bredr("PAN Connect Success",
 				&pan_test_connect, setup_pan,
-				test_panu_connect, teardown);
+				test_pan_connect, teardown);
+
+	test_bredr("PAN Disconnect Success",
+				&panu_test_disconnect, setup_pan,
+				test_pan_disconnect, teardown);
 
 	return tester_run();
 }
-- 
1.8.3.2

