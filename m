Return-Path: <cyrus@holtmann.org>
From: Mat Martineau <mathewm@codeaurora.org>
To: linux-bluetooth@vger.kernel.org, gustavo@padovan.org
Cc: sunnyk@codeaurora.org
Subject: [RFCv1 19/20] Bluetooth: Do not retransmit data during a channel move
Date: Tue, 11 Sep 2012 11:21:30 -0700
Message-Id: <1347387691-5285-20-git-send-email-mathewm@codeaurora.org>
In-Reply-To: <1347387691-5285-1-git-send-email-mathewm@codeaurora.org>
References: <1347387691-5285-1-git-send-email-mathewm@codeaurora.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Do not retransmit previously-sent data when a "receiver ready" s-frame
with the "final" flag is received during a move.

The ERTM state machines will resynchronize at the end of a channel
move, and the state machine needs to avoid state changes during a
move.

Signed-off-by: Mat Martineau <mathewm@codeaurora.org>
---
 net/bluetooth/l2cap_core.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index bde1303..35baa27 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -5580,8 +5580,9 @@ static int l2cap_rx_state_recv(struct l2cap_chan *chan,
 		if (control->final) {
 			clear_bit(CONN_REMOTE_BUSY, &chan->conn_state);
 
-			if (!test_and_clear_bit(CONN_REJ_ACT,
-						&chan->conn_state)) {
+			if (!test_and_clear_bit(CONN_REJ_ACT, &chan->conn_state)
+			    && (chan->move_state == L2CAP_MOVE_STABLE ||
+				chan->move_state == L2CAP_MOVE_WAIT_PREPARE)) {
 				control->final = 0;
 				l2cap_retransmit_all(chan, control);
 			}
-- 
1.7.12

--
Mat Martineau

The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
