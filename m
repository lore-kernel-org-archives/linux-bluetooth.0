Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [PATCH 10/11] android/tester: Add HIDhost SetReport test
Date: Fri, 17 Jan 2014 01:25:50 +0200
Message-Id: <1389914751-18545-11-git-send-email-ravikumar.veeramally@linux.intel.com>
In-Reply-To: <1389914751-18545-1-git-send-email-ravikumar.veeramally@linux.intel.com>
References: <1389914751-18545-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/android-tester.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/android/android-tester.c b/android/android-tester.c
index f8d539d..c79ea16 100644
--- a/android/android-tester.c
+++ b/android/android-tester.c
@@ -3204,6 +3204,10 @@ static void setup_hidhost_interface(const void *test_data)
 #define HID_GET_OUTPUT_REPORT		0x4a
 #define HID_GET_FEATURE_REPORT		0x4b
 
+#define HID_SET_INPUT_REPORT		0x51
+#define HID_SET_OUTPUT_REPORT		0x52
+#define HID_SET_FEATURE_REPORT		0x53
+
 static void hid_prepare_reply_protocol_mode(const void *data, uint16_t len)
 {
 	struct test_data *t_data = tester_get_data();
@@ -3268,6 +3272,12 @@ static void hid_ctrl_cid_hook_cb(const void *data, uint16_t len,
 	case HID_GET_FEATURE_REPORT:
 		hid_prepare_reply_report(data, len);
 		break;
+	/* HID device doesnot reply for this commads, so reaching pdu's
+	 * to hid device means assuming test passed */
+	case HID_SET_INPUT_REPORT:
+	case HID_SET_OUTPUT_REPORT:
+	case HID_SET_FEATURE_REPORT:
+		tester_test_passed();
 	}
 }
 
@@ -3525,6 +3535,21 @@ static void test_hidhost_get_report(const void *test_data)
 		tester_test_failed();
 }
 
+static void test_hidhost_set_report(const void *test_data)
+{
+	struct test_data *data = tester_get_data();
+	const uint8_t *hid_addr = hciemu_get_client_bdaddr(data->hciemu);
+	bt_bdaddr_t bdaddr;
+	bt_status_t bt_status;
+	char *buf = "010101";
+
+	data->cb_count = 0;
+	bdaddr2android((const bdaddr_t *) hid_addr, &bdaddr);
+	bt_status = data->if_hid->set_report(&bdaddr, BTHH_INPUT_REPORT, buf);
+	if (bt_status != BT_STATUS_SUCCESS)
+		tester_test_failed();
+}
+
 #define test_bredrle(name, data, test_setup, test, test_teardown) \
 	do { \
 		struct test_data *user; \
@@ -3894,5 +3919,9 @@ int main(int argc, char *argv[])
 			&hidhost_test_get_report, setup_hidhost_connect,
 				test_hidhost_get_report, teardown);
 
+	test_bredrle("HIDHost SetReport Success",
+				NULL, setup_hidhost_connect,
+				test_hidhost_set_report, teardown);
+
 	return tester_run();
 }
-- 
1.8.3.2

