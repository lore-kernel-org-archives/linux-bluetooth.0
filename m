Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCH 5/5] android/tester: Fix not cleaning up step lists
Date: Wed,  3 Sep 2014 10:56:41 +0200
Message-Id: <1409734601-8078-5-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1409734601-8078-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1409734601-8078-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

There were missing some cleanups for few testers.
---
 android/tester-main.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/android/tester-main.c b/android/tester-main.c
index fb8e11b..f5f46fb 100644
--- a/android/tester-main.c
+++ b/android/tester-main.c
@@ -2122,6 +2122,11 @@ static void tester_testcases_cleanup(void)
 {
 	remove_bluetooth_tests();
 	remove_socket_tests();
+	remove_hidhost_tests();
+	remove_gatt_tests();
+	remove_a2dp_tests();
+	remove_hdp_tests();
+	remove_pan_tests();
 }
 
 static void add_bluetooth_tests(void *data, void *user_data)
-- 
1.9.1

