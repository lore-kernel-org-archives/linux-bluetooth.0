Return-Path: <cyrus@holtmann.org>
From: Mat Martineau <mathewm@codeaurora.org>
To: linux-bluetooth@vger.kernel.org,
	gustavo@padovan.org,
	marcel@holtmann.org
Cc: pkrystad@codeaurora.org
Subject: [PATCH 2/2] Bluetooth: Free allocated ERTM SREJ list if init fails
Date: Thu, 17 May 2012 16:20:14 -0700
Message-Id: <1337296814-3763-3-git-send-email-mathewm@codeaurora.org>
In-Reply-To: <1337296814-3763-1-git-send-email-mathewm@codeaurora.org>
References: <1337296814-3763-1-git-send-email-mathewm@codeaurora.org>
List-ID: <linux-bluetooth.vger.kernel.org>

If the ERTM SREJ list is properly allocated but the retransmit list
allocation fails, the SREJ list must be freed before returning from
l2cap_ertm_init.  l2cap_chan_del will not clean up the SREJ list
if l2cap_ertm_init returns a failure code.

Signed-off-by: Mat Martineau <mathewm@codeaurora.org>
---
 net/bluetooth/l2cap_core.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 36edd42..aeb4e6e 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -2381,7 +2381,11 @@ static inline int l2cap_ertm_init(struct l2cap_chan *chan)
 	if (err < 0)
 		return err;
 
-	return l2cap_seq_list_init(&chan->retrans_list, chan->remote_tx_win);
+	err = l2cap_seq_list_init(&chan->retrans_list, chan->remote_tx_win);
+	if (err < 0)
+		l2cap_seq_list_free(&chan->srej_list);
+
+	return err;
 }
 
 static inline __u8 l2cap_select_mode(__u8 mode, __u16 remote_feat_mask)
-- 
1.7.10

--
Mat Martineau
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
