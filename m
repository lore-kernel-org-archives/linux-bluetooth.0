Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [PATCH 07/11] android/tester: Add HIDhost GetProtocol test
Date: Fri, 17 Jan 2014 01:25:47 +0200
Message-Id: <1389914751-18545-8-git-send-email-ravikumar.veeramally@linux.intel.com>
In-Reply-To: <1389914751-18545-1-git-send-email-ravikumar.veeramally@linux.intel.com>
References: <1389914751-18545-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/android-tester.c | 101 ++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 99 insertions(+), 2 deletions(-)

diff --git a/android/android-tester.c b/android/android-tester.c
index 2adbba1..56be850 100644
--- a/android/android-tester.c
+++ b/android/android-tester.c
@@ -3195,6 +3195,64 @@ static void setup_hidhost_interface(const void *test_data)
 	tester_setup_complete();
 }
 
+#define HID_GET_REPORT_PROTOCOL		0x60
+#define HID_GET_BOOT_PROTOCOL		0x61
+
+static void hid_prepare_reply_protocol_mode(const void *data, uint16_t len)
+{
+	struct test_data *t_data = tester_get_data();
+	struct bthost *bthost = hciemu_client_get_host(t_data->hciemu);
+	uint8_t pdu[2] = { 0, 0 };
+	uint16_t pdu_len = 0;
+
+	pdu_len = 2;
+	pdu[0] = 0xa0;
+	pdu[1] = 0x00;
+
+	bthost_send_cid(bthost, t_data->ctrl_handle, t_data->ctrl_cid,
+						(void *)pdu, pdu_len);
+}
+
+static void hid_intr_cid_hook_cb(const void *data, uint16_t len,
+							void *user_data)
+{
+}
+
+static void hid_intr_connect_cb(uint16_t handle, uint16_t cid, void *user_data)
+{
+	struct test_data *data = tester_get_data();
+	struct bthost *bthost = hciemu_client_get_host(data->hciemu);
+
+	data->intr_handle = handle;
+	data->intr_cid = cid;
+
+	bthost_add_cid_hook(bthost, handle, cid, hid_intr_cid_hook_cb, NULL);
+}
+
+static void hid_ctrl_cid_hook_cb(const void *data, uint16_t len,
+							void *user_data)
+{
+	uint8_t header = ((uint8_t *) data)[0];
+
+	switch (header) {
+	case HID_GET_REPORT_PROTOCOL:
+	case HID_GET_BOOT_PROTOCOL:
+		hid_prepare_reply_protocol_mode(data, len);
+		break;
+	}
+}
+
+static void hid_ctrl_connect_cb(uint16_t handle, uint16_t cid, void *user_data)
+{
+	struct test_data *data = tester_get_data();
+	struct bthost *bthost = hciemu_client_get_host(data->hciemu);
+
+	data->ctrl_handle = handle;
+	data->ctrl_cid = cid;
+
+	bthost_add_cid_hook(bthost, handle, cid, hid_ctrl_cid_hook_cb, NULL);
+}
+
 static void hid_sdp_cid_hook_cb(const void *data, uint16_t len, void *user_data)
 {
 	struct test_data *t_data = tester_get_data();
@@ -3308,9 +3366,9 @@ static void setup_hidhost_connect(const void *test_data)
 	/* Emulate SDP (PSM = 1) */
 	bthost_add_l2cap_server(bthost, 1, hid_sdp_search_cb, NULL);
 	/* Emulate Control Channel (PSM = 17) */
-	bthost_add_l2cap_server(bthost, 17, NULL, NULL);
+	bthost_add_l2cap_server(bthost, 17, hid_ctrl_connect_cb, NULL);
 	/* Emulate Interrupt Channel (PSM = 19) */
-	bthost_add_l2cap_server(bthost, 19, NULL, NULL);
+	bthost_add_l2cap_server(bthost, 19, hid_intr_connect_cb, NULL);
 
 	bthost_set_cmd_complete_cb(bthost, emu_powered_complete, data);
 	bthost_write_scan_enable(bthost, 0x03);
@@ -3354,6 +3412,41 @@ static void test_hidhost_virtual_unplug(const void *test_data)
 		tester_test_failed();
 }
 
+static void hid_protocol_mode_cb(bt_bdaddr_t *bd_addr, bthh_status_t status,
+						bthh_protocol_mode_t mode)
+{
+	struct test_data *data = tester_get_data();
+	const struct hidhost_generic_data *test = data->test_data;
+
+	if (data->cb_count == test->expected_cb_count &&
+					status == test->expected_status &&
+					mode == test->expected_protocol_mode)
+		tester_test_passed();
+	else
+		tester_test_failed();
+}
+
+static const struct hidhost_generic_data hidhost_test_get_protocol = {
+	.expected_hal_cb.protocol_mode_cb = hid_protocol_mode_cb,
+	.expected_cb_count = 1,
+	.expected_protocol_mode = BTHH_BOOT_MODE,
+	.expected_status = BTHH_OK,
+};
+
+static void test_hidhost_get_protocol(const void *test_data)
+{
+	struct test_data *data = tester_get_data();
+	const uint8_t *hid_addr = hciemu_get_client_bdaddr(data->hciemu);
+	bt_bdaddr_t bdaddr;
+	bt_status_t bt_status;
+
+	data->cb_count = 0;
+	bdaddr2android((const bdaddr_t *) hid_addr, &bdaddr);
+	bt_status = data->if_hid->get_protocol(&bdaddr, BTHH_REPORT_MODE);
+	if (bt_status != BT_STATUS_SUCCESS)
+		tester_test_failed();
+}
+
 #define test_bredrle(name, data, test_setup, test, test_teardown) \
 	do { \
 		struct test_data *user; \
@@ -3711,5 +3804,9 @@ int main(int argc, char *argv[])
 				&hidhost_test_disconnect, setup_hidhost_connect,
 				test_hidhost_virtual_unplug, teardown);
 
+	test_bredrle("HIDHost GetProtocol Success",
+			&hidhost_test_get_protocol, setup_hidhost_connect,
+				test_hidhost_get_protocol, teardown);
+
 	return tester_run();
 }
-- 
1.8.3.2

