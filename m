Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [PATCH 11/11] android/tester: Add HIDhost SendData test
Date: Fri, 17 Jan 2014 01:25:51 +0200
Message-Id: <1389914751-18545-12-git-send-email-ravikumar.veeramally@linux.intel.com>
In-Reply-To: <1389914751-18545-1-git-send-email-ravikumar.veeramally@linux.intel.com>
References: <1389914751-18545-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/android-tester.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/android/android-tester.c b/android/android-tester.c
index c79ea16..2ef44ef 100644
--- a/android/android-tester.c
+++ b/android/android-tester.c
@@ -3208,6 +3208,8 @@ static void setup_hidhost_interface(const void *test_data)
 #define HID_SET_OUTPUT_REPORT		0x52
 #define HID_SET_FEATURE_REPORT		0x53
 
+#define HID_SEND_DATA			0xa2
+
 static void hid_prepare_reply_protocol_mode(const void *data, uint16_t len)
 {
 	struct test_data *t_data = tester_get_data();
@@ -3242,6 +3244,12 @@ static void hid_prepare_reply_report(const void *data, uint16_t len)
 static void hid_intr_cid_hook_cb(const void *data, uint16_t len,
 							void *user_data)
 {
+	uint8_t header = ((uint8_t *) data)[0];
+
+	switch (header) {
+	case HID_SEND_DATA:
+		tester_test_passed();
+	}
 }
 
 static void hid_intr_connect_cb(uint16_t handle, uint16_t cid, void *user_data)
@@ -3277,6 +3285,7 @@ static void hid_ctrl_cid_hook_cb(const void *data, uint16_t len,
 	case HID_SET_INPUT_REPORT:
 	case HID_SET_OUTPUT_REPORT:
 	case HID_SET_FEATURE_REPORT:
+	case HID_SEND_DATA:
 		tester_test_passed();
 	}
 }
@@ -3550,6 +3559,21 @@ static void test_hidhost_set_report(const void *test_data)
 		tester_test_failed();
 }
 
+static void test_hidhost_send_data(const void *test_data)
+{
+	struct test_data *data = tester_get_data();
+	const uint8_t *hid_addr = hciemu_get_client_bdaddr(data->hciemu);
+	bt_bdaddr_t bdaddr;
+	bt_status_t bt_status;
+	char *buf = "fe0201";
+
+	data->cb_count = 0;
+	bdaddr2android((const bdaddr_t *) hid_addr, &bdaddr);
+	bt_status = data->if_hid->send_data(&bdaddr, buf);
+	if (bt_status != BT_STATUS_SUCCESS)
+		tester_test_failed();
+}
+
 #define test_bredrle(name, data, test_setup, test, test_teardown) \
 	do { \
 		struct test_data *user; \
@@ -3923,5 +3947,9 @@ int main(int argc, char *argv[])
 				NULL, setup_hidhost_connect,
 				test_hidhost_set_report, teardown);
 
+	test_bredrle("HIDHost SendData Success",
+				NULL, setup_hidhost_connect,
+				test_hidhost_send_data, teardown);
+
 	return tester_run();
 }
-- 
1.8.3.2

