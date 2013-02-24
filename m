Return-Path: <cyrus@holtmann.org>
From: David Herrmann <dh.herrmann@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Marcel Holtmann <marcel@holtmann.org>,
	Gustavo Padovan <gustavo@padovan.org>,
	David Herrmann <dh.herrmann@gmail.com>
Subject: [PATCH 02/16] Bluetooth: change bt_sock_unregister() to return void
Date: Sun, 24 Feb 2013 19:36:52 +0100
Message-Id: <1361731026-7428-3-git-send-email-dh.herrmann@gmail.com>
In-Reply-To: <1361731026-7428-1-git-send-email-dh.herrmann@gmail.com>
References: <1361731026-7428-1-git-send-email-dh.herrmann@gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

There is no reason a caller ever wants to check the return type of this
call. _Iff_ a user successfully called bt_sock_register(), they're allowed
to call bt_sock_unregister().
All other calls in the kernel (device_del, device_unregister, kfree(), ..)
that are logically equivalent return void. Lets not make callers think
they have to check the return type of this call and instead simply return
void.

We guarantee that after bt_sock_unregister() is called, the socket type
_is_ unregistered. If that is not what the caller wants, they're using the
wrong function, anyway.

Signed-off-by: David Herrmann <dh.herrmann@gmail.com>
---
 include/net/bluetooth/bluetooth.h |  2 +-
 net/bluetooth/af_bluetooth.c      | 15 +++------------
 2 files changed, 4 insertions(+), 13 deletions(-)

diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
index 2554b3f..d3222d1 100644
--- a/include/net/bluetooth/bluetooth.h
+++ b/include/net/bluetooth/bluetooth.h
@@ -209,7 +209,7 @@ struct bt_sock_list {
 };
 
 int  bt_sock_register(int proto, const struct net_proto_family *ops);
-int  bt_sock_unregister(int proto);
+void bt_sock_unregister(int proto);
 void bt_sock_link(struct bt_sock_list *l, struct sock *s);
 void bt_sock_unlink(struct bt_sock_list *l, struct sock *s);
 int  bt_sock_recvmsg(struct kiocb *iocb, struct socket *sock,
diff --git a/net/bluetooth/af_bluetooth.c b/net/bluetooth/af_bluetooth.c
index 5355df6..c9383bd 100644
--- a/net/bluetooth/af_bluetooth.c
+++ b/net/bluetooth/af_bluetooth.c
@@ -92,23 +92,14 @@ int bt_sock_register(int proto, const struct net_proto_family *ops)
 }
 EXPORT_SYMBOL(bt_sock_register);
 
-int bt_sock_unregister(int proto)
+void bt_sock_unregister(int proto)
 {
-	int err = 0;
-
 	if (proto < 0 || proto >= BT_MAX_PROTO)
-		return -EINVAL;
+		return;
 
 	write_lock(&bt_proto_lock);
-
-	if (!bt_proto[proto])
-		err = -ENOENT;
-	else
-		bt_proto[proto] = NULL;
-
+	bt_proto[proto] = NULL;
 	write_unlock(&bt_proto_lock);
-
-	return err;
 }
 EXPORT_SYMBOL(bt_sock_unregister);
 
-- 
1.8.1.4
