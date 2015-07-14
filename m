Return-Path: <cyrus@holtmann.org>
From: Dohyun Pyun <re20sfree@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: steve.jun@samsung.com, DoHyun Pyun <dh79.pyun@samsung.com>
Subject: [PATCH Bluez] tools/l2test: Fix potention double close
Date: Tue, 14 Jul 2015 16:39:17 +0900
Message-Id: <1436859557-16153-1-git-send-email-dh79.pyun@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: DoHyun Pyun <dh79.pyun@samsung.com>

If the test gets an error after close the socket, the socket sk
will be closed again. This patch prevents the double close case.
---
 tools/l2test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/l2test.c b/tools/l2test.c
index abe09c1..1d458c4 100644
--- a/tools/l2test.c
+++ b/tools/l2test.c
@@ -644,7 +644,6 @@ static void do_listen(void (*handler)(int sk))
 			continue;
 		}
 		/* Child */
-		close(sk);
 
 		/* Set receive buffer size */
 		if (rcvbuf && setsockopt(nsk, SOL_SOCKET, SO_RCVBUF, &rcvbuf,
@@ -769,6 +768,7 @@ static void do_listen(void (*handler)(int sk))
 		}
 
 		handler(nsk);
+		close(sk);
 
 		syslog(LOG_INFO, "Disconnect: %m");
 		exit(0);
-- 
1.8.1.2

