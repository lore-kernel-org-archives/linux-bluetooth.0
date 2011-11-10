Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <kanak.gupta@stericsson.com>, <ulrik.lauren@stericsson.com>,
	<henrik.possung@stericsson.com>,
	Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH 1/2] Buetooth: Revert "Fixed wrong L2CAP Sock timer value"
Date: Thu, 10 Nov 2011 10:37:24 +0100
Message-ID: <1320917845-20135-2-git-send-email-andrzej.kaczmarek@tieto.com>
In-Reply-To: <1320917845-20135-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1320917845-20135-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This reverts commit 6be6b11f006840ba7d8d4b959b3fa0c522f8468a.

Commit changed sk_sndtimeo value unit to miliseconds while jiffies
should be used. This will cause invalid behaviour if timeout is
read or set via SO_SNDTIMEO sockopt which uses jiffies.

Signed-off-by: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
---
 net/bluetooth/l2cap_sock.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index 664762e..ae7dbe9 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -1039,7 +1039,7 @@ static struct sock *l2cap_sock_alloc(struct net *net, struct socket *sock, int p
 	INIT_LIST_HEAD(&bt_sk(sk)->accept_q);
 
 	sk->sk_destruct = l2cap_sock_destruct;
-	sk->sk_sndtimeo = L2CAP_CONN_TIMEOUT;
+	sk->sk_sndtimeo = msecs_to_jiffies(L2CAP_CONN_TIMEOUT);
 
 	sock_reset_flag(sk, SOCK_ZAPPED);
 
-- 
on behalf of ST-Ericsson

