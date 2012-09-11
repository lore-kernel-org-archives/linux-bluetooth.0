Return-Path: <cyrus@holtmann.org>
From: Mat Martineau <mathewm@codeaurora.org>
To: linux-bluetooth@vger.kernel.org, gustavo@padovan.org
Cc: sunnyk@codeaurora.org
Subject: [RFCv1 01/20] Bluetooth: Add new l2cap_chan struct members for high speed channels
Date: Tue, 11 Sep 2012 11:21:12 -0700
Message-Id: <1347387691-5285-2-git-send-email-mathewm@codeaurora.org>
In-Reply-To: <1347387691-5285-1-git-send-email-mathewm@codeaurora.org>
References: <1347387691-5285-1-git-send-email-mathewm@codeaurora.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

An L2CAP channel using high speed continues to be associated with a
BR/EDR l2cap_conn, while also tracking an additional hci_conn
(representing a physical link on a high speed controller) and hci_chan
(representing a logical link).  There may only be one physical link
between two high speed controllers.  Each physical link may contain
several logical links, with each logical link representing a channel
with specific quality of service.

During a channel move, the destination channel id, current move state,
and role (initiator vs. responder) are tracked and used by the channel
move state machine.  The ident value associated with a move request
must also be stored in order to use it in later move responses.

The active channel is stored in local_amp_id.

Signed-off-by: Mat Martineau <mathewm@codeaurora.org>
---
 include/net/bluetooth/l2cap.h | 29 +++++++++++++++++++++++++++++
 net/bluetooth/l2cap_core.c    |  5 +++++
 2 files changed, 34 insertions(+)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index 7ed8e35..6b6fb27 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -433,6 +433,8 @@ struct l2cap_chan {
 	struct sock *sk;
 
 	struct l2cap_conn	*conn;
+	struct hci_conn		*hs_hcon;
+	struct hci_chan		*hs_hchan;
 	struct kref	kref;
 
 	__u8		state;
@@ -476,6 +478,11 @@ struct l2cap_chan {
 	unsigned long	conn_state;
 	unsigned long	flags;
 
+	__u8		local_amp_id;
+	__u8		move_id;
+	__u8		move_state;
+	__u8		move_role;
+
 	__u16		next_tx_seq;
 	__u16		expected_ack_seq;
 	__u16		expected_tx_seq;
@@ -640,6 +647,9 @@ enum {
 enum {
 	L2CAP_RX_STATE_RECV,
 	L2CAP_RX_STATE_SREJ_SENT,
+	L2CAP_RX_STATE_MOVE,
+	L2CAP_RX_STATE_WAIT_P,
+	L2CAP_RX_STATE_WAIT_F,
 };
 
 enum {
@@ -670,6 +680,25 @@ enum {
 	L2CAP_EV_RECV_FRAME,
 };
 
+enum {
+	L2CAP_MOVE_ROLE_NONE,
+	L2CAP_MOVE_ROLE_INITIATOR,
+	L2CAP_MOVE_ROLE_RESPONDER,
+};
+
+enum {
+	L2CAP_MOVE_STABLE,
+	L2CAP_MOVE_WAIT_REQ,
+	L2CAP_MOVE_WAIT_RSP,
+	L2CAP_MOVE_WAIT_RSP_SUCCESS,
+	L2CAP_MOVE_WAIT_CONFIRM,
+	L2CAP_MOVE_WAIT_CONFIRM_RSP,
+	L2CAP_MOVE_WAIT_LOGICAL_COMP,
+	L2CAP_MOVE_WAIT_LOGICAL_CFM,
+	L2CAP_MOVE_WAIT_LOCAL_BUSY,
+	L2CAP_MOVE_WAIT_PREPARE,
+};
+
 void l2cap_chan_hold(struct l2cap_chan *c);
 void l2cap_chan_put(struct l2cap_chan *c);
 
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 9732f03..111e716 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -2747,6 +2747,11 @@ int l2cap_ertm_init(struct l2cap_chan *chan)
 
 	skb_queue_head_init(&chan->tx_q);
 
+	chan->local_amp_id = 0;
+	chan->move_id = 0;
+	chan->move_state = L2CAP_MOVE_STABLE;
+	chan->move_role = L2CAP_MOVE_ROLE_NONE;
+
 	if (chan->mode != L2CAP_MODE_ERTM)
 		return 0;
 
-- 
1.7.12

--
Mat Martineau

The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
