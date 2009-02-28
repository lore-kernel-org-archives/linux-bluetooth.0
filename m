Return-Path: <cyrus@holtmann.org>
From: "Gustavo F. Padovan" <gustavo@las.ic.unicamp.br>
To: linux-bluetooth@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] bluetooth: add write_lock_bh to __l2cap_chan_link
Date: Sat, 28 Feb 2009 02:02:25 -0300
Message-Id: <1235797347-1816-1-git-send-email-gustavo@las.ic.unicamp.br>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

fix race condition

Signed-off-by: Gustavo F. Padovan <gustavo@las.ic.unicamp.br>
---
 net/bluetooth/l2cap.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/net/bluetooth/l2cap.c b/net/bluetooth/l2cap.c
index ca4d3b4..355f375 100644
--- a/net/bluetooth/l2cap.c
+++ b/net/bluetooth/l2cap.c
@@ -175,12 +175,14 @@ static inline void __l2cap_chan_link(struct l2cap_chan_list *l, struct sock *sk)
 {
 	sock_hold(sk);
 
+	write_lock_bh(&l->lock);
 	if (l->head)
 		l2cap_pi(l->head)->prev_c = sk;
 
 	l2cap_pi(sk)->next_c = l->head;
 	l2cap_pi(sk)->prev_c = NULL;
 	l->head = sk;
+	write_unlock_bh(&l->lock);
 }
 
 static inline void l2cap_chan_unlink(struct l2cap_chan_list *l, struct sock *sk)
-- 
1.6.0.6

