Return-Path: <cyrus@holtmann.org>
From: Dohyun Pyun <dh79.pyun@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: DoHyun Pyun <dh79.pyun@samsung.com>
Subject: [PATCH v2 BLUEZ] tools/l2test: Fix potential double close
Date: Mon, 27 Jul 2015 17:02:22 +0900
Message-id: <1437984142-3701-1-git-send-email-dh79.pyun@samsung.com>
In-reply-to: <1437546336-10105-1-git-send-email-dh79.pyun@samsung.com>
References: <1437546336-10105-1-git-send-email-dh79.pyun@samsung.com>
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

