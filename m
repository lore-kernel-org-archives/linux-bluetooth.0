Return-Path: <cyrus@holtmann.org>
From: Syam Sidhardhan <s.syam@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: Syam Sidhardhan <s.syam@samsung.com>
Subject: [PATCH BlueZ v2] l2test: Add support to test auto select PSM
Date: Wed, 05 Dec 2012 21:51:41 +0530
Message-id: <1354724501-5368-1-git-send-email-s.syam@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch enable us to test the auto select PSM by passing
PSM value as 0.

Ex: l2test -d -P 0
l2test[2585]: Waiting for connection on psm 4099 ...
---
v2 -> Retain the interoperability issue mentioned by Gustavo.
 
 test/l2test.c |    2 --
 1 file changed, 2 deletions(-)

diff --git a/test/l2test.c b/test/l2test.c
index 7f9f007..c88116d 100644
--- a/test/l2test.c
+++ b/test/l2test.c
@@ -454,8 +454,6 @@ static void do_listen(void (*handler)(int sk))
 		addr.l2_cid = htobs(cid);
 	else if (psm)
 		addr.l2_psm = htobs(psm);
-	else
-		goto error;
 
 	if (bind(sk, (struct sockaddr *) &addr, sizeof(addr)) < 0) {
 		syslog(LOG_ERR, "Can't bind socket: %s (%d)",
-- 
1.7.9.5

