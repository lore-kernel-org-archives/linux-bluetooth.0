Return-Path: <cyrus@holtmann.org>
From: Anchit Narang <anchit.n@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: sachin.dev@samsung.com
Subject: [PATCH] tools/l2test:Fixed memory leak
Date: Tue, 28 Jul 2015 16:12:10 +0530
Message-id: <1438080130-445-1-git-send-email-anchit.n@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Freed memory allocated to filename before exiting.
Closed file before returning from do_send function.
---
 tools/l2test.c |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/l2test.c b/tools/l2test.c
index 1d458c4..a2e6d5d 100644
--- a/tools/l2test.c
+++ b/tools/l2test.c
@@ -961,6 +961,7 @@ static void do_send(int sk)
 		if (fd < 0) {
 			syslog(LOG_ERR, "Open failed: %s (%d)",
 							strerror(errno), errno);
+			free(filename);
 			exit(1);
 		}
 
@@ -974,6 +975,8 @@ static void do_send(int sk)
 			sent += len;
 			size -= len;
 		}
+
+		close(fd);
 		return;
 	} else {
 		for (i = 6; i < data_size; i++)
@@ -999,6 +1002,7 @@ static void do_send(int sk)
 			if (len < 0 || len != buflen) {
 				syslog(LOG_ERR, "Send failed: %s (%d)",
 							strerror(errno), errno);
+				free(filename);
 				exit(1);
 			}
 
-- 
1.7.9.5

