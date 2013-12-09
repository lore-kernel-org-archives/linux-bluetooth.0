Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] bnep: Remove unneeded assignment
Date: Mon,  9 Dec 2013 16:17:28 +0200
Message-Id: <1386598648-31619-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

---
 profiles/network/bnep.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/profiles/network/bnep.c b/profiles/network/bnep.c
index 0a719a2..912c0c2 100644
--- a/profiles/network/bnep.c
+++ b/profiles/network/bnep.c
@@ -88,7 +88,6 @@ static void free_bnep_connect(struct bnep_conn *bc)
 	}
 
 	g_free(bc);
-	bc = NULL;
 }
 
 uint16_t bnep_service_id(const char *svc)
-- 
1.8.3.2

