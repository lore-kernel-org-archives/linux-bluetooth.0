Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 02/32] Bluetooth: Add module parameter to enable LE CoC support
Date: Thu,  5 Dec 2013 15:11:00 +0200
Message-Id: <1386249090-10236-3-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1386249090-10236-1-git-send-email-johan.hedberg@gmail.com>
References: <1386249090-10236-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

Along with the L2CAP Connection Oriented Channels features it is now
allowed to use both custom fixed CIDs as well as PSM based (connection
oriented connections). Since the support for this (with the subsequent
patches) is still on an experimental stage, add a module parameter to
enable it.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/l2cap.h |  1 +
 net/bluetooth/l2cap_sock.c    | 18 ++++++++++++------
 2 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index c853b16de4ef..94645d56fea7 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -809,6 +809,7 @@ static inline long l2cap_chan_no_get_sndtimeo(struct l2cap_chan *chan)
 }
 
 extern bool disable_ertm;
+extern bool enable_lecoc;
 
 int l2cap_init_sockets(void);
 void l2cap_cleanup_sockets(void);
diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index 7cc24d263caa..5a1d0cb0b8d5 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -27,6 +27,7 @@
 
 /* Bluetooth L2CAP sockets. */
 
+#include <linux/module.h>
 #include <linux/export.h>
 
 #include <net/bluetooth/bluetooth.h>
@@ -35,6 +36,8 @@
 
 #include "smp.h"
 
+bool enable_lecoc;
+
 static struct bt_sock_list l2cap_sk_list = {
 	.lock = __RW_LOCK_UNLOCKED(l2cap_sk_list.lock)
 };
@@ -73,11 +76,11 @@ static int l2cap_sock_bind(struct socket *sock, struct sockaddr *addr, int alen)
 		return -EINVAL;
 
 	if (bdaddr_type_is_le(la.l2_bdaddr_type)) {
-		/* Connection oriented channels are not supported on LE */
-		if (la.l2_psm)
+		if (!enable_lecoc && la.l2_psm)
 			return -EINVAL;
 		/* We only allow ATT user space socket */
-		if (la.l2_cid != __constant_cpu_to_le16(L2CAP_CID_ATT))
+		if (la.l2_cid &&
+		    la.l2_cid != __constant_cpu_to_le16(L2CAP_CID_ATT))
 			return -EINVAL;
 	}
 
@@ -189,11 +192,11 @@ static int l2cap_sock_connect(struct socket *sock, struct sockaddr *addr,
 		return -EINVAL;
 
 	if (bdaddr_type_is_le(la.l2_bdaddr_type)) {
-		/* Connection oriented channels are not supported on LE */
-		if (la.l2_psm)
+		if (!enable_lecoc && la.l2_psm)
 			return -EINVAL;
 		/* We only allow ATT user space socket */
-		if (la.l2_cid != __constant_cpu_to_le16(L2CAP_CID_ATT))
+		if (la.l2_cid &&
+		    la.l2_cid != __constant_cpu_to_le16(L2CAP_CID_ATT))
 			return -EINVAL;
 	}
 
@@ -1469,3 +1472,6 @@ void l2cap_cleanup_sockets(void)
 	bt_sock_unregister(BTPROTO_L2CAP);
 	proto_unregister(&l2cap_proto);
 }
+
+module_param(enable_lecoc, bool, 0644);
+MODULE_PARM_DESC(enable_lecoc, "Enable support for LE CoC");
-- 
1.8.4.2

