Return-Path: <cyrus@holtmann.org>
From: Dean Jenkins <Dean_Jenkins@mentor.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <marcel@holtmann.org>, <gustavo@padovan.org>, <johan.hedberg@gmail.com>,
	<Joshua_Frkuska@mentor.com>, Dean Jenkins <Dean_Jenkins@mentor.com>
Subject: [PATCH v2 5/8] Bluetooth: l2cap_sock_shutdown() reduce scope of chan locking
Date: Tue, 23 Jun 2015 17:59:36 +0100
Message-ID: <1435078779-4436-6-git-send-email-Dean_Jenkins@mentor.com>
In-Reply-To: <1435078779-4436-1-git-send-email-Dean_Jenkins@mentor.com>
References: <1435078779-4436-1-git-send-email-Dean_Jenkins@mentor.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-bluetooth.vger.kernel.org>

The only place where chan locking is needed is the call to
l2cap_chan_close(chan, 0) which if necessary closes the channel.
Therefore, move the l2cap_chan_lock(chan) and
l2cap_chan_lock(chan) locking calls to around
l2cap_chan_close(chan, 0).

This allows __l2cap_wait_ack(sk, chan) to be called with no
chan locks being held so L2CAP messaging over the ACL link
can be done unimpaired.

Signed-off-by: Dean Jenkins <Dean_Jenkins@mentor.com>
---
 net/bluetooth/l2cap_sock.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index b81cb36..bdf8f4c 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -1115,24 +1115,22 @@ static int l2cap_sock_shutdown(struct socket *sock, int how)
 
 	BT_DBG("chan %p state %s", chan, state_to_string(chan->state));
 
-	l2cap_chan_lock(chan);
-
 	if (chan->mode == L2CAP_MODE_ERTM &&
 	    chan->unacked_frames > 0 &&
 	    chan->state == BT_CONNECTED)
 		err = __l2cap_wait_ack(sk, chan);
 
+	l2cap_chan_lock(chan);
 	release_sock(sk);
 	l2cap_chan_close(chan, 0);
 	lock_sock(sk);
+	l2cap_chan_unlock(chan);
 
 	if (sock_flag(sk, SOCK_LINGER) && sk->sk_lingertime &&
 	    !(current->flags & PF_EXITING))
 		err = bt_sock_wait_state(sk, BT_CLOSED,
 					 sk->sk_lingertime);
 
-	l2cap_chan_unlock(chan);
-
 	l2cap_chan_put(chan);
 	sock_put(sk);
 
-- 
1.8.5.6
