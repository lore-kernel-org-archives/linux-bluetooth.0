Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [PATCH_v2 6/7] android/tester: Add PAN enable NAP test case
Date: Mon, 17 Mar 2014 16:00:10 +0200
Message-Id: <1395064811-5469-7-git-send-email-ravikumar.veeramally@linux.intel.com>
In-Reply-To: <1395064811-5469-1-git-send-email-ravikumar.veeramally@linux.intel.com>
References: <1395064811-5469-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/android-tester.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/android/android-tester.c b/android/android-tester.c
index a7d8ebb..e577f64 100644
--- a/android/android-tester.c
+++ b/android/android-tester.c
@@ -5038,6 +5038,20 @@ static void test_pan_enable_panu(const void *test_data)
 	tester_test_passed();
 }
 
+static void test_pan_enable_nap(const void *test_data)
+{
+	struct test_data *data = tester_get_data();
+	bt_status_t bt_status;
+
+	setup_pan(test_data);
+
+	bt_status = data->if_pan->enable(BTPAN_ROLE_PANNAP);
+	if (bt_status != BT_STATUS_SUCCESS)
+		tester_test_failed();
+
+	tester_test_passed();
+}
+
 #define test_bredr(name, data, test_setup, test, test_teardown) \
 	do { \
 		struct test_data *user; \
@@ -5496,5 +5510,9 @@ int main(int argc, char *argv[])
 				NULL, NULL,
 				test_pan_enable_panu, teardown);
 
+	test_bredr("PAN Enable NAP Success",
+				NULL, NULL,
+				test_pan_enable_nap, teardown);
+
 	return tester_run();
 }
-- 
1.8.3.2

