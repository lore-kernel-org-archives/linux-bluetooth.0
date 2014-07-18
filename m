Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2 3/6] tools/rctest: Remove unneeded return
Date: Fri, 18 Jul 2014 16:28:28 +0300
Message-Id: <1405690111-27097-3-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1405690111-27097-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1405587306-20020-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1405690111-27097-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Code is unreachable since we use exit() before
---
 tools/rctest.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tools/rctest.c b/tools/rctest.c
index 2c7e45b..a09a973 100644
--- a/tools/rctest.c
+++ b/tools/rctest.c
@@ -437,8 +437,6 @@ static void do_listen(void (*handler)(int sk))
 		exit(0);
 	}
 
-	return;
-
 error:
 	close(sk);
 	exit(1);
-- 
1.9.1

