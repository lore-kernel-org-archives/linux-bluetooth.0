Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 9/9] Bluetooth: Fix clearing of persistent dev_flags
Date: Tue, 21 Feb 2012 18:00:05 +0200
Message-Id: <1329840005-4977-9-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1329840005-4977-1-git-send-email-johan.hedberg@gmail.com>
References: <1329840005-4977-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

Now that most flags are persistent, only the LE_SCAN flag should be
cleared after a reset.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/hci_event.c |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 5d0f92a..2a5d05c 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -192,9 +192,8 @@ static void hci_cc_reset(struct hci_dev *hdev, struct sk_buff *skb)
 
 	hci_req_complete(hdev, HCI_OP_RESET, status);
 
-	/* Reset all flags, except persistent ones */
-	hdev->dev_flags &= BIT(HCI_MGMT) | BIT(HCI_SETUP) | BIT(HCI_AUTO_OFF) |
-				BIT(HCI_LINK_KEYS) | BIT(HCI_DEBUG_KEYS);
+	/* Reset all non-persistent flags */
+	hdev->dev_flags &= ~(BIT(HCI_LE_SCAN));
 }
 
 static void hci_cc_write_local_name(struct hci_dev *hdev, struct sk_buff *skb)
-- 
1.7.9

