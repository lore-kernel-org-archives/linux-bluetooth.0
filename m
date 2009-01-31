Return-Path: <cyrus@holtmann.org>
Message-ID: <4983E6D3.6010409@gmail.com>
Date: Sat, 31 Jan 2009 13:51:15 +0800
From: Dave Young <hidave.darkstar@gmail.com>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 marcel@holtmann.org, davem@davemloft.net
Subject: [PATCH] bluetooth: CONFIG_DEBUG_LOCK_ALLOC ifdefs remove
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>


Due to lockdep changes the CONFIG_DEBUG_LOCK_ALLOC ifdef is not needed now, just remove it here.

The following commit fixed the !lockdep build warnings:

commit e8f6fbf62de37cbc2e179176ac7010d5f4396b67
Author: Ingo Molnar <mingo@elte.hu>
Date:   Wed Nov 12 01:38:36 2008 +0000

    lockdep: include/linux/lockdep.h - fix warning in net/bluetooth/af_bluetooth.c

Signed-off-by: Dave Young <hidave.darkstar@gmail.com>
---
net/bluetooth/af_bluetooth.c |    6 ------
1 file changed, 6 deletions(-)

diff -uprN a/net/bluetooth/af_bluetooth.c b/net/bluetooth/af_bluetooth.c
--- a/net/bluetooth/af_bluetooth.c	2009-01-31 13:38:45.000000000 +0800
+++ b/net/bluetooth/af_bluetooth.c	2009-01-31 13:38:58.000000000 +0800
@@ -48,7 +48,6 @@
 static struct net_proto_family *bt_proto[BT_MAX_PROTO];
 static DEFINE_RWLOCK(bt_proto_lock);
 
-#ifdef CONFIG_DEBUG_LOCK_ALLOC
 static struct lock_class_key bt_lock_key[BT_MAX_PROTO];
 static const char *bt_key_strings[BT_MAX_PROTO] = {
 	"sk_lock-AF_BLUETOOTH-BTPROTO_L2CAP",
@@ -86,11 +85,6 @@ static inline void bt_sock_reclassify_lo
 			bt_slock_key_strings[proto], &bt_slock_key[proto],
 				bt_key_strings[proto], &bt_lock_key[proto]);
 }
-#else
-static inline void bt_sock_reclassify_lock(struct socket *sock, int proto)
-{
-}
-#endif
 
 int bt_sock_register(int proto, struct net_proto_family *ops)
 {
