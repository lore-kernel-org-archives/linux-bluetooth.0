Return-Path: <cyrus@holtmann.org>
Sender: "Gustavo F. Padovan" <gfpadovan@gmail.com>
From: "Gustavo F. Padovan" <gustavo@padovan.org>
To: linux-bluetooth@vger.kernel.org
Cc: gustavo@padovan.org,
	marcel@holtmann.org,
	"Gustavo F. Padovan" <padovan@profusion.mobi>
Subject: [PATCH 03/14] Bluetooth: Fix drop of packets with invalid req_seq/tx_seq
Date: Sat,  5 Jun 2010 04:50:07 -0300
Message-Id: <1275724218-29453-4-git-send-email-gustavo@padovan.org>
In-Reply-To: <1275724218-29453-3-git-send-email-gustavo@padovan.org>
References: <1275724218-29453-1-git-send-email-gustavo@padovan.org>
 <1275724218-29453-2-git-send-email-gustavo@padovan.org>
 <1275724218-29453-3-git-send-email-gustavo@padovan.org>
List-ID: <linux-bluetooth.vger.kernel.org>

From: Gustavo F. Padovan <padovan@profusion.mobi>

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
1.7.1
