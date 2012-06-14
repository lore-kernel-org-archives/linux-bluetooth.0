Return-Path: <cyrus@holtmann.org>
Date: Fri, 15 Jun 2012 02:16:20 +0900 (JST)
Message-Id: <20120615.021620.1313543900173654505.yamato@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/8] Added /proc/net/bnep via bt_procfs_init()
From: Masatake YAMATO <yamato@redhat.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Added /proc/net/bnep via bt_procfs_init().


Signed-off-by: Masatake YAMATO <yamato@redhat.com>
---
 net/bluetooth/bnep/sock.c |   22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/bnep/sock.c b/net/bluetooth/bnep/sock.c
index 180bfc4..b5bccd2 100644
--- a/net/bluetooth/bnep/sock.c
+++ b/net/bluetooth/bnep/sock.c
@@ -45,6 +45,10 @@
 
 #include "bnep.h"
 
+static struct bt_sock_list bnep_sk_list = {
+	.lock = __RW_LOCK_UNLOCKED(bnep_sk_list.lock)
+};
+
 static int bnep_sock_release(struct socket *sock)
 {
 	struct sock *sk = sock->sk;
@@ -54,6 +58,8 @@ static int bnep_sock_release(struct socket *sock)
 	if (!sk)
 		return 0;
 
+	bt_sock_unlink(&bnep_sk_list, sk);
+
 	sock_orphan(sk);
 	sock_put(sk);
 	return 0;
@@ -220,6 +226,7 @@ static int bnep_sock_create(struct net *net, struct socket *sock, int protocol,
 	sk->sk_protocol = protocol;
 	sk->sk_state	= BT_OPEN;
 
+	bt_sock_link(&bnep_sk_list, sk);
 	return 0;
 }
 
@@ -238,19 +245,30 @@ int __init bnep_sock_init(void)
 		return err;
 
 	err = bt_sock_register(BTPROTO_BNEP, &bnep_sock_family_ops);
-	if (err < 0)
+	if (err < 0) {
+	  	BT_ERR("Can't register BNEP socket");
 		goto error;
+	}
+
+	err = bt_procfs_init(THIS_MODULE, &init_net, "bnep", &bnep_sk_list, NULL);
+	if (err < 0) {
+		BT_ERR("Failed to create BNEP proc file");
+		bt_sock_unregister(BTPROTO_BNEP);
+		goto error;		
+	}
+
+	BT_INFO("BNEP socket layer initialized");
 
 	return 0;
 
 error:
-	BT_ERR("Can't register BNEP socket");
 	proto_unregister(&bnep_proto);
 	return err;
 }
 
 void __exit bnep_sock_cleanup(void)
 {
+	bt_procfs_cleanup(&init_net, "bnep");
 	if (bt_sock_unregister(BTPROTO_BNEP) < 0)
 		BT_ERR("Can't unregister BNEP socket");
 
-- 
1.7.10.2

