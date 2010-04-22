Return-Path: <cyrus@holtmann.org>
Sender: "Gustavo F. Padovan" <gfpadovan@gmail.com>
From: "Gustavo F. Padovan" <gustavo@padovan.org>
To: linux-bluetooth@vger.kernel.org
Cc: gustavo@padovan.org,
	marcel@holtmann.org,
	"Gustavo F. Padovan" <padovan@profusion.mobi>
Subject: [PATCH 1/3] Bluetooth: Fix return value when bt_skb_alloc fails
Date: Thu, 22 Apr 2010 03:51:37 -0300
Message-Id: <1271919099-22107-1-git-send-email-gustavo@padovan.org>
List-ID: <linux-bluetooth.vger.kernel.org>

From: Gustavo F. Padovan <padovan@profusion.mobi>

Set the proper error(ENOMEM), instead of just return 0.

Signed-off-by: Gustavo F. Padovan <padovan@profusion.mobi>
---
 drivers/bluetooth/hci_h4.c |    2 +-
 drivers/bluetooth/hci_ll.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/hci_h4.c b/drivers/bluetooth/hci_h4.c
index c0ce813..3f038f5 100644
--- a/drivers/bluetooth/hci_h4.c
+++ b/drivers/bluetooth/hci_h4.c
@@ -246,7 +246,7 @@ static int h4_recv(struct hci_uart *hu, void *data, int count)
 			BT_ERR("Can't allocate mem for new packet");
 			h4->rx_state = H4_W4_PACKET_TYPE;
 			h4->rx_count = 0;
-			return 0;
+			return -ENOMEM;
 		}
 
 		h4->rx_skb->dev = (void *) hu->hdev;
diff --git a/drivers/bluetooth/hci_ll.c b/drivers/bluetooth/hci_ll.c
index 5c65014..91e44df 100644
--- a/drivers/bluetooth/hci_ll.c
+++ b/drivers/bluetooth/hci_ll.c
@@ -491,7 +491,7 @@ static int ll_recv(struct hci_uart *hu, void *data, int count)
 			BT_ERR("Can't allocate mem for new packet");
 			ll->rx_state = HCILL_W4_PACKET_TYPE;
 			ll->rx_count = 0;
-			return 0;
+			return -ENOMEM;
 		}
 
 		ll->rx_skb->dev = (void *) hu->hdev;
-- 
1.7.0.4
