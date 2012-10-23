Return-Path: <cyrus@holtmann.org>
From: Mat Martineau <mathewm@codeaurora.org>
To: linux-bluetooth@vger.kernel.org,
	gustavo@padovan.org
Cc: sunnyk@codeaurora.org,
	marcel@holtmann.org,
	andrei.emeltchenko.news@gmail.com
Subject: [PATCHv5 17/18] Bluetooth: Do not retransmit data during a channel move
Date: Tue, 23 Oct 2012 15:24:22 -0700
Message-Id: <1351031063-11791-18-git-send-email-mathewm@codeaurora.org>
In-Reply-To: <1351031063-11791-1-git-send-email-mathewm@codeaurora.org>
References: <1351031063-11791-1-git-send-email-mathewm@codeaurora.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Do not retransmit previously-sent data when a "receiver ready" s-frame
with the "final" flag is received during a move.

The ERTM state machines will resynchronize at the end of a channel
move, and the state machine needs to avoid state changes during a
move.

Signed-off-by: Mat Martineau <mathewm@codeaurora.org>
Acked-by: Marcel Holtmann <marcel@holtmann.org>
Acked-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 net/bluetooth/l2cap_core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index ef86ebb..93f1ebb 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -5591,8 +5591,8 @@ static int l2cap_rx_state_recv(struct l2cap_chan *chan,
 		if (control->final) {
 			clear_bit(CONN_REMOTE_BUSY, &chan->conn_state);
 
-			if (!test_and_clear_bit(CONN_REJ_ACT,
-						&chan->conn_state)) {
+			if (!test_and_clear_bit(CONN_REJ_ACT, &chan->conn_state) &&
+			    !__chan_is_moving(chan)) {
 				control->final = 0;
 				l2cap_retransmit_all(chan, control);
 			}
-- 
1.8.0

--
Mat Martineau

Employee of Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
