Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <andrei.emeltchenko@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] android/tester: Fix slang "never used" warning
Date: Fri, 21 Feb 2014 17:46:47 +0200
Message-Id: <1392997607-21896-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

The patch fixes following warning:
...
android/android-tester.c:2185:2: warning: Value stored to
'adapter_status' is never read
        adapter_status = data->if_bluetooth->set_adapter_property(prop);
        ^                ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
...
---
 android/android-tester.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/android/android-tester.c b/android/android-tester.c
index 84c6ca9..47f918c 100644
--- a/android/android-tester.c
+++ b/android/android-tester.c
@@ -2190,6 +2190,10 @@ static void test_getprop_bdname_success(const void *test_data)
 	init_test_conditions(data);
 
 	adapter_status = data->if_bluetooth->set_adapter_property(prop);
+	if (adapter_status != BT_STATUS_SUCCESS) {
+		tester_setup_failed();
+		return;
+	}
 
 	adapter_status = data->if_bluetooth->get_adapter_property((*prop).type);
 	check_expected_status(adapter_status);
-- 
1.8.3.2

