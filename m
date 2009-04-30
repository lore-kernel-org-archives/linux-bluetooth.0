Return-Path: <cyrus@holtmann.org>
From: ngh@isomerica.net
To: linux-bluetooth@vger.kernel.org
Cc: Nathan Holstein <nathan@lampreynetworks.com>
Subject: [PATCH 05/10] Add support for parsing enhanced L2CAP configuration options.
Date: Thu, 30 Apr 2009 17:16:42 -0400
Message-Id: <1241126207-19996-6-git-send-email-ngh@isomerica.net>
In-Reply-To: <1241126207-19996-1-git-send-email-ngh@isomerica.net>
References: <1241126207-19996-1-git-send-email-ngh@isomerica.net>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Nathan Holstein <nathan@lampreynetworks.com>

When negotiating for either Enhanced Retransmission or Streaming modes, both
sides of the connection must agree upon the configuration.  This patch adds
support for parsing and validating the configuration receiverd from the remote.

Signed-off-by: Nathan Holstein <nathan@lampreynetworks.com>
---
 include/net/bluetooth/l2cap.h |   12 ++++++++-
 net/bluetooth/l2cap.c         |   55 +++++++++++++++++++++++++++++++---------
 2 files changed, 53 insertions(+), 14 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index e67b1ff..9221c4a 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -310,6 +310,12 @@ struct l2cap_pinfo {
 
 	__u8		ident;
 
+	__u8		remote_tx_win;
+	__u8		remote_max_tx;
+	__u16		retrans_timeout;
+	__u16		monitor_timeout;
+	__u16		max_pdu_size;
+
 	__le16		sport;
 
         struct sk_buff		*tx_buf;
@@ -320,8 +326,12 @@ struct l2cap_pinfo {
 
 #define L2CAP_CONF_REQ_SENT	0x01
 #define L2CAP_CONF_INPUT_DONE	0x02
-#define L2CAP_CONF_OUTPUT_DONE	0x04
+#define L2CAP_CONF_MTU_DONE	0x04
+#define L2CAP_CONF_MODE_DONE	0x04
 #define L2CAP_CONF_CONNECT_PEND	0x80
+#define L2CAP_CONF_OUTPUT_DONE(state) (\
+		((state) & L2CAP_CONF_MTU_DONE) && \
+		((state) & L2CAP_CONF_MODE_DONE))
 
 #define L2CAP_CONF_MAX_RETRIES	2
 
diff --git a/net/bluetooth/l2cap.c b/net/bluetooth/l2cap.c
index 660a433..423999e 100644
--- a/net/bluetooth/l2cap.c
+++ b/net/bluetooth/l2cap.c
@@ -747,6 +747,9 @@ static void l2cap_sock_init(struct sock *sk, struct sock *parent)
 			pi->mode = L2CAP_MODE_BASIC;
 	}
 
+	if (pi->mode == L2CAP_MODE_BASIC)
+		pi->conf_state |= L2CAP_CONF_MODE_DONE;
+
 	/* Default config options */
 	pi->conf_len = 0;
 	pi->flush_to = L2CAP_DEFAULT_FLUSH_TO;
@@ -1942,6 +1945,10 @@ static int l2cap_parse_conf_req(struct sock *sk, void *data)
 				memcpy(&rfc, (void *) val, olen);
 			break;
 
+		case L2CAP_CONF_FCS:
+			pi->fcs = val;
+			break;
+
 		default:
 			if (hint)
 				break;
@@ -1952,27 +1959,49 @@ static int l2cap_parse_conf_req(struct sock *sk, void *data)
 		}
 	}
 
+	if (pi->mode != rfc.mode) {
+		result = L2CAP_CONF_UNACCEPT;
+		rfc.mode = pi->mode;
+		l2cap_add_conf_opt(&ptr, L2CAP_CONF_RFC,
+				sizeof(rfc), (unsigned long) &rfc);
+	}
+
 	if (result == L2CAP_CONF_SUCCESS) {
 		/* Configure output options and let the other side know
 		 * which ones we don't like. */
+		if (mtu < L2CAP_DEFAULT_MIN_MTU)
+			result = L2CAP_CONF_UNACCEPT;
+		else {
+			pi->omtu = mtu;
+			pi->conf_state |= L2CAP_CONF_MTU_DONE;
+		}
+		l2cap_add_conf_opt(&ptr, L2CAP_CONF_MTU, 2, pi->omtu);
 
-		if (rfc.mode == L2CAP_MODE_BASIC) {
-			if (mtu < pi->omtu)
-				result = L2CAP_CONF_UNACCEPT;
-			else {
-				pi->omtu = mtu;
-				pi->conf_state |= L2CAP_CONF_OUTPUT_DONE;
-			}
+		switch (rfc.mode) {
+		case L2CAP_MODE_BASIC:
+			pi->fcs = 0;
+			pi->conf_state |= L2CAP_CONF_MODE_DONE;
+			break;
 
-			l2cap_add_conf_opt(&ptr, L2CAP_CONF_MTU, 2, pi->omtu);
-		} else {
+		case L2CAP_MODE_ERTM:
+		case L2CAP_MODE_STREAM:
+			pi->remote_tx_win = rfc.txwin_size;
+			pi->remote_max_tx = rfc.max_transmit;
+			pi->retrans_timeout = rfc.retrans_timeout;
+			pi->monitor_timeout = rfc.monitor_timeout;
+			pi->max_pdu_size = rfc.max_pdu_size;
+
+			pi->conf_state |= L2CAP_CONF_MODE_DONE;
+			break;
+
+		default:
 			result = L2CAP_CONF_UNACCEPT;
 
 			memset(&rfc, 0, sizeof(rfc));
-			rfc.mode = L2CAP_MODE_BASIC;
+			rfc.mode = pi->mode;
 
 			l2cap_add_conf_opt(&ptr, L2CAP_CONF_RFC,
-						sizeof(rfc), (unsigned long) &rfc);
+					sizeof(rfc), (unsigned long) &rfc);
 		}
 	}
 
@@ -2235,7 +2264,7 @@ static inline int l2cap_config_req(struct l2cap_conn *conn, struct l2cap_cmd_hdr
 	/* Reset config buffer. */
 	l2cap_pi(sk)->conf_len = 0;
 
-	if (!(l2cap_pi(sk)->conf_state & L2CAP_CONF_OUTPUT_DONE))
+	if (!L2CAP_CONF_OUTPUT_DONE(l2cap_pi(sk)->conf_state))
 		goto unlock;
 
 	if (l2cap_pi(sk)->conf_state & L2CAP_CONF_INPUT_DONE) {
@@ -2308,7 +2337,7 @@ static inline int l2cap_config_rsp(struct l2cap_conn *conn, struct l2cap_cmd_hdr
 
 	l2cap_pi(sk)->conf_state |= L2CAP_CONF_INPUT_DONE;
 
-	if (l2cap_pi(sk)->conf_state & L2CAP_CONF_OUTPUT_DONE) {
+	if (L2CAP_CONF_OUTPUT_DONE(l2cap_pi(sk)->conf_state)) {
 		sk->sk_state = BT_CONNECTED;
 		l2cap_chan_ready(sk);
 	}
-- 
1.6.0.6

