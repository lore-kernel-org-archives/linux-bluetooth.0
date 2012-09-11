Return-Path: <cyrus@holtmann.org>
From: Mat Martineau <mathewm@codeaurora.org>
To: linux-bluetooth@vger.kernel.org, gustavo@padovan.org
Cc: sunnyk@codeaurora.org
Subject: [RFCv1 14/20] Bluetooth: Flag ACL frames as complete for AMP controllers
Date: Tue, 11 Sep 2012 11:21:25 -0700
Message-Id: <1347387691-5285-15-git-send-email-mathewm@codeaurora.org>
In-Reply-To: <1347387691-5285-1-git-send-email-mathewm@codeaurora.org>
References: <1347387691-5285-1-git-send-email-mathewm@codeaurora.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

AMP controllers expect to transmit only "complete" ACL frames.  These
frames have both the "start" and "cont" bits set.  AMP does not allow
fragmented ACLs.

Signed-off-by: Mat Martineau <mathewm@codeaurora.org>
---
 include/net/bluetooth/hci.h |  1 +
 net/bluetooth/l2cap_core.c  | 14 ++++++++++++--
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 0f28f70..0732721 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -196,6 +196,7 @@ enum {
 #define ACL_START_NO_FLUSH	0x00
 #define ACL_CONT		0x01
 #define ACL_START		0x02
+#define ACL_COMPLETE		0x03
 #define ACL_ACTIVE_BCAST	0x04
 #define ACL_PICO_BCAST		0x08
 
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 9d7fab0..4a5c42b 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -734,10 +734,20 @@ static void l2cap_do_send(struct l2cap_chan *chan, struct sk_buff *skb)
 	u16 flags;
 
 	BT_DBG("chan %p, skb %p len %d priority %u", chan, skb, skb->len,
-							skb->priority);
+	       skb->priority);
+
+	if (chan->hs_hcon && (chan->move_state == L2CAP_MOVE_STABLE ||
+			      chan->move_state == L2CAP_MOVE_WAIT_PREPARE)) {
+		if (chan->hs_hchan)
+			hci_send_acl(chan->hs_hchan, skb, ACL_COMPLETE);
+		else
+			kfree_skb(skb);
+
+		return;
+	}
 
 	if (!test_bit(FLAG_FLUSHABLE, &chan->flags) &&
-					lmp_no_flush_capable(hcon->hdev))
+	    lmp_no_flush_capable(hcon->hdev))
 		flags = ACL_START_NO_FLUSH;
 	else
 		flags = ACL_START;
-- 
1.7.12

--
Mat Martineau

The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
