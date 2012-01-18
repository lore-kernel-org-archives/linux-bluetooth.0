Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 01/15] Bluetooth: Fix clearing persistent flags
Date: Wed, 18 Jan 2012 20:51:43 +0200
Message-Id: <1326912717-6347-2-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1326912717-6347-1-git-send-email-johan.hedberg@gmail.com>
References: <1326912717-6347-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

There are several other dev_flags besided HCI_MGMT that should not be
cleared upon reset.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/hci_event.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index c2fe964..4eef43c 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -195,8 +195,8 @@ static void hci_cc_reset(struct hci_dev *hdev, struct sk_buff *skb)
 
 	hci_req_complete(hdev, HCI_OP_RESET, status);
 
-	/* Reset all flags, except persistent ones like HCI_MGMT */
-	hdev->dev_flags &= BIT(HCI_MGMT);
+	/* Reset all flags, except persistent ones */
+	hdev->dev_flags &= BIT(HCI_MGMT) | BIT(HCI_SETUP) | BIT(HCI_AUTO_OFF);
 }
 
 static void hci_cc_write_local_name(struct hci_dev *hdev, struct sk_buff *skb)
-- 
1.7.8.3

