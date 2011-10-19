Return-Path: <cyrus@holtmann.org>
From: Mat Martineau <mathewm@codeaurora.org>
To: linux-bluetooth@vger.kernel.org
Cc: padovan@profusion.mobi, pkrystad@codeaurora.org,
	andrei.emeltchenko@intel.com,
	Mat Martineau <mathewm@codeaurora.org>
Subject: [PATCHv2 9/9] Bluetooth: Guarantee BR-EDR device will be registered as hci0
Date: Wed, 19 Oct 2011 10:44:07 -0700
Message-Id: <1319046247-3391-10-git-send-email-mathewm@codeaurora.org>
In-Reply-To: <1319046247-3391-1-git-send-email-mathewm@codeaurora.org>
References: <1319046247-3391-1-git-send-email-mathewm@codeaurora.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

It's convenient to use the HCI device index the AMP controller id, but
the spec requires that an AMP controller never has id 0.

Signed-off-by: Mat Martineau <mathewm@codeaurora.org>
---
 net/bluetooth/hci_core.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index fdcbf8f..78e6b05 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1426,7 +1426,7 @@ int hci_add_adv_entry(struct hci_dev *hdev,
 int hci_register_dev(struct hci_dev *hdev)
 {
 	struct list_head *head = &hci_dev_list, *p;
-	int i, id = 0, error;
+	int i, id, error;
 
 	BT_DBG("%p name %s bus %d owner %p", hdev, hdev->name,
 						hdev->bus, hdev->owner);
@@ -1434,6 +1434,8 @@ int hci_register_dev(struct hci_dev *hdev)
 	if (!hdev->open || !hdev->close || !hdev->destruct)
 		return -EINVAL;
 
+	id = (hdev->dev_type == HCI_BREDR) ? 0 : 1;
+
 	write_lock_bh(&hci_dev_list_lock);
 
 	/* Find first available device id */
-- 
1.7.7

--
Mat Martineau
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum

