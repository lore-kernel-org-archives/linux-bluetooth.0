Return-Path: <cyrus@holtmann.org>
From: Gustavo Padovan <gustavo@padovan.org>
To: linux-bluetooth@vger.kernel.org
Cc: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
Subject: [PATCH] Bluetooth: Fix skb allocation check for A2MP
Date: Sat, 22 Dec 2012 01:22:53 -0200
Message-Id: <1356146573-9639-1-git-send-email-gustavo@padovan.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Gustavo Padovan <gustavo.padovan@collabora.co.uk>

vtable's method alloc_skb() needs to return a ERR_PTR in case of err and
not a NULL.

Signed-off-by: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
---
 net/bluetooth/a2mp.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/a2mp.c b/net/bluetooth/a2mp.c
index 0a2ec84..cd9410c 100644
--- a/net/bluetooth/a2mp.c
+++ b/net/bluetooth/a2mp.c
@@ -693,7 +693,13 @@ static void a2mp_chan_state_change_cb(struct l2cap_chan *chan, int state, int er
 static struct sk_buff *a2mp_chan_alloc_skb_cb(struct l2cap_chan *chan,
 					      unsigned long len, int nb)
 {
-	return bt_skb_alloc(len, GFP_KERNEL);
+	struct sk_buff *skb;
+
+	skb = bt_skb_alloc(len, GFP_KERNEL);
+	if (!skb)
+		return ERR_PTR(-ENOMEM);
+
+	return skb;
 }
 
 static struct l2cap_ops a2mp_chan_ops = {
-- 
1.8.0.2

