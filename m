Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/7] Bluetooth: LE scan should send MGMT Discovering events
Date: Wed, 14 Dec 2011 13:25:22 -0300
Message-Id: <1323879926-15971-4-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1323879926-15971-1-git-send-email-andre.guedes@openbossa.org>
References: <1323879926-15971-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Send MGMT Discovering events once LE scan starts/stops so the
userspace can track when local adapters are discovering LE devices.

This way, we also keep the same behavior of inquiry which sends MGMT
Discovering events once inquiry starts/stops even if it is triggered
by an external tool (e.g. hcitool).

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
---
 net/bluetooth/hci_event.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 3d45b05..1f74b54 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -1020,12 +1020,20 @@ static void hci_cc_le_set_scan_enable(struct hci_dev *hdev,
 		del_timer(&hdev->adv_timer);
 
 		hci_dev_lock(hdev);
+
 		hci_adv_entries_clear(hdev);
+
+		mgmt_discovering(hdev, 1);
+
 		hci_dev_unlock(hdev);
 	} else if (cp->enable == 0x00) {
 		clear_bit(HCI_LE_SCAN, &hdev->dev_flags);
 
 		mod_timer(&hdev->adv_timer, jiffies + ADV_CLEAR_TIMEOUT);
+
+		hci_dev_lock(hdev);
+		mgmt_discovering(hdev, 0);
+		hci_dev_unlock(hdev);
 	}
 }
 
-- 
1.7.8

