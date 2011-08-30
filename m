Return-Path: <cyrus@holtmann.org>
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFCv0 1/5] Bluetooth: extended window size option support
Date: Tue, 30 Aug 2011 10:18:37 +0300
Message-Id: <1314688721-16742-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1314688721-16742-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1314688721-16742-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Adds support for EWS option. Code partly based on Qualcomm and Atheros
patches sent upstream a year ago.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 include/net/bluetooth/l2cap.h |   11 +++++--
 net/bluetooth/l2cap_core.c    |   60 +++++++++++++++++++++++++++++++++++++++-
 net/bluetooth/l2cap_sock.c    |   10 +++---
 3 files changed, 71 insertions(+), 10 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index 2350057..b586a55 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -31,7 +31,7 @@
 #define L2CAP_DEFAULT_MTU		672
 #define L2CAP_DEFAULT_MIN_MTU		48
 #define L2CAP_DEFAULT_FLUSH_TO		0xffff
-#define L2CAP_DEFAULT_TX_WINDOW		63
+#define L2CAP_DEFAULT_MAX_TX_WINDOW	63
 #define L2CAP_DEFAULT_MAX_TX		3
 #define L2CAP_DEFAULT_RETRANS_TO	2000    /* 2 seconds */
 #define L2CAP_DEFAULT_MONITOR_TO	12000   /* 12 seconds */
@@ -42,6 +42,8 @@
 #define L2CAP_DEFAULT_SDU_ARRIVAL_TIME	0xFFFFFFFF
 #define L2CAP_DEFAULT_ACCESS_LATENCY	0xFFFFFFFF
 
+#define L2CAP_DEFAULT_MAX_EXT_WINDOW	0x3FFF
+
 #define L2CAP_CONN_TIMEOUT	(40000) /* 40 seconds */
 #define L2CAP_INFO_TIMEOUT	(4000)  /*  4 seconds */
 
@@ -240,6 +242,7 @@ struct l2cap_conf_opt {
 #define L2CAP_CONF_RFC		0x04
 #define L2CAP_CONF_FCS		0x05
 #define L2CAP_CONF_EFS		0x06
+#define L2CAP_CONF_EWS		0x07
 
 #define L2CAP_CONF_MAX_SIZE	22
 
@@ -357,7 +360,7 @@ struct l2cap_chan {
 
 	__u8		fcs;
 
-	__u8		tx_win;
+	__u16		tx_win;
 	__u8		max_tx;
 	__u16		retrans_timeout;
 	__u16		monitor_timeout;
@@ -380,7 +383,7 @@ struct l2cap_chan {
 	struct sk_buff	*sdu;
 	struct sk_buff	*sdu_last_frag;
 
-	__u8		remote_tx_win;
+	__u16		remote_tx_win;
 	__u8		remote_max_tx;
 	__u16		remote_mps;
 
@@ -399,6 +402,7 @@ struct l2cap_chan {
 	__u32		remote_flush_to;
 
 	__u8            ext_flowspec_enable;
+	__u8		ext_ctrl;
 
 	struct timer_list	chan_timer;
 	struct timer_list	retrans_timer;
@@ -491,6 +495,7 @@ enum {
 	CONF_STATE2_DEVICE,
 	CONF_LOCAL_PEND,
 	CONF_REMOTE_PEND,
+	CONF_EWS_RECV,
 };
 
 #define L2CAP_CONF_MAX_CONF_REQ 2
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index de9995d..0d62b05 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -58,6 +58,7 @@
 
 int disable_ertm;
 int disable_flowspec = 1;
+int disable_extwindow = 1;
 
 static u32 l2cap_feat_mask = L2CAP_FEAT_FIXED_CHAN;
 static u8 l2cap_fixed_chan[8] = { 0x02, };
@@ -1916,6 +1917,28 @@ static inline bool __l2cap_efs_supported(struct l2cap_chan *chan)
 			chan->conn->feat_mask & L2CAP_FEAT_EXT_FLOW;
 }
 
+static inline bool __l2cap_ews_supported(struct l2cap_chan *chan)
+{
+	return !disable_extwindow &&
+			chan->conn->feat_mask & L2CAP_FEAT_EXT_WINDOW;
+}
+
+static inline void l2cap_txwin_setup(struct l2cap_chan *chan)
+{
+	if (chan->tx_win > L2CAP_DEFAULT_MAX_TX_WINDOW &&
+			__l2cap_ews_supported(chan)) {
+		/* use extended control field */
+		chan->ext_ctrl = 1;
+		if (chan->tx_win > L2CAP_DEFAULT_MAX_EXT_WINDOW)
+			chan->tx_win = L2CAP_DEFAULT_MAX_EXT_WINDOW;
+	} else {
+		if (chan->tx_win > L2CAP_DEFAULT_MAX_TX_WINDOW)
+			chan->tx_win = L2CAP_DEFAULT_MAX_TX_WINDOW;
+
+		chan->ext_ctrl = 0;
+	}
+}
+
 static int l2cap_build_conf_req(struct l2cap_chan *chan, void *data)
 {
 	struct l2cap_conf_req *req = data;
@@ -1976,7 +1999,6 @@ done:
 
 	case L2CAP_MODE_ERTM:
 		rfc.mode            = L2CAP_MODE_ERTM;
-		rfc.txwin_size      = chan->tx_win;
 		rfc.max_transmit    = chan->max_tx;
 		rfc.retrans_timeout = 0;
 		rfc.monitor_timeout = 0;
@@ -1984,6 +2006,10 @@ done:
 		if (L2CAP_DEFAULT_MAX_PDU_SIZE > chan->conn->mtu - 10)
 			rfc.max_pdu_size = cpu_to_le16(chan->conn->mtu - 10);
 
+		l2cap_txwin_setup(chan);
+		rfc.txwin_size = chan->tx_win > L2CAP_DEFAULT_MAX_TX_WINDOW?
+			L2CAP_DEFAULT_MAX_TX_WINDOW : chan->tx_win;
+
 		l2cap_add_conf_opt(&ptr, L2CAP_CONF_RFC, sizeof(rfc),
 							(unsigned long) &rfc);
 
@@ -2023,6 +2049,10 @@ done:
 					sizeof(efs), (unsigned long) &efs);
 		}
 
+		if (__l2cap_ews_supported(chan) && chan->ext_ctrl)
+			l2cap_add_conf_opt(&ptr, L2CAP_CONF_EWS, 2,
+					chan->tx_win);
+
 		break;
 
 	case L2CAP_MODE_STREAMING:
@@ -2061,6 +2091,9 @@ done:
 					sizeof(efs), (unsigned long) &efs);
 		}
 
+		if (__l2cap_ews_supported(chan) && chan->ext_ctrl)
+			l2cap_add_conf_opt(&ptr, L2CAP_CONF_EWS, 2, 0);
+
 		break;
 	}
 
@@ -2121,6 +2154,12 @@ static int l2cap_parse_conf_req(struct l2cap_chan *chan, void *data)
 				memcpy(&efs, (void *) val, olen);
 			break;
 
+		case L2CAP_CONF_EWS:
+			chan->ext_ctrl = 1;
+			chan->remote_tx_win = val;
+			set_bit(CONF_EWS_RECV, &chan->conf_state);
+			break;
+
 		default:
 			if (hint)
 				break;
@@ -2217,7 +2256,11 @@ done:
 			break;
 
 		case L2CAP_MODE_ERTM:
-			chan->remote_tx_win = rfc.txwin_size;
+			if (!test_bit(CONF_EWS_RECV, &chan->conf_state))
+				chan->remote_tx_win = rfc.txwin_size;
+			else
+				rfc.txwin_size = L2CAP_DEFAULT_MAX_TX_WINDOW;
+
 			chan->remote_max_tx = rfc.max_transmit;
 
 			if (le16_to_cpu(rfc.max_pdu_size) > chan->conn->mtu - 10)
@@ -2339,6 +2382,13 @@ static int l2cap_parse_conf_rsp(struct l2cap_chan *chan, void *rsp, int len, voi
 			l2cap_add_conf_opt(&ptr, L2CAP_CONF_EFS,
 					sizeof(efs), (unsigned long) &efs);
 			break;
+
+		case L2CAP_CONF_EWS:
+			chan->tx_win = val < L2CAP_DEFAULT_MAX_EXT_WINDOW ?
+				val : L2CAP_DEFAULT_MAX_EXT_WINDOW;
+			l2cap_add_conf_opt(&ptr, L2CAP_CONF_EWS,
+							2, chan->tx_win);
+			break;
 		}
 	}
 
@@ -2980,6 +3030,9 @@ static inline int l2cap_information_req(struct l2cap_conn *conn, struct l2cap_cm
 		if (!disable_flowspec)
 			feat_mask |= L2CAP_FEAT_EXT_FLOW;
 
+		if (!disable_extwindow)
+			feat_mask |= L2CAP_FEAT_EXT_WINDOW;
+
 		put_unaligned_le32(feat_mask, rsp->data);
 		l2cap_send_cmd(conn, cmd->ident,
 					L2CAP_INFO_RSP, sizeof(buf), buf);
@@ -4504,3 +4557,6 @@ MODULE_PARM_DESC(disable_ertm, "Disable enhanced retransmission mode");
 
 module_param(disable_flowspec, bool, 0644);
 MODULE_PARM_DESC(disable_flowspec, "Disable Extended Flow Specification");
+
+module_param(disable_extwindow, bool, 0644);
+MODULE_PARM_DESC(disable_extwindow, "Disable Extended Window Size");
diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index 61f1f62..d6a4f63 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -331,7 +331,7 @@ static int l2cap_sock_getsockopt_old(struct socket *sock, int optname, char __us
 		opts.mode     = chan->mode;
 		opts.fcs      = chan->fcs;
 		opts.max_tx   = chan->max_tx;
-		opts.txwin_size = (__u16)chan->tx_win;
+		opts.txwin_size = chan->tx_win;
 
 		len = min_t(unsigned int, len, sizeof(opts));
 		if (copy_to_user(optval, (char *) &opts, len))
@@ -500,7 +500,7 @@ static int l2cap_sock_setsockopt_old(struct socket *sock, int optname, char __us
 		opts.mode     = chan->mode;
 		opts.fcs      = chan->fcs;
 		opts.max_tx   = chan->max_tx;
-		opts.txwin_size = (__u16)chan->tx_win;
+		opts.txwin_size = chan->tx_win;
 
 		len = min_t(unsigned int, sizeof(opts), optlen);
 		if (copy_from_user((char *) &opts, optval, len)) {
@@ -508,7 +508,7 @@ static int l2cap_sock_setsockopt_old(struct socket *sock, int optname, char __us
 			break;
 		}
 
-		if (opts.txwin_size > L2CAP_DEFAULT_TX_WINDOW) {
+		if (opts.txwin_size > L2CAP_DEFAULT_MAX_EXT_WINDOW) {
 			err = -EINVAL;
 			break;
 		}
@@ -532,7 +532,7 @@ static int l2cap_sock_setsockopt_old(struct socket *sock, int optname, char __us
 		chan->omtu = opts.omtu;
 		chan->fcs  = opts.fcs;
 		chan->max_tx = opts.max_tx;
-		chan->tx_win = (__u8)opts.txwin_size;
+		chan->tx_win = opts.txwin_size;
 		break;
 
 	case L2CAP_LM:
@@ -958,7 +958,7 @@ static void l2cap_sock_init(struct sock *sk, struct sock *parent)
 		}
 		chan->max_tx = L2CAP_DEFAULT_MAX_TX;
 		chan->fcs  = L2CAP_FCS_CRC16;
-		chan->tx_win = L2CAP_DEFAULT_TX_WINDOW;
+		chan->tx_win = L2CAP_DEFAULT_MAX_TX_WINDOW;
 		chan->sec_level = BT_SECURITY_LOW;
 		chan->role_switch = 0;
 		chan->force_reliable = 0;
-- 
1.7.4.1

