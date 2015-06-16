Return-Path: <cyrus@holtmann.org>
From: Chan-yeol Park <chanyeol.park@samsung.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/2] Bluetooth: hci_uart: Fix dereferencing of ERR_PTR
Date: Tue, 16 Jun 2015 21:55:21 +0900
Message-id: <1434459321-20281-2-git-send-email-chanyeol.park@samsung.com>
In-reply-to: <1434459321-20281-1-git-send-email-chanyeol.park@samsung.com>
References: <1434459321-20281-1-git-send-email-chanyeol.park@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

If h4_recv() return ERR_PTR instead sk_buff pointer, it should be
cleared once dereference is completed for the further reference such as
h4_recv(), or h4_close().

Signed-off-by: Chan-yeol Park <chanyeol.park@samsung.com>
---
 drivers/bluetooth/hci_h4.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/bluetooth/hci_h4.c b/drivers/bluetooth/hci_h4.c
index f7190f0..a8acd99 100644
--- a/drivers/bluetooth/hci_h4.c
+++ b/drivers/bluetooth/hci_h4.c
@@ -133,6 +133,7 @@ static int h4_recv(struct hci_uart *hu, const void *data, int count)
 	if (IS_ERR(h4->rx_skb)) {
 		int err = PTR_ERR(h4->rx_skb);
 		BT_ERR("%s: Frame reassembly failed (%d)", hu->hdev->name, err);
+		h4->rx_skb = NULL;
 		return err;
 	}
 
@@ -248,6 +249,7 @@ struct sk_buff *h4_recv_buf(struct hci_dev *hdev, struct sk_buff *skb,
 				break;
 			default:
 				/* Unsupported variable length */
+
 				kfree_skb(skb);
 				return ERR_PTR(-EILSEQ);
 			}
-- 
2.1.4

