Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/2] Bluetooth: Add support for per socket msg_name callback
Date: Sun, 13 Oct 2013 12:55:28 -0700
Message-Id: <1381694129-51112-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This allows to add a per socket msg_name callback that can be used
for updating the msg_name information for recvmsg() system calls.

This feature is used by another patch to support address information
on L2CAP connectionless channels.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/bluetooth.h |  1 +
 net/bluetooth/af_bluetooth.c      | 15 +++++++++++----
 2 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
index 1d6e484..896aad8 100644
--- a/include/net/bluetooth/bluetooth.h
+++ b/include/net/bluetooth/bluetooth.h
@@ -221,6 +221,7 @@ struct bt_sock {
 	struct list_head accept_q;
 	struct sock *parent;
 	unsigned long flags;
+	void (*skb_msg_name)(struct sk_buff *, void *, int *);
 };
 
 enum {
diff --git a/net/bluetooth/af_bluetooth.c b/net/bluetooth/af_bluetooth.c
index 9c7e4ed..f0aadea 100644
--- a/net/bluetooth/af_bluetooth.c
+++ b/net/bluetooth/af_bluetooth.c
@@ -221,12 +221,12 @@ int bt_sock_recvmsg(struct kiocb *iocb, struct socket *sock,
 	if (flags & (MSG_OOB))
 		return -EOPNOTSUPP;
 
-	msg->msg_namelen = 0;
-
 	skb = skb_recv_datagram(sk, flags, noblock, &err);
 	if (!skb) {
-		if (sk->sk_shutdown & RCV_SHUTDOWN)
+		if (sk->sk_shutdown & RCV_SHUTDOWN) {
+			msg->msg_namelen = 0;
 			return 0;
+		}
 		return err;
 	}
 
@@ -238,9 +238,16 @@ int bt_sock_recvmsg(struct kiocb *iocb, struct socket *sock,
 
 	skb_reset_transport_header(skb);
 	err = skb_copy_datagram_iovec(skb, 0, msg->msg_iov, copied);
-	if (err == 0)
+	if (err == 0) {
 		sock_recv_ts_and_drops(msg, sk, skb);
 
+		if (bt_sk(sk)->skb_msg_name)
+			bt_sk(sk)->skb_msg_name(skb, msg->msg_name,
+						&msg->msg_namelen);
+		else
+			msg->msg_namelen = 0;
+	}
+
 	skb_free_datagram(sk, skb);
 
 	return err ? : copied;
-- 
1.8.3.1

