Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] android/tester: Fix NULL dereference.
Date: Fri,  3 Jan 2014 12:18:53 +0200
Message-Id: <1388744333-17014-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

NULL pointer data->if_bluetooth will be dereferenced without return.
---
 android/android-tester.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/android/android-tester.c b/android/android-tester.c
index 04fa811..e34d1bd 100644
--- a/android/android-tester.c
+++ b/android/android-tester.c
@@ -1052,7 +1052,9 @@ static void setup_enabled_adapter(const void *test_data)
 	if (status != BT_STATUS_SUCCESS) {
 		data->if_bluetooth = NULL;
 		tester_setup_failed();
+		return;
 	}
+
 	status = data->if_bluetooth->enable();
 	if (status != BT_STATUS_SUCCESS)
 		tester_setup_failed();
-- 
1.8.3.2

