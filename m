Return-Path: <cyrus@holtmann.org>
Sender: "Gustavo F. Padovan" <gfpadovan@gmail.com>
From: "Gustavo F. Padovan" <gustavo@padovan.org>
To: linux-bluetooth@vger.kernel.org
Cc: gustavo@padovan.org,
	marcel@holtmann.org,
	"Gustavo F. Padovan" <padovan@profusion.mobi>
Subject: [PATCH 2/3] Bluetooth: Use the proper function cast to get hdr data
Date: Thu, 22 Apr 2010 03:51:38 -0300
Message-Id: <1271919099-22107-2-git-send-email-gustavo@padovan.org>
In-Reply-To: <1271919099-22107-1-git-send-email-gustavo@padovan.org>
References: <1271919099-22107-1-git-send-email-gustavo@padovan.org>
List-ID: <linux-bluetooth.vger.kernel.org>

From: Gustavo F. Padovan <padovan@profusion.mobi>

Signed-off-by: Gustavo F. Padovan <padovan@profusion.mobi>
---
 drivers/bluetooth/hci_ll.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/bluetooth/hci_ll.c b/drivers/bluetooth/hci_ll.c
index 91e44df..fb8445c 100644
--- a/drivers/bluetooth/hci_ll.c
+++ b/drivers/bluetooth/hci_ll.c
@@ -402,7 +402,7 @@ static int ll_recv(struct hci_uart *hu, void *data, int count)
 				continue;
 
 			case HCILL_W4_EVENT_HDR:
-				eh = (struct hci_event_hdr *) ll->rx_skb->data;
+				eh = hci_event_hdr(ll->rx_skb);
 
 				BT_DBG("Event header: evt 0x%2.2x plen %d", eh->evt, eh->plen);
 
@@ -410,7 +410,7 @@ static int ll_recv(struct hci_uart *hu, void *data, int count)
 				continue;
 
 			case HCILL_W4_ACL_HDR:
-				ah = (struct hci_acl_hdr *) ll->rx_skb->data;
+				ah = hci_acl_hdr(ll->rx_skb);
 				dlen = __le16_to_cpu(ah->dlen);
 
 				BT_DBG("ACL header: dlen %d", dlen);
@@ -419,7 +419,7 @@ static int ll_recv(struct hci_uart *hu, void *data, int count)
 				continue;
 
 			case HCILL_W4_SCO_HDR:
-				sh = (struct hci_sco_hdr *) ll->rx_skb->data;
+				sh = hci_sco_hdr(ll->rx_skb);
 
 				BT_DBG("SCO header: dlen %d", sh->dlen);
 
-- 
1.7.0.4
