Return-Path: <mathew.j.martineau@linux.intel.com>
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: linux-bluetooth@vger.kernel.org,
	daniel@iogearbox.net
Cc: marcel@holtmann.org,
	Mat Martineau <mathew.j.martineau@linux.intel.com>,
	Gustavo Padovan <gustavo.padovan@collabora.co.uk>,
	Willem de Bruijn <willemb@google.com>,
	Alexei Starovoitov <ast@kernel.org>
Subject: [PATCH v2] bluetooth, bpf: split sk_filter in l2cap_sock_recv_cb
Date: Mon, 25 Jul 2016 17:05:23 -0700
Message-Id: <20160726000523.11189-1-mathew.j.martineau@linux.intel.com>
List-ID: <linux-bluetooth.vger.kernel.org>

From: Daniel Borkmann <daniel@iogearbox.net>

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
acked, so dropping is not allowed. Instead, for ERTM, call sk_filter in
l2cap_data_rcv() so the packet can be dropped before the state machine
sees it.

Fixes: e328140fdacb ("Bluetooth: Use event-driven approach for handling ERTM receive buffer")
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
Cc: Willem de Bruijn <willemb@google.com>
Cc: Alexei Starovoitov <ast@kernel.org>
---

I modified the original patch to call sk_filter for ERTM before the packet is
handled by the state machine and to not set the filter locked flag. I tested
using l2test in ERTM mode, with and without a "randomly drop 1 in 64 packets"
filter attached.

Mat

---
 net/bluetooth/l2cap_core.c |  4 ++++
 net/bluetooth/l2cap_sock.c | 13 +++++++++++--
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 54ceb1f..d5de0ce 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -32,6 +32,7 @@
 
 #include <linux/debugfs.h>
 #include <linux/crc16.h>
+#include <linux/filter.h>
 
 #include <net/bluetooth/bluetooth.h>
 #include <net/bluetooth/hci_core.h>
@@ -6610,6 +6611,9 @@ static int l2cap_data_rcv(struct l2cap_chan *chan, struct sk_buff *skb)
 		goto drop;
 	}
 
+	if (chan->mode == L2CAP_MODE_ERTM && sk_filter(chan->data, skb))
+		goto drop;
+
 	if (!control->sframe) {
 		int err;
 
diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index 1842141..94daa2e 100644
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
-- 
2.9.2
