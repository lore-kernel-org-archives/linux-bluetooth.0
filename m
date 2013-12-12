Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2 1/7] android/tester: Rename controller_setup to test_dummy
Date: Thu, 12 Dec 2013 14:48:28 +0200
Message-Id: <1386852514-17270-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1386852514-17270-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1386852514-17270-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

test_dummy is a better name for dummy function test.
---
 android/android-tester.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/android/android-tester.c b/android/android-tester.c
index a36c10a..7ecc80d 100644
--- a/android/android-tester.c
+++ b/android/android-tester.c
@@ -672,7 +672,7 @@ static void test_disable(const void *test_data)
 	data->if_bluetooth->disable();
 }
 
-static void controller_setup(const void *test_data)
+static void test_dummy(const void *test_data)
 {
 	tester_test_passed();
 }
@@ -696,7 +696,7 @@ int main(int argc, char *argv[])
 
 	tester_init(&argc, &argv);
 
-	test_bredrle("Test Init", NULL, setup_base, controller_setup, teardown);
+	test_bredrle("Test Init", NULL, setup_base, test_dummy, teardown);
 
 	test_bredrle("Test Enable - Success", &bluetooth_enable_success_test,
 					setup_base, test_enable, teardown);
-- 
1.8.3.2

