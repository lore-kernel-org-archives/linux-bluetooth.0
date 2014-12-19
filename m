Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] shared/gap: Fix memory leak in gap
Date: Fri, 19 Dec 2014 14:13:01 +0200
Message-Id: <1418991181-3826-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Allocated irk memory was never assigned.
---
 src/shared/gap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/shared/gap.c b/src/shared/gap.c
index 19059e8..3536c1c 100644
--- a/src/shared/gap.c
+++ b/src/shared/gap.c
@@ -276,5 +276,5 @@ bool bt_gap_add_peer_irk(struct bt_gap *gap, uint8_t addr_type,
 	memcpy(irk->addr, addr, 6);
 	memcpy(irk->key, key, 16);
 
-	return true;
+	return queue_push_tail(gap->irk_list, irk);
 }
-- 
2.1.0

