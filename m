Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [PATCH] android/client: Fix pin reply call when pin argument missing in cmd
Date: Fri,  1 Nov 2013 14:20:05 +0200
Message-Id: <1383308405-17782-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

If condition checks number of arguments properly but still executes
EXEC command. It should display error message and return.
---
 android/client/if-bt.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/android/client/if-bt.c b/android/client/if-bt.c
index 3d97458..2c3cc4a 100644
--- a/android/client/if-bt.c
+++ b/android/client/if-bt.c
@@ -719,12 +719,15 @@ static void pin_reply_p(int argc, const char **argv)
 	RETURN_IF_NULL(if_bluetooth);
 	VERIFY_ADDR_ARG(2, &addr);
 
-	if (argc > 3) {
-		accept = 1;
-		pin_len = strlen(argv[3]);
-		memcpy(pin.pin, argv[3], pin_len);
+	if (argc != 4) {
+		haltest_error("Usage <address> <pin>\n");
+		return;
 	}
 
+	accept = 1;
+	pin_len = strlen(argv[3]);
+	memcpy(pin.pin, argv[3], pin_len);
+
 	EXEC(if_bluetooth->pin_reply, &addr, accept, pin_len, &pin);
 }
 
-- 
1.8.1.2

