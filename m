Return-Path: <cyrus@holtmann.org>
Sender: "Gustavo F. Padovan" <pao@profusion.mobi>
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org, gustavo@padovan.org, jprvita@profusion.mobi
Subject: [PATCH 10/10] Bluetooth: Enable option to configure Max Transmission value via sockopt
Date: Tue, 30 Mar 2010 15:52:40 -0300
Message-Id: <1269975160-9994-10-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1269975160-9994-9-git-send-email-padovan@profusion.mobi>
References: <1269373726-13209-20-git-send-email-padovan@profusion.mobi>
 <1269975160-9994-1-git-send-email-padovan@profusion.mobi>
 <1269975160-9994-2-git-send-email-padovan@profusion.mobi>
 <1269975160-9994-3-git-send-email-padovan@profusion.mobi>
 <1269975160-9994-4-git-send-email-padovan@profusion.mobi>
 <1269975160-9994-5-git-send-email-padovan@profusion.mobi>
 <1269975160-9994-6-git-send-email-padovan@profusion.mobi>
 <1269975160-9994-7-git-send-email-padovan@profusion.mobi>
 <1269975160-9994-8-git-send-email-padovan@profusion.mobi>
 <1269975160-9994-9-git-send-email-padovan@profusion.mobi>
List-ID: <linux-bluetooth.vger.kernel.org>

With the sockopt extension we can set a per-channel MaxTx value.

Signed-off-by: Gustavo F. Padovan <padovan@profusion.mobi>
---
 include/net/bluetooth/l2cap.h |    2 ++
 net/bluetooth/l2cap.c         |    7 ++++++-
 2 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index 44dd961..15f6e55 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -55,6 +55,7 @@ struct l2cap_options {
 	__u16 flush_to;
 	__u8  mode;
 	__u8  fcs;
+	__u8  max_tx;
 	__u16  txwin_size;
 };
 
@@ -340,6 +341,7 @@ struct l2cap_pinfo {
 	__u8		ident;
 
 	__u8		tx_win;
+	__u8		max_tx;
 	__u8		remote_tx_win;
 	__u8		remote_max_tx;
 	__u16		retrans_timeout;
diff --git a/net/bluetooth/l2cap.c b/net/bluetooth/l2cap.c
index 32824b9..d5a34a5 100644
--- a/net/bluetooth/l2cap.c
+++ b/net/bluetooth/l2cap.c
@@ -783,6 +783,7 @@ static void l2cap_sock_init(struct sock *sk, struct sock *parent)
 		pi->omtu = l2cap_pi(parent)->omtu;
 		pi->mode = l2cap_pi(parent)->mode;
 		pi->fcs  = l2cap_pi(parent)->fcs;
+		pi->max_tx = l2cap_pi(parent)->max_tx;
 		pi->tx_win = l2cap_pi(parent)->tx_win;
 		pi->sec_level = l2cap_pi(parent)->sec_level;
 		pi->role_switch = l2cap_pi(parent)->role_switch;
@@ -791,6 +792,7 @@ static void l2cap_sock_init(struct sock *sk, struct sock *parent)
 		pi->imtu = L2CAP_DEFAULT_MTU;
 		pi->omtu = 0;
 		pi->mode = L2CAP_MODE_BASIC;
+		pi->max_tx = max_transmit;
 		pi->fcs  = L2CAP_FCS_CRC16;
 		pi->tx_win = tx_window;
 		pi->sec_level = BT_SECURITY_LOW;
@@ -1781,6 +1783,7 @@ static int l2cap_sock_setsockopt_old(struct socket *sock, int optname, char __us
 		opts.flush_to = l2cap_pi(sk)->flush_to;
 		opts.mode     = l2cap_pi(sk)->mode;
 		opts.fcs      = l2cap_pi(sk)->fcs;
+		opts.max_tx   = l2cap_pi(sk)->max_tx;
 		opts.txwin_size = (__u16)l2cap_pi(sk)->tx_win;
 
 		len = min_t(unsigned int, sizeof(opts), optlen);
@@ -1793,6 +1796,7 @@ static int l2cap_sock_setsockopt_old(struct socket *sock, int optname, char __us
 		l2cap_pi(sk)->omtu = opts.omtu;
 		l2cap_pi(sk)->mode = opts.mode;
 		l2cap_pi(sk)->fcs  = opts.fcs;
+		l2cap_pi(sk)->max_tx = opts.max_tx;
 		l2cap_pi(sk)->tx_win = (__u8)opts.txwin_size;
 		break;
 
@@ -1908,6 +1912,7 @@ static int l2cap_sock_getsockopt_old(struct socket *sock, int optname, char __us
 		opts.flush_to = l2cap_pi(sk)->flush_to;
 		opts.mode     = l2cap_pi(sk)->mode;
 		opts.fcs      = l2cap_pi(sk)->fcs;
+		opts.max_tx   = l2cap_pi(sk)->max_tx;
 		opts.txwin_size = (__u16)l2cap_pi(sk)->tx_win;
 
 		len = min_t(unsigned int, len, sizeof(opts));
@@ -2327,7 +2332,7 @@ done:
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
