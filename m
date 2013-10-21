Return-Path: <cyrus@holtmann.org>
From: Gustavo Padovan <gustavo@padovan.org>
To: linux-bluetooth@vger.kernel.org
Cc: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
Subject: [PATCH 3/3] Bluetooth: Remove sk member from struct l2cap_chan
Date: Mon, 21 Oct 2013 18:22:26 -0200
Message-Id: <1382386946-19797-3-git-send-email-gustavo@padovan.org>
In-Reply-To: <1382386946-19797-1-git-send-email-gustavo@padovan.org>
References: <1382386946-19797-1-git-send-email-gustavo@padovan.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Gustavo Padovan <gustavo.padovan@collabora.co.uk>

There is no access to chan->sk in L2CAP core now. This change marks the
end of the task of splitting L2CAP between Core and Socket, thus sk is now
gone from struct l2cap_chan.

Signed-off-by: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
---
 include/net/bluetooth/l2cap.h | 2 --
 net/bluetooth/l2cap_sock.c    | 2 --
 2 files changed, 4 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index 3d922b9..5132990 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -435,8 +435,6 @@ struct l2cap_seq_list {
 #define L2CAP_SEQ_LIST_TAIL	0x8000
 
 struct l2cap_chan {
-	struct sock *sk;
-
 	struct l2cap_conn	*conn;
 	struct hci_conn		*hs_hcon;
 	struct hci_chan		*hs_hchan;
diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index cba3162..7cc24d2 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -1374,8 +1374,6 @@ static struct sock *l2cap_sock_alloc(struct net *net, struct socket *sock,
 
 	l2cap_chan_hold(chan);
 
-	chan->sk = sk;
-
 	l2cap_pi(sk)->chan = chan;
 
 	return sk;
-- 
1.8.3.1

