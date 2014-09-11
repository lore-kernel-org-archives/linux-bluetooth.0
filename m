Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Expire RPA if encryption fails
Date: Wed, 10 Sep 2014 22:16:35 -0700
Message-Id: <1410412595-12157-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

If encryption fails and we're using an RPA it may be because of a
conflict with another device. To avoid repeated failures the safest
action is to simply mark the RPA as expired so that a new one gets
generated as soon as the connection drops.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/hci_event.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 603a17cc52ac..edf05fda017e 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -2438,6 +2438,12 @@ static void hci_encrypt_change_evt(struct hci_dev *hdev, struct sk_buff *skb)
 		}
 	}
 
+	/* We should  disregard the current RPA and generate a new one
+	 * whenever the encryption procedure fails.
+	 */
+	if (ev->status && conn->type == LE_LINK)
+		set_bit(HCI_RPA_EXPIRED, &hdev->dev_flags);
+
 	clear_bit(HCI_CONN_ENCRYPT_PEND, &conn->flags);
 
 	if (ev->status && conn->state == BT_CONNECTED) {
-- 
1.9.3

