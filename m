Return-Path: <SRS0=gSSv=42=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4600C10F27
	for <linux-bluetooth@archiver.kernel.org>; Mon,  9 Mar 2020 21:45:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC56C24649
	for <linux-bluetooth@archiver.kernel.org>; Mon,  9 Mar 2020 21:45:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727268AbgCIVpD (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 9 Mar 2020 17:45:03 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:56624 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727255AbgCIVpC (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 9 Mar 2020 17:45:02 -0400
Received: from localhost.localdomain (p4FEFC5A7.dip0.t-ipconnect.de [79.239.197.167])
        by mail.holtmann.org (Postfix) with ESMTPSA id D3051CECC4
        for <linux-bluetooth@vger.kernel.org>; Mon,  9 Mar 2020 22:54:28 +0100 (CET)
From:   Marcel Holtmann <marcel@holtmann.org>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: bfusb: Switch from BT_ERR to bt_dev_err where possible
Date:   Mon,  9 Mar 2020 22:44:56 +0100
Message-Id: <20200309214456.431153-1-marcel@holtmann.org>
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
 drivers/bluetooth/bfusb.c | 33 ++++++++++++++++-----------------
 1 file changed, 16 insertions(+), 17 deletions(-)

diff --git a/drivers/bluetooth/bfusb.c b/drivers/bluetooth/bfusb.c
index 0e5954cac98e..5a321b4076aa 100644
--- a/drivers/bluetooth/bfusb.c
+++ b/drivers/bluetooth/bfusb.c
@@ -133,8 +133,8 @@ static int bfusb_send_bulk(struct bfusb_data *data, struct sk_buff *skb)
 
 	err = usb_submit_urb(urb, GFP_ATOMIC);
 	if (err) {
-		BT_ERR("%s bulk tx submit failed urb %p err %d", 
-					data->hdev->name, urb, err);
+		bt_dev_err(data->hdev, "bulk tx submit failed urb %p err %d",
+			   urb, err);
 		skb_unlink(skb, &data->pending_q);
 		usb_free_urb(urb);
 	} else
@@ -232,8 +232,8 @@ static int bfusb_rx_submit(struct bfusb_data *data, struct urb *urb)
 
 	err = usb_submit_urb(urb, GFP_ATOMIC);
 	if (err) {
-		BT_ERR("%s bulk rx submit failed urb %p err %d",
-					data->hdev->name, urb, err);
+		bt_dev_err(data->hdev, "bulk rx submit failed urb %p err %d",
+			   urb, err);
 		skb_unlink(skb, &data->pending_q);
 		kfree_skb(skb);
 		usb_free_urb(urb);
@@ -247,7 +247,7 @@ static inline int bfusb_recv_block(struct bfusb_data *data, int hdr, unsigned ch
 	BT_DBG("bfusb %p hdr 0x%02x data %p len %d", data, hdr, buf, len);
 
 	if (hdr & 0x10) {
-		BT_ERR("%s error in block", data->hdev->name);
+		bt_dev_err(data->hdev, "error in block");
 		kfree_skb(data->reassembly);
 		data->reassembly = NULL;
 		return -EIO;
@@ -259,13 +259,13 @@ static inline int bfusb_recv_block(struct bfusb_data *data, int hdr, unsigned ch
 		int pkt_len = 0;
 
 		if (data->reassembly) {
-			BT_ERR("%s unexpected start block", data->hdev->name);
+			bt_dev_err(data->hdev, "unexpected start block");
 			kfree_skb(data->reassembly);
 			data->reassembly = NULL;
 		}
 
 		if (len < 1) {
-			BT_ERR("%s no packet type found", data->hdev->name);
+			bt_dev_err(data->hdev, "no packet type found");
 			return -EPROTO;
 		}
 
@@ -277,7 +277,7 @@ static inline int bfusb_recv_block(struct bfusb_data *data, int hdr, unsigned ch
 				struct hci_event_hdr *hdr = (struct hci_event_hdr *) buf;
 				pkt_len = HCI_EVENT_HDR_SIZE + hdr->plen;
 			} else {
-				BT_ERR("%s event block is too short", data->hdev->name);
+				bt_dev_err(data->hdev, "event block is too short");
 				return -EILSEQ;
 			}
 			break;
@@ -287,7 +287,7 @@ static inline int bfusb_recv_block(struct bfusb_data *data, int hdr, unsigned ch
 				struct hci_acl_hdr *hdr = (struct hci_acl_hdr *) buf;
 				pkt_len = HCI_ACL_HDR_SIZE + __le16_to_cpu(hdr->dlen);
 			} else {
-				BT_ERR("%s data block is too short", data->hdev->name);
+				bt_dev_err(data->hdev, "data block is too short");
 				return -EILSEQ;
 			}
 			break;
@@ -297,7 +297,7 @@ static inline int bfusb_recv_block(struct bfusb_data *data, int hdr, unsigned ch
 				struct hci_sco_hdr *hdr = (struct hci_sco_hdr *) buf;
 				pkt_len = HCI_SCO_HDR_SIZE + hdr->dlen;
 			} else {
-				BT_ERR("%s audio block is too short", data->hdev->name);
+				bt_dev_err(data->hdev, "audio block is too short");
 				return -EILSEQ;
 			}
 			break;
@@ -305,7 +305,7 @@ static inline int bfusb_recv_block(struct bfusb_data *data, int hdr, unsigned ch
 
 		skb = bt_skb_alloc(pkt_len, GFP_ATOMIC);
 		if (!skb) {
-			BT_ERR("%s no memory for the packet", data->hdev->name);
+			bt_dev_err(data->hdev, "no memory for the packet");
 			return -ENOMEM;
 		}
 
@@ -314,7 +314,7 @@ static inline int bfusb_recv_block(struct bfusb_data *data, int hdr, unsigned ch
 		data->reassembly = skb;
 	} else {
 		if (!data->reassembly) {
-			BT_ERR("%s unexpected continuation block", data->hdev->name);
+			bt_dev_err(data->hdev, "unexpected continuation block");
 			return -EIO;
 		}
 	}
@@ -366,8 +366,7 @@ static void bfusb_rx_complete(struct urb *urb)
 		}
 
 		if (count < len) {
-			BT_ERR("%s block extends over URB buffer ranges",
-					data->hdev->name);
+			bt_dev_err(data->hdev, "block extends over URB buffer ranges");
 		}
 
 		if ((hdr & 0xe1) == 0xc1)
@@ -391,8 +390,8 @@ static void bfusb_rx_complete(struct urb *urb)
 
 	err = usb_submit_urb(urb, GFP_ATOMIC);
 	if (err) {
-		BT_ERR("%s bulk resubmit failed urb %p err %d",
-					data->hdev->name, urb, err);
+		bt_dev_err(data->hdev, "bulk resubmit failed urb %p err %d",
+			   urb, err);
 	}
 
 unlock:
@@ -477,7 +476,7 @@ static int bfusb_send_frame(struct hci_dev *hdev, struct sk_buff *skb)
 	/* Max HCI frame size seems to be 1511 + 1 */
 	nskb = bt_skb_alloc(count + 32, GFP_KERNEL);
 	if (!nskb) {
-		BT_ERR("Can't allocate memory for new packet");
+		bt_dev_err(hdev, "Can't allocate memory for new packet");
 		return -ENOMEM;
 	}
 
-- 
2.24.1

