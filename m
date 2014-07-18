Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2 6/6] tools/l2test: Remove unneeded return
Date: Fri, 18 Jul 2014 16:28:31 +0300
Message-Id: <1405690111-27097-6-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1405690111-27097-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1405587306-20020-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1405690111-27097-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Remove dead code after exit()
---
 tools/l2test.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tools/l2test.c b/tools/l2test.c
index ffad7c4..67ca70a 100644
--- a/tools/l2test.c
+++ b/tools/l2test.c
@@ -768,8 +768,6 @@ static void do_listen(void (*handler)(int sk))
 		exit(0);
 	}
 
-	return;
-
 error:
 	close(sk);
 	exit(1);
-- 
1.9.1

