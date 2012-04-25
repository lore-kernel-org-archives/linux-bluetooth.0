Return-Path: <cyrus@holtmann.org>
From: Mat Martineau <mathewm@codeaurora.org>
To: linux-bluetooth@vger.kernel.org, gustavo@padovan.org,
	marcel@holtmann.org
Cc: pkrystad@codeaurora.org, andrei.emeltchenko.news@gmail.com
Subject: [RFC 1/8] Bluetooth: Improve ERTM sequence number offset calculation
Date: Wed, 25 Apr 2012 16:36:12 -0700
Message-Id: <1335396979-11692-2-git-send-email-mathewm@codeaurora.org>
In-Reply-To: <1335396979-11692-1-git-send-email-mathewm@codeaurora.org>
References: <1335396979-11692-1-git-send-email-mathewm@codeaurora.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Instead of using modular division, the offset can be calculated using
only addition and subtraction.  The previous calculation did not work
as intended and was more difficult to understand, involving unsigned
integer underflow and a check for a negative value where one was not
possible.

Signed-off-by: Mat Martineau <mathewm@codeaurora.org>
---
 include/net/bluetooth/l2cap.h |   11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index 22e9ec9..92c0423 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -724,13 +724,10 @@ static inline bool l2cap_clear_timer(struct l2cap_chan *chan,
 
 static inline int __seq_offset(struct l2cap_chan *chan, __u16 seq1, __u16 seq2)
 {
-	int offset;
-
-	offset = (seq1 - seq2) % (chan->tx_win_max + 1);
-	if (offset < 0)
-		offset += (chan->tx_win_max + 1);
-
-	return offset;
+	if (seq1 >= seq2)
+		return seq1 - seq2;
+	else
+		return chan->tx_win_max + 1 - seq2 + seq1;
 }
 
 static inline __u16 __next_seq(struct l2cap_chan *chan, __u16 seq)
-- 
1.7.10

--
Mat Martineau
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
