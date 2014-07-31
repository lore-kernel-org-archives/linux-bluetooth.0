Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] gobex: Fix use after free
Date: Thu, 31 Jul 2014 16:35:20 +0300
Message-Id: <1406813720-4382-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

It is better not to dereference freed pointer
---
 gobex/gobex.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/gobex/gobex.c b/gobex/gobex.c
index 3848884..35e546f 100644
--- a/gobex/gobex.c
+++ b/gobex/gobex.c
@@ -263,8 +263,6 @@ static gboolean req_timeout(gpointer user_data)
 	g_error_free(err);
 	pending_pkt_free(p);
 
-	p->timeout_id = 0;
-
 	return FALSE;
 }
 
-- 
1.9.1

