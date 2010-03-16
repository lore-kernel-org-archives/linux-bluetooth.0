Return-Path: <cyrus@holtmann.org>
Sender: "Gustavo F. Padovan" <gfpadovan@gmail.com>
From: "Gustavo F. Padovan" <gustavo@padovan.org>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org, gustavo@padovan.org
Subject: [PATCH 1/4] Bluetooth: Add sockopt configuration for txWindow on L2CAP
Date: Mon, 15 Mar 2010 21:26:26 -0300
Message-Id: <1268699189-2910-1-git-send-email-gustavo@padovan.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Now can set/get Transmission Window size via sockopt.

Signed-off-by: Gustavo F. Padovan <gustavo@padovan.org>
---
 include/net/bluetooth/l2cap.h |    2 ++
 net/bluetooth/l2cap.c         |    7 ++++++-
 2 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index 48f10f4..c7bf676 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -56,6 +56,7 @@ struct l2cap_options {
 	__u16 flush_to;
 	__u8  mode;
 	__u8  fcs;
+	__u8  txwin_size;
 };
 
 #define L2CAP_CONNINFO	0x02
@@ -339,6 +340,7 @@ struct l2cap_pinfo {
 
 	__u8		ident;
 
+	__u8		tx_win;
 	__u8		remote_tx_win;
 	__u8		remote_max_tx;
 	__u16		retrans_timeout;
diff --git a/net/bluetooth/l2cap.c b/net/bluetooth/l2cap.c
index 930f987..6679418 100644
--- a/net/bluetooth/l2cap.c
+++ b/net/bluetooth/l2cap.c
@@ -780,6 +780,7 @@ static void l2cap_sock_init(struct sock *sk, struct sock *parent)
 		pi->omtu = l2cap_pi(parent)->omtu;
 		pi->mode = l2cap_pi(parent)->mode;
 		pi->fcs  = l2cap_pi(parent)->fcs;
+		pi->tx_win = l2cap_pi(parent)->tx_win;
 		pi->sec_level = l2cap_pi(parent)->sec_level;
 		pi->role_switch = l2cap_pi(parent)->role_switch;
 		pi->force_reliable = l2cap_pi(parent)->force_reliable;
@@ -788,6 +789,7 @@ static void l2cap_sock_init(struct sock *sk, struct sock *parent)
 		pi->omtu = 0;
 		pi->mode = L2CAP_MODE_BASIC;
 		pi->fcs  = L2CAP_FCS_CRC16;
+		pi->tx_win = L2CAP_DEFAULT_TX_WINDOW;
 		pi->sec_level = BT_SECURITY_LOW;
 		pi->role_switch = 0;
 		pi->force_reliable = 0;
@@ -1776,6 +1778,7 @@ static int l2cap_sock_setsockopt_old(struct socket *sock, int optname, char __us
 		opts.flush_to = l2cap_pi(sk)->flush_to;
 		opts.mode     = l2cap_pi(sk)->mode;
 		opts.fcs      = l2cap_pi(sk)->fcs;
+		opts.txwin_size = l2cap_pi(sk)->tx_win;
 
 		len = min_t(unsigned int, sizeof(opts), optlen);
 		if (copy_from_user((char *) &opts, optval, len)) {
@@ -1787,6 +1790,7 @@ static int l2cap_sock_setsockopt_old(struct socket *sock, int optname, char __us
 		l2cap_pi(sk)->omtu = opts.omtu;
 		l2cap_pi(sk)->mode = opts.mode;
 		l2cap_pi(sk)->fcs  = opts.fcs;
+		l2cap_pi(sk)->tx_win = opts.txwin_size;
 		break;
 
 	case L2CAP_LM:
@@ -1901,6 +1905,7 @@ static int l2cap_sock_getsockopt_old(struct socket *sock, int optname, char __us
 		opts.flush_to = l2cap_pi(sk)->flush_to;
 		opts.mode     = l2cap_pi(sk)->mode;
 		opts.fcs      = l2cap_pi(sk)->fcs;
+		opts.txwin_size = l2cap_pi(sk)->tx_win;
 
 		len = min_t(unsigned int, len, sizeof(opts));
 		if (copy_to_user(optval, (char *) &opts, len))
@@ -2318,7 +2323,7 @@ done:
 
 	case L2CAP_MODE_ERTM:
 		rfc.mode            = L2CAP_MODE_ERTM;
-		rfc.txwin_size      = L2CAP_DEFAULT_TX_WINDOW;
+		rfc.txwin_size      = pi->tx_win;
 		rfc.max_transmit    = max_transmit;
 		rfc.retrans_timeout = 0;
 		rfc.monitor_timeout = 0;
-- 
1.6.4.4
