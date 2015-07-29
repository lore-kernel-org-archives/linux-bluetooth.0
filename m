Return-Path: <cyrus@holtmann.org>
From: Anchit Narang <anchit.n@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: sachin.dev@samsung.com
Subject: [PATCH v2] tools/l2test:Fixed memory leak
Date: Wed, 29 Jul 2015 14:06:55 +0530
Message-id: <1438159015-12311-1-git-send-email-anchit.n@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Removed dynamic allocation of filename by strdup.
Instead filename is directly pointing to the argv element.
Closed the file  before returning from do_send function.
---
 tools/l2test.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/l2test.c b/tools/l2test.c
index 1d458c4..386823f 100644
--- a/tools/l2test.c
+++ b/tools/l2test.c
@@ -114,7 +114,7 @@ static unsigned long disc_delay = 0;
 /* Initial sequence value when sending frames */
 static int seq_start = 0;
 
-static char *filename = NULL;
+static const char *filename = NULL;
 
 static int rfcmode = 0;
 static int master = 0;
@@ -974,6 +974,8 @@ static void do_send(int sk)
 			sent += len;
 			size -= len;
 		}
+
+		close(fd);
 		return;
 	} else {
 		for (i = 6; i < data_size; i++)
@@ -1449,7 +1451,7 @@ int main(int argc, char *argv[])
 			break;
 
 		case 'B':
-			filename = strdup(optarg);
+			filename = optarg;
 			break;
 
 		case 'N':
-- 
1.7.9.5

