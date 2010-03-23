Return-Path: <cyrus@holtmann.org>
Sender: "Gustavo F. Padovan" <pao@profusion.mobi>
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org, gustavo@padovan.org, jprvita@profusion.mobi, ulisses@profusion.mobi
Subject: [PATCH 13/19] Bluetooth: Handle all cases of receipt of RNR-frames into L2CAP
Date: Tue, 23 Mar 2010 16:48:40 -0300
Message-Id: <1269373726-13209-14-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1269373726-13209-13-git-send-email-padovan@profusion.mobi>
References: <1269373726-13209-1-git-send-email-padovan@profusion.mobi>
 <1269373726-13209-2-git-send-email-padovan@profusion.mobi>
 <1269373726-13209-3-git-send-email-padovan@profusion.mobi>
 <1269373726-13209-4-git-send-email-padovan@profusion.mobi>
 <1269373726-13209-5-git-send-email-padovan@profusion.mobi>
 <1269373726-13209-6-git-send-email-padovan@profusion.mobi>
 <1269373726-13209-7-git-send-email-padovan@profusion.mobi>
 <1269373726-13209-8-git-send-email-padovan@profusion.mobi>
 <1269373726-13209-9-git-send-email-padovan@profusion.mobi>
 <1269373726-13209-10-git-send-email-padovan@profusion.mobi>
 <1269373726-13209-11-git-send-email-padovan@profusion.mobi>
 <1269373726-13209-12-git-send-email-padovan@profusion.mobi>
 <1269373726-13209-13-git-send-email-padovan@profusion.mobi>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

We weren't handling the receipt under SREJ_SENT state table.
It also introduce l2cap_send_srejtail(). It will be used in the nexts
commits too.

Signed-off-by: Gustavo F. Padovan <padovan@profusion.mobi>
Reviewed-by: João Paulo Rechi Vita <jprvita@profusion.mobi>
---
 net/bluetooth/l2cap.c |   32 ++++++++++++++++++++++++++++----
 1 files changed, 28 insertions(+), 4 deletions(-)

diff --git a/net/bluetooth/l2cap.c b/net/bluetooth/l2cap.c
index 2f32e91..f966ed3 100644
--- a/net/bluetooth/l2cap.c
+++ b/net/bluetooth/l2cap.c
@@ -1447,6 +1447,22 @@ static int l2cap_send_ack(struct l2cap_pinfo *pi)
 	return 0;
 }
 
+static int l2cap_send_srejtail(struct sock *sk)
+{
+	struct srej_list *tail;
+	u16 control;
+
+	control = L2CAP_SUPER_SELECT_REJECT;
+	control |= L2CAP_CTRL_FINAL;
+
+	tail = list_entry(SREJ_LIST(sk)->prev, struct srej_list, list);
+	control |= tail->tx_seq << L2CAP_CTRL_REQSEQ_SHIFT;
+
+	l2cap_send_sframe(l2cap_pi(sk), control);
+
+	return 0;
+}
+
 static inline int l2cap_skbuff_fromiovec(struct sock *sk, struct msghdr *msg, int len, int count, struct sk_buff *skb)
 {
 	struct l2cap_conn *conn = l2cap_pi(sk)->conn;
@@ -3579,11 +3595,19 @@ static inline void l2cap_data_channel_rnrframe(struct sock *sk, u16 rx_control)
 	pi->expected_ack_seq = tx_seq;
 	l2cap_drop_acked_frames(sk);
 
-	del_timer(&pi->retrans_timer);
-	if (rx_control & L2CAP_CTRL_POLL) {
-		u16 control = L2CAP_CTRL_FINAL;
-		l2cap_send_rr_or_rnr(pi, control);
+	if (!(pi->conn_state & L2CAP_CONN_SREJ_SENT)) {
+		del_timer(&pi->retrans_timer);
+		if (rx_control & L2CAP_CTRL_POLL) {
+			u16 control = L2CAP_CTRL_FINAL;
+			l2cap_send_rr_or_rnr(pi, control);
+		}
+		return;
 	}
+
+	if (rx_control & L2CAP_CTRL_POLL)
+		l2cap_send_srejtail(sk);
+	else
+		l2cap_send_sframe(pi, L2CAP_SUPER_RCV_READY);
 }
 
 static inline int l2cap_data_channel_sframe(struct sock *sk, u16 rx_control, struct sk_buff *skb)
-- 
1.6.4.4
