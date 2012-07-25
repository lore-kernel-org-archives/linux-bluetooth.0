Return-Path: <cyrus@holtmann.org>
From: Mat Martineau <mathewm@codeaurora.org>
To: linux-bluetooth@vger.kernel.org, gustavo@padovan.org,
	Andrei.Emeltchenko.news@gmail.com
Cc: pkrystad@codeaurora.org
Subject: [RFCv0 15/21] Bluetooth: Enable data sends on AMP controller
Date: Wed, 25 Jul 2012 16:51:07 -0700
Message-Id: <1343260274-11953-16-git-send-email-mathewm@codeaurora.org>
In-Reply-To: <1343260274-11953-1-git-send-email-mathewm@codeaurora.org>
References: <1343260274-11953-1-git-send-email-mathewm@codeaurora.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Signed-off-by: Mat Martineau <mathewm@codeaurora.org>
---
 include/net/bluetooth/hci.h |  1 +
 net/bluetooth/l2cap_core.c  | 14 ++++++++++++--
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 7f19556..125082e 100644
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
index 7e253ce..113ea8e 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -732,10 +732,20 @@ static void l2cap_do_send(struct l2cap_chan *chan, struct sk_buff *skb)
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
1.7.11.2

--
Mat Martineau
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
