Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/3] android/tester: Change hciemu type to bredr
Date: Tue, 11 Mar 2014 11:09:31 +0100
Message-Id: <1394532573-19278-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Current test cases works on bredrle hciemu types. Now test cases
don't require to support LE mode. Btdev support for LE devices have
to be enhanced to behave correctly with mode set to LE. After enhancing
support in bthost, hciemu type can be retyped to bredrle.
---
 android/android-tester.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/android/android-tester.c b/android/android-tester.c
index b762a2d..49a636f 100644
--- a/android/android-tester.c
+++ b/android/android-tester.c
@@ -4422,13 +4422,18 @@ static void test_hidhost_get_report(const void *test_data)
 		tester_test_failed();
 }
 
+/* Changing hciemu type to bredr is a teporary fix while bthost don't handle
+ * all LE commands. A lot of test cases - especially those which uses scan
+ * (remote device tests) will fail. After enahancing bthost hciemu type can be
+ * rechanged to BREDRLE.
+ */
 #define test_bredrle(name, data, test_setup, test, test_teardown) \
 	do { \
 		struct test_data *user; \
 		user = g_malloc0(sizeof(struct test_data)); \
 		if (!user) \
 			break; \
-		user->hciemu_type = HCIEMU_TYPE_BREDRLE; \
+		user->hciemu_type = HCIEMU_TYPE_BREDR; \
 		user->test_data = data; \
 		tester_add_full(name, data, test_pre_setup, test_setup, \
 				test, test_teardown, test_post_teardown, \
-- 
1.8.5.2

