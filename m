Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/3] android/tester: Check status returned from HAL calls
Date: Wed, 18 Dec 2013 10:55:11 +0200
Message-Id: <1387356913-32666-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

In test setup phase check status returned from  enable() call.
---
 android/android-tester.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/android/android-tester.c b/android/android-tester.c
index bd6fa02..4a75704 100644
--- a/android/android-tester.c
+++ b/android/android-tester.c
@@ -696,10 +696,13 @@ static void setup_base(const void *test_data)
 static void setup_enabled_adapter(const void *test_data)
 {
 	struct test_data *data = tester_get_data();
+	bt_status_t status;
 
 	setup(data);
 
-	data->if_bluetooth->enable();
+	status = data->if_bluetooth->enable();
+	if (status != BT_STATUS_SUCCESS)
+		tester_setup_failed();
 }
 
 static void teardown(const void *test_data)
-- 
1.8.3.2

