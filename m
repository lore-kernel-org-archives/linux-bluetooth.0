Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Denis Kenzior <denkenz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [RFC 2/2] hci_sock: Fix recvmsg return value
Date: Thu, 23 Jun 2016 12:58:33 -0500
Message-Id: <1466704713-3725-2-git-send-email-denkenz@gmail.com>
In-Reply-To: <1466704713-3725-1-git-send-email-denkenz@gmail.com>
References: <1466704713-3725-1-git-send-email-denkenz@gmail.com>
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
---
 net/bluetooth/hci_sock.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/bluetooth/hci_sock.c b/net/bluetooth/hci_sock.c
index 1298d72..12e9294 100644
--- a/net/bluetooth/hci_sock.c
+++ b/net/bluetooth/hci_sock.c
@@ -1048,6 +1048,7 @@ static int hci_sock_recvmsg(struct socket *sock, struct msghdr *msg,
 	struct sock *sk = sock->sk;
 	struct sk_buff *skb;
 	int copied, err;
+	unsigned int skblen;
 
 	BT_DBG("sock %p, sk %p", sock, sk);
 
@@ -1064,6 +1065,7 @@ static int hci_sock_recvmsg(struct socket *sock, struct msghdr *msg,
 	if (!skb)
 		return err;
 
+	skblen = skb->len;
 	copied = skb->len;
 	if (len < copied) {
 		msg->msg_flags |= MSG_TRUNC;
@@ -1089,6 +1091,9 @@ static int hci_sock_recvmsg(struct socket *sock, struct msghdr *msg,
 
 	skb_free_datagram(sk, skb);
 
+	if (msg->msg_flags & MSG_TRUNC)
+		copied = skblen;
+
 	return err ? : copied;
 }
 
-- 
2.4.10

