Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [PATCH_v3 4/7] android/tester: Add PAN get local role test case
Date: Thu, 27 Mar 2014 12:00:23 +0200
Message-Id: <1395914426-24249-5-git-send-email-ravikumar.veeramally@linux.intel.com>
In-Reply-To: <1395914426-24249-1-git-send-email-ravikumar.veeramally@linux.intel.com>
References: <1395914426-24249-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/android-tester.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/android/android-tester.c b/android/android-tester.c
index 82b0541..da9bf2d 100644
--- a/android/android-tester.c
+++ b/android/android-tester.c
@@ -5007,6 +5007,20 @@ static void test_pan_disconnect(const void *test_data)
 	data->if_bluetooth->start_discovery();
 }
 
+static void test_pan_get_local_role_none(const void *test_data)
+{
+	struct test_data *data = tester_get_data();
+	int role;
+
+	role = data->if_pan->get_local_role();
+	if (role != BTPAN_ROLE_NONE) {
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
@@ -5453,5 +5467,9 @@ int main(int argc, char *argv[])
 				&panu_test_disconnect, setup_pan,
 				test_pan_disconnect, teardown);
 
+	test_bredr("PAN GetLocalRole Success",
+				NULL, setup_pan,
+			test_pan_get_local_role_none, teardown);
+
 	return tester_run();
 }
-- 
1.8.3.2

