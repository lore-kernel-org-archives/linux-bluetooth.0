Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [PATCH 6/7] android/tester: Add PAN enable NAP test case
Date: Thu, 13 Mar 2014 23:50:42 +0200
Message-Id: <1394747443-23220-7-git-send-email-ravikumar.veeramally@linux.intel.com>
In-Reply-To: <1394747443-23220-1-git-send-email-ravikumar.veeramally@linux.intel.com>
References: <1394747443-23220-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/android-tester.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/android/android-tester.c b/android/android-tester.c
index 002dfcd..227812c 100644
--- a/android/android-tester.c
+++ b/android/android-tester.c
@@ -5032,6 +5032,20 @@ static void test_pan_enable_panu(const void *test_data)
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
@@ -5490,5 +5504,9 @@ int main(int argc, char *argv[])
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

