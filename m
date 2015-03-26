Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/3] Bluetooth: bnep: Add support to extended headers of control frames
Date: Thu, 26 Mar 2015 12:02:35 +0100
Message-Id: <1427367755-13950-4-git-send-email-grzegorz.kolodziejczyk@tieto.com>
In-Reply-To: <1427367755-13950-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1427367755-13950-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Handling extended headers of control frames is required BNEP
functionality. Previously setup success response was handled in user
space and whole extended header was omitted. This patch allows to
handle setup success response and parsing extended headers in control
messages.

Signed-off-by: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
---
 net/bluetooth/bnep/core.c | 55 +++++++++++++++++++++++++++++++++++++----------
 1 file changed, 44 insertions(+), 11 deletions(-)

diff --git a/net/bluetooth/bnep/core.c b/net/bluetooth/bnep/core.c
index c627817..eb459da 100644
--- a/net/bluetooth/bnep/core.c
+++ b/net/bluetooth/bnep/core.c
@@ -231,7 +231,13 @@ static int bnep_rx_control(struct bnep_session *s, void *data, int len)
 		break;
 
 	case BNEP_SETUP_CONN_REQ:
-		err = bnep_send_rsp(s, BNEP_SETUP_CONN_RSP, BNEP_CONN_NOT_ALLOWED);
+		/* Successful response should be sent only once */
+		if (test_and_clear_bit(BNEP_SETUP_RSP_FLAG, &s->flags))
+			err = bnep_send_rsp(s, BNEP_SETUP_CONN_RSP,
+					    BNEP_SUCCESS);
+		else
+			err = bnep_send_rsp(s, BNEP_SETUP_CONN_RSP,
+					    BNEP_CONN_NOT_ALLOWED);
 		break;
 
 	default: {
@@ -292,29 +298,55 @@ static int bnep_rx_frame(struct bnep_session *s, struct sk_buff *skb)
 {
 	struct net_device *dev = s->dev;
 	struct sk_buff *nskb;
-	u8 type;
+	u8 type, ctrl_type;
 
 	dev->stats.rx_bytes += skb->len;
 
 	type = *(u8 *) skb->data;
 	skb_pull(skb, 1);
+	ctrl_type = *(u8 *)skb->data;
 
 	if ((type & BNEP_TYPE_MASK) >= sizeof(__bnep_rx_hlen))
 		goto badframe;
 
 	if ((type & BNEP_TYPE_MASK) == BNEP_CONTROL) {
-		bnep_rx_control(s, skb->data, skb->len);
-		kfree_skb(skb);
-		return 0;
-	}
+		if (bnep_rx_control(s, skb->data, skb->len) < 0) {
+			dev->stats.tx_errors++;
+			kfree_skb(skb);
+			return 0;
+		}
 
-	skb_reset_mac_header(skb);
+		if (!(type & BNEP_EXT_HEADER)) {
+			kfree_skb(skb);
+			return 0;
+		}
 
-	/* Verify and pull out header */
-	if (!skb_pull(skb, __bnep_rx_hlen[type & BNEP_TYPE_MASK]))
-		goto badframe;
+		/* Verify and pull ctrl message since it's already processed */
+		switch (ctrl_type) {
+		case BNEP_SETUP_CONN_REQ:
+			/* Pull: ctrl type (1 b), len (1 b), data (len bytes) */
+			if (!skb_pull(skb, 2 + *(u8 *)(skb->data + 1) * 2))
+				goto badframe;
+			break;
+		case BNEP_FILTER_MULTI_ADDR_SET:
+		case BNEP_FILTER_NET_TYPE_SET:
+			/* Pull: ctrl type (1 b), len (2 b), data (len bytes) */
+			if (!skb_pull(skb, 3 + *(u16 *)(skb->data + 1) * 2))
+				goto badframe;
+			break;
+		default:
+			kfree_skb(skb);
+			return 0;
+		}
+	} else {
+		skb_reset_mac_header(skb);
 
-	s->eh.h_proto = get_unaligned((__be16 *) (skb->data - 2));
+		/* Verify and pull out header */
+		if (!skb_pull(skb, __bnep_rx_hlen[type & BNEP_TYPE_MASK]))
+			goto badframe;
+
+		s->eh.h_proto = get_unaligned((__be16 *) (skb->data - 2));
+	}
 
 	if (type & BNEP_EXT_HEADER) {
 		if (bnep_rx_extension(s, skb) < 0)
@@ -566,6 +598,7 @@ int bnep_add_connection(struct bnep_connadd_req *req, struct socket *sock)
 	s->sock  = sock;
 	s->role  = req->role;
 	s->state = BT_CONNECTED;
+	s->flags = req->flags;
 
 	s->msg.msg_flags = MSG_NOSIGNAL;
 
-- 
2.1.0

