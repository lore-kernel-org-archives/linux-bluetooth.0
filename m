Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/3] Bluetooth: Fix notifying discovery state when powering off
Date: Wed, 28 Jan 2015 15:13:18 +0200
Message-Id: <1422450799-18548-2-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1422450799-18548-1-git-send-email-johan.hedberg@gmail.com>
References: <1422450799-18548-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

The discovery state should be set to stopped when the HCI device is
powered off. This patch adds the appropriate call to the
hci_discovery_set_state() function from hci_dev_do_close() which is
responsible for the power-off procedure.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/hci_core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index bb831d678868..46aa702c189d 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1628,6 +1628,8 @@ static int hci_dev_do_close(struct hci_dev *hdev)
 
 	hci_dev_lock(hdev);
 
+	hci_discovery_set_state(hdev, DISCOVERY_STOPPED);
+
 	if (!test_and_clear_bit(HCI_AUTO_OFF, &hdev->dev_flags)) {
 		if (hdev->dev_type == HCI_BREDR)
 			mgmt_powered(hdev, 0);
-- 
2.1.0

