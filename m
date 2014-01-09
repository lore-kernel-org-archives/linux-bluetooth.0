Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/4] android/tester: Remove redundant whitespace
Date: Thu,  9 Jan 2014 12:01:32 +0100
Message-Id: <1389265295-3344-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/android-tester.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/android/android-tester.c b/android/android-tester.c
index a448ab5..4f733e1 100644
--- a/android/android-tester.c
+++ b/android/android-tester.c
@@ -189,7 +189,6 @@ static void expected_cb_count_init(struct test_data *data)
 	data->cb_count = test_data->expected_cb_count;
 
 	check_cb_count();
-
 }
 
 static void mgmt_cb_init(struct test_data *data)
-- 
1.8.5.2

