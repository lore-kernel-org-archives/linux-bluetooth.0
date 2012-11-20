Return-Path: <cyrus@holtmann.org>
From: Syam Sidhardhan <s.syam@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: Syam Sidhardhan <s.syam@samsung.com>
Subject: [PATCH BlueZ 2/2 v1] l2test: Add support to test auto select PSM
Date: Tue, 20 Nov 2012 21:45:51 +0530
Message-id: <1353428151-11925-1-git-send-email-s.syam@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch enable us to test the auto select PSM for server by passing
PSM value as 0.

Ex: l2test -d -P 0
l2test[2585]: Waiting for connection on psm 4097 ...
---
v1-> Corrected the misplaced code

 test/l2test.c |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/test/l2test.c b/test/l2test.c
index 7645681..485887f 100644
--- a/test/l2test.c
+++ b/test/l2test.c
@@ -87,7 +87,7 @@ static long buffer_size = 2048;
 
 /* Default addr and psm and cid */
 static bdaddr_t bdaddr;
-static unsigned short psm = 0x1011;
+static unsigned short psm = 0;
 static unsigned short cid = 0;
 
 /* Default number of frames to send (-1 = infinite) */
@@ -458,8 +458,6 @@ static void do_listen(void (*handler)(int sk))
 		addr.l2_cid = htobs(cid);
 	else if (psm)
 		addr.l2_psm = htobs(psm);
-	else
-		goto error;
 
 	if (bind(sk, (struct sockaddr *) &addr, sizeof(addr)) < 0) {
 		syslog(LOG_ERR, "Can't bind socket: %s (%d)",
-- 
1.7.4.1

