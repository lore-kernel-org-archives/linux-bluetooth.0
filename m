Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [RFC] Bluetooth: Allow getting SCO options for not connected sockets
Date: Wed,  2 Jan 2013 11:47:35 -0300
Message-Id: <1357138055-28765-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Now, that we have proper support for deferred setup for SCO sockets it
is very convenient that we are able to get the socket options for
sockets that are not in the 'connected' state.

And makes the behaviour more consistent with what L2CAP does, for
example.

Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
---

Sending this as a RFC, because even though I couldn't think of any cases
that this new behaviour would surprise userspace applications, there
may be still be some.

 net/bluetooth/sco.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
index 531a93d..271320c 100644
--- a/net/bluetooth/sco.c
+++ b/net/bluetooth/sco.c
@@ -730,11 +730,6 @@ static int sco_sock_getsockopt_old(struct socket *sock, int optname, char __user
 
 	switch (optname) {
 	case SCO_OPTIONS:
-		if (sk->sk_state != BT_CONNECTED) {
-			err = -ENOTCONN;
-			break;
-		}
-
 		opts.mtu = sco_pi(sk)->conn->mtu;
 
 		BT_DBG("mtu %d", opts.mtu);
-- 
1.8.0.2

