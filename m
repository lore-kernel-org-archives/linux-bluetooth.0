Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/2] rctest: fix not setting priority of accepted socket
Date: Tue, 15 Nov 2011 13:06:24 +0200
Message-Id: <1321355184-24628-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1321355184-24628-1-git-send-email-luiz.dentz@gmail.com>
References: <1321355184-24628-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

SO_PRIORITY is not inherited upon accept so it has to be set manually in
the new socket.
---
 test/rctest.c |   15 ++++++++-------
 1 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/test/rctest.c b/test/rctest.c
index b8acfb7..4d7c90a 100644
--- a/test/rctest.c
+++ b/test/rctest.c
@@ -312,13 +312,6 @@ static void do_listen(void (*handler)(int sk))
 		goto error;
 	}
 
-	if (priority > 0 && setsockopt(sk, SOL_SOCKET, SO_PRIORITY, &priority,
-						sizeof(priority)) < 0) {
-		syslog(LOG_ERR, "Can't set socket priority: %s (%d)",
-						strerror(errno), errno);
-		goto error;
-	}
-
 	/* Listen for connections */
 	if (listen(sk, 10)) {
 		syslog(LOG_ERR,"Can not listen on the socket: %s (%d)",
@@ -369,6 +362,14 @@ static void do_listen(void (*handler)(int sk))
 			//goto error;
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

