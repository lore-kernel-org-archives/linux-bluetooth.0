Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 18/32] Bluetooth: Add new BT_SNDMTU and BT_RCVMTU socket options
Date: Thu,  5 Dec 2013 15:11:16 +0200
Message-Id: <1386249090-10236-19-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1386249090-10236-1-git-send-email-johan.hedberg@gmail.com>
References: <1386249090-10236-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

This patch adds new socket options for LE sockets since the existing
L2CAP_OPTIONS socket option is not usable for LE. For now, the new
socket options also require LE CoC support to be explicitly enabled to
leave some playroom in case something needs to be changed in a backwards
incompatible way.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/bluetooth.h |  3 +++
 net/bluetooth/l2cap_sock.c        | 52 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 55 insertions(+)

diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
index 2a628b28249f..f4f9ee466791 100644
--- a/include/net/bluetooth/bluetooth.h
+++ b/include/net/bluetooth/bluetooth.h
@@ -115,6 +115,9 @@ struct bt_voice {
 #define BT_VOICE_TRANSPARENT			0x0003
 #define BT_VOICE_CVSD_16BIT			0x0060
 
+#define BT_SNDMTU		12
+#define BT_RCVMTU		13
+
 __printf(1, 2)
 int bt_info(const char *fmt, ...);
 __printf(1, 2)
diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index a20fcc3ddcd9..9007def8c619 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -534,6 +534,31 @@ static int l2cap_sock_getsockopt(struct socket *sock, int level, int optname,
 			err = -EFAULT;
 		break;
 
+	case BT_SNDMTU:
+		if (sk->sk_state != BT_CONNECTED) {
+			err = -ENOTCONN;
+			break;
+		}
+
+		if (!enable_lecoc || !bdaddr_type_is_le(chan->src_type)) {
+			err = -EINVAL;
+			break;
+		}
+
+		if (put_user(chan->omtu, (u16 __user *) optval))
+			err = -EFAULT;
+		break;
+
+	case BT_RCVMTU:
+		if (!enable_lecoc || !bdaddr_type_is_le(chan->src_type)) {
+			err = -EINVAL;
+			break;
+		}
+
+		if (put_user(chan->imtu, (u16 __user *) optval))
+			err = -EFAULT;
+		break;
+
 	default:
 		err = -ENOPROTOOPT;
 		break;
@@ -834,6 +859,33 @@ static int l2cap_sock_setsockopt(struct socket *sock, int level, int optname,
 
 		break;
 
+	case BT_SNDMTU:
+		/* Setting is not supported as it's the remote side that
+		 * decides this.
+		 */
+		err = -EINVAL;
+		break;
+
+	case BT_RCVMTU:
+		if (sk->sk_state == BT_CONNECTED) {
+			err = -EISCONN;
+			break;
+		}
+
+		if (!enable_lecoc || !bdaddr_type_is_le(chan->src_type)) {
+			err = -EINVAL;
+			break;
+		}
+
+		if (get_user(opt, (u32 __user *) optval)) {
+			err = -EFAULT;
+			break;
+		}
+
+		chan->imtu = opt;
+
+		break;
+
 	default:
 		err = -ENOPROTOOPT;
 		break;
-- 
1.8.4.2

