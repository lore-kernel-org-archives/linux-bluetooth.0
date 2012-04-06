Return-Path: <cyrus@holtmann.org>
From: Gustavo Padovan <gustavo@padovan.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/2] Bluetooth: rename parameter of alloc_skb
Date: Fri,  6 Apr 2012 20:15:48 -0300
Message-Id: <1333754148-18796-2-git-send-email-gustavo@padovan.org>
In-Reply-To: <1333754148-18796-1-git-send-email-gustavo@padovan.org>
References: <1333754148-18796-1-git-send-email-gustavo@padovan.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

'flags' makes much more sense than 'nb'.

Signed-off-by: Gustavo Padovan <gustavo@padovan.org>
---
 include/net/bluetooth/l2cap.h |    2 +-
 net/bluetooth/l2cap_sock.c    |    4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index b74b3f9..193d3a1 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -522,7 +522,7 @@ struct l2cap_ops {
 	void			(*close) (void *data);
 	void			(*state_change) (void *data, int state);
 	struct sk_buff		*(*alloc_skb) (struct l2cap_chan *chan,
-					unsigned long len, int nb);
+					unsigned long len, int flags);
 
 };
 
diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index 1463b5d..5d68b51 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -927,12 +927,12 @@ static void l2cap_sock_state_change_cb(void *data, int state)
 }
 
 static struct sk_buff *l2cap_sock_alloc_skb_cb(struct l2cap_chan *chan,
-					       unsigned long len, int nb)
+					       unsigned long len, int flags)
 {
 	struct sk_buff *skb;
 	int err;
 
-	skb = bt_skb_send_alloc(chan->sk, len, nb, &err);
+	skb = bt_skb_send_alloc(chan->sk, len, flags, &err);
 	if (!skb)
 		return (ERR_PTR(err));
 
-- 
1.7.7.6

