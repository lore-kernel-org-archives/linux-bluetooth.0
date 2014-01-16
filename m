Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [PATCH 05/11] android/tester: Add HIDhost Disconnect test
Date: Fri, 17 Jan 2014 01:25:45 +0200
Message-Id: <1389914751-18545-6-git-send-email-ravikumar.veeramally@linux.intel.com>
In-Reply-To: <1389914751-18545-1-git-send-email-ravikumar.veeramally@linux.intel.com>
References: <1389914751-18545-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/android-tester.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/android/android-tester.c b/android/android-tester.c
index 0888a68..8edabb1 100644
--- a/android/android-tester.c
+++ b/android/android-tester.c
@@ -3316,6 +3316,30 @@ static void setup_hidhost_connect(const void *test_data)
 	bthost_write_scan_enable(bthost, 0x03);
 }
 
+static void hid_discon_cb(bt_bdaddr_t *bd_addr,	bthh_connection_state_t state)
+{
+	if (state == BTHH_CONN_STATE_DISCONNECTED)
+		tester_test_passed();
+}
+
+static const struct hidhost_generic_data hidhost_test_disconnect = {
+	.expected_hal_cb.connection_state_cb = hid_discon_cb,
+};
+
+static void test_hidhost_disconnect(const void *test_data)
+{
+	struct test_data *data = tester_get_data();
+	const uint8_t *hid_addr = hciemu_get_client_bdaddr(data->hciemu);
+	bt_bdaddr_t bdaddr;
+	bt_status_t bt_status;
+
+	data->cb_count = 0;
+	bdaddr2android((const bdaddr_t *) hid_addr, &bdaddr);
+	bt_status = data->if_hid->disconnect(&bdaddr);
+	if (bt_status != BT_STATUS_SUCCESS)
+		tester_test_failed();
+}
+
 #define test_bredrle(name, data, test_setup, test, test_teardown) \
 	do { \
 		struct test_data *user; \
@@ -3665,5 +3689,9 @@ int main(int argc, char *argv[])
 				NULL, setup_hidhost_connect,
 				test_dummy, teardown);
 
+	test_bredrle("HIDHost Disconnect Success",
+				&hidhost_test_disconnect, setup_hidhost_connect,
+				test_hidhost_disconnect, teardown);
+
 	return tester_run();
 }
-- 
1.8.3.2

