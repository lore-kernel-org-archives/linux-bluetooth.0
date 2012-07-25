Return-Path: <cyrus@holtmann.org>
From: Mat Martineau <mathewm@codeaurora.org>
To: linux-bluetooth@vger.kernel.org, gustavo@padovan.org,
	Andrei.Emeltchenko.news@gmail.com
Cc: pkrystad@codeaurora.org
Subject: [RFCv0 20/21] Bluetooth: Do not process ERTM reject during move
Date: Wed, 25 Jul 2012 16:51:12 -0700
Message-Id: <1343260274-11953-21-git-send-email-mathewm@codeaurora.org>
In-Reply-To: <1343260274-11953-1-git-send-email-mathewm@codeaurora.org>
References: <1343260274-11953-1-git-send-email-mathewm@codeaurora.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Signed-off-by: Mat Martineau <mathewm@codeaurora.org>
---
 net/bluetooth/l2cap_core.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index d69b4b3..752ff74 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -5560,8 +5560,9 @@ static int l2cap_rx_state_recv(struct l2cap_chan *chan,
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
1.7.11.2

--
Mat Martineau
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
