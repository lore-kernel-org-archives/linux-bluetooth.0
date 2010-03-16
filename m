Return-Path: <cyrus@holtmann.org>
Sender: "Gustavo F. Padovan" <gfpadovan@gmail.com>
From: "Gustavo F. Padovan" <gustavo@padovan.org>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org, gustavo@padovan.org
Subject: [PATCH 4/4] Bluetooth: Enable option to configure Max Transmission value via sockopt
Date: Mon, 15 Mar 2010 21:26:29 -0300
Message-Id: <1268699189-2910-4-git-send-email-gustavo@padovan.org>
In-Reply-To: <1268699189-2910-3-git-send-email-gustavo@padovan.org>
References: <1268699189-2910-1-git-send-email-gustavo@padovan.org>
 <1268699189-2910-2-git-send-email-gustavo@padovan.org>
 <1268699189-2910-3-git-send-email-gustavo@padovan.org>
List-ID: <linux-bluetooth.vger.kernel.org>

With the sockopt extension we can set a per-channel MaxTx value.

Signed-off-by: Gustavo F. Padovan <gustavo@padovan.org>
---
 include/net/bluetooth/l2cap.h |    2 ++
 net/bluetooth/l2cap.c         |    7 ++++++-
 2 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index f1eca05..0366a84 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -56,6 +56,7 @@ struct l2cap_options {
 	__u8  mode;
 	__u8  fcs;
 	__u8  txwin_size;
+	__u8  max_tx;
 };
 
 #define L2CAP_CONNINFO	0x02
@@ -340,6 +341,7 @@ struct l2cap_pinfo {
 	__u8		ident;
 
 	__u8		tx_win;
+	__u8		max_tx;
 	__u8		remote_tx_win;
 	__u8		remote_max_tx;
 	__u16		retrans_timeout;
diff --git a/net/bluetooth/l2cap.c b/net/bluetooth/l2cap.c
index 6f3dc6e..5ff0ca0 100644
--- a/net/bluetooth/l2cap.c
+++ b/net/bluetooth/l2cap.c
@@ -781,6 +781,7 @@ static void l2cap_sock_init(struct sock *sk, struct sock *parent)
 		pi->omtu = l2cap_pi(parent)->omtu;
 		pi->mode = l2cap_pi(parent)->mode;
 		pi->fcs  = l2cap_pi(parent)->fcs;
+		pi->max_tx = l2cap_pi(parent)->max_tx;
 		pi->tx_win = l2cap_pi(parent)->tx_win;
 		pi->sec_level = l2cap_pi(parent)->sec_level;
 		pi->role_switch = l2cap_pi(parent)->role_switch;
@@ -790,6 +791,7 @@ static void l2cap_sock_init(struct sock *sk, struct sock *parent)
 		pi->omtu = 0;
 		pi->mode = L2CAP_MODE_BASIC;
 		pi->fcs  = L2CAP_FCS_CRC16;
+		pi->max_tx = max_transmit;
 		pi->tx_win = tx_window;
 		pi->sec_level = BT_SECURITY_LOW;
 		pi->role_switch = 0;
@@ -1780,6 +1782,7 @@ static int l2cap_sock_setsockopt_old(struct socket *sock, int optname, char __us
 		opts.mode     = l2cap_pi(sk)->mode;
 		opts.fcs      = l2cap_pi(sk)->fcs;
 		opts.txwin_size = l2cap_pi(sk)->tx_win;
+		opts.max_tx   = l2cap_pi(sk)->max_tx;
 
 		len = min_t(unsigned int, sizeof(opts), optlen);
 		if (copy_from_user((char *) &opts, optval, len)) {
@@ -1792,6 +1795,7 @@ static int l2cap_sock_setsockopt_old(struct socket *sock, int optname, char __us
 		l2cap_pi(sk)->mode = opts.mode;
 		l2cap_pi(sk)->fcs  = opts.fcs;
 		l2cap_pi(sk)->tx_win = opts.txwin_size;
+		l2cap_pi(sk)->max_tx = opts.max_tx;
 		break;
 
 	case L2CAP_LM:
@@ -1907,6 +1911,7 @@ static int l2cap_sock_getsockopt_old(struct socket *sock, int optname, char __us
 		opts.mode     = l2cap_pi(sk)->mode;
 		opts.fcs      = l2cap_pi(sk)->fcs;
 		opts.txwin_size = l2cap_pi(sk)->tx_win;
+		opts.max_tx   = l2cap_pi(sk)->max_tx;
 
 		len = min_t(unsigned int, len, sizeof(opts));
 		if (copy_to_user(optval, (char *) &opts, len))
@@ -2325,7 +2330,7 @@ done:
 	case L2CAP_MODE_ERTM:
 		rfc.mode            = L2CAP_MODE_ERTM;
 		rfc.txwin_size      = pi->tx_win;
-		rfc.max_transmit    = max_transmit;
+		rfc.max_transmit    = pi->max_tx;
 		rfc.retrans_timeout = 0;
 		rfc.monitor_timeout = 0;
 		rfc.max_pdu_size    = cpu_to_le16(L2CAP_DEFAULT_MAX_PDU_SIZE);
-- 
1.6.4.4
