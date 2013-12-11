Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/2] android/tester: Remove not needed line
Date: Wed, 11 Dec 2013 12:45:59 +0100
Message-Id: <1386762359-16645-2-git-send-email-marcin.kraglak@tieto.com>
In-Reply-To: <1386762359-16645-1-git-send-email-marcin.kraglak@tieto.com>
References: <1386762359-16645-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

diff --git a/android/android-tester.c b/android/android-tester.c
index d7e80fb..a36c10a 100644
--- a/android/android-tester.c
+++ b/android/android-tester.c
@@ -374,7 +374,6 @@ static void emulator(int pipe, int hci_index)
 	}
 
 	len = write(pipe, EMULATOR_SIGNAL, sizeof(EMULATOR_SIGNAL));
-
 	if (len != sizeof(EMULATOR_SIGNAL))
 		goto failed;
 
-- 
1.8.3.1

