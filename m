Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] android: Fix wrong check
Date: Tue, 16 Sep 2014 11:10:47 +0300
Message-Id: <1410855047-13147-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

---
 android/tester-main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/android/tester-main.c b/android/tester-main.c
index 385c00d..5f0563d 100644
--- a/android/tester-main.c
+++ b/android/tester-main.c
@@ -1631,7 +1631,7 @@ static void setup_avrcp(const void *test_data)
 	}
 
 	avrcp = if_bt->get_profile_interface(BT_PROFILE_AV_RC_ID);
-	if (!a2dp) {
+	if (!avrcp) {
 		tester_setup_failed();
 		return;
 	}
-- 
1.9.1

