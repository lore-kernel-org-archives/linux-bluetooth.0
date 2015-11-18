Return-Path: <linux-bluetooth-owner@vger.kernel.org>
To: linux-bluetooth@vger.kernel.org
From: Danny Schweizer <danny.schweizer@proofnet.de>
Subject: [PATCH] BNEP multicast filter is filtering multicast addresses in
 default case although differently specified
Message-ID: <564C6C35.4030305@proofnet.de>
Date: Wed, 18 Nov 2015 13:16:53 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch fixes the Bug 106691 by changing the default multicast filter
to not filter out any multicast addresses.

---
 net/bluetooth/bnep/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/bnep/core.c b/net/bluetooth/bnep/core.c
index 1641367..ba2467a 100644
--- a/net/bluetooth/bnep/core.c
+++ b/net/bluetooth/bnep/core.c
@@ -609,7 +609,7 @@ int bnep_add_connection(struct bnep_connadd_req
*req, struct socket *sock)

 #ifdef CONFIG_BT_BNEP_MC_FILTER
 	/* Set default mc filter */
-	set_bit(bnep_mc_hash(dev->broadcast), (ulong *) &s->mc_filter);
+	s->mc_filter = ~0LL;
 #endif

 #ifdef CONFIG_BT_BNEP_PROTO_FILTER
-- 
2.1.4
