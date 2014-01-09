Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] android/haltest: Silence static analyzers
Date: Thu,  9 Jan 2014 12:45:20 +0200
Message-Id: <1389264320-7778-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1389259565-995-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1389259565-995-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

This makes code more readable and silence static analyzers which think
that pipe and fd are close two times.
---
 android/android-tester.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/android/android-tester.c b/android/android-tester.c
index a448ab5..c14cc19 100644
--- a/android/android-tester.c
+++ b/android/android-tester.c
@@ -445,7 +445,7 @@ static void emulator(int pipe, int hci_index)
 
 	close(pipe);
 	close(fd);
-	bluetoothd_start(hci_index);
+	return bluetoothd_start(hci_index);
 
 failed:
 	close(pipe);
-- 
1.8.3.2

