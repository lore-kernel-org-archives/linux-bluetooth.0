Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [PATCH 08/11] android/tester: Add HIDhost SetProtocol test
Date: Fri, 17 Jan 2014 01:25:48 +0200
Message-Id: <1389914751-18545-9-git-send-email-ravikumar.veeramally@linux.intel.com>
In-Reply-To: <1389914751-18545-1-git-send-email-ravikumar.veeramally@linux.intel.com>
References: <1389914751-18545-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/android-tester.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/android/android-tester.c b/android/android-tester.c
index 56be850..da1fc28 100644
--- a/android/android-tester.c
+++ b/android/android-tester.c
@@ -3197,6 +3197,8 @@ static void setup_hidhost_interface(const void *test_data)
 
 #define HID_GET_REPORT_PROTOCOL		0x60
 #define HID_GET_BOOT_PROTOCOL		0x61
+#define HID_SET_REPORT_PROTOCOL		0x70
+#define HID_SET_BOOT_PROTOCOL		0x71
 
 static void hid_prepare_reply_protocol_mode(const void *data, uint16_t len)
 {
@@ -3237,6 +3239,8 @@ static void hid_ctrl_cid_hook_cb(const void *data, uint16_t len,
 	switch (header) {
 	case HID_GET_REPORT_PROTOCOL:
 	case HID_GET_BOOT_PROTOCOL:
+	case HID_SET_REPORT_PROTOCOL:
+	case HID_SET_BOOT_PROTOCOL:
 		hid_prepare_reply_protocol_mode(data, len);
 		break;
 	}
@@ -3447,6 +3451,20 @@ static void test_hidhost_get_protocol(const void *test_data)
 		tester_test_failed();
 }
 
+static void test_hidhost_set_protocol(const void *test_data)
+{
+	struct test_data *data = tester_get_data();
+	const uint8_t *hid_addr = hciemu_get_client_bdaddr(data->hciemu);
+	bt_bdaddr_t bdaddr;
+	bt_status_t bt_status;
+
+	data->cb_count = 0;
+	bdaddr2android((const bdaddr_t *) hid_addr, &bdaddr);
+	bt_status = data->if_hid->set_protocol(&bdaddr, BTHH_REPORT_MODE);
+	if (bt_status != BT_STATUS_SUCCESS)
+		tester_test_failed();
+}
+
 #define test_bredrle(name, data, test_setup, test, test_teardown) \
 	do { \
 		struct test_data *user; \
@@ -3808,5 +3826,9 @@ int main(int argc, char *argv[])
 			&hidhost_test_get_protocol, setup_hidhost_connect,
 				test_hidhost_get_protocol, teardown);
 
+	test_bredrle("HIDHost SetProtocol Success",
+			&hidhost_test_get_protocol, setup_hidhost_connect,
+				test_hidhost_set_protocol, teardown);
+
 	return tester_run();
 }
-- 
1.8.3.2

