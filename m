Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/7] Bluetooth: Send control open and close only when cookie is present
Date: Tue, 30 Aug 2016 05:00:36 +0200
Message-Id: <1472526040-21804-3-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Only when the cookie has been assigned, then send the open and close
monitor messages. Also if the socket is bound to a device, then include
the index into the message.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/hci_sock.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/hci_sock.c b/net/bluetooth/hci_sock.c
index fc3ccfe2a5c9..6137cda1c87c 100644
--- a/net/bluetooth/hci_sock.c
+++ b/net/bluetooth/hci_sock.c
@@ -483,6 +483,10 @@ static struct sk_buff *create_monitor_ctrl_open(struct sock *sk)
 	u8 ver[3];
 	u32 flags;
 
+	/* No message needed when cookie is not present */
+	if (!hci_pi(sk)->cookie)
+		return NULL;
+
 	skb = bt_skb_alloc(14 + TASK_COMM_LEN , GFP_ATOMIC);
 	if (!skb)
 		return NULL;
@@ -501,7 +505,10 @@ static struct sk_buff *create_monitor_ctrl_open(struct sock *sk)
 
 	hdr = (void *)skb_push(skb, HCI_MON_HDR_SIZE);
 	hdr->opcode = cpu_to_le16(HCI_MON_CTRL_OPEN);
-	hdr->index = cpu_to_le16(HCI_DEV_NONE);
+	if (hci_pi(sk)->hdev)
+		hdr->index = cpu_to_le16(hci_pi(sk)->hdev->id);
+	else
+		hdr->index = cpu_to_le16(HCI_DEV_NONE);
 	hdr->len = cpu_to_le16(skb->len - HCI_MON_HDR_SIZE);
 
 	return skb;
@@ -512,6 +519,10 @@ static struct sk_buff *create_monitor_ctrl_close(struct sock *sk)
 	struct hci_mon_hdr *hdr;
 	struct sk_buff *skb;
 
+	/* No message needed when cookie is not present */
+	if (!hci_pi(sk)->cookie)
+		return NULL;
+
 	skb = bt_skb_alloc(4, GFP_ATOMIC);
 	if (!skb)
 		return NULL;
@@ -522,7 +533,10 @@ static struct sk_buff *create_monitor_ctrl_close(struct sock *sk)
 
 	hdr = (void *)skb_push(skb, HCI_MON_HDR_SIZE);
 	hdr->opcode = cpu_to_le16(HCI_MON_CTRL_CLOSE);
-	hdr->index = cpu_to_le16(HCI_DEV_NONE);
+	if (hci_pi(sk)->hdev)
+		hdr->index = cpu_to_le16(hci_pi(sk)->hdev->id);
+	else
+		hdr->index = cpu_to_le16(HCI_DEV_NONE);
 	hdr->len = cpu_to_le16(skb->len - HCI_MON_HDR_SIZE);
 
 	return skb;
-- 
2.7.4

