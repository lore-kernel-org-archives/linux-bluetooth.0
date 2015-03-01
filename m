Return-Path: <cyrus@holtmann.org>
From: Eyal Birger <eyal.birger@gmail.com>
To: davem@davemloft.net
Cc: willemb@google.com,
	edumazet@google.com,
	shmulik.ladkani@gmail.com,
	linux-bluetooth@vger.kernel.org,
	marcel@holtmann.org,
	netdev@vger.kernel.org,
	Eyal Birger <eyal.birger@gmail.com>
Subject: [PATCH net-next v3 3/7] net: rxrpc: change call to sock_recv_ts_and_drops() on rxrpc recvmsg to sock_recv_timestamp()
Date: Sun,  1 Mar 2015 14:58:27 +0200
Message-Id: <1425214711-9562-4-git-send-email-eyal.birger@gmail.com>
In-Reply-To: <1425214711-9562-1-git-send-email-eyal.birger@gmail.com>
References: <1425214711-9562-1-git-send-email-eyal.birger@gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Commit 3b885787ea4112 ("net: Generalize socket rx gap / receive queue overflow cmsg")
allowed receiving packet dropcount information as a socket level option.
RXRPC sockets recvmsg function was changed to support this by calling
sock_recv_ts_and_drops() instead of sock_recv_timestamp().

However, protocol families wishing to receive dropcount should call
sock_queue_rcv_skb() or set the dropcount specifically (as done
in packet_rcv()). This was not done for rxrpc and thus this feature
never worked on these sockets.

Formalizing this by not calling sock_recv_ts_and_drops() in rxrpc as
part of an effort to move skb->dropcount into skb->cb[]

Signed-off-by: Eyal Birger <eyal.birger@gmail.com>
---
 net/rxrpc/ar-recvmsg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/rxrpc/ar-recvmsg.c b/net/rxrpc/ar-recvmsg.c
index 4575485..d58ba70 100644
--- a/net/rxrpc/ar-recvmsg.c
+++ b/net/rxrpc/ar-recvmsg.c
@@ -150,7 +150,7 @@ int rxrpc_recvmsg(struct kiocb *iocb, struct socket *sock,
 				       &call->conn->trans->peer->srx, len);
 				msg->msg_namelen = len;
 			}
-			sock_recv_ts_and_drops(msg, &rx->sk, skb);
+			sock_recv_timestamp(msg, &rx->sk, skb);
 		}
 
 		/* receive the message */
-- 
2.1.4
