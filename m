Return-Path: <cyrus@holtmann.org>
From: Gowtham Anandha Babu <gowtham.ab@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: d.kasatkin@samsung.com, bharat.panda@samsung.com, cpgs@samsung.com,
	Gowtham Anandha Babu <gowtham.ab@samsung.com>
Subject: [PATCH] tools/bccmd: Remove dead code
Date: Fri, 19 Dec 2014 19:02:20 +0530
Message-id: <1418995940-16166-1-git-send-email-gowtham.ab@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

warning: Value stored to 'handle' is never read
        handle = array[0] | (array[1] << 8);
        ^        ~~~~~~~~~~~~~~~~~~~~~~~~~~
---
 tools/bccmd.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/bccmd.c b/tools/bccmd.c
index 4649ad5..2646660 100644
--- a/tools/bccmd.c
+++ b/tools/bccmd.c
@@ -279,7 +279,6 @@ static int cmd_keylen(int transport, int argc, char *argv[])
 	if (err < 0)
 		return -1;
 
-	handle = array[0] | (array[1] << 8);
 	keylen = array[2] | (array[3] << 8);
 
 	printf("Crypt key length: %d bit\n", keylen * 8);
-- 
1.9.1

