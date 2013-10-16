Return-Path: <cyrus@holtmann.org>
From: Gustavo Padovan <gustavo@padovan.org>
To: linux-bluetooth@vger.kernel.org
Cc: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
Subject: [PATCH 7/7] Bluetooth: Remove sk member from struct l2cap_chan
Date: Wed, 16 Oct 2013 16:08:35 -0300
Message-Id: <1381950515-25256-7-git-send-email-gustavo@padovan.org>
In-Reply-To: <1381950515-25256-1-git-send-email-gustavo@padovan.org>
References: <1381950515-25256-1-git-send-email-gustavo@padovan.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Gustavo Padovan <gustavo.padovan@collabora.co.uk>

There is no access to chan->sk in L2CAP core now. This change marks the
of the task of splitting L2CAP between Core and Socket, thus sk is now
gone from struct l2cap_chan.

Signed-off-by: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
---
 include/net/bluetooth/l2cap.h | 2 --
 net/bluetooth/l2cap_sock.c    | 2 --
 2 files changed, 4 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index af5eb23..65356bf 100644
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
index 5c84f8a..93fc464 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -1371,8 +1371,6 @@ static struct sock *l2cap_sock_alloc(struct net *net, struct socket *sock,
 
 	l2cap_chan_hold(chan);
 
-	chan->sk = sk;
-
 	l2cap_pi(sk)->chan = chan;
 
 	return sk;
-- 
1.8.3.1

