Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2] Bluetooth: Fix l2cap_tx_window_full
Date: Wed,  8 Feb 2012 15:47:35 +0200
Message-Id: <1328708855-3010-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

l2cap_tx_window_full is not checking the window limit properly, first it
computes based on sequence numbers which doesn't take into account the
ReqSeq and always assume 64 not the real window size.

To fix this now it just checks if the number of unacked frames is >= of
tx window which is much simpler.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
Add debug

 include/net/bluetooth/l2cap.h |   10 +++-------
 1 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index 42fdbb8..bcfddb2 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -661,14 +661,10 @@ static inline __u16 __next_seq(struct l2cap_chan *chan, __u16 seq)
 
 static inline int l2cap_tx_window_full(struct l2cap_chan *ch)
 {
-	int sub;
+	BT_DBG("chan %p unacked %d tx_win %d", ch, ch->unacked_frames,
+							ch->remote_tx_win);
 
-	sub = (ch->next_tx_seq - ch->expected_ack_seq) % 64;
-
-	if (sub < 0)
-		sub += 64;
-
-	return sub == ch->remote_tx_win;
+	return ch->unacked_frames >= ch->remote_tx_win;
 }
 
 static inline __u16 __get_reqseq(struct l2cap_chan *chan, __u32 ctrl)
-- 
1.7.7.6

