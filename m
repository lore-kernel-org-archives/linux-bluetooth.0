Return-Path: <cyrus@holtmann.org>
From: Dean Jenkins <Dean_Jenkins@mentor.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <marcel@holtmann.org>, <gustavo@padovan.org>, <johan.hedberg@gmail.com>,
	<Joshua_Frkuska@mentor.com>, Dean Jenkins <Dean_Jenkins@mentor.com>
Subject: [PATCH v2 4/8] Bluetooth: l2cap_sock_shutdown() remove mutex_lock calls
Date: Tue, 23 Jun 2015 17:59:35 +0100
Message-ID: <1435078779-4436-5-git-send-email-Dean_Jenkins@mentor.com>
In-Reply-To: <1435078779-4436-1-git-send-email-Dean_Jenkins@mentor.com>
References: <1435078779-4436-1-git-send-email-Dean_Jenkins@mentor.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-bluetooth.vger.kernel.org>

Remove the calls
mutex_lock(&conn->chan_lock);
mutex_unlock(&conn->chan_lock);

because the conn structure is no longer being referenced in
l2cap_sock_shutdown() as instead the chan->state is being used
to determince the channel connection state.

Signed-off-by: Dean Jenkins <Dean_Jenkins@mentor.com>
---
 net/bluetooth/l2cap_sock.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index 78d1466..b81cb36 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -1092,7 +1092,6 @@ static int l2cap_sock_shutdown(struct socket *sock, int how)
 {
 	struct sock *sk = sock->sk;
 	struct l2cap_chan *chan;
-	struct l2cap_conn *conn;
 	int err = 0;
 
 	BT_DBG("sock %p, sk %p", sock, sk);
@@ -1113,13 +1112,9 @@ static int l2cap_sock_shutdown(struct socket *sock, int how)
 	chan = l2cap_pi(sk)->chan;
 	/* prevent chan structure from being freed whilst unlocked */
 	l2cap_chan_hold(chan);
-	conn = chan->conn;
 
 	BT_DBG("chan %p state %s", chan, state_to_string(chan->state));
 
-	if (conn)
-		mutex_lock(&conn->chan_lock);
-
 	l2cap_chan_lock(chan);
 
 	if (chan->mode == L2CAP_MODE_ERTM &&
@@ -1138,9 +1133,6 @@ static int l2cap_sock_shutdown(struct socket *sock, int how)
 
 	l2cap_chan_unlock(chan);
 
-	if (conn)
-		mutex_unlock(&conn->chan_lock);
-
 	l2cap_chan_put(chan);
 	sock_put(sk);
 
-- 
1.8.5.6
