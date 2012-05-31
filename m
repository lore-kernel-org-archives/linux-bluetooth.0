Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 2/3] Bluetooth: Check MTU value in l2cap_sock_setsockopt_old
Date: Thu, 31 May 2012 17:01:34 -0300
Message-Id: <1338494495-21447-2-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1338494495-21447-1-git-send-email-andre.guedes@openbossa.org>
References: <1338494495-21447-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

If user tries to set an invalid MTU value, l2cap_sock_setsockopt_old
should return -EINVAL.

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
---
 net/bluetooth/l2cap_sock.c |   21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index d856cc8..ab5868d 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -445,6 +445,22 @@ static int l2cap_sock_getsockopt(struct socket *sock, int level, int optname, ch
 	return err;
 }
 
+static bool l2cap_valid_mtu(struct l2cap_chan *chan, u16 mtu)
+{
+	switch (chan->scid) {
+	case L2CAP_CID_LE_DATA:
+		if (mtu < L2CAP_LE_DEFAULT_MTU)
+			return false;
+		break;
+
+	default:
+		if (mtu < L2CAP_DEFAULT_MIN_MTU)
+			return false;
+	}
+
+	return true;
+}
+
 static int l2cap_sock_setsockopt_old(struct socket *sock, int optname, char __user *optval, unsigned int optlen)
 {
 	struct sock *sk = sock->sk;
@@ -483,6 +499,11 @@ static int l2cap_sock_setsockopt_old(struct socket *sock, int optname, char __us
 			break;
 		}
 
+		if (!l2cap_valid_mtu(chan, opts.imtu)) {
+			err = -EINVAL;
+			break;
+		}
+
 		chan->mode = opts.mode;
 		switch (chan->mode) {
 		case L2CAP_MODE_BASIC:
-- 
1.7.10.2

