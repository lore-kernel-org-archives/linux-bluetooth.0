Return-Path: <cyrus@holtmann.org>
From: Dean Jenkins <Dean_Jenkins@mentor.com>
To: Dean Jenkins <Dean_Jenkins@mentor.com>, <luiz.dentz@gmail.com>,
	<marcel@holtmann.org>, <linux-bluetooth@vger.kernel.org>
CC: Harish Jenny K N <harish_kandiga@mentor.com>, <gustavo@padovan.org>,
	<johan.hedberg@gmail.com>
Subject: [PATCH v1 3/3] Bluetooth: l2cap_disconnection_req priority over shutdown
Date: Wed, 14 Oct 2015 12:18:47 +0200
Message-ID: <1444817927-18834-4-git-send-email-Dean_Jenkins@mentor.com>
In-Reply-To: <1444817927-18834-1-git-send-email-Dean_Jenkins@mentor.com>
References: <1444817927-18834-1-git-send-email-Dean_Jenkins@mentor.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-bluetooth.vger.kernel.org>

There is a L2CAP protocol race between the local peer and
the remote peer demanding disconnection of the L2CAP link.

When L2CAP ERTM is used, l2cap_sock_shutdown() can be called
from userland to disconnect L2CAP. However, there can be a
delay introduced by waiting for ACKs. During this waiting
period, the remote peer may have sent a Disconnection Request.
Therefore, recheck the shutdown status of the socket
after waiting for ACKs because there is no need to do
further processing if the connection has gone.

Signed-off-by: Dean Jenkins <Dean_Jenkins@mentor.com>
Signed-off-by: Harish Jenny K N <harish_kandiga@mentor.com>
---
 net/bluetooth/l2cap_sock.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index d06fb54..1bb5515 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -1129,9 +1129,17 @@ static int l2cap_sock_shutdown(struct socket *sock, int how)
 
 	if (chan->mode == L2CAP_MODE_ERTM &&
 	    chan->unacked_frames > 0 &&
-	    chan->state == BT_CONNECTED)
+	    chan->state == BT_CONNECTED) {
 		err = __l2cap_wait_ack(sk, chan);
 
+		/* After waiting for ACKs, check whether shutdown
+		 * has already been actioned to close the L2CAP
+		 * link such as by l2cap_disconnection_req().
+		 */
+		if (sk->sk_shutdown)
+			goto has_shutdown;
+	}
+
 	sk->sk_shutdown = SHUTDOWN_MASK;
 	release_sock(sk);
 
@@ -1162,6 +1170,7 @@ static int l2cap_sock_shutdown(struct socket *sock, int how)
 		err = bt_sock_wait_state(sk, BT_CLOSED,
 					 sk->sk_lingertime);
 
+has_shutdown:
 	l2cap_chan_put(chan);
 	sock_put(sk);
 
-- 
1.8.5.6
