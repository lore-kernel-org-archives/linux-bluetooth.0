Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Check minimum length of SMP packets
Date: Thu,  3 Oct 2013 01:23:08 -0700
Message-Id: <1380788588-7897-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When SMP packets are received, make sure they contain at least 1 byte
header for the opcode. If not, drop the packet and disconnect the link.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/smp.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index 6e049497..884b208 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -848,8 +848,7 @@ static int smp_cmd_master_ident(struct l2cap_conn *conn, struct sk_buff *skb)
 int smp_sig_channel(struct l2cap_conn *conn, struct sk_buff *skb)
 {
 	struct hci_conn *hcon = conn->hcon;
-	__u8 code = skb->data[0];
-	__u8 reason;
+	__u8 code, reason;
 	int err = 0;
 
 	if (hcon->type != LE_LINK) {
@@ -857,12 +856,18 @@ int smp_sig_channel(struct l2cap_conn *conn, struct sk_buff *skb)
 		return -ENOTSUPP;
 	}
 
+	if (skb->len < 1) {
+		kfree_skb(skb);
+		return -EILSEQ;
+	}
+
 	if (!test_bit(HCI_LE_ENABLED, &conn->hcon->hdev->dev_flags)) {
 		err = -ENOTSUPP;
 		reason = SMP_PAIRING_NOTSUPP;
 		goto done;
 	}
 
+	code = skb->data[0];
 	skb_pull(skb, sizeof(code));
 
 	/*
-- 
1.8.3.1

