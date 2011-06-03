Return-Path: <cyrus@holtmann.org>
From: Mat Martineau <mathewm@codeaurora.org>
To: linux-bluetooth@vger.kernel.org
Cc: padovan@profusion.mobi, Mat Martineau <mathewm@codeaurora.org>
Subject: [PATCH 4/4] Bluetooth: Fix check for the ERTM local busy state
Date: Fri,  3 Jun 2011 16:21:10 -0700
Message-Id: <1307143270-2655-4-git-send-email-mathewm@codeaurora.org>
In-Reply-To: <1307143270-2655-1-git-send-email-mathewm@codeaurora.org>
References: <1307143270-2655-1-git-send-email-mathewm@codeaurora.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Local busy is encoded in a bitfield, but was not masked out correctly.

Signed-off-by: Mat Martineau <mathewm@codeaurora.org>
---
 net/bluetooth/l2cap_core.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index d167edd..6d7c5d8 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -3567,7 +3567,7 @@ static inline int l2cap_data_channel_iframe(struct l2cap_chan *chan, u16 rx_cont
 		goto drop;
 	}
 
-	if (chan->conn_state == L2CAP_CONN_LOCAL_BUSY)
+	if (chan->conn_state & L2CAP_CONN_LOCAL_BUSY)
 		goto drop;
 
 	if (chan->conn_state & L2CAP_CONN_SREJ_SENT) {
-- 
1.7.5.2


--
Mat Martineau
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum

