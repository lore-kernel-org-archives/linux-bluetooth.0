Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/4] android/client: Fix double close issue
Date: Wed, 23 Jul 2014 14:34:58 +0300
Message-Id: <1406115301-18812-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

File is closed inside reading thread. Fixes:
...
Error in
`.../bluez/android/haltest':
double free or corruption (!prev): 0x000000000065a5e0 ***

Program received signal SIGABRT, Aborted.
...
---
 android/client/if-sco.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/android/client/if-sco.c b/android/client/if-sco.c
index 4919fd9..70e2737 100644
--- a/android/client/if-sco.c
+++ b/android/client/if-sco.c
@@ -451,6 +451,8 @@ static void read_p(int argc, const char **argv)
 		haltest_error("Cannot create playback thread!\n");
 		goto failed;
 	}
+
+	return;
 failed:
 	if (out)
 		fclose(out);
-- 
1.9.1

