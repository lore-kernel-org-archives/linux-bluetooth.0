Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Provide HCI command opcode information to driver
Date: Sun, 14 Sep 2014 23:06:28 +0200
Message-Id: <1410728788-5170-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The Bluetooth core already does processing of the HCI command header
and puts it together before sending it to the driver. It is not really
efficient for the driver to look at the HCI command header again in
case it has to make certain decisions about certain commands. To make
this easier, just provide the opcode as part of the SKB control buffer
information. The extra information about the opcode is optional and
only provided for HCI commands.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/bluetooth.h | 1 +
 net/bluetooth/hci_core.c          | 1 +
 2 files changed, 2 insertions(+)

diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
index 373000de610d..7e666d06b97f 100644
--- a/include/net/bluetooth/bluetooth.h
+++ b/include/net/bluetooth/bluetooth.h
@@ -284,6 +284,7 @@ struct hci_req_ctrl {
 struct bt_skb_cb {
 	__u8 pkt_type;
 	__u8 incoming;
+	__u16 opcode;
 	__u16 expect;
 	__u8 force_active;
 	struct l2cap_chan *chan;
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 067526d9680d..41948678f514 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -4547,6 +4547,7 @@ static struct sk_buff *hci_prepare_cmd(struct hci_dev *hdev, u16 opcode,
 	BT_DBG("skb len %d", skb->len);
 
 	bt_cb(skb)->pkt_type = HCI_COMMAND_PKT;
+	bt_cb(skb)->opcode = opcode;
 
 	return skb;
 }
-- 
1.9.3

