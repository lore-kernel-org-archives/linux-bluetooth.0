Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/3] Bluetooth: Fix clearing of HCI_PENDING_CLASS flag
Date: Thu,  1 Mar 2012 17:14:58 -0800
Message-Id: <1330650900-11420-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

When doing reset HCI_PENDING_CLASS is one of the flags that should be
cleared (since it's used for a pending HCI command and a reset clear all
pending commands).

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/hci_event.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index aee9556..d6c41bb 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -193,7 +193,7 @@ static void hci_cc_reset(struct hci_dev *hdev, struct sk_buff *skb)
 	hci_req_complete(hdev, HCI_OP_RESET, status);
 
 	/* Reset all non-persistent flags */
-	hdev->dev_flags &= ~(BIT(HCI_LE_SCAN));
+	hdev->dev_flags &= ~(BIT(HCI_LE_SCAN) | BIT(HCI_PENDING_CLASS));
 
 	hdev->discovery.state = DISCOVERY_STOPPED;
 }
-- 
1.7.9.1

