Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] hciattach: Add sleep|nosleep keyword
Date: Fri, 17 Oct 2014 15:48:13 +0300
Message-Id: <1413550093-16448-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

---
 tools/hciattach.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/hciattach.c b/tools/hciattach.c
index d8ef7e7..808bbac 100644
--- a/tools/hciattach.c
+++ b/tools/hciattach.c
@@ -1276,7 +1276,9 @@ static void usage(void)
 {
 	printf("hciattach - HCI UART driver initialization utility\n");
 	printf("Usage:\n");
-	printf("\thciattach [-n] [-p] [-b] [-r] [-t timeout] [-s initial_speed] <tty> <type | id> [speed] [flow|noflow] [bdaddr]\n");
+	printf("\thciattach [-n] [-p] [-b] [-r] [-t timeout] [-s initial_speed]"
+			" <tty> <type | id> [speed] [flow|noflow]"
+			" [sleep|nosleep] [bdaddr]\n");
 	printf("\thciattach -l\n");
 }
 
-- 
1.9.1

