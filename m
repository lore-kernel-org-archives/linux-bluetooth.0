Return-Path: <cyrus@holtmann.org>
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] use a valid PSM value in l2test.
Date: Wed,  9 Feb 2011 16:42:00 -0200
Message-Id: <1297276920-15467-1-git-send-email-padovan@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 test/l2test.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/test/l2test.c b/test/l2test.c
index 17883a9..3ac332f 100644
--- a/test/l2test.c
+++ b/test/l2test.c
@@ -87,7 +87,7 @@ static long buffer_size = 2048;
 
 /* Default addr and psm and cid */
 static bdaddr_t bdaddr;
-static unsigned short psm = 10;
+static unsigned short psm = 0x1011;
 static unsigned short cid = 0;
 
 /* Default number of frames to send (-1 = infinite) */
-- 
1.7.4

