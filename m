Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [PATCH 04/11] android/tester: Add HIDhost Connect test
Date: Fri, 17 Jan 2014 01:25:44 +0200
Message-Id: <1389914751-18545-5-git-send-email-ravikumar.veeramally@linux.intel.com>
In-Reply-To: <1389914751-18545-1-git-send-email-ravikumar.veeramally@linux.intel.com>
References: <1389914751-18545-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Emulated HID SDP and L2CAP Control and Interrupt channels.
---
 android/android-tester.c | 231 +++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 221 insertions(+), 10 deletions(-)

diff --git a/android/android-tester.c b/android/android-tester.c
index 6f0e962..0888a68 100644
--- a/android/android-tester.c
+++ b/android/android-tester.c
@@ -69,6 +69,16 @@ struct socket_data {
 	bool test_channel;
 };
 
+struct hidhost_generic_data {
+	bthh_status_t expected_status;
+	int expected_conn_state;
+	int expected_cb_count;
+	bthh_protocol_mode_t expected_protocol_mode;
+	int expected_report;
+	bthh_callbacks_t expected_hal_cb;
+	int expected_report_size;
+};
+
 #define WAIT_FOR_SIGNAL_TIME 2 /* in seconds */
 #define EMULATOR_SIGNAL "emulator_started"
 
@@ -97,6 +107,14 @@ struct test_data {
 
 	int cb_count;
 	GSList *expected_properties_list;
+
+	/* hidhost */
+	uint16_t sdp_handle;
+	uint16_t sdp_cid;
+	uint16_t ctrl_handle;
+	uint16_t ctrl_cid;
+	uint16_t intr_handle;
+	uint16_t intr_cid;
 };
 
 static char exec_dir[PATH_MAX + 1];
@@ -1933,15 +1951,6 @@ static bt_callbacks_t bt_callbacks = {
 	.le_test_mode_cb = NULL
 };
 
-static bthh_callbacks_t bthh_callbacks = {
-	.size = sizeof(bthh_callbacks),
-	.connection_state_cb = NULL,
-	.hid_info_cb = NULL,
-	.protocol_mode_cb = NULL,
-	.idle_time_cb = NULL,
-	.get_report_cb = NULL,
-	.virtual_unplug_cb = NULL
-};
 
 static void setup(struct test_data *data)
 {
@@ -3076,7 +3085,80 @@ clean:
 		close(sock_fd);
 }
 
-static void setup_hidhost_interface(const void *test_data)
+static void hidhost_connection_state_cb(bt_bdaddr_t *bd_addr,
+						bthh_connection_state_t state)
+{
+	struct test_data *data = tester_get_data();
+	const struct hidhost_generic_data *test = data->test_data;
+
+	data->cb_count++;
+
+	if (state == BTHH_CONN_STATE_CONNECTED)
+		tester_setup_complete();
+
+	if (test && test->expected_hal_cb.connection_state_cb)
+		test->expected_hal_cb.connection_state_cb(bd_addr, state);
+}
+
+static void hidhost_virual_unplug_cb(bt_bdaddr_t *bd_addr, bthh_status_t status)
+{
+	struct test_data *data = tester_get_data();
+	const struct hidhost_generic_data *test = data->test_data;
+
+	data->cb_count++;
+
+	if (test && test->expected_hal_cb.virtual_unplug_cb)
+		test->expected_hal_cb.virtual_unplug_cb(bd_addr, status);
+}
+
+static void hidhost_hid_info_cb(bt_bdaddr_t *bd_addr, bthh_hid_info_t hid)
+{
+	struct test_data *data = tester_get_data();
+	const struct hidhost_generic_data *test = data->test_data;
+
+	data->cb_count++;
+
+	if (test && test->expected_hal_cb.hid_info_cb)
+		test->expected_hal_cb.hid_info_cb(bd_addr, hid);
+}
+
+static void hidhost_protocol_mode_cb(bt_bdaddr_t *bd_addr,
+						bthh_status_t status,
+						bthh_protocol_mode_t mode)
+{
+	struct test_data *data = tester_get_data();
+	const struct hidhost_generic_data *test = data->test_data;
+
+	data->cb_count++;
+
+	if (test && test->expected_hal_cb.protocol_mode_cb)
+		test->expected_hal_cb.protocol_mode_cb(bd_addr, status, mode);
+}
+
+static void hidhost_get_report_cb(bt_bdaddr_t *bd_addr, bthh_status_t status,
+						uint8_t *report, int size)
+{
+	struct test_data *data = tester_get_data();
+	const struct hidhost_generic_data *test = data->test_data;
+
+	data->cb_count++;
+
+	if (test && test->expected_hal_cb.get_report_cb)
+		test->expected_hal_cb.get_report_cb(bd_addr, status, report,
+									size);
+}
+
+static bthh_callbacks_t bthh_callbacks = {
+	.size = sizeof(bthh_callbacks),
+	.connection_state_cb = hidhost_connection_state_cb,
+	.hid_info_cb = hidhost_hid_info_cb,
+	.protocol_mode_cb = hidhost_protocol_mode_cb,
+	.idle_time_cb = NULL,
+	.get_report_cb = hidhost_get_report_cb,
+	.virtual_unplug_cb = hidhost_virual_unplug_cb
+};
+
+static void setup_hidhost(const void *test_data)
 {
 	struct test_data *data = tester_get_data();
 	bt_status_t status;
@@ -3105,10 +3187,135 @@ static void setup_hidhost_interface(const void *test_data)
 		tester_setup_failed();
 		return;
 	}
+}
 
+static void setup_hidhost_interface(const void *test_data)
+{
+	setup_hidhost(test_data);
 	tester_setup_complete();
 }
 
+static void hid_sdp_cid_hook_cb(const void *data, uint16_t len, void *user_data)
+{
+	struct test_data *t_data = tester_get_data();
+	struct bthost *bthost = hciemu_client_get_host(t_data->hciemu);
+	uint8_t pdu[] = { 0x07, /* PDU id */
+				0x00, 0x00, /* Transaction id */
+				0x01, 0x71, /* Response length */
+				0x01, 0x6E, /* Attributes length */
+				0x36, 0x01, 0x6b, 0x36, 0x01, 0x68, 0x09, 0x00,
+				0x00, 0x0a, 0x00, 0x01, 0x00, 0x00, 0x09, 0x00,
+				0x01, 0x35, 0x03, 0x19, 0x11, 0x24, 0x09, 0x00,
+				0x04, 0x35, 0x0d, 0x35, 0x06, 0x19, 0x01, 0x00,
+				0x09, 0x00, 0x11, 0x35, 0x03, 0x19, 0x00, 0x11,
+				0x09, 0x00, 0x05, 0x35, 0x03, 0x19, 0x10, 0x02,
+				0x09, 0x00, 0x06, 0x35, 0x09, 0x09, 0x65, 0x6e,
+				0x09, 0x00, 0x6a, 0x09, 0x01, 0x00, 0x09, 0x00,
+				0x09, 0x35, 0x08, 0x35, 0x06, 0x19, 0x11, 0x24,
+				0x09, 0x01, 0x00, 0x09, 0x00, 0x0d, 0x35, 0x0f,
+				0x35, 0x0d, 0x35, 0x06, 0x19, 0x01, 0x00, 0x09,
+				0x00, 0x13, 0x35, 0x03, 0x19, 0x00, 0x11, 0x09,
+				0x01, 0x00, 0x25, 0x1e, 0x4c, 0x6f, 0x67, 0x69,
+				0x74, 0x65, 0x63, 0x68, 0x20, 0x42, 0x6c, 0x75,
+				0x65, 0x74, 0x6f, 0x6f, 0x74, 0x68, 0x20, 0x4d,
+				0x6f, 0x75, 0x73, 0x65, 0x20, 0x4d, 0x35, 0x35,
+				0x35, 0x62, 0x09, 0x01, 0x01, 0x25, 0x0f, 0x42,
+				0x6c, 0x75, 0x65, 0x74, 0x6f, 0x6f, 0x74, 0x68,
+				0x20, 0x4d, 0x6f, 0x75, 0x73, 0x65, 0x09, 0x01,
+				0x02, 0x25, 0x08, 0x4c, 0x6f, 0x67, 0x69, 0x74,
+				0x65, 0x63, 0x68, 0x09, 0x02, 0x00, 0x09, 0x01,
+				0x00, 0x09, 0x02, 0x01, 0x09, 0x01, 0x11, 0x09,
+				0x02, 0x02, 0x08, 0x80, 0x09, 0x02, 0x03, 0x08,
+				0x21, 0x09, 0x02, 0x04, 0x28, 0x01, 0x09, 0x02,
+				0x05, 0x28, 0x01, 0x09, 0x02, 0x06, 0x35, 0x74,
+				0x35, 0x72, 0x08, 0x22, 0x25, 0x6e, 0x05, 0x01,
+				0x09, 0x02, 0xa1, 0x01, 0x85, 0x02, 0x09, 0x01,
+				0xa1, 0x00, 0x05, 0x09, 0x19, 0x01, 0x29, 0x08,
+				0x15, 0x00, 0x25, 0x01, 0x75, 0x01, 0x95, 0x08,
+				0x81, 0x02, 0x05, 0x01, 0x09, 0x30, 0x09, 0x31,
+				0x16, 0x01, 0xf8, 0x26, 0xff, 0x07, 0x75, 0x0c,
+				0x95, 0x02, 0x81, 0x06, 0x09, 0x38, 0x15, 0x81,
+				0x25, 0x7f, 0x75, 0x08, 0x95, 0x01, 0x81, 0x06,
+				0x05, 0x0c, 0x0a, 0x38, 0x02, 0x81, 0x06, 0x05,
+				0x09, 0x19, 0x09, 0x29, 0x10, 0x15, 0x00, 0x25,
+				0x01, 0x95, 0x08, 0x75, 0x01, 0x81, 0x02, 0xc0,
+				0xc0, 0x06, 0x00, 0xff, 0x09, 0x01, 0xa1, 0x01,
+				0x85, 0x10, 0x75, 0x08, 0x95, 0x06, 0x15, 0x00,
+				0x26, 0xff, 0x00, 0x09, 0x01, 0x81, 0x00, 0x09,
+				0x01, 0x91, 0x00, 0xc0, 0x09, 0x02, 0x07, 0x35,
+				0x08, 0x35, 0x06, 0x09, 0x04, 0x09, 0x09, 0x01,
+				0x00, 0x09, 0x02, 0x08, 0x28, 0x00, 0x09, 0x02,
+				0x09, 0x28, 0x01, 0x09, 0x02, 0x0a, 0x28, 0x01,
+				0x09, 0x02, 0x0b, 0x09, 0x01, 0x00, 0x09, 0x02,
+				0x0c, 0x09, 0x0c, 0x80, 0x09, 0x02, 0x0d, 0x28,
+				0x00, 0x09, 0x02, 0x0e, 0x28, 0x01,
+				0x00 /* no continuation */};
+
+	bthost_send_cid(bthost, t_data->sdp_handle, t_data->sdp_cid,
+						(void *)pdu, sizeof(pdu));
+}
+
+static void hid_sdp_search_cb(uint16_t handle, uint16_t cid, void *user_data)
+{
+	struct test_data *data = tester_get_data();
+	struct bthost *bthost = hciemu_client_get_host(data->hciemu);
+
+	data->sdp_handle = handle;
+	data->sdp_cid = cid;
+
+	bthost_add_cid_hook(bthost, handle, cid, hid_sdp_cid_hook_cb, NULL);
+}
+
+static void emu_powered_complete(uint16_t opcode, uint8_t status,
+					const void *param, uint8_t len,
+					void *user_data)
+{
+	struct test_data *data = tester_get_data();
+	const uint8_t *hid_addr = hciemu_get_client_bdaddr(data->hciemu);
+	bt_bdaddr_t bdaddr;
+	bt_status_t bt_status;
+
+	switch (opcode) {
+	case BT_HCI_CMD_WRITE_SCAN_ENABLE:
+	case BT_HCI_CMD_LE_SET_ADV_ENABLE:
+		break;
+	default:
+		return;
+	}
+
+	if (status) {
+		tester_setup_failed();
+		return;
+	}
+
+	data->cb_count = 0;
+	bdaddr2android((const bdaddr_t *) hid_addr, &bdaddr);
+	bt_status = data->if_hid->connect(&bdaddr);
+	if (bt_status != BT_STATUS_SUCCESS)
+		tester_setup_failed();
+
+}
+
+static void setup_hidhost_connect(const void *test_data)
+{
+	struct test_data *data = tester_get_data();
+	struct bthost *bthost;
+
+	setup_hidhost(test_data);
+
+	bthost = hciemu_client_get_host(data->hciemu);
+
+	/* Emulate SDP (PSM = 1) */
+	bthost_add_l2cap_server(bthost, 1, hid_sdp_search_cb, NULL);
+	/* Emulate Control Channel (PSM = 17) */
+	bthost_add_l2cap_server(bthost, 17, NULL, NULL);
+	/* Emulate Interrupt Channel (PSM = 19) */
+	bthost_add_l2cap_server(bthost, 19, NULL, NULL);
+
+	bthost_set_cmd_complete_cb(bthost, emu_powered_complete, data);
+	bthost_write_scan_enable(bthost, 0x03);
+}
+
 #define test_bredrle(name, data, test_setup, test, test_teardown) \
 	do { \
 		struct test_data *user; \
@@ -3454,5 +3661,9 @@ int main(int argc, char *argv[])
 	test_bredrle("HIDHost Init", NULL, setup_hidhost_interface,
 						test_dummy, teardown);
 
+	test_bredrle("HIDHost Connect Success",
+				NULL, setup_hidhost_connect,
+				test_dummy, teardown);
+
 	return tester_run();
 }
-- 
1.8.3.2

