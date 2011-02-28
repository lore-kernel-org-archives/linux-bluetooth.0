Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <par-gunnar.p.hjalmdahl@stericsson.com>,
	<henrik.possung@stericsson.com>,
	Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH] Bluetooth: Fix possible NULL pointer dereference in cmd_complete
Date: Mon, 28 Feb 2011 14:09:50 +0100
Message-ID: <1298898590-9052-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

It is now possible to create command complete event without specific
reply data by passing NULL as reply with len 0. Check pointer before
calling memcpy to avoid undefined behaviour.
---
 net/bluetooth/mgmt.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 46c3edc..34f58f4 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -92,7 +92,9 @@ static int cmd_complete(struct sock *sk, u16 index, u16 cmd, void *rp,
 
 	ev = (void *) skb_put(skb, sizeof(*ev) + rp_len);
 	put_unaligned_le16(cmd, &ev->opcode);
-	memcpy(ev->data, rp, rp_len);
+
+	if (rp)
+		memcpy(ev->data, rp, rp_len);
 
 	if (sock_queue_rcv_skb(sk, skb) < 0)
 		kfree_skb(skb);
-- 
1.7.0.4
on behalf of ST-Ericsson
