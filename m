Return-Path: <cyrus@holtmann.org>
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv3 02/16] Bluetooth: EWS: extended window size option support
Date: Tue, 11 Oct 2011 13:37:42 +0300
Message-Id: <1318329476-30153-3-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1318329476-30153-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1318329476-30153-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Adds support for extended window size (EWS) config option. We enable EWS
feature in L2CAP Info RSP when hs enabled. EWS option is included in L2CAP
Config Req if tx_win (which is set via socket) bigger then standard default
value (63) && hs enabled && remote side supports EWS feature.

Using EWS selects extended control field in L2CAP.

Code partly based on Qualcomm and Atheros patches sent upstream a year ago.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 include/net/bluetooth/l2cap.h |    8 +++++-
 net/bluetooth/l2cap_core.c    |   51 ++++++++++++++++++++++++++++++++++++++--
 net/bluetooth/l2cap_sock.c    |    8 +++---
 3 files changed, 58 insertions(+), 9 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index 08ad40b..51998ff 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -32,6 +32,7 @@
 #define L2CAP_DEFAULT_MIN_MTU		48
 #define L2CAP_DEFAULT_FLUSH_TO		0xffff
 #define L2CAP_DEFAULT_TX_WINDOW		63
+#define L2CAP_DEFAULT_EXT_WINDOW	0x3FFF
 #define L2CAP_DEFAULT_MAX_TX		3
 #define L2CAP_DEFAULT_RETRANS_TO	2000    /* 2 seconds */
 #define L2CAP_DEFAULT_MONITOR_TO	12000   /* 12 seconds */
@@ -233,6 +234,7 @@ struct l2cap_conf_opt {
 #define L2CAP_CONF_QOS		0x03
 #define L2CAP_CONF_RFC		0x04
 #define L2CAP_CONF_FCS		0x05
+#define L2CAP_CONF_EWS		0x07
 
 #define L2CAP_CONF_MAX_SIZE	22
 
@@ -333,7 +335,7 @@ struct l2cap_chan {
 
 	__u8		fcs;
 
-	__u8		tx_win;
+	__u16		tx_win;
 	__u8		max_tx;
 	__u16		retrans_timeout;
 	__u16		monitor_timeout;
@@ -357,7 +359,7 @@ struct l2cap_chan {
 	struct sk_buff	*sdu;
 	struct sk_buff	*sdu_last_frag;
 
-	__u8		remote_tx_win;
+	__u16		remote_tx_win;
 	__u8		remote_max_tx;
 	__u16		remote_mps;
 
@@ -442,6 +444,7 @@ enum {
 	CONF_CONNECT_PEND,
 	CONF_NO_FCS_RECV,
 	CONF_STATE2_DEVICE,
+	CONF_EWS_RECV,
 };
 
 #define L2CAP_CONF_MAX_CONF_REQ 2
@@ -465,6 +468,7 @@ enum {
 	FLAG_FORCE_ACTIVE,
 	FLAG_FORCE_RELIABLE,
 	FLAG_FLUSHABLE,
+	FLAG_EXT_CTRL,
 };
 
 #define __set_chan_timer(c, t) l2cap_set_timer(c, &c->chan_timer, (t))
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 18a08c5..6e34312 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -1898,6 +1898,22 @@ static inline __u8 l2cap_select_mode(__u8 mode, __u16 remote_feat_mask)
 	}
 }
 
+static inline bool __l2cap_ews_supported(struct l2cap_chan *chan)
+{
+	return enable_hs && chan->conn->feat_mask & L2CAP_FEAT_EXT_WINDOW;
+}
+
+static inline void l2cap_txwin_setup(struct l2cap_chan *chan)
+{
+	if (chan->tx_win > L2CAP_DEFAULT_TX_WINDOW &&
+						__l2cap_ews_supported(chan))
+		/* use extended control field */
+		set_bit(FLAG_EXT_CTRL, &chan->flags);
+	else
+		chan->tx_win = min_t(u16, chan->tx_win,
+						L2CAP_DEFAULT_TX_WINDOW);
+}
+
 static int l2cap_build_conf_req(struct l2cap_chan *chan, void *data)
 {
 	struct l2cap_conf_req *req = data;
@@ -1944,7 +1960,6 @@ done:
 
 	case L2CAP_MODE_ERTM:
 		rfc.mode            = L2CAP_MODE_ERTM;
-		rfc.txwin_size      = chan->tx_win;
 		rfc.max_transmit    = chan->max_tx;
 		rfc.retrans_timeout = 0;
 		rfc.monitor_timeout = 0;
@@ -1952,6 +1967,11 @@ done:
 		if (L2CAP_DEFAULT_MAX_PDU_SIZE > chan->conn->mtu - 10)
 			rfc.max_pdu_size = cpu_to_le16(chan->conn->mtu - 10);
 
+		l2cap_txwin_setup(chan);
+
+		rfc.txwin_size = min_t(u16, chan->tx_win,
+						L2CAP_DEFAULT_TX_WINDOW);
+
 		l2cap_add_conf_opt(&ptr, L2CAP_CONF_RFC, sizeof(rfc),
 							(unsigned long) &rfc);
 
@@ -1963,6 +1983,10 @@ done:
 			chan->fcs = L2CAP_FCS_NONE;
 			l2cap_add_conf_opt(&ptr, L2CAP_CONF_FCS, 1, chan->fcs);
 		}
+
+		if (test_bit(FLAG_EXT_CTRL, &chan->flags))
+			l2cap_add_conf_opt(&ptr, L2CAP_CONF_EWS, 2,
+								chan->tx_win);
 		break;
 
 	case L2CAP_MODE_STREAMING:
@@ -2038,6 +2062,15 @@ static int l2cap_parse_conf_req(struct l2cap_chan *chan, void *data)
 
 			break;
 
+		case L2CAP_CONF_EWS:
+			if (!enable_hs)
+				return -ECONNREFUSED;
+
+			set_bit(FLAG_EXT_CTRL, &chan->flags);
+			set_bit(CONF_EWS_RECV, &chan->conf_state);
+			chan->remote_tx_win = val;
+			break;
+
 		default:
 			if (hint)
 				break;
@@ -2098,7 +2131,11 @@ done:
 			break;
 
 		case L2CAP_MODE_ERTM:
-			chan->remote_tx_win = rfc.txwin_size;
+			if (!test_bit(CONF_EWS_RECV, &chan->conf_state))
+				chan->remote_tx_win = rfc.txwin_size;
+			else
+				rfc.txwin_size = L2CAP_DEFAULT_TX_WINDOW;
+
 			chan->remote_max_tx = rfc.max_transmit;
 
 			if (le16_to_cpu(rfc.max_pdu_size) > chan->conn->mtu - 10)
@@ -2190,6 +2227,13 @@ static int l2cap_parse_conf_rsp(struct l2cap_chan *chan, void *rsp, int len, voi
 			l2cap_add_conf_opt(&ptr, L2CAP_CONF_RFC,
 					sizeof(rfc), (unsigned long) &rfc);
 			break;
+
+		case L2CAP_CONF_EWS:
+			chan->tx_win = min_t(u16, val,
+						L2CAP_DEFAULT_EXT_WINDOW);
+			l2cap_add_conf_opt(&ptr, L2CAP_CONF_EWS,
+							2, chan->tx_win);
+			break;
 		}
 	}
 
@@ -2785,7 +2829,8 @@ static inline int l2cap_information_req(struct l2cap_conn *conn, struct l2cap_cm
 			feat_mask |= L2CAP_FEAT_ERTM | L2CAP_FEAT_STREAMING
 							 | L2CAP_FEAT_FCS;
 		if (enable_hs)
-			feat_mask |= L2CAP_FEAT_EXT_FLOW;
+			feat_mask |= L2CAP_FEAT_EXT_FLOW
+						| L2CAP_FEAT_EXT_WINDOW;
 
 		put_unaligned_le32(feat_mask, rsp->data);
 		l2cap_send_cmd(conn, cmd->ident,
diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index aa2f2f0..4b388b7 100644
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
@@ -501,7 +501,7 @@ static int l2cap_sock_setsockopt_old(struct socket *sock, int optname, char __us
 		opts.mode     = chan->mode;
 		opts.fcs      = chan->fcs;
 		opts.max_tx   = chan->max_tx;
-		opts.txwin_size = (__u16)chan->tx_win;
+		opts.txwin_size = chan->tx_win;
 
 		len = min_t(unsigned int, sizeof(opts), optlen);
 		if (copy_from_user((char *) &opts, optval, len)) {
@@ -509,7 +509,7 @@ static int l2cap_sock_setsockopt_old(struct socket *sock, int optname, char __us
 			break;
 		}
 
-		if (opts.txwin_size > L2CAP_DEFAULT_TX_WINDOW) {
+		if (opts.txwin_size > L2CAP_DEFAULT_EXT_WINDOW) {
 			err = -EINVAL;
 			break;
 		}
@@ -533,7 +533,7 @@ static int l2cap_sock_setsockopt_old(struct socket *sock, int optname, char __us
 		chan->omtu = opts.omtu;
 		chan->fcs  = opts.fcs;
 		chan->max_tx = opts.max_tx;
-		chan->tx_win = (__u8)opts.txwin_size;
+		chan->tx_win = opts.txwin_size;
 		break;
 
 	case L2CAP_LM:
-- 
1.7.4.1

