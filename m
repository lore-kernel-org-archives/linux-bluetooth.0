Return-Path: <cyrus@holtmann.org>
From: Dean Jenkins <Dean_Jenkins@mentor.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <marcel@holtmann.org>, <gustavo@padovan.org>, <johan.hedberg@gmail.com>,
	<Joshua_Frkuska@mentor.com>, Dean Jenkins <Dean_Jenkins@mentor.com>, Kautuk
 Consul <Kautuk_Consul@mentor.com>
Subject: [PATCH v1 1/7] Bluetooth: L2CAP ERTM shutdown protect sk and chan
Date: Sat, 6 Jun 2015 00:11:10 +0100
Message-ID: <1433545876-15800-2-git-send-email-Dean_Jenkins@mentor.com>
In-Reply-To: <1433545876-15800-1-git-send-email-Dean_Jenkins@mentor.com>
References: <1433545876-15800-1-git-send-email-Dean_Jenkins@mentor.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-bluetooth.vger.kernel.org>

During execution of l2cap_sock_shutdown() which might
sleep, the sk and chan structures can be in an unlocked
condition which potentially allows the structures to be
freed by other running threads. Therefore, there is a
possibility of a malfunction or memory reuse after being
freed.

Keep the sk and chan structures alive during the
exection of l2cap_sock_shutdown() by using their
respective hold and put functions. This allows the structures
to be freeable at the end of l2cap_sock_shutdown().

Signed-off-by: Kautuk Consul <Kautuk_Consul@mentor.com>
Signed-off-by: Dean Jenkins <Dean_Jenkins@mentor.com>
---
 net/bluetooth/l2cap_sock.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index 2442877..8321685 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -1098,7 +1098,12 @@ static int l2cap_sock_shutdown(struct socket *sock, int how)
 	if (!sk)
 		return 0;
 
+	/* prevent sk structure from being freed whilst unlocked */
+	sock_hold(sk);
+
 	chan = l2cap_pi(sk)->chan;
+	/* prevent chan structure from being freed whilst unlocked */
+	l2cap_chan_hold(chan);
 	conn = chan->conn;
 
 	BT_DBG("chan %p state %s", chan, state_to_string(chan->state));
@@ -1134,6 +1139,10 @@ static int l2cap_sock_shutdown(struct socket *sock, int how)
 	if (conn)
 		mutex_unlock(&conn->chan_lock);
 
+	/* allow chan and sk structures to be freed */
+	l2cap_chan_put(chan);
+	sock_put(sk);
+
 	return err;
 }
 
-- 
1.8.5.6
