Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/2] android/tester: Fix closing file descriptor
Date: Wed, 11 Dec 2013 12:45:58 +0100
Message-Id: <1386762359-16645-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Don't close file descriptor if failed to create it.
---
 android/android-tester.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/android/android-tester.c b/android/android-tester.c
index 09c76c9..d7e80fb 100644
--- a/android/android-tester.c
+++ b/android/android-tester.c
@@ -390,7 +390,9 @@ static void emulator(int pipe, int hci_index)
 
 failed:
 	close(pipe);
-	close(fd);
+
+	if (fd >= 0)
+		close(fd);
 }
 
 static void adapter_state_changed_cb(bt_state_t state)
-- 
1.8.3.1

