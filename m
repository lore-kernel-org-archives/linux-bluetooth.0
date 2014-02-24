Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 6/7] Bluetooth: Don't clear HCI_ADVERTISING when powering off
Date: Mon, 24 Feb 2014 14:52:21 +0200
Message-Id: <1393246342-27980-7-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1393246342-27980-1-git-send-email-johan.hedberg@gmail.com>
References: <1393246342-27980-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

Once mgmt_set_powered(off) is updated to clear the scan mode we should
not just blindly clear the HCI_ADVERTISING flag in mgmt_advertising()
but first check if there is a pending set_powered operation.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/mgmt.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 5899ac7264ff..610ac32e797b 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -4842,6 +4842,10 @@ void mgmt_connectable(struct hci_dev *hdev, u8 connectable)
 
 void mgmt_advertising(struct hci_dev *hdev, u8 advertising)
 {
+	/* Powering off may stop advertising - don't let that interfere */
+	if (!advertising && mgmt_pending_find(MGMT_OP_SET_POWERED, hdev))
+		return;
+
 	if (advertising)
 		set_bit(HCI_ADVERTISING, &hdev->dev_flags);
 	else
-- 
1.8.5.3

