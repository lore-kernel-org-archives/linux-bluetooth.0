Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ] l2test: Set CID due to socket restrictions for LE
Date: Wed, 16 Oct 2013 16:05:07 -0300
Message-Id: <1381950307-7155-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Bluetooth kernel now restricts LE L2CAP sockets to ATT channels only.
For LE L2CAP socket bind, ATT CID is now mandatory. Reference: kernel patch
bfe4655f05d7ec4a7c0c1c7e4051862f824cd8ec
---
 tools/l2test.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/l2test.c b/tools/l2test.c
index 125532b..c5c8763 100644
--- a/tools/l2test.c
+++ b/tools/l2test.c
@@ -280,6 +280,8 @@ static int do_connect(char *svr)
 	addr.l2_family = AF_BLUETOOTH;
 	bacpy(&addr.l2_bdaddr, &bdaddr);
 	addr.l2_bdaddr_type = bdaddr_type;
+	if (cid)
+		addr.l2_cid = htobs(cid);
 
 	if (bind(sk, (struct sockaddr *) &addr, sizeof(addr)) < 0) {
 		syslog(LOG_ERR, "Can't bind socket: %s (%d)",
-- 
1.8.3.1

