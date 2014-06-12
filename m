Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] android/ipc-tester: Fix closing invalid fd
Date: Thu, 12 Jun 2014 17:07:43 +0300
Message-Id: <1402582063-7584-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Is socket() fails we jumps to failed label.
---
 android/ipc-tester.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/android/ipc-tester.c b/android/ipc-tester.c
index 63fd105..f1f93f2 100644
--- a/android/ipc-tester.c
+++ b/android/ipc-tester.c
@@ -279,7 +279,8 @@ static void emulator(int pipe, int hci_index)
 
 failed:
 	close(pipe);
-	close(fd);
+	if (fd >= 0)
+		close(fd);
 }
 
 static int accept_connection(int sk)
-- 
1.8.3.2

