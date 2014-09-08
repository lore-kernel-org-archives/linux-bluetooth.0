Return-Path: <cyrus@holtmann.org>
From: roylee17@gmail.com
To: linux-bluetooth@vger.kernel.org
Cc: Tzu-Jung Lee <roylee17@gmail.com>
Subject: [PATCH 1/3] tools: Fix usage for hciattach command
Date: Mon,  8 Sep 2014 14:21:58 -0700
Message-Id: <1410211320-16111-1-git-send-email-roylee@paypal.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Tzu-Jung Lee <roylee17@gmail.com>

---
 tools/hciattach.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/hciattach.c b/tools/hciattach.c
index 1904ac5..542b5b3 100644
--- a/tools/hciattach.c
+++ b/tools/hciattach.c
@@ -1276,7 +1276,7 @@ static void usage(void)
 {
 	printf("hciattach - HCI UART driver initialization utility\n");
 	printf("Usage:\n");
-	printf("\thciattach [-n] [-p] [-b] [-r] [-t timeout] [-s initial_speed] <tty> <type | id> [speed] [flow|noflow] [bdaddr]\n");
+	printf("\thciattach [-n] [-p] [-b] [-r] [-t timeout] [-s initial_speed] <tty> <type | id> [speed] [flow|noflow] [sleep|nosleep] [bdaddr]\n");
 	printf("\thciattach -l\n");
 }
 
-- 
2.0.4

