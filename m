Return-Path: <cyrus@holtmann.org>
Sender: "Gustavo F. Padovan" <pao@profusion.mobi>
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org, gustavo@padovan.org
Subject: [PATCH] Set l2cap mode always
Date: Wed, 14 Apr 2010 19:03:45 -0300
Message-Id: <1271282625-11666-1-git-send-email-padovan@profusion.mobi>
List-ID: <linux-bluetooth.vger.kernel.org>

As ERTM can be the default mode with SOCK_STREAM we have to set
opts.mode always.
---
 test/l2test.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/test/l2test.c b/test/l2test.c
index 9413070..0bb46f3 100644
--- a/test/l2test.c
+++ b/test/l2test.c
@@ -228,8 +228,7 @@ static int do_connect(char *svr)
 	/* Set new options */
 	opts.omtu = omtu;
 	opts.imtu = imtu;
-	if (rfcmode > 0)
-		opts.mode = rfcmode;
+	opts.mode = rfcmode;
 
 	opts.fcs = fcs;
 	opts.txwin_size = txwin_size;
-- 
1.6.4.4
