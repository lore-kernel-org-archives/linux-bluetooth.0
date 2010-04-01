Return-Path: <cyrus@holtmann.org>
Sender: "Gustavo F. Padovan" <pao@profusion.mobi>
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org, gustavo@padovan.org, jprvita@profusion.mobi
Subject: [PATCH 22/34] Bluetooth: Fix configuration of the MPS value
Date: Thu,  1 Apr 2010 17:23:40 -0300
Message-Id: <1270153432-6477-23-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1270153432-6477-22-git-send-email-padovan@profusion.mobi>
References: <1270153432-6477-1-git-send-email-padovan@profusion.mobi>
 <1270153432-6477-2-git-send-email-padovan@profusion.mobi>
 <1270153432-6477-3-git-send-email-padovan@profusion.mobi>
 <1270153432-6477-4-git-send-email-padovan@profusion.mobi>
 <1270153432-6477-5-git-send-email-padovan@profusion.mobi>
 <1270153432-6477-6-git-send-email-padovan@profusion.mobi>
 <1270153432-6477-7-git-send-email-padovan@profusion.mobi>
 <1270153432-6477-8-git-send-email-padovan@profusion.mobi>
 <1270153432-6477-9-git-send-email-padovan@profusion.mobi>
 <1270153432-6477-10-git-send-email-padovan@profusion.mobi>
 <1270153432-6477-11-git-send-email-padovan@profusion.mobi>
 <1270153432-6477-12-git-send-email-padovan@profusion.mobi>
 <1270153432-6477-13-git-send-email-padovan@profusion.mobi>
 <1270153432-6477-14-git-send-email-padovan@profusion.mobi>
 <1270153432-6477-15-git-send-email-padovan@profusion.mobi>
 <1270153432-6477-16-git-send-email-padovan@profusion.mobi>
 <1270153432-6477-17-git-send-email-padovan@profusion.mobi>
 <1270153432-6477-18-git-send-email-padovan@profusion.mobi>
 <1270153432-6477-19-git-send-email-padovan@profusion.mobi>
 <1270153432-6477-20-git-send-email-padovan@profusion.mobi>
 <1270153432-6477-21-git-send-email-padovan@profusion.mobi>
 <1270153432-6477-22-git-send-email-padovan@profusion.mobi>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

We were accepting values bigger than we can accept. This was leading
ERTM to drop packets because of wrong FCS checks.

Signed-off-by: Gustavo F. Padovan <padovan@profusion.mobi>
Reviewed-by: João Paulo Rechi Vita <jprvita@profusion.mobi>
---
 include/net/bluetooth/l2cap.h |    3 ++-
 net/bluetooth/l2cap.c         |   36 ++++++++++++++++++++----------------
 2 files changed, 22 insertions(+), 17 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index 48f10f4..0f4e423 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -343,7 +343,8 @@ struct l2cap_pinfo {
 	__u8		remote_max_tx;
 	__u16		retrans_timeout;
 	__u16		monitor_timeout;
-	__u16		max_pdu_size;
+	__u16		remote_mps;
+	__u16		mps;
 
 	__le16		sport;
 
diff --git a/net/bluetooth/l2cap.c b/net/bluetooth/l2cap.c
index 40aff8d..4c98e3c 100644
--- a/net/bluetooth/l2cap.c
+++ b/net/bluetooth/l2cap.c
@@ -1605,21 +1605,21 @@ static inline int l2cap_sar_segment_sdu(struct sock *sk, struct msghdr *msg, siz
 
 	__skb_queue_head_init(&sar_queue);
 	control = L2CAP_SDU_START;
-	skb = l2cap_create_iframe_pdu(sk, msg, pi->max_pdu_size, control, len);
+	skb = l2cap_create_iframe_pdu(sk, msg, pi->remote_mps, control, len);
 	if (IS_ERR(skb))
 		return PTR_ERR(skb);
 
 	__skb_queue_tail(&sar_queue, skb);
-	len -= pi->max_pdu_size;
-	size +=pi->max_pdu_size;
+	len -= pi->remote_mps;
+	size +=pi->remote_mps;
 	control = 0;
 
 	while (len > 0) {
 		size_t buflen;
 
-		if (len > pi->max_pdu_size) {
+		if (len > pi->remote_mps) {
 			control |= L2CAP_SDU_CONTINUE;
-			buflen = pi->max_pdu_size;
+			buflen = pi->remote_mps;
 		} else {
 			control |= L2CAP_SDU_END;
 			buflen = len;
@@ -1697,7 +1697,7 @@ static int l2cap_sock_sendmsg(struct kiocb *iocb, struct socket *sock, struct ms
 	case L2CAP_MODE_ERTM:
 	case L2CAP_MODE_STREAMING:
 		/* Entire SDU fits into one PDU */
-		if (len <= pi->max_pdu_size) {
+		if (len <= pi->remote_mps) {
 			control = L2CAP_SDU_UNSEGMENTED;
 			skb = l2cap_create_iframe_pdu(sk, msg, len, control, 0);
 			if (IS_ERR(skb)) {
@@ -2326,7 +2326,7 @@ done:
 		rfc.monitor_timeout = 0;
 		rfc.max_pdu_size    = cpu_to_le16(L2CAP_DEFAULT_MAX_PDU_SIZE);
 		if (L2CAP_DEFAULT_MAX_PDU_SIZE > pi->conn->mtu - 10)
-			rfc.max_pdu_size = pi->conn->mtu - 10;
+			rfc.max_pdu_size = cpu_to_le16(pi->conn->mtu - 10);
 
 		l2cap_add_conf_opt(&ptr, L2CAP_CONF_RFC,
 					sizeof(rfc), (unsigned long) &rfc);
@@ -2349,7 +2349,7 @@ done:
 		rfc.monitor_timeout = 0;
 		rfc.max_pdu_size    = cpu_to_le16(L2CAP_DEFAULT_MAX_PDU_SIZE);
 		if (L2CAP_DEFAULT_MAX_PDU_SIZE > pi->conn->mtu - 10)
-			rfc.max_pdu_size = pi->conn->mtu - 10;
+			rfc.max_pdu_size = cpu_to_le16(pi->conn->mtu - 10);
 
 		l2cap_add_conf_opt(&ptr, L2CAP_CONF_RFC,
 					sizeof(rfc), (unsigned long) &rfc);
@@ -2478,7 +2478,10 @@ done:
 		case L2CAP_MODE_ERTM:
 			pi->remote_tx_win = rfc.txwin_size;
 			pi->remote_max_tx = rfc.max_transmit;
-			pi->max_pdu_size = rfc.max_pdu_size;
+			if (rfc.max_pdu_size > pi->conn->mtu - 10)
+				rfc.max_pdu_size = le16_to_cpu(pi->conn->mtu - 10);
+
+			pi->remote_mps = le16_to_cpu(rfc.max_pdu_size);
 
 			rfc.retrans_timeout = L2CAP_DEFAULT_RETRANS_TO;
 			rfc.monitor_timeout = L2CAP_DEFAULT_MONITOR_TO;
@@ -2491,7 +2494,10 @@ done:
 			break;
 
 		case L2CAP_MODE_STREAMING:
-			pi->max_pdu_size = rfc.max_pdu_size;
+			if (rfc.max_pdu_size > pi->conn->mtu - 10)
+				rfc.max_pdu_size = le16_to_cpu(pi->conn->mtu - 10);
+
+			pi->remote_mps = le16_to_cpu(rfc.max_pdu_size);
 
 			pi->conf_state |= L2CAP_CONF_MODE_DONE;
 
@@ -2570,11 +2576,10 @@ static int l2cap_parse_conf_rsp(struct sock *sk, void *rsp, int len, void *data,
 			pi->remote_tx_win   = rfc.txwin_size;
 			pi->retrans_timeout = rfc.retrans_timeout;
 			pi->monitor_timeout = rfc.monitor_timeout;
-			pi->max_pdu_size    = le16_to_cpu(rfc.max_pdu_size);
+			pi->mps    = le16_to_cpu(rfc.max_pdu_size);
 			break;
 		case L2CAP_MODE_STREAMING:
-			pi->max_pdu_size    = le16_to_cpu(rfc.max_pdu_size);
-			break;
+			pi->mps    = le16_to_cpu(rfc.max_pdu_size);
 		}
 	}
 
@@ -3758,7 +3763,7 @@ static inline int l2cap_data_channel(struct l2cap_conn *conn, u16 cid, struct sk
 		 * Receiver will miss it and start proper recovery
 		 * procedures and ask retransmission.
 		 */
-		if (len > L2CAP_DEFAULT_MAX_PDU_SIZE)
+		if (len > pi->mps)
 			goto drop;
 
 		if (l2cap_check_fcs(pi, skb))
@@ -3789,8 +3794,7 @@ static inline int l2cap_data_channel(struct l2cap_conn *conn, u16 cid, struct sk
 		if (pi->fcs == L2CAP_FCS_CRC16)
 			len -= 2;
 
-		if (len > L2CAP_DEFAULT_MAX_PDU_SIZE || len < 4
-				|| __is_sframe(control))
+		if (len > pi->mps || len < 4 || __is_sframe(control))
 			goto drop;
 
 		if (l2cap_check_fcs(pi, skb))
-- 
1.6.4.4
