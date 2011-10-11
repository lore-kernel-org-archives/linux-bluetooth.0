Return-Path: <cyrus@holtmann.org>
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv3 04/16] Bluetooth: EWS: rewrite handling Supervisory (S) bits
Date: Tue, 11 Oct 2011 13:37:44 +0300
Message-Id: <1318329476-30153-5-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1318329476-30153-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1318329476-30153-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Supervisory bits occupy different windows in standard / extended control
fields. Convert hardcoded masks to relative ones and use shift to access
S-bit window.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 include/net/bluetooth/l2cap.h |   27 +++++++++++++++++++++++----
 net/bluetooth/l2cap_core.c    |   41 ++++++++++++++++++++++-------------------
 2 files changed, 45 insertions(+), 23 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index fa7edab..f24f5cf 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -140,10 +140,10 @@ struct l2cap_conninfo {
 #define L2CAP_EXT_CTRL_TXSEQ_SHIFT	18
 
 /* L2CAP Supervisory Function */
-#define L2CAP_SUPER_RCV_READY           0x0000
-#define L2CAP_SUPER_REJECT              0x0004
-#define L2CAP_SUPER_RCV_NOT_READY       0x0008
-#define L2CAP_SUPER_SELECT_REJECT       0x000C
+#define L2CAP_SUPER_RR		0x00
+#define L2CAP_SUPER_REJ		0x01
+#define L2CAP_SUPER_RNR		0x02
+#define L2CAP_SUPER_SREJ	0x03
 
 /* L2CAP Segmentation and Reassembly */
 #define L2CAP_SDU_UNSEGMENTED       0x0000
@@ -518,6 +518,25 @@ static inline int l2cap_tx_window_full(struct l2cap_chan *ch)
 #define __is_sframe(ctrl)	((ctrl) & L2CAP_CTRL_FRAME_TYPE)
 #define __is_sar_start(ctrl)	(((ctrl) & L2CAP_CTRL_SAR) == L2CAP_SDU_START)
 
+static inline __u8 __get_ctrl_super(struct l2cap_chan *chan, __u32 ctrl)
+{
+	if (test_bit(FLAG_EXT_CTRL, &chan->flags))
+		return (ctrl & L2CAP_EXT_CTRL_SUPERVISE) >>
+						L2CAP_EXT_CTRL_SUPER_SHIFT;
+	else
+		return (ctrl & L2CAP_CTRL_SUPERVISE) >> L2CAP_CTRL_SUPER_SHIFT;
+}
+
+static inline __u32 __set_ctrl_super(struct l2cap_chan *chan, __u32 super)
+{
+	if (test_bit(FLAG_EXT_CTRL, &chan->flags))
+		return (super << L2CAP_EXT_CTRL_SUPER_SHIFT) &
+						L2CAP_EXT_CTRL_SUPERVISE;
+	else
+		return (super << L2CAP_CTRL_SUPER_SHIFT) &
+							L2CAP_CTRL_SUPERVISE;
+}
+
 extern int disable_ertm;
 
 int l2cap_init_sockets(void);
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 6e34312..93b5da6 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -613,10 +613,10 @@ static inline void l2cap_send_sframe(struct l2cap_chan *chan, u16 control)
 static inline void l2cap_send_rr_or_rnr(struct l2cap_chan *chan, u16 control)
 {
 	if (test_bit(CONN_LOCAL_BUSY, &chan->conn_state)) {
-		control |= L2CAP_SUPER_RCV_NOT_READY;
+		control |= __set_ctrl_super(chan, L2CAP_SUPER_RNR);
 		set_bit(CONN_RNR_SENT, &chan->conn_state);
 	} else
-		control |= L2CAP_SUPER_RCV_READY;
+		control |= __set_ctrl_super(chan, L2CAP_SUPER_RR);
 
 	control |= chan->buffer_seq << L2CAP_CTRL_REQSEQ_SHIFT;
 
@@ -1408,7 +1408,7 @@ static void l2cap_send_ack(struct l2cap_chan *chan)
 	control |= chan->buffer_seq << L2CAP_CTRL_REQSEQ_SHIFT;
 
 	if (test_bit(CONN_LOCAL_BUSY, &chan->conn_state)) {
-		control |= L2CAP_SUPER_RCV_NOT_READY;
+		control |= __set_ctrl_super(chan, L2CAP_SUPER_RNR);
 		set_bit(CONN_RNR_SENT, &chan->conn_state);
 		l2cap_send_sframe(chan, control);
 		return;
@@ -1417,7 +1417,7 @@ static void l2cap_send_ack(struct l2cap_chan *chan)
 	if (l2cap_ertm_send(chan) > 0)
 		return;
 
-	control |= L2CAP_SUPER_RCV_READY;
+	control |= __set_ctrl_super(chan, L2CAP_SUPER_RR);
 	l2cap_send_sframe(chan, control);
 }
 
@@ -1426,7 +1426,7 @@ static void l2cap_send_srejtail(struct l2cap_chan *chan)
 	struct srej_list *tail;
 	u16 control;
 
-	control = L2CAP_SUPER_SELECT_REJECT;
+	control = __set_ctrl_super(chan, L2CAP_SUPER_SREJ);
 	control |= L2CAP_CTRL_FINAL;
 
 	tail = list_entry((&chan->srej_l)->prev, struct srej_list, list);
@@ -3119,7 +3119,7 @@ static inline void l2cap_send_i_or_rr_or_rnr(struct l2cap_chan *chan)
 	control |= chan->buffer_seq << L2CAP_CTRL_REQSEQ_SHIFT;
 
 	if (test_bit(CONN_LOCAL_BUSY, &chan->conn_state)) {
-		control |= L2CAP_SUPER_RCV_NOT_READY;
+		control |= __set_ctrl_super(chan, L2CAP_SUPER_RNR);
 		l2cap_send_sframe(chan, control);
 		set_bit(CONN_RNR_SENT, &chan->conn_state);
 	}
@@ -3131,7 +3131,7 @@ static inline void l2cap_send_i_or_rr_or_rnr(struct l2cap_chan *chan)
 
 	if (!test_bit(CONN_LOCAL_BUSY, &chan->conn_state) &&
 			chan->frames_sent == 0) {
-		control |= L2CAP_SUPER_RCV_READY;
+		control |= __set_ctrl_super(chan, L2CAP_SUPER_RR);
 		l2cap_send_sframe(chan, control);
 	}
 }
@@ -3287,7 +3287,7 @@ static void l2cap_ertm_enter_local_busy(struct l2cap_chan *chan)
 	set_bit(CONN_LOCAL_BUSY, &chan->conn_state);
 
 	control = chan->buffer_seq << L2CAP_CTRL_REQSEQ_SHIFT;
-	control |= L2CAP_SUPER_RCV_NOT_READY;
+	control |= __set_ctrl_super(chan, L2CAP_SUPER_RNR);
 	l2cap_send_sframe(chan, control);
 
 	set_bit(CONN_RNR_SENT, &chan->conn_state);
@@ -3303,7 +3303,8 @@ static void l2cap_ertm_exit_local_busy(struct l2cap_chan *chan)
 		goto done;
 
 	control = chan->buffer_seq << L2CAP_CTRL_REQSEQ_SHIFT;
-	control |= L2CAP_SUPER_RCV_READY | L2CAP_CTRL_POLL;
+	control |= L2CAP_CTRL_POLL;
+	control |= __set_ctrl_super(chan, L2CAP_SUPER_RR);
 	l2cap_send_sframe(chan, control);
 	chan->retry_count = 1;
 
@@ -3367,7 +3368,7 @@ static void l2cap_resend_srejframe(struct l2cap_chan *chan, u8 tx_seq)
 			kfree(l);
 			return;
 		}
-		control = L2CAP_SUPER_SELECT_REJECT;
+		control = __set_ctrl_super(chan, L2CAP_SUPER_SREJ);
 		control |= l->tx_seq << L2CAP_CTRL_REQSEQ_SHIFT;
 		l2cap_send_sframe(chan, control);
 		list_del(&l->list);
@@ -3381,7 +3382,7 @@ static void l2cap_send_srejframe(struct l2cap_chan *chan, u8 tx_seq)
 	u16 control;
 
 	while (tx_seq != chan->expected_tx_seq) {
-		control = L2CAP_SUPER_SELECT_REJECT;
+		control = __set_ctrl_super(chan, L2CAP_SUPER_SREJ);
 		control |= chan->expected_tx_seq << L2CAP_CTRL_REQSEQ_SHIFT;
 		l2cap_send_sframe(chan, control);
 
@@ -3645,10 +3646,12 @@ static inline void l2cap_data_channel_rnrframe(struct l2cap_chan *chan, u16 rx_c
 		return;
 	}
 
-	if (rx_control & L2CAP_CTRL_POLL)
+	if (rx_control & L2CAP_CTRL_POLL) {
 		l2cap_send_srejtail(chan);
-	else
-		l2cap_send_sframe(chan, L2CAP_SUPER_RCV_READY);
+	} else {
+		rx_control = __set_ctrl_super(chan, L2CAP_SUPER_RR);
+		l2cap_send_sframe(chan, rx_control);
+	}
 }
 
 static inline int l2cap_data_channel_sframe(struct l2cap_chan *chan, u16 rx_control, struct sk_buff *skb)
@@ -3663,20 +3666,20 @@ static inline int l2cap_data_channel_sframe(struct l2cap_chan *chan, u16 rx_cont
 		clear_bit(CONN_WAIT_F, &chan->conn_state);
 	}
 
-	switch (rx_control & L2CAP_CTRL_SUPERVISE) {
-	case L2CAP_SUPER_RCV_READY:
+	switch (__get_ctrl_super(chan, rx_control)) {
+	case L2CAP_SUPER_RR:
 		l2cap_data_channel_rrframe(chan, rx_control);
 		break;
 
-	case L2CAP_SUPER_REJECT:
+	case L2CAP_SUPER_REJ:
 		l2cap_data_channel_rejframe(chan, rx_control);
 		break;
 
-	case L2CAP_SUPER_SELECT_REJECT:
+	case L2CAP_SUPER_SREJ:
 		l2cap_data_channel_srejframe(chan, rx_control);
 		break;
 
-	case L2CAP_SUPER_RCV_NOT_READY:
+	case L2CAP_SUPER_RNR:
 		l2cap_data_channel_rnrframe(chan, rx_control);
 		break;
 	}
-- 
1.7.4.1

