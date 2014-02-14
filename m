Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Officially enable LE CoC support
Date: Fri, 14 Feb 2014 07:40:51 +0200
Message-Id: <1392356451-14435-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

Now that the LE Connection oriented Channel support has undergone a
decent amount of testing we can make it officially supported. This patch
removes the enable_lecoc debugfs switch which was previously needed to
enable support for LE CoC.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/l2cap_core.c | 11 -----------
 net/bluetooth/l2cap_sock.c | 29 -----------------------------
 2 files changed, 40 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 66fbac91eaed..6e6b3a9c8e6d 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -5544,17 +5544,6 @@ static inline int l2cap_le_sig_cmd(struct l2cap_conn *conn,
 {
 	int err = 0;
 
-	if (!enable_lecoc) {
-		switch (cmd->code) {
-		case L2CAP_LE_CONN_REQ:
-		case L2CAP_LE_CONN_RSP:
-		case L2CAP_LE_CREDITS:
-		case L2CAP_DISCONN_REQ:
-		case L2CAP_DISCONN_RSP:
-			return -EINVAL;
-		}
-	}
-
 	switch (cmd->code) {
 	case L2CAP_COMMAND_REJ:
 		l2cap_le_command_rej(conn, cmd, cmd_len, data);
diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index 27d3d6d48b6e..b247f9d27fed 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -36,8 +36,6 @@
 
 #include "smp.h"
 
-bool enable_lecoc;
-
 static struct bt_sock_list l2cap_sk_list = {
 	.lock = __RW_LOCK_UNLOCKED(l2cap_sk_list.lock)
 };
@@ -111,8 +109,6 @@ static int l2cap_sock_bind(struct socket *sock, struct sockaddr *addr, int alen)
 	}
 
 	if (bdaddr_type_is_le(la.l2_bdaddr_type)) {
-		if (!enable_lecoc && la.l2_psm)
-			return -EINVAL;
 		/* We only allow ATT user space socket */
 		if (la.l2_cid &&
 		    la.l2_cid != __constant_cpu_to_le16(L2CAP_CID_ATT))
@@ -229,8 +225,6 @@ static int l2cap_sock_connect(struct socket *sock, struct sockaddr *addr,
 		return -EINVAL;
 
 	if (bdaddr_type_is_le(la.l2_bdaddr_type)) {
-		if (!enable_lecoc && la.l2_psm)
-			return -EINVAL;
 		/* We only allow ATT user space socket */
 		if (la.l2_cid &&
 		    la.l2_cid != __constant_cpu_to_le16(L2CAP_CID_ATT))
@@ -578,11 +572,6 @@ static int l2cap_sock_getsockopt(struct socket *sock, int level, int optname,
 		break;
 
 	case BT_SNDMTU:
-		if (!enable_lecoc) {
-			err = -EPROTONOSUPPORT;
-			break;
-		}
-
 		if (!bdaddr_type_is_le(chan->src_type)) {
 			err = -EINVAL;
 			break;
@@ -598,11 +587,6 @@ static int l2cap_sock_getsockopt(struct socket *sock, int level, int optname,
 		break;
 
 	case BT_RCVMTU:
-		if (!enable_lecoc) {
-			err = -EPROTONOSUPPORT;
-			break;
-		}
-
 		if (!bdaddr_type_is_le(chan->src_type)) {
 			err = -EINVAL;
 			break;
@@ -919,11 +903,6 @@ static int l2cap_sock_setsockopt(struct socket *sock, int level, int optname,
 		break;
 
 	case BT_SNDMTU:
-		if (!enable_lecoc) {
-			err = -EPROTONOSUPPORT;
-			break;
-		}
-
 		if (!bdaddr_type_is_le(chan->src_type)) {
 			err = -EINVAL;
 			break;
@@ -936,11 +915,6 @@ static int l2cap_sock_setsockopt(struct socket *sock, int level, int optname,
 		break;
 
 	case BT_RCVMTU:
-		if (!enable_lecoc) {
-			err = -EPROTONOSUPPORT;
-			break;
-		}
-
 		if (!bdaddr_type_is_le(chan->src_type)) {
 			err = -EINVAL;
 			break;
@@ -1643,6 +1617,3 @@ void l2cap_cleanup_sockets(void)
 	bt_sock_unregister(BTPROTO_L2CAP);
 	proto_unregister(&l2cap_proto);
 }
-
-module_param(enable_lecoc, bool, 0644);
-MODULE_PARM_DESC(enable_lecoc, "Enable support for LE CoC");
-- 
1.8.5.3

