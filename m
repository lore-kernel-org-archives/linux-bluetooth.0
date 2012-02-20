Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/8] Bluetooth: Remove unneeded bt_cb(skb)->channel variable
Date: Mon, 20 Feb 2012 11:58:35 +0100
Message-Id: <1329735520-23539-3-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The bt_cb(skb)->channel was only needed to make hci_send_to_sock() be
used for HCI raw and control sockets. Since they have now separate sending
functions this is no longer needed.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/bluetooth.h |    1 -
 net/bluetooth/mgmt.c              |    2 --
 2 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
index 5ca9219..262ebd1 100644
--- a/include/net/bluetooth/bluetooth.h
+++ b/include/net/bluetooth/bluetooth.h
@@ -222,7 +222,6 @@ struct bt_skb_cb {
 	__u16 tx_seq;
 	__u8 retries;
 	__u8 sar;
-	unsigned short channel;
 	__u8 force_active;
 };
 #define bt_cb(skb) ((struct bt_skb_cb *)((skb)->cb))
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 1695d04..bc71b45 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -911,8 +911,6 @@ static int mgmt_event(u16 event, struct hci_dev *hdev, void *data,
 	if (!skb)
 		return -ENOMEM;
 
-	bt_cb(skb)->channel = HCI_CHANNEL_CONTROL;
-
 	hdr = (void *) skb_put(skb, sizeof(*hdr));
 	hdr->opcode = cpu_to_le16(event);
 	if (hdev)
-- 
1.7.7.6

