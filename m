Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/2] Bluetooth: Provide default implementation for L2CAP alloc_skb callback
Date: Mon, 16 Jun 2014 12:25:56 +0200
Message-Id: <1402914357-27572-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

For all internal L2CAP channels, the alloc_skb callback will be exactly
the same. To make it simple, provide a default implementation that all
internal channel can just reference.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
Tested-by: Jukka Rissanen <jukka.rissanen@linux.intel.com>
---
 include/net/bluetooth/l2cap.h | 13 +++++++++++++
 net/bluetooth/a2mp.c          | 17 +++--------------
 2 files changed, 16 insertions(+), 14 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index 92511034d1d4..525c75abe1d4 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -857,6 +857,19 @@ static inline long l2cap_chan_no_get_sndtimeo(struct l2cap_chan *chan)
 	return 0;
 }
 
+static inline struct sk_buff *l2cap_chan_no_alloc_skb(struct l2cap_chan *chan,
+						      unsigned long hdr_len,
+						      unsigned long len, int nb)
+{
+	struct sk_buff *skb;
+
+	skb = bt_skb_alloc(hdr_len + len, GFP_KERNEL);
+	if (!skb)
+		return ERR_PTR(-ENOMEM);
+
+	return skb;
+}
+
 extern bool disable_ertm;
 
 int l2cap_init_sockets(void);
diff --git a/net/bluetooth/a2mp.c b/net/bluetooth/a2mp.c
index 0fd8d1dda709..4e03a77b5a80 100644
--- a/net/bluetooth/a2mp.c
+++ b/net/bluetooth/a2mp.c
@@ -692,25 +692,14 @@ static void a2mp_chan_state_change_cb(struct l2cap_chan *chan, int state,
 	}
 }
 
-static struct sk_buff *a2mp_chan_alloc_skb_cb(struct l2cap_chan *chan,
-					      unsigned long hdr_len,
-					      unsigned long len, int nb)
-{
-	struct sk_buff *skb;
-
-	skb = bt_skb_alloc(hdr_len + len, GFP_KERNEL);
-	if (!skb)
-		return ERR_PTR(-ENOMEM);
-
-	return skb;
-}
-
 static const struct l2cap_ops a2mp_chan_ops = {
 	.name = "L2CAP A2MP channel",
 	.recv = a2mp_chan_recv_cb,
 	.close = a2mp_chan_close_cb,
 	.state_change = a2mp_chan_state_change_cb,
-	.alloc_skb = a2mp_chan_alloc_skb_cb,
+
+	/* Use default kernel implementation */
+	.alloc_skb = l2cap_chan_no_alloc_skb,
 
 	/* Not implemented for A2MP */
 	.new_connection = l2cap_chan_no_new_connection,
-- 
1.9.3

