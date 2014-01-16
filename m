Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [PATCH 06/11] android/tester: Add HIDhost VirtualUnplug test
Date: Fri, 17 Jan 2014 01:25:46 +0200
Message-Id: <1389914751-18545-7-git-send-email-ravikumar.veeramally@linux.intel.com>
In-Reply-To: <1389914751-18545-1-git-send-email-ravikumar.veeramally@linux.intel.com>
References: <1389914751-18545-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/android-tester.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/android/android-tester.c b/android/android-tester.c
index 8edabb1..2adbba1 100644
--- a/android/android-tester.c
+++ b/android/android-tester.c
@@ -3340,6 +3340,20 @@ static void test_hidhost_disconnect(const void *test_data)
 		tester_test_failed();
 }
 
+static void test_hidhost_virtual_unplug(const void *test_data)
+{
+	struct test_data *data = tester_get_data();
+	const uint8_t *hid_addr = hciemu_get_client_bdaddr(data->hciemu);
+	bt_bdaddr_t bdaddr;
+	bt_status_t bt_status;
+
+	data->cb_count = 0;
+	bdaddr2android((const bdaddr_t *) hid_addr, &bdaddr);
+	bt_status = data->if_hid->virtual_unplug(&bdaddr);
+	if (bt_status != BT_STATUS_SUCCESS)
+		tester_test_failed();
+}
+
 #define test_bredrle(name, data, test_setup, test, test_teardown) \
 	do { \
 		struct test_data *user; \
@@ -3693,5 +3707,9 @@ int main(int argc, char *argv[])
 				&hidhost_test_disconnect, setup_hidhost_connect,
 				test_hidhost_disconnect, teardown);
 
+	test_bredrle("HIDHost VirtualUnplug Success",
+				&hidhost_test_disconnect, setup_hidhost_connect,
+				test_hidhost_virtual_unplug, teardown);
+
 	return tester_run();
 }
-- 
1.8.3.2

