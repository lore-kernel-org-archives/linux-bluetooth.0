Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>,
	Mikel Astiz <mikel.astiz.oss@gmail.com>
Subject: [PATCH v0 6/6] Bluetooth: Remove outgoing MTU check
Date: Wed, 11 Apr 2012 08:48:52 +0200
Message-Id: <1334126932-27327-7-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1334126932-27327-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1334126932-27327-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

MTU is known in userland so there is no real need to check this in the
kernel, specially because no SCO flow control is done anyway.

In addition, when multiple SCO links are active, many BT chips will work
only if bigger packets are being sent. In this case the MTU is not
relevant any more and typically the size of the incoming packets can be
used also for outgoing packets. This is often greater than the MTU so it
is necessary that we remove this check.

Signed-off-by: Mikel Astiz <mikel.astiz.oss@gmail.com>
---
 net/bluetooth/sco.c |    4 ----
 1 files changed, 0 insertions(+), 4 deletions(-)

diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
index b48370b..9ae9e31 100644
--- a/net/bluetooth/sco.c
+++ b/net/bluetooth/sco.c
@@ -236,10 +236,6 @@ static inline int sco_send_frame(struct sock *sk, struct msghdr *msg, int len)
 	struct sk_buff *skb;
 	int err;
 
-	/* Check outgoing MTU */
-	if (len > conn->mtu)
-		return -EINVAL;
-
 	BT_DBG("sk %p len %d", sk, len);
 
 	skb = bt_skb_send_alloc(sk, len, msg->msg_flags & MSG_DONTWAIT, &err);
-- 
1.7.7.6

