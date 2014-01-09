Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] android/haltest: Fix double file close
Date: Thu,  9 Jan 2014 11:26:05 +0200
Message-Id: <1389259565-995-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

---
 android/android-tester.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/android/android-tester.c b/android/android-tester.c
index a448ab5..f5f8c62 100644
--- a/android/android-tester.c
+++ b/android/android-tester.c
@@ -443,8 +443,6 @@ static void emulator(int pipe, int hci_index)
 	if (len <= 0 || (strcmp(buf, "ctl.start=bluetoothd")))
 		goto failed;
 
-	close(pipe);
-	close(fd);
 	bluetoothd_start(hci_index);
 
 failed:
-- 
1.8.3.2

