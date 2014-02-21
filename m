Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/2] android/tester: Fix tester setup result set
Date: Fri, 21 Feb 2014 12:33:13 +0100
Message-Id: <1392982394-22845-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Tester setup result is set to pass after set to fail because of missing
function return. This adds return from function after setting of setup
result to fail.
---
 android/android-tester.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/android/android-tester.c b/android/android-tester.c
index 9605c4d..618efde 100644
--- a/android/android-tester.c
+++ b/android/android-tester.c
@@ -2024,6 +2024,7 @@ static void setup_base(const void *test_data)
 	if (status != BT_STATUS_SUCCESS) {
 		data->if_bluetooth = NULL;
 		tester_setup_failed();
+		return;
 	}
 
 	tester_setup_complete();
-- 
1.8.5.2

