Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [PATCH_v2 2/2] android/tester: Add HIDhost GetReport test
Date: Tue, 21 Jan 2014 14:24:19 +0200
Message-Id: <1390307059-7772-2-git-send-email-ravikumar.veeramally@linux.intel.com>
In-Reply-To: <1390307059-7772-1-git-send-email-ravikumar.veeramally@linux.intel.com>
References: <1390307059-7772-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/android-tester.c | 64 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/android/android-tester.c b/android/android-tester.c
index 9a17612..e0b4579 100644
--- a/android/android-tester.c
+++ b/android/android-tester.c
@@ -3206,6 +3206,10 @@ static void setup_hidhost_interface(const void *test_data)
 
 #define HID_SEND_DATA			0xa2
 
+#define HID_GET_INPUT_REPORT		0x49
+#define HID_GET_OUTPUT_REPORT		0x4a
+#define HID_GET_FEATURE_REPORT		0x4b
+
 static void hid_prepare_reply_protocol_mode(const void *data, uint16_t len)
 {
 	struct test_data *t_data = tester_get_data();
@@ -3221,6 +3225,22 @@ static void hid_prepare_reply_protocol_mode(const void *data, uint16_t len)
 						(void *)pdu, pdu_len);
 }
 
+static void hid_prepare_reply_report(const void *data, uint16_t len)
+{
+	struct test_data *t_data = tester_get_data();
+	struct bthost *bthost = hciemu_client_get_host(t_data->hciemu);
+	uint8_t pdu[3] = { 0, 0, 0 };
+	uint16_t pdu_len = 0;
+
+	pdu_len = 3;
+	pdu[0] = 0xa2;
+	pdu[1] = 0x01;
+	pdu[2] = 0x00;
+
+	bthost_send_cid(bthost, t_data->ctrl_handle, t_data->ctrl_cid,
+						(void *)pdu, pdu_len);
+}
+
 static void hid_intr_cid_hook_cb(const void *data, uint16_t len,
 							void *user_data)
 {
@@ -3255,6 +3275,11 @@ static void hid_ctrl_cid_hook_cb(const void *data, uint16_t len,
 	case HID_SET_BOOT_PROTOCOL:
 		hid_prepare_reply_protocol_mode(data, len);
 		break;
+	case HID_GET_INPUT_REPORT:
+	case HID_GET_OUTPUT_REPORT:
+	case HID_GET_FEATURE_REPORT:
+		hid_prepare_reply_report(data, len);
+		break;
 	/* HID device doesnot reply for this commads, so reaching pdu's
 	 * to hid device means assuming test passed */
 	case HID_SET_INPUT_REPORT:
@@ -3514,6 +3539,41 @@ static void test_hidhost_send_data(const void *test_data)
 		tester_test_failed();
 }
 
+static void hid_get_report_cb(bt_bdaddr_t *bd_addr, bthh_status_t status,
+						uint8_t *report, int size)
+{
+	struct test_data *data = tester_get_data();
+	const struct hidhost_generic_data *test = data->test_data;
+
+	if (data->cb_count == test->expected_cb_count &&
+					status == test->expected_status &&
+					size == test->expected_report_size)
+		tester_test_passed();
+	else
+		tester_test_failed();
+}
+
+static const struct hidhost_generic_data hidhost_test_get_report = {
+	.expected_hal_cb.get_report_cb = hid_get_report_cb,
+	.expected_cb_count = 1,
+	.expected_status = BTHH_OK,
+	.expected_report_size = 2,
+};
+
+static void test_hidhost_get_report(const void *test_data)
+{
+	struct test_data *data = tester_get_data();
+	const uint8_t *hid_addr = hciemu_get_client_bdaddr(data->hciemu);
+	bt_bdaddr_t bdaddr;
+	bt_status_t bt_status;
+
+	data->cb_count = 0;
+	bdaddr2android((const bdaddr_t *) hid_addr, &bdaddr);
+	bt_status = data->if_hid->get_report(&bdaddr, BTHH_INPUT_REPORT, 1, 20);
+	if (bt_status != BT_STATUS_SUCCESS)
+		tester_test_failed();
+}
+
 #define test_bredrle(name, data, test_setup, test, test_teardown) \
 	do { \
 		struct test_data *user; \
@@ -3879,6 +3939,10 @@ int main(int argc, char *argv[])
 			&hidhost_test_get_protocol, setup_hidhost_connect,
 				test_hidhost_set_protocol, teardown);
 
+	test_bredrle("HIDHost GetReport Success",
+			&hidhost_test_get_report, setup_hidhost_connect,
+				test_hidhost_get_report, teardown);
+
 	test_bredrle("HIDHost SetReport Success",
 				NULL, setup_hidhost_connect,
 				test_hidhost_set_report, teardown);
-- 
1.8.3.2

