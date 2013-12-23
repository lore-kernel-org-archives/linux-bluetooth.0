Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] android/tester: Fix possible NULL dereference
Date: Mon, 23 Dec 2013 10:28:51 +0200
Message-Id: <1387787331-8405-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

value is checked for NULL and later is dereferenced if we do not return.
---
 android/android-tester.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/android/android-tester.c b/android/android-tester.c
index 2d1ffde..0383115 100644
--- a/android/android-tester.c
+++ b/android/android-tester.c
@@ -148,18 +148,21 @@ static void test_device_property(bt_property_t *property,
 	if (value == NULL) {
 		tester_warn("NULL property passed");
 		tester_test_failed();
+		return;
 	}
 
 	if (property->type != type) {
 		tester_warn("Wrong remote property type %d, expected %d",
 							type, property->type);
 		tester_test_failed();
+		return;
 	}
 
 	if (property->len != len) {
 		tester_warn("Wrong remote property len %d, expected %d",
 							len, property->len);
 		tester_test_failed();
+		return;
 	}
 
 	if (memcmp(property->val, value, len)) {
-- 
1.8.3.2

