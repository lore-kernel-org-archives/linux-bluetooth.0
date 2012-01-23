Return-Path: <cyrus@holtmann.org>
From: Hemant Gupta <hemant.gupta@stericsson.com>
To: <linux-bluetooth@vger.kernel.org>
Cc: Hemant Gupta <hemantgupta.ste@gmail.com>,
	Hemant Gupta <hemant.gupta@stericsson.com>
Subject: [PATCH] Bluetooth: Fix clearing of debug and linkkey flags
Date: Mon, 23 Jan 2012 15:36:11 +0530
Message-ID: <1327313171-20544-1-git-send-email-hemant.gupta@stericsson.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch fixes clearing of HCI_LINK_KEYS and HCI_DEBUG_KEYS
dev_flags while resetting. Without this patch pairing does
not work over management interface for BR-EDR devices.

Signed-off-by: Hemant Gupta <hemant.gupta@stericsson.com>
---
 net/bluetooth/hci_event.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index b24c663..fcd6d10 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -196,7 +196,8 @@ static void hci_cc_reset(struct hci_dev *hdev, struct sk_buff *skb)
 	hci_req_complete(hdev, HCI_OP_RESET, status);
 
 	/* Reset all flags, except persistent ones */
-	hdev->dev_flags &= BIT(HCI_MGMT) | BIT(HCI_SETUP) | BIT(HCI_AUTO_OFF);
+	hdev->dev_flags &= BIT(HCI_MGMT) | BIT(HCI_SETUP) | BIT(HCI_AUTO_OFF) |
+				BIT(HCI_LINK_KEYS) | BIT(HCI_DEBUG_KEYS);
 }
 
 static void hci_cc_write_local_name(struct hci_dev *hdev, struct sk_buff *skb)
-- 
1.6.6.1

