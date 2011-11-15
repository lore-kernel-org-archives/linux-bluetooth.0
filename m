Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/2] l2test: fix not setting priority of accepted socket
Date: Tue, 15 Nov 2011 13:06:23 +0200
Message-Id: <1321355184-24628-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

SO_PRIORITY is not inherited upon accept so it has to be set manually in
the new socket.
---
 test/l2test.c |   15 ++++++++-------
 1 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/test/l2test.c b/test/l2test.c
index 438d21c..5034775 100644
--- a/test/l2test.c
+++ b/test/l2test.c
@@ -469,13 +469,6 @@ static void do_listen(void (*handler)(int sk))
 	}
 
 
-	if (priority > 0 && setsockopt(sk, SOL_SOCKET, SO_PRIORITY, &priority,
-						sizeof(priority)) < 0) {
-		syslog(LOG_ERR, "Can't set socket priority: %s (%d)",
-							strerror(errno), errno);
-		goto error;
-	}
-
 	/* Listen for connections */
 	if (listen(sk, 10)) {
 		syslog(LOG_ERR, "Can not listen on the socket: %s (%d)",
@@ -542,6 +535,14 @@ static void do_listen(void (*handler)(int sk))
 			}
 		}
 
+		if (priority > 0 && setsockopt(sk, SOL_SOCKET, SO_PRIORITY,
+					&priority, sizeof(priority)) < 0) {
+			syslog(LOG_ERR, "Can't set socket priority: %s (%d)",
+						strerror(errno), errno);
+			close(nsk);
+			goto error;
+		}
+
 		optlen = sizeof(priority);
 		if (getsockopt(nsk, SOL_SOCKET, SO_PRIORITY, &opt, &optlen) < 0) {
 			syslog(LOG_ERR, "Can't get socket priority: %s (%d)",
-- 
1.7.7.1

