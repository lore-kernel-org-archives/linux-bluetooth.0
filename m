Return-Path: <SRS0=gSSv=42=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 091C7C10F25
	for <linux-bluetooth@archiver.kernel.org>; Mon,  9 Mar 2020 21:57:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5A8624670
	for <linux-bluetooth@archiver.kernel.org>; Mon,  9 Mar 2020 21:57:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726536AbgCIV53 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 9 Mar 2020 17:57:29 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:52958 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726439AbgCIV53 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 9 Mar 2020 17:57:29 -0400
Received: from localhost.localdomain (p4FEFC5A7.dip0.t-ipconnect.de [79.239.197.167])
        by mail.holtmann.org (Postfix) with ESMTPSA id 1C8E0CECC4
        for <linux-bluetooth@vger.kernel.org>; Mon,  9 Mar 2020 23:06:56 +0100 (CET)
From:   Marcel Holtmann <marcel@holtmann.org>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: hci_h5: Switch from BT_ERR to bt_dev_err where possible
Date:   Mon,  9 Mar 2020 22:57:23 +0100
Message-Id: <20200309215723.442701-1-marcel@holtmann.org>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

All HCI device specific error messages shall use bt_dev_err to indicate
the device name in the message.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 drivers/bluetooth/hci_h5.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/bluetooth/hci_h5.c b/drivers/bluetooth/hci_h5.c
index 812a5e975ec1..106c110efe56 100644
--- a/drivers/bluetooth/hci_h5.c
+++ b/drivers/bluetooth/hci_h5.c
@@ -178,7 +178,7 @@ static void h5_peer_reset(struct hci_uart *hu)
 {
 	struct h5 *h5 = hu->priv;
 
-	BT_ERR("Peer device has reset");
+	bt_dev_err(hu->hdev, "Peer device has reset");
 
 	h5->state = H5_UNINITIALIZED;
 
@@ -438,21 +438,21 @@ static int h5_rx_3wire_hdr(struct hci_uart *hu, unsigned char c)
 	       H5_HDR_LEN(hdr));
 
 	if (((hdr[0] + hdr[1] + hdr[2] + hdr[3]) & 0xff) != 0xff) {
-		BT_ERR("Invalid header checksum");
+		bt_dev_err(hu->hdev, "Invalid header checksum");
 		h5_reset_rx(h5);
 		return 0;
 	}
 
 	if (H5_HDR_RELIABLE(hdr) && H5_HDR_SEQ(hdr) != h5->tx_ack) {
-		BT_ERR("Out-of-order packet arrived (%u != %u)",
-		       H5_HDR_SEQ(hdr), h5->tx_ack);
+		bt_dev_err(hu->hdev, "Out-of-order packet arrived (%u != %u)",
+			   H5_HDR_SEQ(hdr), h5->tx_ack);
 		h5_reset_rx(h5);
 		return 0;
 	}
 
 	if (h5->state != H5_ACTIVE &&
 	    H5_HDR_PKT_TYPE(hdr) != HCI_3WIRE_LINK_PKT) {
-		BT_ERR("Non-link packet received in non-active state");
+		bt_dev_err(hu->hdev, "Non-link packet received in non-active state");
 		h5_reset_rx(h5);
 		return 0;
 	}
@@ -475,7 +475,7 @@ static int h5_rx_pkt_start(struct hci_uart *hu, unsigned char c)
 
 	h5->rx_skb = bt_skb_alloc(H5_MAX_LEN, GFP_ATOMIC);
 	if (!h5->rx_skb) {
-		BT_ERR("Can't allocate mem for new packet");
+		bt_dev_err(hu->hdev, "Can't allocate mem for new packet");
 		h5_reset_rx(h5);
 		return -ENOMEM;
 	}
@@ -551,7 +551,7 @@ static int h5_recv(struct hci_uart *hu, const void *data, int count)
 
 		if (h5->rx_pending > 0) {
 			if (*ptr == SLIP_DELIMITER) {
-				BT_ERR("Too short H5 packet");
+				bt_dev_err(hu->hdev, "Too short H5 packet");
 				h5_reset_rx(h5);
 				continue;
 			}
@@ -578,13 +578,13 @@ static int h5_enqueue(struct hci_uart *hu, struct sk_buff *skb)
 	struct h5 *h5 = hu->priv;
 
 	if (skb->len > 0xfff) {
-		BT_ERR("Packet too long (%u bytes)", skb->len);
+		bt_dev_err(hu->hdev, "Packet too long (%u bytes)", skb->len);
 		kfree_skb(skb);
 		return 0;
 	}
 
 	if (h5->state != H5_ACTIVE) {
-		BT_ERR("Ignoring HCI data in non-active state");
+		bt_dev_err(hu->hdev, "Ignoring HCI data in non-active state");
 		kfree_skb(skb);
 		return 0;
 	}
@@ -601,7 +601,7 @@ static int h5_enqueue(struct hci_uart *hu, struct sk_buff *skb)
 		break;
 
 	default:
-		BT_ERR("Unknown packet type %u", hci_skb_pkt_type(skb));
+		bt_dev_err(hu->hdev, "Unknown packet type %u", hci_skb_pkt_type(skb));
 		kfree_skb(skb);
 		break;
 	}
@@ -657,7 +657,7 @@ static struct sk_buff *h5_prepare_pkt(struct hci_uart *hu, u8 pkt_type,
 	int i;
 
 	if (!valid_packet_type(pkt_type)) {
-		BT_ERR("Unknown packet type %u", pkt_type);
+		bt_dev_err(hu->hdev, "Unknown packet type %u", pkt_type);
 		return NULL;
 	}
 
@@ -734,7 +734,7 @@ static struct sk_buff *h5_dequeue(struct hci_uart *hu)
 		}
 
 		skb_queue_head(&h5->unrel, skb);
-		BT_ERR("Could not dequeue pkt because alloc_skb failed");
+		bt_dev_err(hu->hdev, "Could not dequeue pkt because alloc_skb failed");
 	}
 
 	spin_lock_irqsave_nested(&h5->unack.lock, flags, SINGLE_DEPTH_NESTING);
@@ -754,7 +754,7 @@ static struct sk_buff *h5_dequeue(struct hci_uart *hu)
 		}
 
 		skb_queue_head(&h5->rel, skb);
-		BT_ERR("Could not dequeue pkt because alloc_skb failed");
+		bt_dev_err(hu->hdev, "Could not dequeue pkt because alloc_skb failed");
 	}
 
 unlock:
-- 
2.24.1

