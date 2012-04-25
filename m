Return-Path: <cyrus@holtmann.org>
From: Manoj <manojkr.sharma@stericsson.com>
To: <linux-bluetooth@vger.kernel.org>
Cc: Anurag Gupta <anurag.gupta@stericsson.com>,
	Manoj <manojkr.sharma@stericsson.com>
Subject: [PATCH 2/2] Bluetooth: Fix retransmission of ERTM packets
Date: Wed, 25 Apr 2012 13:59:04 +0530
Message-ID: <1335342544-17320-2-git-send-email-manojkr.sharma@stericsson.com>
In-Reply-To: <1335342544-17320-1-git-send-email-manojkr.sharma@stericsson.com>
References: <1335342544-17320-1-git-send-email-manojkr.sharma@stericsson.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

State CONN_REJ_ACT of connection is not handled properly.
ERTM packets should be transmitted only if bit corresponding to
CONN_REJ_ACT in conn_state field is set. Opposite was being
done, which has been fixed by this patch.

Signed-off-by: Manoj <manojkr.sharma@stericsson.com>
---
 net/bluetooth/l2cap_core.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index a9319e2..485d374 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -4324,7 +4324,7 @@ expected:
 	}
 
 	if (__is_ctrl_final(chan, rx_control)) {
-		if (!test_and_clear_bit(CONN_REJ_ACT, &chan->conn_state))
+		if (test_and_clear_bit(CONN_REJ_ACT, &chan->conn_state))
 			l2cap_retransmit_frames(chan);
 	}
 
@@ -4366,7 +4366,7 @@ static inline void l2cap_data_channel_rrframe(struct l2cap_chan *chan, u32 rx_co
 	} else if (__is_ctrl_final(chan, rx_control)) {
 		clear_bit(CONN_REMOTE_BUSY, &chan->conn_state);
 
-		if (!test_and_clear_bit(CONN_REJ_ACT, &chan->conn_state))
+		if (test_and_clear_bit(CONN_REJ_ACT, &chan->conn_state))
 			l2cap_retransmit_frames(chan);
 
 	} else {
@@ -4394,7 +4394,7 @@ static inline void l2cap_data_channel_rejframe(struct l2cap_chan *chan, u32 rx_c
 	l2cap_drop_acked_frames(chan);
 
 	if (__is_ctrl_final(chan, rx_control)) {
-		if (!test_and_clear_bit(CONN_REJ_ACT, &chan->conn_state))
+		if (test_and_clear_bit(CONN_REJ_ACT, &chan->conn_state))
 			l2cap_retransmit_frames(chan);
 	} else {
 		l2cap_retransmit_frames(chan);
-- 
1.6.6.1

