Return-Path: <cyrus@holtmann.org>
From: Syam Sidhardhan <s.syam@samsung.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/4] Bluetooth: Use __constant modifier for L2CAP SMP CID
Date: Wed, 10 Oct 2012 22:09:28 +0530
Message-id: <1349887169-20880-3-git-send-email-s.syam@samsung.com>
In-reply-to: <1349887169-20880-1-git-send-email-s.syam@samsung.com>
References: <1349887169-20880-1-git-send-email-s.syam@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Since the L2CAP_CID_SMP is constant, __constant_cpu_to_le16() is
the right go here.

Signed-off-by: Syam Sidhardhan <s.syam@samsung.com>
---
 net/bluetooth/smp.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index 8c225ef..9b54fea 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -165,7 +165,7 @@ static struct sk_buff *smp_build_cmd(struct l2cap_conn *conn, u8 code,
 
 	lh = (struct l2cap_hdr *) skb_put(skb, L2CAP_HDR_SIZE);
 	lh->len = cpu_to_le16(sizeof(code) + dlen);
-	lh->cid = cpu_to_le16(L2CAP_CID_SMP);
+	lh->cid = __constant_cpu_to_le16(L2CAP_CID_SMP);
 
 	memcpy(skb_put(skb, sizeof(code)), &code, sizeof(code));
 
-- 
1.7.9.5

