Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] monitor: Fix possible resource leak
Date: Fri,  4 Jul 2014 15:45:38 +0300
Message-Id: <1404477938-15036-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

This fixes following memory leak:
...
==14887== 24 bytes in 1 blocks are definitely lost in loss record 2 of 4
==14887==    at 0x4C2CC70: calloc (in
/usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so)
==14887==    by 0x425B6C: btsnoop_open (btsnoop.c:83)
==14887==    by 0x424837: analyze_trace (analyze.c:262)
==14887==    by 0x40249A: main (main.c:189)
...
---
 monitor/analyze.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/monitor/analyze.c b/monitor/analyze.c
index a5ed5f4..5288cf3 100644
--- a/monitor/analyze.c
+++ b/monitor/analyze.c
@@ -272,7 +272,7 @@ void analyze_trace(const char *path)
 		break;
 	default:
 		fprintf(stderr, "Unsupported packet format\n");
-		return;
+		goto done;
 	}
 
 	dev_list = queue_new();
-- 
1.9.1

