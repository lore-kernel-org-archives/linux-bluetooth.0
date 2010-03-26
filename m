Return-Path: <cyrus@holtmann.org>
Sender: "Gustavo F. Padovan" <pao@profusion.mobi>
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org, gustavo@padovan.org
Subject: [PATCH 6/6] Bluetooth: Close channel when an invalid ReqSeq is received
Date: Fri, 26 Mar 2010 16:19:19 -0300
Message-Id: <1269631159-20750-6-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1269631159-20750-5-git-send-email-padovan@profusion.mobi>
References: <1269373726-13209-20-git-send-email-padovan@profusion.mobi>
 <1269631159-20750-1-git-send-email-padovan@profusion.mobi>
 <1269631159-20750-2-git-send-email-padovan@profusion.mobi>
 <1269631159-20750-3-git-send-email-padovan@profusion.mobi>
 <1269631159-20750-4-git-send-email-padovan@profusion.mobi>
 <1269631159-20750-5-git-send-email-padovan@profusion.mobi>
List-ID: <linux-bluetooth.vger.kernel.org>

When we receive a frame With-Invalid-ReqSeq and
With-Invalid-ReqSeq-Retrans we shall close the channel.

Signed-off-by: Gustavo F. Padovan <padovan@profusion.mobi>
---
 net/bluetooth/l2cap.c |   17 +++++++++++++++++
 1 files changed, 17 insertions(+), 0 deletions(-)

diff --git a/net/bluetooth/l2cap.c b/net/bluetooth/l2cap.c
index 20c3f53..b978782 100644
--- a/net/bluetooth/l2cap.c
+++ b/net/bluetooth/l2cap.c
@@ -3460,6 +3460,13 @@ static inline int l2cap_data_channel_iframe(struct sock *sk, u16 rx_control, str
 
 	BT_DBG("sk %p rx_control 0x%4.4x len %d", sk, rx_control, skb->len);
 
+	if ((req_seq - pi->expected_ack_seq) % 64 >
+			(pi->next_tx_seq - pi->expected_ack_seq) % 64) {
+		kfree_skb(skb);
+		l2cap_send_disconn_req(pi->conn, sk);
+		return 0;
+	}
+
 	if (L2CAP_CTRL_FINAL & rx_control) {
 		del_timer(&pi->monitor_timer);
 		if (pi->unacked_frames > 0)
@@ -3687,8 +3694,18 @@ static inline void l2cap_data_channel_rnrframe(struct sock *sk, u16 rx_control)
 
 static inline int l2cap_data_channel_sframe(struct sock *sk, u16 rx_control, struct sk_buff *skb)
 {
+	struct l2cap_pinfo *pi = l2cap_pi(sk);
+	u8 tx_seq = __get_reqseq(rx_control);
+
 	BT_DBG("sk %p rx_control 0x%4.4x len %d", sk, rx_control, skb->len);
 
+	if ((tx_seq - pi->expected_ack_seq) % 64 >
+			(pi->next_tx_seq - pi->expected_ack_seq) % 64) {
+		kfree_skb(skb);
+		l2cap_send_disconn_req(pi->conn, sk);
+		return 0;
+	}
+
 	if (L2CAP_CTRL_FINAL & rx_control) {
 		del_timer(&l2cap_pi(sk)->monitor_timer);
 		if (l2cap_pi(sk)->unacked_frames > 0)
-- 
1.6.4.4
