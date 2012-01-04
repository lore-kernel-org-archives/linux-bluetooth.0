Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <kanak.gupta@stericsson.com>,
	Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH 1/2] Bluetooth: Fix sk_sndtimeo initialization for L2CAP socket
Date: Wed, 4 Jan 2012 12:10:41 +0100
Message-ID: <1325675442-24658-2-git-send-email-andrzej.kaczmarek@tieto.com>
In-Reply-To: <1325675442-24658-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1325675442-24658-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

sk_sndtime value should be specified in jiffies thus initial value
needs to be converted from miliseconds. Otherwise this timeout is
unreliable when CONFIG_HZ is not set to 1000.

Signed-off-by: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
---
 net/bluetooth/l2cap_sock.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index c61d967..c57027f 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -1002,7 +1002,7 @@ static struct sock *l2cap_sock_alloc(struct net *net, struct socket *sock, int p
 	INIT_LIST_HEAD(&bt_sk(sk)->accept_q);
 
 	sk->sk_destruct = l2cap_sock_destruct;
-	sk->sk_sndtimeo = L2CAP_CONN_TIMEOUT;
+	sk->sk_sndtimeo = msecs_to_jiffies(L2CAP_CONN_TIMEOUT);
 
 	sock_reset_flag(sk, SOCK_ZAPPED);
 
-- 
on behalf of ST-Ericsson

