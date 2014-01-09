Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/3] l2test: Fix using incorrect size of option
Date: Thu,  9 Jan 2014 18:11:03 +0200
Message-Id: <1389283864-15135-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1389283864-15135-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1389283864-15135-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Use size of option instead of size of pointer
---
 tools/l2test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/l2test.c b/tools/l2test.c
index 9a7c809..aaa1608 100644
--- a/tools/l2test.c
+++ b/tools/l2test.c
@@ -287,7 +287,7 @@ static int setopts(int sk, struct l2cap_options *opts)
 {
 	if (bdaddr_type == BDADDR_BREDR || cid)
 		return setsockopt(sk, SOL_L2CAP, L2CAP_OPTIONS, opts,
-								sizeof(opts));
+								sizeof(*opts));
 
 	return setsockopt(sk, SOL_BLUETOOTH, BT_RCVMTU, &opts->imtu,
 							sizeof(opts->imtu));
-- 
1.8.3.2

