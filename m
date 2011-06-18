Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH 3/3] Bluetooth: Remove useless access to the socket
Date: Fri, 17 Jun 2011 22:46:27 -0300
Message-Id: <1308361587-8338-3-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1308361587-8338-1-git-send-email-vinicius.gomes@openbossa.org>
References: <1308361587-8338-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

We already have access to the chan, we don't have to access the
socket to get its imtu.

Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
---
 net/bluetooth/l2cap_core.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index bbe5306..904b177 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -3964,7 +3964,7 @@ static inline int l2cap_conless_channel(struct l2cap_conn *conn, __le16 psm, str
 	if (chan->state != BT_BOUND && chan->state != BT_CONNECTED)
 		goto drop;
 
-	if (l2cap_pi(sk)->chan->imtu < skb->len)
+	if (chan->imtu < skb->len)
 		goto drop;
 
 	if (!chan->ops->recv(chan->data, skb))
@@ -3997,7 +3997,7 @@ static inline int l2cap_att_channel(struct l2cap_conn *conn, __le16 cid, struct
 	if (chan->state != BT_BOUND && chan->state != BT_CONNECTED)
 		goto drop;
 
-	if (l2cap_pi(sk)->chan->imtu < skb->len)
+	if (chan->imtu < skb->len)
 		goto drop;
 
 	if (!chan->ops->recv(chan->data, skb))
-- 
1.7.5.4

