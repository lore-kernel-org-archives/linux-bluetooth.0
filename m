Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@gmail.com>
Subject: [PATCH] tools: Fix bccmd build with GCC 4.9
Date: Wed,  2 Apr 2014 22:15:15 +0200
Message-Id: <1396469715-6321-1-git-send-email-szymon.janc@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Make sure accessing array[63 * 2 + 4] is legal.

tools/bccmd.c: In function ‘cmd_buildname’:
tools/bccmd.c:406:18: error: iteration 63u invokes undefined behavior
     [-Werror=aggressive-loop-optimizations]
   name[i] = array[(i * 2) + 4];
---
 tools/bccmd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/bccmd.c b/tools/bccmd.c
index ff1b307..4649ad5 100644
--- a/tools/bccmd.c
+++ b/tools/bccmd.c
@@ -389,7 +389,7 @@ static int cmd_chiprev(int transport, int argc, char *argv[])
 
 static int cmd_buildname(int transport, int argc, char *argv[])
 {
-	uint8_t array[130];
+	uint8_t array[131];
 	char name[64];
 	unsigned int i;
 	int err;
-- 
1.9.1

