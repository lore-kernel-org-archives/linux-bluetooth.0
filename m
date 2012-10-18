Return-Path: <cyrus@holtmann.org>
From: Mat Martineau <mathewm@codeaurora.org>
To: linux-bluetooth@vger.kernel.org,
	gustavo@padovan.org
Cc: sunnyk@codeaurora.org,
	marcel@holtmann.org,
	andrei.emeltchenko.news@gmail.com
Subject: [PATCHv3 13/18] Bluetooth: Flag ACL frames as complete for AMP controllers
Date: Thu, 18 Oct 2012 10:58:45 -0700
Message-Id: <1350583130-3241-14-git-send-email-mathewm@codeaurora.org>
In-Reply-To: <1350583130-3241-1-git-send-email-mathewm@codeaurora.org>
References: <1350583130-3241-1-git-send-email-mathewm@codeaurora.org>
List-ID: <linux-bluetooth.vger.kernel.org>

AMP controllers expect to transmit only "complete" ACL frames.  These
frames have both the "start" and "cont" bits set.  AMP does not allow
fragmented ACLs.

Signed-off-by: Mat Martineau <mathewm@codeaurora.org>
Acked-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/l2cap_core.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index d83faa9..a8fc10d 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -762,6 +762,15 @@ static void l2cap_do_send(struct l2cap_chan *chan, struct sk_buff *skb)
 	BT_DBG("chan %p, skb %p len %d priority %u", chan, skb, skb->len,
 	       skb->priority);
 
+	if (chan->hs_hcon && !__chan_is_moving(chan)) {
+		if (chan->hs_hchan)
+			hci_send_acl(chan->hs_hchan, skb, ACL_COMPLETE);
+		else
+			kfree_skb(skb);
+
+		return;
+	}
+
 	if (!test_bit(FLAG_FLUSHABLE, &chan->flags) &&
 	    lmp_no_flush_capable(hcon->hdev))
 		flags = ACL_START_NO_FLUSH;
-- 
1.7.12.3

--
Mat Martineau

Employee of Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
