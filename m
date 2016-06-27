Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Denis Kenzior <denkenz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 1/2] af_bluetooth: Fix recvmsg return value
Date: Mon, 27 Jun 2016 11:01:12 -0500
Message-Id: <1467043273-3781-1-git-send-email-denkenz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

If recvmsg is called with a destination buffer that is too small to
receive the contents of skb in its entirety, the return value from
recvmsg was inconsistent with common SOCK_SEQPACKET or SOCK_DGRAM
semantics.

If destination buffer provided by userspace is too small (e.g. len <
copied), then MSG_TRUNC flag is set and copied is returned.  Instead, it
should return the length of the message, which is consistent with how
other datagram based sockets act.  Quoting 'man recv':

"All  three calls return the length of the message on successful comple‐
tion.  If a message is too long to fit in the supplied  buffer,  excess
bytes  may  be discarded depending on the type of socket the message is
received from."

and

"MSG_TRUNC (since Linux 2.2)

    For   raw   (AF_PACKET),   Internet   datagram   (since    Linux
    2.4.27/2.6.8),  netlink  (since Linux 2.6.22), and UNIX datagram
    (since Linux 3.4) sockets: return the real length of the packet
    or datagram, even when it was longer than the passed buffer."

Signed-off-by: Denis Kenzior <denkenz@gmail.com>
---
 net/bluetooth/af_bluetooth.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/bluetooth/af_bluetooth.c b/net/bluetooth/af_bluetooth.c
index 955eda9..eab6f62 100644
--- a/net/bluetooth/af_bluetooth.c
+++ b/net/bluetooth/af_bluetooth.c
@@ -215,6 +215,7 @@ int bt_sock_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
 	struct sock *sk = sock->sk;
 	struct sk_buff *skb;
 	size_t copied;
+	size_t skblen;
 	int err;
 
 	BT_DBG("sock %p sk %p len %zu", sock, sk, len);
@@ -230,6 +231,7 @@ int bt_sock_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
 		return err;
 	}
 
+	skblen = skb->len;
 	copied = skb->len;
 	if (len < copied) {
 		msg->msg_flags |= MSG_TRUNC;
@@ -248,6 +250,9 @@ int bt_sock_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
 
 	skb_free_datagram(sk, skb);
 
+	if (msg->msg_flags & MSG_TRUNC)
+		copied = skblen;
+
 	return err ? : copied;
 }
 EXPORT_SYMBOL(bt_sock_recvmsg);
-- 
2.4.10

