Return-Path: <cyrus@holtmann.org>
From: Par-Gunnar Hjalmdahl <par-gunnar.hjalmdahl@stericsson.com>
To: <linux-bluetooth@vger.kernel.org>
Cc: Anurag Gupta <anurag.gupta@stericsson.com>,
	Par-Gunnar Hjalmdahl <par-gunnar.hjalmdahl@stericsson.com>
Subject: [PATCH] bluetooth: Improve BNEP extension headers handling
Date: Tue, 31 Jul 2012 15:03:53 +0200
Message-ID: <1343739833-827-1-git-send-email-par-gunnar.hjalmdahl@stericsson.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Adds handling of extension headers to BNEP control packets.

Signed-off-by: Par-Gunnar Hjalmdahl <par-gunnar.hjalmdahl@stericsson.com>
---
 net/bluetooth/bnep/core.c | 44 +++++++++++++++++++++++++++++++++++---------
 1 file changed, 35 insertions(+), 9 deletions(-)

diff --git a/net/bluetooth/bnep/core.c b/net/bluetooth/bnep/core.c
index 4a6620b..939b6aa 100644
--- a/net/bluetooth/bnep/core.c
+++ b/net/bluetooth/bnep/core.c
@@ -100,7 +100,8 @@ static inline void bnep_set_default_proto_filter(struct bnep_session *s)
 }
 #endif
 
-static int bnep_ctrl_set_netfilter(struct bnep_session *s, __be16 *data, int len)
+static int bnep_ctrl_set_netfilter(struct bnep_session *s, __be16 *data,
+		int len, int *pkt_size)
 {
 	int n;
 
@@ -116,6 +117,8 @@ static int bnep_ctrl_set_netfilter(struct bnep_session *s, __be16 *data, int len
 
 	BT_DBG("filter len %d", n);
 
+	*pkt_size = 2 + n;
+
 #ifdef CONFIG_BT_BNEP_PROTO_FILTER
 	n /= 4;
 	if (n <= BNEP_MAX_PROTO_FILTERS) {
@@ -146,7 +149,8 @@ static int bnep_ctrl_set_netfilter(struct bnep_session *s, __be16 *data, int len
 	return 0;
 }
 
-static int bnep_ctrl_set_mcfilter(struct bnep_session *s, u8 *data, int len)
+static int bnep_ctrl_set_mcfilter(struct bnep_session *s, u8 *data, int len,
+		int *pkt_size)
 {
 	int n;
 
@@ -162,6 +166,8 @@ static int bnep_ctrl_set_mcfilter(struct bnep_session *s, u8 *data, int len)
 
 	BT_DBG("filter len %d", n);
 
+	*pkt_size = 2 + n;
+
 #ifdef CONFIG_BT_BNEP_MC_FILTER
 	n /= (ETH_ALEN * 2);
 
@@ -207,7 +213,8 @@ static int bnep_ctrl_set_mcfilter(struct bnep_session *s, u8 *data, int len)
 	return 0;
 }
 
-static int bnep_rx_control(struct bnep_session *s, void *data, int len)
+static int bnep_rx_control(struct bnep_session *s, void *data, int len,
+		int *pkt_size)
 {
 	u8  cmd = *(u8 *)data;
 	int err = 0;
@@ -215,6 +222,8 @@ static int bnep_rx_control(struct bnep_session *s, void *data, int len)
 	data++;
 	len--;
 
+	*pkt_size = 0;
+
 	switch (cmd) {
 	case BNEP_CMD_NOT_UNDERSTOOD:
 	case BNEP_SETUP_CONN_RSP:
@@ -224,15 +233,20 @@ static int bnep_rx_control(struct bnep_session *s, void *data, int len)
 		break;
 
 	case BNEP_FILTER_NET_TYPE_SET:
-		err = bnep_ctrl_set_netfilter(s, data, len);
+		err = bnep_ctrl_set_netfilter(s, data, len, pkt_size);
 		break;
 
 	case BNEP_FILTER_MULTI_ADDR_SET:
-		err = bnep_ctrl_set_mcfilter(s, data, len);
+		err = bnep_ctrl_set_mcfilter(s, data, len, pkt_size);
 		break;
 
-	case BNEP_SETUP_CONN_REQ:
-		err = bnep_send_rsp(s, BNEP_SETUP_CONN_RSP, BNEP_CONN_NOT_ALLOWED);
+	case BNEP_SETUP_CONN_REQ: {
+			u8 uuid_size = *(u8 *)data;
+
+			err = bnep_send_rsp(s, BNEP_SETUP_CONN_RSP,
+					BNEP_CONN_NOT_ALLOWED);
+			*pkt_size = 1 + 2 * uuid_size;
+		}
 		break;
 
 	default: {
@@ -245,6 +259,10 @@ static int bnep_rx_control(struct bnep_session *s, void *data, int len)
 		break;
 	}
 
+	if (*pkt_size > 0)
+		/* Add 1 byte for type field */
+		(*pkt_size)++;
+
 	return err;
 }
 
@@ -252,6 +270,7 @@ static int bnep_rx_extension(struct bnep_session *s, struct sk_buff *skb)
 {
 	struct bnep_ext_hdr *h;
 	int err = 0;
+	int pkt_size;
 
 	do {
 		h = (void *) skb->data;
@@ -264,7 +283,7 @@ static int bnep_rx_extension(struct bnep_session *s, struct sk_buff *skb)
 
 		switch (h->type & BNEP_TYPE_MASK) {
 		case BNEP_EXT_CONTROL:
-			bnep_rx_control(s, skb->data, skb->len);
+			bnep_rx_control(s, skb->data, skb->len, &pkt_size);
 			break;
 
 		default:
@@ -304,7 +323,14 @@ static int bnep_rx_frame(struct bnep_session *s, struct sk_buff *skb)
 		goto badframe;
 
 	if ((type & BNEP_TYPE_MASK) == BNEP_CONTROL) {
-		bnep_rx_control(s, skb->data, skb->len);
+		int pkt_size = 0;
+
+		bnep_rx_control(s, skb->data, skb->len, &pkt_size);
+		if (pkt_size > 0 && (type & BNEP_EXT_HEADER)) {
+			skb_pull(skb, pkt_size);
+			if (bnep_rx_extension(s, skb) < 0)
+				goto badframe;
+		}
 		kfree_skb(skb);
 		return 0;
 	}
-- 
1.7.11.1

