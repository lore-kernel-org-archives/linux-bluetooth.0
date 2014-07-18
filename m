Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2 5/6] tools/scotest: Remove unneeded return
Date: Fri, 18 Jul 2014 16:28:30 +0300
Message-Id: <1405690111-27097-5-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1405690111-27097-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1405587306-20020-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1405690111-27097-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Remove dead code after exit()
---
 tools/scotest.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tools/scotest.c b/tools/scotest.c
index e5530d9..bd65034 100644
--- a/tools/scotest.c
+++ b/tools/scotest.c
@@ -237,8 +237,6 @@ static void do_listen(void (*handler)(int sk))
 		exit(0);
 	}
 
-	return;
-
 error:
 	close(sk);
 	exit(1);
-- 
1.9.1

