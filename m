Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/2] android/tester: Add missing break
Date: Mon, 16 Dec 2013 16:52:47 +0200
Message-Id: <1387205568-14461-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

---
 android/android-tester.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/android/android-tester.c b/android/android-tester.c
index eb938d0..2a8c8d0 100644
--- a/android/android-tester.c
+++ b/android/android-tester.c
@@ -487,6 +487,7 @@ static void adapter_state_changed_cb(bt_state_t state)
 			tester_setup_complete();
 		else
 			tester_setup_failed();
+		break;
 	default:
 		break;
 	}
-- 
1.8.3.2

