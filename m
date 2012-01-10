Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC 1/2] Bluetooth: make use of MSG_DONTROUTE flag in L2CAP sockets
Date: Tue, 10 Jan 2012 15:26:27 +0200
Message-Id: <1326201988-17651-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This use MSG_DONTROUTE to send a single message with highest possible
priority without having to rely on socket options.

This is useful for RFCOMM which relies on socket interface to send frames
to L2CAP, but since some of this frames are actual commands that can
timeout they should be sent as soon as possible.

For userspace this also offer the convenience of not having to use
setsockopt several times when only a single/some messages needs to be
prioritize.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/l2cap_sock.c |    9 ++++++++-
 1 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index c57027f..133c1f2 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -699,6 +699,7 @@ static int l2cap_sock_sendmsg(struct kiocb *iocb, struct socket *sock, struct ms
 	struct sock *sk = sock->sk;
 	struct l2cap_chan *chan = l2cap_pi(sk)->chan;
 	int err;
+	u32 priority;
 
 	BT_DBG("sock %p, sk %p", sock, sk);
 
@@ -711,12 +712,18 @@ static int l2cap_sock_sendmsg(struct kiocb *iocb, struct socket *sock, struct ms
 
 	lock_sock(sk);
 
+	priority = sk->sk_priority;
+
+	/* MSG_DONTROUTE send message at maximum possible priority */
+	if ((msg->msg_flags & MSG_DONTROUTE) && priority < HCI_PRIO_MAX - 1)
+		priority = HCI_PRIO_MAX - 1;
+
 	if (sk->sk_state != BT_CONNECTED) {
 		release_sock(sk);
 		return -ENOTCONN;
 	}
 
-	err = l2cap_chan_send(chan, msg, len, sk->sk_priority);
+	err = l2cap_chan_send(chan, msg, len, priority);
 
 	release_sock(sk);
 	return err;
-- 
1.7.7.5

