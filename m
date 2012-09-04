Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFCv1 11/15] Bluetooth: AMP: Send data over AMP channel
Date: Tue,  4 Sep 2012 16:44:30 +0300
Message-Id: <1346766274-21612-12-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1346766274-21612-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1346766274-21612-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>


Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 include/net/bluetooth/hci.h |    1 +
 net/bluetooth/l2cap_core.c  |    7 +++++++
 2 files changed, 8 insertions(+)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 4c41b8c..f19dfde 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -198,6 +198,7 @@ enum {
 #define ACL_START_NO_FLUSH	0x00
 #define ACL_CONT		0x01
 #define ACL_START		0x02
+#define ACL_COMPLETE		0x03
 #define ACL_ACTIVE_BCAST	0x04
 #define ACL_PICO_BCAST		0x08
 
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index c662344..cc7ec41 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -784,6 +784,13 @@ static void l2cap_do_send(struct l2cap_chan *chan, struct sk_buff *skb)
 	BT_DBG("chan %p, skb %p len %d priority %u", chan, skb, skb->len,
 							skb->priority);
 
+	if (chan->hs_hchan) {
+		BT_DBG("Send over AMP hchan %p", chan->hs_hchan);
+
+		hci_send_acl(chan->hs_hchan, skb, ACL_COMPLETE);
+		return;
+	}
+
 	if (!test_bit(FLAG_FLUSHABLE, &chan->flags) &&
 					lmp_no_flush_capable(hcon->hdev))
 		flags = ACL_START_NO_FLUSH;
-- 
1.7.9.5

