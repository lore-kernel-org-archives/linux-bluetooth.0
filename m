Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 4/7] Bluetooth: Don't clear HCI_DISCOVERABLE when powering off
Date: Mon, 24 Feb 2014 14:52:19 +0200
Message-Id: <1393246342-27980-5-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1393246342-27980-1-git-send-email-johan.hedberg@gmail.com>
References: <1393246342-27980-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

Once mgmt_set_powered(off) is updated to clear the scan mode we should
not just blindly clear the HCI_DISCOVERABLE flag in mgmt_discoverable()
but first check if there is a pending set_powered operation.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/mgmt.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index bdc831b3bb97..769b5dc0270d 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -4790,6 +4790,10 @@ void mgmt_discoverable(struct hci_dev *hdev, u8 discoverable)
 	if (mgmt_pending_find(MGMT_OP_SET_DISCOVERABLE, hdev))
 		return;
 
+	/* Powering off may clear the scan mode - don't let that interfere */
+	if (!discoverable && mgmt_pending_find(MGMT_OP_SET_POWERED, hdev))
+		return;
+
 	if (discoverable) {
 		changed = !test_and_set_bit(HCI_DISCOVERABLE, &hdev->dev_flags);
 	} else {
-- 
1.8.5.3

