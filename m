Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [PATCH_v3 5/7] android/tester: Add PAN enable PANU test case
Date: Thu, 27 Mar 2014 12:00:24 +0200
Message-Id: <1395914426-24249-6-git-send-email-ravikumar.veeramally@linux.intel.com>
In-Reply-To: <1395914426-24249-1-git-send-email-ravikumar.veeramally@linux.intel.com>
References: <1395914426-24249-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/android-tester.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/android/android-tester.c b/android/android-tester.c
index da9bf2d..554d2cb 100644
--- a/android/android-tester.c
+++ b/android/android-tester.c
@@ -5021,6 +5021,20 @@ static void test_pan_get_local_role_none(const void *test_data)
 	tester_test_passed();
 }
 
+static void test_pan_enable_panu(const void *test_data)
+{
+	struct test_data *data = tester_get_data();
+	bt_status_t bt_status;
+
+	bt_status = data->if_pan->enable(BTPAN_ROLE_PANU);
+	if (bt_status != BT_STATUS_UNSUPPORTED) {
+		tester_test_failed();
+		return;
+	}
+
+	tester_test_passed();
+}
+
 #define test_bredr(name, data, test_setup, test, test_teardown) \
 	do { \
 		struct test_data *user; \
@@ -5471,5 +5485,9 @@ int main(int argc, char *argv[])
 				NULL, setup_pan,
 			test_pan_get_local_role_none, teardown);
 
+	test_bredr("PAN Enable PANU Success",
+				NULL, setup_pan,
+				test_pan_enable_panu, teardown);
+
 	return tester_run();
 }
-- 
1.8.3.2

