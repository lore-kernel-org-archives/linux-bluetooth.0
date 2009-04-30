Return-Path: <cyrus@holtmann.org>
From: ngh@isomerica.net
To: linux-bluetooth@vger.kernel.org
Cc: Nathan Holstein <nathan@lampreynetworks.com>
Subject: [PATCH 08/10] Reassemble segmented L2CAP PDUs upon reception
Date: Thu, 30 Apr 2009 17:16:45 -0400
Message-Id: <1241126207-19996-9-git-send-email-ngh@isomerica.net>
In-Reply-To: <1241126207-19996-1-git-send-email-ngh@isomerica.net>
References: <1241126207-19996-1-git-send-email-ngh@isomerica.net>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Nathan Holstein <nathan@lampreynetworks.com>

When configured in Enhanced Retransmission of Streaming modes, data sent over
L2CAP can be broken up into multiple L2CAP SDUs.  This patch adds support for
reassembling these packets upon reception.

Signed-off-by: Nathan Holstein <nathan@lampreynetworks.com>
---
 include/net/bluetooth/l2cap.h |    3 ++
 net/bluetooth/l2cap.c         |   53 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 56 insertions(+), 0 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index 85fc21b..44e6e92 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -316,6 +316,9 @@ struct l2cap_pinfo {
 	__u16		monitor_timeout;
 	__u16		max_pdu_size;
 
+	__u16		sdu_next;
+	__u16		sdu_len;
+
 	__le16		sport;
 
         struct sk_buff		*tx_buf;
diff --git a/net/bluetooth/l2cap.c b/net/bluetooth/l2cap.c
index ad96ce7..228f7f0 100644
--- a/net/bluetooth/l2cap.c
+++ b/net/bluetooth/l2cap.c
@@ -2591,6 +2591,43 @@ static int l2cap_check_fcs(struct l2cap_pinfo *pi, struct l2cap_hdr *lh, struct
 	return 0;
 }
 
+static int l2cap_check_sar(struct l2cap_pinfo *pi, u16 control, struct sk_buff *skb)
+{
+	u16 mask = control & L2CAP_CONTROL_SAR_MASK;
+
+	switch (mask)
+	{
+	case L2CAP_SAR_UNSEGMENTED:
+		if (pi->sdu_next != 0)
+			return -1;
+		break;
+
+	case L2CAP_SAR_SDU_START:
+		if (pi->sdu_next != 0 || skb->len < 2)
+			return -1;
+		pi->sdu_next = 1;
+		pi->sdu_len = get_unaligned((__le16 *) skb->data);
+		skb_pull(skb, 2);
+		break;
+
+	case L2CAP_SAR_SDU_CONTINUE:
+		if (pi->sdu_next >= pi->sdu_len)
+			return -1;
+		++pi->sdu_next;
+		break;
+
+	case L2CAP_SAR_SDU_END:
+		/* TODO:
+		 * How do we correctly signal MSG_EOR? */
+		if (pi->sdu_next != pi->sdu_len)
+			return -1;
+		pi->sdu_next = pi->sdu_len = 0;
+		break;
+	}
+
+	return 0;
+}
+
 static inline int l2cap_data_channel_i_frame(struct sock *sk, u16 rx_control, struct sk_buff *skb)
 {
 	struct l2cap_pinfo *pi = l2cap_pi(sk);
@@ -2610,6 +2647,17 @@ static inline int l2cap_data_channel_i_frame(struct sock *sk, u16 rx_control, st
 	L2CAP_SEQ_NUM_INC(pi->req_seq);
 	tx_control = pi->req_seq << L2CAP_CONTROL_REQSEQ_SHIFT;
 
+	/* TODO:
+	 * l2cap_check_sar() call side effects!  After calling this function,
+	 * we can't reject the SDU without possibly screwing up reassembly.
+	 * We need to ensure the sequence number is correct, and that we can
+	 * queue the skb before calling l2cap_check_sar(). */
+	if (l2cap_check_sar(pi, rx_control, skb)) {
+		tx_control |= L2CAP_SUPER_REJECT;
+		err = -1;
+		goto respond;
+	}
+
 	if ((err = sock_queue_rcv_skb(sk, skb))) {
 		tx_control |= L2CAP_SUPER_RCV_NOT_READY;
 		goto respond;
@@ -2690,6 +2738,11 @@ static int l2cap_data_channel_streaming(struct sock *sk, struct l2cap_hdr *lh, s
 	control = get_unaligned((__le16 *) skb->data);
 	skb_pull(skb, 2);
 
+	/* Todo:
+	 * is this the proper behavior? */
+	if (l2cap_is_I_frame(control) && l2cap_check_sar(pi, control, skb))
+		return -1;
+
 	if (!sock_queue_rcv_skb(sk, skb))
 		return -1;
 
-- 
1.6.0.6

