Return-Path: <cyrus@holtmann.org>
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv3 08/16] Bluetooth: EWS: rewrite check frame type function
Date: Tue, 11 Oct 2011 13:37:48 +0300
Message-Id: <1318329476-30153-9-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1318329476-30153-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1318329476-30153-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Check frame function uses now information about control field type.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 include/net/bluetooth/l2cap.h |   18 ++++++++++++++++--
 net/bluetooth/l2cap_core.c    |    9 +++++----
 2 files changed, 21 insertions(+), 6 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index 3ca24af..9444dce 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -548,8 +548,22 @@ static inline __u32 __set_txseq(struct l2cap_chan *chan, __u32 txseq)
 		return (txseq << L2CAP_CTRL_TXSEQ_SHIFT) & L2CAP_CTRL_TXSEQ;
 }
 
-#define __is_iframe(ctrl)	(!((ctrl) & L2CAP_CTRL_FRAME_TYPE))
-#define __is_sframe(ctrl)	((ctrl) & L2CAP_CTRL_FRAME_TYPE)
+static inline bool __is_sframe(struct l2cap_chan *chan, __u32 ctrl)
+{
+	if (test_bit(FLAG_EXT_CTRL, &chan->flags))
+		return ctrl & L2CAP_EXT_CTRL_FRAME_TYPE;
+	else
+		return ctrl & L2CAP_CTRL_FRAME_TYPE;
+}
+
+static inline __u32 __set_sframe(struct l2cap_chan *chan)
+{
+	if (test_bit(FLAG_EXT_CTRL, &chan->flags))
+		return L2CAP_EXT_CTRL_FRAME_TYPE;
+	else
+		return L2CAP_CTRL_FRAME_TYPE;
+}
+
 static inline __u8 __get_ctrl_sar(struct l2cap_chan *chan, __u32 ctrl)
 {
 	if (test_bit(FLAG_EXT_CTRL, &chan->flags))
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 1c367d6..9262a00 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -578,7 +578,8 @@ static inline void l2cap_send_sframe(struct l2cap_chan *chan, u16 control)
 	BT_DBG("chan %p, control 0x%2.2x", chan, control);
 
 	count = min_t(unsigned int, conn->mtu, hlen);
-	control |= L2CAP_CTRL_FRAME_TYPE;
+
+	control |= __set_sframe(chan);
 
 	if (test_and_clear_bit(CONN_SEND_FBIT, &chan->conn_state))
 		control |= L2CAP_CTRL_FINAL;
@@ -3707,7 +3708,7 @@ static int l2cap_ertm_data_rcv(struct sock *sk, struct sk_buff *skb)
 	if (l2cap_check_fcs(chan, skb))
 		goto drop;
 
-	if (__is_sar_start(chan, control) && __is_iframe(control))
+	if (__is_sar_start(chan, control) && !__is_sframe(chan, control))
 		len -= 2;
 
 	if (chan->fcs == L2CAP_FCS_CRC16)
@@ -3734,7 +3735,7 @@ static int l2cap_ertm_data_rcv(struct sock *sk, struct sk_buff *skb)
 		goto drop;
 	}
 
-	if (__is_iframe(control)) {
+	if (!__is_sframe(chan, control)) {
 		if (len < 0) {
 			l2cap_send_disconn_req(chan->conn, chan, ECONNRESET);
 			goto drop;
@@ -3817,7 +3818,7 @@ static inline int l2cap_data_channel(struct l2cap_conn *conn, u16 cid, struct sk
 		if (chan->fcs == L2CAP_FCS_CRC16)
 			len -= 2;
 
-		if (len > chan->mps || len < 0 || __is_sframe(control))
+		if (len > chan->mps || len < 0 || __is_sframe(chan, control))
 			goto drop;
 
 		tx_seq = __get_txseq(chan, control);
-- 
1.7.4.1

