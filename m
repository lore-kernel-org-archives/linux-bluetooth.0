Return-Path: <cyrus@holtmann.org>
Sender: "Gustavo F. Padovan" <pao@profusion.mobi>
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org, gustavo@padovan.org
Subject: [l2cap 2/6] Bluetooth: Fix drop of packets with invalid req_seq/tx_seq
Date: Wed, 12 May 2010 00:05:54 -0300
Message-Id: <1273633558-10576-2-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1273633558-10576-1-git-send-email-padovan@profusion.mobi>
References: <1273513181-28258-2-git-send-email-gustavo@padovan.org>
 <1273633558-10576-1-git-send-email-padovan@profusion.mobi>
List-ID: <linux-bluetooth.vger.kernel.org>

We can't use an unsigned var since we are expecting negatives value
there too.

Signed-off-by: Gustavo F. Padovan <padovan@profusion.mobi>
---
 net/bluetooth/l2cap.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/l2cap.c b/net/bluetooth/l2cap.c
index a7e14c0..93667ac 100644
--- a/net/bluetooth/l2cap.c
+++ b/net/bluetooth/l2cap.c
@@ -3790,7 +3790,7 @@ static inline int l2cap_data_channel_iframe(struct sock *sk, u16 rx_control, str
 	u8 tx_seq = __get_txseq(rx_control);
 	u8 req_seq = __get_reqseq(rx_control);
 	u8 sar = rx_control >> L2CAP_CTRL_SAR_SHIFT;
-	u8 tx_seq_offset, expected_tx_seq_offset;
+	int tx_seq_offset, expected_tx_seq_offset;
 	int num_to_ack = (pi->tx_win/6) + 1;
 	int err = 0;
 
@@ -4075,7 +4075,8 @@ static inline int l2cap_data_channel(struct l2cap_conn *conn, u16 cid, struct sk
 	struct sock *sk;
 	struct l2cap_pinfo *pi;
 	u16 control, len;
-	u8 tx_seq, req_seq, next_tx_seq_offset, req_seq_offset;
+	u8 tx_seq, req_seq;
+	int next_tx_seq_offset, req_seq_offset;
 
 	sk = l2cap_get_chan_by_scid(&conn->chan_list, cid);
 	if (!sk) {
-- 
1.6.4.4
