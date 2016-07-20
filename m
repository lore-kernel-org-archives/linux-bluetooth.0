Return-Path: <daniel@iogearbox.net>
From: Daniel Borkmann <daniel@iogearbox.net>
To: johan.hedberg@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	mathew.j.martineau@linux.intel.com,
	marcel@holtmann.org,
	daniel@iogearbox.net,
	Gustavo Padovan <gustavo.padovan@collabora.co.uk>,
	Willem de Bruijn <willemb@google.com>,
	Alexei Starovoitov <ast@kernel.org>
Subject: [PATCH net RFT] bluetooth, bpf: split sk_filter in l2cap_sock_recv_cb
Date: Wed, 20 Jul 2016 18:13:35 +0200
Message-Id: <ca6905bba5f094171cef36a9279fd991b30a2abc.1469030410.git.daniel@iogearbox.net>
List-ID: <linux-bluetooth.vger.kernel.org>

During an audit for sk_filter(), we found that rx_busy_skb handling
in l2cap_sock_recv_cb() and l2cap_sock_recvmsg() looks not quite as
intended.

The assumption from commit e328140fdacb ("Bluetooth: Use event-driven
approach for handling ERTM receive buffer") is that errors returned
from sock_queue_rcv_skb() are due to receive buffer shortage. However,
nothing should prevent doing a setsockopt() with SO_ATTACH_FILTER on
the socket, that could drop some of the incoming skbs when handled in
sock_queue_rcv_skb().

In that case sock_queue_rcv_skb() will return with -EPERM, propagated
from sk_filter() and if in L2CAP_MODE_ERTM mode, wrong assumption was
that we failed due to receive buffer being full. From that point onwards,
due to the to-be-dropped skb being held in rx_busy_skb, we cannot make
any forward progress as rx_busy_skb is never cleared from l2cap_sock_recvmsg(),
due to the filter drop verdict over and over coming from sk_filter().
Meanwhile, in l2cap_sock_recv_cb() all new incoming skbs are being
dropped due to rx_busy_skb being occupied.

Instead, just use __sock_queue_rcv_skb() where an error really tells
that there's a receive buffer issue. Split the sk_filter() and only
enable it for non-L2CAP_MODE_ERTM modes since at this point in time the
skb has already been through the ERTM state machine and it has been
acked, so dropping is not allowed. Since skipping sk_filter() for ERTM
may have consequences wrt future abi, we need to generally disallow
filters to be attached for this mode. So set SOCK_FILTER_LOCKED during
socket initialization. Given that noone run into this issue before as
it otherwise would have been noticed and fixed, there should be little
risk of any breakage. The SOCK_FILTER_LOCKED can later on be lifted
should there be a use case to call sk_filter() at a safe place for such
kind of sockets.

Fixes: e328140fdacb ("Bluetooth: Use event-driven approach for handling ERTM receive buffer")
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Cc: Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
Cc: Willem de Bruijn <willemb@google.com>
Cc: Alexei Starovoitov <ast@kernel.org>
---
 I don't have a BT setup at hand, so compile tested only at this time.
 Would be great if some of the BT folks could help out or take over if
 possible. Thanks!

 net/bluetooth/l2cap_sock.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index 388ee8b..10ba801 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -1019,7 +1019,7 @@ static int l2cap_sock_recvmsg(struct socket *sock, struct msghdr *msg,
 		goto done;
 
 	if (pi->rx_busy_skb) {
-		if (!sock_queue_rcv_skb(sk, pi->rx_busy_skb))
+		if (!__sock_queue_rcv_skb(sk, pi->rx_busy_skb))
 			pi->rx_busy_skb = NULL;
 		else
 			goto done;
@@ -1270,7 +1270,16 @@ static int l2cap_sock_recv_cb(struct l2cap_chan *chan, struct sk_buff *skb)
 		goto done;
 	}
 
-	err = sock_queue_rcv_skb(sk, skb);
+	if (chan->mode != L2CAP_MODE_ERTM) {
+		/* Even if no filter is attached, we could potentially
+		 * get errors from security modules, etc.
+		 */
+		err = sk_filter(sk, skb);
+		if (err)
+			goto done;
+	}
+
+	err = __sock_queue_rcv_skb(sk, skb);
 
 	/* For ERTM, handle one skb that doesn't fit into the recv
 	 * buffer.  This is important to do because the data frames
@@ -1559,6 +1568,9 @@ static void l2cap_sock_init(struct sock *sk, struct sock *parent)
 
 	/* Default config options */
 	chan->flush_to = L2CAP_DEFAULT_FLUSH_TO;
+	/* In ERTM mode, no socket filter can be attached. */
+	if (chan->mode == L2CAP_MODE_ERTM)
+		sock_set_flag(sk, SOCK_FILTER_LOCKED);
 
 	chan->data = sk;
 	chan->ops = &l2cap_chan_ops;
-- 
1.9.3
