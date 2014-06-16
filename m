Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH] tools/l2test: Fix setopts and getopts functions
Date: Tue, 17 Jun 2014 00:29:57 +0200
Message-Id: <1402957797-515-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Level SOL_L2CAP with optname L2CAP_OPTIONS is supported only for BR/EDR
Since bdaddr_type is set to BDADDR_BREDR by default, there is no sense
to check also CID.

This fix le connect which now fails when trying to connect ATT CID on LE
transport.
---
 tools/l2test.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/l2test.c b/tools/l2test.c
index c70bac0..ffad7c4 100644
--- a/tools/l2test.c
+++ b/tools/l2test.c
@@ -271,7 +271,7 @@ static int getopts(int sk, struct l2cap_options *opts, bool connected)
 
 	memset(opts, 0, sizeof(*opts));
 
-	if (bdaddr_type == BDADDR_BREDR || cid) {
+	if (bdaddr_type == BDADDR_BREDR) {
 		optlen = sizeof(*opts);
 		return getsockopt(sk, SOL_L2CAP, L2CAP_OPTIONS, opts, &optlen);
 	}
@@ -287,7 +287,7 @@ static int getopts(int sk, struct l2cap_options *opts, bool connected)
 
 static int setopts(int sk, struct l2cap_options *opts)
 {
-	if (bdaddr_type == BDADDR_BREDR || cid)
+	if (bdaddr_type == BDADDR_BREDR)
 		return setsockopt(sk, SOL_L2CAP, L2CAP_OPTIONS, opts,
 								sizeof(*opts));
 
-- 
1.8.4

