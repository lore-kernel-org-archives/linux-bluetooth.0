Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] bluetooth: fix shutdown on SCO sockets
Date: Thu, 12 May 2011 11:13:15 +0300
Message-Id: <1305187995-5780-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.dentz-von@nokia.com>

shutdown should wait for SCO link to be properly disconnected before
detroying the socket, otherwise an application using the socket may
assume link is properly disconnected before it really happens which
can be a problem when e.g synchronizing profile switch.

Signed-off-by: Luiz Augusto von Dentz <luiz.dentz-von@nokia.com>
---
 net/bluetooth/sco.c |   13 ++++++++++++-
 1 files changed, 12 insertions(+), 1 deletions(-)

diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
index 42fdffd..cb4fb78 100644
--- a/net/bluetooth/sco.c
+++ b/net/bluetooth/sco.c
@@ -369,6 +369,15 @@ static void __sco_sock_close(struct sock *sk)
 
 	case BT_CONNECTED:
 	case BT_CONFIG:
+		if (sco_pi(sk)->conn) {
+			sk->sk_state = BT_DISCONN;
+			sco_sock_set_timer(sk, SCO_DISCONN_TIMEOUT);
+			hci_conn_put(sco_pi(sk)->conn->hcon);
+			sco_pi(sk)->conn->hcon = NULL;
+		} else
+			sco_chan_del(sk, ECONNRESET);
+		break;
+
 	case BT_CONNECT:
 	case BT_DISCONN:
 		sco_chan_del(sk, ECONNRESET);
@@ -819,7 +828,9 @@ static void sco_chan_del(struct sock *sk, int err)
 		conn->sk = NULL;
 		sco_pi(sk)->conn = NULL;
 		sco_conn_unlock(conn);
-		hci_conn_put(conn->hcon);
+
+		if (conn->hcon)
+			hci_conn_put(conn->hcon);
 	}
 
 	sk->sk_state = BT_CLOSED;
-- 
1.7.1

