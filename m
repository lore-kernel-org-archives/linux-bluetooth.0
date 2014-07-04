Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 12/12] core: Remove dead code
Date: Fri,  4 Jul 2014 16:44:01 +0300
Message-Id: <1404481441-734-13-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1404481441-734-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1404481441-734-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

rfcomm can only be NULL in this path
---
 src/profile.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/src/profile.c b/src/profile.c
index f30f4f6..528525a 100644
--- a/src/profile.c
+++ b/src/profile.c
@@ -1295,10 +1295,6 @@ failed:
 		ext->servers = g_slist_remove(ext->servers, l2cap);
 		ext_io_destroy(l2cap);
 	}
-	if (rfcomm) {
-		ext->servers = g_slist_remove(ext->servers, rfcomm);
-		ext_io_destroy(rfcomm);
-	}
 
 	return 0;
 }
-- 
1.9.1

