Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [PATCH_v2 7/7] android/tester: Add PAN enable NONE test case
Date: Mon, 17 Mar 2014 16:00:11 +0200
Message-Id: <1395064811-5469-8-git-send-email-ravikumar.veeramally@linux.intel.com>
In-Reply-To: <1395064811-5469-1-git-send-email-ravikumar.veeramally@linux.intel.com>
References: <1395064811-5469-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/android-tester.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/android/android-tester.c b/android/android-tester.c
index e577f64..68db5bf 100644
--- a/android/android-tester.c
+++ b/android/android-tester.c
@@ -5052,6 +5052,20 @@ static void test_pan_enable_nap(const void *test_data)
 	tester_test_passed();
 }
 
+static void test_pan_enable_none(const void *test_data)
+{
+	struct test_data *data = tester_get_data();
+	bt_status_t bt_status;
+
+	setup_pan(test_data);
+
+	bt_status = data->if_pan->enable(BTPAN_ROLE_NONE);
+	if (bt_status != BT_STATUS_SUCCESS)
+		tester_test_failed();
+
+	tester_test_passed();
+}
+
 #define test_bredr(name, data, test_setup, test, test_teardown) \
 	do { \
 		struct test_data *user; \
@@ -5514,5 +5528,9 @@ int main(int argc, char *argv[])
 				NULL, NULL,
 				test_pan_enable_nap, teardown);
 
+	test_bredr("PAN Enable NONE Success",
+				NULL, NULL,
+				test_pan_enable_none, teardown);
+
 	return tester_run();
 }
-- 
1.8.3.2

