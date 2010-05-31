Return-Path: <cyrus@holtmann.org>
Sender: "Gustavo F. Padovan" <pao@profusion.mobi>
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: jprvita@profusion.mobi, gustavo@padovan.org, marcel@holtmann.org
Subject: [PATCH 03/11] Bluetooth: Fix drop of packets with invalid req_seq/tx_seq
Date: Mon, 31 May 2010 16:05:19 -0300
Message-Id: <1275332727-16263-3-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1275332727-16263-2-git-send-email-padovan@profusion.mobi>
References: <1275332727-16263-1-git-send-email-padovan@profusion.mobi>
 <1275332727-16263-2-git-send-email-padovan@profusion.mobi>
List-ID: <linux-bluetooth.vger.kernel.org>

We can't use an unsigned var since we are expecting negatives value
there too.

Signed-off-by: Gustavo F. Padovan <padovan@profusion.mobi>
---
 net/bluetooth/l2cap.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/l2cap.c b/net/bluetooth/l2cap.c
index e036419..b08731d 100644
--- a/net/bluetooth/l2cap.c
+++ b/net/bluetooth/l2cap.c
@@ -3789,7 +3789,7 @@ static inline int l2cap_data_channel_iframe(struct sock *sk, u16 rx_control, str
 	u8 tx_seq = __get_txseq(rx_control);
 	u8 req_seq = __get_reqseq(rx_control);
 	u8 sar = rx_control >> L2CAP_CTRL_SAR_SHIFT;
-	u8 tx_seq_offset, expected_tx_seq_offset;
+	int tx_seq_offset, expected_tx_seq_offset;
 	int num_to_ack = (pi->tx_win/6) + 1;
 	int err = 0;
 
@@ -4074,7 +4074,8 @@ static inline int l2cap_data_channel(struct l2cap_conn *conn, u16 cid, struct sk
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
