Return-Path: <cyrus@holtmann.org>
Message-Id: <200902112128.n1BLSCdw000376@imap1.linux-foundation.org>
Subject: [patch 2/2] bluetooth: CONFIG_DEBUG_LOCK_ALLOC ifdefs remove
To: marcel@holtmann.org
Cc: linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
        akpm@linux-foundation.org, hidave.darkstar@gmail.com, mingo@elte.hu
From: akpm@linux-foundation.org
Date: Wed, 11 Feb 2009 13:28:12 -0800
List-ID: <linux-bluetooth.vger.kernel.org>

From: Dave Young <hidave.darkstar@gmail.com>

Due to lockdep changes the CONFIG_DEBUG_LOCK_ALLOC ifdef is not needed
now, just remove it here.

The following commit fixed the !lockdep build warnings:

commit e8f6fbf62de37cbc2e179176ac7010d5f4396b67
Author: Ingo Molnar <mingo@elte.hu>
Date:   Wed Nov 12 01:38:36 2008 +0000

    lockdep: include/linux/lockdep.h - fix warning in net/bluetooth/af_bluetooth.c

Signed-off-by: Dave Young <hidave.darkstar@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 net/bluetooth/af_bluetooth.c |    6 ------
 1 file changed, 6 deletions(-)

diff -puN net/bluetooth/af_bluetooth.c~bluetooth-config_debug_lock_alloc-ifdefs-remove net/bluetooth/af_bluetooth.c
--- a/net/bluetooth/af_bluetooth.c~bluetooth-config_debug_lock_alloc-ifdefs-remove
+++ a/net/bluetooth/af_bluetooth.c
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
_
