Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/9] android/ipc-tester: Fix possible double close
Date: Thu, 19 Jun 2014 16:55:28 +0300
Message-Id: <1403186136-30041-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

I case of error we may close fd and pipe twice.
---
 android/ipc-tester.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/android/ipc-tester.c b/android/ipc-tester.c
index f1f93f2..f23e4b6 100644
--- a/android/ipc-tester.c
+++ b/android/ipc-tester.c
@@ -275,7 +275,7 @@ static void emulator(int pipe, int hci_index)
 
 	close(pipe);
 	close(fd);
-	bluetoothd_start(hci_index);
+	return bluetoothd_start(hci_index);
 
 failed:
 	close(pipe);
-- 
1.8.3.2

