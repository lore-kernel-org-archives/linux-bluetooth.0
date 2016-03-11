Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/2] Bluetooth: Fix setting correct flags in AD
Date: Fri, 11 Mar 2016 09:56:32 +0200
Message-Id: <1457682993-18470-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

A recent change added MGMT_ADV_FLAG_DISCOV to the flags returned by
get_adv_instance_flags(), however failed to take into account limited
discoverable mode. This patch fixes the issue by setting the correct
discoverability flag in the AD data.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/hci_request.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
index 95a545ca9dbc..6e125d76df0d 100644
--- a/net/bluetooth/hci_request.c
+++ b/net/bluetooth/hci_request.c
@@ -872,7 +872,9 @@ static u32 get_adv_instance_flags(struct hci_dev *hdev, u8 instance)
 		if (hci_dev_test_flag(hdev, HCI_ADVERTISING_CONNECTABLE))
 			flags |= MGMT_ADV_FLAG_CONNECTABLE;
 
-		if (hci_dev_test_flag(hdev, HCI_DISCOVERABLE))
+		if (hci_dev_test_flag(hdev, HCI_LIMITED_DISCOVERABLE))
+			flags |= MGMT_ADV_FLAG_LIMITED_DISCOV;
+		else if (hci_dev_test_flag(hdev, HCI_DISCOVERABLE))
 			flags |= MGMT_ADV_FLAG_DISCOV;
 
 		return flags;
-- 
2.5.0

