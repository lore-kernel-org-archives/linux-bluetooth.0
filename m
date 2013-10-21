Return-Path: <cyrus@holtmann.org>
From: Gustavo Padovan <gustavo@padovan.org>
To: linux-bluetooth@vger.kernel.org
Cc: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
Subject: [PATCH 1/3] Bluetooth: Add L2CAP channel to skb private data
Date: Mon, 21 Oct 2013 18:22:24 -0200
Message-Id: <1382386946-19797-1-git-send-email-gustavo@padovan.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Gustavo Padovan <gustavo.padovan@collabora.co.uk>

Adding the channel to the skb private data makes possible to us know which
channel the skb we have came from.

Signed-off-by: Gustavo Padovan <gustavo.padovan@collabora.co.uk
---
 include/net/bluetooth/bluetooth.h | 1 +
 net/bluetooth/l2cap_sock.c        | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
index bf2ddff..a707a02 100644
--- a/include/net/bluetooth/bluetooth.h
+++ b/include/net/bluetooth/bluetooth.h
@@ -282,6 +282,7 @@ struct bt_skb_cb {
 	__u8 incoming;
 	__u16 expect;
 	__u8 force_active;
+	struct l2cap_chan *chan;
 	struct l2cap_ctrl control;
 	struct hci_req_ctrl req;
 	bdaddr_t bdaddr;
diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index a159b0e..cba3162 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -1174,6 +1174,8 @@ static struct sk_buff *l2cap_sock_alloc_skb_cb(struct l2cap_chan *chan,
 	if (!skb)
 		return ERR_PTR(err);
 
+	bt_cb(skb)->chan = chan;
+
 	return skb;
 }
 
-- 
1.8.3.1

