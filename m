Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: SMP packets are only valid on LE connections
Date: Thu,  3 Oct 2013 00:00:57 -0700
Message-Id: <1380783657-45553-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When receiving SMP packets on a BR/EDR connection, then just drop
the packet and do not try to process it.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/smp.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index b5562ab..6e049497 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -847,10 +847,16 @@ static int smp_cmd_master_ident(struct l2cap_conn *conn, struct sk_buff *skb)
 
 int smp_sig_channel(struct l2cap_conn *conn, struct sk_buff *skb)
 {
+	struct hci_conn *hcon = conn->hcon;
 	__u8 code = skb->data[0];
 	__u8 reason;
 	int err = 0;
 
+	if (hcon->type != LE_LINK) {
+		kfree_skb(skb);
+		return -ENOTSUPP;
+	}
+
 	if (!test_bit(HCI_LE_ENABLED, &conn->hcon->hdev->dev_flags)) {
 		err = -ENOTSUPP;
 		reason = SMP_PAIRING_NOTSUPP;
-- 
1.8.3.1

