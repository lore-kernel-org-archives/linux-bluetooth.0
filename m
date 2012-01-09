Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/4] Bluetooth: Fix resetting HCI_MGMT flag
Date: Mon,  9 Jan 2012 13:46:04 +0200
Message-Id: <1326109565-32631-3-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1326109565-32631-1-git-send-email-johan.hedberg@gmail.com>
References: <1326109565-32631-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

The HCI_MGMT flag should not be cleared when resetting a HCI device.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/hci_event.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 4693bbc..94a9ca2 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -195,7 +195,8 @@ static void hci_cc_reset(struct hci_dev *hdev, struct sk_buff *skb)
 
 	hci_req_complete(hdev, HCI_OP_RESET, status);
 
-	hdev->dev_flags = 0;
+	/* Reset all flags, except persistent ones like HCI_MGMT */
+	hdev->dev_flags &= BIT(HCI_MGMT);
 }
 
 static void hci_cc_write_local_name(struct hci_dev *hdev, struct sk_buff *skb)
-- 
1.7.8.2

