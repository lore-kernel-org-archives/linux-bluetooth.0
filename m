Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [PATCH_v2 4/7] android/tester: Add PAN get local role test cases
Date: Mon, 17 Mar 2014 16:00:08 +0200
Message-Id: <1395064811-5469-5-git-send-email-ravikumar.veeramally@linux.intel.com>
In-Reply-To: <1395064811-5469-1-git-send-email-ravikumar.veeramally@linux.intel.com>
References: <1395064811-5469-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/android-tester.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/android/android-tester.c b/android/android-tester.c
index 9892b09..71c32bb 100644
--- a/android/android-tester.c
+++ b/android/android-tester.c
@@ -4998,6 +4998,32 @@ static void test_pan_disconnect(const void *test_data)
 	data->if_bluetooth->start_discovery();
 }
 
+static void test_pan_get_local_role(const void *test_data)
+{
+	struct test_data *data = tester_get_data();
+	int role;
+
+	role = data->if_pan->get_local_role();
+	if (role != BTPAN_ROLE_PANU)
+		tester_test_failed();
+
+	tester_test_passed();
+}
+
+static void test_pan_get_local_role_none(const void *test_data)
+{
+	struct test_data *data = tester_get_data();
+	int role;
+
+	setup_pan(test_data);
+
+	role = data->if_pan->get_local_role();
+	if (role != BTPAN_ROLE_NONE)
+		tester_test_failed();
+
+	tester_test_passed();
+}
+
 #define test_bredr(name, data, test_setup, test, test_teardown) \
 	do { \
 		struct test_data *user; \
@@ -5444,5 +5470,13 @@ int main(int argc, char *argv[])
 				&panu_test_disconnect, setup_pan,
 				test_pan_disconnect, teardown);
 
+	test_bredr("PAN GetLocalRole Success 1",
+				NULL, setup_pan,
+				test_pan_get_local_role, teardown);
+
+	test_bredr("PAN GetLocalRole Success 2",
+				NULL, NULL,
+				test_pan_get_local_role_none, teardown);
+
 	return tester_run();
 }
-- 
1.8.3.2

